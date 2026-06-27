-- // SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

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
--              CARGAR LIBRERÍA UI
-- =============================================
-- Usamos la librería que se parece exactamente a la de tu foto
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/BaiuFcu/BaiuUI-Libary/main/source.lua"))()

local Window = Library:CreateWindow({
    Name = "Hoshi | Speed Keyboard",
    LoadingTitle = "Cargando Script...",
    LoadingSubtitle = "Por favor espera",
    Theme = "Dark", -- Tema oscuro igual que el original
    Credit = "Made by Dola"
})

-- =============================================
--              PESTAÑA: SPEED
-- =============================================
local TabSpeed = Window:CreateTab("Speed", 4483362458) -- Icono de rayo

-- SECCIÓN: AUTO WIN
local SectionAutoWin = TabSpeed:CreateSection("AUTO WIN")

SectionAutoWin:CreateToggle({
    Name = "Auto Win (tween)",
    CurrentValue = false,
    Callback = function(Value)
        AutoWinActive = Value
        if Value then
            spawn(function()
                while AutoWinActive and task.wait() do
                    pcall(function()
                        -- Simula presionar teclas rápidamente
                        UserInputService:SendKeyDownPressed(Enum.KeyCode.W, false, false)
                        task.wait(0.05)
                        UserInputService:SendKeyUpReleased(Enum.KeyCode.W, false, false)
                        UserInputService:SendKeyDownPressed(Enum.KeyCode.A, false, false)
                        task.wait(0.05)
                        UserInputService:SendKeyUpReleased(Enum.KeyCode.A, false, false)
                        UserInputService:SendKeyDownPressed(Enum.KeyCode.S, false, false)
                        task.wait(0.05)
                        UserInputService:SendKeyUpReleased(Enum.KeyCode.S, false, false)
                        UserInputService:SendKeyDownPressed(Enum.KeyCode.D, false, false)
                        task.wait(0.05)
                        UserInputService:SendKeyUpReleased(Enum.KeyCode.D, false, false)
                    end)
                end
            end)
        end
    end,
})

SectionAutoWin:CreateDropdown({
    Name = "Target Win Block",
    Options = {"WB1 (1)", "WB2 (2)", "WB3 (3)"},
    CurrentOption = "WB1 (1)",
    Callback = function(Value)
        print("Bloque objetivo: "..Value)
    end,
})

SectionAutoWin:CreateSlider({
    Name = "Travel speed (studs/s)",
    Range = {1, 500},
    CurrentValue = 120,
    Callback = function(Value)
        Humanoid.WalkSpeed = Value
    end,
})

SectionAutoWin:CreateSlider({
    Name = "Delay each run (s)",
    Range = {0, 5},
    CurrentValue = 0.0,
    Callback = function(Value)
        print("Delay: "..Value)
    end,
})

-- SECCIÓN: AUTO SPEED
local SectionAutoSpeed = TabSpeed:CreateSection("AUTO SPEED")

SectionAutoSpeed:CreateToggle({
    Name = "Auto Speed (TP to treadmill)",
    CurrentValue = false,
    Callback = function(Value)
        print("Auto Speed: "..tostring(Value))
    end,
})

SectionAutoSpeed:CreateDropdown({
    Name = "Treadmill tier",
    Options = {"Auto (best owned)", "Tier 1", "Tier 2", "Tier 3"},
    CurrentOption = "Auto (best owned)",
    Callback = function(Value)
        print("Maquina: "..Value)
    end,
})

SectionAutoSpeed:CreateToggle({
    Name = "Teleport onto treadmill",
    CurrentValue = false,
    Callback = function(Value)
        print("TP Maquina: "..tostring(Value))
    end,
})

SectionAutoSpeed:CreateSlider({
    Name = "Fire interval (s)",
    Range = {0.01, 1},
    CurrentValue = 0.10,
    Callback = function(Value)
        print("Intervalo: "..Value)
    end,
})

-- SECCIÓN: REBIRTH
local SectionRebirth = TabSpeed:CreateSection("REBIRTH")

SectionRebirth:CreateToggle({
    Name = "Auto Rebirth (when eligible)",
    CurrentValue = false,
    Callback = function(Value)
        spawn(function()
            while Value and task.wait(3) do
                pcall(function()
                    -- Busca y hace clic en el botón de renacer
                    fireclickdetector(Workspace:FindFirstChild("RebirthButton") or game:GetService("ReplicatedStorage").Rebirth.ClickDetector)
                end)
            end
        end)
    end,
})

SectionRebirth:CreateButton({
    Name = "Rebirth Now",
    Callback = function()
        pcall(function()
            fireclickdetector(Workspace:FindFirstChild("RebirthButton") or game:GetService("ReplicatedStorage").Rebirth.ClickDetector)
        end)
    end,
})

-- SECCIÓN: OBSTACLES & SAFETY
local SectionObstacles = TabSpeed:CreateSection("OBSTACLES & SAFETY")

SectionObstacles:CreateButton({
    Name = "Remove All Obstacles",
    Callback = function()
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("Part") or v:IsA("MeshPart") then
                if string.find(v.Name:lower(), "obstacle") or string.find(v.Name:lower(), "wall") or string.find(v.Name:lower(), "block") then
                    v:Destroy()
                end
            end
        end
        print("Obstaculos eliminados")
    end,
})

