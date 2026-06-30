--[[
🏰 Mansion Tycoon v2.1 MEJORADO 🏰
Creador: JoseAngel_Blox
Fecha: 30/06/2026
Compatible con PC y CELULAR 📱💻
]]

-- Servicios
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")

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
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.Enabled = true -- ✅ Esto reemplaza a Modal

-- Pantalla de Carga
local LoadFrame = Instance.new("Frame")
LoadFrame.Name = "LoadFrame"
LoadFrame.Size = UDim2.new(0, 400, 0, 200)
LoadFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
LoadFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
LoadFrame.BorderSizePixel = 0
LoadFrame.Active = true
LoadFrame.ClipsDescendants = true
LoadFrame.Parent = ScreenGui -- ✅ IMPORTANTE: añadir al ScreenGui

local LoadCorner = Instance.new("UICorner")
LoadCorner.CornerRadius = UDim.new(0, 20)
LoadCorner.Parent = LoadFrame

-- Efecto de brillo en borde
local LoadStroke = Instance.new("UIStroke")
LoadStroke.Thickness = 2
LoadStroke.Color = Color3.fromRGB(80, 150, 255)
LoadStroke.Transparency = 0.5
LoadStroke.Parent = LoadFrame

-- Título Bienvenida
local WelcomeText = Instance.new("TextLabel")
WelcomeText.Name = "WelcomeText"
WelcomeText.Size = UDim2.new(1, -40, 0, 50)
WelcomeText.Position = UDim2.new(0, 20, 0, 30)
WelcomeText.BackgroundTransparency = 1
WelcomeText.Text = "🏰 Bienvenido a Mansion Tycoon"
WelcomeText.TextColor3 = Color3.fromRGB(255, 255, 255)
WelcomeText.Font = Enum.Font.GothamBold
WelcomeText.TextSize = 18
WelcomeText.Parent = LoadFrame

-- Subtítulo
local SubText = Instance.new("TextLabel")
SubText.Name = "SubText"
SubText.Size = UDim2.new(1, -40, 0, 20)
SubText.Position = UDim2.new(0, 20, 0, 70)
SubText.BackgroundTransparency = 1
SubText.Text = "By: JoseAngel_Blox"
SubText.TextColor3 = Color3.fromRGB(150, 150, 200)
SubText.Font = Enum.Font.Gotham
SubText.TextSize = 12
SubText.Parent = LoadFrame

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

-- =============================================
-- 🔄 ANIMACIÓN DE CARGA MEJORADA
-- =============================================

spawn(function()
    -- Barra de progreso
    for i = 0, 100 do
        local Progress = i / 100
        LoadingBar.Size = UDim2.new(Progress, 0, 0, 20)
        PercentText.Text = "Cargando... "..i.."%"
        
        -- Cambio de color según progreso
        if i < 30 then
            LoadingBar.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        elseif i < 60 then
            LoadingBar.BackgroundColor3 = Color3.fromRGB(255, 200, 100)
        elseif i < 85 then
            LoadingBar.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
        else
            LoadingBar.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
        end
        
        wait(0.015)
    end
    
    wait(0.5)
    
    -- Animación de desvanecimiento
    local FadeTween = TweenService:Create(LoadFrame, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, -200, 0.5, -150)
    })
    
    -- Desvanecer todos los hijos
    for _, child in pairs(LoadFrame:GetChildren()) do
        if child:IsA("TextLabel") or child:IsA("Frame") then
            TweenService:Create(child, TweenInfo.new(0.8), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
        end
    end
    
    FadeTween:Play()
    wait(0.8)
    LoadFrame:Destroy()
    MainFrame.Visible = true
    MainFrame:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.3, true)
    wait(0.1)
    MainFrame:TweenSize(UDim2.new(0, 360, 0, 550), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.4, true)
end)

-- =============================================
-- 🎨 MENU PRINCIPAL PROFESIONAL
-- =============================================

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 0, 0, 0) -- Empieza pequeño para animación
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -275)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui -- ✅ IMPORTANTE

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 2
MainStroke.Color = Color3.fromRGB(80, 150, 255)
MainStroke.Transparency = 0.8
MainStroke.Parent = MainFrame

