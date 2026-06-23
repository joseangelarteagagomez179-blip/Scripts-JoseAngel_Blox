-- // SERVICES
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local PlayerGui = Players.LocalPlayer.PlayerGui
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- // VARIABLES GLOBALES
local ScriptEnabled = true
local Functions = {}
local SpeedValue = 100 -- Velocidad inicial

-- // CREACIÓN DE LA INTERFAZ

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SpeedHubUI"
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ==================================================
--  MARCO PRINCIPAL
-- ==================================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
MainFrame.BorderColor3 = Color3.new(0.5, 0, 0.8)
MainFrame.BorderSizePixel = 2
MainFrame.Size = UDim2.new(0, 680, 0, 520)
MainFrame.Position = UDim2.new(0.5, -340, 0.5, -260)
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- ==================================================
--  EFECTO LED ANIMADO
-- ==================================================
local LEDFrame = Instance.new("Frame")
LEDFrame.Name = "LEDFrame"
LEDFrame.Parent = MainFrame
LEDFrame.BackgroundTransparency = 1
LEDFrame.Size = UDim2.new(1, 12, 1, 12)
LEDFrame.Position = UDim2.new(0, -6, 0, -6)
LEDFrame.ZIndex = -1

local LEDGradient = Instance.new("UIGradient")
LEDGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.new(0.9, 0, 1)),
    ColorSequenceKeypoint.new(0.5, Color3.new(0.3, 0, 0.6)),
    ColorSequenceKeypoint.new(1, Color3.new(0.9, 0, 1))
})
LEDGradient.Rotation = 90
LEDGradient.Parent = LEDFrame

-- Animación LED
spawn(function()
    while wait(2.5) do
        local tween = TweenService:Create(LEDGradient, TweenInfo.new(2.5, Enum.EasingStyle.Linear), {Rotation = 450})
        tween:Play()
        tween.Completed:Wait()
        LEDGradient.Rotation = 90
    end
end)

-- ==================================================
--  TÍTULO
-- ==================================================
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, -20, 0, 50)
Title.Position = UDim2.new(0, 10, 0, 10)
Title.Font = Enum.Font.GothamBold
Title.Text = "+1 Speed-Keyboard-Escape-Candy-Chocolate"
Title.TextColor3 = Color3.new(1, 0.5, 1)
Title.TextSize = 20
Title.TextWrapped = true

-- ==================================================
--  SEPARADOR
-- ==================================================
local Separator = Instance.new("Frame")
Separator.Name = "Separator"
Separator.Parent = MainFrame
Separator.Size = UDim2.new(1, -40, 0, 2)
Separator.Position = UDim2.new(0, 20, 0, 70)
Separator.BackgroundColor3 = Color3.new(0.6, 0, 1)

-- ==================================================
--  BOTÓN MAESTRO (ON/OFF)
-- ==================================================
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = MainFrame
ToggleButton.BackgroundColor3 = Color3.new(0.8, 0, 1)
ToggleButton.Size = UDim2.new(0, 280, 0, 50)
ToggleButton.Position = UDim2.new(0.5, -140, 0, 90)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "✅ SCRIPT ACTIVO"
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.TextSize = 18

local ButtonCornerMain = Instance.new("UICorner")
ButtonCornerMain.CornerRadius = UDim.new(0, 8)
ButtonCornerMain.Parent = ToggleButton

-- ==================================================
--  ÁREA DE OPCIONES
-- ==================================================
local OptionsFrame = Instance.new("Frame")
OptionsFrame.Name = "OptionsFrame"
OptionsFrame.Parent = MainFrame
OptionsFrame.BackgroundTransparency = 1
OptionsFrame.Size = UDim2.new(1, -40, 0, 340)
OptionsFrame.Position = UDim2.new(0, 20, 0, 155)

-- ==================================================
--  📄 SECCIÓN 1: INFO
-- ==================================================
local SectionInfo = Instance.new("TextLabel")
SectionInfo.Parent = OptionsFrame
SectionInfo.BackgroundTransparency = 1
SectionInfo.Size = UDim2.new(1, 0, 0, 70)
SectionInfo.Position = UDim2.new(0, 0, 0, 0)
SectionInfo.Font = Enum.Font.GothamBold
SectionInfo.Text = "📄 INFO\nCreador: JoseAngel_Blox | Lanzamiento: 23/06/2026"
SectionInfo.TextColor3 = Color3.new(1, 0.7, 1)
SectionInfo.TextSize = 14

