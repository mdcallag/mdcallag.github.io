# Overview

Pinned:
* [Benchmarks](database-benchmarks.md)

Posts for 2020:
* [Explaining explain to understand index usage in MySQL](posts_2020/20_08_11_explain_explain.md)

Posts for 2023:
* [Chasing down a CPU regression for MyRocks using flamegraphs](posts_2023/sep23.ibench.56builds.u.md)

Benchmark reports for 2024
* Insert Benchmark
  * Small server
    * Postgres, Beelink 16G RAM (SER4), Jan24: [cached](reports/24_01_01.1u.1tno.bee.cached.pg/all.html)
    * Postgres, Beelink 16G RAM (SER4), Jan24, v2: [cached](reports/24_01_10.1u.1tno.bee.cached.pg/all.html)
    * Postgres, Beelink 16G RAM (SER4), Jan24, v3: [cached](reports/24_01_24.8u.1tno.mem.bee.pg/all.html)
    * Postgres, Beelink 16G RAM (SER4), Jan24: [IO-bound](reports/24_01_27.1u.1tno.io.bee.pg/all.html)
    * Postgres, Beelink 16G RAM (SER4), Feb24: [cached](reports/24_02_12.1u.1tno.mem.bee.pg/all.html)
    * Postgres, Beelink 16G RAM (SER4), Feb24: [IO-bound](reports/24_02_12.1u.1tno.io.bee.pg/all.html)
    * Postgres, Beelink 16G RAM (SER4), Mar24, tuning v16: [cached](reports/24_03_17.1u.1tno.mem.bee.pg/all.html), [IO-bound](reports/24_03_17.1u.1tno.io.bee.pg/all.html)
    * MyRocks, Beelink 16G RAM (SER4), Jan24, v2, cached: [5.6.35](reports/24_01_12.1u.1tno.cached.bee.30m.fbmy.56/all.html), [8.0](reports/24_01_12.1u.1tno.cached.bee.30m.fbmy.80/all.html), [all](reports/24_01_12.1u.1tno.cached.bee.30m.fbmy.all/all.html), [latest](reports/24_01_12.1u.1tno.cached.bee.30m.fbmy.latest/all.html)
    * MyRocks, Beelink 16G RAM (SER4), Mar24: [cached](reports/24_03_17.1u.1tno.mem.bee.fbmy/all.html), [IO-bound](reports/24_03_17.1u.1tno.io.bee.fbmy/all.html)
    * InnoDB, Beelink 16G RAM (SER4), Jan24, cached: [5.6](reports/24_01_25.8u.1tno.mem.bee.my.56/all.html), [5.7](reports/24_01_25.8u.1tno.mem.bee.my.57/all.html), [8.0](reports/24_01_25.8u.1tno.mem.bee.my.80/all.html), [all](reports/24_01_25.8u.1tno.mem.bee.my.all/all.html)
    * InnoDB, Beelink 16G RAM (SER4), Feb24, IO-bound: [5.6](reports/24_o2_01.1u.1tno.io.bee.my.56/all.html), [5.7](reports/24_o2_01.1u.1tno.io.bee.my.57/all.html), [8.0](reports/24_o2_01.1u.1tno.io.bee.my.80/all.html), [all](reports/24_o2_01.1u.1tno.io.bee.my.all/all.html)
    * InnoDB, Beelink 16G RAM (SER4), Mar24: [cached](reports/24_03_17.1u.1tno.mem.bee.inno/all.html), [IO-bound](reports/24_03_17.1u.1tno.io.bee.inno/all.html)
    * Postgres and MySQL, Beelink 16G RAM (SER4), Mar24: [cached](reports/24_03_17.1u.1tno.mem.bee.some/all.html), [IO-bound](reports/24_03_17.1u.1tno.io.bee.some/all.html)
    * MariaDB and MySQL, Beelink 16G RAM (SER4), Apr24, cached
      * Low concurrency (1 client): [all](reports/24_04_12.1u.1tno.mem.ser7.all/all.html), [MariaDB: all](reports/24_04_12.1u.1tno.mem.ser7.ma/all.html), [MariaDB: 10.x](reports/24_04_12.1u.1tno.mem.ser7.ma10/all.html), [MariaDB: 11.4](reports/24_04_12.1u.1tno.mem.ser7.ma11/all.html), [MariaDB vs MySQL](reports/24_04_12.1u.1tno.mem.ser7.mavsmy/all.html), [MySQL](reports/24_04_12.1u.1tno.mem.ser7.my/all.html), [MariaDB: 10.4](reports/24_04_21.1u.1tno.mem.bee.ma1004/all.html)
      * Some concurrency (4 clients): [all](reports/24_04_21.4u.1tno.mem.bee.all/all.html), [MariaDB:all](reports/24_04_21.4u.1tno.mem.bee.ma/all.html), [MariaDB: 10.x](reports/24_04_21.4u.1tno.mem.bee.ma10/all.html), [MariaDB: 11.x](reports/24_04_21.4u.1tno.mem.bee.ma11/all.html), [MariaDB vs MYSQL](reports/24_04_21.4u.1tno.mem.bee.mavsmy/all.html), [MySQL](reports/24_04_21.4u.1tno.mem.bee.my/all.html), [MariaDB: 10.4](reports/24_04_21.4u.1tno.mem.bee.ma1004/all.html)
    * MariaDB and MySQL, Beelink 16G RAM (SER4), May24, IO-bound
      * 1 client: [all](reports/24_05_15.ib.1u.1tno.io.amd3.all/all.html), [MariaDB](reports/24_05_15.ib.1u.1tno.io.amd3.ma/all.html), [MariaDB 10.x](reports/24_05_15.ib.1u.1tno.io.amd3.ma10/all.html), [MariaDB 11.x](reports/24_05_15.ib.1u.1tno.io.amd3.ma11/all.html), [MariaDB vs MySQL](reports/24_05_15.ib.1u.1tno.io.amd3.mavsmy/all.html), [MySQL](reports/24_05_15.ib.1u.1tno.io.amd3.my/all.html)
      * 4 clients: [all](reports/24_05_15.ib.4u.1tno.io.amd3.all/all.html), [MariaDB](reports/24_05_15.ib.4u.1tno.io.amd3.ma/all.html), [MariaDB 10.x](reports/24_05_15.ib.4u.1tno.io.amd3.ma10/all.html), [MariaDB 11.x](reports/24_05_15.ib.4u.1tno.io.amd3.ma11/all.html), [MariaDB vs MySQL](reports/24_05_15.ib.4u.1tno.io.amd3.mavsmy/all.html), [MySQL](reports/24_05_15.ib.4u.1tno.io.amd3.my/all.html)
    * Postgres, Beelink 32G RAM (SER7), Jan24: [cached](reports/24_01_01.1u.1tno.ser7.cached.pg/all.html)
    * Postgres, Beelink 32G RAM (SER7), Feb24: [cached](reports/24_02_12.1u.1tno.io.ser7.pg/all.html)
    * Postgres, Beelink 32G RAM (SER7), Feb24: [IO-bound](reports/24_02_12.1u.1tno.mem.ser7.pg/all.html)
    * Postgres, Beelink 32G RAM (SER7), Mar24: [cached](reports/24_03_18.1u.1tno.mem.ser7.pg/all.html), [IO-bound](reports/24_03_18.1u.1tno.io.ser7.pg/all.html)
    * MyRocks, Beelink 32G RAM (SER7), cached, Jan24: [5.6.35](reports/24_01_01.1u.1tno.bee.cached.fbmy56/all.html), [8.0.28](reports/24_01_01.1u.1tno.bee.cached.fbmy8028/all.html), [8.0.32](reports/24_01_01.1u.1tno.bee.cached.fbmy8032/all.html), [8.0](reports/24_01_01.1u.1tno.bee.cached.fbmy80/all.html), [all](reports/24_01_01.1u.1tno.bee.cached.fbmyall/all.html)
    * MyRocks, Beelink 32G RAM (SER7), cached, Jan24, v2: [5.6.35](reports/24_01_11.1u.1tno.cached.ser7.fbmy.56/all.html), [8.0](reports/24_01_11.1u.1tno.cached.ser7.fbmy.80/all.html), [all](reports/24_01_11.1u.1tno.cached.ser7.fbmy.all/all.html), [latest](reports/24_01_11.1u.1tno.cached.ser7.fbmy.latest/all.html)
    * MariaDB and MySQL, PN53, cached, May24:
      * 1 user: [all](reports/24_05_14.1u.1tno.mem.pn53.all/all.html), [MariaDB, 1 purge_thread](reports/24_05_14.1u.1tno.mem.pn53.map1/all.html), [MariaDB, 4 purge threads](reports/24_05_14.1u.1tno.mem.pn53.map4/all.html), [MySQL](reports/24_05_14.1u.1tno.mem.pn53.my/all.html), [MariaDB vs MySQL, 1 purge thread](reports/24_05_14.1u.1tno.mem.pn53.map1vsmy/all.html), [MariaDB vs MySQL, 4 purge threads](reports/24_05_14.1u.1tno.mem.pn53.map4vsmy/all.html)
      * 4 users: [all](reports/24_05_14.4u.1tno.mem.pn53.all/all.html), [MariaDB, 1 purge thread](reports/24_05_14.4u.1tno.mem.pn53.map1/all.html), [MariaDB, 4 purge threads](reports/24_05_14.4u.1tno.mem.pn53.map4/all.html), [MySQL](reports/24_05_14.4u.1tno.mem.pn53.my/all.html), [MariaDB vs MySQL, 1 purge thread](reports/24_05_14.4u.1tno.mem.pn53.map1vsmy/all.html), [MariaDB vs MySQL, 4 purge threads](reports/24_05_14.4u.1tno.mem.pn53.map4vsmy/all.html)
    * Postgres 17beta1, PN53, May34:
      * cached: [1 user](reports/24_05_27.ib.1u.1tno.mem.pn53.pg/all.html)
    * Postgres 16.3 with and without full_page_writes vs the Insert Benchmark, PN53: [cached, v1](reports/24_06_03.ib.mem.pn53.pg.nofpw/all.html), [cached, v2](reports/24_06_05.ib.mem.pn53.pg.nofpw/all.html)
    * Postgres 17beta1 with patch that enforces VISITED_PAGES_LIMIT during get_actual_value_range calls: [cached](reports/24_06_07.ib.mem.pn53.pg.hack10/all.html)
  * Medium server (GCP, c2-standard-30)
    * MySQL, InnoDB, cached workload, Jan24: [MySQL 5.6](reports/24_01_01.8u.1tno.c2.cached.my56/all.html), [MySQL 5.7](reports/24_01_01.8u.1tno.c2.cached.my57/all.html), [MySQL 8.0](reports/24_01_01.8u.1tno.c2.cached.my80/all.html), [MySQL 5.6, 5.7 and 8.0](reports/24_01_01.8u.1tno.c2.cached.my678/all.html)
    * MyRocks, cached workload, Jan24: [5.6.35](reports/24_01_01.8u.1tno.c2.cached.fbmy56/all.html), [8.0.28, 8.0.32](reports/24_01_01.8u.1tno.c2.cached.fbmy80/all.html), [5.6.35, 8.0.28, 8.0.32 - many versions](reports/24_01_01.8u.1tno.c2.cached.fbmy_all/all.html), [5.6.35, 8.0.28, 8.0.32 - latest versions](reports/24_01_01.8u.1tno.c2.cached.fbmy_latest/all.html)
    * MyRocks, cached workload, Jan24, v2: [5.6.35](reports/24_01_11.8u.1tno.cached.fbmy56/all.html), [8.0](reports/24_01_11.8u.1tno.cached.fbmy80/all.html), [latest 5.6, 8.0](reports/24_01_11.8u.1tno.cached.fbmy.latest/all.html), [all](reports/24_01_11.8u.1tno.cached.fbmy.all/all.html)
    * MyRocks, IO-bound workload, Jan24, v2: [5.6.35](reports/24_01_17.8u.1tno.io.c2.fbmy.56/all.html), [8.0](reports/24_01_17.8u.1tno.io.c2.fbmy.80/all.html), [all](reports/24_01_17.8u.1tno.io.c2.fbmy.all/all.html), [latest](reports/24_01_17.8u.1tno.io.c2.fbmy.latest/all.html)
  * Large server (2-socket, 24-core)
    * MyRocks, cached workload, Jan24: [5.6.35, 8.0.28, 8.0.32](reports/24_01_01.12u.1tno.socket2.cached.fbmy/all.html)
    * Postgres, Feb24: [cached workload](reports/24_02_01.16u.1tno.socket2.mem.pg/all.html)
  * Large server (32-core)
    * Postgres, Jun24, up to pg17beta1: [cached](reports/24_06_10.ib.mem.dell32.pg.hack10/all.html)
  * Large server (2-socket, 20 cores/socket)
    * InnoDB, v2: [cached](reports/24_01_10.24u.1tno.cached.inno.int1.v2/all.html)

