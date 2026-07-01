-- =============================================
--        MANSION TYCOON - SCRIPT v4
--        Auto-Farm removido | Auto-Build añadido
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
    CollectRadius = 40,
    BuildRadius   = 20
}

local buildKeywords = {
    "button", "buy", "purchase", "build", "unlock", "comprar",
    "construir", "pad", "tycoon", "collect", "drop", "open",
    "claim", "place"
}

local blockedKeywords = {
    "gamepass", "robux", "vip", "premium", "donate", "shop",
    "store", "tienda", "auto-comprar", "autocomprar", "auto_comprar"
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

local function isBuildButton(obj)
    local nameL = obj.Name:lower()
    for _, kw in ipairs(buildKeywords) do
        if nameL:find(kw) then return true end
    end
    return false
end

-- [GUI — igual que v3, todos los botones en OFF]

-- AUTO-BUILD
task.spawn(function()
    while true do
        task.wait(0.8)
        if config.AutoBuild and rootPart then
            for _, obj in ipairs(workspace:GetDescendants()) do
                if not isBlocked(obj) then
                    local dist = (rootPart.Position - obj.Position).Magnitude

                    -- ClickDetector
                    local cd = obj:FindFirstChildOfClass("ClickDetector")
                    if cd and isBuildButton(obj) and dist < 200 then
                        local savedPos = rootPart.CFrame
                        rootPart.CFrame = obj.CFrame + Vector3.new(0, 4, 0)
                        task.wait(0.1)
                        pcall(function() fireClickDetector(cd) end)
                        task.wait(0.1)
                        rootPart.CFrame = savedPos
                    end

                    -- ProximityPrompt
                    local pp = obj:FindFirstChildOfClass("ProximityPrompt")
                    if pp and not isBlocked(pp) and isBuildButton(obj) and dist < 200 then
                        local savedPos = rootPart.CFrame
                        rootPart.CFrame = obj.CFrame + Vector3.new(0, 4, 0)
                        task.wait(0.1)
                        pcall(function() fireproximityprompt(pp) end)
                        task.wait(0.1)
                        rootPart.CFrame = savedPos
                    end

                    -- TouchInterest (pads)
                    if (obj:IsA("BasePart") or obj:IsA("MeshPart")) and isBuildButton(obj) then
                        local touchInterest = obj:FindFirstChild("TouchInterest")
                        if touchInterest and dist < 200 then
                            pcall(function()
                                firetouchinterest(rootPart, obj, 0)
                                task.wait(0.05)
                                firetouchinterest(rootPart, obj, 1)
                            end)
                        end
                    end
                end
            end
        end
    end
end)

-- [Speed, Jump, AntiAFK, ESP igual que v3]

print("✅ Mansion Tycoon Script v4 cargado")
