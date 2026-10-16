
#!/bin/bash

usage=$(df -P / | awk 'NR==2 {gsub("%","",$5); print $5}')

if [ "$usage" -ge 90 ]; then
    echo "CRITICAL: Disk usage is 90% or higher"
elif [ "$usage" -ge 80 ]; then
    echo "WARNING: Disk usage is 80% or higher"
else
    echo "OK: Disk usage is below 80%"
fi
