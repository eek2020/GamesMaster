#!/usr/bin/env bash
set -euo pipefail

# Development helper script - quick access to common tasks

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$SCRIPT_DIR/.."

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

show_menu() {
    clear
    echo
    echo -e "${BLUE}╔════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║  GamesMaster Development Helper   ║${NC}"
    echo -e "${BLUE}╚════════════════════════════════════╝${NC}"
    echo
    echo "1) Test setup (validate project)"
    echo "2) Build all apps"
    echo "3) Build installer only"
    echo "4) Build launcher only"
    echo "5) View recent logs"
    echo "6) Clean build directory"
    echo "7) Open build directory"
    echo "8) Run installer script directly"
    echo "9) Run launcher script directly"
    echo "0) Exit"
    echo
    read -p "Choose option: " choice
    echo
}

test_setup() {
    echo -e "${GREEN}Running setup tests...${NC}"
    bash "$SCRIPT_DIR/test-setup.sh"
}

build_all() {
    echo -e "${GREEN}Building all apps...${NC}"
    bash "$SCRIPT_DIR/build-all.sh"
}

build_installer() {
    echo -e "${GREEN}Building installer app...${NC}"
    bash "$SCRIPT_DIR/build-installer-app.sh"
}

build_launcher() {
    echo -e "${GREEN}Building launcher app...${NC}"
    bash "$SCRIPT_DIR/build-launcher-app.sh"
}

view_logs() {
    echo -e "${GREEN}Recent logs:${NC}"
    echo
    if [ -d "$PROJECT_ROOT/logs" ] && [ "$(ls -A "$PROJECT_ROOT/logs")" ]; then
        ls -lht "$PROJECT_ROOT/logs" | head -10
        echo
        read -p "Enter log filename to view (or press ENTER to skip): " log_file
        if [ -n "$log_file" ]; then
            less "$PROJECT_ROOT/logs/$log_file"
        fi
    else
        echo "No logs found."
    fi
}

clean_build() {
    echo -e "${YELLOW}Cleaning build directory...${NC}"
    if [ -d "$PROJECT_ROOT/build" ]; then
        rm -rf "$PROJECT_ROOT/build"
        echo "Build directory cleaned."
    else
        echo "Build directory doesn't exist."
    fi
}

open_build() {
    if [ -d "$PROJECT_ROOT/build" ]; then
        open "$PROJECT_ROOT/build"
    else
        echo "Build directory doesn't exist. Run a build first."
    fi
}

run_installer() {
    echo -e "${GREEN}Running installer script directly...${NC}"
    bash "$PROJECT_ROOT/src/installer/install-retroarch.sh"
}

run_launcher() {
    echo -e "${GREEN}Running launcher script directly...${NC}"
    bash "$PROJECT_ROOT/src/launcher/launch-sf2.sh"
}

main() {
    while true; do
        show_menu
        
        case $choice in
            1) test_setup ;;
            2) build_all ;;
            3) build_installer ;;
            4) build_launcher ;;
            5) view_logs ;;
            6) clean_build ;;
            7) open_build ;;
            8) run_installer ;;
            9) run_launcher ;;
            0) echo "Goodbye!"; exit 0 ;;
            *) echo "Invalid option." ;;
        esac
        
        echo
        read -p "Press ENTER to continue..."
    done
}

main "$@"
