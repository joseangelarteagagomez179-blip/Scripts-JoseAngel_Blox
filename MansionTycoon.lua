-- =============================================
--        MANSION TYCOON - SCRIPT v8
-- =============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local config = {
    AutoCollect  = false,
    AutoBuild    = false,
    SpeedHack    = false,
    InfiniteJump = false,
    AntiAFK      = false,
    ESP          = false,
    WalkSpeed    = 50,
}

local blockedKeywords = {
    "gamepass", "robux", "vip", "premium", "donate",
    "shop", "store", "tienda", "auto-comprar",
    "autocomprar", "auto_comprar", "dinerodoble",
    "dinero doble", "extra", "paquete", "autocollect",
    "autorecoger", "auto-recoger"
}

local function isBlocked(obj)
    local nameL = obj.Name:lower():gsub("%s","")
    for _, kw in ipairs(blockedKeywords) do
        if nameL:find(kw:lower():gsub("%s","")) then return true end
    end
    if obj.Parent then
        local parentL = obj.Parent.Name:lower():gsub("%s","")
        for _, kw in ipairs(blockedKeywords) do
            if parentL:find(kw:lower():gsub("%s","")) then return true end
        end
    end
    return false
end

-- GUI (Delta - gethui)
local guiParent
if gethui then
    guiParent = gethui()
else
    guiParent = game:GetService("CoreGui")
end

local existingGui = guiParent:FindFirstChild("MansionScript")
if existingGui then existingGui:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MansionScript"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 999
screenGui.IgnoreGuiInset = true
screenGui.Parent = guiParent

-- [Frame, título, botones igual que v7]

-- Función: encontrar Hitbox del Collector
local function getMyCollectorHitbox()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name == "Collector" then
            local hitbox = obj:FindFirstChild("Hitbox")
            if hitbox and hitbox:IsA("BasePart") then
                return hitbox
            end
            if obj.PrimaryPart then return obj.PrimaryPart end
            for _, part in ipairs(obj:GetDescendants()) do
                if part:IsA("BasePart") then return part end
            end
        end
    end
    return nil
end

-- AUTO-COLLECT: se queda parado en el Hitbox del Collector
task.spawn(function()
    local lastHitbox = nil
    while true do
        task.wait(0.2)
        if config.AutoCollect and rootPart then
            if not lastHitbox or not lastHitbox.Parent then
                lastHitbox = getMyCollectorHitbox()
            end
            if lastHitbox and lastHitbox.Parent then
                rootPart.CFrame = CFrame.new(
                    lastHitbox.Position.X,
                    lastHitbox.Position.Y + 4,
                    lastHitbox.Position.Z
                )
                pcall(function()
                    firetouchinterest(rootPart, lastHitbox, 0)
                    firetouchinterest(rootPart, lastHitbox, 1)
                end)
            end
        end
    end
end)

-- AUTO-BUILD: activa ClickDetectors del tycoon
task.spawn(function()
    while true do
        task.wait(1)
        if config.AutoBuild and rootPart then
            for _, obj in ipairs(workspace:GetDescendants()) do
                if not isBlocked(obj) then
                    local cd = obj:FindFirstChildOfClass("ClickDetector")
                    if cd then
                        local dist = (rootPart.Position - obj.Position).Magnitude
                        if dist < 300 then
                            pcall(function() fireClickDetector(cd) end)
                        end
                    end
                    local pp = obj:FindFirstChildOfClass("ProximityPrompt")
                    if pp and not isBlocked(pp) then
                        local actionL = (pp.ActionText or ""):lower()
                        local objTextL = (pp.ObjectText or ""):lower()
                        local isBuyPrompt = actionL:find("comprar") or actionL:find("buy")
                            or objTextL:find("robux") or objTextL:find("$")
                        if not isBuyPrompt then
                            local dist = (rootPart.Position - obj.Position).Magnitude
                            if dist < 300 then
                                pcall(function() fireproximityprompt(pp) end)
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- SPEED / JUMP / ANTIAFK / ESP igual que v7

print("✅ Mansion Tycoon Script v8 cargado")