Benchmark reports for 2023
* jemalloc
  * Medium server, focus on jemalloc 5.2.1: IO-bound with [LRU block cache](reports/23_09_25.c2.ib.jemalloc521.io.c5/all.html), [Hyper Clock cache](reports/23_09_25.c2.ib.jemalloc521.io.c7/all.html)
* Postgres 16 (Sep 2023)
  * Small server, insert benchmark
    * wal_compression=lz4: [Cached by Postgres](reports/23_09_18.bee.ib.pg160.1u.1tno.cached.a1/all.html), [IO-bound](reports/23_09_18.bee.ib.pg160.1u.1tno.io.a1/all.html)
    * wal_compression=none: [Cached by Postgres](reports/23_09_18.bee.ib.pg160.1u.1tno.cached.a2/all.html), [IO-bound](reports/23_09_18.bee.ib.pg160.1u.1tno.io.a2/all.html)
  * Medium server, insert benchmark
    * wal_compression=lz4: [Cached by Postgres](reports/23_09_18.c2.ib.pg160.8u.1tno.cached.a27/all.html), [IO-bound](reports/23_09_18.c2.ib.pg160.8u.1tno.io.a27/all.html)
    * wal_compression=none: [Cached by Postgres](reports/23_09_18.c2.ib.pg160.8u.1tno.cached.a28/all.html), [IO-bound](reports/23_09_18.c2.ib.pg160.8u.1tno.io.a28/all.html)
