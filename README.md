# Walkspeed Changer Scripts for Roblox

This collection provides multiple walkspeed changer scripts for Roblox, ranging from simple one-liners to advanced GUI-based solutions.

## 📁 Available Scripts

### 1. `safe_walkspeed_changer.lua` - Anti-Detection Version ⭐ **RECOMMENDED**
**Features:**
- **Anti-cheat protection** - Detects and bypasses common anti-cheat systems
- **System freeze prevention** - Built-in safeguards to prevent crashes
- **Alternative movement methods** - CFrame and BodyVelocity for problematic games
- **Gradual speed changes** - Avoids detection with smooth transitions
- **Error handling** - Comprehensive pcall protection and recovery
- **Mobile optimization** - Reduced resource usage for mobile devices
- **Emergency reset** - Automatic cleanup and reset functionality

**How to use:**
1. Copy the script from `safe_walkspeed_changer.lua`
2. Execute in your script executor
3. Use keybinds: **G** (toggle), **H** (reset), **J/K** (adjust speed)
4. For problematic games, enable alternative methods:
   ```lua
   SafeWalkspeed.enableCFrameMethod()
   -- OR
   SafeWalkspeed.enableBodyVelocityMethod()
   ```

### 2. `walkspeed_changer.lua` - Advanced GUI Version
**Features:**
- Beautiful, draggable GUI interface
- Interactive slider for real-time speed adjustment
- Speed range: 0-100 (configurable)
- Reset button to restore default speed
- Keybind toggle (Press X to show/hide GUI)
- Auto-applies speed when character respawns
- Modern, rounded UI design

**How to use:**
1. Copy the entire script from `walkspeed_changer.lua`
2. Paste into your Roblox script executor
3. Execute the script
4. Press `X` to toggle the GUI
5. Use the slider to adjust your walkspeed
6. Click "Reset" to return to default speed (16)

### 2. `simple_walkspeed.lua` - Basic Version
**Features:**
- Lightweight and easy to understand
- Configurable walkspeed at the top of the script
- Auto-applies when character spawns
- Keybind to manually apply speed (Press Q)
- Perfect for beginners

**How to use:**
1. Open `simple_walkspeed.lua`
2. Change the `WALKSPEED` variable to your desired speed
3. Optionally change the `KEYBIND` variable
4. Copy and paste the entire script into your executor
5. Execute the script
6. Press `Q` (or your chosen keybind) to apply the speed

### 3. `oneliner_walkspeed.lua` - Quick Execution
**Features:**
- Multiple one-liner options
- Instant walkspeed change
- Advanced loadstring versions with auto-respawn
- Multiple speed presets with keybinds

**Available options:**
- **Instant:** `game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50`
- **Auto-respawn:** Keeps speed when you die/respawn
- **Multiple speeds:** Press 1,2,3,4 for different speed presets

## 🚀 Quick Start

### For Beginners:
Use the simple one-liner:
```lua
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
```

### For Advanced Users:
Use the GUI version for the best experience with interactive controls.

## ⚙️ Configuration

### Speed Values
- **Default Roblox speed:** 16
- **Recommended range:** 16-100
- **Extreme speeds:** 100+ (may cause issues in some games)

### Common Speed Values:
- `16` - Default walking speed
- `25` - Slightly faster
- `50` - Fast walking
- `100` - Very fast (use with caution)

## 🔧 Customization

### GUI Version Customization:
```lua
local config = {
    minSpeed = 0,        -- Minimum slider value
    maxSpeed = 100,      -- Maximum slider value
    currentSpeed = 16,   -- Starting speed
    keybind = Enum.KeyCode.X, -- Toggle key (change X to any key)
    enabled = true
}
```

### Simple Version Customization:
```lua
local WALKSPEED = 50  -- Your desired speed
local KEYBIND = "Q"   -- Your keybind (A-Z)
```

## 📋 Keybinds

### GUI Version:
- `X` - Toggle GUI visibility

### Simple Version:
- `Q` - Apply walkspeed (customizable)

### One-liner Multiple Speeds:
- `1` - Speed 16 (default)
- `2` - Speed 25
- `3` - Speed 50
- `4` - Speed 100

## 🛠️ Troubleshooting

### Script Not Working?
1. Make sure you're in a game, not the Roblox menu
2. Ensure your character has spawned
3. Check if the game has anti-cheat that blocks walkspeed changes
4. Try executing the script again after respawning

### GUI Not Showing?
1. Press the toggle key (X by default)
2. Check if the GUI was destroyed - re-run the script
3. Make sure you're using a compatible executor

### Speed Not Applying?
1. Some games reset walkspeed frequently - the script handles most cases
2. Try the simple version if the GUI version doesn't work
3. Some games may have server-side restrictions

## 🛡️ Anti-Cheat & Safety Information

⚠️ **CRITICAL**: Some games have strict anti-cheat systems that can:
- **Detect walkspeed modifications** and ban your account
- **Cause system freezes** on PC/mobile devices
- **Crash your game** or script executor

### Games with Strong Anti-Cheat:
- **Adopt Me** - Very strict detection
- **Arsenal** - Advanced anti-cheat, risk of bans
- **Jailbreak** - Sophisticated monitoring
- **Phantom Forces** - Military-grade protection

### **RECOMMENDED APPROACH:**
1. **Always start with `safe_walkspeed_changer.lua`** - has built-in protections
2. **Test in private servers first**
3. **Use conservative speeds (18-25 range)**
4. **Read `troubleshooting_guide.md` for game-specific solutions**

### Emergency Reset (if system freezes):
```lua
-- Paste this immediately if something goes wrong
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
```

## ⚠️ Important Notes

1. **Use Responsibly:** Don't use extreme speeds that could disrupt gameplay for others
2. **Game Compatibility:** Some games may have anti-cheat systems that detect or prevent walkspeed changes
3. **Server Rules:** Always follow the rules of the games you're playing
4. **Executor Required:** These scripts require a Roblox script executor to run
5. **System Safety:** Monitor your device performance and stop if experiencing lag/freezing

## 🔄 Updates

The scripts automatically handle:
- Character respawning
- Death/reset events
- Game teleportation (in most cases)

## 📝 License

These scripts are provided for educational purposes. Use responsibly and follow Roblox's Terms of Service.

---

**Enjoy your enhanced Roblox experience!** 🎮