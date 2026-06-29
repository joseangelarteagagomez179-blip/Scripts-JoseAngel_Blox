-- // SERVICIOS
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

-- // VARIABLES
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
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
            -- Comprar piezas de la casa
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
            -- Moverse un poquito cada 2 minutos
            HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(1,0,1)
            wait(0.5)
            HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(-1,0,-1)
        end
    end
end)

-- ==============================================
-- [[ 🚗 TELETRANSPORTES RÁPIDOS ]]
-- ==============================================

-- Para usar estos comandos, escribe en el chat: !casa, !pista, !yate

Player.Chatted:Connect(function(Message)
    local Msg = Message:lower()
    if Msg == "!casa" then
        -- Busca tu zona de construcción
        for _, Zone in pairs(workspace:GetChildren()) do
            if string.find(Zone.Name:lower(), Player.Name:lower()) or string.find(Zone.Name:lower(), "plot") then
                Teleport(Zone.Position + Vector3.new(0,5,0))
                print("Teletransportado a tu casa!")
                break
            end
        end
    elseif Msg == "!pista" then
        Teleport(Vector3.new(100, 10, 100)) -- Ajusta coordenadas si es necesario
        print("Teletransportado a la pista de carreras!")
    elseif Msg == "!yate" then
        Teleport(Vector3.new(-200, 10, -150)) -- Ajusta coordenadas
        print("Teletransportado al yate!")
    end
end)

-- ==============================================
-- [[ 🎨 MENÚ VISUAL (Rayfield UI) ]]
-- ==============================================

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()
local Window = Library:CreateWindow({
    Name = "Mansion Tycoon | Script",
    LoadingTitle = "Cargando...",
    LoadingSubtitle = "Por favor espera",
    Theme = "Default"
})

local TabMain = Window:CreateTab("Principal", 4483362458)
local TabMove = Window:CreateTab("Movimiento", 10734898478)
local TabTeleport = Window:CreateTab("Teletransportes", 10709797733)

-- Pestaña Principal
TabMain:CreateToggle({
    Name = "Auto Recolectar Dinero",
    CurrentValue = true,
    Callback = function(Value)
        Config.AutoCollect = Value
    end
})

TabMain:CreateToggle({
    Name = "Auto Construir / Mejorar",
    CurrentValue = true,
    Callback = function(Value)
        Config.AutoBuild = Value
    end
})

TabMain:CreateToggle({
    Name = "Anti AFK",
    CurrentValue = true,
    Callback = function(Value)
        Config.AntiAFK = Value
    end
})

-- Pestaña Movimiento
TabMove:CreateSlider({
    Name = "Velocidad",
    Range = {16, 200},
    Increment = 1,
    CurrentValue = 50,
    Callback = function(Value)
        Config.Speed = Value
    end
})

TabMove:CreateToggle({
    Name = "Modo Volar",
    CurrentValue = false,
    Callback = function(Value)
        Config.Fly = Value
        Humanoid.PlatformStand = Value -- Evita que caigas
    end
})

-- Pestaña Teletransportes
TabTeleport:CreateButton({
    Name = "Ir a mi Casa",
    Callback = function()
        for _, Zone in pairs(workspace:GetChildren()) do
            if string.find(Zone.Name:lower(), Player.Name:lower()) or string.find(Zone.Name:lower(), "plot") then
                Teleport(Zone.Position + Vector3.new(0,5,0))
            end
        end
    end
})

TabTeleport:CreateButton({
    Name = "Ir a Pista de Carreras",
    Callback = function()
        Teleport(Vector3.new(100, 10, 100))
    end
})

TabTeleport:CreateButton({
    Name = "Ir al Yate",
    Callback = function()
        Teleport(Vector3.new(-200, 10, -150))
    end
})

print("✅ Script cargado completamente!")
