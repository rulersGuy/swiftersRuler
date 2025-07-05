-- One-liner Walkspeed Changer
-- Copy and paste this into Roblox executor

-- Set walkspeed to 50 (change the number to your desired speed)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50

-- With auto-respawn feature (more advanced one-liner)
-- loadstring("local p=game.Players.LocalPlayer;local s=50;local function w()if p.Character and p.Character:FindFirstChild('Humanoid')then p.Character.Humanoid.WalkSpeed=s end end;if p.Character then w()end;p.CharacterAdded:Connect(function()wait(0.1)w()end)")()

-- Multiple speed options with keybinds
-- loadstring("local p,u=game.Players.LocalPlayer,game:GetService('UserInputService');local function s(v)if p.Character and p.Character:FindFirstChild('Humanoid')then p.Character.Humanoid.WalkSpeed=v;print('Speed: '..v)end end;u.InputBegan:Connect(function(i,g)if not g then if i.KeyCode==Enum.KeyCode.One then s(16)elseif i.KeyCode==Enum.KeyCode.Two then s(25)elseif i.KeyCode==Enum.KeyCode.Three then s(50)elseif i.KeyCode==Enum.KeyCode.Four then s(100)end end end);print('Press 1,2,3,4 for different speeds')")()

-- Instructions:
-- 1. Copy one of the lines above
-- 2. Paste into your Roblox script executor
-- 3. Execute the script
-- 
-- The first line sets walkspeed to 50 immediately
-- The second line (loadstring) sets walkspeed and keeps it when you respawn
-- The third line (loadstring) gives you multiple speed options with number keys