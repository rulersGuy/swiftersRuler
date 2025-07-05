-- Safe Walkspeed Changer with Anti-Detection
-- Designed to work around anti-cheat systems and prevent freezing

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Safety Configuration
local config = {
    maxSafeSpeed = 25,  -- Conservative max speed to avoid detection
    minSpeed = 1,
    defaultSpeed = 16,
    currentSpeed = 16,
    
    -- Anti-detection settings
    useGradualChange = true,    -- Gradually change speed instead of instant
    randomizeSpeed = true,      -- Add small random variations
    respectGameLimits = true,   -- Don't exceed game's natural limits
    
    -- Alternative methods for problematic games
    useCFrameMethod = false,    -- Use CFrame teleportation instead
    useBodyVelocity = false,    -- Use BodyVelocity for movement
    
    -- Safety checks
    enableSafetyChecks = true,
    maxAttempts = 3,
    cooldownTime = 1
}

-- State tracking
local state = {
    isActive = false,
    lastChangeTime = 0,
    attemptCount = 0,
    originalSpeed = 16,
    connectionCleanup = {}
}

-- Utility Functions
local function log(message)
    print("[Safe Walkspeed] " .. message)
end

local function isGameSafe()
    -- Check if the game allows walkspeed changes
    local success, result = pcall(function()
        return humanoid.WalkSpeed
    end)
    
    if not success then
        log("Warning: Cannot access WalkSpeed property")
        return false
    end
    
    -- Check for common anti-cheat indicators
    local antiCheatNames = {
        "AntiCheat", "AC", "Security", "Detection", 
        "Monitor", "Guard", "Protection", "Shield"
    }
    
    for _, name in pairs(antiCheatNames) do
        if game:FindFirstChild(name, true) then
            log("Warning: Potential anti-cheat detected: " .. name)
            return false
        end
    end
    
    return true
end

local function safeSetWalkSpeed(speed)
    if not config.enableSafetyChecks then
        humanoid.WalkSpeed = speed
        return true
    end
    
    local currentTime = tick()
    
    -- Cooldown check
    if currentTime - state.lastChangeTime < config.cooldownTime then
        return false
    end
    
    -- Attempt limit check
    if state.attemptCount >= config.maxAttempts then
        log("Max attempts reached. Waiting before retry...")
        wait(5)
        state.attemptCount = 0
    end
    
    local success, error = pcall(function()
        if config.useGradualChange then
            -- Gradually change speed to avoid detection
            local currentSpeed = humanoid.WalkSpeed
            local steps = math.abs(speed - currentSpeed)
            local stepSize = (speed - currentSpeed) / math.max(steps, 1)
            
            for i = 1, steps do
                humanoid.WalkSpeed = currentSpeed + (stepSize * i)
                wait(0.1)
            end
        else
            humanoid.WalkSpeed = speed
        end
        
        -- Add random variation if enabled
        if config.randomizeSpeed then
            local variation = math.random(-1, 1) * 0.5
            humanoid.WalkSpeed = speed + variation
        end
    end)
    
    if success then
        state.lastChangeTime = currentTime
        state.attemptCount = 0
        log("Speed successfully changed to: " .. speed)
        return true
    else
        state.attemptCount = state.attemptCount + 1
        log("Failed to change speed: " .. tostring(error))
        return false
    end
end

-- Alternative Movement Methods
local function setupCFrameMovement()
    log("Setting up CFrame movement method...")
    
    local connection
    connection = RunService.Heartbeat:Connect(function()
        if not state.isActive then return end
        
        local moveVector = humanoid.MoveDirection
        if moveVector.Magnitude > 0 then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                local speed = config.currentSpeed / 16 -- Normalize to default speed
                rootPart.CFrame = rootPart.CFrame + (moveVector * speed * 0.5)
            end
        end
    end)
    
    table.insert(state.connectionCleanup, connection)
end

