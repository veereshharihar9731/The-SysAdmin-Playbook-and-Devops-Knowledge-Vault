
#!/bin/bash

file="/etc/hosts"

if [ -f "$file" ]; then
    echo "File exists: $file"

    if [ -r "$file" ]; then
        echo "File is readable"
    else
        echo "File is not readable"
    fi
else
    echo "File does not exist: $file"
fi
