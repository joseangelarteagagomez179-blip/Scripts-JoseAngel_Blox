--[[
███╗   ███╗██╗███╗   ██╗██╗███████╗██╗     ███████╗
████╗ ████║██║████╗  ██║██║██╔════╝██║     ██╔════╝
██╔████╔██║██║██╔██╗ ██║██║█████╗  ██║     █████╗  
██║╚██╔╝██║██║██║╚██╗██║██║██╔══╝  ██║     ██╔══╝  
██║ ╚═╝ ██║██║██║ ╚████║██║███████╗███████╗███████╗
╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝╚══════╝╚══════╝╚══════╝
            Mansion Tycoon Script | CARS
]]

-- Servicios
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local Camera = workspace.CurrentCamera

-- =============================================
-- 🎨 CREAR LA INTERFAZ (MENU)
-- =============================================

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local AutoBuildToggle = Instance.new("TextButton")
local AutoCollectToggle = Instance.new("TextButton")
local AntiAFKToggle = Instance.new("TextButton")

-- Propiedades de la GUI
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BorderSizePixel = 2
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 180)
MainFrame.Active = true
MainFrame.Draggable = true -- Para mover la ventana

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.BorderSizePixel = 0
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "Mansion Tycoon | CARS"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14

-- Función para crear botones estilo Toggle
local function CreateToggle(name, pos, parent)
    local Button = Instance.new("TextButton")
    Button.Parent = parent
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Button.BorderSizePixel = 0
    Button.Position = pos
    Button.Size = UDim2.new(1, -10, 0, 30)
    Button.Font = Enum.Font.Gotham
    Button.Text = name .. " [ OFF ]"
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 12
    return Button
end

-- Crear los botones
AutoBuildToggle = CreateToggle("Auto Build", UDim2.new(0, 5, 0, 40), MainFrame)
AutoCollectToggle = CreateToggle("Auto Collect Cash", UDim2.new(0, 5, 0, 80), MainFrame)
AntiAFKToggle = CreateToggle("Anti AFK", UDim2.new(0, 5, 0, 120), MainFrame)

-- =============================================
-- ⚙️ VARIABLES DE ESTADO (ON/OFF)
-- =============================================

local AutoBuild_Enabled = false
local AutoCollect_Enabled = false
local AntiAFK_Enabled = false

-- =============================================
-- 🔘 LÓGICA DE LOS BOTONES
-- =============================================

AutoBuildToggle.MouseButton1Click:Connect(function()
    AutoBuild_Enabled = not AutoBuild_Enabled
    AutoBuildToggle.Text = "Auto Build [ " .. (AutoBuild_Enabled and "ON ]" or "OFF ]")
    AutoBuildToggle.BackgroundColor3 = AutoBuild_Enabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(50, 50, 50)
end)

AutoCollectToggle.MouseButton1Click:Connect(function()
    AutoCollect_Enabled = not AutoCollect_Enabled
    AutoCollectToggle.Text = "Auto Collect Cash [ " .. (AutoCollect_Enabled and "ON ]" or "OFF ]")
    AutoCollectToggle.BackgroundColor3 = AutoCollect_Enabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(50, 50, 50)
end)

AntiAFKToggle.MouseButton1Click:Connect(function()
    AntiAFK_Enabled = not AntiAFK_Enabled
    AntiAFKToggle.Text = "Anti AFK [ " .. (AntiAFK_Enabled and "ON ]" or "OFF ]")
    AntiAFKToggle.BackgroundColor3 = AntiAFK_Enabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(50, 50, 50)
end)

-- =============================================
-- 🛠️ FUNCIÓN: AUTO BUILD
-- =============================================

spawn(function()
    while wait() do
        if AutoBuild_Enabled then
            -- Aquí va la lógica para buscar botones y construir
            -- Ejemplo básico:
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("ClickDetector") and (v.Parent.Name:find("Build") or v.Parent.Name:find("Buy")) then
                    fireclickdetector(v)
                    wait(0.1)
                end
            end
        end
    end
end)

-- =============================================
-- 💰 FUNCIÓN: AUTO COLLECT CASH
-- =============================================

spawn(function()
    while wait() do
        if AutoCollect_Enabled then
            -- Aquí va la lógica para recoger dinero
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Part") and (v.Name:find("Cash") or v.Name:find("Money")) then
                    -- Simula tocar el objeto
                    firetouchinterest(Player.Character.HumanoidRootPart, v, 0)
                    firetouchinterest(Player.Character.HumanoidRootPart, v, 1)
                end
            end
        end
    end
end)

-- =============================================
-- 🛡️ FUNCIÓN: ANTI AFK
-- =============================================

spawn(function()
    while wait(60) do -- Cada minuto
        if AntiAFK_Enabled and Player.Character then
            -- Hace un pequeño salto o movimiento
            local Humanoid = Player.Character:FindChildOfClass("Humanoid")
            if Humanoid then
                Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)

print("✅ Script cargado exitosamente!")
