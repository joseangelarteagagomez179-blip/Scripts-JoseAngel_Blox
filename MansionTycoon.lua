--// SCRIPT COMPLETO PARA MANSION TYCOON 🏰❤️
--// Creado especialmente para ti 🥰
--// Compatible con Delta, Hydrogen, Fluxus, Arceus X

--// SERVICIOS
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

--// CONFIGURACIÓN (Puedes cambiar los valores si quieres)
local Config = {
    AutoBuild = true,      -- Auto Construir
    AutoCollect = true,    -- Auto Recolectar Dinero
    Speed = 75,            -- Velocidad normal
    FlySpeed = 120,        -- Velocidad volando
    EnableFly = true       -- Activar Fly
}

--// FUNCIÓN DE NOTIFICACIÓN
local function Notify(title, text)
    game.StarterGui:SetCore("SendNotification", {
        Title = title;
        Text = text;
        Duration = 3;
    })
end

Notify("✅ Script Cargado", "Bienvenido "..Player.Name)

--// 🏗️ AUTO CONSTRUIR
spawn(function()
    while Config.AutoBuild and task.wait(0.5) do
        pcall(function()
            for _, v in pairs(Workspace:GetDescendants()) do
                if v:FindFirstChild("ClickDetector") and v.Name:find("Build") or v.Name:find("Buy") then
                    fireclickdetector(v.ClickDetector)
                    task.wait(0.1)
                end
            end
        end)
    end
end)

--// 💰 AUTO RECOLECTAR DINERO
spawn(function()
    while Config.AutoCollect and task.wait(0.2) do
        pcall(function()
            for _, item in pairs(Workspace:GetChildren()) do
                if item.Name:find("Money") or item.Name:find("Cash") then
                    item:Destroy()
                    Player.leaderstats.Money.Value += 1000 -- Aumenta dinero
                end
            end
        end)
    end
end)

--// ⚡ VELOCIDAD Y SALTO
Humanoid.WalkSpeed = Config.Speed
Humanoid.JumpPower = 100

--// 🚀 FLY (VOLAR)
if Config.EnableFly then
    local Camera = Workspace.CurrentCamera
    local Keys = {W=false, A=false, S=false, D=false, Space=false, LeftControl=false}

    -- Detectar teclas
    game:GetService("UserInputService").InputBegan:Connect(function(Input, GP)
        if not GP then
            if Input.KeyCode == Enum.KeyCode.W then Keys.W = true end
            if Input.KeyCode == Enum.KeyCode.A then Keys.A = true end
            if Input.KeyCode == Enum.KeyCode.S then Keys.S = true end
            if Input.KeyCode == Enum.KeyCode.D then Keys.D = true end
            if Input.KeyCode == Enum.KeyCode.Space then Keys.Space = true end
            if Input.KeyCode == Enum.KeyCode.LeftControl then Keys.LeftControl = true end
        end
    end)

    game:GetService("UserInputService").InputEnded:Connect(function(Input, GP)
        if not GP then
            if Input.KeyCode == Enum.KeyCode.W then Keys.W = false end
            if Input.KeyCode == Enum.KeyCode.A then Keys.A = false end
            if Input.KeyCode == Enum.KeyCode.S then Keys.S = false end
            if Input.KeyCode == Enum.KeyCode.D then Keys.D = false end
            if Input.KeyCode == Enum.KeyCode.Space then Keys.Space = false end
            if Input.KeyCode == Enum.KeyCode.LeftControl then Keys.LeftControl = false end
        end
    end)

    -- Moverse volando
    RunService.RenderStepped:Connect(function()
        local CF = Camera.CFrame
        local Direction = Vector3.new()

        if Keys.W then Direction += CF.LookVector end
        if Keys.S then Direction -= CF.LookVector end
        if Keys.A then Direction -= CF.RightVector end
        if Keys.D then Direction += CF.RightVector end
        if Keys.Space then Direction += Vector3.new(0,1,0) end
        if Keys.LeftControl then Direction -= Vector3.new(0,1,0) end

        RootPart.Velocity = Direction * Config.FlySpeed
    end)
end

Notify("🎉 ¡Todo activado!", "Disfruta el juego mi amor 😘")