* Postgres 16 beta (Aug 2023)
  * Small server, insert benchmark:
    * wal_compression=lz4: [Cached by Postgres](reports/23_08_26.bee.pg16beta.1u.1tno.cached.a1/all.html), [IO-bound](reports/23_08_26.bee.pg16beta.1u.1tno.io.a1/all.html)
    * wal_compression=none: [Cached by Postgres](reports/23_08_26.bee.pg16beta.1u.1tno.cached.a2/all.html), [IO-bound](reports/23_08_26.bee.pg16beta.1u.1tno.io.a2/all.html)
  * Medium server, insert benchmark: [Cached by Postgres](reports/23_08_16.c2.pg16b3.cached/all.html), [IO-bound, wal_compression=lz4](reports/23_08_16.c2.pg16b3.io.27/all.html), [IO-bound, wal_compression=none](reports/23_08_16.c2.pg16b3.io.28/all.html)
* MyRocks tombstones (Aug 2023)
  * Large server: [Cached by RocksDB](reports/23_08_14.u.rx.deletetune.cached/all.html), [IO-bound](reports/23_08_14.u.rx.deletetune.io/all.html)
* MySQL perf regressions with the Insert Benchmark
  * Large server, Dec 2023, FB MySQL with MyRocks 5.6.35, 8.0.28, 8.0.32
    * Cached database: [latest builds](reports/23_12_31_24u.1tno.cached.fbmy.latest/all.html)
  * Large server, Dec 2023, MySQL with InnoDB
    * Cached workload: [without NUMA interleave](reports/23_12_31_24u.1tno.cached.inno.int0/all.html)
  * Small server, Dec 2023, cached workload, MySQL with InnoDB
    * Some point releases: [5.6](reports/23_12_18.bee.1u.1tno.cached.my56/all.html), [5.7](reports/23_12_18.bee.1u.1tno.cached.my57/all.html), [8.0](reports/23_12_18.bee.1u.1tno.cached.my80/all.html), [5.6, 5.7 and 8.0](reports/23_12_18.bee.1u.1tno.cached.myall/all.html)
    * One point release, different my.cnf: [5.7.44](reports/23_12_18.bee.1u.1tno.cached.my5744/all.html), [8.0.35](reports/23_12_18.bee.1u.1tno.cached.my8035/all.html)
  * Medium server, Nov 2023, 5.6 to 8.0
    * Cached: [some 5.6 releases](reports/23_11_14.c2.8u.1tno.cached.my56/all.html), [all 5.7 releases](reports/23_11_14.c2.8u.1tno.cached.my57/all.html), [All 8.0 releases](reports/23_11_14.c2.8u.1tno.cached.my678/all.html), [some 5.6, 5.7 and 8.0 releases](reports/23_11_14.c2.8u.1tno.cached.my80/all.html)
    * IO-bound
  * Small server, Oct 2023, 5.6 to 8.0, IO-bound: [InnoDB 5.6](reports/23_10_09.bee.ib.io.my56/all.html), [InnoDB 5.7](reports/23_10_09.bee.ib.io.my57/all.html), [InnoDB 8.0](reports/23_10_09.bee.ib.io.my80/all.html), [InnoDB 5.6, 5.7 and 8.0](reports/23_10_09.bee.ib.io.my678/all.html)
  * Small server, Sep 2023, 5.6 to 8.0 all versions, cached: [5.6](reports/23_09_18.bee.ib.my56.1u.1tno.cached/all.html), [5.7](reports/23_09_18.bee.ib.my57.1u.1tno.cached/all.html), [8.0](reports/23_09_18.bee.ib.my80.1u.1tno.cached/all.html), [5.6, 5.7, 8.0](reports/23_09_18.bee.ib.my678.1u.1tno.cached/all.html)
  * Large server, Sep 2023, part 3 (oops): [cached workload](reports/23_09_25.u.ib.fbmy56builds.24u.1tno.cached/all.html), [IO-bound workload](reports/23_09_25.u.ib.fbmy56builds.24u.1tno.io/all.html)
  * Large server, Sep 2023, part 2: cached workload [base config](reports/23_09_06.u.56builds.20221011.24u.1tno.cached.c/all.html), [c5 config](reports/23_09_06.u.56builds.20221011.24u.1tno.cached.c5/all.html)
  * Large server, Aug 2023, part 1
    * Base config: [Cached](reports/23_08_24.u.56builds.24u.1tno.cached.c/all.html), [IO-bound](reports/23_08_24.u.56builds.24u.1tno.io.c/all.html)
    * c5 config: [Cached](reports/23_08_24.u.56builds.24u.1tno.cached.c5/all.html), [IO-bound](reports/23_08_24.u.56builds.24u.1tno.io.c5/all.html)
  * Medium server, Aug 2023, part 2
    * Base config: [Cached](reports/23_08_16.c2.56builds.8u.1tno.cached.c/all.html), [IO-bound](reports/23_08_16.c2.56builds.8u.1tno.io.c/all.html)
    * c5 config: [Cached](reports/23_08_16.c2.56builds.8u.1tno.cached.c5/all.html), [IO-bound](reports/23_08_16.c2.56builds.8u.1tno.io.c5/all.html)
  * Medium server, Aug 2023, part 1
    * Base config: [Cached](reports/23_08_10.c2.56builds.1u.1tno.cached.c/all.html) and [IO-bound](reports/23_08_10.c2.56builds.1u.1tno.io.c/all.html)
    * c5 config: [Cached](reports/23_08_10.c2.56builds.1u.1tno.cached.c5/all.html) and [IO-bound](reports/23_08_10.c2.56builds.1u.1tno.io.c5/all.html)
  * Small server, Aug 2023, part 1
    * [Cached by RocksDB](reports/23_08_08.bee.56builds.1u.1tno.cached/all.html), [IO-bound](reports/23_08_08.bee.56builds.1u.1tno.io/all.html)
  * Small server, Aug 2023, part 2
    * Cached by RocksDB: [base config](reports/23_08_17.bee.56builds.1u.1tno.cached.c/all.html), [c5 config](reports/23_08_17.bee.56builds.1u.1tno.cached.c5/all.html)
    * IO-bound: [base config](reports/23_08_17.bee.56builds.1u.1tno.io.c/all.html), [c5 config](reports/23_08_17.bee.56builds.1u.1tno.io.c5/all.html)
