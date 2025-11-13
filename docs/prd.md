# Product Requirements Document (PRD)
## Games Master - RetroArch Netplay Installer

**Version**: 1.0
**Last Updated**: 2025-11-12
**Status**: Planning

---

## 1. Executive Summary

### Vision
Enable non-technical users to play retro arcade games online with friends through a seamless, one-click installation experience on macOS.

### Problem Statement
Playing retro games online requires technical knowledge (emulator setup, core installation, netplay configuration, port forwarding, controller mapping). This complexity prevents casual users from enjoying online multiplayer with friends.

### Solution
A packaged installer that handles all technical setup automatically, delivering a "download and play" experience comparable to modern gaming platforms.

---

## 2. Goals and Non-Goals

### Goals
✅ **Zero-configuration installation** - No terminal commands, no manual config file editing
✅ **Automatic controller support** - Detect and configure any connected game controller
✅ **Simple networking** - Use RetroArch relay servers to avoid port forwarding
✅ **One-click launching** - Double-click to connect and play
✅ **Cross-version compatibility** - Works on M1, M2, M3+ Apple Silicon Macs

### Non-Goals
❌ Not building a custom emulator (using RetroArch)
❌ Not supporting Intel Macs (Apple Silicon only)
❌ Not providing ROMs (user must supply)
❌ Not a game library manager (focused on single game setup)
❌ Not supporting Windows/Linux (macOS only for v1.0)

---

## 3. Target Users

### Primary User Persona: "The Nostalgic Gamer"
- **Age**: 30-45
- **Technical skill**: Basic (can install apps, use web browser)
- **Gaming background**: Grew up with arcade/console games
- **Goal**: Relive childhood gaming memories with old friends
- **Pain points**:
  - Intimidated by emulator configuration
  - Doesn't understand networking concepts
  - Limited time to troubleshoot

### Secondary User Persona: "The Tech-Savvy Friend"
- **Age**: 25-50
- **Technical skill**: Intermediate to advanced
- **Role**: The person setting up the game for their less technical friend
- **Goal**: Provide a working setup that "just works" without support calls
- **Pain points**:
  - Tired of walking friends through technical setups
  - Wants to package everything once and distribute

---

## 4. User Stories

### Installation Phase

**US-001**: As a user, I want to download a single file and drag it to my Applications folder, so I can install the game without complexity.

**US-002**: As a user, when I first run the installer, it should automatically download and configure all dependencies without asking me questions.

**US-003**: As a user, I want clear progress feedback during installation, so I know the process is working and haven't frozen.

**US-004**: As a user, if installation fails, I want a clear error message explaining what went wrong and how to fix it.

### Controller Setup

**US-005**: As a user, when I plug in my controller, it should automatically be detected and configured without manual button mapping.

**US-006**: As a user, I want to test my controller before launching the game, so I know it works correctly.

**US-007**: As a user, if no controller is detected, I want to be prompted to connect one or be told I can use keyboard controls.

### Network Play

**US-008**: As a client user, I want to connect to my friend's game by just launching the app, without entering IP addresses or port numbers.

**US-009**: As a host user, I want to start hosting by clicking one button and share a simple connection code with my friend.

**US-010**: As a user, I want to see connection quality indicators (ping, lag) so I understand if performance issues are network-related.

**US-011**: As a user, if the connection fails, I want troubleshooting suggestions rather than cryptic error codes.

### Gameplay

**US-012**: As a user, once connected, the game should launch automatically without additional configuration.

**US-013**: As a user, I want the ability to quit the game and return to the launcher without force-quitting.

**US-014**: As a user, save states should be disabled in netplay to prevent cheating/desync.

---

## 5. Features and Requirements

### 5.1 Installer App ("SF2 Installer.app")

