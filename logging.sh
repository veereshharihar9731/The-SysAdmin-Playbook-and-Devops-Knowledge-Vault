
#!/bin/bash

LOG_FILE="/home/veeresh/scripts/monitor.log"

log_message() {
    local level="$1"
    shift
    printf '%s [%s] %s\n' \
        "$(date '+%Y-%m-%d %H:%M:%S')" \
        "$level" "$*" >> "$LOG_FILE"
}

log_message INFO "Service monitoring started"
log_message INFO "Checking Apache service"
log_message WARN "Example warning message"
log_message ERROR "Example error message"

echo "Log entries written to $LOG_FILE"

