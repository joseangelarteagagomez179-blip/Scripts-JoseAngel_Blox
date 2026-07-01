--[[
    Mansion Tycoon v1.2 - CON ANIMACIÓN DE CARGA
    Creador: JoseAngel_Blox
    Fecha: 30/06/2026
]]

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- ==================== VARIABLES DE ESTADO ====================
local State = {
    AutoCollect = true,
    AutoBuy = false,
    InfiniteMoney = false,
    AutoBuild = false,
    Minimized = false,
    MoneyPerSecond = 1,
    TotalMoney = 8863,
    Loaded = false
}

-- ==================== CREAR GUI PRINCIPAL ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MansionTycoon_v1.2"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- ============================================
-- ========== PANTALLA DE CARGA ==============
-- ============================================
local LoadingFrame = Instance.new("Frame")
LoadingFrame.Size = UDim2.new(1, 0, 1, 0)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
LoadingFrame.BackgroundTransparency = 0
LoadingFrame.Parent = ScreenGui

-- Fondo con gradiente (efecto bonito)
local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 10, 30)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(20, 15, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 30))
})
Gradient.Rotation = 45
Gradient.Parent = LoadingFrame

-- Título de carga
local LoadingTitle = Instance.new("TextLabel")
LoadingTitle.Size = UDim2.new(0.8, 0, 0, 80)
LoadingTitle.Position = UDim2.new(0.1, 0, 0.2, 0)
LoadingTitle.BackgroundTransparency = 1
LoadingTitle.Text = "🏰 MANSION TYCOON"
LoadingTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
LoadingTitle.TextScaled = true
LoadingTitle.Font = Enum.Font.GothamBold
LoadingTitle.Parent = LoadingFrame

-- Subtítulo
local LoadingSub = Instance.new("TextLabel")
LoadingSub.Size = UDim2.new(0.6, 0, 0, 40)
LoadingSub.Position = UDim2.new(0.2, 0, 0.35, 0)
LoadingSub.BackgroundTransparency = 1
LoadingSub.Text = "Cargando..."
LoadingSub.TextColor3 = Color3.fromRGB(200, 200, 255)
LoadingSub.TextScaled = true
LoadingSub.Font = Enum.Font.Gotham
LoadingSub.Parent = LoadingFrame

-- Barra de progreso (fondo)
local ProgressBg = Instance.new("Frame")
ProgressBg.Size = UDim2.new(0.6, 0, 0, 20)
ProgressBg.Position = UDim2.new(0.2, 0, 0.5, 0)
ProgressBg.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
ProgressBg.BorderSizePixel = 0
ProgressBg.Parent = LoadingFrame

local ProgressCorner = Instance.new("UICorner")
ProgressCorner.CornerRadius = UDim.new(0, 10)
ProgressCorner.Parent = ProgressBg

-- Barra de progreso (relleno)
local ProgressBar = Instance.new("Frame")
ProgressBar.Size = UDim2.new(0, 1, 1, 0)
ProgressBar.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
ProgressBar.BorderSizePixel = 0
ProgressBar.Parent = ProgressBg

local ProgressCorner2 = Instance.new("UICorner")
ProgressCorner2.CornerRadius = UDim.new(0, 10)
ProgressCorner2.Parent = ProgressBar

-- Efecto de brillo en la barra
local Glow = Instance.new("Frame")
Glow.Size = UDim2.new(0.3, 0, 1, 0)
Glow.Position = UDim2.new(0, 0, 0, 0)
Glow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Glow.BackgroundTransparency = 0.5
Glow.BorderSizePixel = 0
Glow.Parent = ProgressBar

local GlowCorner = Instance.new("UICorner")
GlowCorner.CornerRadius = UDim.new(0, 10)
GlowCorner.Parent = Glow

-- Texto de porcentaje
local ProgressText = Instance.new("TextLabel")
ProgressText.Size = UDim2.new(0.6, 0, 0, 30)
ProgressText.Position = UDim2.new(0.2, 0, 0.58, 0)
ProgressText.BackgroundTransparency = 1
ProgressText.Text = "0%"
ProgressText.TextColor3 = Color3.fromRGB(255, 255, 255)
ProgressText.TextScaled = true
ProgressText.Font = Enum.Font.GothamBold
ProgressText.Parent = LoadingFrame

