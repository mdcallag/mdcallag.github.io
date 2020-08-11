# Explaining explain

I learned a few things while trying to understand which predicates from a query will be index access predicates with MySQL. My focus with MySQL in the past and MongoDB today is such that I don't write or explain MQL or SQL queries on a daily basis and there is much for me to learn. What I learned today with MySQL is to trust the optimizer trace. But be careful with both the key_len column in explain and slow log output. [Use The Index, Luke explains](https://use-the-index-luke.com/sql/explain-plan/mysql/access-filter-predicates) index access and index filter predicates.

The full SQL for my test case [is here](https://gist.github.com/mdcallag/6e7a8ab51fd779ff3d2e6c592c1e1a2b). There is a table with an index on (x,y,z). There are not null constraints on all columns (not shown below).
<pre>
create table t (x int, y int, z int, val int, bloat char(200));
create index x1 on t(x, y, z);
</pre>

The queries are:
<pre>
Q1: select * from t where x >= 1 and x <= 3 and y = 3 and z in (1,3,5);
Q2: select * from t where x >= 1 and x <= 3 and y = 3;
Q3: select * from t where x >= 1 and x <= 3;
</pre>

# An optimization opportunity

Is it possible to use all of the WHERE clause from Q1 and Q2 for index access predicates? The quick answer is no because once a range predicate is encountered the columns that follow it in the index can only be used as index filter predicates. In this case there is a range predicate on x and things in the WHERE clause for y and z would only be index filter predicates -- when my quick answer is correct.

Q1 has a range predicate on x, equality on y and multiple equality on z and I summarize that as (range, eq, eqN). The predicates for Q2 can be written as (range, eq, none) and for Q3 as (range, none, none). The skip scan optimization for MySQL might be used for a query like the following. Using the syntax from above I could represent that as (eq, none, range).
<pre>
select * from t where x=2 and z >= 2
</pre>

So the style of predicates in Q1 and Q2 don't satisfy the requirements for MySQL skip scan because there is a range predicate on the most significant column in the index but I wonder if the existing code could be extended to support Q1 and Q2 because the [skip scan docs](https://dev.mysql.com/doc/refman/8.0/en/range-optimization.html#range-access-skip-scan) state that existing code can *Skip between distinct values of the first index part*. Is it possible to use that for Q1 by the following?

1. Seek to (x=1, y=3, z=1) in the index
2. Scan until z > 1
3. Seek to (x=$current, y=3, z=3)
4. Scan until z > 3
5. Seek to (x=$current, y=3, z=5)
6. Scan until z > 5
3. Seek to (next distinct value x, y=3, z=1) and goto 2 if x is <= 3

When I ask about things like this I wonder whether I missed something obvious (MySQL already supports this) or whether this is nonsense. I don't think MySQL already supports this but am happy to be corrected and learn more.

# The data

This lists the queried table in index order, excluding the *bloat* column and rows for x >= 5. Each row is tagged with *Q1*, *Q2* or *Q3* when that row is in the result set for that query. This makes it clear that the result for Q3 is co-located in the index -- seek once, then call next to get the rest. The result for Q1 and Q2 is not co-located. It is three parts and in theory there are two ways to get that from the index
1. Seek to the start for each part and call next. There is only one row in each part so the next call doesn't get more rows. There will be 3 seeks and one row per seek.
2. Seek to the first row (x=1, y=3, z=3) and keep calling next until x > 3. There will be one seek and 20 or 21 calls to next.

<pre>
x       y       z      result set
1       1       1      Q3
1       2       2      Q3
1       3       3      Q3  Q1  Q2
1       4       4      Q3
1       5       5      Q3
1       6       6      Q3
1       7       7      Q3
1       8       8      Q3
1       9       9      Q3
1       10      10     Q3
2       1       1      Q3
2       2       2      Q3
2       3       3      Q3  Q1  Q2
2       4       4      Q3
2       5       5      Q3
2       6       6      Q3
2       7       7      Q3
2       8       8      Q3
2       9       9      Q3
2       10      10     Q3
3       1       1      Q3
3       2       2      Q3
3       3       3      Q3  Q1  Q2
3       4       4      Q3
3       5       5      Q3
3       6       6      Q3
3       7       7      Q3
3       8       8      Q3
3       9       9      Q3
3       10      10     Q3
4       1       1
4       2       2
4       3       3
4       4       4
4       5       5
4       6       6
4       7       7
4       8       8
4       9       9
4       10      10
</pre>

# What I want to know

I want to confirm the [index access predicate](https://use-the-index-luke.com/sql/explain-plan/mysql/access-filter-predicates) only uses x and the others (y and z) are [index filter predicates](https://use-the-index-luke.com/sql/explain-plan/mysql/access-filter-predicates). If this is true then the 3 queries use the index in the same way (read the same entries, use the same start/stop keys during the range scan). But they will differ after the index range scan because Q1 and Q2 have different index filter predicates.

The [docs for key_len](https://dev.mysql.com/doc/refman/8.0/en/explain-output.html) state the following. Note that *decided to use* doesn't distinguish between usage as an index access or index filter predicate. Later in this post I show that I can't determine how many parts of a multiple-part key MySQL actually used based on key_len. So this part of the manual is more truthy than true - not a complaint, MySQL does a good job explaining optimizations.
> The key_len column indicates the length of the key that MySQL decided to use. The value of key_len enables you to determine how many parts of a multiple-part key MySQL actually uses.

The [docs on range optimization](https://dev.mysql.com/doc/refman/8.0/en/range-optimization.html#range-access-multi-part) for multi-part indexes are clear that once a range predicate is encountered, then there will be no more parts used for the index access predicate. So for Q1 and an index on (x,y,z) the range predicate on x means that the index access predicate is limited to x.

> The optimizer attempts to use additional key parts to determine the interval as long as the comparison operator is =, <=>, or IS NULL. If the operator is >, <, >=, <=, !=, <>, BETWEEN, or LIKE, the optimizer uses it but considers no more key parts. For the following expression, the optimizer uses = from the first comparison. It also uses >= from the second comparison but considers no further key parts and does not use the third comparison for interval construction:

# Explain output

Up next is output from explain for Q1, Q2 and Q3.

Explain for Q1 has a range scan with key_len=12 and I expect it to be 4 so I am confused (each key part is a 4-byte integer). When key_len=12 that suggests that x, y and z are all used for the index access predicate and I doubt that is the case. Given the range predicate on x and the statement above about range predicates I don't think this is possible with MySQL. There are not null constraints on x, y and z so that would not explain why key_len is larger than 4.

<pre>
           id: 1
  select_type: SIMPLE
        table: t
   partitions: NULL
         type: range
possible_keys: x1
          key: x1
      key_len: 12
          ref: NULL
         rows: 21
     filtered: 3.00
        Extra: Using index condition
</pre>

Explain for Q2 is similar to Q1 except key_len=8 rather than 12 because z is not referenced in the WHERE clause. Again I am confused and expect key_len to be 4.
<pre>
           id: 1
  select_type: SIMPLE
        table: t
   partitions: NULL
         type: range
possible_keys: x1
          key: x1
      key_len: 8
          ref: NULL
         rows: 21
     filtered: 10.00
        Extra: Using index condition
</pre>

Explain for Q3 has key_len=4 which is what I expect because the WHERE clause only has a range predicate on x.
<pre>
           id: 1
  select_type: SIMPLE
        table: t
   partitions: NULL
         type: range
possible_keys: x1
          key: x1
      key_len: 4
          ref: NULL
         rows: 30
     filtered: 100.00
        Extra: Using index condition
</pre>

# Slow log output

At this point I am still confused and check the slow query log with *slow-log-extra=ON*. The output has more data than I show below. I trimmed it for readability.
* Q1: *Rows_sent: 3  Rows_examined: 3 Read_key: 1 Read_next: 3*
* Q2: *Rows_sent: 3  Rows_examined: 3 Read_key: 1 Read_next: 3*
* Q3: *Rows_sent: 30  Rows_examined: 30 Read_key: 1 Read_next: 30*

I am not sure whether *Rows_examined* is incremented before or after index filter predicates have been applied. I hoped that *Read_key* meant seek but the [docs aren't clear](https://dev.mysql.com/doc/refman/8.0/en/slow-query-log.html) and it can't mean seek given the results above. As I show in [the Data section](https://github.com/mdcallag/mdcallag.github.io/new/master#the-data) the result for Q1 and Q2 has 3 rows and the rows are not adjacent in the index. So there is either 1 seek followed by 20 nexts or 3 seeks. There isn't 1 seek followed by 3 nexts -- but the slow log shows Read_key=1, Read_next=3 for Q1 and Q2.

# Optimizer trace

I am still confused after using explain and the slow log. Next up is to use the [optimizer trace tool](http://oysteing.blogspot.com/2016/01/how-to-get-optimizer-trace-for-query.html). This might be the first time I have used it and it quickly made me less confused.

This is part of the trace for Q1 and shows that the index access predicate is limited to x, thus y and z will be index filter predicates. While I don't show it here the result is the same if I change Q1 to be index-only by using *select x,y,z*.
<pre>
                  "chosen_range_access_summary": {
                    "range_access_plan": {
                      "type": "range_scan",
                      "index": "x1",
                      "rows": 21,
                      "ranges": [
                        "1 <= x <= 3"
                      ]
                    },
                    "rows_for_plan": 21,
                    "cost_for_plan": 7.61,
                    "chosen": true
                  }
</pre>

This post is long enough so I won't show the trace output for Q2. It is the same as the trace above.
