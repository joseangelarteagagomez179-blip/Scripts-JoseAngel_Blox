--[[
🏰 Mansion Tycoon v2.1 🏰
Creador: JoseAngel_Blox
Fecha: 30/06/2026
]]

-- Servicios
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HRP = Character:WaitForChild("HumanoidRootPart")
local Head = Character:WaitForChild("Head")

-- =============================================
-- ⚡ ANIMACIÓN DE CARGA ÉPICA
-- =============================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MenuPrincipal"
ScreenGui.Parent = game.CoreGui

-- Pantalla de Carga
local LoadFrame = Instance.new("Frame")
LoadFrame.Name = "LoadFrame"
LoadFrame.Size = UDim2.new(0, 400, 0, 200)
LoadFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
LoadFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
LoadFrame.BorderSizePixel = 0
LoadFrame.Active = true
LoadFrame.ClipsDescendants = true

local LoadCorner = Instance.new("UICorner")
LoadCorner.CornerRadius = UDim.new(0, 20)
LoadCorner.Parent = LoadFrame

-- Título Bienvenida
local WelcomeText = Instance.new("TextLabel")
WelcomeText.Name = "WelcomeText"
WelcomeText.Size = UDim2.new(1, -40, 0, 50)
WelcomeText.Position = UDim2.new(0, 20, 0, 30)
WelcomeText.BackgroundTransparency = 1
WelcomeText.Text = "Bienvenidos a Scripts JoseAngel_Blox"
WelcomeText.TextColor3 = Color3.fromRGB(255, 255, 255)
WelcomeText.Font = Enum.Font.GothamBold
WelcomeText.TextSize = 18
WelcomeText.Parent = LoadFrame

-- Barra de Carga Fondo
local LoadingBarBackground = Instance.new("Frame")
LoadingBarBackground.Name = "LoadingBarBackground"
LoadingBarBackground.Size = UDim2.new(0, 300, 0, 20)
LoadingBarBackground.Position = UDim2.new(0.5, -150, 0, 110)
LoadingBarBackground.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
LoadingBarBackground.BorderSizePixel = 0
LoadingBarBackground.Parent = LoadFrame

local BarCorner = Instance.new("UICorner")
BarCorner.CornerRadius = UDim.new(0, 10)
BarCorner.Parent = LoadingBarBackground

-- Barra de Carga Animada
local LoadingBar = Instance.new("Frame")
LoadingBar.Name = "LoadingBar"
LoadingBar.Size = UDim2.new(0, 0, 0, 20)
LoadingBar.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
LoadingBar.BorderSizePixel = 0
LoadingBar.Parent = LoadingBarBackground

local LoadingBarCorner = Instance.new("UICorner")
LoadingBarCorner.CornerRadius = UDim.new(0, 10)
LoadingBarCorner.Parent = LoadingBar

-- Texto Porcentaje
local PercentText = Instance.new("TextLabel")
PercentText.Name = "PercentText"
PercentText.Size = UDim2.new(1, 0, 0, 20)
PercentText.Position = UDim2.new(0, 0, 0, 135)
PercentText.BackgroundTransparency = 1
PercentText.Text = "Cargando... 0%"
PercentText.TextColor3 = Color3.fromRGB(200, 200, 200)
PercentText.Font = Enum.Font.Gotham
PercentText.TextSize = 12
PercentText.Parent = LoadFrame

-- Animación de la Barra
local TweenInfoLoad = TweenInfo.new(2.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local Goal = {Size = UDim2.new(0, 300, 0, 20)}
local LoadTween = TweenService:Create(LoadingBar, TweenInfoLoad, Goal)

LoadTween:Play()

-- Simular progreso
spawn(function()
    for i = 0, 100 do
        PercentText.Text = "Cargando... "..i.."%"
        wait(0.02)
    end
    wait(0.3)
    -- Efecto de desvanecimiento
    local FadeOut = TweenService:Create(LoadFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1})
    WelcomeText.TextTransparency = 1
    PercentText.TextTransparency = 1
    LoadingBarBackground.BackgroundTransparency = 1
    LoadingBar.BackgroundTransparency = 1
    FadeOut:Play()
    wait(0.5)
    LoadFrame:Destroy()
    MainFrame.Visible = true
end)