-- Sombra
local Shadow = Instance.new("Frame")
Shadow.Name = "Shadow"
Shadow.Size = UDim2.new(1, 20, 1, 20)
Shadow.Position = UDim2.new(-0.03, -10, -0.03, -10)
Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Shadow.BackgroundTransparency = 0.7
Shadow.ZIndex = 0
Shadow.Parent = MainFrame

local ShadowCorner = Instance.new("UICorner")
ShadowCorner.CornerRadius = UDim.new(0, 20)
ShadowCorner.Parent = Shadow

-- Título
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 60)
Title.BorderSizePixel = 0
Title.Text = "🏰 Mansion Tycoon v2.1"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 15)
TitleCorner.Parent = Title

-- Info
local InfoLabel = Instance.new("TextLabel")
InfoLabel.Name = "InfoLabel"
InfoLabel.Size = UDim2.new(1, -20, 0, 20)
InfoLabel.Position = UDim2.new(0, 10, 0, 55)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Text = "By: JoseAngel_Blox | 30/06/2026"
InfoLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.TextSize = 11
InfoLabel.Parent = MainFrame

-- Botón Flecha
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(1, -20, 0, 35)
ToggleButton.Position = UDim2.new(0, 10, 0, 80)
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 90)
ToggleButton.Text = "▼ FUNCIONES ▼"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 15
ToggleButton.AutoButtonColor = false
ToggleButton.Parent = MainFrame

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 8)
ToggleCorner.Parent = ToggleButton

-- Hover efecto
ToggleButton.MouseEnter:Connect(function()
    TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 70, 120)}):Play()
end)
ToggleButton.MouseLeave:Connect(function()
    TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 90)}):Play()
end)

-- Contenedor
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -20, 0, 400)
ContentFrame.Position = UDim2.new(0, 10, 0, 120)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Visible = false
ContentFrame.Parent = MainFrame

-- Scroll si es necesario
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Name = "ScrollingFrame"
ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 380)
ScrollingFrame.ScrollBarThickness = 4
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 150, 255)
ScrollingFrame.Parent = ContentFrame

-- =============================================
-- 🎚️ SISTEMA DE INTERRUPTORES (TOGGLES) MEJORADO
-- =============================================

local function CreateToggle(Name, Position, Callback)
    local Container = Instance.new("Frame")
    Container.Name = Name.."Container"
    Container.Size = UDim2.new(1, 0, 0, 50)
    Container.Position = Position
    Container.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
    Container.BorderSizePixel = 0
    Container.BackgroundTransparency = 0.3
    Container.Parent = ScrollingFrame

    local ContainerCorner = Instance.new("UICorner")
    ContainerCorner.CornerRadius = UDim.new(0, 8)
    ContainerCorner.Parent = Container

    local ToggleName = Instance.new("TextLabel")
    ToggleName.Name = "ToggleName"
    ToggleName.Size = UDim2.new(0.6, -10, 1, 0)
    ToggleName.Position = UDim2.new(0, 15, 0, 0)
    ToggleName.BackgroundTransparency = 1
    ToggleName.Text = Name
    ToggleName.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleName.Font = Enum.Font.Gotham
    ToggleName.TextSize = 14
    ToggleName.TextXAlignment = Enum.TextXAlignment.Left
    ToggleName.Parent = Container

    local SwitchBox = Instance.new("TextButton")
    SwitchBox.Name = "SwitchBox"
    SwitchBox.Size = UDim2.new(0, 55, 0, 28)
    SwitchBox.Position = UDim2.new(0.85, 0, 0.5, -14)
    SwitchBox.BackgroundColor3 = Color3.fromRGB(60, 60, 85)
    SwitchBox.BorderSizePixel = 0
    SwitchBox.Text = ""
    SwitchBox.AutoButtonColor = false
    SwitchBox.Parent = Container

    local SwitchCorner = Instance.new("UICorner")
    SwitchCorner.CornerRadius = UDim.new(1, 0)
    SwitchCorner.Parent = SwitchBox

    local SwitchButton = Instance.new("TextButton")
    SwitchButton.Name = "SwitchButton"
    SwitchButton.Size = UDim2.new(0, 22, 0, 22)
    SwitchButton.Position = UDim2.new(0, 3, 0, 3)
    SwitchButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SwitchButton.BorderSizePixel = 0
    SwitchButton.Text = ""
    SwitchButton.AutoButtonColor = false
    SwitchButton.Parent = SwitchBox

    local SwitchBtnCorner = Instance.new("UICorner")
    SwitchBtnCorner.CornerRadius = UDim.new(1, 0)
    SwitchBtnCorner.Parent = SwitchButton

    local Enabled = false

    local function Toggle()
        Enabled = not Enabled
        if Enabled then
            TweenService:Create(SwitchBox, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(80, 200, 120)}):Play()
            TweenService:Create(SwitchButton, TweenInfo.new(0.25), {Position = UDim2.new(0, 30, 0, 3)}):Play()
            Callback(true)
        else
            TweenService:Create(SwitchBox, TweenInfo.new(0.25), {BackgroundColor3 = Color3.fromRGB(60, 60, 85)}):Play()
            TweenService:Create(SwitchButton, TweenInfo.new(0.25), {Position = UDim2.new(0, 3, 0, 3)}):Play()
            Callback(false)
        end
    end

    SwitchButton.MouseButton1Click:Connect(Toggle)
    SwitchBox.MouseButton1Click:Connect(Toggle)
    
    return Container
