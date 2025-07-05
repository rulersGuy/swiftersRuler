-- Walkspeed Changer with Hotkeys
-- Hotkeys: 1=Walk, 2=Run, 3=Fast, 4=Super, 5=Ultra, R=Reset

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- Speed presets
local SPEEDS = {
    [Enum.KeyCode.One] = {speed = 16, name = "Walk"},
    [Enum.KeyCode.Two] = {speed = 30, name = "Run"},
    [Enum.KeyCode.Three] = {speed = 50, name = "Fast"},
    [Enum.KeyCode.Four] = {speed = 100, name = "Super"},
    [Enum.KeyCode.Five] = {speed = 200, name = "Ultra"},
    [Enum.KeyCode.R] = {speed = 16, name = "Reset"}
}

-- Function to set walkspeed
local function setWalkspeed(speed, name)
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.WalkSpeed = speed
        
        -- Create notification
        game.StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = "Walkspeed set to " .. name .. " (" .. speed .. ")";
            Color = Color3.fromRGB(85, 170, 255);
            Font = Enum.Font.GothamBold;
            FontSize = Enum.FontSize.Size18;
        })
        
        print("Walkspeed: " .. name .. " (" .. speed .. ")")
    end
end

-- Function to get current walkspeed
local function getCurrentSpeed()
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        return character.Humanoid.WalkSpeed
    end
    return 16
end

-- Handle hotkeys
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    local speedData = SPEEDS[input.KeyCode]
    if speedData then
        setWalkspeed(speedData.speed, speedData.name)
    end
end)

-- Initial setup
print("=== Walkspeed Changer with Hotkeys ===")
print("Controls:")
print("1 = Walk (16)")
print("2 = Run (30)")
print("3 = Fast (50)")
print("4 = Super (100)")
print("5 = Ultra (200)")
print("R = Reset (16)")
print("=====================================")
print("Current speed: " .. getCurrentSpeed())

-- Set initial notification
game.StarterGui:SetCore("ChatMakeSystemMessage", {
    Text = "Walkspeed Changer loaded! Use keys 1-5 or R to change speed.";
    Color = Color3.fromRGB(100, 255, 100);
    Font = Enum.Font.Gotham;
    FontSize = Enum.FontSize.Size14;
})