* Insert benchmark with deletes (July 2023)
  * MyRocks
    * Small server, tuning my.cnf (Beelink): [Cached by RocksDB](reports/23_07_26.bee.rx.1u.1tno.cached/all.html), [Cached by OS](reports/23_07_26.bee.rx.1u.1tno.1g/all.html), [IO-bound](reports/23_07_26.bee.rx.1u.1tno.io/all.html)
    * Small server (Beelink, 8-cores)
      * 1 client: cached [by RocksDB](reports/23_05_29_ibench.bee.rx68.1u.1tno.cached/all.html) and [by OS page cache](reports/23_05_29_ibench.bee.rx68.1u.1tno.1g/all.html), [IO-bound](reports/23_06_12_ibench.bee.rx68.1u.1tno.io/all.html)
      * 4 clients: cached [by RocksDB](reports/23_05_29_ibench.bee.rx68.4u.1tno.cached/all.html) and [by OS page cache](reports/23_05_29_ibench.bee.rx68.4u.1tno.1g/all.html), [IO-bound](reports/23_06_12_ibench.bee.rx68.4u.1tno.io/all.html)
    * Medium server (c2-standard-30, 15-cores)
      * With delete-per-insert: [Cached by MyRocks](reports/23_06_27_ibench.c2.rx.8u.1tno.dpi1.cached/all.html), [Cached by OS](reports/23_06_27_ibench.c2.rx.8u.1tno.dpi1.4g/all.html), [IO-bound](reports/23_06_27_ibench.c2.rx.8u.1tno.dpi1.io/all.html)
      * Configuration tuning, medium server, July 2023: [Cached by RocksDB](reports/23_07_14.ibench.c2.fbmy8028.8u.1tno.cached.tune/all.html), [Cached by OS](reports/23_07_14.ibench.c2.fbmy8028.8u.1tno.4g.tune/all.html), [IO-bound](reports/23_07_14.ibench.c2.fbmy8028.8u.1tno.io.tune/all.html)
    * Large server, builds back to 2022: [Cached by RocksDB](reports/23_07_24.u.rx56.24u.1tno.cached/all.html), [IO-bound](reports/23_07_24.u.rx56.24u.1tno.io/all.html)
    * Large server, my.cnf tuning: [Cached by RocksDB](reports/23_07_26.u.tune.rx.24u.1tno.cached/all.html), [Cached by OS](reports/23_07_26.u.tune.rx.24u.1tno.4g/all.html), [IO-bound](reports/23_07_26.u.tune.rx.24u.1tno.io/all.html)
  * InnoDB
    * Write stalls: [big server and cached by OS](reports/23_07_07_ibench.u.in.24u.1tno.dpi1.4g.writestalls/all.html)
  * Postgres
