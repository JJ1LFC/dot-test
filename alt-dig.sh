#!/usr/bin/bash
for i in udp4 udpcache4 tcp4 tcpcache4 udp6 udpcache6 tcp6 tcpcache6
do
    touch ./$i
done

echo 'Starting with UDP via IPv4...'

for i in `seq 500`
do
    ssh -J cpu1 endo 'sudo unbound-control reload'
    kdig -4 google.com. @endo.sfc.wide.ad.jp.:853 +notls | grep -E '(;; From|;; WARNING)' >> ./udp4
    kdig -4 google.com. @endo.sfc.wide.ad.jp.:853 +notls | grep -E '(;; From|;; WARNING)' >> ./udpcache4
    echo "IPv4 UDP $i "
done

echo 'Starting with TCP via IPv4...'

for i in `seq 500`
do
    ssh -J cpu1 endo 'sudo unbound-control reload'
    kdig -4 google.com. @endo.sfc.wide.ad.jp.:853 +tcp +tls | grep -E '(;; From|;; WARNING)' >> ./tcp4
    kdig -4 google.com. @endo.sfc.wide.ad.jp.:853 +tcp +tls | grep -E '(;; From|;; WARNING)' >> ./tcpcache4
    echo "IPv4 TCP $i "
done

echo 'Starting with UDP via IPv6...'
echo 'If you do not have IPv6 connectivity, just interrupt this.'

for i in `seq 500`
do
    ssh -J cpu1 endo 'sudo unbound-control reload'
    kdig -6 google.com. @endo.sfc.wide.ad.jp.:853 +notls | grep -E '(;; From|;; WARNING)' >> ./udp6
    kdig -6 google.com. @endo.sfc.wide.ad.jp.:853 +notls | grep -E '(;; From|;; WARNING)' >> ./udpcache6
    echo "IPv6 UDP $i "
done

echo 'Starting with TCP via IPv6...'

for i in `seq 500`
do
    ssh -J cpu1 endo 'sudo unbound-control reload'
    kdig -6 google.com. @endo.sfc.wide.ad.jp.:853 +tcp +tls | grep -E '(;; From|;; WARNING)' >> ./tcp6
    kdig -6 google.com. @endo.sfc.wide.ad.jp.:853 +tcp +tls | grep -E '(;; From|;; WARNING)' >> ./tcpcache6
    echo "IPv6 TCP $i "
done


bash ./calc.sh

exit 0