-- ==================================================
--  ⚙️ SECCIÓN 2: MAIN
-- ==================================================
local SectionMainTitle = Instance.new("TextLabel")
SectionMainTitle.Parent = OptionsFrame
SectionMainTitle.BackgroundTransparency = 1
SectionMainTitle.Size = UDim2.new(1, 0, 0, 25)
SectionMainTitle.Position = UDim2.new(0, 0, 0, 75)
SectionMainTitle.Font = Enum.Font.GothamBold
SectionMainTitle.Text = "⚙️ MAIN"
SectionMainTitle.TextColor3 = Color3.new(1, 0.5, 1)
SectionMainTitle.TextSize = 16

-- Botón Auto Farm
local AutoFarmBtn = Instance.new("TextButton")
AutoFarmBtn.Name = "AutoFarmBtn"
AutoFarmBtn.Parent = OptionsFrame
AutoFarmBtn.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
AutoFarmBtn.Size = UDim2.new(0.48, 0, 0, 50)
AutoFarmBtn.Position = UDim2.new(0.01, 0, 0, 105)
AutoFarmBtn.Font = Enum.Font.GothamBold
AutoFarmBtn.Text = "❌ AUTO FARM"
AutoFarmBtn.TextColor3 = Color3.new(1, 1, 1)
AutoFarmBtn.TextSize = 15
local cf1 = Instance.new("UICorner"); cf1.CornerRadius = UDim.new(0,6); cf1.Parent=AutoFarmBtn

-- Texto de Velocidad
local SpeedText = Instance.new("TextLabel")
SpeedText.Parent = OptionsFrame
SpeedText.BackgroundTransparency = 1
SpeedText.Size = UDim2.new(0.48, 0, 0, 25)
SpeedText.Position = UDim2.new(0.51, 0, 0, 105)
SpeedText.Font = Enum.Font.GothamBold
SpeedText.Text = "VELOCIDAD: "..SpeedValue
SpeedText.TextColor3 = Color3.new(1, 0.8, 1)
SpeedText.TextSize = 14

-- Botón Aumentar Velocidad
local SpeedUpBtn = Instance.new("TextButton")
SpeedUpBtn.Name = "SpeedUpBtn"
SpeedUpBtn.Parent = OptionsFrame
SpeedUpBtn.BackgroundColor3 = Color3.new(0.2, 0, 0.3)
SpeedUpBtn.Size = UDim2.new(0.23, 0, 0, 22)
SpeedUpBtn.Position = UDim2.new(0.51, 0, 0, 132)
SpeedUpBtn.Font = Enum.Font.GothamBold
SpeedUpBtn.Text = "+"
SpeedUpBtn.TextColor3 = Color3.new(1,1,1)
SpeedUpBtn.TextSize = 14
local cf2 = Instance.new("UICorner"); cf2.CornerRadius = UDim.new(0,4); cf2.Parent=SpeedUpBtn

-- Botón Bajar Velocidad
local SpeedDownBtn = Instance.new("TextButton")
SpeedDownBtn.Name = "SpeedDownBtn"
SpeedDownBtn.Parent = OptionsFrame
SpeedDownBtn.BackgroundColor3 = Color3.new(0.2, 0, 0.3)
SpeedDownBtn.Size = UDim2.new(0.23, 0, 0, 22)
SpeedDownBtn.Position = UDim2.new(0.75, 0, 0, 132)
SpeedDownBtn.Font = Enum.Font.GothamBold
SpeedDownBtn.Text = "-"
SpeedDownBtn.TextColor3 = Color3.new(1,1,1)
SpeedDownBtn.TextSize = 14
local cf3 = Instance.new("UICorner"); cf3.CornerRadius = UDim.new(0,4); cf3.Parent=SpeedDownBtn

-- ==================================================
--  🛒 SECCIÓN 3: FREE SHOP ITEMS
-- ==================================================
local SectionShopTitle = Instance.new("TextLabel")
SectionShopTitle.Parent = OptionsFrame
SectionShopTitle.BackgroundTransparency = 1
SectionShopTitle.Size = UDim2.new(1, 0, 0, 25)
SectionShopTitle.Position = UDim2.new(0, 0, 0, 165)
SectionShopTitle.Font = Enum.Font.GothamBold
SectionShopTitle.Text = "🛒 FREE SHOP ITEMS"
SectionShopTitle.TextColor3 = Color3.new(1, 0.5, 1)
SectionShopTitle.TextSize = 16

-- Botón Caminadoras
local TreadmillsBtn = Instance.new("TextButton")
TreadmillsBtn.Name = "TreadmillsBtn"
TreadmillsBtn.Parent = OptionsFrame
TreadmillsBtn.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
TreadmillsBtn.Size = UDim2.new(0.32, 0, 0, 50)
TreadmillsBtn.Position = UDim2.new(0.01, 0, 0, 195)
TreadmillsBtn.Font = Enum.Font.GothamBold
TreadmillsBtn.Text = "✅ CAMINADORAS"
TreadmillsBtn.TextColor3 = Color3.new(1, 1, 1)
TreadmillsBtn.TextSize = 14
local cf4 = Instance.new("UICorner"); cf4.CornerRadius = UDim.new(0,6); cf4.Parent=TreadmillsBtn

