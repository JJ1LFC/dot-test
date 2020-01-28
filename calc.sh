#!/usr/bin/bash
HOST=`hostname -f`
IP=`hostname -I`
echo ******kdig result from $HOST \( $IP\)******

for i in udp udpcache tcp tcpcache
do
    sed -i -e 's/;.*in //' ./$i
    sed -i -e 's/ ms//' ./$i
done

for i in udp udpcache tcp tcpcache
do
    echo "\n$i min, max, avg"
    awk 'BEGIN{m=100000}{if(m>$1) m=$1} END{print m}' < ./$i
    awk '{if(m<$1) m=$1} END{print m}' < ./$i
    awk '{sum+=$1} END {print sum/NR}' < ./$i
done

exit 0
