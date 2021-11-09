set boxwidth 0.7
set xtics rotate 90
set style fill solid
set yrange [0:]
set title "Inserts/second"
set output "ch.l.i0.ips.png"
set term png
plot "res.x.20m.all.etldirs/mrg.l.i0.ips" using 1:xtic(2) notitle with boxes
set boxwidth 0.7
set xtics rotate 90
set style fill solid
set yrange [0:]
set title "Indexed docs or rows/second"
set output "ch.l.x.ips.png"
set term png
plot "res.x.20m.all.etldirs/mrg.l.x.ips" using 1:xtic(2) notitle with boxes
set boxwidth 0.7
set xtics rotate 90
set style fill solid
set yrange [0:]
set title "Inserts/second"
set output "ch.l.i1.ips.png"
set term png
plot "res.x.20m.all.etldirs/mrg.l.i1.ips" using 1:xtic(2) notitle with boxes
unset title
set boxwidth 0.5
set xtics rotate 90
set style fill solid
set style data histograms
set yrange [0:]
set output "ch.q100.2.qps.png"
set term png
plot "res.x.20m.all.etldirs/mrg.q100.2.qps" using 2:xtic(3) title "QPS", "" using 1 title "IPS"
unset title
set boxwidth 0.5
set xtics rotate 90
set style fill solid
set style data histograms
set yrange [0:]
set output "ch.q200.2.qps.png"
set term png
plot "res.x.20m.all.etldirs/mrg.q200.2.qps" using 2:xtic(3) title "QPS", "" using 1 title "IPS"
unset title
set boxwidth 0.5
set xtics rotate 90
set style fill solid
set style data histograms
set yrange [0:]
set output "ch.q400.2.qps.png"
set term png
plot "res.x.20m.all.etldirs/mrg.q400.2.qps" using 2:xtic(3) title "QPS", "" using 1 title "IPS"
unset title
set boxwidth 0.5
set xtics rotate 90
set style fill solid
set style data histograms
set yrange [0:]
set output "ch.q600.2.qps.png"
set term png
plot "res.x.20m.all.etldirs/mrg.q600.2.qps" using 2:xtic(3) title "QPS", "" using 1 title "IPS"
unset title
set boxwidth 0.5
set xtics rotate 90
set style fill solid
set style data histograms
set yrange [0:]
set output "ch.q800.2.qps.png"
set term png
plot "res.x.20m.all.etldirs/mrg.q800.2.qps" using 2:xtic(3) title "QPS", "" using 1 title "IPS"
unset title
set boxwidth 0.5
set xtics rotate 90
set style fill solid
set style data histograms
set yrange [0:]
set output "ch.q1000.2.qps.png"
set term png
plot "res.x.20m.all.etldirs/mrg.q1000.2.qps" using 2:xtic(3) title "QPS", "" using 1 title "IPS"
