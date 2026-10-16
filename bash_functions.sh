
#!/bin/bash

show_server_info() {
    echo "Server Name: $(hostname)"
    echo "Current User: $(whoami)"
    echo "Current Date: $(date)"
}

echo "Starting server information check"
show_server_info
echo "Check completed"
