#!/usr/bin/env bash
set -euo pipefail

# SF2 Netplay Launcher Script
# Launches RetroArch with SF2CE in netplay mode

# Load shared logging utilities
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../shared/logging.sh"

# Initialize logging
init_logging "launcher"
cleanup_old_logs "launcher_*.log" 10

# Paths
RETROARCH_APP="/Applications/RetroArch.app"
RETROARCH_CLI="$RETROARCH_APP/Contents/MacOS/RetroArch"
ROM_PATH="$HOME/Library/Application Support/RetroArch/downloads/sf2ce.zip"
CORE_PATH="$HOME/Library/Application Support/RetroArch/cores/fbneo_libretro.dylib"

check_installation() {
    log_info "Checking installation..."
    
    if [ ! -f "$RETROARCH_CLI" ]; then
        log_error "RetroArch not found. Please run the installer first."
        exit 1
    fi
    
    if [ ! -f "$ROM_PATH" ]; then
        log_error "SF2CE ROM not found. Please run the installer first."
        exit 1
    fi
    
    if [ ! -f "$CORE_PATH" ]; then
        log_warn "FBNeo core not found. Attempting to download..."
        "$RETROARCH_CLI" --verbose --downloadcore "fbneo" || {
            log_error "Failed to download core. Please install manually."
            exit 1
        }
    fi
    
    log_info "Installation verified ✓"
}

show_menu() {
    echo
    echo "================================"
    echo "  SF2 Championship Edition"
    echo "  Netplay Launcher"
    echo "================================"
    echo
    echo "1) Host Game"
    echo "2) Join Game"
    echo "3) Exit"
    echo
    read -p "Choose option (1-3): " choice
    echo
}

host_game() {
    log_info "Starting host mode..."
    echo
    echo -e "${BLUE}╔════════════════════════════════╗${NC}"
    echo -e "${BLUE}║  Hosting SF2 Netplay Session  ║${NC}"
    echo -e "${BLUE}╚════════════════════════════════╝${NC}"
    echo
    echo "Share this information with your friend:"
    echo
    echo "  Connection Method: RetroArch Relay Server"
    echo "  Region: New York (nyc)"
    echo
    echo "Your friend should:"
    echo "  1. Run the launcher"
    echo "  2. Choose 'Join Game'"
    echo "  3. Wait for you to start hosting"
    echo
    read -p "Press ENTER to start hosting..."
    
    log_info "Launching RetroArch as host..."
    
    # Launch RetroArch in host mode with relay server
    "$RETROARCH_CLI" \
        -L "$CORE_PATH" \
        "$ROM_PATH" \
        --host \
        --port 55435 \
        --mitm nyc \
        --nick "Player1" \
        --verbose &
    
    RETROARCH_PID=$!
    
    echo
    log_info "RetroArch launched (PID: $RETROARCH_PID)"
    log_info "Game will start when Player 2 connects..."
    echo
    
    wait $RETROARCH_PID
}

join_game() {
    log_info "Starting client mode..."
    echo
    echo -e "${BLUE}╔════════════════════════════════╗${NC}"
    echo -e "${BLUE}║  Joining SF2 Netplay Session  ║${NC}"
    echo -e "${BLUE}╚════════════════════════════════╝${NC}"
    echo
    
    read -p "Enter host's username or IP (or press ENTER for relay): " host_address
    
    if [ -z "$host_address" ]; then
        log_info "Using RetroArch relay server (nyc)..."
        
        "$RETROARCH_CLI" \
            -L "$CORE_PATH" \
            "$ROM_PATH" \
            --connect \
            --mitm nyc \
            --nick "Player2" \
            --verbose &
    else
        log_info "Connecting to $host_address..."
        
        "$RETROARCH_CLI" \
            -L "$CORE_PATH" \
            "$ROM_PATH" \
            --connect "$host_address" \
            --port 55435 \
            --nick "Player2" \
            --verbose &
    fi
    
    RETROARCH_PID=$!
    
    echo
    log_info "RetroArch launched (PID: $RETROARCH_PID)"
    log_info "Connecting to host..."
    echo
    
    wait $RETROARCH_PID
}

main() {
    check_installation
    
    while true; do
        show_menu
        
        case $choice in
            1)
                host_game
                ;;
            2)
                join_game
                ;;
            3)
                log_info "Goodbye! 👋"
                exit 0
                ;;
            *)
                log_error "Invalid option. Please choose 1-3."
                ;;
        esac
        
        echo
        read -p "Press ENTER to return to menu..."
    done
}

main "$@"