| Feature | Priority | Description | Acceptance Criteria |
|---------|----------|-------------|---------------------|
| **One-click install** | P0 | Install all components with single app launch | User opens app, clicks "Install", everything works |
| **Dependency download** | P0 | Download FBNeo core automatically | Core downloads and installs without user action |
| **ROM placement** | P0 | Copy ROM to correct RetroArch directory | ROM accessible to RetroArch after install |
| **Config generation** | P0 | Create netplay-ready RetroArch config | Config enables netplay, relay servers, proper input |
| **Progress indication** | P1 | Show install progress with descriptive steps | User sees: "Downloading core... 45%" |
| **Error handling** | P1 | Graceful failures with actionable messages | "Network error: Check internet connection" |
| **Uninstaller** | P2 | Optional cleanup utility | Removes all installed components |

### 5.2 Launcher App ("SF2 Launcher.app")

| Feature | Priority | Description | Acceptance Criteria |
|---------|----------|-------------|---------------------|
| **Controller detection** | P0 | Auto-detect connected controllers | Any HID gamepad recognized on launch |
| **Host mode** | P0 | Start hosting with one button | Creates host session, shows connection info |
| **Client mode** | P0 | Connect to host with one button | Enters connection code, joins game |
| **Connection code** | P0 | Generate/enter simple join codes | 6-digit code easier than IP:PORT |
| **Auto-reconnect** | P1 | Rejoin if connection drops briefly | Handles momentary network hiccups |
| **Quick restart** | P1 | Return to launcher after game quits | No need to reopen app |
| **Network test** | P2 | Test connection before launching game | "Ping: 45ms - Good connection" |

### 5.3 Configuration Management

| Feature | Priority | Description | Acceptance Criteria |
|---------|----------|-------------|---------------------|
| **Default controls** | P0 | Pre-map keyboard controls | Arrow keys + Z/X/A/S work immediately |
| **Controller mapping** | P0 | Standard mapping for common controllers | Xbox/PS/Switch controllers work correctly |
| **Netplay settings** | P0 | Optimal settings for SF2 netplay | Input delay, spectator mode, etc. |
| **Relay server config** | P0 | Use RetroArch public relays | No port forwarding required |
| **Persistent settings** | P1 | Remember user preferences | Doesn't reset controller config each launch |

---

## 6. Technical Requirements

### 6.1 Platform Support
- macOS 12.0 (Monterey) or later
- Apple Silicon only (M1, M2, M3, M4+)
- 2GB free disk space
- Internet connection for initial setup

### 6.2 Performance
- Installer completes in < 5 minutes on 10Mbps connection
- Launcher opens in < 3 seconds
- Game launches in < 5 seconds after connection established
- Network latency < 100ms for playable experience

### 6.3 Reliability
- 99% success rate on supported systems
- Graceful degradation if optional features unavailable
- No crashes during normal operation

### 6.4 Security
- No network traffic except RetroArch netplay protocol
- No telemetry or analytics
- No persistent storage of user data
- Sandboxed app execution where possible

---

## 7. User Interface

### 7.1 Installer UI
```
┌─────────────────────────────────────┐
│  SF2 Championship Edition Installer │
│                                     │
│  [Icon]                             │
│                                     │
│  Ready to install RetroArch and     │
│  Street Fighter 2 for online play.  │
│                                     │
│  ┌───────────────────────────────┐  │
│  │      Install (2.1 GB)         │  │
│  └───────────────────────────────┘  │
│                                     │
│  This will install to:              │
│  ~/Library/Application Support/     │
│  RetroArch                          │
│                                     │
└─────────────────────────────────────┘
```

### 7.2 Launcher UI (Host)
```
┌─────────────────────────────────────┐
│  Street Fighter 2: Online           │
│                                     │
│  Controller: Xbox Controller ✓      │
│                                     │
│  ┌───────────────────────────────┐  │
│  │      Host Game                │  │
│  └───────────────────────────────┘  │
│                                     │
│  ┌───────────────────────────────┐  │
│  │      Join Game                │  │
│  └───────────────────────────────┘  │
│                                     │
│  [⚙️ Settings]                      │
└─────────────────────────────────────┘
```

