
#!/bin/bash

file="services.txt"

check_service() {
    local service_name="$1"

    if systemctl is-active --quiet "$service_name"; then
        echo "RUNNING: $service_name"
    else
        echo "NOT RUNNING: $service_name"
    fi
}

if [ ! -r "$file" ]; then
    echo "ERROR: Cannot read $file"
    exit 1
fi

while IFS= read -r service || [ -n "$service" ]; do
    [ -z "$service" ] && continue
    check_service "$service"
done < "$file"

