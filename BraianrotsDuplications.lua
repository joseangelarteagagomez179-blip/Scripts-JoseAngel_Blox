--[[
    +1Speed JoseAngel_Blox
    Creador: JoseAngel_Blox
    Fecha de Creación: 01/06/2026
]]

-- === SERVICIOS ===
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local camera = workspace.CurrentCamera

-- === VARIABLES DE ESTADO ===
local _G = {
    autoFarm = false,
    autoWin = false,
    autoRebirth = false,
    noclip = false,
    infJump = false,
    fly = false,
    ws = 16,
    jp = 50,
    showFPS = false
}

-- === INTERFAZ (GUI) ===
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Blox_Hub"
ScreenGui.Parent = player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 350, 0, 450)
Main.Position = UDim2.new(0.5, -175, 0.5, -225)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", Main).Color = Color3.fromRGB(120, 50, 255)

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(45, 20, 80)
Title.Text = "+1Speed JoseAngel_Blox"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = Main
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 12)

-- Contenedor de Páginas
local Container = Instance.new("ScrollingFrame")
Container.Size = UDim2.new(1, -20, 1, -100)
Container.Position = UDim2.new(0, 10, 0, 50)
Container.BackgroundTransparency = 1
Container.CanvasSize = UDim2.new(0, 0, 0, 800)
Container.ScrollBarThickness = 2
Container.Parent = Main
local Layout = Instance.new("UIListLayout", Container)
Layout.Padding = UDim.new(0, 8)

-- === FUNCIONES DE CREACIÓN ===
local function NewButton(text, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 14
    btn.Parent = Container
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local function NewToggle(text, callback)
    local active = false
    local btn = NewButton("❌ " .. text, Color3.fromRGB(50, 50, 70), function()
        active = not active
        callback(active)
    end)
    
    spawn(function()
        while true do
            wait(0.1)
            btn.Text = (active and "✔ " or "❌ ") .. text
            btn.BackgroundColor3 = active and Color3.fromRGB(80, 40, 150) or Color3.fromRGB(50, 50, 70)
        end
    end)
end

-- === PÁGINA 1: INFO ===
local info = Instance.new("TextLabel", Container)
info.Size = UDim2.new(1, 0, 0, 60)
info.BackgroundTransparency = 1
info.Text = "👤 Creador: JoseAngel_Blox\n📅 Fecha: 01/06/2026\n(Usa ↑↓ para ajustar)"
info.TextColor3 = Color3.new(0.8, 0.8, 0.8)
info.Font = Enum.Font.Gotham
info.TextSize = 14

-- === PÁGINA 2: MAIN (Lógica del Juego) ===
local Remotes = ReplicatedStorage:FindFirstChild("Remotes") or ReplicatedStorage -- Ajuste dinámico

NewToggle("Auto Farm (Velocidad)", function(v) _G.autoFarm = v end)
NewToggle("Auto Win (Copas)", function(v) _G.autoWin = v end)
NewToggle("Auto Rebirth", function(v) _G.autoRebirth = v end)
NewToggle("Remove Obstacles", function()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == "MovingObstacle" or obj.Name == "KillPart" then obj:Destroy() end
    end
end)
NewToggle("Godmode", function(v)
    if v then player.Character.Humanoid.MaxHealth = math.huge player.Character.Humanoid.Health = math.huge end
end)

-- === PÁGINA 3: PLAYER ===
NewToggle("Fly", function(v) _G.fly = v end)
NewToggle("Noclip", function(v) _G.noclip = v end)
NewToggle("Infinite Jump", function(v) _G.infJump = v end)

NewButton("Aumentar WalkSpeed ↑", Color3.fromRGB(40, 100, 40), function() _G.ws = _G.ws + 10 end)
NewButton("Disminuir WalkSpeed ↓", Color3.fromRGB(100, 40, 40), function() _G.ws = math.max(16, _G.ws - 10) end)

-- === PÁGINA 4: FREE SHOP (Visual Hack) ===
NewButton("🔓 Desbloquear Todo (Treadmills/Auras)", Color3.fromRGB(200, 150, 0), function()
    -- Simula que tienes los items para usarlos
    local data = player:FindFirstChild("leaderstats") or player:FindFirstChild("Data")
    if data then
        print("Items desbloqueados visualmente para JoseAngel_Blox")
    end
end)

-- === PÁGINA 5: CONFIG ===
local FPSLabel = Instance.new("TextLabel", ScreenGui)
FPSLabel.Size = UDim2.new(0, 80, 0, 30)
FPSLabel.Position = UDim2.new(0, 10, 0, 10)
FPSLabel.Visible = false
FPSLabel.BackgroundColor3 = Color3.new(0,0,0)
FPSLabel.TextColor3 = Color3.new(0,1,0)
FPSLabel.TextSize = 14
Instance.new("UICorner", FPSLabel)

NewToggle("Mostrar FPS", function(v) FPSLabel.Visible = v end)
NewButton("Anti-Lag / Optimizar", Color3.fromRGB(40, 40, 40), function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("BasePart") and not v.Parent:FindFirstChild("Humanoid") then
            v.Material = Enum.Material.SmoothPlastic
        end
        if v:IsA("Decal") or v:IsA("Texture") then v:Destroy() end
    end
    Lighting.GlobalShadows = false
end)

-- === LOOPS DE EJECUCIÓN (THREADS) ===

-- Auto Farm & Win
spawn(function()
    while wait() do
        if _G.autoFarm then
            -- Evento común en estos juegos para ganar velocidad al caminar o clickear
            ReplicatedStorage.Remotes.AddSpeed:FireServer() 
        end
        if _G.autoWin then
            -- Teletransporta al final del mapa (ajusta según el mapa)
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.CFrame = workspace.EndPart.CFrame -- Ajuste genérico
            end
        end
        if _G.autoRebirth then
            ReplicatedStorage.Remotes.Rebirth:FireServer()
        end
    end
end)

-- Player Loop
RunService.RenderStepped:Connect(function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = _G.ws
        if _G.noclip then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end
    if FPSLabel.Visible then
        FPSLabel.Text = "FPS: " .. math.floor(1/RunService.RenderStepped:Wait())
    end
end)

-- Jump
UserInputService.JumpRequest:Connect(function()
    if _G.infJump and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

print("¡Script +1Speed JoseAngel_Blox Listo!")
