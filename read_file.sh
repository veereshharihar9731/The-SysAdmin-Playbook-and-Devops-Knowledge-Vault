
#!/bin/bash

file="services.txt"

if [ ! -f "$file" ]; then
    echo "ERROR: File not found: $file"
    exit 1
fi

while IFS= read -r service || [ -n "$service" ]; do
    echo "Service from file: $service"
done < "$file"

echo "File reading completed"

