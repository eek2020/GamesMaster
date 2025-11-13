#!/usr/bin/env bash
set -euo pipefail

# Test setup script - validates project structure and dependencies

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$SCRIPT_DIR/.."

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

PASS=0
FAIL=0
WARN=0

check_pass() {
    echo -e "${GREEN}✓${NC} $1"
    ((PASS++))
}

check_fail() {
    echo -e "${RED}✗${NC} $1"
    ((FAIL++))
}

check_warn() {
    echo -e "${YELLOW}⚠${NC} $1"
    ((WARN++))
}

echo
echo -e "${BLUE}╔════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  GamesMaster Setup Test           ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════╝${NC}"
echo

# Test 1: Project structure
echo -e "${BLUE}[1] Checking project structure...${NC}"
if [ -d "$PROJECT_ROOT/src/installer" ]; then
    check_pass "src/installer/ exists"
else
    check_fail "src/installer/ missing"
fi

if [ -d "$PROJECT_ROOT/src/launcher" ]; then
    check_pass "src/launcher/ exists"
else
    check_fail "src/launcher/ missing"
fi

if [ -d "$PROJECT_ROOT/src/shared" ]; then
    check_pass "src/shared/ exists"
else
    check_fail "src/shared/ missing"
fi

if [ -d "$PROJECT_ROOT/vendor" ]; then
    check_pass "vendor/ exists"
else
    check_fail "vendor/ missing"
fi

echo

# Test 2: Required scripts
echo -e "${BLUE}[2] Checking required scripts...${NC}"
if [ -f "$PROJECT_ROOT/src/installer/install-retroarch.sh" ]; then
    check_pass "install-retroarch.sh exists"
    if [ -x "$PROJECT_ROOT/src/installer/install-retroarch.sh" ]; then
        check_pass "install-retroarch.sh is executable"
    else
        check_fail "install-retroarch.sh is not executable"
    fi
else
    check_fail "install-retroarch.sh missing"
fi

if [ -f "$PROJECT_ROOT/src/launcher/launch-sf2.sh" ]; then
    check_pass "launch-sf2.sh exists"
    if [ -x "$PROJECT_ROOT/src/launcher/launch-sf2.sh" ]; then
        check_pass "launch-sf2.sh is executable"
    else
        check_fail "launch-sf2.sh is not executable"
    fi
else
    check_fail "launch-sf2.sh missing"
fi

if [ -f "$PROJECT_ROOT/src/shared/logging.sh" ]; then
    check_pass "logging.sh exists"
else
    check_fail "logging.sh missing"
fi

echo

# Test 3: Dependencies
echo -e "${BLUE}[3] Checking dependencies...${NC}"
if [ -d "$PROJECT_ROOT/vendor/retroarch/RetroArch.app" ]; then
    check_pass "RetroArch.app found in vendor/"
else
    check_warn "RetroArch.app not found in vendor/ (required for installation)"
fi

if [ -f "$PROJECT_ROOT/vendor/roms/sf2ce.zip" ]; then
    check_pass "sf2ce.zip ROM found in vendor/"
else
    check_warn "sf2ce.zip ROM not found in vendor/ (required for installation)"
fi

echo

# Test 4: Build scripts
echo -e "${BLUE}[4] Checking build scripts...${NC}"
if [ -f "$PROJECT_ROOT/scripts/build-installer-app.sh" ]; then
    check_pass "build-installer-app.sh exists"
else
    check_fail "build-installer-app.sh missing"
fi

if [ -f "$PROJECT_ROOT/scripts/build-launcher-app.sh" ]; then
    check_pass "build-launcher-app.sh exists"
else
    check_fail "build-launcher-app.sh missing"
fi

if [ -f "$PROJECT_ROOT/scripts/build-all.sh" ]; then
    check_pass "build-all.sh exists"
else
    check_fail "build-all.sh missing"
fi

echo

# Test 5: Documentation
echo -e "${BLUE}[5] Checking documentation...${NC}"
if [ -f "$PROJECT_ROOT/README.md" ]; then
    check_pass "README.md exists"
else
    check_fail "README.md missing"
fi

if [ -f "$PROJECT_ROOT/docs/prd.md" ]; then
    check_pass "PRD exists"
else
    check_warn "PRD missing"
fi

if [ -f "$PROJECT_ROOT/QUICKSTART.md" ]; then
    check_pass "QUICKSTART.md exists"
else
    check_warn "QUICKSTART.md missing"
fi

echo

# Test 6: System requirements
echo -e "${BLUE}[6] Checking system requirements...${NC}"
if [[ $(uname) == "Darwin" ]]; then
    check_pass "Running on macOS"
    
    # Check for Apple Silicon
    if [[ $(uname -m) == "arm64" ]]; then
        check_pass "Apple Silicon detected"
    else
        check_warn "Intel Mac detected (Apple Silicon recommended)"
    fi
    
    # Check macOS version
    macos_version=$(sw_vers -productVersion)
    major_version=$(echo "$macos_version" | cut -d. -f1)
    if [ "$major_version" -ge 12 ]; then
        check_pass "macOS version $macos_version (>= 12.0)"
    else
        check_warn "macOS version $macos_version (12.0+ recommended)"
    fi
else
    check_fail "Not running on macOS"
fi

echo

# Summary
echo "================================"
echo -e "${GREEN}Passed:${NC} $PASS"
if [ $WARN -gt 0 ]; then
    echo -e "${YELLOW}Warnings:${NC} $WARN"
fi
if [ $FAIL -gt 0 ]; then
    echo -e "${RED}Failed:${NC} $FAIL"
fi
echo "================================"
echo

if [ $FAIL -gt 0 ]; then
    echo -e "${RED}⚠ Some critical checks failed. Please fix before proceeding.${NC}"
    exit 1
elif [ $WARN -gt 0 ]; then
    echo -e "${YELLOW}⚠ Some warnings detected. Review before building.${NC}"
    exit 0
else
    echo -e "${GREEN}✓ All checks passed! Ready to build.${NC}"
    exit 0
fi
