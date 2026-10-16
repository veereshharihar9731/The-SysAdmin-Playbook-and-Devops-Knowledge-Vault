
#!/bin/bash

check_service() {
    service_name="$1"

    if systemctl is-active --quiet "$service_name"; then
        echo "SUCCESS: $service_name is running"
    else
        echo "WARNING: $service_name is not running"
    fi
}

check_service sshd
check_service httpd
check_service tomcat
