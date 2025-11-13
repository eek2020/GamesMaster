# Next Steps - Quick Reference

## 🎯 Current Status

**Phase 2**: Core features complete, ready for dependency setup and testing

### ✅ Completed
- Project structure established
- Core scripts implemented (`install-retroarch.sh`, `launch-sf2.sh`)
- Build system created (installer + launcher app builders)
- Shared utilities (logging system)
- Documentation (PRD, conventions, setup guide)
- Development helper tools

### ⚠️ Required Before Testing
You need to download and place two dependencies:

1. **RetroArch.app** → `vendor/retroarch/RetroArch.app`
   - Download from: https://www.retroarch.com/?page=platforms
   - Get the Apple Silicon version

2. **sf2ce.zip ROM** → `vendor/roms/sf2ce.zip`
   - Obtain the Street Fighter 2 CE ROM file
   - Must be named exactly `sf2ce.zip`

---

## 📋 Testing Workflow

### Step 1: Add Dependencies
```bash
# After downloading RetroArch.app and sf2ce.zip:
# Place RetroArch.app in vendor/retroarch/
# Place sf2ce.zip in vendor/roms/
```

### Step 2: Validate Setup
```bash
./scripts/test-setup.sh
```

Expected output: All checks pass ✓

### Step 3: Build Apps
```bash
./scripts/build-all.sh
```

Creates:
- `SF2 Installer.app`
- `SF2 Launcher.app`

### Step 4: Manual Testing

#### Test Installer
1. Double-click `SF2 Installer.app`
2. Follow installation prompts
3. Verify RetroArch installed to `~/Library/Application Support/RetroArch`

#### Test Launcher (Host)
1. Double-click `SF2 Launcher.app`
2. Click "Host Game"
3. Note the connection code
4. Verify game launches

#### Test Launcher (Client)
1. On second Mac, run `SF2 Launcher.app`
2. Click "Join Game"
3. Enter connection code from host
4. Verify connection and gameplay

---

## 🔧 Development Commands

### Quick Access Menu
```bash
./scripts/dev-helper.sh
```

### Individual Commands
```bash
# Validate setup
./scripts/test-setup.sh

# Build everything
./scripts/build-all.sh

# Build installer only
./scripts/build-installer-app.sh

# Build launcher only
./scripts/build-launcher-app.sh
```

---

## 📁 Key Files Reference

| File | Purpose |
|------|---------|
| `SETUP.md` | Comprehensive setup guide |
| `QUICKSTART.md` | Quick start for end users |
| `docs/prd.md` | Product requirements |
| `docs/project-conventions.md` | Code standards |
| `src/installer/install-retroarch.sh` | Installer logic |
| `src/launcher/launch-sf2.sh` | Launcher logic |
| `src/shared/logging.sh` | Logging utilities |

---

## 🚀 Future Phases

### Phase 3: Polish (After Testing)
- [ ] Custom app icons (SF2 themed)
- [ ] Enhanced error messages
- [ ] Progress indicators
- [ ] DMG installer creation
- [ ] App signing and notarization

### Phase 4: Release
- [ ] Real-world testing with friends
- [ ] Network performance validation
- [ ] Controller compatibility testing
- [ ] Final bug fixes
- [ ] Release documentation
- [ ] Distribution package

---

## 🐛 Troubleshooting

### Common Issues

**"RetroArch.app not found"**
- Check path: `vendor/retroarch/RetroArch.app`
- Ensure it's the Apple Silicon version

**"ROM not found"**
- Check path: `vendor/roms/sf2ce.zip`
- Verify filename is exactly `sf2ce.zip`

**"Permission denied"**
```bash
chmod +x scripts/*.sh
chmod +x src/installer/*.sh src/launcher/*.sh
```

**Build fails**
- Run `./scripts/test-setup.sh` first
- Verify all dependencies present
- Check macOS version (12+ required)

---

## 📊 Testing Checklist

### Pre-Testing
- [ ] RetroArch.app in vendor/retroarch/
- [ ] sf2ce.zip in vendor/roms/
- [ ] test-setup.sh passes
- [ ] build-all.sh completes successfully

### Installer Testing
- [ ] App launches without errors
- [ ] Installation completes
- [ ] RetroArch installed correctly
- [ ] ROM copied to correct location
- [ ] Config files created

### Launcher Testing (Host)
- [ ] App launches
- [ ] Host mode starts
- [ ] Connection code displayed
- [ ] Game launches
- [ ] Controller detected

### Launcher Testing (Client)
- [ ] App launches
- [ ] Join mode works
- [ ] Connection code accepted
- [ ] Connects to host
- [ ] Game launches

### Netplay Testing
- [ ] Both players see each other
- [ ] Input lag acceptable
- [ ] No desyncs
- [ ] Can complete full match
- [ ] Reconnect works after disconnect

---

## 💡 Tips

1. **Use dev-helper.sh** for quick access to common tasks
2. **Check logs** in `~/Library/Logs/GamesMaster/` if issues occur
3. **Test on clean system** if possible (or create new user account)
4. **Document issues** as you find them for Phase 3 improvements
5. **Both players need identical ROM** for netplay to work

---

## 📞 Next Actions

1. **Download dependencies** (RetroArch + ROM)
2. **Run validation** (`./scripts/test-setup.sh`)
3. **Build apps** (`./scripts/build-all.sh`)
4. **Test installer** on your Mac
5. **Test launcher** in host mode
6. **Test with friend** for netplay validation
7. **Document findings** for Phase 3 improvements

---

**Ready to proceed?** Start with downloading the dependencies, then run the validation script!
