-- =============================================
--        MANSION TYCOON - SCRIPT v6
-- =============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

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

local collectKeywords = {
    "mailbox", "mail", "buzon", "buzón", "collector",
    "collect", "money", "cash", "inbox", "postbox",
    "dropoff", "drop_off", "moneybox"
}

local buildKeywords = {
    "button", "build", "unlock", "construir", "pad",
    "tycoon", "open", "claim", "place", "purchase"
}

local blockedKeywords = {
    "gamepass", "robux", "vip", "premium", "donate",
    "shop", "store", "tienda", "auto-comprar",
    "autocomprar", "auto_comprar", "dinero doble",
    "speed", "extra", "paquete"
}

local function isBlocked(obj)
    local nameL = obj.Name:lower()
    for _, kw in ipairs(blockedKeywords) do
        if nameL:find(kw) then return true end
    end
    if obj.Parent then
        local parentL = obj.Parent.Name:lower()
        for _, kw in ipairs(blockedKeywords) do
            if parentL:find(kw) then return true end
        end
    end
    if obj:IsA("ProximityPrompt") then
        local actionL = obj.ActionText:lower()
        local objTextL = obj.ObjectText:lower()
        for _, kw in ipairs(blockedKeywords) do
            if actionL:find(kw) or objTextL:find(kw) then return true end
        end
    end
    return false
end

local function isCollectPoint(obj)
    local nameL = obj.Name:lower()
    for _, kw in ipairs(collectKeywords) do
        if nameL:find(kw) then return true end
    end
    return false
end

local function isBuildButton(obj)
    local nameL = obj.Name:lower()
    for _, kw in ipairs(buildKeywords) do
        if nameL:find(kw) then return true end
    end
    return false
end

-- [GUI igual que v5 — CoreGui, todos OFF]

-- AUTO-COLLECT: solo el buzón, desde lejos
task.spawn(function()
    while true do
        task.wait(1)
        if config.AutoCollect and rootPart then
            for _, obj in ipairs(workspace:GetDescendants()) do
                if (obj:IsA("BasePart") or obj:IsA("MeshPart") or obj:IsA("Model")) then
                    if isCollectPoint(obj) and not isBlocked(obj) then
                        local targetPos
                        if obj:IsA("Model") and obj.PrimaryPart then
                            targetPos = obj.PrimaryPart.CFrame + Vector3.new(0, 4, 0)
                        elseif obj:IsA("BasePart") or obj:IsA("MeshPart") then
                            targetPos = obj.CFrame + Vector3.new(0, 4, 0)
                        end
                        if targetPos then
                            rootPart.CFrame = targetPos
                            task.wait(0.2)
                            pcall(function()
                                firetouchinterest(rootPart, obj, 0)
                                firetouchinterest(rootPart, obj, 1)
                            end)
                            local cd = obj:FindFirstChildOfClass("ClickDetector")
                            if cd then pcall(function() fireClickDetector(cd) end) end
                            local pp = obj:FindFirstChildOfClass("ProximityPrompt")
                            if pp then pcall(function() fireproximityprompt(pp) end) end
                            task.wait(0.3)
                        end
                    end
                end
            end
        end
    end
end)

-- [Auto-Build, Speed, Jump, AntiAFK, ESP igual que v5]

print("✅ Mansion Tycoon Script v6 cargado")
