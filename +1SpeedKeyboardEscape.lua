--// Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

--// Variables
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

--// Settings
local AutoFarmEnabled = false
local AutoFarmSpeed = 50
local WalkSpeedEnabled = false
local WalkSpeedValue = 50
local AllTreadmillsUnlocked = false
local AllTrailsUnlocked = false
local AllAurasUnlocked = false

--// UI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")

--// Sección Info
local InfoSection = Instance.new("TextButton")
local InfoContent = Instance.new("Frame")
local CreatorLabel = Instance.new("TextLabel")
local DateLabel = Instance.new("TextLabel")

--// Sección Main
local MainSection = Instance.new("TextButton")
local MainContent = Instance.new("Frame")

--// Auto Farm
local AutoFarmToggle = Instance.new("TextButton")
local AutoFarmSlider = Instance.new("TextBox")
local AutoFarmStatus = Instance.new("TextLabel")

--// Walk Speed
local WalkSpeedToggle = Instance.new("TextButton")
local WalkSpeedSlider = Instance.new("TextBox")
local WalkSpeedStatus = Instance.new("TextLabel")

--// === SECCIÓN FREE SHOP ===
local ShopSection = Instance.new("TextButton")
local ShopContent = Instance.new("Frame")

--// Treadmills
local TreadmillsToggle = Instance.new("TextButton")
local TreadmillsStatus = Instance.new("TextLabel")

--// Trails
local TrailsToggle = Instance.new("TextButton")
local TrailsStatus = Instance.new("TextLabel")

--// Auras
local AurasToggle = Instance.new("TextButton")
local AurasStatus = Instance.new("TextLabel")

--// Estilos
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")

--// Propiedades Generales
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 300, 0, 80)
MainFrame.ClipsDescendants = true

UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

UIStroke.Color = Color3.fromRGB(150, 0, 255)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "NOCTIS || HOOD CUSTOM"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Position = UDim2.new(0, 10, 0, 5)

--// === SECCIÓN INFO ===
InfoSection.Name = "InfoSection"
InfoSection.Parent = MainFrame
InfoSection.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
InfoSection.Size = UDim2.new(1, -20, 0, 30)
InfoSection.Position = UDim2.new(0, 10, 0, 45)
InfoSection.Font = Enum.Font.GothamSemibold
InfoSection.Text = "Info ↓"
InfoSection.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoSection.TextSize = 14
InfoSection.TextXAlignment = Enum.TextXAlignment.Left

local InfoCorner = Instance.new("UICorner")
InfoCorner.CornerRadius = UDim.new(0, 6)
InfoCorner.Parent = InfoSection

InfoContent.Name = "InfoContent"
InfoContent.Parent = MainFrame
InfoContent.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
InfoContent.Size = UDim2.new(1, -20, 0, 60)
InfoContent.Position = UDim2.new(0, 10, 0, 80)
InfoContent.Visible = false

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 6)
ContentCorner.Parent = InfoContent

CreatorLabel.Name = "CreatorLabel"
CreatorLabel.Parent = InfoContent
CreatorLabel.BackgroundTransparency = 1
CreatorLabel.Size = UDim2.new(1, -10, 0, 25)
CreatorLabel.Position = UDim2.new(0, 5, 0, 5)
CreatorLabel.Font = Enum.Font.Gotham
CreatorLabel.Text = "Nombre del Creador: JoseAngel_Blox"
CreatorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CreatorLabel.TextSize = 13
CreatorLabel.TextXAlignment = Enum.TextXAlignment.Left

DateLabel.Name = "DateLabel"
DateLabel.Parent = InfoContent
DateLabel.BackgroundTransparency = 1
DateLabel.Size = UDim2.new(1, -10, 0, 25)
DateLabel.Position = UDim2.new(0, 5, 0, 32)
DateLabel.Font = Enum.Font.Gotham
DateLabel.Text = "Fecha de Creación: 23/06/2026"
DateLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
DateLabel.TextSize = 13
DateLabel.TextXAlignment = Enum.TextXAlignment.Left

