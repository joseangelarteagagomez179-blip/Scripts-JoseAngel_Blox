-- =============================================
--        MANSION TYCOON - SCRIPT v9
--        Fix GUI definitivo para Delta
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

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MansionScript"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 999
screenGui.IgnoreGuiInset = true

local ok = pcall(function()
    local h = gethui()
    local old = h:FindFirstChild("MansionScript")
    if old then old:Destroy() end
    screenGui.Parent = h
end)

if not ok then
    ok = pcall(function()
        local CoreGui = game:GetService("CoreGui")
        local old = CoreGui:FindFirstChild("MansionScript")
        if old then old:Destroy() end
        syn.protect_gui(screenGui)
        screenGui.Parent = CoreGui
    end)
end

if not ok then
    ok = pcall(function()
        local CoreGui = game:GetService("CoreGui")
        local old = CoreGui:FindFirstChild("MansionScript")
        if old then old:Destroy() end
        screenGui.Parent = CoreGui
    end)
end

if not ok then
    pcall(function()
        local old = player.PlayerGui:FindFirstChild("MansionScript")
        if old then old:Destroy() end
        screenGui.Parent = player
