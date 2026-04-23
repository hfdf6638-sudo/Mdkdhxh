local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:wait()
local humanoid = char:WaitForChild("Humanoid")

-- إنشاء الواجهة
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "VinomGUI"
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 400)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
mainFrame.BackgroundTransparency = 0.2
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- توهج أزرق
local glow = Instance.new("UICorner")
glow.CornerRadius = UDim.new(0, 12)
glow.Parent = mainFrame

local shadow = Instance.new("UIStroke")
shadow.Color = Color3.fromRGB(0, 200, 255)
shadow.Thickness = 3
shadow.Transparency = 0.3
shadow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
shadow.Parent = mainFrame

-- عنوان
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(0, 50, 150)
title.Text = "VINOM"
title.TextColor3 = Color3.fromRGB(0, 200, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

-- زر القفز اللانهائي
local infiniteJumpBtn = Instance.new("TextButton")
infiniteJumpBtn.Size = UDim2.new(0.8, 0, 0, 50)
infiniteJumpBtn.Position = UDim2.new(0.1, 0, 0.2, 0)
infiniteJumpBtn.BackgroundColor3 = Color3.fromRGB(0, 80, 200)
infiniteJumpBtn.Text = "تمكين القفز اللانهائي"
infiniteJumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
infiniteJumpBtn.Parent = mainFrame

local jumpEnabled = false
infiniteJumpBtn.MouseButton1Click:Connect(function()
    jumpEnabled = not jumpEnabled
    infiniteJumpBtn.Text = jumpEnabled and "القفز اللانهائي: مفعل" or "القفز اللانهائي: معطل"
end)
-- تعريف المتغير
local infjump = false

-- الكود الخاص بالقفز اللانهائي
uis.JumpRequest:Connect(function()
    if infjump and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
        plr.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(plr.Character.HumanoidRootPart.AssemblyLinearVelocity.X, 52, plr.Character.HumanoidRootPart.AssemblyLinearVelocity.Z)
    end
end)
-- منع الموت
player.CharacterAdded:Connect(function(newChar)
    char = newChar
    humanoid = char:WaitForChild("Humanoid")
    humanoid:GetPropertyChangedSignal("Health"):Connect(function()
        if antiDeathEnabled and humanoid.Health <= 0 then
            humanoid.Health = 100
        end
    end)
end)

humanoid:GetPropertyChangedSignal("Health"):Connect(function()
    if antiDeathEnabled and humanoid.Health <= 0 then
        humanoid.Health = 100
    end
end)
