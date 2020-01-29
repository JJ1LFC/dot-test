#!/usr/bin/bash
HOST=`hostname -f`
IP=`hostname -I`
echo "******kdig result from $HOST ( $IP)******"

for i in udp4 udpcache4 tcp4 tcpcache4 udp6 udpcache6 tcp6 tcpcache6
do
    sed -i -e 's/;; From.*in //' ./$i
    sed -i -e 's/ ms//' ./$i
done

for i in udp4 udpcache4 tcp4 tcpcache4 udp6 udpcache6 tcp6 tcpcache6
do
    echo -e "\n$i min, max, avg"
    awk 'BEGIN{m=100000}{if(m>$1) m=$1} END{print m}' < ./$i
    awk '{if(m<$1) m=$1} END{print m}' < ./$i
    awk '{sum+=$1} END {print sum/NR}' < ./$i
done

exit 0
