
#!/bin/bash

url="http://127.0.0.1:8080/"
attempt=1
max_attempts=5

while [ "$attempt" -le "$max_attempts" ]
do
    if curl -fsS --max-time 3 "$url" -o /dev/null; then
        echo "HTTP endpoint is responding successfully"
        exit 0
    fi

    echo "Attempt $attempt failed"
    attempt=$((attempt + 1))
    sleep 2
done

echo "ERROR: Endpoint did not respond successfully"
exit 1