-- Texto de créditos (abajo)
local Credits = Instance.new("TextLabel")
Credits.Size = UDim2.new(0.8, 0, 0, 30)
Credits.Position = UDim2.new(0.1, 0, 0.85, 0)
Credits.BackgroundTransparency = 1
Credits.Text = "by JoseAngel_Blox | 30/06/2026"
Credits.TextColor3 = Color3.fromRGB(150, 150, 200)
Credits.TextScaled = true
Credits.Font = Enum.Font.Gotham
Credits.Parent = LoadingFrame

-- ============================================
-- ========== MENÚ PRINCIPAL =================
-- ============================================
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 520, 0, 400)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false -- OCULTO AL INICIO
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(180, 180, 255)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

-- ==================== TÍTULO ====================
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
Title.Text = "🏰 Mansion Tycoon v1.2"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

-- Botón minimizar
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

-- ==================== INFO ====================
local InfoSection = Instance.new("Frame")
InfoSection.Size = UDim2.new(0.95, 0, 0, 70)
InfoSection.Position = UDim2.new(0.025, 0, 0.1, 0)
InfoSection.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
InfoSection.Parent = MainFrame

local InfoCorner = Instance.new("UICorner")
InfoCorner.CornerRadius = UDim.new(0, 10)
InfoCorner.Parent = InfoSection

local InfoTitle = Instance.new("TextLabel")
InfoTitle.Size = UDim2.new(1, 0, 0, 25)
InfoTitle.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
InfoTitle.Text = "📋 INFO"
InfoTitle.TextColor3 = Color3.fromRGB(200, 200, 255)
InfoTitle.TextScaled = true
InfoTitle.Font = Enum.Font.GothamBold
InfoTitle.Parent = InfoSection

local InfoCreator = Instance.new("TextLabel")
InfoCreator.Size = UDim2.new(0.9, 0, 0, 20)
InfoCreator.Position = UDim2.new(0.05, 0, 0.35, 0)
InfoCreator.BackgroundTransparency = 1
InfoCreator.Text = "👤 Creador: JoseAngel_Blox  |  📅 30/06/2026"
InfoCreator.TextColor3 = Color3.fromRGB(220, 220, 220)
InfoCreator.TextXAlignment = Enum.TextXAlignment.Left
InfoCreator.Parent = InfoSection

-- Contador de dinero
local MoneyDisplay = Instance.new("TextLabel")
MoneyDisplay.Size = UDim2.new(0.9, 0, 0, 25)
MoneyDisplay.Position = UDim2.new(0.05, 0, 0.65, 0)
MoneyDisplay.BackgroundTransparency = 1
MoneyDisplay.Text = "💰 $" .. State.TotalMoney .. " ($" .. State.MoneyPerSecond .. "/s)"
MoneyDisplay.TextColor3 = Color3.fromRGB(0, 255, 150)
MoneyDisplay.TextXAlignment = Enum.TextXAlignment.Left
MoneyDisplay.Font = Enum.Font.GothamBold
MoneyDisplay.Parent = InfoSection

-- ==================== MANUAL ====================
local ManualSection = Instance.new("Frame")
ManualSection.Size = UDim2.new(0.95, 0, 0, 120)
ManualSection.Position = UDim2.new(0.025, 0, 0.28, 0)
ManualSection.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
ManualSection.Parent = MainFrame

local ManualCorner = Instance.new("UICorner")
ManualCorner.CornerRadius = UDim.new(0, 10)
ManualCorner.Parent = ManualSection

local ManualTitle = Instance.new("TextLabel")
ManualTitle.Size = UDim2.new(1, 0, 0, 25)
ManualTitle.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
ManualTitle.Text = "📖 MANUAL"
ManualTitle.TextColor3 = Color3.fromRGB(200, 200, 255)
ManualTitle.TextScaled = true
ManualTitle.Font = Enum.Font.GothamBold
ManualTitle.Parent = ManualSection

