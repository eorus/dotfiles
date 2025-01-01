#!/bin/bash

BLT="$(xbacklight -get | awk '{print int($1)}')"
echo -e "$BLT%"
	
