#!/bin/bash

mem="$(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)"
echo -e "$mem"