### 7.3 Launcher UI (Hosting)
```
┌─────────────────────────────────────┐
│  Waiting for Player 2...            │
│                                     │
│  Share this code:                   │
│                                     │
│  ╔═══════════╗                      │
│  ║  4 7 2 9  ║                      │
│  ╚═══════════╝                      │
│                                     │
│  [Copy Code]  [Cancel]              │
│                                     │
│  Tip: Your friend needs to          │
│  click "Join Game" and enter        │
│  this code.                         │
└─────────────────────────────────────┘
```

---

## 8. Success Metrics

### Launch Metrics (First 30 Days)
- **Installation success rate**: > 95%
- **Time to first game**: < 15 minutes from download
- **User-reported issues**: < 5% of installations

### Quality Metrics
- **Crash rate**: < 0.1% of sessions
- **Connection success rate**: > 90%
- **Controller detection rate**: > 95% for major brands

### User Satisfaction (if collecting feedback)
- **Would recommend**: > 80%
- **Setup difficulty rating**: < 3/10 (1=easiest, 10=hardest)

---

## 9. Out of Scope (Future Versions)

### Version 2.0 Candidates
- Support for multiple games
- Built-in voice chat
- Tournament/lobby system
- Replay recording and sharing
- Custom ROM artwork
- Intel Mac support

### Version 3.0+ Ideas
- Windows/Linux support
- Mobile companion app
- Cloud save states
- Matchmaking service

---

## 10. Open Questions

1. **Connection Code System**: Should we build our own relay/matching service, or use RetroArch's built-in relay with manual codes?
   - **Decision needed by**: Before MVP implementation
   - **Decision maker**: Technical lead

2. **ROM Distribution**: How do we handle ROM file distribution legally?
   - **Current stance**: User must provide their own ROM
   - **Risk**: May prevent truly "one-file" distribution

3. **Auto-update mechanism**: Should the app check for updates?
   - **Complexity**: Requires update server or GitHub releases
   - **Benefit**: Bug fixes and improvements reach users

4. **Multiple game support**: Should v1.0 support multiple games or focus on SF2?
   - **Current**: Single game focus for simplicity
   - **Trade-off**: Limits appeal but ensures quality

---

## 11. Dependencies and Risks

### External Dependencies
| Dependency | Risk Level | Mitigation |
|------------|------------|------------|
| RetroArch availability | Low | Download and bundle specific version |
| FBNeo core availability | Low | Bundle core or host mirror |
| RetroArch relay servers | Medium | Document alternative (port forwarding) |
| macOS API changes | Medium | Test on each macOS version |

### Project Risks
| Risk | Impact | Probability | Mitigation |
|------|--------|-------------|------------|
| Controller compatibility issues | High | Medium | Test with 10+ controller models |
| Network performance unacceptable | High | Low | Set expectations, provide latency test |
| Apple security restrictions block app | High | Low | Code signing, notarization |
| RetroArch config changes break setup | Medium | Low | Lock to specific RetroArch version |

---

## 12. Timeline and Milestones

### Phase 1: Foundation (Week 1-2)
- [ ] Project structure and conventions
- [ ] Development environment setup
- [ ] Basic installer shell script
- [ ] RetroArch integration proof of concept

### Phase 2: Core Features (Week 3-4)
- [ ] Installer app bundle with UI
- [ ] Automatic core download
- [ ] Config generation
- [ ] Controller detection

### Phase 3: Networking (Week 5-6)
- [ ] Launcher app UI
- [ ] Host/client mode implementation
- [ ] Connection code system
- [ ] Testing on multiple networks

### Phase 4: Polish (Week 7-8)
- [ ] Error handling and user feedback
- [ ] Icon and visual design
- [ ] Testing on various Mac models
- [ ] DMG packaging

### Phase 5: Release (Week 9)
- [ ] Final testing
- [ ] Documentation
- [ ] Distribution preparation

---

## 13. Approval and Sign-off

| Role | Name | Status | Date |
|------|------|--------|------|
| Product Owner | Eric | Pending | - |
| Technical Lead | - | Pending | - |
| Designer | - | N/A | - |

---

**Document History**
- 2025-11-12: Initial version created
