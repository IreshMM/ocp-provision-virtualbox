cpcount="$1"
wcount="$2"

cat << EOF > db.reverse
\$TTL    604800
@       IN      SOA     ocp-svc.ocp.lan. contact.ocp.lan (
                  1     ; Serial
             604800     ; Refresh
              86400     ; Retry
            2419200     ; Expire
             604800     ; Minimum
)

  IN      NS      ocp-svc.ocp.lan.

1      IN    PTR    ocp-svc.ocp.lan.
1      IN    PTR    api.lab.ocp.lan.
1      IN    PTR    api-int.lab.ocp.lan.
;
200    IN    PTR    ocp-bootstrap.lab.ocp.lan.
;
EOF

for i in $(seq 1 $cpcount); do
	echo "20$i    IN    PTR    ocp-cp-$i.lab.ocp.lan." >> db.reverse;
done
echo ";" >> db.reverse

for i in $(seq 1 $wcount); do
	echo "21$i    IN    PTR    ocp-w-$i.lab.ocp.lan." >> db.reverse;
done
