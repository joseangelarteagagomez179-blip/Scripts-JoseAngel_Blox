--// SCRIPT CORREGIDO PARA MANSION TYCOON 🏰❤️
--// Versión estable para Android 📱

--// SERVICIOS
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

--// CONFIGURACIÓN
local Config = {
    AutoBuild = true,
    AutoCollect = true,
    Speed = 75,
    FlySpeed = 120,
    EnableFly = true
}

--// NOTIFICACIÓN (SOLO UNA VEZ)
game.StarterGui:SetCore("SendNotification", {
    Title = "✅ Script Cargado";
    Text = "Bienvenido "..Player.Name.." | Disfruta mi amor 😘";
    Duration = 5;
})

--// ⚡ VELOCIDAD Y SALTO
Humanoid.WalkSpeed = Config.Speed
Humanoid.JumpPower = 100

--// 🏗️ AUTO CONSTRUIR (MEJORADO)
spawn(function()
    while Config.AutoBuild and task.wait(0.3) do
        pcall(function()
            -- Busca en todo el juego los botones para construir
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("ClickDetector") then
                    fireclickdetector(obj)
                end
            end
        end)
    end
end)

--// 💰 AUTO DINERO (MEJORADO)
spawn(function()
    while Config.AutoCollect and task.wait(0.1) do
        pcall(function()
            -- Busca dinero y partículas
            for _, item in pairs(Workspace:GetChildren()) do
                if string.find(string.lower(item.Name), "money") or string.find(string.lower(item.Name), "cash") or string.find(string.lower(item.Name), "coin") then
                    item:Destroy()
                    if Player.leaderstats and Player.leaderstats:FindChild("Money") then
                        Player.leaderstats.Money.Value += 500
                    end
                end
            end
        end)
    end
end)

--// 🚀 FLY (VOLAR)
if Config.EnableFly then
    local Camera = Workspace.CurrentCamera
    local Keys = {W=false, A=false, S=false, D=false, Space=false, LeftControl=false}

    game:GetService("UserInputService").InputBegan:Connect(function(Input, GP)
        if not GP then
            if Input.KeyCode == Enum.KeyCode.W then Keys.W = true end
            if Input.KeyCode == Enum.KeyCode.A then Keys.A = true end
            if Input.KeyCode == S then Keys.S = true end
            if Input.KeyCode == D then Keys.D = true end
            if Input.KeyCode == Space then Keys.Space = true end
            if Input.KeyCode == LeftControl then Keys.LeftControl = true end
        end
    end)

    game:GetService("UserInputService").InputEnded:Connect(function(Input, GP)
        if not GP then
            if Input.KeyCode == Enum.KeyCode.W then Keys.W = false end
            if Input.KeyCode == Enum.KeyCode.A then Keys.A = false end
            if Input.KeyCode == S then Keys.S = false end
            if Input.KeyCode == D then Keys.D = false end
            if Input.KeyCode == Space then Keys.Space = false end
            if Input.KeyCode == LeftControl then Keys.LeftControl = false end
        end
    end)

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
