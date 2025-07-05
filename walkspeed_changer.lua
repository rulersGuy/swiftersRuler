-- Walkspeed Changer Script for Roblox
-- Simple and clean implementation

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local defaultWalkSpeed = 16

-- Configuration
local config = {
    minSpeed = 0,
    maxSpeed = 100,
    currentSpeed = 16,
    keybind = Enum.KeyCode.X, -- Press X to toggle GUI
    enabled = true
}

-- Create GUI
local function createGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "WalkspeedChanger"
    screenGui.ResetOnSpawn = false
    
    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 250, 0, 150)
    mainFrame.Position = UDim2.new(0, 10, 0, 10)
    mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui
    
    -- Corner rounding
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = mainFrame
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "Walkspeed Changer"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 16
    title.Font = Enum.Font.GothamBold
    title.Parent = mainFrame
    
    -- Speed Label
    local speedLabel = Instance.new("TextLabel")
    speedLabel.Name = "SpeedLabel"
    speedLabel.Size = UDim2.new(1, -20, 0, 20)
    speedLabel.Position = UDim2.new(0, 10, 0, 40)
    speedLabel.BackgroundTransparency = 1
    speedLabel.Text = "Speed: " .. config.currentSpeed
    speedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    speedLabel.TextSize = 14
    speedLabel.Font = Enum.Font.Gotham
    speedLabel.TextXAlignment = Enum.TextXAlignment.Left
    speedLabel.Parent = mainFrame
    
    -- Speed Slider
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Name = "SliderFrame"
    sliderFrame.Size = UDim2.new(1, -20, 0, 20)
    sliderFrame.Position = UDim2.new(0, 10, 0, 70)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    sliderFrame.BorderSizePixel = 0
    sliderFrame.Parent = mainFrame
    
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 4)
    sliderCorner.Parent = sliderFrame
    
    local slider = Instance.new("Frame")
    slider.Name = "Slider"
    slider.Size = UDim2.new(config.currentSpeed / config.maxSpeed, 0, 1, 0)
    slider.Position = UDim2.new(0, 0, 0, 0)
    slider.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
    slider.BorderSizePixel = 0
    slider.Parent = sliderFrame
    
    local sliderKnobCorner = Instance.new("UICorner")
    sliderKnobCorner.CornerRadius = UDim.new(0, 4)
    sliderKnobCorner.Parent = slider
    
    -- Buttons Frame
    local buttonsFrame = Instance.new("Frame")
    buttonsFrame.Name = "ButtonsFrame"
    buttonsFrame.Size = UDim2.new(1, -20, 0, 30)
    buttonsFrame.Position = UDim2.new(0, 10, 0, 100)
    buttonsFrame.BackgroundTransparency = 1
    buttonsFrame.Parent = mainFrame
    
    -- Reset Button
    local resetButton = Instance.new("TextButton")
    resetButton.Name = "ResetButton"
    resetButton.Size = UDim2.new(0.48, 0, 1, 0)
    resetButton.Position = UDim2.new(0, 0, 0, 0)
    resetButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    resetButton.BorderSizePixel = 0
    resetButton.Text = "Reset"
    resetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    resetButton.TextSize = 12
    resetButton.Font = Enum.Font.Gotham
    resetButton.Parent = buttonsFrame
    
    local resetCorner = Instance.new("UICorner")
    resetCorner.CornerRadius = UDim.new(0, 4)
    resetCorner.Parent = resetButton
    
    -- Close Button
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0.48, 0, 1, 0)
    closeButton.Position = UDim2.new(0.52, 0, 0, 0)
    closeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    closeButton.BorderSizePixel = 0
    closeButton.Text = "Close"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextSize = 12
    closeButton.Font = Enum.Font.Gotham
    closeButton.Parent = buttonsFrame
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 4)
    closeCorner.Parent = closeButton
    
    return screenGui, speedLabel, slider, sliderFrame, resetButton, closeButton
end

-- Set walkspeed function
local function setWalkSpeed(speed)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = speed
        config.currentSpeed = speed
    end
end

-- Main script
local function main()
    local gui, speedLabel, slider, sliderFrame, resetButton, closeButton = createGUI()
    gui.Parent = player:WaitForChild("PlayerGui")
    
    local dragging = false
    
    -- Slider functionality
    local function updateSlider(input)
        local relativeX = math.clamp((input.Position.X - sliderFrame.AbsolutePosition.X) / sliderFrame.AbsoluteSize.X, 0, 1)
        local newSpeed = math.floor(config.minSpeed + (relativeX * (config.maxSpeed - config.minSpeed)))
        
        config.currentSpeed = newSpeed
        slider.Size = UDim2.new(relativeX, 0, 1, 0)
        speedLabel.Text = "Speed: " .. newSpeed
        setWalkSpeed(newSpeed)
    end
    
    -- Slider input handling
    sliderFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateSlider(input)
        end
    end)
    
    sliderFrame.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateSlider(input)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    -- Reset button
    resetButton.MouseButton1Click:Connect(function()
        config.currentSpeed = defaultWalkSpeed
        local relativeX = config.currentSpeed / config.maxSpeed
        slider.Size = UDim2.new(relativeX, 0, 1, 0)
        speedLabel.Text = "Speed: " .. config.currentSpeed
        setWalkSpeed(config.currentSpeed)
    end)
    
    -- Close button
    closeButton.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)
    
    -- Toggle GUI with keybind
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == config.keybind then
            gui.Enabled = not gui.Enabled
        end
    end)
    
    -- Auto-apply speed when character spawns
    local function onCharacterAdded(character)
        local humanoid = character:WaitForChild("Humanoid")
        setWalkSpeed(config.currentSpeed)
    end
    
    if player.Character then
        onCharacterAdded(player.Character)
    end
    
    player.CharacterAdded:Connect(onCharacterAdded)
    
    print("Walkspeed Changer loaded! Press " .. config.keybind.Name .. " to toggle GUI")
end

-- Initialize
main()