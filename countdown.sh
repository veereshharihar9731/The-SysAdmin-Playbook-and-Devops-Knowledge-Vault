
#!/bin/bash

count=5

while [ "$count" -gt 0 ]
do
    echo "Count: $count"
    count=$((count - 1))
    sleep 1
done

echo "Countdown completed"