--// === SECCIÓN MAIN ===
MainSection.Name = "MainSection"
MainSection.Parent = MainFrame
MainSection.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
MainSection.Size = UDim2.new(1, -20, 0, 30)
MainSection.Position = UDim2.new(0, 10, 0, 110)
MainSection.Font = Enum.Font.GothamSemibold
MainSection.Text = "Main ↓"
MainSection.TextColor3 = Color3.fromRGB(255, 255, 255)
MainSection.TextSize = 14
MainSection.TextXAlignment = Enum.TextXAlignment.Left

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 6)
MainCorner.Parent = MainSection

MainContent.Name = "MainContent"
MainContent.Parent = MainFrame
MainContent.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
MainContent.Size = UDim2.new(1, -20, 0, 100)
MainContent.Position = UDim2.new(0, 10, 0, 145)
MainContent.Visible = false

local MainContentCorner = Instance.new("UICorner")
MainContentCorner.CornerRadius = UDim.new(0, 6)
MainContentCorner.Parent = MainContent

--// AUTO FARM
AutoFarmToggle.Name = "AutoFarmToggle"
AutoFarmToggle.Parent = MainContent
AutoFarmToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
AutoFarmToggle.Size = UDim2.new(1, -10, 0, 30)
AutoFarmToggle.Position = UDim2.new(0, 5, 0, 5)
AutoFarmToggle.Font = Enum.Font.GothamSemibold
AutoFarmToggle.Text = "Auto Farm"
AutoFarmToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoFarmToggle.TextSize = 14
AutoFarmToggle.TextXAlignment = Enum.TextXAlignment.Left

AutoFarmStatus.Name = "AutoFarmStatus"
AutoFarmStatus.Parent = AutoFarmToggle
AutoFarmStatus.BackgroundTransparency = 1
AutoFarmStatus.Size = UDim2.new(0, 40, 1, 0)
AutoFarmStatus.Position = UDim2.new(1, -45, 0, 0)
AutoFarmStatus.Font = Enum.Font.GothamBold
AutoFarmStatus.Text = "OFF"
AutoFarmStatus.TextColor3 = Color3.fromRGB(255, 50, 50)
AutoFarmStatus.TextSize = 14

AutoFarmSlider.Name = "AutoFarmSlider"
AutoFarmSlider.Parent = MainContent
AutoFarmSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
AutoFarmSlider.Size = UDim2.new(1, -10, 0, 25)
AutoFarmSlider.Position = UDim2.new(0, 5, 0, 40)
AutoFarmSlider.Font = Enum.Font.Gotham
AutoFarmSlider.Text = "Velocidad: "..AutoFarmSpeed
AutoFarmSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoFarmSlider.TextSize = 13
AutoFarmSlider.ClearTextOnFocus = true

--// WALK SPEED
WalkSpeedToggle.Name = "WalkSpeedToggle"
WalkSpeedToggle.Parent = MainContent
WalkSpeedToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
WalkSpeedToggle.Size = UDim2.new(1, -10, 0, 30)
WalkSpeedToggle.Position = UDim2.new(0, 5, 0, 70)
WalkSpeedToggle.Font = Enum.Font.GothamSemibold
WalkSpeedToggle.Text = "Walk Speed"
WalkSpeedToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
WalkSpeedToggle.TextSize = 14
WalkSpeedToggle.TextXAlignment = Enum.TextXAlignment.Left

WalkSpeedStatus.Name = "WalkSpeedStatus"
WalkSpeedStatus.Parent = WalkSpeedToggle
WalkSpeedStatus.BackgroundTransparency = 1
WalkSpeedStatus.Size = UDim2.new(0, 40, 1, 0)
WalkSpeedStatus.Position = UDim2.new(1, -45, 0, 0)
WalkSpeedStatus.Font = Enum.Font.GothamBold
WalkSpeedStatus.Text = "OFF"
WalkSpeedStatus.TextColor3 = Color3.fromRGB(255, 50, 50)
WalkSpeedStatus.TextSize = 14