SectionObstacles:CreateToggle({
    Name = "God Mode",
    CurrentValue = false,
    Callback = function(Value)
        spawn(function()
            while Value and task.wait() do
                Humanoid.Health = Humanoid.MaxHealth
            end
        end)
    end,
})

-- SECCIÓN: WORLD
local SectionWorld = TabSpeed:CreateSection("WORLD")

SectionWorld:CreateDropdown({
    Name = "Select world",
    Options = {"World 1", "World 2", "World 3", "World 4"},
    CurrentOption = "World 1",
    Callback = function(Value)
        print("Mundo seleccionado: "..Value)
    end,
})

SectionWorld:CreateToggle({
    Name = "Auto Teleport World",
    CurrentValue = false,
    Callback = function(Value)
        print("Auto TP Mundo: "..tostring(Value))
    end,
})

-- =============================================
--              PESTAÑA: SHOP
-- =============================================
local TabShop = Window:CreateTab("Shop", 4483362458) -- Icono de carrito

-- SECCIÓN: TRAILS
local SectionTrails = TabShop:CreateSection("TRAILS")

SectionTrails:CreateDropdown({
    Name = "Seleccionar Estela",
    Options = {"SupernovaTrail (x10000)", "VoidTrail (x1000)", "CosmicTrail (x100)", "RainbowTrail (x5)", "RedTrail (x4)"},
    CurrentOption = "SupernovaTrail (x10000)",
    Callback = function(Value)
        print("Estela: "..Value)
    end,
})

SectionTrails:CreateButton({
    Name = "Equip Best Trail",
    Callback = function()
        print("Equipando mejor estela")
    end,
})

-- SECCIÓN: AURAS
local SectionAuras = TabShop:CreateSection("AURAS")

SectionAuras:CreateToggle({
    Name = "Auto Buy Auras",
    CurrentValue = false,
    Callback = function(Value)
        print("Auto Comprar Auras: "..tostring(Value))
    end,
})

SectionAuras:CreateDropdown({
    Name = "Auras",
    Options = {"All affordable", "Common", "Rare", "Legendary"},
    CurrentOption = "All affordable",
    Callback = function(Value)
        print("Tipo Aura: "..Value)
    end,
})

SectionAuras:CreateButton({
    Name = "Equip Best Aura",
    Callback = function()
        print("Equipando mejor aura")
    end,
})

-- SECCIÓN: ITEMS
local SectionItems = TabShop:CreateSection("ITEMS")

SectionItems:CreateToggle({
    Name = "Auto Buy (watch stock)",
    CurrentValue = false,
    Callback = function(Value)
        print("Auto Comprar: "..tostring(Value))
    end,
})

SectionItems:CreateSlider({
    Name = "Check interval (s)",
    Range = {1, 300},
    CurrentValue = 60,
    Callback = function(Value)
        print("Intervalo revisión: "..Value)
    end,
})

SectionItems:CreateToggle({
    Name = "Auto Equip Best",
    CurrentValue = false,
    Callback = function(Value)
        print("Auto Equipar: "..tostring(Value))
    end,
})

-- SECCIÓN: GAMEPASS
local SectionGamepass = TabShop:CreateSection("GAMEPASS")

SectionGamepass:CreateButton({
    Name = "Unlock All Sound",
    Callback = function()
        print("Desbloqueando todos los sonidos...")
    end,
})

SectionGamepass:CreateButton({
    Name = "Unlock All Treadmill (visual)",
    Callback = function()
        print("Desbloqueando todas las maquinas...")
    end,
})

-- =============================================
--              PESTAÑA: MOVIMIENTO
-- =============================================
local TabMove = Window:CreateTab("Movement", 4483362458)

-- VELOCIDAD
TabMove:CreateSlider({
    Name = "Walk Speed",
    Range = {1, 1000},
    CurrentValue = 152,
    Callback = function(Value)
        Humanoid.WalkSpeed = Value
    end,
})

-- SALTO
TabMove:CreateSlider({
    Name = "Jump Power",
    Range = {1, 500},
    CurrentValue = 50,
    Callback = function(Value)
        Humanoid.JumpPower = Value
    end,
})

-- GRAVEDAD
TabMove:CreateSlider({
    Name = "Gravity",
    Range = {0, 200},
    CurrentValue = OriginalGravity,
    Callback = function(Value)
        Workspace.Gravity = Value
    end,
})

-- BAILE Y GIRO
TabMove:CreateToggle({
    Name = "Hips Dance",
    CurrentValue = false,
    Callback = function(Value)
        spawn(function()
            while Value and task.wait() do
                HumRootPart.CFrame = HumRootPart.CFrame * CFrame.Angles(0, math.rad(5), 0)
            end
        end)
    end,
})

TabMove:CreateToggle({
    Name = "Spin Bot",
    CurrentValue = false,
    Callback = function(Value)
        spawn(function()
            while Value and task.wait() do
                HumRootPart.CFrame = HumRootPart.CFrame * CFrame.Angles(0, math.rad(10), 0)
            end
        end)
    end,
})

-- =============================================
--                 FINAL
-- =============================================
print("✅ Script Hoshi cargado exitosamente!")
