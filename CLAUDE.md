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

**Phase 2 In Progress** - Build system and logging infrastructure complete.

### Implemented

- ✅ Project directory structure (following conventions)
- ✅ `.gitignore` and dependency management
- ✅ Installer script (`src/installer/install-retroarch.sh`)
- ✅ Launcher script (`src/launcher/launch-sf2.sh`)
- ✅ RetroArch relay server integration (lowest latency)
- ✅ Documentation (README, QUICKSTART, vendor instructions)
- ✅ Shared logging system (`src/shared/logging.sh`)
- ✅ Build scripts for creating .app bundles
- ✅ Test setup validation script

### Key Decisions Made

- **ROM Distribution**: User supplies their own ROM file
- **Networking**: Using RetroArch relay servers (no port forwarding needed)
- **Code Signing**: Not required (personal use between friends)
- **Logging**: All operations logged to `logs/` directory (gitignored)

## Build System

### Building App Bundles

```bash
# Build both apps
./scripts/build-all.sh

# Or build individually
./scripts/build-installer-app.sh
./scripts/build-launcher-app.sh
```

### Testing Setup

```bash
# Validate project structure and dependencies
./scripts/test-setup.sh
```

## Next Steps

### Phase 2: Testing & Refinement (Current)

1. Obtain RetroArch.app from official DMG → place in `vendor/retroarch/`
2. Obtain sf2ce.zip ROM file → place in `vendor/roms/`
3. Run `./scripts/test-setup.sh` to validate
4. Build app bundles with `./scripts/build-all.sh`
5. Test installer app end-to-end
6. Test launcher with relay server connection
7. Verify on both M1 and M3 Macs

### Phase 3: Polish & Distribution

1. Add custom icons for app bundles
2. Improve error messages and user feedback
3. Create distributable DMG or ZIP
4. Write end-user documentation

### Phase 4: Production

1. Final testing with friend over internet
2. Document any issues and fixes
3. Create distribution package
