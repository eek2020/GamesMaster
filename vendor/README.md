# Vendor Dependencies

This folder contains third-party dependencies that are too large for git or require manual download.

## Required Files

### 1. RetroArch.app
- **Location**: `vendor/retroarch/RetroArch.app`
- **Download**: https://www.retroarch.com/?page=platforms
- **Version**: Latest stable for macOS (Apple Silicon)
- **Instructions**:
  1. Download the `.dmg` file
  2. Open the DMG
  3. Copy `RetroArch.app` to `vendor/retroarch/`

### 2. Street Fighter 2 ROM
- **Location**: `vendor/roms/sf2ce.zip`
- **File**: `sf2ce.zip` (CPS-1 arcade version)
- **Important**: Do not extract the zip file - RetroArch needs it zipped
- **Note**: Both players must use the exact same ROM file (same MD5 hash)

## Verification

After adding files, your structure should look like:
```
vendor/
├── README.md (this file)
├── retroarch/
│   └── RetroArch.app/
└── roms/
    └── sf2ce.zip
```

## .gitignore

These files are excluded from git via `.gitignore` to avoid:
- Large file sizes
- Copyright issues
- Repository bloat