end

-- =============================================
-- ⚙️ ENCONTRAR MANSION
-- =============================================

local TycoonLocation = nil
local function FindTycoon()
    for _, Tycoon in pairs(Workspace:FindFirstChild("Tycoons") and Workspace.Tycoons:GetChildren() or {}) do
        if Tycoon:FindFirstChild("Mansion") then
            local Mansion = Tycoon.Mansion
            local Collectors = Mansion:FindFirstChild("Collectors")
            if Collectors then
                local Collector = Collectors:FindFirstChild("Collector")
                if Collector then
                    local CollectorGui = Collector:FindFirstChild("CollectorGui")
                    if CollectorGui then
                        local MainFrame = CollectorGui:FindFirstChild("MainFrame")
                        if MainFrame then
                            local Title = MainFrame:FindFirstChild("Title")
                            if Title and Title:IsA("TextLabel") then
                                local TitleText = Title.Text
                                if TitleText:sub(-10) == "'s Mansion" then
                                    local TycoonName = TitleText:sub(1, -11)
                                    if TycoonName == Player.Name then
                                        return Tycoon
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return nil
end

TycoonLocation = FindTycoon()

-- =============================================
-- ⚙️ FUNCIONES
-- =============================================

local AC_On = false
local AB_On = false
local NC_On = false

-- Auto Collect (MEJORADO)
CreateToggle("💰 Auto Collect Cash", UDim2.new(0,0,0,0), function(state)
    AC_On = state
    if state then
        spawn(function()
            while AC_On do
                TycoonLocation = FindTycoon() or TycoonLocation
                if TycoonLocation and TycoonLocation.Mansion and TycoonLocation.Mansion.Collectors then
                    for _, v in pairs(TycoonLocation.Mansion.Collectors:GetDescendants()) do
                        if v:IsA("BasePart") and v.Name == "TouchInterest" then
                            pcall(function()
                                firetouchinterest(Head, v.Parent, 0)
                                wait(0.1)
                                firetouchinterest(Head, v.Parent, 1)
                            end)
                        end
                    end
                end
                wait(0.5)
            end
        end)
    end
end)

