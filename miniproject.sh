
#!/bin/bash

BASE_DIR="/home/veeresh/scripts"
SERVICE_FILE="$BASE_DIR/services.txt"
LOG_FILE="$BASE_DIR/monitor.log"

log_message() {
    local level="$1"
    shift
    printf '%s [%s] %s\n' \
        "$(date '+%Y-%m-%d %H:%M:%S')" \
        "$level" "$*" | tee -a "$LOG_FILE"
}

check_service() {
    local service_name="$1"

    if systemctl is-active --quiet "$service_name"; then
        log_message INFO "$service_name is RUNNING"
        return 0
    else
        log_message ERROR "$service_name is NOT RUNNING"
        return 1
    fi
}

if [ ! -r "$SERVICE_FILE" ]; then
    log_message ERROR "Cannot read $SERVICE_FILE"
    exit 1
fi

log_message INFO "Middleware monitoring started"

failed=0

while IFS= read -r service || [ -n "$service" ]; do
    [ -z "$service" ] && continue
    check_service "$service" || failed=1
done < "$SERVICE_FILE"

if [ "$failed" -eq 0 ]; then
    log_message INFO "Monitoring completed: all services are running"
    exit 0
else
    log_message ERROR "Monitoring completed: one or more services failed"
    exit 1
fi

