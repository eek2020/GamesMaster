# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This project aims to create a user-friendly macOS installer package for playing Street Fighter 2 Champion Edition online between friends using RetroArch netplay. The goal is to eliminate technical barriers by providing a simple drag-and-drop installation experience.

## Project Goals

- **Target Platform**: macOS (Apple Silicon - M1/M3)
- **Emulator**: RetroArch with FBNeo core
- **Game**: Street Fighter 2 Champion Edition (CPS-1 arcade version, `sf2ce.zip`)
- **User Experience**: Zero terminal commands, no manual configuration
- **Key Requirement**: Automatic controller detection and configuration

## Planned Architecture

### Components to Build

1. **Installer App Bundle** (`.app`)
   - Extracts RetroArch to proper location
   - Downloads/installs FBNeo core automatically
   - Copies ROM to correct directory
   - Configures netplay settings
   - Sets up controller mappings
   - No terminal interaction required

2. **Launcher App Bundle** (`.app`)
   - Simple double-click to connect and play
   - Handles netplay connection automatically
   - Pre-configured with host IP or relay server

3. **Configuration Management**
   - RetroArch config files with netplay enabled
   - Controller auto-detection logic
   - Network settings (port forwarding or relay server)

### Technical Considerations

- **Port Forwarding**: Default RetroArch netplay port is 55435, or use relay servers to avoid port forwarding
- **ROM Matching**: Both players must have identical ROM files
- **Input Lag**: Expect 1-2 frames depending on connection quality
- **Bundle Structure**: All dependencies (RetroArch, ROM, configs) must be self-contained

## Current Status

**Phase 1 Complete** - Foundation established with working shell scripts.

### Implemented
- ✅ Project directory structure (following conventions)
- ✅ `.gitignore` and dependency management
- ✅ Installer script (`src/installer/install-retroarch.sh`)
- ✅ Launcher script (`src/launcher/launch-sf2.sh`)
- ✅ RetroArch relay server integration (lowest latency)
- ✅ Documentation (README, QUICKSTART, vendor instructions)

### Key Decisions Made
- **ROM Distribution**: User supplies their own ROM file
- **Networking**: Using RetroArch relay servers (no port forwarding needed)
- **Code Signing**: Not required (personal use between friends)

## Next Steps

### Phase 2: Testing & Refinement
1. Obtain RetroArch.app from official DMG → place in `vendor/retroarch/`
2. Obtain sf2ce.zip ROM file → place in `vendor/roms/`
3. Test installer script end-to-end
4. Test launcher with relay server connection
5. Verify on both M1 and M3 Macs

### Phase 3: App Bundle Creation (Optional)
6. Create macOS `.app` bundle wrappers for easier distribution
7. Add custom icons and UI polish
8. Package as distributable DMG or ZIP

### Phase 4: Production
9. Final testing with friend over internet
10. Document any issues and fixes
11. Create distribution package