-- =============================================
-- 🎨 MENU PRINCIPAL PROFESIONAL
-- =============================================

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 420)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false -- Oculto hasta que cargue

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 2
MainStroke.Color = Color3.fromRGB(80, 150, 255)
MainStroke.Parent = MainFrame

-- Título
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
Title.BorderSizePixel = 0
Title.Text = "🏰 Mansion Tycoon v2.1 🏰"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 17

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 15)
TitleCorner.Parent = Title

-- Info
local InfoLabel = Instance.new("TextLabel")
InfoLabel.Name = "InfoLabel"
InfoLabel.Size = UDim2.new(1, -20, 0, 25)
InfoLabel.Position = UDim2.new(0, 10, 0, 50)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Text = "By: JoseAngel_Blox | 30/06/2026"
InfoLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.TextSize = 12

-- Botón Flecha
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(1, -20, 0, 30)
ToggleButton.Position = UDim2.new(0, 10, 0, 80)
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
ToggleButton.Text = "▼ FUNCIONES ▼"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 14

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 8)
ToggleCorner.Parent = ToggleButton

-- Contenedor
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -20, 0, 270)
ContentFrame.Position = UDim2.new(0, 10, 0, 115)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Visible = false

-- =============================================
-- 🎚️ SISTEMA DE INTERRUPTORES (TOGGLES)
-- =============================================

local function CreateToggle(Name, Position, Callback)
    -- Contenedor del Toggle
    local ToggleContainer = Instance.new("Frame")
    ToggleContainer.Name = Name.."Container"
    ToggleContainer.Size = UDim2.new(1, 0, 0, 40)
    ToggleContainer.Position = Position
    ToggleContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    ToggleContainer.BorderSizePixel = 0
    ToggleContainer.Parent = ContentFrame

    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 8)
    ToggleCorner.Parent = ToggleContainer

    -- Nombre
    local ToggleName = Instance.new("TextLabel")
    ToggleName.Name = "ToggleName"
    ToggleName.Size = UDim2.new(0.7, 0, 1, 0)
    ToggleName.Position = UDim2.new(0, 15, 0, 0)
    ToggleName.BackgroundTransparency = 1
    ToggleName.Text = Name
    ToggleName.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleName.Font = Enum.Font.Gotham
    ToggleName.TextSize = 13
    ToggleName.Parent = ToggleContainer

    -- Caja del Interruptor
    local SwitchBox = Instance.new("Frame")
    SwitchBox.Name = "SwitchBox"
    SwitchBox.Size = UDim2.new(0, 40, 0, 20)
    SwitchBox.Position = UDim2.new(0.85, 0, 0.5, -10)
    SwitchBox.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    SwitchBox.BorderSizePixel = 0
    SwitchBox.Parent = ToggleContainer

    local SwitchCorner = Instance.new("UICorner")
    SwitchCorner.CornerRadius = UDim.new(1, 0)
    SwitchCorner.Parent = SwitchBox

    -- Bola del Interruptor
    local SwitchButton = Instance.new("TextButton")
    SwitchButton.Name = "SwitchButton"
    SwitchButton.Size = UDim2.new(0, 16, 0, 16)
    SwitchButton.Position = UDim2.new(0, 2, 0, 2)
    SwitchButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SwitchButton.BorderSizePixel = 0
    SwitchButton.Text = ""
    SwitchButton.Parent = SwitchBox

    local SwitchBtnCorner = Instance.new("UICorner")
    SwitchBtnCorner.CornerRadius = UDim.new(1, 0)
    SwitchBtnCorner.Parent = SwitchButton

    -- Estado
    local Enabled = false

    -- Función Click
    local function Toggle()
        Enabled = not Enabled
        if Enabled then
            TweenService:Create(SwitchBox, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 200, 120)}):Play()
            TweenService:Create(SwitchButton, TweenInfo.new(0.2), {Position = UDim2.new(0, 22, 0, 2)}):Play()
            Callback(true)
        else
            TweenService:Create(SwitchBox, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 80)}):Play()
            TweenService:Create(SwitchButton, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0, 2)}):Play()
            Callback(false)
        end
    end

    SwitchButton.MouseButton1Click:Connect(Toggle)
    SwitchBox.MouseButton1Click:Connect(Toggle)
end

-- =============================================
-- ⚙️ FUNCIONES
-- =============================================