WalkSpeedSlider.Name = "WalkSpeedSlider"
WalkSpeedSlider.Parent = MainContent
WalkSpeedSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
WalkSpeedSlider.Size = UDim2.new(1, -10, 0, 25)
WalkSpeedSlider.Position = UDim2.new(0, 5, 0, 105)
WalkSpeedSlider.Font = Enum.Font.Gotham
WalkSpeedSlider.Text = "Velocidad: "..WalkSpeedValue
WalkSpeedSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
WalkSpeedSlider.TextSize = 13
WalkSpeedSlider.ClearTextOnFocus = true

--// === SECCIÓN FREE SHOP ===
ShopSection.Name = "ShopSection"
ShopSection.Parent = MainFrame
ShopSection.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
ShopSection.Size = UDim2.new(1, -20, 0, 30)
ShopSection.Position = UDim2.new(0, 10, 0, 175)
ShopSection.Font = Enum.Font.GothamSemibold
ShopSection.Text = "Free Shop Items ↓"
ShopSection.TextColor3 = Color3.fromRGB(255, 255, 255)
ShopSection.TextSize = 14
ShopSection.TextXAlignment = Enum.TextXAlignment.Left

local ShopCorner = Instance.new("UICorner")
ShopCorner.CornerRadius = UDim.new(0, 6)
ShopCorner.Parent = ShopSection

ShopContent.Name = "ShopContent"
ShopContent.Parent = MainFrame
ShopContent.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
ShopContent.Size = UDim2.new(1, -20, 0, 130)
ShopContent.Position = UDim2.new(0, 10, 0, 210)
ShopContent.Visible = false

local ShopContentCorner = Instance.new("UICorner")
ShopContentCorner.CornerRadius = UDim.new(0, 6)
ShopContentCorner.Parent = ShopContent

--// DESBLOQUEAR CAMINADORAS
TreadmillsToggle.Name = "TreadmillsToggle"
TreadmillsToggle.Parent = ShopContent
TreadmillsToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
TreadmillsToggle.Size = UDim2.new(1, -10, 0, 35)
TreadmillsToggle.Position = UDim2.new(0, 5, 0, 10)
TreadmillsToggle.Font = Enum.Font.GothamSemibold
TreadmillsToggle.Text = "Desbloquear todas las caminadoras"
TreadmillsToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
TreadmillsToggle.TextSize = 13
TreadmillsToggle.TextXAlignment = Enum.TextXAlignment.Left

TreadmillsStatus.Name = "TreadmillsStatus"
TreadmillsStatus.Parent = TreadmillsToggle
TreadmillsStatus.BackgroundTransparency = 1
TreadmillsStatus.Size = UDim2.new(0, 40, 1, 0)
TreadmillsStatus.Position = UDim2.new(1, -45, 0, 0)
TreadmillsStatus.Font = Enum.Font.GothamBold
TreadmillsStatus.Text = "OFF"
TreadmillsStatus.TextColor3 = Color3.fromRGB(255, 50, 50)
TreadmillsStatus.TextSize = 14

--// DESBLOQUEAR RASTROS
TrailsToggle.Name = "TrailsToggle"
TrailsToggle.Parent = ShopContent
TrailsToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
TrailsToggle.Size = UDim2.new(1, -10, 0, 35)
TrailsToggle.Position = UDim2.new(0, 5, 0, 50)
TrailsToggle.Font = Enum.Font.GothamSemibold
TrailsToggle.Text = "Desbloquear todos los rastros"
TrailsToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
TrailsToggle.TextSize = 13
TrailsToggle.TextXAlignment = Enum.TextXAlignment.Left

