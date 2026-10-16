
#!/bin/bash

for service in sshd httpd tomcat
do
    if systemctl is-active --quiet "$service"; then
        echo "$service: RUNNING"
    else
        echo "$service: NOT RUNNING"
    fi
done
