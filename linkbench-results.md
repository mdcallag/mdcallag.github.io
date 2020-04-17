# Overview 
This describes the formatted results extracted from the Linkbench benchmark output.
The results are extracted by helper scripts as the benchmark client generates a lot of data.
The helper scripts also run vmstat, iostat and mstat to collect hardware metrics that are used to compute HW efficiency metrics. 
The scripts generate one line of text per test step and I currently use several test steps - load, index, run, run, ...
The load step is insert only on tables that only have PK indexes.
The index step creates an index on the Link table.
The run step does short-running transactions.
Helper scripts that run the benchmark generate many output files so filenames are encoded to make it easy for me to find results.
The load and index files I describe here include:
* **l.pre.eff.op** - **l.pre** means **load** and **eff.op** means per-operation efficiency metrics like CPU and IO per insert
* **l.pre.eff.sec** - **l.pre** means **load** and **eff.sec** means per-second efficiency metrics CPU utilization and MB read/second from storage
* **l.post.eff.op** - **l.post** means **index** and **eff.op** means per-operation efficiency metrics like CPU or IO per indexed row
* **l.post.eff.sec** - **l.post** means **index** and **eff.sec** means per-second efficiency metrics like CPU utilization and MB read/second from storage
* **l.rt** - **l** means **load** and **rt** means response time for the multi-row inserts during the load

Then there are files per run step. I usually do a sequence of 1-hour run steps to see how performance and efficiency change over time.
My helper scripts tag each run using its position in the sequence and the number of concurrent clients.
If there were 6 run steps each each used 16 concurrent clients then the tags would be L1.P16, L2.P16, L3.P16, L4.P16, L5.P16 and L6.P16.
The examples below are from the tag L6.P16:
* **r.eff.op.L6.P16** - **r** means a run step, **eff.op** means per-operation efficiency metrics, **L6.P16** is a tag described above
* **r.eff.sec.L6.P16** - **r** means a run step, **eff.sec** means per-second efficiency metrics, **L6.P16** is a tag described above
* **r.rt.node.L6.P16** - **r** means a run step, **rt.node** means response time for operations on the Node collection, **L6.P16** is a tag described above
* **r.rt.link.L6.P16** - **r** means a run step, **rt.link** means response time for operations on the Link and Count collections, **L6.P16** is a tag described above

# Load

## Per operation

**l.pre.eff.op** has per-operation efficiency metrics for the load. Performance data is collected from vmstat, iostat and elsewhere and then normalized (divided by) the workload rate. Here the workload rate is the number of inserts/second.

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

## Per second

**l.pre.eff.sec** has per-second efficiency metrics for the load. This shows performance data as rates (per second). Much of the data is from vmstat and iostat.

