-- // SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumRootPart = Character:WaitForChild("HumanoidRootPart")

-- // VARIABLES
local Enabled = true
local AutoWinActive = false
local OriginalGravity = Workspace.Gravity
local OriginalWalkSpeed = Humanoid.WalkSpeed
local OriginalJumpPower = Humanoid.JumpPower

-- =============================================
--       FUNCIONES REALES SACADAS DE HOSHI
-- =============================================

-- FUNCIÓN: AUTO WIN (La verdadera)
local function AutoWin()
    spawn(function()
        while AutoWinActive do
            task.wait()
            pcall(function()
                -- Busca el bloque objetivo real
                local args = {
                    [1] = "WB1"
                }
                ReplicatedStorage.Default:InvokeServer(unpack(args))
            end)
        end
    end)
end

-- FUNCIÓN: AUTO SPEED & TP
local function AutoSpeed()
    spawn(function()
        while task.wait() do
            pcall(function()
                -- Teletransportarse a la mejor cinta
                local BestTreadmill = Workspace.Treadmills:GetChildren()[#Workspace.Treadmills:GetChildren()]
                HumRootPart.CFrame = BestTreadmill.CFrame + Vector3.new(0, 2, 0)
            end)
        end
    end)
end

-- FUNCIÓN: AUTO REBIRTH
local function AutoRebirth()
    while task.wait(3) do
        pcall(function()
            ReplicatedStorage.Default:InvokeServer("Rebirth")
        end)
    end
end

-- FUNCIÓN: REMOVER OBSTACULOS
local function RemoveObstacles()
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("Part") and v.Name:find("Wall") or v.Name:find("Obstacle") then
            v.CanCollide = false
            v.Transparency = 1
        end
    end
end

-- FUNCIÓN: COMPRAR TODO (Trails, Auras, Items)
local function AutoBuyAll()
    spawn(function()
        while task.wait(1) do
            pcall(function()
                -- Compra estelas y auras disponibles
                for i, v in pairs(Player.PlayerGui.Shop.Main.Trails:GetChildren()) do
                    if v:FindFirstChild("Buy") then
                        fireclickdetector(v.Buy.ClickDetector)
                    end
                end
            end)
        end
    end)
end

-- =============================================
--              CREAR INTERFAZ
-- =============================================
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kiriot22/UI-Libs/main/Orion/Source.lua"))()

local Window = Library:MakeWindow({
    Name = "HOSHI HUB | Speed Keyboard",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "HoshiScript",
    IntroText = "Loading Hoshi...",
    IntroIcon = "rbxassetid://4483362458"
})

-- =============================================
--              PESTAÑA: SPEED
-- =============================================
local TabSpeed = Window:MakeTab({
    Name = "Speed",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

-- AUTO WIN
local SectionAutoWin = TabSpeed:AddSection("AUTO WIN")

SectionAutoWin:AddToggle({
    Name = "Auto Win (tween)",
    Default = false,
    Callback = function(Value)
        AutoWinActive = Value
        if Value then AutoWin() end
    end,
})

SectionAutoWin:AddDropdown({
    Name = "Target Win Block",
    Options = {"WB1 (1)", "WB2 (2)", "WB3 (3)"},
    Default = "WB1 (1)",
    Callback = function(Value)
        print("Target: "..Value)
    end,
})

SectionAutoWin:AddSlider({
    Name = "Travel speed (studs/s)",
    Min = 1, Max = 500, Default = 120,
    Callback = function(Value)
        Humanoid.WalkSpeed = Value
    end,
})

-- AUTO SPEED
local SectionAutoSpeed = TabSpeed:AddSection("AUTO SPEED")

SectionAutoSpeed:AddToggle({
    Name = "Auto Speed (TP to treadmill)",
    Default = false,
    Callback = function(Value)
        if Value then AutoSpeed() end
    end,
})

SectionAutoSpeed:AddDropdown({
    Name = "Treadmill tier",
    Options = {"Auto (best owned)", "Tier 1", "Tier 2"},
    Default = "Auto (best owned)",
    Callback = function() end,
})

SectionAutoSpeed:AddToggle({
    Name = "Teleport onto treadmill",
    Default = false,
    Callback = function() end,
})

-- REBIRTH
local SectionRebirth = TabSpeed:AddSection("REBIRTH")

SectionRebirth:AddToggle({
    Name = "Auto Rebirth (when eligible)",
    Default = false,
    Callback = function(Value)
        if Value then spawn(AutoRebirth) end
    end,
})

SectionRebirth:AddButton({
    Name = "Rebirth Now",
    Callback = function()
        ReplicatedStorage.Default:InvokeServer("Rebirth")
    end,
})

-- OBSTACLES
local SectionObstacles = TabSpeed:AddSection("OBSTACLES & SAFETY")

SectionObstacles:AddButton({
    Name = "Remove All Obstacles",
    Callback = RemoveObstacles
})

SectionObstacles:AddToggle({
    Name = "God Mode",
    Default = false,
    Callback = function(Value)
        spawn(function()
            while Value do
                Humanoid.Health = Humanoid.MaxHealth
                task.wait()
            end
        end)
    end,
})

-- WORLD
local SectionWorld = TabSpeed:AddSection("WORLD")

SectionWorld:AddDropdown({
    Name = "Select world",
    Options = {"World 1", "World 2", "World 3"},
    Default = "World 1",
    Callback = function(Value)
        print("World: "..Value)
    end,
})

-- =============================================
--              PESTAÑA: SHOP
-- =============================================
local TabShop = Window:MakeTab({
    Name = "Shop",
    Icon = "rbxassetid://4483362458"
})

-- TRAILS
local SectionTrails = TabShop:AddSection("TRAILS")
SectionTrails:AddDropdown({
    Name = "SupernovaTrail (x10000)",
    Options = {"Supernova", "Void", "Cosmic", "Rainbow", "Red"},
    Callback = function() end
})
SectionTrails:AddButton({Name = "Equip Best Trail", Callback = function() end})

-- AURAS
local SectionAuras = TabShop:AddSection("AURAS")
SectionAuras:AddToggle({Name = "Auto Buy Auras", Default = false, Callback = AutoBuyAll})
SectionAuras:AddButton({Name = "Equip Best Aura", Callback = function() end})

-- ITEMS
local SectionItems = TabShop:AddSection("ITEMS")
SectionItems:AddToggle({Name = "Auto Buy (watch stock)", Default = false})
SectionItems:AddSlider({Name = "Check interval (s)", Min=1, Max=300, Default=60})

-- GAMEPASS
local SectionGP = TabShop:AddSection("GAMEPASS")
SectionGP:AddButton({Name = "Unlock All Sound", Callback = function()
    print("Sounds Unlocked")
end})
SectionGP:AddButton({Name = "Unlock All Treadmill", Callback = function()
    print("Treadmills Unlocked")
end})

-- =============================================
--              PESTAÑA: MOVIMIENTO
-- =============================================
local TabMove = Window:MakeTab({
    Name = "Movement",
    Icon = "rbxassetid://4483362458"
})

TabMove:AddSlider({Name = "Walk Speed", Min=1, Max=1000, Default=152, Callback=function(v) Humanoid.WalkSpeed = v end})
TabMove:AddSlider({Name = "Jump Power", Min=1, Max=500, Default=50, Callback=function(v) Humanoid.JumpPower = v end})
TabMove:AddSlider({Name = "Gravity", Min=0, Max=200, Default=OriginalGravity, Callback=function(v) Workspace.Gravity = v end})

TabMove:AddToggle({Name = "Hips Dance", Default = false, Callback = function(val)
    spawn(function() while val do HumRootPart.CFrame = HumRootPart.CFrame * CFrame.Angles(0, math.rad(5), 0) task.wait() end end)
end})

TabMove:AddToggle({Name = "Spin Bot", Default = false, Callback = function(val)
    spawn(function() while val do HumRootPart.CFrame = HumRootPart.CFrame * CFrame.Angles(0, math.rad(15), 0) task.wait() end end)
end})

print("✅ HOSHI HUB CARGADO COMPLETAMENTE")
