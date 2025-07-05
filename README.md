# Walkspeed Changer Scripts

This repository contains three different walkspeed changer scripts for Roblox, each designed for different use cases and preferences.

## 📁 Files Included

### 1. `walkspeed_changer.lua` - Full GUI Version
**Best for:** Users who want a complete interface with lots of features

**Features:**
- 🎨 Modern, draggable GUI interface
- 📊 Real-time speed display
- ⌨️ Custom speed input (1-1000)
- 🎯 6 preset speed buttons
- ✨ Button animations and visual feedback
- 🔄 Auto-updates when character respawns
- ❌ Close button to hide GUI

**How to use:**
1. Execute the script
2. Use the GUI to change walkspeed
3. Drag the window to move it around
4. Click "Close" to hide the GUI

### 2. `simple_walkspeed.lua` - Basic Version
**Best for:** Users who want a quick, no-fuss solution

**Features:**
- 🎯 Simple speed setting
- 📝 Easy to modify
- 💻 Console output
- 🔧 Function-based approach

**How to use:**
1. Open the script
2. Change the `SPEED` variable to your desired speed
3. Execute the script
4. Your walkspeed will be set instantly

### 3. `hotkey_walkspeed.lua` - Hotkey Version
**Best for:** Users who want quick speed changes during gameplay

**Features:**
- ⌨️ Keyboard hotkeys for instant speed changes
- 📢 In-game chat notifications
- 🎯 5 preset speeds + reset
- 📝 Console feedback

**Hotkeys:**
- `1` = Walk (16)
- `2` = Run (30)
- `3` = Fast (50)
- `4` = Super (100)
- `5` = Ultra (200)
- `R` = Reset (16)

## 🚀 Quick Start

1. **Choose your preferred version** based on your needs
2. **Copy the script content**
3. **Paste into your script executor**
4. **Execute the script**
5. **Enjoy your new walkspeed!**

## ⚙️ Configuration

### Speed Ranges
- **Minimum:** 1
- **Maximum:** 1000
- **Default:** 16 (Roblox default)

### Common Speeds
- **Walk:** 16 (default)
- **Jog:** 25-30
- **Run:** 40-50
- **Sprint:** 75-100
- **Super Speed:** 150+

## 🛠️ Customization

### Adding New Presets (GUI Version)
Edit the `presets` table in `walkspeed_changer.lua`:
```lua
{name = "Custom", speed = 75, color = Color3.fromRGB(255, 255, 100)}
```

### Changing Hotkeys (Hotkey Version)
Modify the `SPEEDS` table in `hotkey_walkspeed.lua`:
```lua
[Enum.KeyCode.Q] = {speed = 75, name = "Custom"}
```

### Changing Default Speed (Simple Version)
Change the `SPEED` variable in `simple_walkspeed.lua`:
```lua
local SPEED = 75  -- Your desired speed here
```

## 📋 Requirements

- **Platform:** Roblox
- **Executor:** Any Lua script executor
- **Permissions:** LocalPlayer access

## ⚠️ Notes

- These scripts only affect your local walkspeed
- Other players won't see the speed changes on their end
- Speed changes persist until character respawn (GUI version auto-reapplies)
- Some games may have anti-cheat that resets walkspeed

## 🎯 Recommended Versions

- **New Users:** `walkspeed_changer.lua` (GUI version)
- **Quick Setup:** `simple_walkspeed.lua`
- **Advanced Users:** `hotkey_walkspeed.lua`

## 🐛 Troubleshooting

**Script not working?**
- Make sure you have a valid character spawned
- Check if the game has anti-cheat systems
- Try rejoining the game

**GUI not appearing?**
- The GUI might be off-screen - try executing again
- Check if your executor supports GUI creation

**Hotkeys not working?**
- Make sure you're not typing in chat
- Check if the game overrides key inputs

---

*Created with ❤️ for the Roblox scripting community*