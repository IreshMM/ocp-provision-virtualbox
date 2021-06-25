#!/bin/bash

iso_path="$1"
network="$2"
controlplanecount="$3"
computenodecount="$4"

./createbootstrapmachine.sh "$iso_path" "$network"
./createcontrolplane.sh "$iso_path" "$network" $controlplanecount
./createcomputenodes.sh "$iso_path" "$network" $computenodecount