* InnoDB config tuning for the insert benchmark
  * medium server with Percona Server, August 2023
    * Cached by InnoDB: [8.0 only](reports/23_08_14.c2.innops.80.cached/all.html), [5.6 vs 5.7 vs 8.0](reports/23_08_14.c2.innops.all.cached/all.html)
    * IO-bound: [8.0 only](reports/23_08_14.c2.innops.80.io/all.html), [5.6 vs 5.7 vs 8.0](reports/23_08_14.c2.innops.all.io/all.html)
  * big server, August 2023
    * Cached by InnoDB: [MySQL 5.6.51](reports/23_08_02.u.tune.in56.24u.1tno.cached/all.html), [MySQL 5.7.40](reports/23_08_02.u.tune.in57.24u.1tno.cached/all.html), [MySQL 8.0.33](reports/23_08_02.u.tune.in80.24u.1tno.cached/all.html), [MySQL 5.6, 5.7 and 8.0](reports/23_08_02.u.tune.all.24u.1tno.cached/all.html)
    * Cached by OS: [MySQL 5.6.51](reports/23_08_02.u.tune.in56.24u.1tno.4g/all.html), [MySQL 5.7.40](reports/23_08_02.u.tune.in57.24u.1tno.4g/all.html), [MySQL 8.0.33](reports/23_08_02.u.tune.in80.24u.1tno.4g/all.html), [MySQL 5.6, 5.7 and 8.0](reports/23_08_02.u.tune.all.24u.1tno.4g/all.html)
    * IO-bound: [MySQL 5.6.51](reports/23_08_02.u.tune.in56.24u.1tno.io/all.html), [MySQL 5.7.40](reports/23_08_02.u.tune.in57.24u.1tno.io/all.html), [MySQL 8.0.33](reports/23_08_02.u.tune.in80.24u.1tno.io/all.html), [MySQL 5.6, 5.7 and 8.0](reports/23_08_02.u.tune.all.24u.1tno.io/all.html)
  * c2-standard-30, June 2023
    * MySQL 5.6.51: [cached by InnoDB](reports/23_06_12_ibench.c2.inno.my56.8u.1tno.cached/all.html), [cached by OS](reports/23_06_12_ibench.c2.inno.my56.8u.1tno.4g/all.html), [IO-bound](reports/23_06_12_ibench.c2.inno.my56.8u.1tno.io/all.html)
    * MySQL 5.7.40:
