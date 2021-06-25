#!/bin/bash

cpcount="$1"
wcount="$2"

cat <<-EOF > db.ocp.lan
\$TTL    604800
@       IN      SOA     ocp-svc.ocp.lan. contact.ocp.lan (
                  1     ; Serial
             604800     ; Refresh
              86400     ; Retry
            2419200     ; Expire
             604800     ; Minimum
)
        IN      NS      ocp-svc

ocp-svc.ocp.lan.          IN      A       192.168.22.1

; OpenShift Internal - Load balancer
api.lab.ocp.lan.        IN    A    192.168.22.1
api-int.lab.ocp.lan.    IN    A    192.168.22.1
*.apps.lab.ocp.lan.     IN    A    192.168.22.1

; Temp Bootstrap Node
ocp-bootstrap.lab.ocp.lan.        IN      A      192.168.22.200

EOF

echo "; Control Plane Nodes" >> db.ocp.lan
for i in $(seq 1 $cpcount); do
	echo "ocp-cp-$i.lab.ocp.lan.         IN      A      192.168.22.20$i" >> db.ocp.lan;
done
echo >> db.ocp.lan # empty line

echo "; Worker Nodes" >> db.ocp.lan
for i in $(seq 1 $wcount); do
	echo "ocp-w-$i.lab.ocp.lan.         IN      A      192.168.22.21$i" >> db.ocp.lan;
done
echo >> db.ocp.lan # empty line

echo "; ETCD Cluster" >> db.ocp.lan
for i in $(seq 1 $cpcount); do
	echo "etcd-$(($i-1)).lab.ocp.lan.    IN    A     192.168.22.20$i" >> db.ocp.lan;
done
echo >> db.ocp.lan # empty line

echo "; OpenShift Internal SRV records (cluster name = lab)" >> db.ocp.lan
for i in $(seq 0 $(($cpcount-1))); do
	echo "_etcd-server-ssl._tcp.lab.ocp.lan.    86400     IN    SRV     0    10    2380    etcd-$i.lab" >> db.ocp.lan;
done
echo >> db.ocp.lan # empty line

cat << EOF >> db.ocp.lan
oauth-openshift.apps.lab.ocp.lan.     IN     A     192.168.22.1
console-openshift-console.apps.lab.ocp.lan.     IN     A     192.168.22.1
EOF