local ManualText = Instance.new("TextLabel")
ManualText.Size = UDim2.new(0.9, 0, 0.7, 0)
ManualText.Position = UDim2.new(0.05, 0, 0.3, 0)
ManualText.BackgroundTransparency = 1
ManualText.Text = [[
✅ Auto Collect → Recoge monedas automáticamente
🛒 Auto Buy → Compra upgrades por sí solo
💰 Infinite Money → Dinero infinito (actívalo con cuidado)
🏗️ Auto Build → Construye automáticamente
]]
ManualText.TextColor3 = Color3.fromRGB(220, 220, 220)
ManualText.TextXAlignment = Enum.TextXAlignment.Left
ManualText.TextYAlignment = Enum.TextYAlignment.Top
ManualText.TextWrapped = true
ManualText.Font = Enum.Font.Gotham
ManualText.Parent = ManualSection

-- ==================== FUNCIONES ====================
local function CreateToggle(parent, text, defaultState, yPos)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0.9, 0, 0, 35)
    Frame.Position = UDim2.new(0.05, 0, yPos, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
    Frame.Parent = parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Frame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.6, 0, 1, 0)
    Label.Position = UDim2.new(0.05, 0, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.Gotham
    Label.Parent = Frame
    
    local Status = Instance.new("TextLabel")
    Status.Size = UDim2.new(0.25, 0, 1, 0)
    Status.Position = UDim2.new(0.7, 0, 0, 0)
    Status.BackgroundTransparency = 1
    Status.Text = defaultState and "✅ ON" or "❌ OFF"
    Status.TextColor3 = defaultState and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 80, 80)
    Status.TextScaled = true
    Status.Font = Enum.Font.GothamBold
    Status.Parent = Frame
    
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 60, 0, 25)
    ToggleBtn.Position = UDim2.new(0.75, 0, 0.5, -12.5)
    ToggleBtn.BackgroundColor3 = defaultState and Color3.fromRGB(0, 200, 80) or Color3.fromRGB(200, 50, 50)
    ToggleBtn.Text = defaultState and "ON" or "OFF"
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleBtn.TextScaled = true
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.Parent = Frame
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 6)
    ToggleCorner.Parent = ToggleBtn
    
    local state = defaultState
    
    ToggleBtn.MouseButton1Click:Connect(function()
        state = not state
        Status.Text = state and "✅ ON" or "❌ OFF"
        Status.TextColor3 = state and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 80, 80)
        ToggleBtn.BackgroundColor3 = state and Color3.fromRGB(0, 200, 80) or Color3.fromRGB(200, 50, 50)
        ToggleBtn.Text = state and "ON" or "OFF"
        
        if text:find("Collect") then State.AutoCollect = state
        elseif text:find("Buy") then State.AutoBuy = state
        elseif text:find("Money") then State.InfiniteMoney = state
        elseif text:find("Build") then State.AutoBuild = state
        end
        
        print("🔄 " .. text .. " → " .. (state and "ON" or "OFF"))
    end)
    
    return Frame
end

-- ==================== SECCIÓN PRINCIPAL ====================
local MainSection = Instance.new("Frame")
MainSection.Size = UDim2.new(0.95, 0, 0, 180)
MainSection.Position = UDim2.new(0.025, 0, 0.5, 0)
MainSection.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
MainSection.Parent = MainFrame

local MainCorner2 = Instance.new("UICorner")
MainCorner2.CornerRadius = UDim.new(0, 10)
MainCorner2.Parent = MainSection

local MainTitle = Instance.new("TextLabel")
MainTitle.Size = UDim2.new(1, 0, 0, 25)
MainTitle.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
MainTitle.Text = "⚙️ FUNCIONES"
MainTitle.TextColor3 = Color3.fromRGB(200, 200, 255)
MainTitle.TextScaled = true
MainTitle.Font = Enum.Font.GothamBold
MainTitle.Parent = MainSection

CreateToggle(MainSection, "🪙 Auto Collect", State.AutoCollect, 0.15)
CreateToggle(MainSection, "🛒 Auto Buy", State.AutoBuy, 0.35)
CreateToggle(MainSection, "💰 Infinite Money", State.InfiniteMoney, 0.55)
CreateToggle(MainSection, "🏗️ Auto Build", State.AutoBuild, 0.75)

