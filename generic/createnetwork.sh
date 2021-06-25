#!/bin/bash

subnet="$1"
name=`VBoxManage hostonlyif create | cut -d" " -f2 | tr -d "'"`
VBoxManage hostonlyif ipconfig $name --ip $subnet
echo $name