```
ips     secs    rps     rmbps   wmbps   csps    cpups   cutil   dutil   vsz     rss     cnf
30248   25147   0       0       15      2512    26.2    0.262   0.634   13.0    11.3    my56.c5
45282   16798   0       0       27      4095    27.7    0.228   0.887   14.1    12.4    my56.c5
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

## Response time

**l.rt** has response time metrics for the multi-row inserts (batch writes) done during the load.
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

## Per operation

**l.post.eff.op** - has per-row efficiency metrics for create index. Performance data is collected from vmstat, iostat and elsewhere and then normalized (divided by) the workload rate. Here the workload rate is the number of indexed rows/second.
```
ips     secs    rpi     rkbpi   wkbpi   cspi    cpupi   csecpq  dsecpq  csec    dsec    dbgb    cnf
311740  2440    0.001   0.133   0.067   0.0     84      0.0     3.2     2421    2421    209.8   my56.c6
107679  7064    0.002   0.132   0.066   0.0     239     0.0     9.3     7109    7109    219.8   my80.c1
```

The legend [from Load](https://github.com/mdcallag/mdcallag.github.io/blob/master/linkbench-results.md#per-operation) applies here although the **i** in columns above means per-indexed rather than per-inserted row.

During the load rows are inserted into 3 collections (Link, Node, Count) and the efficiency metrics are divided by the
number of rows inserted into all collections.
Here a secondary index is created on the Link collection and the denominator is the number of rows in the Link collection.

## Per second

**l.post.eff.sec** - has per-second efficiency metrics for create index.  This shows performance data as rates (per second). Much of the data is from vmstat and iostat.
```
ips     secs    rps     rmbps   wmbps   csps    cpups   cutil   dutil   vsz     rss     cnf
311740  2440    448     40      21      1518    26.1    0.000   0.992   13.9    12.0    my40.c2
121296  6271    141     17      8       1911    26.5    0.000   1.021   17.2    14.7    pg12.c0
```

The legend [from Load](https://github.com/mdcallag/mdcallag.github.io/blob/master/linkbench-results.md#per-second) applies here.

# Run

z3.r.eff.op.L6.P16
```
qps     secs    rpq     rkbpq   wkbpq   cspq    cpupq   csecpq  dsecpq  csec    dsec    dbgb    cnf
12379   3600    0.195   1.638   2.132   8.2     3697    160.1   0.0     7134    0       34.0    pg12.c7b20s1
10665   3600    0.010   0.087   1.132   5.6     7283    747.0   426.6   28680   16379   19.4    rx56.c5b20s1
10719   3600    0.007   0.059   1.122   5.6     7280    737.0   435.3   28439   16796   14.3    rx56.c6b20s1
10488   3601    0.007   0.060   3.787   7.4     6566    712.1   367.3   26896   13873   30.9    in80.c9b20s1
```

z3.r.eff.sec.L6.P16
```
qps     secs    rps     rmbps   wmbps   csps    cpups   cutil   dutil   vsz     rss     cnf
12379   3600    2416    20      26      101891  45.8    1.982   0.000   0.1     0.0     pg12.c7b20s1
10665   3600    104     1       12      59991   77.7    7.967   4.550   28.5    21.9    rx56.c5b20s1
10719   3600    74      1       12      60320   78.0    7.900   4.666   29.2    21.8    rx56.c6b20s1
10488   3601    72      1       39      77527   68.9    7.469   3.853   25.0    23.1    in80.c9b20s1
```

z4.r.rt.node.L6.P16
```
an9     anx     anm     un9     unx     unm     dn9     dnx     dnm     gn9     gnx     gnm     cnf
9       233.1   2.904   10      261.4   2.803   10      162.4   2.784   4       235.1   0.289   pg12.c7b20s1
14      415.2   1.978   14      373.0   1.903   14      400.0   1.882   2       310.5   0.259   rx56.c5b20s1
14      317.1   1.956   14      344.5   1.875   14      297.7   1.853   2       266.1   0.258   rx56.c6b20s1
13      446.6   3.177   13      446.4   3.036   13      447.3   2.987   0.8     261.0   0.235   in80.c9b20s1
```

z4.r.rt.link.L6.P16
```
al9     alx     alm     dl9     dlx     dlm     ul9     ulx     ulm     cl9     clx     clm     mg9     mgx     mgm     gll9    gllx    gllm    cnf
12      261.4   3.854   12      190.9   3.364   11      255.6   3.797   5       233.2   0.408   4       226.7   0.407   25      633.1   2.234   pg12.c7b20s1
15      414.9   2.358   15      375.3   2.217   15      415.8   2.474   2       96.3    0.253   4       300.6   0.417   68      334.6   4.159   rx56.c5b20s1
15      344.2   2.318   15      344.8   2.187   15      344.0   2.436   2       145.4   0.251   4       267.8   0.415   68      322.2   4.156   rx56.c6b20s1
14      448.5   3.644   14      231.2   3.219   14      448.0   3.729   3       238.2   0.266   3       167.8   0.379   58      581.7   3.417   in80.c9b20s1
```

