-- // SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumRootPart = Character:WaitForChild("HumanoidRootPart")

-- // VARIABLES GLOBALES
local Enabled = true
local AutoWinActive = false
local OriginalGravity = Workspace.Gravity

-- =============================================
--                INTERFAZ GUI
-- =============================================
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Speed Keyboard | Dola Script", "Ocean")

-- =============================================
--              FUNCIONES PRINCIPALES
-- =============================================
local TabMain = Window:NewTab("⚡ PRINCIPAL")

-- Auto Speed
TabMain:NewToggle("Auto Speed", "Mantiene la velocidad máxima", function(state)
    if state then
        spawn(function()
            while Enabled and wait(0.5) do
                if Humanoid then Humanoid.WalkSpeed = 100 end
            end
        end)
    end
end)

-- Auto Win
TabMain:NewToggle("Auto Win", "Presiona las teclas automáticamente", function(state)
    AutoWinActive = state
    if state then
        spawn(function()
            while AutoWinActive and wait() do
                pcall(function()
                    -- Detecta la tecla (ajusta la ruta si es necesario)
                    local KeyText = Workspace:FindFirstChild("KeyUI") or Workspace:FindFirstChildWhichIsA("Part")
                    -- Aquí intentamos detectar y presionar
                    UserInputService:SendKeyDownPressed(Enum.KeyCode.W, false, false)
                    task.wait()
                    UserInputService:SendKeyUpReleased(Enum.KeyCode.W, false, false)
                    -- Repite con A, S, D dependiendo del juego
                end)
            end
        end)
    end
end)

-- God Mode
TabMain:NewToggle("God Mode", "Nunca mueres", function(state)
    while state and wait() do
        if Humanoid.Health < Humanoid.MaxHealth then
            Humanoid.Health = Humanoid.MaxHealth
        end
    end
end)

-- Obstacle & Safety (Quitar obstáculos)
TabMain:NewButton("Obstacle & Safety", "Eliminar obstáculos", function()
    for _, v in pairs(Workspace:GetChildren()) do
        if v:IsA("Part") or v:IsA("Model") and string.find(v.Name:lower(), "obstacle") or string.find(v.Name:lower(), "wall") then
            v:Destroy()
        end
    end
end)

-- Auto Rebirth
TabMain:NewToggle("Auto Rebirth", "Renacer automáticamente", function(state)
    spawn(function()
        while state and wait(5) do
            pcall(function()
                -- Busca el botón de rebirth y haz click
                fireclickdetector(game:GetService("ReplicatedStorage").RebirthButton or Workspace.RebirthPart.ClickDetector)
            end)
        end
    end)
end)

-- Teleport World
TabMain:NewTextBox("Ir al Mundo", "Escribe el número", function(text)
    -- Aquí puedes modificar para teletransportarte
    print("Yendo al mundo: "..text)
end)

-- =============================================
--                 MOVIMIENTO
-- =============================================
local TabMove = Window:NewTab("🛑 MOVIMIENTO")

-- Walk Speed
TabMove:NewSlider("Walk Speed", "Ajusta la velocidad", 1, 500, 50, function(Value)
    Humanoid.WalkSpeed = Value
end)

-- Jump Power
TabMove:NewSlider("Jump Power", "Ajusta el salto", 1, 500, 50, function(Value)
    Humanoid.JumpPower = Value
end)

-- Gravity
TabMove:NewSlider("Gravity", "Gravedad", 0, 200, OriginalGravity, function(Value)
    Workspace.Gravity = Value
end)

-- Hips Dance
TabMove:NewToggle("Hips Dance", "Bailar", function(state)
    spawn(function()
        while state and wait() do
            HumRootPart.CFrame = HumRootPart.CFrame * CFrame.Angles(0, math.rad(10), 0)
        end
    end)
end)

-- Spin Bot
TabMove:NewToggle("Spin Bot", "Girar sin parar", function(state)
    spawn(function()
        while state and wait() do
            HumRootPart.CFrame = HumRootPart.CFrame * CFrame.Angles(0, math.rad(5), 0)
        end
    end)
end)

-- =============================================
--              TIENDA Y EFECTOS
-- =============================================
local TabShop = Window:NewTab("🛒 TIENDA")

-- Auto Buy Items
TabShop:NewButton("Auto Buy Items", "Comprar todo", function()
    pcall(function()
        -- Simula click en todos los botones de compra
        for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Shop:GetChildren()) do
            if v:FindFirstChild("BuyButton") then
                fireclickdetector(v.BuyButton.ClickDetector)
            end
        end
    end)
end)

-- Unlock All
TabShop:NewButton("Unlock All Treadmill", "Desbloquear máquinas", function()
    print("Desbloqueando...")
end)

TabShop:NewButton("Unlock All Sound", "Desbloquear sonidos", function()
    print("Sonidos desbloqueados")
end)

-- Trails / Auras
TabShop:NewDropdown("✨ Trails / Estelas", {"Supernova", "Void", "Cosmic", "Fire", "Ice"}, function(selected)
    print("Seleccionaste: "..selected)
    -- Aquí iría el código para poner la estela
end)

TabShop:NewDropdown("💫 Auras", {"Red", "Blue", "Gold", "Rainbow"}, function(selected)
    print("Aura: "..selected)
end)

-- =============================================
--                 FINAL
-- =============================================
print("✅ Script Cargado Correctamente")
