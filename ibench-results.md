# Overview

This describes the formatted results extracted from the insert benchmark output.
The results are extracted by helper scripts as the insert benchmark client generates a lot of data.
The helper scripts also run vmstat and iostat to collect hardware metrics that are used to compute HW efficiency metrics. 
The scripts generate one line of text per test step and I currently use several test steps - load, run and scan.
The load step is insert only. The run step does short range queries as fast as possible with a rate-limited writer and there are usually many run steps.
The scan step does full index scans with no writers, it is read-only. There is one scan step per index.

Below I frequently assume that writes == inserts and reads == short range queries.

# Load

Example output with vsz and rss
```
ips     qps     rps     rkbps   wkbps   rpq     rkbpq   wkbpq   csps    cpups   cspq    cpupq   ccpupq  dbgb    vsz     rss     maxop   p50     p90     tag
124805  0       0       0       110669  0.000   0.000   0.887   19298   47.5    0.155   61      2       13      3.4     2.2     0.536   16018   13616   rx56.c5b40
```

Note:
* All of the rates are the average over the entire test step.
* The full test output has per-interval averages but the goal here is to condense the results for a test step to one line.
  Limiting that to one line makes it easier to compare results between different configurations.
* The headers for HW efficiency metrics, CPU or IO /insert, in the Load step I should have used **i** rather than **q** 
  (see rpq, rkbpq, etc). Perhaps it is too late to fix that -- :clown_face:. But HW efficiency metrics are valuable as
  they often explain why one DBMS is faster than another.
* The example data is from an in-memory workload so rps, rkbps, rkbpq are zero because there were no storage reads.

Legend:
* ips - inserts/second
* qps - queries/second. Will be zero for Load and non-zero for [Run](master#Run).
* rps - storage reads /second per iostat
* rkbps, wkbps - storage read KB and write KB /second per iostat
* rpq - storage read /insert computed from rps/ips
* rkbpq, wkbpq - storage read and write KB /insert computed as rkbps/ips and wkbps/ips. Pretend this is rkbpi and wkbpi.
* csps - context switch /second per vmstat
* cpups - CPU utilization, the sum of the us and sy columns per vmstat
* cspq - context switches /insert computed from csps/ips. Pretend this is named cpupi.
* cpupq - CPU microseconds /insert. Pretend this is named cpupi. This includes CPU by the client, DBMS and anything else running on the server.
* ccpupq - client CPU microseconds /insert. Similar to cpupq but only counts the CPU consumed by the benchmark client
* dbgb - database size in GB
* vsz, rss - VSZ and RSS in GB for database process, measured via *ps aux*
* maxop - max response time for an insert in milliseconds
* p50, p90 - the 50th and 90th percentile of the per-interval insert rates. Assume the test uses 10 second intervals and
and ran for 10,000 seconds. Then there will be 1000 intervals and an average insert rate per interval. The rates are sorted
and then p50 and p90 are the rates at the 50th and 90th percentile.
* tag - name of the configuration tested. This names the DBMS, storage engine and configuration options that are 
  explained elsewhere. In the example, **50m.in57.c8b**, the load step inserted 50M rows, in57 is InnoDB from MySQL 5.7
  and c8b is the configuraton file (my.cnf).

# Run

The legend [from Load](master#load) applies here but I explain where it differs. The load step is insert-only, the run step
is read-write.

Legend:
* ips - inserts/second. The run step uses a rate-limited writer and ips should be close to that rate limit. But in some
        cases the rate limit is too high or the DBMS is too slow and ips is less than the limit.
* qps - queries/second. Each query is a short range scan. Queries are not rate-limited.
* rpq - storage read /query computed from rps/qps
* rkbpq, wkbpq - storage read and write KB /query computed as rkbps/qps and wkbps/qps.
* cspq, context switches /query
* cpupq, ccpupq - total and client CPU microseconds /query
* maxop - max response time for a query in milliseconds
* p50, p90 - the 50th and 90th percentile of the per-interval query rates.

```
ips     qps     rps     rkbps   wkbps   rpq     rkbpq   wkbpq   csps    cpups   cspq    cpupq   ccpupq  dbgb    vsz     rss     maxop   p50     p90     tag
794     25535   0       0       1492    0.000   0.000   0.058   99442   43.1    3.894   270     16      16      37.6    33.1    0.015   3181    3002    rx56.c5b40
```

# Scan

The insert benchmark has a primary key index and 3 secondary indexes per table. There are 5 scans: PK, one for each of the
secondary indexes and then the PK again. The scan step is done immediately after the load step and page writeback (or LSM
compaction) can be in progress during the scan. That is most likely to happen during the first PK scan, so it is repeated
after the secondary index scans.

Legend:
* secs - number of seconds for the index scan. Rounded to nearest int.
* mrps - millions of row read /second
* rps - storage reads /second per iostat
* rmbps, wmbps - storage read MB and write MB /second per iostat
* rpo - storage reads / index entry scanned
* rkbpo - storage KB read / index entry scanned
* csps, cpups - same as above
* cspo - context switches / index entry scanned
* Mcpupo - CPU overhead / index entry scanned. Similar to mcpupq above, multiplied by 1M, based on vmstat us+sy.
* tag - same as above

```
secs	mrps	rps	rmbps	wmbps	rpo	rkbpo	csps	cpups	cspo	Mcpupo	tag
11	4.545	0	0.0	5.9	0.000	0.000	1410	5.5	0.000	1.320	50m.in57.c8b
```
