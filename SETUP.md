# GamesMaster Setup Guide

## Current Status

✅ **Project Structure**: Complete
✅ **Core Scripts**: Ready
✅ **Build Scripts**: Ready
⚠️ **Dependencies**: Required (see below)

---

## Required Dependencies

Before you can build and test the apps, you need to download two dependencies:

### 1. RetroArch for macOS (Apple Silicon)

**Download Location**: https://www.retroarch.com/?page=platforms

**Steps**:
1. Visit the RetroArch downloads page
2. Download the **macOS (Apple Silicon)** version (`.dmg` file)
3. Open the `.dmg` file
4. Drag `RetroArch.app` to your Desktop temporarily
5. Copy `RetroArch.app` to: `vendor/retroarch/RetroArch.app`

**Expected Path**: 
```
vendor/retroarch/RetroArch.app/
```

### 2. Street Fighter 2 Champion Edition ROM

**File Name**: `sf2ce.zip`

**Steps**:
1. Obtain the SF2CE ROM file (CPS-1 arcade version)
2. Ensure it's named exactly: `sf2ce.zip`
3. Place it in: `vendor/roms/sf2ce.zip`

**Expected Path**:
```
vendor/roms/sf2ce.zip
```

**Important**: Both you and your friend must use the **exact same ROM file** for netplay to work correctly.

---

## Validation

Once you've added both dependencies, validate your setup:

```bash
./scripts/test-setup.sh
```

This will check:
- ✓ Project structure
- ✓ Required scripts are present and executable
- ✓ RetroArch.app is in vendor/retroarch/
- ✓ sf2ce.zip ROM is in vendor/roms/
- ✓ Build scripts exist
- ✓ Documentation is present
- ✓ System requirements (macOS 12+, Apple Silicon)

---

## Building the Apps

After validation passes, build the app bundles:

```bash
./scripts/build-all.sh
```

This creates:
- `SF2 Installer.app` - Installs RetroArch and configures SF2
- `SF2 Launcher.app` - Launches the game in host or client mode

---

## Testing

### Manual Testing Checklist

#### 1. Test SF2 Installer.app
- [ ] Double-click `SF2 Installer.app`
- [ ] Verify it installs RetroArch to `~/Library/Application Support/RetroArch`
- [ ] Check that ROM is copied correctly
- [ ] Verify configuration files are created

#### 2. Test SF2 Launcher.app (Host Mode)
- [ ] Double-click `SF2 Launcher.app`
- [ ] Click "Host Game"
- [ ] Verify connection code is displayed
- [ ] Check that RetroArch launches with netplay hosting

#### 3. Test SF2 Launcher.app (Client Mode)
- [ ] On a second Mac (or after closing host)
- [ ] Double-click `SF2 Launcher.app`
- [ ] Click "Join Game"
- [ ] Enter the connection code from host
- [ ] Verify connection and game launch

#### 4. Test Netplay Connection
- [ ] Both players can see each other
- [ ] Game runs smoothly with acceptable latency
- [ ] Controllers work correctly
- [ ] Can complete a full match

---

## Development Helper

For quick access to common dev tasks:

```bash
./scripts/dev-helper.sh
```

This provides a menu with options to:
1. Run setup validation
2. Build all apps
3. Build installer only
4. Build launcher only
5. Clean build artifacts
6. View logs

---

## Troubleshooting

### "RetroArch.app not found"
- Ensure you've downloaded RetroArch for **Apple Silicon** (not Intel)
- Check the path: `vendor/retroarch/RetroArch.app`
- The `.app` bundle should be directly in the `retroarch` folder

### "ROM not found"
- Ensure the file is named exactly `sf2ce.zip` (lowercase)
- Check the path: `vendor/roms/sf2ce.zip`
- The file should be a valid CPS-1 ROM archive

### "Permission denied" errors
- Make scripts executable: `chmod +x scripts/*.sh`
- Make core scripts executable: `chmod +x src/installer/*.sh src/launcher/*.sh`

### Build fails
- Run `./scripts/test-setup.sh` to identify issues
- Check that all dependencies are present
- Verify you're on macOS 12+ with Apple Silicon

---

## Next Steps

Once testing is complete:

### Phase 3: Polish
- [ ] Add custom app icons
- [ ] Improve error handling and user feedback
- [ ] Create DMG installer for distribution
- [ ] Add app signing and notarization

### Phase 4: Release
- [ ] Real-world testing with friends
- [ ] Final bug fixes
- [ ] Documentation updates
- [ ] Create release package

---

## File Structure Reference

```
GamesMaster/
├── vendor/
│   ├── retroarch/
│   │   └── RetroArch.app/          ← Place RetroArch here
│   └── roms/
│       └── sf2ce.zip                ← Place ROM here
├── scripts/
│   ├── test-setup.sh                ← Validation script
│   ├── build-all.sh                 ← Build both apps
│   ├── build-installer-app.sh       ← Build installer
│   ├── build-launcher-app.sh        ← Build launcher
│   └── dev-helper.sh                ← Dev menu
├── src/
│   ├── installer/
│   │   └── install-retroarch.sh     ← Installer logic
│   ├── launcher/
│   │   └── launch-sf2.sh            ← Launcher logic
│   └── shared/
│       └── logging.sh               ← Shared utilities
└── docs/
    ├── prd.md                       ← Product requirements
    └── project-conventions.md       ← Code standards
```

---

## Support

For issues or questions:
1. Check the logs in `~/Library/Logs/GamesMaster/`
2. Review `docs/prd.md` for feature details
3. Check `docs/project-conventions.md` for code standards
