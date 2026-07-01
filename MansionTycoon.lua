-- Mansion Tycoon v1.1 by JoseAngel_Blox
-- Creado el 30/06/2026

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MansionTycoon_v1.1"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 520, 0, 420) -- Ancho 520 px, bajo 420 px
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Esquinas redondeadas
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(180, 180, 255)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
Title.Text = "Mansion Tycoon v1.1"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

-- Animación de bienvenida
local WelcomeLabel = Instance.new("TextLabel")
WelcomeLabel.Size = UDim2.new(0.85, 0, 0, 50)
WelcomeLabel.Position = UDim2.new(0.075, 0, 0.1, 0)
WelcomeLabel.BackgroundTransparency = 1
WelcomeLabel.Text = "¡Bienvenidos a Scripts JoseAngel_Blox!"
WelcomeLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
WelcomeLabel.TextScaled = true
WelcomeLabel.Font = Enum.Font.GothamBold
WelcomeLabel.Parent = MainFrame

local WelcomeCorner = Instance.new("UICorner")
WelcomeCorner.CornerRadius = UDim.new(0, 10)
WelcomeCorner.Parent = WelcomeLabel

-- Barra de carga
local LoadingFrame = Instance.new("Frame")
LoadingFrame.Size = UDim2.new(0.85, 0, 0, 10)
LoadingFrame.Position = UDim2.new(0.075, 0, 0.25, 0)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
LoadingFrame.Parent = MainFrame

local LoadingCorner = Instance.new("UICorner")
LoadingCorner.CornerRadius = UDim.new(0, 5)
LoadingCorner.Parent = LoadingFrame

local LoadingBar = Instance.new("Frame")
LoadingBar.Size = UDim2.new(0, 0, 1, 0)
LoadingBar.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
LoadingBar.Parent = LoadingFrame

local LoadingBarCorner = Instance.new("UICorner")
LoadingBarCorner.CornerRadius = UDim.new(0, 5)
LoadingBarCorner.Parent = LoadingBar

-- Botón de minimizar/expandir
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 30, 0, 30)
ToggleButton.Position = UDim2.new(1, -35, 0, 5)
ToggleButton.BackgroundColor3 = Color3.fromRGB(180, 180, 255)
ToggleButton.Text = "−"
ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.TextScaled = true
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Parent = Title

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 6)
ToggleCorner.Parent = ToggleButton

-- Secciones del script (ordenadas)
local SectionY = 0.35

local function CreateSection(TitleText, YPos)
    local Section = Instance.new("Frame")
    Section.Size = UDim2.new(0.9, 0, 0, 80)
    Section.Position = UDim2.new(0.05, 0, YPos, 0)
    Section.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    Section.Parent = MainFrame
    
    local SecCorner = Instance.new("UICorner")
    SecCorner.CornerRadius = UDim.new(0, 10)
    SecCorner.Parent = Section
    
    local SecTitle = Instance.new("TextLabel")
    SecTitle.Size = UDim2.new(1, 0, 0, 25)
    SecTitle.BackgroundColor3 = Color3.fromRGB(55, 55, 75)
    SecTitle.Text = TitleText
    SecTitle.TextColor3 = Color3.fromRGB(200, 200, 255)
    SecTitle.TextScaled = true
    SecTitle.Font = Enum.Font.GothamBold
    SecTitle.Parent = Section
    
    local SecTitleCorner = Instance.new("UICorner")
    SecTitleCorner.CornerRadius = UDim.new(0, 10)
    SecTitleCorner.Parent = SecTitle
    
    return Section
end

-- ====================== SECCIÓN 1: INFO ======================
local InfoSection = CreateSection("📋 INFO DEL SCRIPT", SectionY)
SectionY += 0.12

local InfoCreator = Instance.new("TextLabel")
InfoCreator.Size = UDim2.new(0.95, 0, 0, 25)
InfoCreator.Position = UDim2.new(0.025, 0, 0, 30)
InfoCreator.BackgroundTransparency = 1
InfoCreator.Text = "Creador: JoseAngel_Blox"
InfoCreator.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoCreator.TextXAlignment = Enum.TextXAlignment.Left
InfoCreator.Parent = InfoSection

local InfoDate = Instance.new("TextLabel")
InfoDate.Size = UDim2.new(0.95, 0, 0, 25)
InfoDate.Position = UDim2.new(0.025, 0, 0, 55)
InfoDate.BackgroundTransparency = 1
InfoDate.Text = "Fecha de lanzamiento: 30/06/2026"
InfoDate.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoDate.TextXAlignment = Enum.TextXAlignment.Left
InfoDate.Parent = InfoSection

-- ====================== SECCIÓN 2: MANUAL ======================
local ManualSection = CreateSection("📖 MANUAL", SectionY)
SectionY += 0.12

