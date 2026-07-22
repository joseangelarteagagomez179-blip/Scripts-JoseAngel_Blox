-- // Script Creado por JoseAngel_Blox
-- // Error corregido: Uso correcto de UICorner

-- SERVICIOS
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- VARIABLES
local Player = game.Players.LocalPlayer
local PlayerGui = Player.PlayerGui

-- LIMPIAR SI EXISTE
if PlayerGui:FindFirstChild("MenuJoseAngel") then PlayerGui.MenuJoseAngel:Destroy() end

-- CREAR SCREENGUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MenuJoseAngel"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.Parent = game:GetService("CoreGui")

-- PROTECCIÓN PARA DELTA
if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
end

-- 🟦 MARCO PRINCIPAL (YA CORREGIDO)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 420)
MainFrame.Position = UDim2.new(0.05, 0, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- ✅ ESQUINAS REDONDAS (ASÍ SE HACE BIEN)
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14) -- Tamaño de esquina que querías
MainCorner.Parent = MainFrame

-- TÍTULO
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "JoseAngel_Blox | Script"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Title.Parent = MainFrame

-- Ejemplo para un botón:
local BotonPrueba = Instance.new("TextButton")
BotonPrueba.Size = UDim2.new(0.9, 0, 0, 40)
BotonPrueba.Position = UDim2.new(0.05, 0, 0, 70)
BotonPrueba.BackgroundColor3 = Color3.fromRGB(60, 20, 120)
BotonPrueba.Text = "Botón de Prueba"
BotonPrueba.TextColor3 = Color3.new(1,1,1)
BotonPrueba.Font = Enum.Font.Gotham
BotonPrueba.Parent = MainFrame

-- ✅ Esquinas al botón igual que al marco
local BotonCorner = Instance.new("UICorner")
BotonCorner.CornerRadius = UDim.new(0, 8)
BotonCorner.Parent = B
otonPrueba