-- Encontrar Mansión
local TycoonLocation = nil
for _, Tycoon in pairs(Workspace.Tycoons:GetChildren()) do
    if Tycoon:FindFirstChild("Mansion") then
        local Mansion = Tycoon.Mansion
        local CollectorGui = Mansion.Collectors and Mansion.Collectors.Collector and Mansion.Collectors.Collector.CollectorGui
        if CollectorGui then
            local TitleText = CollectorGui.MainFrame.Title.Text
            if TitleText:sub(-10) == "'s Mansion" then
                local TycoonName = TitleText:sub(1, -11)
                if TycoonName == Player.Name then
                    TycoonLocation = Tycoon
                    break
                end
            end
        end
    end
end

-- Variables de control
local AC_On = false
local AB_On = false
local NC_On = false

-- Auto Collect
CreateToggle("💰 Auto Collect Cash", UDim2.new(0,0,0,0), function(state)
    AC_On = state
    if state then
        spawn(function()
            while AC_On do
                if TycoonLocation then
                    for _, v in pairs(TycoonLocation.Mansion.Collectors:GetDescendants()) do
                        if v.Name == "TouchInterest" then
                            firetouchinterest(Head, v.Parent, 0)
                            wait(0.1)
                            firetouchinterest(Head, v.Parent, 1)
                        end
                    end
                end
                wait(1)
            end
        end)
    end
end)

-- Auto Buy
CreateToggle("🛒 Auto Comprar / Mejorar", UDim2.new(0,0,0,45), function(state)
    AB_On = state
    if state then
        spawn(function()
            while AB_On do
                if TycoonLocation then
                    for _, v in pairs(TycoonLocation.Mansion.Buttons:GetDescendants()) do
                        if v.ClassName == "Part" and v.Name == "Touch" then
                            HRP.CFrame = CFrame.new(v.Position)
                            wait(1)
                        end
                    end
                end
                wait(1)
            end
        end)
    end
end)

-- NoClip
CreateToggle("👻 NoClip", UDim2.new(0,0,0,90), function(state)
    NC_On = state
    if state then
        spawn(function()
            while NC_On do
                for _, v in pairs(Character:GetDescendants()) do
                    if v:IsA("BasePart") then v.CanCollide = false end
                end
                wait(0.1)
            end
        end)
    end
end)

-- Velocidad Max
CreateToggle("⚡ Velocidad y Salto Max", UDim2.new(0,0,0,135), function(state)
    if state then
        Humanoid.WalkSpeed = 350
        Humanoid.JumpPower = 350
    else
        Humanoid.WalkSpeed = 16
        Humanoid.JumpPower = 50
    end
end)

-- Anti AFK
CreateToggle("🛡️ Anti AFK", UDim2.new(0,0,0,180), function(state)
    if state then
        Player.Idled:Connect(function()
            VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            wait(1)
            VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
    end
end)

-- B-Tools
CreateToggle("🧰 Herramientas B-Tools", UDim2.new(0,0,0,225), function(state)
    if state then
        local backpack = Player.Backpack
        local h = Instance.new("HopperBin") h.Name="Hammer" h.BinType=4 h.Parent=backpack
        local c = Instance.new("HopperBin") c.Name="Clone" c.BinType=3 c.Parent=backpack
        local g = Instance.new("HopperBin") g.Name="Grab" g.BinType=2 g.Parent=backpack
    end
end)

-- =============================================
-- 📥 ABRIR / CERRAR MENU
-- =============================================

local Open = false
ToggleButton.MouseButton1Click:Connect(function()
    Open = not Open
    if Open then
        ContentFrame.Visible = true
        ToggleButton.Text = "▲ FUNCIONES ▲"
        MainFrame:TweenSize(UDim2.new(0, 320, 0, 420), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
    else
        ContentFrame.Visible = false
        ToggleButton.Text = "▼ FUNCIONES ▼"
        MainFrame:TweenSize(UDim2.new(0, 320, 0, 125), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
    end
end)

-- =============================================
-- ✅ FINALIZAR
-- =============================================

InfoLabel.Parent = MainFrame
ToggleButton.Parent = MainFrame
ContentFrame.Parent = MainFrame
Title.Parent = MainFrame
MainFrame.Parent = ScreenGui

print("✅ Script Cargado - JoseAngel_Blox")
