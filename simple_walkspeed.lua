-- Simple Walkspeed Changer (No GUI)
-- Usage: Change the SPEED variable below or use the functions

local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Configuration
local SPEED = 50  -- Change this value to set your desired speed

-- Function to set walkspeed
local function setSpeed(speed)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    humanoid.WalkSpeed = speed
    print("Walkspeed set to: " .. speed)
end

-- Function to get current walkspeed
local function getSpeed()
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        return character.Humanoid.WalkSpeed
    end
    return 16
end

-- Apply the speed
setSpeed(SPEED)

-- Preset speeds (uncomment the one you want)
-- setSpeed(16)   -- Normal
-- setSpeed(30)   -- Fast
-- setSpeed(50)   -- Very Fast
-- setSpeed(100)  -- Super Fast
-- setSpeed(200)  -- Ultra Fast

print("Simple Walkspeed Changer loaded!")
print("Current speed: " .. getSpeed())
print("To change speed, modify the SPEED variable at the top of the script")