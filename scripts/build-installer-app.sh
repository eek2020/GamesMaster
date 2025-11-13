#!/usr/bin/env bash
set -euo pipefail

# Build SF2 Installer.app bundle
# Creates a macOS application bundle for the installer

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$SCRIPT_DIR/.."
BUILD_DIR="$PROJECT_ROOT/build"
APP_NAME="SF2 Installer"
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
    <string>installer-wrapper</string>
    <key>CFBundleIdentifier</key>
    <string>com.gamesmaster.sf2-installer</string>
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    <key>CFBundleName</key>
    <string>SF2 Installer</string>
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
cat > "$APP_BUNDLE/Contents/MacOS/installer-wrapper" << 'EOF'
#!/usr/bin/env bash
# Wrapper to launch installer in Terminal

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
INSTALLER_SCRIPT="$SCRIPT_DIR/../Resources/install-retroarch.sh"

# Launch in Terminal
osascript <<APPLESCRIPT
tell application "Terminal"
    activate
    do script "cd \"$(dirname \"$INSTALLER_SCRIPT\")\" && bash \"$INSTALLER_SCRIPT\"; echo ''; echo 'Press any key to close...'; read -n 1"
end tell
APPLESCRIPT
EOF

chmod +x "$APP_BUNDLE/Contents/MacOS/installer-wrapper"

# Copy installer script and dependencies
echo -e "${GREEN}[4/5]${NC} Copying installer scripts..."
cp "$PROJECT_ROOT/src/installer/install-retroarch.sh" "$APP_BUNDLE/Contents/Resources/"
mkdir -p "$APP_BUNDLE/Contents/Resources/shared"
cp "$PROJECT_ROOT/src/shared/logging.sh" "$APP_BUNDLE/Contents/Resources/shared/"

# Create symbolic links to vendor directory
echo -e "${GREEN}[5/5]${NC} Setting up vendor links..."
mkdir -p "$APP_BUNDLE/Contents/Resources/vendor"
ln -sf "$PROJECT_ROOT/vendor/retroarch" "$APP_BUNDLE/Contents/Resources/vendor/retroarch"
ln -sf "$PROJECT_ROOT/vendor/roms" "$APP_BUNDLE/Contents/Resources/vendor/roms"

# Update paths in the bundled installer script
sed -i '' 's|SCRIPT_DIR/\.\./\.\./vendor|SCRIPT_DIR/../Resources/vendor|g' "$APP_BUNDLE/Contents/Resources/install-retroarch.sh"
sed -i '' 's|SCRIPT_DIR/\.\./shared|SCRIPT_DIR/../Resources/shared|g' "$APP_BUNDLE/Contents/Resources/install-retroarch.sh"

echo
echo -e "${GREEN}✓${NC} Build complete!"
echo "App bundle created at: $APP_BUNDLE"
echo
echo "To test: open \"$APP_BUNDLE\""
echo
