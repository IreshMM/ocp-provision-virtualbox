#!/bin/bash

BASE_DIR=/data/vms

vdi_path="$1"
network="$2"
natnetwork="$3"
name=ocp-svc
cpus=6
memory=8
storage=200


generic/createvm.sh "$name" RedHat_64 $cpus $(($memory*1024)) $(($storage*1024)) ""  "$network"
VBoxManage storageattach "$name" --storagectl SATA --port 0 --device 0 --medium none

final_vdi_path="${BASE_DIR}/disks/${name}-disk.vdi"
VBoxManage closemedium $final_vdi_path --delete

cp "$vdi_path" "$final_vdi_path"

VBoxManage storageattach "$name" --storagectl SATA --port 0 --device 0 --medium "$final_vdi_path" --type hdd
VBoxManage modifyvm "$name" --nic2 natnetwork --nat-network2 "$natnetwork"
