#!/bin/bash

BASE_DIR="/data/vms"

name="$1"
ostype="$2"
VBoxManage createvm --name "$name" --ostype "$ostype" --register

cpus="$3"
memory="$4"
vga="vmsvga"
VBoxManage modifyvm "$name" --cpus "$cpus" --memory "$memory" --graphicscontroller "$vga"

VBoxManage storagectl "$name" --name SATA --add sata --portcount 2 --bootable on

disk="$5"
disk_file="${BASE_DIR}/disks/${name}-disk.vdi" 
VBoxManage createmedium disk --filename "$disk_file" --size "$disk" --variant Standard
VBoxManage storageattach "$name" --storagectl SATA --port 0 --device 0 --medium "$disk_file" --type hdd

iso_path="$6"
VBoxManage storageattach "$name" --storagectl SATA --port 1 --device 0 --medium "$iso_path" --type dvddrive

network="$7"
VBoxManage modifyvm "$name" --nic2 hostonly --hostonlyadapter2 "$network"
