#!/usr/bin/bash
for i in udp udpcache tcp tcpcache
do
    touch ./$i
done

echo 'Starting with UDP...'

for i in `seq 500`
do
    ssh -J cpu1 endo 'sudo unbound-control reload'
    kdig google.com. @endo.sfc.wide.ad.jp.:853 +notls | grep '(;; From|;; WARNING)' >> ./udp
    kdig google.com. @endo.sfc.wide.ad.jp.:853 +notls | grep '(;; From|;; WARNING)' >> ./udpcache
    echo "UDP $i "
done

echo 'Starting with TCP...'

for i in `seq 500`
do
    ssh -J cpu1 endo 'sudo unbound-control reload'
    kdig google.com. @endo.sfc.wide.ad.jp.:853 +tcp +tls | grep '(;; From|;; WARNING)' >> ./tcp
    kdig google.com. @endo.sfc.wide.ad.jp.:853 +tcp +tls | grep '(;; From|;; WARNING)' >> ./tcpcache
    echo "TCP $i "
done

bash ./calc.sh

exit 0
