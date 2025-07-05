-- Walkspeed Changer Script
-- Author: Assistant
-- Description: A GUI-based walkspeed changer with presets and custom input

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Configuration
local CONFIG = {
    DEFAULT_WALKSPEED = 16,
    MIN_WALKSPEED = 1,
    MAX_WALKSPEED = 1000,
    GUI_SIZE = UDim2.new(0, 300, 0, 400),
    TWEEN_TIME = 0.3
}

-- Create GUI
local function createGUI()
    -- Main ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "WalkspeedChanger"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = CONFIG.GUI_SIZE
    mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    -- Add corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = mainFrame
    
    -- Add stroke
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(85, 170, 255)
    stroke.Thickness = 2
    stroke.Parent = mainFrame
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "🚶 Walkspeed Changer"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = mainFrame
    
    -- Current Speed Display
    local currentSpeedLabel = Instance.new("TextLabel")
    currentSpeedLabel.Name = "CurrentSpeed"
    currentSpeedLabel.Size = UDim2.new(1, -20, 0, 30)
    currentSpeedLabel.Position = UDim2.new(0, 10, 0, 60)
    currentSpeedLabel.BackgroundTransparency = 1
    currentSpeedLabel.Text = "Current Speed: " .. CONFIG.DEFAULT_WALKSPEED
    currentSpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    currentSpeedLabel.TextScaled = true
    currentSpeedLabel.Font = Enum.Font.Gotham
    currentSpeedLabel.Parent = mainFrame
    
    -- Custom Input Section
    local inputLabel = Instance.new("TextLabel")
    inputLabel.Name = "InputLabel"
    inputLabel.Size = UDim2.new(1, -20, 0, 25)
    inputLabel.Position = UDim2.new(0, 10, 0, 100)
    inputLabel.BackgroundTransparency = 1
    inputLabel.Text = "Custom Speed:"
    inputLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    inputLabel.TextScaled = true
    inputLabel.Font = Enum.Font.Gotham
    inputLabel.TextXAlignment = Enum.TextXAlignment.Left
    inputLabel.Parent = mainFrame
    
    -- Custom Input TextBox
    local customInput = Instance.new("TextBox")
    customInput.Name = "CustomInput"
    customInput.Size = UDim2.new(0.6, -10, 0, 35)
    customInput.Position = UDim2.new(0, 10, 0, 130)
    customInput.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    customInput.BorderSizePixel = 0
    customInput.Text = ""
    customInput.PlaceholderText = "Enter speed (1-1000)"
    customInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    customInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    customInput.TextScaled = true
    customInput.Font = Enum.Font.Gotham
    customInput.Parent = mainFrame
    
    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 5)
    inputCorner.Parent = customInput
    
    -- Apply Custom Button
    local applyCustomBtn = Instance.new("TextButton")
    applyCustomBtn.Name = "ApplyCustom"
    applyCustomBtn.Size = UDim2.new(0.35, -10, 0, 35)
    applyCustomBtn.Position = UDim2.new(0.65, 0, 0, 130)
    applyCustomBtn.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
    applyCustomBtn.BorderSizePixel = 0
    applyCustomBtn.Text = "Apply"
    applyCustomBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    applyCustomBtn.TextScaled = true
    applyCustomBtn.Font = Enum.Font.GothamBold
    applyCustomBtn.Parent = mainFrame
    
    local applyCorner = Instance.new("UICorner")
    applyCorner.CornerRadius = UDim.new(0, 5)
    applyCorner.Parent = applyCustomBtn
    
    -- Preset Speeds Section
    local presetLabel = Instance.new("TextLabel")
    presetLabel.Name = "PresetLabel"
    presetLabel.Size = UDim2.new(1, -20, 0, 25)
    presetLabel.Position = UDim2.new(0, 10, 0, 180)
    presetLabel.BackgroundTransparency = 1
    presetLabel.Text = "Preset Speeds:"
    presetLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    presetLabel.TextScaled = true
    presetLabel.Font = Enum.Font.Gotham
    presetLabel.TextXAlignment = Enum.TextXAlignment.Left
    presetLabel.Parent = mainFrame
    
    -- Preset Buttons
    local presets = {
        {name = "Walk", speed = 16, color = Color3.fromRGB(100, 200, 100)},
        {name = "Run", speed = 30, color = Color3.fromRGB(255, 200, 100)},
        {name = "Fast", speed = 50, color = Color3.fromRGB(255, 150, 100)},
        {name = "Super", speed = 100, color = Color3.fromRGB(255, 100, 100)},
        {name = "Ultra", speed = 200, color = Color3.fromRGB(200, 100, 255)},
        {name = "Max", speed = 500, color = Color3.fromRGB(255, 100, 200)}
    }
    
    for i, preset in ipairs(presets) do
        local row = math.floor((i - 1) / 2)
        local col = (i - 1) % 2
        
        local presetBtn = Instance.new("TextButton")
        presetBtn.Name = "Preset" .. preset.name
        presetBtn.Size = UDim2.new(0.45, -5, 0, 35)
        presetBtn.Position = UDim2.new(0.05 + col * 0.5, 0, 0, 210 + row * 45)
        presetBtn.BackgroundColor3 = preset.color
        presetBtn.BorderSizePixel = 0
        presetBtn.Text = preset.name .. " (" .. preset.speed .. ")"
        presetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        presetBtn.TextScaled = true
        presetBtn.Font = Enum.Font.GothamBold
        presetBtn.Parent = mainFrame
        
        local presetCorner = Instance.new("UICorner")
        presetCorner.CornerRadius = UDim.new(0, 5)
        presetCorner.Parent = presetBtn
        
        -- Store speed value for easy access
        presetBtn:SetAttribute("Speed", preset.speed)
    end
    
    -- Reset Button
    local resetBtn = Instance.new("TextButton")
    resetBtn.Name = "Reset"
    resetBtn.Size = UDim2.new(0.45, -5, 0, 35)
    resetBtn.Position = UDim2.new(0.05, 0, 0, 345)
    resetBtn.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
    resetBtn.BorderSizePixel = 0
    resetBtn.Text = "Reset (16)"
    resetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    resetBtn.TextScaled = true
    resetBtn.Font = Enum.Font.GothamBold
    resetBtn.Parent = mainFrame
    
    local resetCorner = Instance.new("UICorner")
    resetCorner.CornerRadius = UDim.new(0, 5)
    resetCorner.Parent = resetBtn
    
    -- Close Button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "Close"
    closeBtn.Size = UDim2.new(0.45, -5, 0, 35)
    closeBtn.Position = UDim2.new(0.55, 0, 0, 345)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 100, 100)
    closeBtn.BorderSizePixel = 0
    closeBtn.Text = "Close"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextScaled = true
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = mainFrame
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 5)
    closeCorner.Parent = closeBtn
    
    return screenGui, mainFrame, customInput, applyCustomBtn, resetBtn, closeBtn, currentSpeedLabel
