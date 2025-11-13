#!/usr/bin/env bash
# Shared logging utilities for GamesMaster scripts

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Log directory
LOG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)/logs"
mkdir -p "$LOG_DIR"

# Current log file (set by init_logging)
CURRENT_LOG_FILE=""

# Initialize logging for a script
# Usage: init_logging "script-name"
init_logging() {
    local script_name="${1:-unknown}"
    local timestamp=$(date +"%Y%m%d_%H%M%S")
    CURRENT_LOG_FILE="$LOG_DIR/${script_name}_${timestamp}.log"
    
    echo "=== Log started at $(date) ===" > "$CURRENT_LOG_FILE"
    echo "Script: $script_name" >> "$CURRENT_LOG_FILE"
    echo "======================================" >> "$CURRENT_LOG_FILE"
    echo "" >> "$CURRENT_LOG_FILE"
}

# Log to both console and file
log_to_file() {
    local level="$1"
    local message="$2"
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    
    if [ -n "$CURRENT_LOG_FILE" ]; then
        echo "[$timestamp] [$level] $message" >> "$CURRENT_LOG_FILE"
    fi
}

log_info() {
    local message="$1"
    echo -e "${GREEN}[INFO]${NC} $message"
    log_to_file "INFO" "$message"
}

log_warn() {
    local message="$1"
    echo -e "${YELLOW}[WARN]${NC} $message"
    log_to_file "WARN" "$message"
}

log_error() {
    local message="$1"
    echo -e "${RED}[ERROR]${NC} $message"
    log_to_file "ERROR" "$message"
}

log_debug() {
    local message="$1"
    if [ "${DEBUG:-0}" = "1" ]; then
        echo -e "${BLUE}[DEBUG]${NC} $message"
    fi
    log_to_file "DEBUG" "$message"
}

# Clean up old log files (keep last 10)
cleanup_old_logs() {
    local pattern="${1:-*.log}"
    local keep_count="${2:-10}"
    
    cd "$LOG_DIR" 2>/dev/null || return
    
    # Count log files matching pattern
    local log_count=$(ls -1 $pattern 2>/dev/null | wc -l | tr -d ' ')
    
    if [ "$log_count" -gt "$keep_count" ]; then
        log_debug "Cleaning up old logs (keeping $keep_count most recent)"
        ls -1t $pattern | tail -n +$((keep_count + 1)) | xargs rm -f
    fi
}

# Export functions for use in other scripts
export -f init_logging
export -f log_to_file
export -f log_info
export -f log_warn
export -f log_error
export -f log_debug
export -f cleanup_old_logs
