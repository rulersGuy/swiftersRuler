-- Simple Walkspeed Changer
-- Basic version with minimal code

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Configuration
local WALKSPEED = 50  -- Change this value to set your desired walkspeed
local KEYBIND = "Q"   -- Press Q to set walkspeed

-- Function to set walkspeed
local function setWalkspeed(speed)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = speed
        print("Walkspeed set to: " .. speed)
    end
end

-- Function to reset walkspeed to default
local function resetWalkspeed()
    setWalkspeed(16) -- Default Roblox walkspeed
end

-- Apply walkspeed when character spawns
local function onCharacterAdded(character)
    local humanoid = character:WaitForChild("Humanoid")
    wait(0.1) -- Small delay to ensure character is fully loaded
    setWalkspeed(WALKSPEED)
end

-- Connect to character spawning
if player.Character then
    onCharacterAdded(player.Character)
end
player.CharacterAdded:Connect(onCharacterAdded)

-- Keybind to manually set walkspeed
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode[KEYBIND] then
        setWalkspeed(WALKSPEED)
    end
end)

print("Simple Walkspeed Changer loaded!")
print("Press " .. KEYBIND .. " to set walkspeed to " .. WALKSPEED)
print("Change WALKSPEED variable at the top to adjust speed")