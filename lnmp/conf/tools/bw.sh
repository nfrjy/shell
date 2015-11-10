sar -n 'DEV' 1  10000000|awk 'BEGIN{printf "DEVICE\tIN\t\tOUT\n"}''/eth0/ {printf $3"  ";printf $6*8/1024/1024"Mbps    ";print $7*8/1024/1024"Mbps"}'
