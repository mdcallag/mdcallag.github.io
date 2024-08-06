set boxwidth 0.7
set xtics rotate 90
set style fill solid
set yrange [0:]
set title "Inserts/second"
set output "ch.l.i0.ips.png"
set term png
plot "res.masome.etldirs/mrg.l.i0.ips" using 1:xtic(2) notitle with boxes
set boxwidth 0.7
set xtics rotate 90
set style fill solid
set yrange [0:]
set title "Indexed docs or rows/second"
set output "ch.l.x.ips.png"
set term png
plot "res.masome.etldirs/mrg.l.x.ips" using 1:xtic(2) notitle with boxes
set boxwidth 0.7
set xtics rotate 90
set style fill solid
set yrange [0:]
set title "Inserts/second"
set output "ch.l.i1.ips.png"
set term png
plot "res.masome.etldirs/mrg.l.i1.ips" using 1:xtic(2) notitle with boxes
set boxwidth 0.7
set xtics rotate 90
set style fill solid
set yrange [0:]
set title "Inserts/second"
set output "ch.l.i2.ips.png"
set term png
plot "res.masome.etldirs/mrg.l.i2.ips" using 1:xtic(2) notitle with boxes
unset title
set boxwidth 0.5
set xtics rotate 90
set style fill solid
set style data histograms
set yrange [0:]
set output "ch.qr100.L1.qps.png"
set term png
plot "res.masome.etldirs/mrg.qr100.L1.qps" using 2:xtic(3) title "QPS", "" using 1 title "IPS"
unset title
set boxwidth 0.5
set xtics rotate 90
set style fill solid
set style data histograms
set yrange [0:]
set output "ch.qp100.L2.qps.png"
set term png
plot "res.masome.etldirs/mrg.qp100.L2.qps" using 2:xtic(3) title "QPS", "" using 1 title "IPS"
unset title
set boxwidth 0.5
set xtics rotate 90
set style fill solid
set style data histograms
set yrange [0:]
set output "ch.qr500.L3.qps.png"
set term png
plot "res.masome.etldirs/mrg.qr500.L3.qps" using 2:xtic(3) title "QPS", "" using 1 title "IPS"
unset title
set boxwidth 0.5
set xtics rotate 90
set style fill solid
set style data histograms
set yrange [0:]
set output "ch.qp500.L4.qps.png"
set term png
plot "res.masome.etldirs/mrg.qp500.L4.qps" using 2:xtic(3) title "QPS", "" using 1 title "IPS"
unset title
set boxwidth 0.5
set xtics rotate 90
set style fill solid
set style data histograms
set yrange [0:]
set output "ch.qr1000.L5.qps.png"
set term png
plot "res.masome.etldirs/mrg.qr1000.L5.qps" using 2:xtic(3) title "QPS", "" using 1 title "IPS"
unset title
set boxwidth 0.5
set xtics rotate 90
set style fill solid
set style data histograms
set yrange [0:]
set output "ch.qp1000.L6.qps.png"
set term png
plot "res.masome.etldirs/mrg.qp1000.L6.qps" using 2:xtic(3) title "QPS", "" using 1 title "IPS"
