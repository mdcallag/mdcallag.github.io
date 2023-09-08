# Chasing down a performance regression in MyRocks 5.6

I recently shared two blog posts documenting performance regressions in MyRocks 5.6 releases over the past 2 years. Most are due to new CPU overhead so I used perf and created flamegraphs
to narrow my search. My focus is on two of the benchmark steps from the [Insert Benchmark](http://smalldatum.blogspot.com/2023/05/updates-to-insert-benchmark.html). The benchmark steps are:
* l.i1 - write-only with many random inserts and deletes that require secondary index maintenance. Throughput might have dropped by 10% over 2 years while the CPU overhead per operation has increased.
* q100 - short range queries as fast as possible with rate-limited inserts and deletes. Query throughput might have dropped by 10% over 2 years, again from new CPU overhead.

TODO
1) what am I looking for, sample time grows
2) look at relative changes, which funcs get more/less over time

# Flamegraphs

I don't inline the flamegraphs here to improve the download speed for this page. Also, I provide two links per flamegraph, one for viewing and the other for downloading. To get an interactive svg file you need to download it. The non-differential flamegraphs combine the folded output from many perf samples into one large file. Otherwise, flamegraph results have much variance depending on whether compaction is active during the sample. The differential flamegraphs compare a given build with results from the 2022-03-07 build. Given that the source code for the compared builds are not the same the differential flamegraph isn't always useful.

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

