# Overview

Pinned:
* [Benchmarks](database-benchmarks.md)

Posts for 2020:
* [Explaining explain to understand index usage in MySQL](posts_2020/20_08_11_explain_explain.md)

Benchmark reports for 2023:
* Postgres config tuning for the insert benchmark
  * Postgres 15.3, c2-standard-30 server
    * [Cached by Postgres, 8 users, 8 tables](reports/23_05_23_ibench.c2s30.pg153.8u.1tno.cached/all.html)
    * [Cached by OS, 8 users, 8 tables](reports/23_05_23_ibench.c2s30.pg153.8u.1tno.4g/all.html)
* Postgres 16
  * at git sha 1ab763fc2
    * Beelink (server with 8 cores, 16G RAM)
      * insert benchmark
        * cached by Postgres: [1 user, 1 table](reports/23_05_04_ibench.beelink.pg16b.1u.1tno.cached/all.html), [4 users, 4 tables](reports/23_05_04_ibench.beelink.pg16b.4u.1tno.cached/all.html), [4 users, 1 table](reports/23_05_04_ibench.beelink.pg16b.4u.1tyes.cached/all.html)
        * cached by OS page cache: [1 user, 1 table](reports/23_05_04_ibench.beelink.pg16b.1u.1tno.1g/all.html), [4 users, 4 tables](reports/23_05_04_ibench.beelink.pg16b.4u.1tno.1g/all.html), [4 users, 1 table](reports/23_05_04_ibench.beelink.pg16b.4u.1tyes.1g/all.html)
      * sysbench
        * cached by Postgres: pending
        * cached by OS page cache: pending
