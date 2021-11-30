# Overview

Pinned:
* [Benchmarks](database-benchmarks.md)

Posts for 2020:
* [Explaining explain to understand index usage in MySQL](posts_2020/20_08_11_explain_explain.md)

Benchmark reports for 2021:
* November
  * Insert benchmark, Intel NUC, 1 user, 20M rows (in memory)
    * [InnoDB in MySQL 5.6, 5.7 and 8.0](reports/21_11_30_report.x.20m.my.etldirs/all.html)
    * [Postgres 12.4, 13.4 and 14.0](reports/21_11_30_report.x.20m.pg.etldirs/all.html)
  * Insert benchmark, Intel NUC, 1 user, 500M rows (IO-bound)
    * [InnoDB in MySQL 5.6, 5.7 and 8.0](reports/21_11_30_report.x.500m.my.etldirs/all.html)
    * [Postgres 12.4, 13.4 and 14.0](reports/21_11_30_report.x.500m.pg.etldirs/all.html)
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

