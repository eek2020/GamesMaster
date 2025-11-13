# Development Guide

Quick reference for developing and building GamesMaster.

## Quick Start

```bash
# Interactive development menu
./scripts/dev-helper.sh

# Or run commands directly:
./scripts/test-setup.sh      # Validate project setup
./scripts/build-all.sh        # Build both apps
```

## Project Structure

```
GamesMaster/
├── src/
│   ├── installer/           # Installer script
│   ├── launcher/            # Launcher script
│   └── shared/              # Shared utilities (logging)
├── scripts/                 # Build and test scripts
├── vendor/                  # Dependencies (RetroArch, ROMs)
├── build/                   # Build output (.app bundles)
├── logs/                    # Runtime logs
└── docs/                    # Documentation
```

## Available Scripts

### Build Scripts

- **`build-all.sh`** - Build both installer and launcher apps
- **`build-installer-app.sh`** - Build SF2 Installer.app only
- **`build-launcher-app.sh`** - Build SF2 Launcher.app only

### Testing Scripts

- **`test-setup.sh`** - Validate project structure and dependencies
- **`dev-helper.sh`** - Interactive development menu

### Direct Execution

- **`src/installer/install-retroarch.sh`** - Run installer directly
- **`src/launcher/launch-sf2.sh`** - Run launcher directly

## Development Workflow

### 1. Initial Setup

```bash
# Clone repository
git clone <repo-url>
cd GamesMaster

# Add dependencies
# - Place RetroArch.app in vendor/retroarch/
# - Place sf2ce.zip in vendor/roms/

# Validate setup
./scripts/test-setup.sh
```

### 2. Making Changes

```bash
# Edit source files in src/
vim src/installer/install-retroarch.sh
vim src/launcher/launch-sf2.sh

# Test changes directly
bash src/installer/install-retroarch.sh
bash src/launcher/launch-sf2.sh
```

### 3. Building Apps

```bash
# Build app bundles
./scripts/build-all.sh

# Test app bundles
open build/SF2\ Installer.app
open build/SF2\ Launcher.app
```

### 4. Debugging

```bash
# View logs
ls -lht logs/

# View specific log
tail -f logs/installer_*.log
tail -f logs/launcher_*.log

# Enable debug mode
DEBUG=1 bash src/installer/install-retroarch.sh
```

## Logging System

All scripts log to `logs/` directory:

- **`installer_YYYYMMDD_HHMMSS.log`** - Installer execution logs
- **`launcher_YYYYMMDD_HHMMSS.log`** - Launcher execution logs

Logs include:
- Timestamps
- Log levels (INFO, WARN, ERROR, DEBUG)
- All operations and errors

Old logs are automatically cleaned up (keeps last 10).

## Code Conventions

### File Naming

- Use **kebab-case**: `my-script.sh`, `config-file.json`
- No spaces or underscores in filenames

### Shell Scripts

```bash
#!/usr/bin/env bash
set -euo pipefail

# Load logging
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../shared/logging.sh"
init_logging "script-name"

# Your code here
log_info "Starting process..."
```

### Variables

- Shell: `snake_case` - `my_variable="value"`
- Paths: Use absolute paths from `$SCRIPT_DIR`

## Testing Checklist

Before committing changes:

- [ ] Run `./scripts/test-setup.sh` - all checks pass
- [ ] Build apps successfully
- [ ] Test installer app manually
- [ ] Test launcher app manually
- [ ] Check logs for errors
- [ ] Update documentation if needed

## Common Issues

### "Permission denied" errors

```bash
chmod +x scripts/*.sh
chmod +x src/**/*.sh
```

### "RetroArch not found" in vendor

Download from: <https://www.retroarch.com/?page=platforms>

Place `RetroArch.app` in `vendor/retroarch/`

### "ROM not found" in vendor

Place `sf2ce.zip` in `vendor/roms/`

**Important**: Both players must use identical ROM file.

### Build fails

```bash
# Clean and rebuild
rm -rf build/
./scripts/build-all.sh
```

### App won't open

```bash
# Check app bundle structure
ls -la build/SF2\ Installer.app/Contents/

# Check executable permissions
ls -la build/SF2\ Installer.app/Contents/MacOS/

# View system logs
log show --predicate 'process == "SF2 Installer"' --last 5m
```

## Distribution

### Creating Release Package

```bash
# Build apps
./scripts/build-all.sh

# Create DMG (future)
./scripts/package-dmg.sh

# Or create ZIP
cd build
zip -r GamesMaster-v1.0.zip "SF2 Installer.app" "SF2 Launcher.app"
```

## Resources

- [PRD](docs/prd.md) - Product requirements
- [Progress](docs/progress.md) - Development progress
- [CLAUDE.md](CLAUDE.md) - AI assistant guidance
- [RetroArch Docs](https://docs.libretro.com/)
