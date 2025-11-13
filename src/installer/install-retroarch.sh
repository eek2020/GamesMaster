#!/usr/bin/env bash
set -euo pipefail

# SF2 RetroArch Installer Script
# Installs RetroArch, FBNeo core, ROM, and netplay configuration

# Load shared logging utilities
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../shared/logging.sh"

# Initialize logging
init_logging "installer"
cleanup_old_logs "installer_*.log" 10

# Paths
RETROARCH_APP="/Applications/RetroArch.app"
RETROARCH_CONFIG="$HOME/Library/Application Support/RetroArch"
RETROARCH_CORES="$RETROARCH_CONFIG/cores"
RETROARCH_ROMS="$RETROARCH_CONFIG/downloads"
RETROARCH_CFG="$RETROARCH_CONFIG/retroarch.cfg"
VENDOR_RETROARCH="$SCRIPT_DIR/../../vendor/retroarch/RetroArch.app"
VENDOR_ROM="$SCRIPT_DIR/../../vendor/roms/sf2ce.zip"

check_dependencies() {
    log_info "Checking dependencies..."
    
    if [ ! -d "$VENDOR_RETROARCH" ]; then
        log_error "RetroArch.app not found in vendor/retroarch/"
        log_error "Please download RetroArch and place it in vendor/retroarch/"
        exit 1
    fi
    
    if [ ! -f "$VENDOR_ROM" ]; then
        log_error "sf2ce.zip ROM not found in vendor/roms/"
        log_error "Please place sf2ce.zip in vendor/roms/"
        exit 1
    fi
    
    log_info "All dependencies found ✓"
}

install_retroarch() {
    log_info "Installing RetroArch to /Applications..."
    
    if [ -d "$RETROARCH_APP" ]; then
        log_warn "RetroArch already exists in /Applications"
        read -p "Overwrite? (y/n) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            log_info "Skipping RetroArch installation"
            return
        fi
        rm -rf "$RETROARCH_APP"
    fi
    
    cp -R "$VENDOR_RETROARCH" "$RETROARCH_APP"
    log_info "RetroArch installed ✓"
}

create_config_dirs() {
    log_info "Creating configuration directories..."
    mkdir -p "$RETROARCH_CONFIG"
    mkdir -p "$RETROARCH_CORES"
    mkdir -p "$RETROARCH_ROMS"
    log_info "Directories created ✓"
}

install_rom() {
    log_info "Installing SF2CE ROM..."
    cp "$VENDOR_ROM" "$RETROARCH_ROMS/sf2ce.zip"
    log_info "ROM installed ✓"
}

download_fbneo_core() {
    log_info "Downloading FBNeo core..."
    
    # RetroArch CLI path
    RETROARCH_CLI="$RETROARCH_APP/Contents/MacOS/RetroArch"
    
    if [ ! -f "$RETROARCH_CLI" ]; then
        log_error "RetroArch CLI not found at $RETROARCH_CLI"
        exit 1
    fi
    
    # Download FBNeo core using RetroArch's online updater
    "$RETROARCH_CLI" --verbose --downloadcore "fbneo" || {
        log_warn "Auto-download failed. You'll need to download FBNeo core manually:"
        log_warn "1. Open RetroArch"
        log_warn "2. Go to Online Updater > Core Downloader > Arcade > FBNeo"
        return
    }
    
    log_info "FBNeo core downloaded ✓"
}

configure_netplay() {
    log_info "Configuring netplay settings..."
    
    # Create basic RetroArch config with netplay enabled
    cat > "$RETROARCH_CFG" << 'EOF'
# RetroArch Configuration - SF2 Netplay Setup

# Network settings
network_cmd_enable = "true"
netplay_client_swap_input = "true"
netplay_nat_traversal = "true"
netplay_use_mitm_server = "true"
netplay_mitm_server = "nyc"
netplay_ip_port = "55435"
netplay_delay_frames = "2"
netplay_check_frames = "600"
netplay_input_latency_frames_min = "0"
netplay_input_latency_frames_range = "0"

# Video settings
video_fullscreen = "true"
video_vsync = "true"
video_hard_sync = "true"
video_frame_delay = "0"

# Audio settings
audio_enable = "true"
audio_sync = "true"

# Input settings
input_autodetect_enable = "true"
input_joypad_driver = "hid"

# Menu settings
menu_driver = "ozone"
rgui_menu_color_theme = "0"

# Directories
savefile_directory = "~/.config/retroarch/saves"
savestate_directory = "~/.config/retroarch/states"
system_directory = "~/.config/retroarch/system"
libretro_directory = "~/.config/retroarch/cores"
libretro_info_path = "~/.config/retroarch/info"
content_database_path = "~/.config/retroarch/database/rdb"
cheat_database_path = "~/.config/retroarch/cheats"
video_shader_dir = "~/.config/retroarch/shaders"
recording_output_directory = "~/.config/retroarch/recordings"
recording_config_directory = "~/.config/retroarch/records_config"
overlay_directory = "~/.config/retroarch/overlay"
screenshot_directory = "~/.config/retroarch/screenshots"
joypad_autoconfig_dir = "~/.config/retroarch/autoconfig"
playlist_directory = "~/.config/retroarch/playlists"
EOF
    
    log_info "Netplay configuration created ✓"
}

main() {
    echo "================================"
    echo "SF2 RetroArch Installer"
    echo "================================"
    echo
    
    check_dependencies
    install_retroarch
    create_config_dirs
    install_rom
    download_fbneo_core
    configure_netplay
    
    echo
    log_info "Installation complete! 🎮"
    echo
    echo "Next steps:"
    echo "1. Run the SF2 Launcher app"
    echo "2. Choose Host or Join mode"
    echo "3. Start playing!"
    echo
}

main "$@"
