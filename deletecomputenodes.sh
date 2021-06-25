
#!/bin/bash
name_prefix=ocp-w
count="$1"

for i in $(seq 1 $count); do
	generic/deletevm.sh "${name_prefix}-$i"
done;