TrailsStatus.Name = "TrailsStatus"
TrailsStatus.Parent = TrailsToggle
TrailsStatus.BackgroundTransparency = 1
TrailsStatus.Size = UDim2.new(0, 40, 1, 0)
TrailsStatus.Position = UDim2.new(1, -45, 0, 0)
TrailsStatus.Font = Enum.Font.GothamBold
TrailsStatus.Text = "OFF"
TrailsStatus.TextColor3 = Color3.fromRGB(255, 50, 50)
TrailsStatus.TextSize = 14

--// DESBLOQUEAR AURAS
AurasToggle.Name = "AurasToggle"
AurasToggle.Parent = ShopContent
AurasToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
AurasToggle.Size = UDim2.new(1, -10, 0, 35)
AurasToggle.Position = UDim2.new(0, 5, 0, 90)
AurasToggle.Font = Enum.Font.GothamSemibold
AurasToggle.Text = "Desbloquear todas las auras"
AurasToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AurasToggle.TextSize = 13
AurasToggle.TextXAlignment = Enum.TextXAlignment.Left

AurasStatus.Name = "AurasStatus"
AurasStatus.Parent = AurasToggle
AurasStatus.BackgroundTransparency = 1
AurasStatus.Size = UDim2.new(0, 40, 1, 0)
AurasStatus.Position = UDim2.new(1, -45, 0, 0)
AurasStatus.Font = Enum.Font.GothamBold
AurasStatus.Text = "OFF"
AurasStatus.TextColor3 = Color3.fromRGB(255, 50, 50)
AurasStatus.TextSize = 14

--// FUNCIONES

-- Animaciones de abrir/cerrar
local TweenInfoAnim = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local InfoOpen = false
local MainOpen = false
local ShopOpen = false

InfoSection.MouseButton1Click:Connect(function()
    InfoOpen = not InfoOpen
    if InfoOpen then
        InfoSection.Text = "Info ↑"
        InfoContent.Visible = true
        TweenService:Create(MainFrame, TweenInfoAnim, {Size = UDim2.new(0, 300, 0, 150)}):Play()
    else
        InfoSection.Text = "Info ↓"
        InfoContent.Visible = false
        TweenService:Create(MainFrame, TweenInfoAnim, {Size = UDim2.new(0, 300, 0, 80)}):Play()
    end
end)

MainSection.MouseButton1Click:Connect(function()
    MainOpen = not MainOpen
    if MainOpen then
        MainSection.Text = "Main ↑"
        MainContent.Visible = true
        TweenService:Create(MainFrame, TweenInfoAnim, {Size = UDim2.new(0, 300, 0, 260)}):Play()
    else
        MainSection.Text = "Main ↓"
        MainContent.Visible = false
        TweenService:Create(MainFrame, TweenInfoAnim, {Size = UDim2.new(0, 300, 0, 80)}):Play()
    end
end)

ShopSection.MouseButton1Click:Connect(function()
    ShopOpen = not ShopOpen
    if ShopOpen then
        ShopSection.Text = "Free Shop Items ↑"
        ShopContent.Visible = true
        TweenService:Create(MainFrame, TweenInfoAnim, {Size = UDim2.new(0, 300, 0, 350)}):Play()
    else
        ShopSection.Text = "Free Shop Items ↓"
        ShopContent.Visible = false
        TweenService:Create(MainFrame, TweenInfoAnim, {Size = UDim2.new(0, 300, 0, 80)}):Play()
    end
end)

-- Auto Farm Logic
local AutoFarmConnection = nil

AutoFarmToggle.MouseButton1Click:Connect(function()
    AutoFarmEnabled = not AutoFarmEnabled
    if AutoFarmEnabled then
        AutoFarmStatus.Text = "ON"
        AutoFarmStatus.TextColor3 = Color3.fromRGB(50, 255, 50)
        AutoFarmConnection = RunService.Heartbeat:Connect(function()
            if Character and Character:FindFirstChild("HumanoidRootPart") then
                Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, AutoFarmSpeed)
            end
        end)
    else
        AutoFarmStatus.Text = "OFF"
        AutoFarmStatus.TextColor3 = Color3.fromRGB(255, 50, 50)
        if AutoFarmConnection then
            AutoFarmConnection:Disconnect()
            AutoFarmConnection = nil
        end
    end