[cached by InnoDB](reports/23_06_12_ibench.c2.inno.my57.8u.1tno.cached/all.html), [cached by OS](reports/23_06_12_ibench.c2.inno.my57.8u.1tno.4g/all.html), [IO-bound](reports/23_06_12_ibench.c2.inno.my57.8u.1tno.io/all.html)
    * MySQL 8.0.33: [cached by InnoDB](reports/23_06_12_ibench.c2.inno.my80.8u.1tno.cached/all.html), [cached by OS](reports/23_06_12_ibench.c2.inno.my80.8u.1tno.4g/all.html), [IO-bound](reports/23_06_12_ibench.c2.inno.my80.8u.1tno.io/all.html)
  * c2-standard-30, July 2023
    * MySQL 5.6.51: [cached by InnoDB](reports/23_07_17.c2.in56.8u.1tno.cached/all.html), [cached by OS](reports/23_07_17.c2.in56.8u.1tno.4g/all.html), [IO-bound](reports/23_07_17.c2.in56.8u.1tno.io/all.html)
    * MySQL 5.7.40: [cached by InnoDB](reports/23_07_17.c2.in57.8u.1tno.cached/all.html), [cached by OS](reports/23_07_17.c2.in57.8u.1tno.4g/all.html), [IO-bound](reports/23_07_17.c2.in57.8u.1tno.io/all.html)
    * MySQL 8.0.33: [cached by InnoDB](reports/23_07_17.c2.in80.8u.1tno.cached/all.html), [cached by OS](reports/23_07_17.c2.in80.8u.1tno.4g/all.html), [IO-bound](reports/23_07_17.c2.in80.8u.1tno.io/all.html)
    * MySQL 5.6, 5.7, 8.0: [cached by InnoDB](reports/23_07_17.c2.in678.8u.1tno.cached/all.html), [cached by OS](reports/23_07_17.c2.in678.8u.1tno.4g/all.html), [IO-bound](reports/23_07_17.c2.in678.8u.1tno.io/all.html)
  * small server, August 2023
    * Cached by InnoDB: [5.6.51](reports/23_08_11.bee.tune.1u.1tno.cached.my56/all.html), [5.7.40](reports/23_08_11.bee.tune.1u.1tno.cached.my57/all.html), [8.0.33](reports/23_08_11.bee.tune.1u.1tno.cached.my80/all.html), [5.6 vs 5.7 vs 8.0](reports/23_08_11.bee.tune.1u.1tno.cached.565780/all.html)
    * Cached by OS: [5.6.51](reports/23_08_11.bee.tune.1u.1tno.1g.my56/all.html), [5.7.40](reports/23_08_11.bee.tune.1u.1tno.1g.my57/all.html), [8.0.33](reports/23_08_11.bee.tune.1u.1tno.1g.my80/all.html), [5.6 vs 5.7 vs 8.0](reports/23_08_11.bee.tune.1u.1tno.1g.565780/all.html)
    * IO-bound: [5.6.51](reports/23_08_11.bee.tune.1u.1tno.io.my56/all.html), [5.7.40](reports/23_08_11.bee.tune.1u.1tno.io.my57/all.html), [8.0.33](reports/23_08_11.bee.tune.1u.1tno.io.my80/all.html), [5.6 vs 5.7 vs 8.0](reports/23_08_11.bee.tune.1u.1tno.io.565780/all.html)
