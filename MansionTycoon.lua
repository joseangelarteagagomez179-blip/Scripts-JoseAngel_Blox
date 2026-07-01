-- =============================================
--        MANSION TYCOON - SCRIPT v2
--        Botones OFF por defecto | Auto-Collect/Farm mejorados
-- =============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- =============================================
-- CONFIGURACION (todos en false = OFF por defecto)
-- =============================================
local config = {
    AutoCollect  = false,
    AutoFarm     = false,
    SpeedHack    = false,
    InfiniteJump = false,
    AntiAFK      = false,
    ESP          = false,
    WalkSpeed    = 50,
    CollectRadius = 40
}

-- =============================================
-- GUI PRINCIPAL
-- =============================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MansionScript"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = player.PlayerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 320)
mainFrame.Position = UDim2.new(0, 10, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundColor3 = Color3.fromRGB(100, 60, 200)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Text = "🏠 Mansion Tycoon"
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = title

local function createToggle(name, configKey, yPos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.85, 0, 0, 32)
    btn.Position = UDim2.new(0.075, 0, 0, yPos)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BorderSizePixel = 0
    btn.Parent = mainFrame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    local function updateColor()
        if config[configKey] then
            btn.BackgroundColor3 = Color3.fromRGB(60, 180, 90)
            btn.Text = "✅ " .. name .. ": ON"
        else
            btn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
            btn.Text = "❌ " .. name .. ": OFF"
        end
    end

    updateColor()

    btn.MouseButton1Click:Connect(function()
        config[configKey] = not config[configKey]
        updateColor()
    end)
end

createToggle("Auto-Collect",  "AutoCollect",  45)
createToggle("Auto-Farm",     "AutoFarm",     85)
createToggle("Speed Hack",    "SpeedHack",    125)
createToggle("Infinite Jump", "InfiniteJump", 165)
createToggle("Anti-AFK",      "AntiAFK",      205)
createToggle("ESP",           "ESP",          245)

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 25)
statusLabel.Position = UDim2.new(0, 0, 0, 290)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Text = "Script activo ✓"
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 11
statusLabel.Parent = mainFrame

-- =============================================
-- 1. AUTO-COLLECT
-- =============================================
task.spawn(function()
    while true do
        task.wait(0.3)
        if config.AutoCollect and rootPart then
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.CanTouch and not obj.Locked then
                    local dist = (rootPart.Position - obj.Position).Magnitude
                    if dist < config.CollectRadius then
                        pcall(function()
                            firetouchinterest(rootPart, obj, 0)
                            firetouchinterest(rootPart, obj, 1)
                        end)
                        local cd = obj:FindFirstChildOfClass("ClickDetector")
                        if cd then
                            pcall(function() fireClickDetector(cd) end)
                        end
                        local pp = obj:FindFirstChildOfClass("ProximityPrompt")
                        if pp then
                            pcall(function() fireproximityprompt(pp) end)
                        end
                    end
                end
            end
        end
    end
end)

-- =============================================
-- 2. AUTO-FARM
-- =============================================
task.spawn(function()
    while true do
        task.wait(0.5)
        if config.AutoFarm and rootPart then
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") or obj:IsA("UnionOperation") or obj:IsA("MeshPart") then
                    local pp = obj:FindFirstChildOfClass("ProximityPrompt")
                    if pp then
                        local dist = (rootPart.Position - obj.Position).Magnitude
                        if dist < 50 then
                            pcall(function() fireproximityprompt(pp) end)
                        end
                    end
                    local cd = obj:FindFirstChildOfClass("ClickDetector")
                    if cd then
                        local dist = (rootPart.Position - obj.Position).Magnitude
                        if dist < 50 then
                            pcall(function() fireClickDetector(cd) end)
                        end
                    end
                end
            end

            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.CanTouch then
                    local size = obj.Size
                    if size.X < 5 and size.Y < 5 and size.Z < 5 then
                        local dist = (rootPart.Position - obj.Position).Magnitude
                        if dist > 3 and dist < 60 then
                            pcall(function()
                                firetouchinterest(rootPart, obj, 0)
                                firetouchinterest(rootPart, obj, 1)
                            end)
                        end
                    end
                end
            end
        end
    end
end)

-- =============================================
-- 3. SPEED HACK
-- =============================================
RunService.Heartbeat:Connect(function()
    if humanoid and humanoid.Parent then
        humanoid.WalkSpeed = config.SpeedHack and config.WalkSpeed or 16
    end
end)

-- =============================================
-- 4. INFINITE JUMP
-- =============================================
UserInputService.JumpRequest:Connect(function()
    if config.InfiniteJump and humanoid and humanoid.Parent then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- =============================================
-- 5. ANTI-AFK
-- =============================================
local VirtualUser = game:GetService("VirtualUser")
player.Idled:Connect(function()
    if config.AntiAFK then
        VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end
end)

-- =============================================
-- 6. ESP
-- =============================================
local function createESP(targetPlayer)
    if targetPlayer == player then return end

    local function applyESP()
        local espChar = targetPlayer.Character
        if not espChar then return end
        local rootESP = espChar:FindFirstChild("HumanoidRootPart")
        if not rootESP then return end

        local existing = rootESP:FindFirstChild("ESP_Tag")
        if existing then existing:Destroy() end

        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ESP_Tag"
        billboard.Size = UDim2.new(0, 130, 0, 45)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.Parent = rootESP

        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 0.6, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 100)
        nameLabel.Text = targetPlayer.Name
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextSize = 13
        nameLabel.TextStrokeTransparency = 0
        nameLabel.Parent = billboard

        local distLabel = Instance.new("TextLabel")
        distLabel.Size = UDim2.new(1, 0, 0.4, 0)
        distLabel.Position = UDim2.new(0, 0, 0.6, 0)
        distLabel.BackgroundTransparency = 1
        distLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        distLabel.Font = Enum.Font.Gotham
        distLabel.TextSize = 11
        distLabel.TextStrokeTransparency = 0
        distLabel.Parent = billboard

        RunService.Heartbeat:Connect(function()
            billboard.Enabled = config.ESP
            if rootPart and rootESP and rootESP.Parent then
                local dist = math.floor((rootPart.Position - rootESP.Position).Magnitude)
                distLabel.Text = dist .. " studs"
            end
        end)
    end

    applyESP()
    targetPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        applyESP()
    end)
end

for _, p in ipairs(Players:GetPlayers()) do
    createESP(p)
end
Players.PlayerAdded:Connect(createESP)

player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = newChar:WaitForChild("Humanoid")
    rootPart = newChar:WaitForChild("HumanoidRootPart")
    for _, p in ipairs(Players:GetPlayers()) do
        createESP(p)
    end
end)

print("✅ Mansion Tycoon Script v2 cargado")
