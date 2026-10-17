
#!/bin/bash

read -r -p "Enter disk usage percentage (0-100): " usage

if [[ ! "$usage" =~ ^[0-9]+$ ]]; then
    echo "ERROR: Enter numbers only"
    exit 1
fi

if (( usage < 0 || usage > 100 )); then
    echo "ERROR: Value must be between 0 and 100"
    exit 1
fi

if (( usage >= 80 )); then
    echo "WARNING: Disk usage is high: ${usage}%"
else
    echo "OK: Disk usage is ${usage}%"
fi

