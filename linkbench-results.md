# Overview

This describes the formatted results extracted from the Linkbench benchmark output.
The results are extracted by helper scripts as the benchmark client generates a lot of data.
The helper scripts also run vmstat, iostat and mstat to collect hardware metrics that are used to compute HW efficiency metrics. 
The scripts generate one line of text per test step and I currently use several test steps - load, index, run, run, ...
The load step is insert only on tables that only have PK indexes.
The index step creates an index on the Link table.
The run step does short-running transactions.

Helper scripts that run the benchmark generate many output files so filenames are encoded to make it easy for me to find results.
The files I describe here include:
* l.pre.eff.op - *l.pre* means *load* and *eff.op* means per-operation efficiency metrics like CPU and IO per insert
* l.pre.eff.sec - *l.pre* means *load* and *eff.sec* means per-second efficiency metrics CPU utilization and MB read/second from storage
* l.post.eff.op - *l.post* means *index* and *eff.op* means per-operation efficiency metrics like CPU or IO per indexed row
* l.post.eff.sec - *l.post* means *index* and *eff.sec* means per-second efficiency metrics like CPU utilization and MB read/second from storage
* l.rt - *l* means *load* and *rt* means response time for the multi-row inserts during the load

# Load

*l.pre.eff.op* has per-operation efficiency metrics for the load
```
ips     secs    rpi     rkbpi   wkbpi   cspi    cpupi   csecpq  dsecpq  csec    dsec    dbgb    cnf
30248   25147   0.000   0.000   0.522   0.1     865     8.7     21.0    15954   15954   188.7   my56.c5
45282   16798   0.000   0.000   0.601   0.1     611     5.0     19.6    14901   14901   243.5   my57.c5
```

Legend:
* ips - inserts/second
* secs - duration of test step in seconds
* rpi - storage reads /insert
* rkbpi, wkbpi - storage read KB and write KB /insert
* cspi - context switches /insert
* cpupi - CPU/insert computed from (cpups/ips)\*1M.
  cpupq is multiplied by 1,000,000 so I can display the value as an integer. When this value
  is 2X larger for DBMS A than for DBMS B, then DBMS A uses 2X more CPU/insert. This value can only be compared for tests
  on servers with the same number of CPUs, because it is based on utilization (vmstat sy and us) not on CPU seconds.
* csecpq, dsecpq - CPU seconds /insert for the bench mark client (csecpq) and DBMS process (dsecpq). Note that dsecpq
  and dsec is bogus for Postgres (my scripts assume a long-lived process).
* csec, dsec - CPU seconds for the benchmark client (csec) and DBMS process (dsec). See prior point for dsec and Postgres.
* dbgb - database size in GB
* cnf - the DBMS and configuration

*l.pre.eff.sec* has per-second efficiency metrics for the load
```
ips     secs    rps     rmbps   wmbps   csps    cpups   cutil   dutil   cnf
30248   25147   0       0       15      2512    26.2    0.262   0.634   my56.c5
```

Legend:
* ips - inserts/second
* secs - duration of test step in seconds
* rps - storage reads /second
* rmbps, wmbps - storage read and write MB /second
* csps - context switches /second
* cpups - CPU utilization, the sum of sy and us columns from vmstat
* cutil, dutil - csec/secs and dsec/dsecs
* vsz, rss - VSZ and RSS in GB for database process, measured via \*ps aux\*
* cnf - the DBMS and configuration

*l.rt* has response time metrics for the multi-row inserts (batch writes) done during the load.
```
ips     secs    n9      nx      nm      l9      lx      lm      c9      cx      cm      cnf
26272   25146   43      1419    26      77      1259    39      69      1087    35      my56.c5
39330   16798   64      1949    22      81      2190    26      73      1448    24      my57.c5
```

Legend:
* ips - inserts/second
* secs - duration of test step in seconds
* n9, nx, nm - p99, max and mean response time in milliseconds for Node inserts
* l9, lx, lm - p99, max and mean response time in milliseconds for Link inserts
* c9, cx, cm - p99, max and mean response time in milliseconds for Count inserts

Note:
* All of the rates are the average over the entire test step.
* The full test output has per-interval averages but the goal here is to condense the results for a test step to one line.
  Limiting that to one line makes it easier to compare results between different configurations and DBMS.

# Index

*l.post.eff.op* - has per-row efficiency metrics for create index
```
ips     secs    rpi     rkbpi   wkbpi   cspi    cpupi   csecpq  dsecpq  csec    dsec    dbgb    cnf
311740  2440    0.001   0.133   0.067   0.0     84      0.0     3.2     2421    2421    209.8   mo425.c5
107679  7064    0.002   0.132   0.066   0.0     239     0.0     9.3     7109    7109    219.8   mo44pre.c5
121296  6271    0.001   0.144   0.066   0.0     218     0.0     8.4     6402    6402    264.4   mo440rc0.c5
```

The legend [from Load](master#load) applies here.
During the load rows are inserted into 3 collections (Link, Node, Count) and the efficiency metrics are divided by the
number of rows inserted into all collections.
Here a secondary index is created on the Link collection and the denominator is the number of rows in the Link collection.

*l.post.eff.sec* - has per-second efficiency metrics for create index
```
ips     secs    rps     rmbps   wmbps   csps    cpups   cutil   dutil   cnf
311740  2440    448     40      21      1518    26.1    0.000   0.992   mo425.c5
107679  7064    181     14      7       1670    25.7    0.000   1.006   mo44pre.c5
121296  6271    141     17      8       1911    26.5    0.000   1.021   mo440rc0.c5
```

The legend [from Load](master#load) applies here.
