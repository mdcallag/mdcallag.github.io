# Overview

This describes the formatted results extracted from the insert benchmark output.
The results are extracted by helper scripts as the insert benchmark client generates a lot of data.
The helper scripts also run vmstat and iostat to collect hardware metrics that are used to compute HW efficiency metrics. 
The scripts generate one line of text per test step and I currently use several test steps - load, run and scan.
The load step is insert only. The run step does short range queries as fast as possible with a rate-limited writer and there are usually many run steps.
The scan step does full index scans with no writers, it is read-only. There is one scan step per index.

Below I frequently assume that writes == inserts and reads == short range queries.

# Load

Example output without vsz and rss
```
ips	qps	rps	rkbps	wkbps	rpq	rkbpq	wkbpq	csps	cpups	cspq	cpupq	dbgb	maxop	p50	p99	tag
21711	0	0.0	0	35629	0.000	0.000	1.641	8996	8.0	0.414	370	11	0.292	21435	19826	50m.in57.c8b
```

Example output with vsz and rss
```
ips     qps     rps     rkbps   wkbps   rpq     rkbpq   wkbpq   csps    cpups   cspq    cpupq   dbgb    vsz     rss     maxop   p50     p99     tag
50441   0       0.3     3       197213  0.000   0.000   3.910   18387   71.1    0.365   1409    64      25.1    23.3    0.477   8349    3050    80m.mo425.c5b
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
* cpupq - CPU/insert computed from (cpups/ips)*1M. Pretend this is named cpupi. 
  cpupq is multiplied by 1,000,000 so I can display the value as an integer. When this value
  is 2X larger for DBMS A than for DBMS B, then DBMS A uses 2X more CPU/insert. This value can only be compared for tests
  on servers with the same number of CPUs, because it is based on utilization (vmstat sy and us) not on CPU seconds.
* dbgb - database size in GB
* vsz, rss - VSZ and RSS in GB for database process, measured via *ps aux*
* maxop - max response time for an insert in milliseconds
* p50, p99 - the 50th and 99th percentile of the per-interval insert rates. Assume the test uses 10 second intervals and
and ran for 10,000 seconds. Then there will be 1000 intervals and an average insert rate per interval. The rates are sorted
and then p50 and p99 are the rates at the 50th and 99th percentile.
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
* cspq, cpupq - context switch /query and CPU/query computed from csps/qps and cpups/qps.
* maxop - max response time for a query in milliseconds
* p50, p99 - the 50th and 99th percentile of the per-interval query rates.

```
ips	qps	rps	rkbps	wkbps	rpq	rkbpq	wkbpq	csps	cpups	cspq	cpupq	dbgb	maxop	p50	p99	tag
998	3412	0.0	0	19317	0.000	0.000	5.661	18542	7.1	5.434	2084	11	0.023	3415	3354	50m.in57.c8b
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
