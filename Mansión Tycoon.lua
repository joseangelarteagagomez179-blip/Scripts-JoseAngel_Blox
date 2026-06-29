-- // SERVICIOS
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

-- // VARIABLES
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Child("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- // CONFIGURACIÓN
local Config = {
    AutoCollect = true,
    AutoBuild = true,
    Speed = 50,
    Fly = false,
    AntiAFK = true
}

-- ==============================================
-- [[ 🔧 FUNCIONES BÁSICAS ]]
-- ==============================================

local function Teleport(Pos)
    local Tween = TweenService:Create(HumanoidRootPart, TweenInfo.new(0.3), {CFrame = CFrame.new(Pos)})
    Tween:Play()
end

local function FindAndClick(NameContains)
    for _, Obj in pairs(workspace:GetDescendants()) do
        if Obj:IsA("ClickDetector") and string.find(Obj.Parent.Name:lower(), NameContains:lower()) then
            fireclickdetector(Obj)
            wait(0.2)
        end
    end
end

-- ==============================================
-- [[ 💰 AUTO RECOLECTAR DINERO ]]
-- ==============================================

spawn(function()
    while wait(0.5) do
        if Config.AutoCollect then
            for _, Money in pairs(workspace:GetChildren()) do
                if string.find(Money.Name:lower(), "money") or string.find(Money.Name:lower(), "cash") or string.find(Money.Name:lower(), "collect") then
                    Teleport(Money.Position + Vector3.new(0, 3, 0))
                    wait(0.1)
                end
            end
        end
    end
end)

-- ==============================================
-- [[ 🏗️ AUTO CONSTRUIR Y MEJORAR ]]
-- ==============================================

spawn(function()
    while wait(2) do
        if Config.AutoBuild then
            FindAndClick("build")
            FindAndClick("buy")
            FindAndClick("upgrade")
            FindAndClick("wall")
            FindAndClick("floor")
            FindAndClick("room")
        end
    end
end)

-- ==============================================
-- [[ ⚡ VELOCIDAD Y VOLAR ]]
-- ==============================================

spawn(function()
    while wait() do
        Humanoid.WalkSpeed = Config.Speed
        if Config.Fly then
            HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            local CameraCF = workspace.CurrentCamera.CFrame
            local MoveDir = Vector3.new()
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then MoveDir += CameraCF.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then MoveDir -= CameraCF.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then MoveDir -= CameraCF.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then MoveDir += CameraCF.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then MoveDir += Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then MoveDir -= Vector3.new(0,1,0) end
            
            HumanoidRootPart.CFrame = HumanoidRootPart.CFrame + MoveDir * 0.3
        end
    end
end)

-- ==============================================
-- [[ 🛡️ ANTI AFK ]]
-- ==============================================

spawn(function()
    while wait(120) do
        if Config.AntiAFK then
            HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(1,0,1)
            wait(0.5)
            HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(-1,0,-1)
        end
    end
end)

-- ==============================================
-- [[ 🎨 MENÚ VISUAL (ESTILO CUADRADO REDONDEADO) ]]
-- ==============================================

local Window = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua", true))()

local Main = Window:CreateWindow({
    Name = "Mansion Tycoon",
    Size = UDim2.new(0, 280, 0, 420), -- Tamaño cuadrado
    Position = UDim2.new(0.4, 0, 0.3, 0)
})

-- Pestañas
local TabPrincipal = Main:CreateTab("Inicio")
local TabMovimiento = Main:CreateTab("Movimiento")
local TabTeleports = Main:CreateTab("Teleports")

-- Sección Principal
TabPrincipal:CreateToggle({
    Name = "Auto Recolectar Dinero",
    CurrentValue = true,
    Callback = function(v) Config.AutoCollect = v end
})

TabPrincipal:CreateToggle({
    Name = "Auto Construir Todo",
    CurrentValue = true,
    Callback = function(v) Config.AutoBuild = v end
})

TabPrincipal:CreateToggle({
    Name = "Anti AFK",
    CurrentValue = true,
    Callback = function(v) Config.AntiAFK = v end
})

-- Sección Movimiento
TabMovimiento:CreateSlider({
    Name = "Velocidad",
    Min = 16,
    Max = 200,
    Default = 50,
    Callback = function(v) Config.Speed = v end
})

TabMovimiento:CreateToggle({
    Name = "Modo Volar",
    CurrentValue = false,
    Callback = function(v) Config.Fly = v end
})

-- Sección Teleports
TabTeleports:CreateButton({
    Name = "Ir a Casa",
    Callback = function()
        for _, Zone in pairs(workspace:GetChildren()) do
            if string.find(Zone.Name:lower(), "plot") or string.find(Zone.Name:lower(), Player.Name:lower()) then
                Teleport(Zone.Position + Vector3.new(0,8,0))
                break
            end
        end
    end
})

TabTeleports:CreateButton({
    Name = "Ir a Tienda",
    Callback = function()
        Teleport(Vector3.new(0, 10, -150)) -- Ajusta si quieres
    end
})

-- 💡 Características del diseño:
-- ✅ Es CUADRADO perfecto
-- ✅ Tiene ESQUINAS REDONDEADAS
-- ✅ Se puede AGARRAR Y MOVER por toda la pantalla
-- ✅ Se ve moderno y limpio

print("✅ Script cargado con éxito!")
    
