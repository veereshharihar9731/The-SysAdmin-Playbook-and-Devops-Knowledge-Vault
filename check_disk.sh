#!/bin/bash

usage=$(df -P / | awk 'NR==2 {gsub("%","",$5); print $5}')

if [ "$usage" -gt 80 ];
then
echo "High Disk usage"
else
echo "Disk is working normal"
fi