local ManualText = Instance.new("TextLabel")
ManualText.Size = UDim2.new(0.95, 0, 0.65, 0)
ManualText.Position = UDim2.new(0.025, 0, 0, 30)
ManualText.BackgroundTransparency = 1
ManualText.Text = [[

¡BIENVENIDOS A SCRIPTS JOSEANGEL_BLOX!

Este script te ayuda a construir tu mansión más rápido y fácil en Mansion Tycoon.

Funciones principales:
• Auto Collect (monedas automáticas)
• Auto Buy (compra todo automáticamente)
• Infinite Money (dinero ilimitado)
• Auto Build (construye según tu orden)
• Highlight Affordable (resalta lo que puedes comprar)

¡Mantén el script abierto mientras juegas!

]]
ManualText.TextColor3 = Color3.fromRGB(220, 220, 220)
ManualText.TextXAlignment = Enum.TextXAlignment.Left
ManualText.TextYAlignment = Enum.TextYAlignment.Top
ManualText.TextWrapped = true
ManualText.Font = Enum.Font.Gotham
ManualText.Parent = ManualSection

-- ====================== SECCIÓN 3: FUNCIONES IMPORTANTES ======================
local FuncSection = CreateSection("⚙️ FUNCIONES IMPORTANTES", SectionY)
SectionY += 0.12

-- Crear interruptores
local function CreateToggle(Text, DefaultState, YPos)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(0.92, 0, 0, 35)
    ToggleFrame.Position = UDim2.new(0.04, 0, YPos, 0)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
    ToggleFrame.Parent = FuncSection
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 8)
    ToggleCorner.Parent = ToggleFrame
    
    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Size = UDim2.new(0.6, 0, 1, 0)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Text = Text
    ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.Parent = ToggleFrame
    
    local ToggleSwitch = Instance.new("TextButton")
    ToggleSwitch.Size = UDim2.new(0, 50, 0, 25)
    ToggleSwitch.Position = UDim2.new(0.82, 0, 0.5, -12.5)
    ToggleSwitch.BackgroundColor3 = DefaultState and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 80, 80)
    ToggleSwitch.Text = ""
    ToggleSwitch.Parent = ToggleFrame
    
    local SwitchCorner = Instance.new("UICorner")
    SwitchCorner.CornerRadius = UDim.new(1, 0)
    SwitchCorner.Parent = ToggleSwitch
    
    local IsActive = DefaultState
    ToggleSwitch.MouseButton1Click:Connect(function()
        IsActive = not IsActive
        ToggleSwitch.BackgroundColor3 = IsActive and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 80, 80)
    end)
    
    return IsActive
end

local AutoCollect = CreateToggle("Auto Collect (monedas)", true, 0)
local AutoBuy = CreateToggle("Auto Buy", false, 0.25)
local InfiniteMoney = CreateToggle("Infinite Money", false, 0.5)
local AutoBuild = CreateToggle("Auto Build", false, 0.75)

-- ====================== SECCIÓN 4: BOTÓN PARA MINIMIZAR ======================
ToggleButton.MouseButton1Click:Connect(function()
    if MainFrame.Size == UDim2.new(0, 520, 0, 420) then
        MainFrame:TweenSize(UDim2.new(0, 520, 0, 80), "Out", "Quad", 0.4, true)
        WelcomeLabel.Visible = false
        LoadingFrame.Visible = false
        ManualText.Visible = false
        FuncSection.Visible = false
    else
        MainFrame:TweenSize(UDim2.new(0, 520, 0, 420), "Out", "Quad", 0.4, true)
        WelcomeLabel.Visible = true
        LoadingFrame.Visible = true
        ManualText.Visible = true
        FuncSection.Visible = true
    end
end)

-- ====================== BARRA DE CARGA (se llena sola) ======================
local function FillLoading()
    local tween = TweenService:Create(LoadingBar, TweenInfo.new(3, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 1, 0)})
    tween:Play()
    tween.Completed:Connect(function()
        LoadingBar.BackgroundColor3 = Color3.fromRGB(0, 255, 80)
    end)
end

-- ====================== FUNCIONES REALES (ejemplo) ======================
-- Aquí puedes añadir más código según necesites (Auto Collect, etc.)
-- Por ahora solo visual + interruptores

-- Animación de bienvenida + carga
WelcomeLabel.TextTransparency = 1
LoadingBar.Size = UDim2.new(0, 0, 1, 0)

WelcomeLabel:TweenPosition(UDim2.new(0.075, 0, 0.18, 0), "Out", "Quad", 1, true)
WelcomeLabel:TweenTextTransparency(0, TweenInfo.new(1), true)

task.delay(0.8, function()
    LoadingFrame:TweenPosition(UDim2.new(0.075, 0, 0.28, 0), "Out", "Quad", 0.8, true)
    FillLoading()
end)

task.wait(3.5)
WelcomeLabel:Destroy()
LoadingFrame:Destroy()

print("✅ Mansion Tycoon v1.1 cargado por JoseAngel_Blox")
