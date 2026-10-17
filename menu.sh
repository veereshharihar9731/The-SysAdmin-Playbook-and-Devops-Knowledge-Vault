
#!/bin/bash

echo "===== Middleware Menu ====="
echo "1. Check SSH service"
echo "2. Check Apache service"
echo "3. Check Tomcat service"
echo "4. Show disk usage"
echo "5. Exit"

read -r -p "Enter your choice: " choice

case "$choice" in
    1)
        systemctl is-active sshd
        ;;
    2)
        systemctl is-active httpd
        ;;
    3)
        systemctl is-active tomcat
        ;;
    4)
        df -h /
        ;;
    5)
        echo "Exiting menu"
        exit 0
        ;;
    *)
        echo "Invalid choice. Enter 1 to 5."
        exit 1
        ;;
esac

