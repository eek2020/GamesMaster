# Changelog

All notable changes to GamesMaster will be documented in this file.

## [Unreleased]

### Added

- Shared logging system for all scripts
- Build scripts for creating macOS .app bundles
- Setup validation script (`test-setup.sh`)
- Development helper script with interactive menu
- Comprehensive documentation (DEVELOPMENT.md, progress.md)
- Automatic log cleanup (keeps last 10 logs)

### Changed

- Installer and launcher scripts now use centralized logging
- Updated documentation to reflect build system

## [0.1.0] - 2025-11-12

### Added

- Initial project structure
- Installer shell script (`install-retroarch.sh`)
- Launcher shell script (`launch-sf2.sh`)
- RetroArch relay server integration
- Documentation (README, QUICKSTART, PRD, conventions)
- Git repository with proper `.gitignore`

### Technical Details

- macOS Apple Silicon support only
- RetroArch netplay via relay servers (no port forwarding)
- FBNeo core for arcade emulation
- Street Fighter 2 Championship Edition support
