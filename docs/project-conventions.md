# Project Conventions

This document defines the core conventions and standards for the Games Master project. **All code, files, and folders must follow these rules.**

## Naming Conventions

### Files and Folders
- **Always use kebab-case**: `my-file-name.sh`, `config-builder/`
- **No spaces, underscores, or camelCase**: ❌ `MyFile.sh`, `my_file.sh` → ✅ `my-file.sh`
- **Descriptive names**: `install-retroarch.sh` not `installer.sh`

### Code Variables
- **Shell scripts**: Use `snake_case` for variables: `rom_path`, `user_name`
- **AppleScript/JXA**: Use `camelCase` for variables: `romPath`, `userName`

### App Bundles
- **Display names**: Title Case with spaces: "SF2 Installer.app"
- **Bundle identifiers**: Reverse domain notation: `com.gamesmaster.sf2-installer`
- **Internal folders**: kebab-case when possible

## Directory Structure

```
games-master/
├── docs/                           # All documentation
│   ├── project-conventions.md      # This file (source of truth)
│   ├── prd.md                      # Product requirements
│   ├── technical-spec.md           # Technical architecture
│   └── roadmap.md                  # Implementation plan
├── src/                            # Source code
│   ├── installer/                  # Installer app source
│   ├── launcher/                   # Launcher app source
│   ├── shared/                     # Shared utilities
│   └── config/                     # Configuration templates
├── assets/                         # Static assets
│   ├── icons/                      # App icons
│   ├── images/                     # UI images
│   └── sounds/                     # Audio files (if needed)
├── build/                          # Build outputs (gitignored)
├── dist/                           # Distribution packages (gitignored)
├── scripts/                        # Build/utility scripts
│   ├── build-installer.sh
│   ├── build-launcher.sh
│   └── package-dmg.sh
├── tests/                          # Test files
└── vendor/                         # Third-party dependencies
    ├── retroarch/                  # RetroArch.app bundle
    └── roms/                       # ROM files (gitignored)
```

## Git Conventions

### Branch Naming
- `main` - Production-ready code
- `feature/feature-name` - New features
- `fix/issue-description` - Bug fixes
- `docs/update-description` - Documentation updates

### Commit Messages
- Format: `type: brief description`
- Types: `feat`, `fix`, `docs`, `refactor`, `test`, `build`, `chore`
- Example: `feat: add controller auto-detection`

### .gitignore Rules
- Never commit ROMs or copyrighted content
- Ignore `build/` and `dist/` directories
- Ignore macOS-specific files (`.DS_Store`, etc.)
- Ignore sensitive data (IP addresses in configs)

## Code Style

### Shell Scripts
- Use `#!/usr/bin/env bash` shebang
- Set strict mode: `set -euo pipefail`
- Quote all variables: `"$variable"`
- Use functions for reusability
- Add comments for complex logic

### AppleScript/JXA
- Use JXA (JavaScript for Automation) for modern syntax
- Handle errors gracefully with try-catch
- Provide user-friendly error messages
- Log to Console.app for debugging

### Configuration Files
- Use JSON for structured data
- Use property lists (.plist) for macOS app configs
- Include comments where format allows
- Validate before deployment

## Testing Standards

- Test on both M1 and M3 Macs
- Test with multiple controller types
- Test network scenarios (LAN, WAN, relay)
- Document test cases in `tests/`

## Documentation Standards

- All docs in `docs/` folder
- Use Markdown format
- Keep CLAUDE.md updated with architecture changes
- Include code examples where helpful
- Update roadmap when priorities change

## Security and Privacy

- No hardcoded passwords or API keys
- No telemetry or tracking
- Validate all user inputs
- Use secure file permissions (644 for files, 755 for executables)

## User Experience Principles

- **Zero configuration**: Works out of the box
- **Clear error messages**: Tell users what went wrong and how to fix it
- **Graceful failures**: Never crash without explanation
- **Progressive disclosure**: Advanced options available but hidden by default

---

**This document is the source of truth. When in doubt, refer here.**