end

-- Walkspeed Functions
local function setWalkspeed(speed)
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        local humanoid = character.Humanoid
        
        -- Clamp speed to valid range
        speed = math.clamp(speed, CONFIG.MIN_WALKSPEED, CONFIG.MAX_WALKSPEED)
        
        -- Set walkspeed
        humanoid.WalkSpeed = speed
        
        return speed
    end
    return nil
end

local function getCurrentWalkspeed()
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        return character.Humanoid.WalkSpeed
    end
    return CONFIG.DEFAULT_WALKSPEED
end

-- Button Animation
local function animateButton(button, scale)
    scale = scale or 0.95
    local tween = TweenService:Create(
        button,
        TweenInfo.new(CONFIG.TWEEN_TIME / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = button.Size * scale}
    )
    
    local tween2 = TweenService:Create(
        button,
        TweenInfo.new(CONFIG.TWEEN_TIME / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = button.Size}
    )
    
    tween:Play()
    tween.Completed:Connect(function()
        tween2:Play()
    end)
end

-- Main Function
local function main()
    -- Create GUI
    local screenGui, mainFrame, customInput, applyCustomBtn, resetBtn, closeBtn, currentSpeedLabel = createGUI()
    screenGui.Parent = playerGui
    
    -- Update current speed display
    local function updateSpeedDisplay()
        local currentSpeed = getCurrentWalkspeed()
        currentSpeedLabel.Text = "Current Speed: " .. math.floor(currentSpeed)
    end
    
    -- Initial speed display update
    updateSpeedDisplay()
    
    -- Custom Input Handler
    applyCustomBtn.MouseButton1Click:Connect(function()
        animateButton(applyCustomBtn)
        
        local inputText = customInput.Text
        local speed = tonumber(inputText)
        
        if speed then
            local actualSpeed = setWalkspeed(speed)
            if actualSpeed then
                customInput.Text = ""
                updateSpeedDisplay()
                
                -- Success feedback
                customInput.PlaceholderText = "Applied: " .. actualSpeed
                wait(2)
                customInput.PlaceholderText = "Enter speed (1-1000)"
            end
        else
            -- Error feedback
            customInput.Text = ""
            customInput.PlaceholderText = "Invalid number!"
            customInput.PlaceholderColor3 = Color3.fromRGB(255, 100, 100)
            wait(2)
            customInput.PlaceholderText = "Enter speed (1-1000)"
            customInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
        end
    end)
    
    -- Enter key support for custom input
    customInput.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            applyCustomBtn.MouseButton1Click:Fire()
        end
    end)
    
    -- Preset Button Handlers
    for _, child in ipairs(mainFrame:GetChildren()) do
        if child:IsA("TextButton") and child.Name:sub(1, 6) == "Preset" then
            child.MouseButton1Click:Connect(function()
                animateButton(child)
                
                local speed = child:GetAttribute("Speed")
                if speed then
                    setWalkspeed(speed)
                    updateSpeedDisplay()
                end
            end)
        end
    end
    
    -- Reset Button Handler
    resetBtn.MouseButton1Click:Connect(function()
        animateButton(resetBtn)
        setWalkspeed(CONFIG.DEFAULT_WALKSPEED)
        updateSpeedDisplay()
    end)
    
    -- Close Button Handler
    closeBtn.MouseButton1Click:Connect(function()
        animateButton(closeBtn, 0.9)
        wait(CONFIG.TWEEN_TIME)
        screenGui:Destroy()
    end)
    
    -- Make GUI draggable
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)
    
    mainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    mainFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    -- Update speed display when character spawns
    player.CharacterAdded:Connect(function()
        wait(1) -- Wait for humanoid to load
        updateSpeedDisplay()
    end)
    
    print("Walkspeed Changer loaded successfully!")
    print("Current walkspeed: " .. getCurrentWalkspeed())
end

-- Execute
main()