local function setupBodyVelocityMovement()
    log("Setting up BodyVelocity movement method...")
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(4000, 0, 4000)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.Parent = rootPart
    
    local connection
    connection = RunService.Heartbeat:Connect(function()
        if not state.isActive then
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            return
        end
        
        local moveVector = humanoid.MoveDirection
        if moveVector.Magnitude > 0 then
            local speed = config.currentSpeed
            bodyVelocity.Velocity = moveVector * speed
        else
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        end
    end)
    
    table.insert(state.connectionCleanup, connection)
    table.insert(state.connectionCleanup, function()
        bodyVelocity:Destroy()
    end)
end

-- Main Functions
local function setWalkSpeed(speed)
    speed = math.clamp(speed, config.minSpeed, config.maxSafeSpeed)
    config.currentSpeed = speed
    
    if not isGameSafe() then
        log("Game appears unsafe for walkspeed changes. Trying alternative methods...")
        
        if config.useCFrameMethod then
            setupCFrameMovement()
        elseif config.useBodyVelocity then
            setupBodyVelocityMovement()
        else
            log("No alternative methods enabled. Consider enabling useCFrameMethod or useBodyVelocity")
            return false
        end
        
        state.isActive = true
        return true
    end
    
    return safeSetWalkSpeed(speed)
end

local function resetWalkSpeed()
    config.currentSpeed = config.defaultSpeed
    state.isActive = false
    
    -- Clean up connections
    for _, cleanup in pairs(state.connectionCleanup) do
        if typeof(cleanup) == "function" then
            cleanup()
        elseif typeof(cleanup) == "RBXScriptConnection" then
            cleanup:Disconnect()
        end
    end
    state.connectionCleanup = {}
    
    safeSetWalkSpeed(config.defaultSpeed)
    log("Walkspeed reset to default")
end

local function toggleWalkSpeed()
    if state.isActive then
        resetWalkSpeed()
    else
        setWalkSpeed(config.currentSpeed)
    end
end

-- Character respawn handling
local function onCharacterAdded(newCharacter)
    character = newCharacter
    humanoid = character:WaitForChild("Humanoid")
    
    -- Store original speed
    state.originalSpeed = humanoid.WalkSpeed
    
    wait(1) -- Wait for character to fully load
    
    if state.isActive then
        setWalkSpeed(config.currentSpeed)
    end
end

-- Event Connections
player.CharacterAdded:Connect(onCharacterAdded)

-- Input handling
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.G then
        toggleWalkSpeed()
    elseif input.KeyCode == Enum.KeyCode.H then
        resetWalkSpeed()
    elseif input.KeyCode == Enum.KeyCode.J then
        -- Increase speed
        setWalkSpeed(config.currentSpeed + 2)
    elseif input.KeyCode == Enum.KeyCode.K then
        -- Decrease speed
        setWalkSpeed(config.currentSpeed - 2)
    end
end)

-- Public API
local WalkspeedChanger = {
    setSpeed = setWalkSpeed,
    reset = resetWalkSpeed,
    toggle = toggleWalkSpeed,
    
    -- Configuration
    setMaxSpeed = function(speed)
        config.maxSafeSpeed = math.min(speed, 50) -- Hard limit for safety
    end,
    
    enableCFrameMethod = function()
        config.useCFrameMethod = true
        config.useBodyVelocity = false
    end,
    
    enableBodyVelocityMethod = function()
        config.useBodyVelocity = true
        config.useCFrameMethod = false
    end,
    
    disableAlternativeMethods = function()
        config.useCFrameMethod = false
        config.useBodyVelocity = false
    end
}

-- Initialize
log("Safe Walkspeed Changer loaded!")
log("Controls:")
log("G - Toggle walkspeed")
log("H - Reset to default")
log("J - Increase speed")
log("K - Decrease speed")

-- Make it globally accessible
getgenv().SafeWalkspeed = WalkspeedChanger

return WalkspeedChanger