-- Botón Auras
local AurasBtn = Instance.new("TextButton")
AurasBtn.Name = "AurasBtn"
AurasBtn.Parent = OptionsFrame
AurasBtn.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
AurasBtn.Size = UDim2.new(0.32, 0, 0, 50)
AurasBtn.Position = UDim2.new(0.34, 0, 0, 195)
AurasBtn.Font = Enum.Font.GothamBold
AurasBtn.Text = "✅ AURAS"
AurasBtn.TextColor3 = Color3.new(1, 1, 1)
AurasBtn.TextSize = 14
local cf5 = Instance.new("UICorner"); cf5.CornerRadius = UDim.new(0,6); cf5.Parent=AurasBtn

-- Botón Rastros
local TrailsBtn = Instance.new("TextButton")
TrailsBtn.Name = "TrailsBtn"
TrailsBtn.Parent = OptionsFrame
TrailsBtn.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
TrailsBtn.Size = UDim2.new(0.32, 0, 0, 50)
TrailsBtn.Position = UDim2.new(0.67, 0, 0, 195)
TrailsBtn.Font = Enum.Font.GothamBold
TrailsBtn.Text = "✅ RASTROS"
TrailsBtn.TextColor3 = Color3.new(1, 1, 1)
TrailsBtn.TextSize = 14
local cf6 = Instance.new("UICorner"); cf6.CornerRadius = UDim.new(0,6); cf6.Parent=TrailsBtn

-- ==================================================
--  LÓGICA DE FUNCIONES
-- ==================================================

-- Auto Farm Toggle
local AutoFarmEnabled = false
AutoFarmBtn.MouseButton1Click:Connect(function()
    AutoFarmEnabled = not AutoFarmEnabled
    if AutoFarmEnabled then
        AutoFarmBtn.Text = "✅ AUTO FARM"
        AutoFarmBtn.BackgroundColor3 = Color3.new(0.2, 0.6, 0.2)
    else
        AutoFarmBtn.Text = "❌ AUTO FARM"
        AutoFarmBtn.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    end
end)

-- Control de Velocidad
SpeedUpBtn.MouseButton1Click:Connect(function()
    SpeedValue = SpeedValue + 10
    SpeedText.Text = "VELOCIDAD: "..SpeedValue
end)

SpeedDownBtn.MouseButton1Click:Connect(function()
    SpeedValue = SpeedValue - 10
    if SpeedValue < 10 then SpeedValue = 10 end
    SpeedText.Text = "VELOCIDAD: "..SpeedValue
end)

-- Aplicar velocidad en tiempo real
RunService.Heartbeat:Connect(function()
    if ScriptEnabled then
        local char = Players.LocalPlayer.Character
        if char and char.Humanoid then
            char.Humanoid.WalkSpeed = SpeedValue
        end
    end
end)

-- Free Shop Items (Simulación de desbloqueo)
TreadmillsBtn.MouseButton1Click:Connect(function()
    TreadmillsBtn.Text = "✅ DESBLOQUEADO"
    TreadmillsBtn.BackgroundColor3 = Color3.new(0,0.5,0)
    wait(1)
    TreadmillsBtn.Text = "✅ CAMINADORAS"
end)

AurasBtn.MouseButton1Click:Connect(function()
    AurasBtn.Text = "✅ DESBLOQUEADO"
    AurasBtn.BackgroundColor3 = Color3.new(0,0.5,0)
    wait(1)
    AurasBtn.Text = "✅ AURAS"
end)

TrailsBtn.MouseButton1Click:Connect(function()
    TrailsBtn.Text = "✅ DESBLOQUEADO"
    TrailsBtn.BackgroundColor3 = Color3.new(0,0.5,0)
    wait(1)
    TrailsBtn.Text = "✅ RASTROS"
end)

-- Botón Maestro ON/OFF
ToggleButton.MouseButton1Click:Connect(function()
    ScriptEnabled = not ScriptEnabled
    if ScriptEnabled then
        ToggleButton.BackgroundColor3 = Color3.new(0.8, 0, 1)
        ToggleButton.Text = "✅ SCRIPT ACTIVO"
    else
        ToggleButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        ToggleButton.Text = "❌ SCRIPT DESACTIVADO"
        -- Reset velocidad
        local char = Players.LocalPlayer.Character
        if char and char.Humanoid then
            char.Humanoid.WalkSpeed = 16
        end
    end
end)

print("✅ Script Cargado - JoseAngel_Blox")