-- Auto Buy (MEJORADO)
CreateToggle("🛒 Auto Comprar", UDim2.new(0,0,0,55), function(state)
    AB_On = state
    if state then
        spawn(function()
            while AB_On do
                TycoonLocation = FindTycoon() or TycoonLocation
                if TycoonLocation and TycoonLocation.Mansion and TycoonLocation.Mansion.Buttons then
                    for _, v in pairs(TycoonLocation.Mansion.Buttons:GetDescendants()) do
                        if v:IsA("BasePart") and v.Name == "Touch" then
                            pcall(function()
                                HRP.CFrame = CFrame.new(v.Position + Vector3.new(0, 3, 0))
                                wait(0.5)
                            end)
                        end
                    end
                end
                wait(1)
            end
        end)
    end
end)

-- NoClip (MEJORADO)
CreateToggle("👻 NoClip", UDim2.new(0,0,0,110), function(state)
    NC_On = state
    spawn(function()
        while NC_On do
            if Character then
                for _, v in pairs(Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
            wait(0.1)
        end
    end)
end)

-- Velocidad Max
CreateToggle("⚡ Velocidad Max", UDim2.new(0,0,0,165), function(state)
    if state then
        Humanoid.WalkSpeed = 100
        Humanoid.JumpPower = 100
    else
        Humanoid.WalkSpeed = 16
        Humanoid.JumpPower = 50
    end
end)

-- Anti AFK (MEJORADO)
CreateToggle("🛡️ Anti AFK", UDim2.new(0,0,0,220), function(state)
    if state then
        local connection
        connection = Player.Idled:Connect(function()
            pcall(function()
                VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                wait(0.1)
                VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            end)
        end)
        -- Guardar la conexión para desconectarla
        getgenv().AntiAFKConnection = connection
    else
        if getgenv().AntiAFKConnection then
            getgenv().AntiAFKConnection:Disconnect()
            getgenv().AntiAFKConnection = nil
        end
    end
end)

-- B-Tools
CreateToggle("🧰 B-Tools", UDim2.new(0,0,0,275), function(state)
    if state then
        pcall(function()
            local backpack = Player.Backpack
            local h = Instance.new("HopperBin")
            h.Name = "Hammer"
            h.BinType = Enum.BinType.Hammer
            h.Parent = backpack
            
            local c = Instance.new("HopperBin")
            c.Name = "Clone"
            c.BinType = Enum.BinType.Clone
            c.Parent = backpack
            
            local g = Instance.new("HopperBin")
            g.Name = "Grab"
            g.BinType = Enum.BinType.Grab
            g.Parent = backpack
        end)
    end
end)

-- =============================================
-- 📱 DETECTAR CELULAR Y AJUSTAR
-- =============================================

local isMobile = UserInputService.TouchEnabled

if isMobile then
    -- Ajustes para móvil
    Title.TextSize = 16
    ToggleButton.TextSize = 14
    MainFrame.Size = UDim2.new(0, 340, 0, 500)
    MainFrame.Position = UDim2.new(0.5, -170, 0.5, -250)
    
    -- Hacer toggles más grandes
    for _, container in pairs(ScrollingFrame:GetChildren()) do
        if container:IsA("Frame") then
            container.Size = UDim2.new(1, 0, 0, 55)
            local label = container:FindFirstChild("ToggleName")
            if label then label.TextSize = 16 end
        end
    end
end

-- =============================================
-- 📥 ABRIR / CERRAR MENU
-- =============================================

local Open = false
ToggleButton.MouseButton1Click:Connect(function()
    Open = not Open
    if Open then
        ContentFrame.Visible = true
        ToggleButton.Text = "▲ FUNCIONES ▲"
        MainFrame:TweenSize(UDim2.new(0, isMobile and 340 or 360, 0, isMobile and 500 or 550), 
            Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
    else
        ContentFrame.Visible = false
        ToggleButton.Text = "▼ FUNCIONES ▼"
        MainFrame:TweenSize(UDim2.new(0, isMobile and 340 or 360, 0, isMobile and 140 or 130), 
            Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
    end
end)

-- =============================================
-- 🧹 LIMPIAR AL SALIR
-- =============================================

Player.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = newChar:WaitForChild("Humanoid")
    HRP = newChar:WaitForChild("HumanoidRootPart")
    Head = newChar:WaitForChild("Head")
end)

-- =============================================
-- ✅ FINALIZAR
-- =======================
