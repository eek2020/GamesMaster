# Games Master - RetroArch Netplay Installer

A user-friendly macOS installer for playing Street Fighter 2 Champion Edition online with friends using RetroArch netplay.

## Quick Start

### Prerequisites (You Must Provide)

1. **RetroArch for macOS (Apple Silicon)**
   - Download from: https://www.retroarch.com/?page=platforms
   - Get the `.dmg` file for macOS
   - Extract `RetroArch.app` and place it in `vendor/retroarch/`

2. **SF2CE ROM**
   - File: `sf2ce.zip` (CPS-1 arcade version)
   - Place in `vendor/roms/`
   - **Important**: Both players must use the exact same ROM file

### Installation

1. Clone this repository
2. Add dependencies to `vendor/` folder (see above)
3. Run the installer build script:
   ```bash
   ./scripts/build-installer.sh
   ```

### Usage

**For the host (you):**
1. Run `SF2 Installer.app` to set up RetroArch
2. Run `SF2 Launcher.app` and click "Host Game"
3. Share the connection code with your friend

**For the client (your friend):**
1. Run `SF2 Installer.app` to set up RetroArch
2. Run `SF2 Launcher.app` and click "Join Game"
3. Enter the connection code

## Project Structure

See `docs/project-conventions.md` for detailed structure and standards.

## Documentation

- `docs/prd.md` - Product requirements
- `docs/project-conventions.md` - Code standards
- `CLAUDE.md` - AI assistant guidance

## License

Personal project - not for commercial distribution.