-- ============================================
-- ========== ANIMACIÓN DE CARGA =============
-- ============================================
local function StartLoading()
    local duration = 3.0 -- 3 segundos de carga
    local steps = 100
    local stepTime = duration / steps
    
    -- Animación de la barra
    for i = 0, steps do
        local progress = i / steps
        local width = progress * 0.6
        ProgressBar.Size = UDim2.new(width, 0, 1, 0)
        ProgressText.Text = math.floor(progress * 100) .. "%"
        
        -- Mover el brillo
        Glow.Position = UDim2.new(progress - 0.1, 0, 0, 0)
        
        -- Cambiar color según progreso
        local color = Color3.fromRGB(
            0 + progress * 200,
            200 - progress * 100,
            255 - progress * 100
        )
        ProgressBar.BackgroundColor3 = color
        
        task.wait(stepTime)
    end
    
    -- Carga completa
    ProgressText.Text = "100%"
    ProgressBar.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    
    -- Animación de desvanecimiento de la pantalla de carga
    local fadeTween = TweenService:Create(LoadingFrame, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    })
    fadeTween:Play()
    
    task.wait(0.3)
    
    -- Mostrar menú principal con animación
    MainFrame.Visible = true
    MainFrame.BackgroundTransparency = 1
    MainFrame.Size = UDim2.new(0, 400, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    
    -- Animación de entrada del menú
    local menuTween = TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0,
        Size = UDim2.new(0, 520, 0, 400),
        Position = UDim2.new(0.5, -260, 0.5, -200)
    })
    menuTween:Play()
    
    task.wait(0.8)
    LoadingFrame:Destroy() -- Eliminar pantalla de carga
    State.Loaded = true
    print("✅ Carga completada - Menú mostrado")
end

-- ============================================
-- ========== LOOPS DE FUNCIONES =============
-- ============================================
-- Loop de dinero (solo cuando el menú está cargado)
task.spawn(function()
    while task.wait(1) do
        if State.Loaded then
            if State.InfiniteMoney then
                State.TotalMoney = State.TotalMoney + 1000
            else
                State.TotalMoney = State.TotalMoney + State.MoneyPerSecond
            end
            MoneyDisplay.Text = "💰 $" .. string.format("%.0f", State.TotalMoney) .. " ($" .. State.MoneyPerSecond .. "/s)"
        end
    end
end)

-- Auto Collect
task.spawn(function()
    while task.wait(0.5) do
        if State.Loaded and State.AutoCollect then
            -- Aquí va tu código de recoger monedas
            print("🪙 Auto Collect ON")
        end
    end
end)

-- Auto Buy
task.spawn(function()
    while task.wait(1) do
        if State.Loaded and State.AutoBuy then
            print("🛒 Auto Buy ON")
        end
    end
end)

-- Auto Build
task.spawn(function()
    while task.wait(2) do
        if State.Loaded and State.AutoBuild then
            print("🏗️ Auto Build ON")
        end
    end
end)

-- ============================================
-- ========== CONTROLES ======================
-- ============================================
-- Minimizar
ToggleButton.MouseButton1Click:Connect(function()
    if not State.Loaded then return end
    State.Minimized = not State.Minimized
    if State.Minimized then
        MainFrame:TweenSize(UDim2.new(0, 520, 0, 40), "Out", "Quad", 0.3, true)
        InfoSection.Visible = false
        ManualSection.Visible = false
        MainSection.Visible = false
        ToggleButton.Text = "+"
    else
        MainFrame:TweenSize(UDim2.new(0, 520, 0, 400), "Out", "Quad", 0.3, true)
        InfoSection.Visible = true
        ManualSection.Visible = true
        MainSection.Visible = true
        ToggleButton.Text = "−"
    end
end)

-- Arrastrar
local dragging, dragInput, dragStart, startPos

Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

Title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

RunService.RenderStepped:Connect(function()
    if dragging and dragInput and State.Loaded then
        local delta = dragInput.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- ============================================
-- ========== INICIAR CARGA ==================
-- ============================================
StartLoading()
print("🚀 Mansion Tycoon v1.2 - Iniciando carga...")
