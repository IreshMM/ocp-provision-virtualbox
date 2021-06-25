#!/bin/bash
controlplanecount="$1"
computenodecount="$2"

./deletebootstrapmachine.sh
./deletecontrolplane.sh $controlplanecount
./deletecomputenodes.sh $computenodecount
