#!/bin/bash

iso_path="$1"
network="$2"
name=ocp-bootstrap
cpus=4
memory=16
storage=120


generic/createvm.sh "$name" RedHat_64 $cpus $(($memory*1024)) $(($storage*1024)) "$iso_path" "$network"
