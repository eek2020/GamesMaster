#!/usr/bin/env bash
set -euo pipefail

# Build all app bundles for GamesMaster

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo
echo -e "${BLUE}╔════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  GamesMaster Build Script         ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════╝${NC}"
echo

# Build installer
echo -e "${GREEN}Building Installer App...${NC}"
bash "$SCRIPT_DIR/build-installer-app.sh"

echo
echo "---"
echo

# Build launcher
echo -e "${GREEN}Building Launcher App...${NC}"
bash "$SCRIPT_DIR/build-launcher-app.sh"

echo
echo "---"
echo
echo -e "${GREEN}✓ All builds complete!${NC}"
echo
echo "Built applications:"
echo "  - build/SF2 Installer.app"
echo "  - build/SF2 Launcher.app"
echo