* Compiler options, insert benchmark, small server (Beelink, 8 AMD cores, 16G RAM, NVMe SSD), May 2023
  * Cached by database
    * MyRocks
      * 1 thread & 1 table - [5.6.35](reports/23_04_17_ibench.beelink.20m.1u.1tno.cached/report.rx56.etldirs/all.html), [8.0.28](reports/23_04_17_ibench.beelink.20m.1u.1tno.cached/report.rx80.etldirs/all.html), [5.6 vs 8.0](reports/23_04_17_ibench.beelink.20m.1u.1tno.cached/report.rx.v68.etldirs/all.html)
      * 4 threads & 4 tables - [5.6.35](reports/23_04_17_ibench.beelink.20m.4u.1tno.cached/report.rx56.etldirs/all.html), [8.0.28](reports/23_04_17_ibench.beelink.20m.4u.1tno.cached/report.rx80.etldirs/all.html), [5.6 vs 8.0](reports/23_04_17_ibench.beelink.20m.4u.1tno.cached/report.rx.v68.etldirs/all.html)
      * 4 threads & 1 table - [5.6.35](reports/23_04_17_ibench.beelink.20m.4u.1tyes.cached/report.rx56.etldirs/all.html), [8.0.28](reports/23_04_17_ibench.beelink.20m.4u.1tyes.cached/report.rx80.etldirs/all.html), [5.6 vs 8.0](reports/23_04_17_ibench.beelink.20m.4u.1tyes.cached/report.rx.v68.etldirs/all.html)
    * InnoDB
      * 1 thread & 1 table - [versions 5.6, 5.7, 8.0](reports/23_05_16_ibench.beelink.in678.1u.1tno.cached/all.html), [versions 8.0.2x, 8.0.3x](reports/23_05_16_ibench.beelink.in80.1u.1tno.cached/all.html), [version 8.0.31 builds](reports/23_05_16_ibench.beelink.in8031.1u.1tno.cached/all.html)
      * 4 threads & 4 tables - [versions 5.6, 5.7, 8.0](reports/23_05_16_ibench.beelink.in678.4u.1tno.cached/all.html), [versions 8.0.2x, 8.0.3x](reports/23_05_16_ibench.beelink.in80.4u.1tno.cached/all.html), [version 8.0.31 builds](reports/23_05_16_ibench.beelink.in8031.4u.1tno.cached/all.html)
      * 4 threads & 1 table - [versions 5.6, 5.7, 8.0](reports/23_05_16_ibench.beelink.in678.4u.1tyes.cached/all.html), [versions 8.0.2x, 8.0.3x](reports/23_05_16_ibench.beelink.in80.4u.1tyes.cached/all.html), [version 8.0.31 builds](reports/23_05_16_ibench.beelink.in8031.4u.1tyes.cached/all.html)
    * Postgres
      * 1 thread & 1 table - [Version 15.1 builds](reports/23_05_04_ibench.beelink.pg151.1u.1tno.cached/all.html), [Versions 11 to 15](reports/23_05_04_ibench.beelink.pgall.1u.1tno.cached/all.html)
      * 4 threads & 4 tables - [Version 15.1 builds](reports/23_05_04_ibench.beelink.pg151.4u.1tno.cached/all.html), [Versions 11 to 15](reports/23_05_04_ibench.beelink.pgall.4u.1tno.cached/all.html)
      * 4 threads & 1 table - [Version 15.1 builds](reports/23_05_04_ibench.beelink.pg151.4u.1tyes.cached/all.html), [Versions 11 to 15](reports/23_05_04_ibench.beelink.pgall.4u.1tyes.cached/all.html)
  * Cached by OS
    * MyRocks
      * 1 thread & 1 table - [5.6.35](reports/23_04_17_ibench.beelink.20m.1u.1tno.1g/report.rx56.etldirs/all.html), [8.0.28](reports/23_04_17_ibench.beelink.20m.1u.1tno.1g/report.rx80.etldirs/all.html), [5.6 vs 8.0](reports/23_04_17_ibench.beelink.20m.1u.1tno.1g/report.rx.v68.etldirs/all.html)
      * 4 threads & 4 tables - [5.6.35](reports/23_04_17_ibench.beelink.20m.4u.1tno.1g/report.rx56.etldirs/all.html), [8.0.28](reports/23_04_17_ibench.beelink.20m.4u.1tno.1g/report.rx80.etldirs/all.html), [5.6 vs 8.0](reports/23_04_17_ibench.beelink.20m.4u.1tno.1g/report.rx.v68.etldirs/all.html)
      * 4 threads & 1 table - [5.6.35](reports/23_04_17_ibench.beelink.20m.4u.1tyes.1g/report.rx56.etldirs/all.html), [8.0.28](reports/23_04_17_ibench.beelink.20m.4u.1tyes.1g/report.rx80.etldirs/all.html), [5.6 vs 8.0](reports/23_04_17_ibench.beelink.20m.4u.1tyes.1g/report.rx.v68.etldirs/all.html)
    * InnoDB
      * 1 thread & 1 table - [versions 5.6, 5.7, 8.0](reports/23_05_16_ibench.beelink.in678.1u.1tno.1g/all.html), [versions 8.0.2x, 8.0.3x](reports/23_05_16_ibench.beelink.in80.1u.1tno.1g/all.html), [version 8.0.31 builds](reports/23_05_16_ibench.beelink.in8031.1u.1tno.1g/all.html)
      * 4 threads & 4 tables -
[versions 5.6, 5.7, 8.0](reports/23_05_16_ibench.beelink.in678.4u.1tno.1g/all.html), [versions 8.0.2x, 8.0.3x](reports/23_05_16_ibench.beelink.in80.4u.1tno.1g/all.html), [version 8.0.31 builds](reports/23_05_16_ibench.beelink.in8031.4u.1tno.1g/all.html)
      * 4 threads & 1 table - [versions 5.6, 5.7, 8.0](reports/23_05_16_ibench.beelink.in678.4u.1tyes.1g/all.html), [versions 8.0.2x, 8.0.3x](reports/23_05_16_ibench.beelink.in80.4u.1tyes.1g/all.html), [version 8.0.31 builds](reports/23_05_16_ibench.beelink.in8031.4u.1tyes.1g/all.html)
    * Postgres
      * 1 thread & 1 table - [Version 15.1 builds](reports/23_05_04_ibench.beelink.pg151.1u.1tno.1g/all.html), [Versions 11 to 15](reports/23_05_04_ibench.beelink.pgall.1u.1tno.1g/all.html)
      * 4 threads & 4 tables - [Version 15.1 builds](reports/23_05_04_ibench.beelink.pg151.4u.1tno.1g/all.html), [Versions 11 to 15](reports/23_05_04_ibench.beelink.pgall.4u.1tno.1g/all.html)
      * 4 threads & 1 table - [Version 15.1 builds](reports/23_05_04_ibench.beelink.pg151.4u.1tyes.1g/all.html), [Versions 11 to 15](reports/23_05_04_ibench.beelink.pgall.4u.1tyes.1g/all.html)
