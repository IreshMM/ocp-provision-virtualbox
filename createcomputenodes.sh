
#!/bin/bash

iso_path="$1"
network="$2"
name_prefix=ocp-w
cpus=4
memory=8
storage=120
count="$3"

for i in $(seq 1 $count); do
	generic/createvm.sh "${name_prefix}-$i" RedHat_64 $cpus $(($memory*1024)) $(($storage*1024)) "$iso_path" "$network";
done;
