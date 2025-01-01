#!/bin/bash
weather=$(curl -s wttr.in/Istanbul?format=%t)
printf " %s %s \n" "$weather"