* Compiler options, insert benchmark, big server (c2-standard-60, 30 cores, hyperthreads disabled, 240G RAM), May 2023
  * Cached by database
    * MyRocks
      * 20 threads & 20 tables - [5.6.35](reports/23_04_17_ibench.c2.400m.1tno.cached/report.rx56.etldirs/all.html), [8.0.28](reports/23_04_17_ibench.c2.400m.1tno.cached/report.rx80.etldirs/all.html), [5.6 vs 8.0](reports/23_04_17_ibench.c2.400m.1tno.cached/report.rx.v68.etldirs/all.html)
      * 20 threads & 1 table - [5.6.35](reports/23_04_17_ibench.c2.400m.1tyes.cached/report.rx56.etldirs/all.html), [8.0.28](reports/23_04_17_ibench.c2.400m.1tyes.cached/report.rx80.etldirs/all.html), [5.6 vs 8.0](reports/23_04_17_ibench.c2.400m.1tyes.cached/report.rx.v68.etldirs/all.html)
    * InnoDB
      * 20 threads & 20 tables - [versions 5.6, 5.7, 8.0](reports/23_05_08_ibench.c2.myall.20u.1tno.cached/all.html), [versions 8.0.22, 8.0.28, 8.0.31, 8.0.32](reports/23_05_08_ibench.c2.my8.20u.1tno.cached/all.html), [8.0.31 builds](reports/23_05_08_ibench.c2.my8031.20u.1tno.cached/all.html)
      * 20 threads & 1 table - [versions 5.6, 5.7, 8.0](reports/23_05_08_ibench.c2.myall.20u.1tyes.cached/all.html), [versions 8.0.22, 8.0.28, 8.0.31, 8.0.32](reports/23_05_08_ibench.c2.my8.20u.1tyes.cached/all.html), [8.0.32 builds](reports/23_05_08_ibench.c2.my8031.20u.1tyes.cached/all.html)
    * Postgres
      * 20 threads & 20 tables - [Version 15.1 builds](reports/23_05_04_ibench.c2.pg151.20u.1tno.cached/all.html), [Versions 11 to 15](reports/23_05_04_ibench.c2.pgall.20u.1tno.cached/all.html)
      * 20 threads & 1 table - [Version 15.1 builds](reports/23_05_04_ibench.c2.pg151.20u.1tyes.cached/all.html), [Versions 11 to 15](reports/23_05_04_ibench.c2.pgall.20u.1tyes.cached/all.html)
  * Cached by OS
    * MyRocks
      * 20 threads & 20 tables - [5.6.35](reports/23_04_17_ibench.c2.400m.1tno.4g/report.rx56.etldirs/all.html), [8.0.28](reports/23_04_17_ibench.c2.400m.1tno.4g/report.rx80.etldirs/all.html), [5.6 vs 8.0](reports/23_04_17_ibench.c2.400m.1tno.4g/report.rx.v68.etldirs/all.html)
      * 20 threads & 1 table - [5.6.35](reports/23_04_17_ibench.c2.400m.1tyes.4g/report.rx56.etldirs/all.html), [8.0.28](reports/23_04_17_ibench.c2.400m.1tyes.4g/report.rx80.etldirs/all.html), [5.6 vs 8.0](reports/23_04_17_ibench.c2.400m.1tyes.4g/report.rx.v68.etldirs/all.html)
    * InnoDB
      * 20 threads & 20 tables - [versions 5.6, 5.7, 8.0](reports/23_05_08_ibench.c2.myall.20u.1tno.4g/all.html), [versions 8.0.22, 8.0.28, 8.0.31, 8.0.32](reports/23_05_08_ibench.c2.my8.20u.1tno.4g/all.html), [8.0.31 builds](reports/23_05_08_ibench.c2.my8031.20u.1tno.4g/all.html)
      * 20 threads & 1 table - [versions 5.6, 5.7, 8.0](reports/23_05_08_ibench.c2.myall.20u.1tyes.4g/all.html), [versions 8.0.22, 8.0.28, 8.0.31, 8.0.32](reports/23_05_08_ibench.c2.my8.20u.1tyes.4g/all.html)
    * Postgres
      * 20 threads & 20 tables - [Version 15.1 builds](reports/23_05_04_ibench.c2.pg151.20u.1tno.4g/all.html), [Versions 11 to 15](reports/23_05_04_ibench.c2.pgall.20u.1tno.4g/all.html)
      * 20 threads & 1 table - [Version 15.1 builds](reports/23_05_04_ibench.c2.pg151.20u.1tyes.4g/all.html), [Versions 11 to 15](reports/23_05_04_ibench.c2.pgall.20u.1tyes.4g/all.html)