end)

AutoFarmSlider.FocusLost:Connect(function()
    local num = tonumber(AutoFarmSlider.Text)
    if num then
        AutoFarmSpeed = num
        AutoFarmSlider.Text = "Velocidad: "..num
    else
        AutoFarmSlider.Text = "Velocidad: "..AutoFarmSpeed
    end
end)

-- Walk Speed Logic
WalkSpeedToggle.MouseButton1Click:Connect(function()
    WalkSpeedEnabled = not WalkSpeedEnabled
    if WalkSpeedEnabled then
        WalkSpeedStatus.Text = "ON"
        WalkSpeedStatus.TextColor3 = Color3.fromRGB(50, 255, 50)
        Humanoid.WalkSpeed = WalkSpeedValue
    else
        WalkSpeedStatus.Text = "OFF"
        WalkSpeedStatus.TextColor3 = Color3.fromRGB(255, 50, 50)
        Humanoid.WalkSpeed = 16 -- Velocidad normal
    end
end)

WalkSpeedSlider.FocusLost:Connect(function()
    local num = tonumber(WalkSpeedSlider.Text)
    if num then
        WalkSpeedValue = num
        WalkSpeedSlider.Text = "Velocidad: "..num
        if WalkSpeedEnabled then
            Humanoid.WalkSpeed = num
        end
    else
        WalkSpeedSlider.Text = "Velocidad: "..WalkSpeedValue
    end
end)

-- FREE SHOP LOGIC
TreadmillsToggle.MouseButton1Click:Connect(function()
    AllTreadmillsUnlocked = not AllTreadmillsUnlocked
    if AllTreadmillsUnlocked then
        TreadmillsStatus.Text = "ON"
        TreadmillsStatus.TextColor3 = Color3.fromRGB(50, 255, 50)
        -- Aquí iría el código para desbloquear todas las caminadoras
        print("Todas las caminadoras desbloqueadas")
    else
        TreadmillsStatus.Text = "OFF"
        TreadmillsStatus.TextColor3 = Color3.fromRGB(255, 50, 50)
        print("Caminadoras bloqueadas")
    end
end)

TrailsToggle.MouseButton1Click:Connect(function()
    AllTrailsUnlocked = not AllTrailsUnlocked
    if AllTrailsUnlocked then
        TrailsStatus.Text = "ON"
        TrailsStatus.TextColor3 = Color3.fromRGB(50, 255, 50)
        -- Aquí iría el código para desbloquear todos los rastros
        print("Todos los rastros desbloqueados")
    else
        TrailsStatus.Text = "OFF"
        TrailsStatus.TextColor3 = Color3.fromRGB(255, 50, 50)
        print("Rastros bloqueados")
    end
end)

AurasToggle.MouseButton1Click:Connect(function()
    AllAurasUnlocked = not AllAurasUnlocked
    if AllAurasUnlocked then
        AurasStatus.Text = "ON"
        AurasStatus.TextColor3 = Color3.fromRGB(50, 255, 50)
        -- Aquí iría el código para desbloquear todas las auras
        print("Todas las auras desbloqueadas")
    else
        AurasStatus.Text = "OFF"
        AurasStatus.TextColor3 = Color3.fromRGB(255, 50, 50)
        print("Auras bloqueadas")
    end
end)

-- Arrastrar ventana
local Dragging, DragStart, StartPos = nil, nil, nil

local function Update(input)
    local Delta = input.Position - DragStart
    MainFrame.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)
end

UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        if MainFrame:IsPointInObject(input.Position) then
            Dragging = true
            DragStart = input.Position
            StartPos = MainFrame.Position
        end
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        Update(input)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = false
    end
end)
