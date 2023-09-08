# Chasing down a performance regression in MyRocks 5.6

I recently shared two blog posts documenting performance regressions in MyRocks 5.6 releases over the past 2 years. Most are due to new CPU overhead so I used perf and created flamegraphs
to narrow my search. My focus is on two of the benchmark steps from the [Insert Benchmark](http://smalldatum.blogspot.com/2023/05/updates-to-insert-benchmark.html) -- l.i1 and q100, see below.

For the l.i1 benchmark step more time is spent in these functions in newer builds:
* MemTableInserter::DeleteImpl/SingleDeleteCF under ha_commit_trans
* MemTableInsert::PutCFImpl/PutCF under ha_commit_trans
* CompactionIterator::Next
* CompactionOutputs::AddToOutput / BlockBasedTableBuilder::Add

For the q100 benchmark step more time is spent in these functions in newer builds:
* MergingIterator::Seek
* BlockBasedTable::NewDataBlockIterator / BlockBasedTableIterator::InitDataBlock
* IndexBlockIter::SeekImpl
* DBImpl::NewIteratorImpl

# Builds

The builds are [explained here](http://smalldatum.blogspot.com/2023/08/checking-myrocks-56-for-regressions_17.html). Below I just use the dates from which the builds were done. All of this uses the FB MySQL 5.6.35 github repo and everything was compiled from source. The dates for the builds are:
* 2022-03-07
* 2022-05-19
* 2022-08-09
* 2023-02-16
* 2023-05-29

# Benchmarks

The insert benchmark was run using a cached database and all tables fit in the RocksDB block cache
IO-bound - the database is larger than memory
The server has 80 HW threads, 40 cores, 256G of RAM and fast NVMe storage with XFS.

The benchmark is run with 24 clients, 24 tables and a client per table. The benchmark is a sequence of steps.
* l.i0 - insert 20 million rows per table 
* l.x - create 3 secondary indexes. I usually ignore performance from this step.
* l.i1 - insert and delete another 10 million rows per table with secondary index maintenance. The number of rows/table at the end of the benchmark step matches the number at the start with inserts done to the table head and the deletes done from the tail.
* q100, q500, q1000 - do queries as fast as possible with 100, 500 and 1000 inserts/s/client and the same rate for deletes/s done in the background. Run for 1800 seconds.

# Flamegraphs and me

I use both non-differential and differential flamegraphs.

The non-differential flamegraphs combine the folded output from many perf samples into one large file. Had I not done this the flamegraph results have much variance depending on whether compaction is active during the sample. For l.i1 the newer builds, such as 2023-05-29, have more samples than the older builds, such as 2022-03-07, because the benchmark step runs for more time with the newer builds because the older builds sustain a higher insert rate. Regardless, I used to flamegraphs to find functions for which their relative overhead has changed across releases. For example, if some function accounts for 10% of the samples in an older build vs 20% in a newer build then I assume that function is part of the regression.

It is possible for there to be a regression from new CPU overhead even if the distribution of time in function A vs function B doesn't change. One example is if there are more memory system stalls and the stalls are uniformly distributed. However, I see guidance from the flamegraphs not an exact answer for the root cause.

The differential flamegraphs compare a given build with results from the 2022-03-07 build. Given that the source code for the compared builds are not the same the differential flamegraph isn't always useful. However, the results from the differential flamegraphs turned out to be useful.

# Flamegraph summaries

I started by going through the non-differential flamegraphs and created tables to show the percentage of samples for each of the towers on the flamegraphs and then zooming in (moving up the towers). Using the first table below and the 2022-03-07 line: 49.89% of the time is from my-connection and children vs 2.46% for rocksdb:high and children vs 47.41% for rocksdb:low and children.

## Summary for l.i1

The l.i1 benchmark step does random inserts and deletes as fast as possible.

In this table the amount of time in my-oneconnection increases slightly
```
a - my-oneconnection, MySQL foreground threads processing inserts and deletes
b - rocksdb:high, RocksDB memtable flush
c - rocksdb:low, RocksDB compaction

Numbers are the percentage of time in each function including its children.
a       b       c       version
49.89   2.46    47.41   2022-03-07, RocksDB 6.28.2
49.51   2.45    47.94   2022-05-19, RocksDB 7.2.2
51.38   2.41    46.11   2022-08-09, RocksDB 7.3.1
51.49   2.80    45.19   2023-02-16, RocksDB 7.10.0
50.04   2.74    46.67   2023-05-29, RocksDB 8.2.1
```

Where has time increased in newer builds? My focus is on leaf nodes in the call stacks.
* MemTableInserter::DeleteImpl/SingleDeleteCF under ha_commit_trans
* MemTableInsert::PutCFImpl/PutCF under ha_commit_trans
* CompactionIterator::Next
* CompactionOutputs::AddToOutput / BlockBasedTableBuilder::Add

### Foreground threads

If you read to the end there is more time spent in two functions in newer builds, although it isn't clear this increase is sufficient to explain the perf regression.
* MemTableInserter::DeleteImpl/SingleDeleteCF
* MemTableInsert::PutCFImpl/PutCF 

Next up are the functions called by my-oneconnection which process the inserts and deletes via a thread per MySQL connection and the overhead from ha_commit_trans increased in newer builds.
```
a - MYSQLparse
b - ha_commit_trans
c - mysql_delete
d - mysql_insert

Numbers are the percentage of time in each function including its children.
a       b       c       d       version
2.32    11.45   17.10   17.11   2022-03-07, RocksDB 6.28.2
2.13    11.27   17.21   17.09   2022-05-19, RocksDB 7.2.2
2.06    11.18   18.24   18.11   2022-08-09, RocksDB 7.3.1
2.16    12.67   17.41   17.43   2023-02-16, RocksDB 7.10.0
2.14    12.52   16.75   16.86   2023-05-29, RocksDB 8.2.1
```

So then I look at one of the functions, WriteBatchInternal::Iterate, on the callstack where ha_commit_trans is an ancestor and the time in it increased in newer builds.
```
a - WriteBatchInternal::Iterate

Numbers are the percentage of time in each function including its children.
a       version 
7.96    2022-03-07, RocksDB 6.28.2      
7.92    2022-05-19, RocksDB 7.2.2
7.80    2022-08-09, RocksDB 7.3.1
9.07    2023-02-16, RocksDB 7.10.0
8.83    2023-05-29, RocksDB 8.2.1
```

Finally I look at functions called by WriteBatchInternal::Iterator and the time in two of them (columns b and c below) increased in newer builds.
```
a - MemTableInserter::DeleteCF
b - MemTableInserter::DeleteImpl/SingleDeleteCF
c - MemTableInsert::PutCFImpl/PutCF 

Numbers are the percentage of time in each function including its children.
a       b       c       version
0.62    2.92    3.77    2022-03-07, RocksDB 6.28.2
0.64    2.95    3.73    2022-05-19, RocksDB 7.2.2
0.64    3.06    3.84    2022-08-09, RocksDB 7.3.1
0.80    3.52    4.51    2023-02-16, RocksDB 7.10.0
0.77    3.44    4.38    2023-05-29, RocksDB 8.2.1
```

### Compaction threads

This section focuses on the call stacks for compaction and the functions have rocksdb:low as an ancestor.

These aren't called directly by rocksdb:low but they are the first where the call stack splits and the time in CompactionJob::ProcessKeyValueCompaction increased in newer builds.
```
a - CompactionJob::ProcessKeyValueCompaction
b - BGThreadWrapper

Numbers are the percentage of time in each function including its children.
a       b       version 
 5.47   41.73   2022-03-07, RocksDB 6.28.2
 6.04   41.75   2022-05-19, RocksDB 7.2.2
 7.09   38.86   2022-08-09, RocksDB 7.3.1
10.96   34.14   2023-02-16, RocksDB 7.10.0
11.72   34.87   2023-05-29, RocksDB 8.2.1
```

Next are children of CompactionJob::ProcessKeyValueCompaction and newer builds spend more time in both CompactionIterator::Next and CompactionOutputs::AddToOutput / BlockBasedTableBuilder::Add.
```
a - CompactionIterator::Next
b - CompactionOutputs::AddToOutput / BlockBasedTableBuilder::Add

Numbers are the percentage of time in each function including its children.
a       b       version
2.54    1.46    2022-03-07, RocksDB 6.28.2
2.67    1.68    2022-05-19, RocksDB 7.2.2
3.18    1.94    2022-08-09, RocksDB 7.3.1
5.27    5.23    2023-02-16, RocksDB 7.10.0
5.81    5.43    2023-05-29, RocksDB 8.2.1
```

## Summary for q100

The q100 benchmark step does short range queries as fast as possible and reports the performance for those queries. Additionally, rate-limited inserts and deletes are done (100 inserts/s and 100 deletes/s per client).

Where has time increased in newer builds? My focus is on leaf nodes in the call stacks.
* MergingIterator::Seek
* BlockBasedTable::NewDataBlockIterator / BlockBasedTableIterator::InitDataBlock
* IndexBlockIter::SeekImpl
* DBImpl::NewIteratorImpl

First are the functions at the base of each tower on the flamegraph. All of these except for rocksdb:low have handle_one_connection as an ancestor and handle_one_connection is used to process user requests. The fraction of time from mysql_execute_command increased in newer builds and that function includes query optimization and execution.
```
a - MYSQLparse
b - mysql_execute_command
c - net_write_raw_loop
d - net_read_raw_loop
e - rocksdb:low (compaction)

Numbers are the percentage of time in each function including its children.
a       b       c       d       e       version
7.49    75.96   5.61    4.52    1.79    2022-03-07, RocksDB 6.28.2
7.32    73.57   5.21    4.46    4.95    2022-05-19, RocksDB 7.2.2
7.37    77.66   5.22    4.32    0.85    2022-08-09, RocksDB 7.3.1
7.17    78.43   4.91    4.29    0.90    2023-02-16, RocksDB 7.10.0
7.16    79.03   4.91    4.15    0.45    2023-05-29, RocksDB 8.2.1
```

Next are the children of mysql_execute_command. The fraction of time in JOIN::exec increased in newer builds.
```
a - clock_gettime
b - close_open_tables
c - JOIN::exec
d - JOIN::optimize
e - JOIN::prepare
f - mysql_lock_tables
g - open_normal_and_derived_tables
h - ha_commit_trans

Numbers are the percentage of time in each function including its children.
a       b       c       d       e       f       g       h       version
0.78    2.54    37.10   24.57   2.88    1.32    1.23    1.72    2022-03-07, RocksDB 6.28.2
0.76    2.46    36.22   23.63   2.63    1.25    1.18    1.79    2022-05-19, RocksDB 7.2.2
0.76    2.39    39.37   24.47   2.71    1.30    1.24    1.61    2022-08-09, RocksDB 7.3.1
0.77    2.16    39.87   24.69   2.69    1.52    1.24    1.89    2023-02-16, RocksDB 7.10.0
0.70    2.18    40.73   24.67   2.61    1.40    1.26    1.86    2023-05-29, RocksDB 8.2.1
```

Next are the children of JOIN::exec and the time in sub_select increased in newer builds.
```
a - JOIN::join_free
b - Protocol::send_result_set_metadata
c - sub_select

Numbers are the percentage of time in each function including its children.
a       b       c       version
3.89    0.96    31.71   2022-03-07, RocksDB 6.28.2
3.77    0.94    30.98   2022-05-19, RocksDB 7.2.2
4.25    0.86    33.74   2022-08-09, RocksDB 7.3.1
4.06    0.84    34.48   2023-02-16, RocksDB 7.10.0
4.15    0.80    35.24   2023-05-29, RocksDB 8.2.1
```

Next are the children of sub_select and the time in rr_quick increased in newer builds.
```
a - Item_func_ge::val_int
b - end_send
c - join_init_read_record
d - rr_quick

Numbers are the percentage of time in each function including its children.
a       b       c       d       version
0.48    3.55    2.28    24.85   2022-03-07, RocksDB 6.28.2
0.46    3.36    2.23    24.42   2022-05-19, RocksDB 7.2.2
0.45    3.30    2.30    27.19   2022-08-09, RocksDB 7.3.1
0.46    3.28    2.18    28.03   2023-02-16, RocksDB 7.10.0
0.43    3.12    2.14    29.06   2023-05-29, RocksDB 8.2.1
```

Next are the children of rr_quick and the time in RocksDB code (position_to_correct_key, setup_scan_iterator) increased in newer builds.
```
a - ha_rocksdb::index_next_with_direction
b - ha_rocksdb::position_to_correct_key
c - ha_rocksdb::setup_scan_iterator

Numbers are the percentage of time in each function including its children.
a       b       c       version
3.41    17.90   1.93    2022-03-07, RocksDB 6.28.2
3.38    17.70   1.69    2022-05-19, RocksDB 7.2.2
3.30    19.88   2.37    2022-08-09, RocksDB 7.3.1
3.51    20.08   2.86    2023-02-16, RocksDB 7.10.0
3.38    21.12   3.08    2023-05-29, RocksDB 8.2.1
```

Next are the children of DBIter::Seek which has position_to_correct_key as an ancestor and the time in MergingIterator::Seek increased in newer builds.
```
a - DBIter::FindNextUserEntry
b - my_rocksdb::MergingIterator::Seek

Numbers are the percentage of time in each function including its children.
a       b       version
0.99    15.96   2022-03-07, RocksDB 6.28.2
1.05    15.76   2022-05-19, RocksDB 7.2.2
x       x       2022-08-09, RocksDB 7.3.1
1.27    17.86   2023-02-16, RocksDB 7.10.0
1.24    18.90   2023-05-29, RocksDB 8.2.1
```

Next are the children of MergingIterator::Seek and the time in BlockBasedTableIterator::SeekImpl increased in newer builds.
```
a - my_rocksdb::LevelIterator::Seek
b - my_rocksdb::BlockBasedTableIterator::SeekImpl
c - my_rocksdb::MemTableIterator::Seek

q100 - under MergingIterator::Seek
Numbers are the percentage of time in each function including its children.
a       b       c       version
12.81   1.64    1.00    2022-03-07, RocksDB 6.28.2
13.44   0.86    0.94    2022-05-19, RocksDB 7.2.2
12.65   3.17    0.93    2022-08-09, RocksDB 7.3.1
12.29   3.00    0.97    2023-02-16, RocksDB 7.10.0
11.76   4.59    0.94    2023-05-29, RocksDB 8.2.1
```

Next are the children of BlockBasedTableIterator::SeekImpl and the time in BlockBasedTable::NewDataBlockIterator / BlockBasedTableIterator::InitDataBlock and IndexBlockIter::SeekImpl increased in newer builds.
```
a - memcmp
b - my_rocksdb::BlockBasedTable::NewDataBlockIterator / BlockBasedTableIterator::InitDataBlock
c - my_rocksdb::DataBlockIter::SeekImpl / BlockIter<my_rocksdb::IndexValue>::Seek
d - my_rocksdb::IndexBlockIter::SeekImpl

q100 - under my_rocksdb::BlockBasedTableIterator::SeekImpl
Numbers are the percentage of time in each function including its children.
a       b       c       d       version
0.21    0.67    0.43    0.22    2022-03-07, RocksDB 6.28.2
0.06    0.36    0.29    0.11    2022-05-19, RocksDB 7.2.2
0.02    1.40    0.51    1.16    2022-08-09, RocksDB 7.3.1
0.02    1.36    0.48    1.04    2023-02-16, RocksDB 7.10.0
0.01    2.03    0.73    1.69    2023-05-29, RocksDB 8.2.1
```

Finally, the children of setup_scan_iterator and the time in DBImpl::NewIteratorImpl increased in recent builds.
```
a - DBImpl::NewIteratorImpl

Numbers are the percentage of time in each function including its children.
a       version
1.42    2022-03-07, RocksDB 6.28.2
1.16    2022-05-19, RocksDB 7.2.2
1.81    2022-08-09, RocksDB 7.3.1
2.34    2023-02-16, RocksDB 7.10.0
2.43    2023-05-29, RocksDB 8.2.1
```

# Flamegraphs

I don't inline the flamegraphs here to improve the download speed for this page. Also, I provide two links per flamegraph, one for viewing and the other for downloading. To get an interactive svg file you need to download it. 

Flamegraphs for l.i1
* 2022-03-07 : [inlined](../svg/sep23.56builds.ibench.u/480m.fbmy5635_202203072101.cy9c5_u/l.i1/all_svg.md), [download](https://github.com/mdcallag/mytools/tree/master/bench/arc/56builds.perf.svg.sep23/480m.fbmy5635_202203072101.cy9c5_u/l.i1/o.perf.g.all.svg)
* 2022-05-19 : [inlined](../svg/sep23.56builds.ibench.u/480m.fbmy5635_202205192101.cy9c5_u/l.i1/all_svg.md), [download](https://github.com/mdcallag/mytools/tree/master/bench/arc/56builds.perf.svg.sep23/480m.fbmy5635_202205192101.cy9c5_u/l.i1/o.perf.g.all.svg)
* 2022-08-19 : [inlined](../svg/sep23.56builds.ibench.u/480m.fbmy5635_202208092101.cy9c5_u/l.i1/all_svg.md), [download](https://github.com/mdcallag/mytools/tree/master/bench/arc/56builds.perf.svg.sep23/480m.fbmy5635_202208092101.cy9c5_u/l.i1/o.perf.g.all.svg)
* 2023-02-16 : [inlined](../svg/sep23.56builds.ibench.u/480m.fbmy5635_202302162102.cy9c5_u/l.i1/all_svg.md), [download](https://github.com/mdcallag/mytools/tree/master/bench/arc/56builds.perf.svg.sep23/480m.fbmy5635_202302162102.cy9c5_u/l.i1/o.perf.g.all.svg)
* 2023-05-29 : [inlined](../svg/sep23.56builds.ibench.u/480m.fbmy5635_202305292102.cy9c5_u/l.i1/all_svg.md), [download](https://github.com/mdcallag/mytools/tree/master/bench/arc/56builds.perf.svg.sep23/480m.fbmy5635_202305292102.cy9c5_u/l.i1/o.perf.g.all.svg)

Flamegraphs for q100
* 2022-03-07 : [inlined](../svg/sep23.56builds.ibench.u/480m.fbmy5635_202203072101.cy9c5_u/q.L1.ips100/all_svg.md), [download](https://github.com/mdcallag/mytools/tree/master/bench/arc/56builds.perf.svg.sep23/480m.fbmy5635_202203072101.cy9c5_u/q.L1.ips100/o.perf.g.all.svg)
* 2022-05-19 : [inlined](../svg/sep23.56builds.ibench.u/480m.fbmy5635_202205192101.cy9c5_u/q.L1.ips100/all_svg.md), [download](https://github.com/mdcallag/mytools/tree/master/bench/arc/56builds.perf.svg.sep23/480m.fbmy5635_202205192101.cy9c5_u/q.L1.ips100/o.perf.g.all.svg)
* 2022-08-19 : [inlined](../svg/sep23.56builds.ibench.u/480m.fbmy5635_202208092101.cy9c5_u/q.L1.ips100/all_svg.md), [download](https://github.com/mdcallag/mytools/tree/master/bench/arc/56builds.perf.svg.sep23/480m.fbmy5635_202208092101.cy9c5_u/q.L1.ips100/o.perf.g.all.svg)
* 2023-02-16 : [inlined](../svg/sep23.56builds.ibench.u/480m.fbmy5635_202302162102.cy9c5_u/q.L1.ips100/all_svg.md), [download](https://github.com/mdcallag/mytools/tree/master/bench/arc/56builds.perf.svg.sep23/480m.fbmy5635_202302162102.cy9c5_u/q.L1.ips100/o.perf.g.all.svg)
* 2023-05-29 : [inlined](../svg/sep23.56builds.ibench.u/480m.fbmy5635_202305292102.cy9c5_u/q.L1.ips100/all_svg.md), [download](https://github.com/mdcallag/mytools/tree/master/bench/arc/56builds.perf.svg.sep23/480m.fbmy5635_202305292102.cy9c5_u/q.L1.ips100/o.perf.g.all.svg)

Differential flamegraphs for l.i1, base case is 2022-03-07
* 2022-05-19 : [inlined](../svg/sep23.56builds.ibench.u/480m.fbmy5635_202205192101.cy9c5_u/l.i1/diff_svg.md), [download](https://github.com/mdcallag/mytools/tree/master/bench/arc/56builds.perf.svg.sep23/480m.fbmy5635_202205192101.cy9c5_u/l.i1/all.diff.svg)
* 2022-08-19 : [inlined](../svg/sep23.56builds.ibench.u/480m.fbmy5635_202208092101.cy9c5_u/l.i1/diff_svg.md), [download](https://github.com/mdcallag/mytools/tree/master/bench/arc/56builds.perf.svg.sep23/480m.fbmy5635_202208092101.cy9c5_u/l.i1/all.diff.svg)
* 2023-02-16 : [inlined](../svg/sep23.56builds.ibench.u/480m.fbmy5635_202302162102.cy9c5_u/l.i1/diff_svg.md), [download](
https://github.com/mdcallag/mytools/tree/master/bench/arc/56builds.perf.svg.sep23/480m.fbmy5635_202302162102.cy9c5_u/l.i1/all.diff.svg)
* 2023-05-29 : [inlined](../svg/sep23.56builds.ibench.u/480m.fbmy5635_202305292102.cy9c5_u/l.i1/diff_svg.md), [download](https://github.com/mdcallag/mytools/tree/master/bench/arc/56builds.perf.svg.sep23/480m.fbmy5635_202305292102.cy9c5_u/l.i1/all.diff.svg)

Differential flamegraphs for q100, base case is 2022-03-07
* 2022-05-19 : [inlined](../svg/sep23.56builds.ibench.u/480m.fbmy5635_202205192101.cy9c5_u/q.L1.ips100/diff_svg.md), [download](https://github.com/mdcallag/mytools/tree/master/bench/arc/56builds.perf.svg.sep23/480m.fbmy5635_202205192101.cy9c5_u/q.L1.ips100/all.diff.svg)
* 2022-08-19 : [inlined](../svg/sep23.56builds.ibench.u/480m.fbmy5635_202208092101.cy9c5_u/q.L1.ips100/diff_svg.md), [download](https://github.com/mdcallag/mytools/tree/master/bench/arc/56builds.perf.svg.sep23/480m.fbmy5635_202208092101.cy9c5_u/q.L1.ips100/all.diff.svg)
* 2023-02-16 : [inlined](../svg/sep23.56builds.ibench.u/480m.fbmy5635_202302162102.cy9c5_u/q.L1.ips100/diff_svg.md), [download](https://github.com/mdcallag/mytools/tree/master/bench/arc/56builds.perf.svg.sep23/480m.fbmy5635_202302162102.cy9c5_u/q.L1.ips100/all.diff.svg)
* 2023-05-29 : [inlined](../svg/sep23.56builds.ibench.u/480m.fbmy5635_202305292102.cy9c5_u/q.L1.ips100/diff_svg.md), [download](https://github.com/mdcallag/mytools/tree/master/bench/arc/56builds.perf.svg.sep23/480m.fbmy5635_202305292102.cy9c5_u/q.L1.ips100/all.diff.svg)

