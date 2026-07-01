-- =============================================
--        MANSION TYCOON - SCRIPT v10
--        Optimizado para Delta Android
-- =============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

repeat task.wait() until player.Character
local character = player.Character
repeat task.wait() until character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Humanoid")
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
    "shop", "store", "tienda", "autocomprar",
    "dinerodoble", "extra", "paquete"
}

local function isBlocked(obj)
    local nameL = obj.Name:lower():gsub("%s","")
    for _, kw in ipairs(blockedKeywords) do
        if nameL:find(kw) then return true end
    end
    if obj.Parent then
        local parentL = obj.Parent.Name:lower():gsub("%s","")
        for _, kw in ipairs(blockedKeywords) do
            if parentL:find(kw) then return true end
        end
    end
    return false
end

task.wait(2) -- esperar que PlayerGui esté listo

local old = player.PlayerGui:FindFirstChild("MansionScript")
if old then old:Destroy() end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MansionScript"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 999
screenGui.IgnoreGuiInset = true
screenGui.Parent = player.PlayerGui

-- [Frame, título y botones igual — todos en OFF]

-- AUTO-COLLECT, AUTO-BUILD, SPEED, JUMP, ANTIAFK, ESP igual que v9

print("✅ Mansion Tycoon Script v10 cargado")