* Postgres config tuning for the insert benchmark
  * Postgres 15.2 and 15.3, c2-standard-30 server, Aug 2023: [Cached by Postgres](reports/23_08_09.c2.pg15.tune.8u.1tno.cached/all.html), [IO-bound](reports/23_08_09.c2.pg15.tune.8u.1tno.io/all.html)
  * Postgres 15.3, c2-standard-30 server, May 2023
    * [Cached by Postgres, 8 users, 8 tables](reports/23_05_23_ibench.c2s30.pg153.8u.1tno.cached/all.html)
    * [Cached by OS, 8 users, 8 tables](reports/23_05_23_ibench.c2s30.pg153.8u.1tno.4g/all.html)
  * Postgres 15.3, c2-standard-30 server, more tuning, with delete_per_insert, up to a17 config, May 2023
    * [Cached by OS, 8 users, 8 tables](reports/23_05_31_ibench_c2.pg153.8u.1tno.4g.tune/all.html)
    * [Cached by Postgres, 8 users, 8 tables](reports/23_05_31_ibench_c2.pg153.8u.1tno.cached.tune/all.html)
  * Postgres 15.3, c2-standard-30 server, more tuning, with delete_per_insert, adds a18 config, June 2023
    * [Cached by OS, 8 users, 8 tables](reports/23_06_13_ibench.c2.pg153.8u.1tno.4g.tune/all.html)
    * [Cached by Postgres, 8 users, 8 tables](reports/23_06_13_ibench.c2.pg153.8u.1tno.cached.tune/all.html)
  * Postgres 15.3, c2-standard-30 server: IO-bound, with delete per insert, configs up to a18, June 2023
    * [All configs](reports/23_06_14_ibench.c2.pg153.8u.1tno.io.tune.v2/all.html)
    * [Some configs](reports/23_06_14_ibench.c2.pg153.8u.1tno.io.tune.v3/all.html)
  * Postgres 15.3, c2-standard-30 server with delete per insert, configs up to a22, July 2023
    * [Cached by Postgres](reports/23_07_11_ibench.c2.pg153.8u.1tno.cached.tune/all.html), [Cached by OS](reports/23_07_11_ibench.c2.pg153.8u.1tno.4g.tune/all.html), [IO-bound](reports/23_07_11_ibench.c2.pg153.8u.1tno.io.tune/all.html)
  * Postgres 15.2, Beelink (8-cores, 16G RAM), June 2023
    * Cached by Postgres: [1 user](reports/23_06_13_ibench.bee.pg152.1u.1tno.cached/all.html) and [4 users](reports/23_06_13_ibench.bee.pg152.4u.1tno.cached/all.html)
    * Cached by OS: [1 user](reports/23_06_13_ibench.bee.pg152.1u.1tno.1g/all.html) and [4 users](reports/23_06_13_ibench.bee.pg152.4u.1tno.1g/all.html)
  * Postgres 15.2, Beelink (8-cores, 16G RAM), July 2023
    * Cached by Postgres: [1 user](reports/23_07_14.bee.pg152.1u.1tno.cached.tune/all.html) and [4 users](reports/23_07_14.bee.pg152.4u.1tno.cached.tune/all.html)
    * Cached by OS: [1 user](reports/23_07_14.bee.pg152.1u.1tno.1g.tune/all.html) and [4 users](reports/23_07_14.bee.pg152.4u.1tno.1g.tune/all.html)
    * IO-bound: [1 user](reports/23_07_14.bee.pg152.1u.1tno.io.tune/all.html) and [4 users](reports/23_07_14.bee.pg152.4u.1tno.io.tune/all.html)
  * Postgres 15.2 and 15.3, Beelink Aug 2023: [Cached by Postgres](reports/23_08_16.bee.pg15.cached/all.html), [IO-bound](reports/23_08_16.bee.pg15.io/all.html)
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

Others from 2023:
* Insert Benchmark with Postgres 16 storage engines
  * Beelink: [Cached](reports/23_10_16.bee.pg16oriole.ib.cached/all.html), [IO-bound](reports/23_10_16.bee.pg16oriole.ib.io/all.html)
  * c2-standard-30: [Cached](reports/23_10_16.c2.pg16oriole.ib.cached/all.html), [IO-bound](reports/23_10_16.c2.pg16oriole.ib.io/all.html)

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