* Compiler options, sysbench, small server ([Beelink](http://smalldatum.blogspot.com/2022/10/small-servers-for-performance-testing-v4.html), 8-core AMD, 16G RAM)
  * MyRocks
    * One thread, one table: [5.6.35](reports/23_03_14_ibench.20m.rx56.beelink.1u.1t/all.html), [8.0.28](reports/23_03_14_ibench.20m.rx80.beelink.1u.1t/all.html), [5.6 vs 8.0](reports/23_03_14_ibench.20m.rx56v80.beelink.1u.1t/all.html)
    * Four threads, four tables: [5.6.35](reports/23_03_14_ibench.20m.rx56.beelink.4u.4t/all.html), [8.0.28](reports/23_03_14_ibench.20m.rx80.beelink.4u.4t/all.html), [5.6 vs 8.0](reports/23_03_14_ibench.20m.rx56v80.beelink.4u.4t/all.html)
    * Four threads, one table: [5.6.35](reports/23_03_14_ibench.20m.rx56.beelink.4u.1t/all.html), [8.0.28](reports/23_03_14_ibench.20m.rx80.beelink.4u.1t/all.html), [5.6 vs 8.0](reports/23_03_14_ibench.20m.rx56v80.beelink.4u.1t/all.html)
* Insert benchmark on Intel NUC to show the benefit from the insert buffer
  * [1 client, 500M rows, IO-bound](reports/23_02_08_ibench.500m.ibuf.nuc/all.html)

Benchmark reports for 2022:
* Insert Benchmark on c2-standard-60 (GCP, 30 cores, 240G RAM), Postgres
  * Cached by Postgres, 20 clients, table per client for versions [11.19](reports/23_04_10_ibench.400m.pg11.c2s60.20u.1tno.cached/all.html), [12.14](reports/23_04_10_ibench.400m.pg12.c2s60.20u.1tno.cached/all.html), [13.10](reports/23_04_10_ibench.400m.pg13.c2s60.20u.1tno.cached/all.html), [14.7](reports/23_04_10_ibench.400m.pg14.c2s60.20u.1tno.cached/all.html), [15.1](reports/23_04_10_ibench.400m.pg151.c2s60.20u.1tno.cached/all.html), [15.2](reports/23_04_10_ibench.400m.pg152.c2s60.20u.1tno.cached/all.html), [11 to 15](reports/23_04_10_ibench.400m.pgall.c2s60.20u.1tno.cached/all.html)
  * Cached by Postgres, 20 clients, only one table for versions [11.19](reports/23_04_10_ibench.400m.pg11.c2s60.20u.1tyes.cached/all.html), [12.14](reports/23_04_10_ibench.400m.pg12.c2s60.20u.1tyes.cached/all.html), [13.10](reports/23_04_10_ibench.400m.pg13.c2s60.20u.1tyes.cached/all.html), [14.7](reports/23_04_10_ibench.400m.pg14.c2s60.20u.1tyes.cached/all.html), [15.1](reports/23_04_10_ibench.400m.pg151.c2s60.20u.1tyes.cached/all.html), [15.2](reports/23_04_10_ibench.400m.pg152.c2s60.20u.1tyes.cached/all.html), [11 to 15](reports/23_04_10_ibench.400m.pgall.c2s60.20u.1tyes.cached/all.html)
  * Cached by OS page cache, 20 clients, table per client for versions [11.19](reports/23_04_10_ibench.400m.pg11.c2s60.20u.1tno.4g/all.html), [12.14](reports/23_04_10_ibench.400m.pg12.c2s60.20u.1tno.4g/all.html), [13.10](reports/23_04_10_ibench.400m.pg13.c2s60.20u.1tno.4g/all.html), [14.7](reports/23_04_10_ibench.400m.pg14.c2s60.20u.1tno.4g/all.html), [15.1](reports/23_04_10_ibench.400m.pg151.c2s60.20u.1tno.4g/all.html), [15.2](reports/23_04_10_ibench.400m.pg152.c2s60.20u.1tno.4g/all.html), [11 to 15](reports/23_04_10_ibench.400m.pgall.c2s60.20u.1tno.4g/all.html)
  * Cached by OS page cache, 20 clients, only one table for versions [11.19](reports/23_04_10_ibench.400m.pg11.c2s60.20u.1tyes.4g/all.html), [12.14](reports/23_04_10_ibench.400m.pg12.c2s60.20u.1tyes.4g/all.html), [13.10](reports/23_04_10_ibench.400m.pg13.c2s60.20u.1tyes.4g/all.html), [14.7](reports/23_04_10_ibench.400m.pg14.c2s60.20u.1tyes.4g/all.html), [15.1](reports/23_04_10_ibench.400m.pg151.c2s60.20u.1tyes.4g/all.html), [15.2](reports/23_04_10_ibench.400m.pg152.c2s60.20u.1tyes.4g/all.html), [11 to 15](reports/23_04_10_ibench.400m.pgall.c2s60.20u.1tyes.4g/all.html)
* Insert Benchmark on Beelink (AMD, 8-core, 16G RAM, NVMe)
  * Cached by DBMS, 20M rows
    * MySQL 5.6, 5.7, 8.0 with InnoDB and MyRocks: [1 client](reports/22_12_29_ibench.20m.my.beelink.1u/all.html), [2 clients](reports/22_12_29_ibench.20m.my.beelink.2u/all.html), [3 clients](reports/22_12_29_ibench.20m.my.beelink.3u/all.html), [4 clients](reports/22_12_29_ibench.20m.my.beelink.4u/all.html)
    * Postgres 12, 13, 14 and 15: [1 client](reports/22_12_29_ibench.20m.pg.beelink.1u/all.html), [2 clients](reports/22_12_29_ibench.20m.pg.beelink.2u/all.html), [3 clients](reports/22_12_29_ibench.20m.pg.beelink.3u/all.html), [4 clients](reports/22_12_29_ibench.20m.pg.beelink.4u/all.html)
  * IO-bound, 500m rows
    * MySQL 5.6, 5.7, 8.0 with InnoDB and MyRocks: [1 client](reports/22_12_29_ibench.500m.my.beelink.1u/all.html), [2 clients](reports/22_12_29_ibench.500m.my.beelink.2u/all.html), [3 clients](reports/22_12_29_ibench.500m.my.beelink.3u/all.html), [4 clients](reports/22_12_29_ibench.500m.my.beelink.4u/all.html)
    * Postgres 12, 13, 14 and 15: [1 client](reports/22_12_29_ibench.500m.pg.beelink.1u/all.html), [2 clients](reports/22_12_29_ibench.500m.pg.beelink.2u/all.html), [3 clients](reports/22_12_29_ibench.500m.pg.beelink.3u/all.html), [4 clients](reports/22_12_29_ibench.500m.pg.beelink.4u/all.html)
* Insert Benchmark on AWS c7g.2xl with io2 SSD (256G, 10K IOPs)
  * [1 client, 20M rows, cached by DBMS](reports/22_12_29_ibench.20m.all.c7g.2xl.1u/all.html)
* Insert Benchmark on AWS c6i.2xl with io2 SSD (256G, 10K IOPs)
  * [1 client, 20M rows, cached by DBMS, hyperthread disabled](reports/22_12_29_ibench.20m.all.c6i.2xl.ht0.1u/all.html)
* Insert Benchmark on AWS c7g.4xl with io2 SSD (1T, 32K IOPs)
  * [4 clients, 50M rows, cached by DBMS](reports/22_12_29_ibench.50m.all.c7g.4xl.4u/all.html)
  * [8 clients, 50M rows, cached by DBMS](reports/22_12_29_ibench.50m.all.c7g.4xl.8u/all.html)
* Insert Benchmark on AWS c6i.4xl with io2 SSD (1T, 32K IOPs)
  * [4 clients, 50M rows, cached by DBMS, hyperthread disabled](reports/22_12_29_ibench.50m.all.c6i.4xl.ht0.4u/all.html)
  * [8 clients, 50M rows, cached by DBMS, hyperthread disabled](reports/22_12_29_ibench.50m.all.c6i.4xl.ht0.8u/all.html)
* Insert Benchmark on AWS c7g.8xl with io2 SSD (2T, 64K IOPs)
  * [8 clients, 100M rows, cached by DBMS](reports/22_12_29_ibench.100m.all.c7g.8xl.8u/all.html)
  * [16 clients, 100M rows, cached by DBMS](reports/22_12_29_ibench.100m.all.c7g.8xl.16u/all.html)
* Insert Benchmark on AWS c6i.8xl with io2 SSD (2T, 64K IOPs)
  * [8 clients, 100M rows, cached by DBMS, hyperthread disabled](reports/22_12_29_ibench.100m.all.c6i.8xl.ht0.8u/all.html)
  * [16 clients, 100M rows, cached by DBMS, hyperthread disabled](reports/22_12_29_ibench.100m.all.c6i.8xl.ht0.16u/all.html)
* Insert Benchmark on AWS c7g.16xl with io2 SSD (5T, 100K IOPs)
  * [22 clients, 500M rows, cached by DBMS](reports/22_12_29_ibench.500m.all.c7g.16xl.22u/all.html)
  * [44 clients, 500M rows, cached by DBMS](reports/22_12_29_ibench.500m.all.c7g.16xl.44u/all.html)
* Insert Benchmark on AWS c6i.16xl with io2 SSD (5T, 64K IOPs)
  * [22 clients, 500M rows, cached by DBMS, hyperthread disabled](reports/22_12_29_ibench.500m.all.c6i.16xl.ht0.22u/all.html)
  * [22 clients, 500M rows, cached by DBMS, hyperthread enabled](reports/22_12_29_ibench.500m.all.c6i.16xl.ht1.22u/all.html)
  * [44 clients, 500M rows, cached by DBMS, hyperthread disabled](reports/22_12_29_ibench.500m.all.c6i.16xl.ht0.44u/all.html)
  * [44 clients, 500M rows, cached by DBMS, hyperthread enabled](reports/22_12_29_ibench.500m.all.c6i.16xl.ht1.44u/all.html)
* Insert Benchmark
  * [Intel NUC, not IO-bound, Postgres](reports/22_11_29_ibench.20m.pg/all.html)
  * [Intel NUC, IO-bound, Postgres](reports/22_11_29_ibench.500m.pg/all.html)
  * [Intel NUC, not IO-bound, InnoDB](reports/22_11_29_ibench.20m.in/all.html)
  * [Intel NUC, IO-bound, InnoDB](reports/22_11_29_ibench.500m.in/all.html)
  * [Intel NUC, not IO-bound, MyRocks](reports/22_11_29_ibench.20m.rx/all.html)
  * [Intel NUC, IO-bound, MyRocks](reports/22_11_29_ibench.500m.rx/all.html)
* Insert Benchmark to test wal_compression in Postgres 15
  * [Intel NUC, IO-bound](reports/22_05_26_pgwalcomp.500m.nuc.etldirs/all.html)
  * [Intel NUC, not IO-bound](reports/22_05_26_pgwalcomp.20m.nuc.etldirs/all.html)
* Insert Benchmark for Postgres 12.11, 13.7, 14.3 and 15beta
  * [Intel NUC, IO-bound](reports/22_06_06_ibench.500m.pg.all/all.html)
  * [Intel NUC, IO-bound, uses prepared statements](reports/22_06_21_ibench.500m.pg.all/all.html)
  * [Intel NUC, IO-bound, uses prepared statements, 15b1 with patch 1](reports/22_06_23_ibench.500m.pg15b1p1/all.html)
  * [Intel NUC, IO-bound, uses prepared statements, 15b1 with patch 1, larger WAL](reports/22_06_30_ibench.500m.pg.all.v2/all.html)
  * [Intel NUC, IO-bound, uses prepared statements, larger WAL, includes 15beta](reports/22_07_02_ibench.500m.pg.all/all.html)
  * [Intel NUC, not IO-bound](reports/22_06_06_ibench.20m.pg.all/all.html)
  * [Intel NUC, not IO-bound, uses prepared statements](reports/22_06_21_ibench.20m.pg.all/all.html)
  * [Intel NUC, not IO-bound, uses prepared statements, 15b1 with patch 1](reports/22_06_23_ibench.20m.pg15b1p1/all.html)
  * [Intel NUC, not IO-bound, uses prepared statements, 15b1 with patch 1, larger WAL](reports/22_06_30_ibench.20m.pg.all.v2/all.html)
  * [Intel NUC, IO-bound, uses prepared statements, larger WAL, includes 15beta](reports/22_07_02_ibench.20m.pg.all/all.html)
* Insert Benchmark for Postgres 14.0, 14.1, 14.2, 14.3
  * [Intel NUC, IO-bound](reports/22_06_06_ibench.500m.pg.v14/all.html)
  * [Intel NUC, not IO-bound](reports/22_06_06_ibench.20m.pg.v14/all.html)

Benchmark reports for 2021:
* November
  * Insert benchmark, Intel NUC, 1 user, 20M rows (in memory)
    * [InnoDB in MySQL 5.6, 5.7 and 8.0](reports/21_11_30_report.x.20m.my.etldirs/all.html)
    * [Postgres 12.4, 13.4 and 14.0](reports/21_11_30_report.x.20m.pg.etldirs/all.html)
    * [MyRocks 5.6.35 and 8.0.20](reports/21_11_30_report.x.20m.fbmy.etldirs/all.html)
  * Insert benchmark, Intel NUC, 1 user, 500M rows (IO-bound)
    * [InnoDB in MySQL 5.6, 5.7 and 8.0](reports/21_11_30_report.x.500m.my.etldirs/all.html)
    * [Postgres 12.4, 13.4 and 14.0](reports/21_11_30_report.x.500m.pg.etldirs/all.html)
    * [MyRocks 5.6.35 and 8.0.20](reports/21_11_30_report.x.500m.fbmy.etldirs/all.html)
* January, Intel NUC
  * [Insert benchmark, 20M rows, 1 user, NUC server](reports/21_01_21_ibench_20m/all.html)
  * [Insert benchmark, 100M rows, 1 user, NUC server](reports/21_01_21_ibench_100m/all.html)
  * [Insert benchmark, 500M rows, 1 user, NUC server](reports/21_01_21_ibench_500m/all.html)

Benchmark reports for 2020:
* Insert benchmark tests with a table per user
  * [CPU-bound, 15m rows, 1 user](reports/20_09_11_ibench_1u_15m/all.html)
  * [CPU-bound, 40m rows, 8 user](reports/20_09_11_ibench_8u_40m/all.html)
  * [IO-bound 800m rows, 8 users](reports/20_09_11_ibench_8u_800m/all.html)
  * [IO-bound 2000m rows, 8 users](reports/20_09_11_ibench_8u_2000m/all.html)
* Insert benchmark tests with 1 table shared by all users
  * [CPU-bound, 40m rows, 8 user](reports/20_09_11_ibench_1t_8u_40m/all.html)
  * [IO-bound 800m rows, 8 users](reports/20_09_11_ibench_1t_8u_800m/all.html)
  * [IO-bound 2000m rows, 8 users](reports/20_09_11_ibench_1t_8u_2000m/all.html)
* Linkbench
  * [CPU-bound, maxid1=10m, 8 users](reports/20_09_11_linkb_10m_inno/all.html)
  * [IO-bound, maxid1=200m, 8 users](reports/20_09_11_linkb_200m_inno/all.html)
  * [IO-bound, maxid1=500m, 8 users](reports/20_09_11_linkb_500m_inno/all.html)
* Insert benchmark on [NUC](http://smalldatum.blogspot.com/2018/12/new-small-servers-for-performance.html) to determine the best configuration
  * CPU-bound, 20m rows for [InnoDB](reports/20_12_01_ibench_nuc/in.8021/20m/all.html), [MyRocks](reports/20_12_01_ibench_nuc/rx.5635/20m/all.html) and [Postgres](reports/20_12_01_ibench_nuc/pg.123/20m/all.html)
  * Less IO-bound, 100m rows for [InnoDB](reports/20_12_01_ibench_nuc/in.8021/100m/all.html), [MyRocks](reports/20_12_01_ibench_nuc/rx.5635/100m/all.html) and [Postgres](reports/20_12_01_ibench_nuc/pg.123/100m/all.html)
  * More IO-bound, 500m rows for [InnoDB](reports/20_12_01_ibench_nuc/in.8021/500m/all.html), [MyRocks](reports/20_12_01_ibench_nuc/rx.5635/500m/all.html) and [Postgres](reports/20_12_01_ibench_nuc/pg.123/500m/all.html)

