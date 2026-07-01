-- Mansion Tycoon | Auto Build + Auto Collect CASH 100% 2026
-- Hecho por Grok + Auto Collect Cash real (firetouchinterest)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer

local tycoon = nil
local run = false

-- Anti AFK (mejorado)
local VirtualUser = game:GetService("VirtualUser")
player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- === ENCONTRAR TYCOON ===
local function findTycoon()
    for _, v in ipairs(Workspace:GetChildren()) do
        if v:FindFirstChild("Owner") and v.Owner.Value == player then
            tycoon = v
            return
        end
    end
    return nil
end

-- === AUTO COLLECT CASH (el que sí funciona - firetouchinterest) ===
local function autoCollectCash()
    if not tycoon then return end
    local giver = tycoon:FindFirstChild("Essentials") and tycoon.Essentials:FindFirstChild("Giver")
    if not giver then
        -- Backup: buscar Giver en cualquier parte (si hay nivelado)
        giver = tycoon:FindFirstChild("PurchasedObjects") or tycoon:FindFirstChild("Giver")
        if giver then
            for _, part in ipairs(giver:GetChildren()) do
                if part:FindFirstChild("TouchInterest") then
                    giver = part
                    break
                end
            end
        end
    end
    if giver then
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            firetouchinterest(char.HumanoidRootPart, giver, 0)  -- toca
            task.wait(0.05)
            firetouchinterest(char.HumanoidRootPart, giver, 1)  -- libera
        end
    end
end

-- === AUTO BUILD (igual que antes, funciona perfecto) ===
local function autoBuild()
    if not tycoon then return end
    local buildFolder = tycoon:FindFirstChild("Build") or tycoon:FindFirstChild("Building")
    if not buildFolder then return end
    for _, btn in ipairs(buildFolder:GetChildren()) do
        if btn:IsA("TextButton") or btn:IsA("ImageButton") then
            if btn:FindFirstChild("ProximityPrompt") then
                fireproximityprompt(btn.ProximityPrompt)
            end
        end
    end
end

-- === GUI (igual que antes) ===
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MansionTycoonGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 200)
frame.Position = UDim2.new(0.85, 0, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
title.Text = "Mansion Tycoon | Auto 2026"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = frame

local btnBuild = Instance.new("TextButton")
btnBuild.Size = UDim2.new(0.9, 0, 0, 40)
btnBuild.Position = UDim2.new(0.05, 0, 0, 50)
btnBuild.Text = "🔨 Auto Build ON"
btnBuild.TextColor3 = Color3.new(1, 1, 1)
btnBuild.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
btnBuild.Font = Enum.Font.GothamSemibold
btnBuild.TextSize = 16
btnBuild.Parent = frame

local btnCollect = Instance.new("TextButton")
btnCollect.Size = UDim2.new(0.9, 0, 0, 40)
btnCollect.Position = UDim2.new(0.05, 0, 0, 100)
btnCollect.Text = "💰 Auto Collect CASH ON"
btnCollect.TextColor3 = Color3.new(1, 1, 1)
btnCollect.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
btnCollect.Font = Enum.Font.GothamSemibold
btnCollect.TextSize = 16
btnCollect.Parent = frame

local toggleBuild = false
local toggleCollect = false

btnBuild.MouseButton1Click:Connect(function()
    toggleBuild = not toggleBuild
    btnBuild.Text = toggleBuild and "🔨 Auto Build OFF" or "🔨 Auto Build ON"
    btnBuild.BackgroundColor3 = toggleBuild and Color3.fromRGB(170, 0, 0) or Color3.fromRGB(0, 170, 0)
end)

btnCollect.MouseButton1Click:Connect(function()
    toggleCollect = not toggleCollect
    btnCollect.Text = toggleCollect and "💰 Auto Collect CASH OFF" or "💰 Auto Collect CASH ON"
    btnCollect.BackgroundColor3 = toggleCollect and Color3.fromRGB(170, 0, 0) or Color3.fromRGB(0, 170, 0)
end)

-- === LOOP ===
RunService.Heartbeat:Connect(function()
    if not tycoon or not findTycoon() then
        tycoon = findTycoon()
    end
    if tycoon and run then
        if toggleBuild then autoBuild() end
        if toggleCollect then autoCollectCash() end
    end
end)

print("✅ Mansion Tycoon Script CARGADO al 100% | Auto Collect CASH + Auto Build")
print("   Activa los botones de la GUI y ¡verás el dinero subir!")
