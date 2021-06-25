#!/bin/bash

name="$1"
VBoxManage hostonlyif remove $name
echo $name
