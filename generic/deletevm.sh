#!/bin/bash

BASE_DIR="/data/vms"

name="$1"
VBoxManage  unregistervm "$name" --delete
