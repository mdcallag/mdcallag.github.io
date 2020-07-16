# Overview

This describes the formatted results extracted from the insert benchmark output.
The results are extracted by helper scripts as the insert benchmark client generates a lot of data.
The helper scripts also run vmstat and iostat to collect hardware metrics that are used to compute HW efficiency metrics. 
The scripts generate one line of text per test step and I currently use several test steps.

The test steps are:
* l.i0 - loads without secondary indexes
* l.x - creates secondary indexes
* l.i1 - continues the load with the secondary indexes in place. This will be slower than **l.i0** because of secondary index maintenance.
* q100, q200, q400, q600, q800, q1000 - these steps do range queries concurrent with inserts. For each table (collection) there is one query client and one insert client. The insert client has a rate limit, indicated by the number that follows *q* so that **q100** means to do 100 insert/s per client. Sometimes the DBMS is unable to sustain the target insert rate.

Below I frequently assume that writes == inserts and reads == short range queries.

# Load

This is valid for l.i0, l.x and l.i1. For **l.x** metrics are normalized by the number of indexed rows (documents) -- so IPS means indexed rows/second.

Example output:
```
ips     qps     rps     rkbps   wkbps   rpq     rkbpq   wkbpi   csps    cpups   cspq    cpupq   dbgb1   dbgb2   rss     maxop   p50     p99     tag
60000   0       0       0       9041    0.000   0.000   0.151   5990    11.2    0.100   30      0.7     1.5     0.6     0.101   62533   50146   rx56.c7b40
```

Note:
* All of the rates are the average over the entire test step.
* The full test output has per-interval averages but the goal here is to condense the results for a test step to one line.
  Limiting that to one line makes it easier to compare results between different configurations.
* The headers for HW efficiency metrics, CPU or IO /insert, in the Load step should have used **i** rather than **q** 
  (see rpq, rkbpq, etc). Perhaps it is too late to fix that -- :clown_face:. But HW efficiency metrics are valuable as
  they often explain why one DBMS is faster than another.
* The example data is from an in-memory workload so rps, rkbps, rkbpq are zero because there were no storage reads.

Legend:
* ips - inserts/second
* qps - queries/second. Will be zero for Load and non-zero for [Run](master#Run).
* rps - storage reads /second per iostat
* rkbps, wkbps - storage read KB and write KB /second per iostat
* rpq - storage read /insert computed from rps/ips
* rkbpq, wkbpi - storage read and write KB /insert computed as rkbps/ips and wkbps/ips. Pretend this is rkbpi.
* csps - context switch /second per vmstat
* cpups - CPU utilization, the sum of the us and sy columns per vmstat
* cspq - context switches /insert computed from csps/ips. Pretend this is named cpupi.
* cpupq - CPU microseconds /insert. Pretend this is named cpupi. This includes CPU by the client, DBMS and anything else running on the server.
* dbgb1, dbgb2 - database size in GB. **dbgb1** is the size of the test tables and indexes while **dbgb2** includes everything in the database directory (db files, redo log, replication log, error log) and can be misleading. For example, unless replication logs are kept for the same time period for all DBMS it isn't comparable.
* rss - RSS in GB for database process, measured via *ps aux*
* maxop - max response time for an insert in milliseconds
* p50, p99 - the 50th and 99th percentile of the per-interval insert rates. These are per-client while *ips* is the average rate across all clients. If there are 8 clients and *ips* is 80,000 then the per-client p50 rate might be 10,000. The insert rates tend to increase over time.
* tag - name of the configuration tested. This names the DBMS, storage engine and configuration options that are 
  explained elsewhere. In the example, **rx56.c5**, rx56 is MyRocks from MySQL 5.6 and c5b is the configuraton file (my.cnf).

# Run

The legend [from Load](master#load) applies here but I explain where it differs. The load step is insert-only, the run step
is read-write.

Legend:
* ips - inserts/second. The run step uses a rate-limited writer and ips should be close to that rate limit. But in some
        cases the rate limit is too high or the DBMS is too slow and ips is less than the limit.
* qps - queries/second. Each query is a short range scan. Queries are not rate-limited.
* rpq - storage read /query computed from rps/qps
* rkbpq - storage read KB /query computed as rkbps/qps.
* wkbpi - storage write KB /insert computed as wkbps/ips.
* cspq, context switches /query
* cpupq, ccpupq - total and client CPU microseconds /query
* maxop - max response time for a query in milliseconds
* p50, p99 - the 50th and 99th percentile of the per-client, per-interval query rates.

Example output:
```
ips     qps     rps     rkbps   wkbps   rpq     rkbpq   wkbpi   csps    cpups   cspq    cpupq   dbgb1   dbgb2   rss     maxop   p50     p99     tag
99      3156    0       0       25      0.000   0.000   0.249   12472   5.2     3.952   264     3.5     6.1     3.3     0.001   3165    3117    rx56.c7b40
```

# Response Time Histograms

These list the percentage of responses that are in each bucket. Each response is counted once in the bucket in which it fits. The 256us bucket has all responses that take <= 256 microseconds. The 1ms bucket has all repsonses that take between 256us and 1 millisecond, and so on. The buckets are:
* 256us - 256 microseconds
* 1ms, 4ms, 16mx, 64ms, 256ms - *ms* is milliseconds
* 1s, 4s, 16s - *s* is seconds
* gt - all responses > 16 seconds
* max - the max response time in seconds
* tag - the DBMS and configuration 

```
256us   1ms     4ms     16ms    64ms    256ms   1s      4s      16s     gt      max     tag
0.000   0.000   82.919  15.837  1.073   0.161   0.010   0.000   0.000   0.000   0.45814 pg12.c7b40
```
