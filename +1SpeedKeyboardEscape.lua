-- // SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumRootPart = Character:WaitForChild("HumanoidRootPart")

-- // VARIABLES
local AutoWinActive = false
local AutoRebirthActive = false
local AutoSpeedActive = false

-- =============================================
--       FUNCIONES REALES DE HOSHI HUB
-- =============================================

-- AUTO WIN (La función real)
local function AutoWin()
    spawn(function()
        while AutoWinActive do
            task.wait(0.1)
            pcall(function()
                -- Esto es lo que hace el script original
                ReplicatedStorage.Default:InvokeServer("Interact", "WB1")
            end)
        end
    end)
end

-- AUTO SPEED & TP A MAQUINA
local function AutoSpeed()
    spawn(function()
        while AutoSpeedActive do
            task.wait(1)
            pcall(function()
                -- Ir a la mejor maquina
                local Treadmills = Workspace:FindFirstChild("Treadmills")
                if Treadmills then
                    local Best = Treadmills:GetChildren()[#Treadmills:GetChildren()]
                    HumRootPart.CFrame = Best.CFrame + Vector3.new(0,3,0)
                end
            end)
        end
    end)
end

-- AUTO REBIRTH
local function AutoRebirth()
    spawn(function()
        while AutoRebirthActive do
            task.wait(3)
            pcall(function()
                ReplicatedStorage.Default:InvokeServer("Rebirth")
            end)
        end
    end)
end

-- QUITAR OBSTACULOS
local function RemoveObstacles()
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("Part") and (v.Name:find("Wall") or v.Name:find("Obstacle")) then
            v.CanCollide = false
            v.Transparency = 1
        end
    end
end

-- GOD MODE
local function GodMode()
    spawn(function()
        while true do
            Humanoid.Health = Humanoid.MaxHealth
            task.wait()
        end
    end)
end

-- AUTO COMPRAR
local function AutoBuy()
    spawn(function()
        while true do
            task.wait(5)
            pcall(function()
                for _, item in pairs(Player.PlayerGui.Shop:GetDescendants()) do
                    if item.Name == "Buy" and item:IsA("ClickDetector") then
                        fireclickdetector(item)
                    end
                end
            end)
        end
    end)
end

-- =============================================
--       CREAR MENU VISUAL (SIN LIBRERIAS)
-- =============================================
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local AutoWinBtn = Instance.new("TextButton")
local AutoRebirthBtn = Instance.new("TextButton")
local RemoveObsBtn = Instance.new("TextButton")
local GodModeBtn = Instance.new("TextButton")
local AutoBuyBtn = Instance.new("TextButton")

-- Propiedades
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0, 300, 0, 350)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "⚡ HOSHI HUB - SPEED KEYBOARD"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextSize = 14

-- BOTONES
local y = 40
local function MakeButton(name, func)
    local btn = Instance.new("TextButton")
    btn.Parent = MainFrame
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.Position = UDim2.new(0, 10, 0, y)
    btn.Size = UDim2.new(0, 280, 0, 30)
    btn.Font = Enum.Font.Gotham
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.TextSize = 12
    btn.MouseButton1Click:Connect(func)
    y = y + 40
end

-- AGREGAR BOTONES
MakeButton("🔴 ACTIVAR AUTO WIN", function()
    AutoWinActive = not AutoWinActive
    if AutoWinActive then AutoWin() end
    print("Auto Win: "..tostring(AutoWinActive))
end)

MakeButton("🔴 ACTIVAR AUTO SPEED", function()
    AutoSpeedActive = not AutoSpeedActive
    if AutoSpeedActive then AutoSpeed() end
    print("Auto Speed: "..tostring(AutoSpeedActive))
end)

MakeButton("🔴 ACTIVAR AUTO REBIRTH", function()
    AutoRebirthActive = not AutoRebirthActive
    if AutoRebirthActive then AutoRebirth() end
    print("Auto Rebirth: "..tostring(AutoRebirthActive))
end)

MakeButton("🧱 REMOVER OBSTACULOS", RemoveObstacles)
MakeButton("🛡️ GOD MODE", GodMode)
MakeButton("🛒 AUTO COMPRAR TODO", AutoBuy)

-- =============================================
--       COMANDOS DE MOVIMIENTO RAPIDO
-- =============================================
-- Presiona W para velocidad alta, S para normal, A para saltar alto, D gravedad baja
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.W then
        Humanoid.WalkSpeed = 500
    elseif input.KeyCode == Enum.KeyCode.S then
        Humanoid.WalkSpeed = 16
    elseif input.KeyCode == Enum.KeyCode.A then
        Humanoid.JumpPower = 150
    elseif input.KeyCode == Enum.KeyCode.D then
        Workspace.Gravity = 10
    end
end)

print("✅ HOSHI HUB CARGADO EXITOSAMENTE!")
print("📱 Mueve el menú arrastrando la barra negra")
