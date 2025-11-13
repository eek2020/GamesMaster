# Quick Start Guide

## For You (Setting Up)

### Step 1: Get Dependencies

1. **Download RetroArch**
   - Go to <https://www.retroarch.com/?page=platforms>
   - Download the macOS version (Apple Silicon)
   - Open the DMG and copy `RetroArch.app` to `vendor/retroarch/`

2. **Get the ROM**
   - Obtain `sf2ce.zip` (Street Fighter 2 Champion Edition)
   - Place it in `vendor/roms/`
   - **Important**: Give your friend the exact same ROM file

### Step 2: Run Installer

```bash
./src/installer/install-retroarch.sh
```

This will:
- Install RetroArch to `/Applications`
- Download the FBNeo core
- Copy the ROM to the right location
- Configure netplay settings

### Step 3: Test the Launcher

```bash
./src/launcher/launch-sf2.sh
```

Choose "Host Game" to test hosting.

---

## For Your Friend

### Option A: Send Them the Scripts

1. Send them:
   - `src/installer/install-retroarch.sh`
   - `src/launcher/launch-sf2.sh`
   - `vendor/retroarch/RetroArch.app` (if you can share it)
   - `vendor/roms/sf2ce.zip` (the exact same file you're using)

2. They run the installer, then the launcher

### Option B: Build App Bundles (Coming Soon)

We'll create `.app` bundles that they can just double-click.

---

## Playing Together

### You (Host):

1. Run launcher: `./src/launcher/launch-sf2.sh`
2. Choose option `1` (Host Game)
3. Tell your friend you're hosting

### Your Friend (Client):

1. Run launcher: `./src/launcher/launch-sf2.sh`
2. Choose option `2` (Join Game)
3. Press ENTER to use relay server
4. Game should connect automatically

---

## Troubleshooting

### "RetroArch not found"
- Make sure you ran the installer first
- Check that RetroArch is in `/Applications`

### "ROM not found"
- Run the installer again
- Verify `sf2ce.zip` is in `vendor/roms/`

### "Connection failed"
- Both players must use the exact same ROM file
- Try using relay server (just press ENTER when asked for host address)
- Check internet connection

### "Controller not working"
- Plug in controller before launching
- RetroArch should auto-detect most controllers
- You can also use keyboard: Arrow keys + Z/X/A/S

---

## Next Steps

- Test with your friend on the same network first
- Then test over internet using relay servers
- Report any issues for fixes
