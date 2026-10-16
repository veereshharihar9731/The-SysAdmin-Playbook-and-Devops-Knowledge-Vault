
#!/bin/bash

for port in 22 80 443 8080
do
    echo "Checking port: $port"
    if ss -lnt | awk '{print $4}' | grep -Eq "[:.]${port}$"; then
        echo "Port $port has a listening socket"
    else
        echo "No listening socket found for port $port"
    fi
done
