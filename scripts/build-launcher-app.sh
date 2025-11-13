#!/usr/bin/env bash
set -euo pipefail

# Build SF2 Launcher.app bundle
# Creates a macOS application bundle for the launcher

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$SCRIPT_DIR/.."
BUILD_DIR="$PROJECT_ROOT/build"
APP_NAME="SF2 Launcher"
APP_BUNDLE="$BUILD_DIR/$APP_NAME.app"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "================================"
echo "Building $APP_NAME.app"
echo "================================"
echo

# Clean and create build directory
echo -e "${GREEN}[1/5]${NC} Preparing build directory..."
rm -rf "$APP_BUNDLE"
mkdir -p "$APP_BUNDLE/Contents/MacOS"
mkdir -p "$APP_BUNDLE/Contents/Resources"

# Create Info.plist
echo -e "${GREEN}[2/5]${NC} Creating Info.plist..."
cat > "$APP_BUNDLE/Contents/Info.plist" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleDevelopmentRegion</key>
    <string>en</string>
    <key>CFBundleExecutable</key>
    <string>launcher-wrapper</string>
    <key>CFBundleIdentifier</key>
    <string>com.gamesmaster.sf2-launcher</string>
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    <key>CFBundleName</key>
    <string>SF2 Launcher</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0.0</string>
    <key>CFBundleVersion</key>
    <string>1</string>
    <key>LSMinimumSystemVersion</key>
    <string>12.0</string>
    <key>NSHighResolutionCapable</key>
    <true/>
    <key>NSRequiresAquaSystemAppearance</key>
    <false/>
</dict>
</plist>
EOF

# Create wrapper script that launches Terminal
echo -e "${GREEN}[3/5]${NC} Creating launcher wrapper..."
cat > "$APP_BUNDLE/Contents/MacOS/launcher-wrapper" << 'EOF'
#!/usr/bin/env bash
# Wrapper to launch SF2 in Terminal

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
LAUNCHER_SCRIPT="$SCRIPT_DIR/../Resources/launch-sf2.sh"

# Launch in Terminal
osascript <<APPLESCRIPT
tell application "Terminal"
    activate
    do script "bash \"$LAUNCHER_SCRIPT\""
end tell
APPLESCRIPT
EOF

chmod +x "$APP_BUNDLE/Contents/MacOS/launcher-wrapper"

# Copy launcher script and dependencies
echo -e "${GREEN}[4/5]${NC} Copying launcher scripts..."
cp "$PROJECT_ROOT/src/launcher/launch-sf2.sh" "$APP_BUNDLE/Contents/Resources/"
mkdir -p "$APP_BUNDLE/Contents/Resources/shared"
cp "$PROJECT_ROOT/src/shared/logging.sh" "$APP_BUNDLE/Contents/Resources/shared/"

# Update paths in the bundled launcher script
echo -e "${GREEN}[5/5]${NC} Updating script paths..."
sed -i '' 's|SCRIPT_DIR/\.\./shared|SCRIPT_DIR/../Resources/shared|g' "$APP_BUNDLE/Contents/Resources/launch-sf2.sh"

echo
echo -e "${GREEN}✓${NC} Build complete!"
echo "App bundle created at: $APP_BUNDLE"
echo
echo "To test: open \"$APP_BUNDLE\""
echo
