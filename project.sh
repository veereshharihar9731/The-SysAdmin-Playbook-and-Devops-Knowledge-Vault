#!/bin/bash

file='services.txt'

#!/bin/bash

# Middleware Health Monitoring Automation

BASE_DIR="/home/veeresh/scripts"
SERVICE_FILE="$BASE_DIR/services.txt"
LOG_FILE="$BASE_DIR/monitor.log"

DISK_THRESHOLD=80
HTTP_URL="${HTTP_URL:-http://127.0.0.1:8080/}"

failed=0

# Write timestamped messages to the log and terminal
log_message() {
    local level="$1"
    shift

    printf '%s [%s] %s\n' \
        "$(date '+%Y-%m-%d %H:%M:%S')" \
        "$level" "$*" | tee -a "$LOG_FILE"
}

# Check whether a required systemd service is running
check_service() {
    local service_name="$1"

    if systemctl is-active --quiet "$service_name"; then
        log_message INFO "Service $service_name is RUNNING"
        return 0
    else
        log_message ERROR "Service $service_name is NOT RUNNING"
        return 1
    fi
}

# Check root filesystem disk usage
check_disk() {
    local usage

    usage=$(df -P / | awk 'NR==2 {
        gsub("%", "", $5)
        print $5
    }')

    if [[ ! "$usage" =~ ^[0-9]+$ ]]; then
        log_message ERROR "Unable to determine disk usage"
        return 1
    fi

    log_message INFO "Root filesystem usage is ${usage}%"

    if (( usage >= DISK_THRESHOLD )); then
        log_message WARN "Disk usage reached threshold: ${usage}%"
        return 1
    else
        log_message INFO "Disk usage is below ${DISK_THRESHOLD}%"
        return 0
    fi
}

# Check HTTP response and status code
check_http() {
    local status
    local curl_rc

    if status=$(curl -sS -o /dev/null \
        -w '%{http_code}' \
        --connect-timeout 3 \
        --max-time 5 \
        "$HTTP_URL"); then

        log_message INFO "HTTP endpoint $HTTP_URL returned $status"

        if [[ "$status" =~ ^[0-9]{3}$ ]] &&
           (( 10#$status >= 200 && 10#$status < 400 )); then
            log_message INFO "HTTP health check PASSED"
            return 0
        else
            log_message ERROR "HTTP health check FAILED"
            return 1
        fi
    else
        curl_rc=$?
        log_message ERROR "HTTP request failed; curl exit code $curl_rc"
        return 1
    fi
}

# Validate the configuration file
if [[ ! -r "$SERVICE_FILE" ]]; then
    log_message ERROR "Cannot read service file: $SERVICE_FILE"
    exit 1
fi

log_message INFO "========== Monitoring started =========="

# Read and check all configured services
while IFS= read -r service || [[ -n "$service" ]]; do
    [[ -z "$service" || "$service" == \#* ]] && continue

    if ! check_service "$service"; then
        failed=1
    fi
done < "$SERVICE_FILE"

# Check disk usage
if ! check_disk; then
    failed=1
fi

# Check HTTP endpoint
if ! check_http; then
    failed=1
fi

# Final summary and exit status
if (( failed == 0 )); then
    log_message INFO "RESULT: ALL REQUIRED CHECKS PASSED"
else
    log_message ERROR "RESULT: ONE OR MORE REQUIRED CHECKS FAILED"
fi

log_message INFO "========== Monitoring completed =========="

exit "$failed"

