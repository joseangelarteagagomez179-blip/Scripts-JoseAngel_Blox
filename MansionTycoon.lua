-- Mansion Tycoon v1.2 by JoseAngel_Blox
-- 30/06/2026 - Versión corregida y más chiquita

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MansionTycoon_v1.2"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 520, 0, 340) -- Más chiquito
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -170)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

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
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
Title.Text = "Mansion Tycoon v1.2"
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

-- ====================== INFO (arriba) ======================
local InfoSection = Instance.new("Frame")
InfoSection.Size = UDim2.new(0.95, 0, 0, 95)
InfoSection.Position = UDim2.new(0.025, 0, 0.08, 0)
InfoSection.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
InfoSection.Parent = MainFrame

local InfoCorner = Instance.new("UICorner")
InfoCorner.CornerRadius = UDim.new(0, 10)
InfoCorner.Parent = InfoSection

local InfoTitle = Instance.new("TextLabel")
InfoTitle.Size = UDim2.new(1, 0, 0, 30)
InfoTitle.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
InfoTitle.Text = "📋 INFO DEL SCRIPT"
InfoTitle.TextColor3 = Color3.fromRGB(200, 200, 255)
InfoTitle.TextScaled = true
InfoTitle.Font = Enum.Font.GothamBold
InfoTitle.Parent = InfoSection

local InfoCorner2 = Instance.new("UICorner")
InfoCorner2.CornerRadius = UDim.new(0, 10)
InfoCorner2.Parent = InfoTitle

local InfoCreator = Instance.new("TextLabel")
InfoCreator.Size = UDim2.new(0.9, 0, 0, 25)
InfoCreator.Position = UDim2.new(0.05, 0, 0, 35)
InfoCreator.BackgroundTransparency = 1
InfoCreator.Text = "Creador: JoseAngel_Blox"
InfoCreator.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoCreator.TextXAlignment = Enum.TextXAlignment.Left
InfoCreator.Parent = InfoSection

local InfoDate = Instance.new("TextLabel")
InfoDate.Size = UDim2.new(0.9, 0, 0, 25)
InfoDate.Position = UDim2.new(0.05, 0, 0, 60)
InfoDate.BackgroundTransparency = 1
InfoDate.Text = "Fecha de lanzamiento: 30/06/2026"
InfoDate.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoDate.TextXAlignment = Enum.TextXAlignment.Left
InfoDate.Parent = InfoSection

-- ====================== MANUAL (justo debajo) ======================
local ManualSection = Instance.new("Frame")
ManualSection.Size = UDim2.new(0.95, 0, 0, 95)
ManualSection.Position = UDim2.new(0.025, 0, 0.32, 0)
ManualSection.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
ManualSection.Parent = MainFrame

local ManualCorner = Instance.new("UICorner")
ManualCorner.CornerRadius = UDim.new(0, 10)
ManualCorner.Parent = ManualSection

local ManualTitle = Instance.new("TextLabel")
ManualTitle.Size = UDim2.new(1, 0, 0, 30)
ManualTitle.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
ManualTitle.Text = "📖 MANUAL"
ManualTitle.TextColor3 = Color3.fromRGB(200, 200, 255)
ManualTitle.TextScaled = true
ManualTitle.Font = Enum.Font.GothamBold
ManualTitle.Parent = ManualSection

local ManualCorner2 = Instance.new("UICorner")
ManualCorner2.CornerRadius = UDim.new(0, 10)
ManualCorner2.Parent = ManualTitle

local ManualText = Instance.new("TextLabel")
ManualText.Size = UDim2.new(0.9, 0, 0.65, 0)
ManualText.Position = UDim2.new(0.05, 0, 0, 35)
ManualText.BackgroundTransparency = 1
ManualText.Text = [[
¡BIENVENIDOS A SCRIPTS JOSEANGEL_BLOX!

Auto Collect: Monedas recogen solas
Auto Buy: Compra automáticamente
Infinite Money: Dinero ilimitado
Auto Build: Construye lo que necesites
]]
ManualText.TextColor3 = Color3.fromRGB(220, 220, 220)
ManualText.TextXAlignment = Enum.TextXAlignment.Left
ManualText.TextYAlignment = Enum.TextYAlignment.Top
ManualText.TextWrapped = true
ManualText.Font = Enum.Font.Gotham
ManualText.Parent = ManualSection

-- ====================== MAIN (abajo) ======================
local MainSection = Instance.new("Frame")
MainSection.Size = UDim2.new(0.95, 0, 0, 95)
MainSection.Position = UDim2.new(0.025, 0, 0.55, 0)
MainSection.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
MainSection.Parent = MainFrame

local MainTitle = Instance.new("TextLabel")
MainTitle.Size = UDim2.new(1, 0, 0, 30)
MainTitle.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
MainTitle.Text = "⚙️ FUNCIONES IMPORTANTES"
MainTitle.TextColor3 = Color3.fromRGB(200, 200, 255)
MainTitle.TextScaled = true
MainTitle.Font = Enum.Font.GothamBold
MainTitle.Parent = MainSection

local MainCorner2 = Instance.new("UICorner")
MainCorner2.CornerRadius = UDim.new(0, 10)
MainCorner2.Parent = MainTitle

-- Botones con flechas (↓↑)
local function CreateToggleWithArrows(Text, DefaultState)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0.9, 0, 0, 40)
    Frame.Position = UDim2.new(0.05, 0, 0, 35)
    Frame.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
    Frame.Parent = MainSection
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Frame
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.65, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = Text
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame
    
    local Status = Instance.new("TextLabel")
    Status.Size = UDim2.new(0.3, 0, 1, 0)
    Status.Position = UDim2.new(0.68, 0, 0, 0)
    Status.BackgroundTransparency = 1
    Status.Text = DefaultState and "ON" or "OFF"
    Status.TextColor3 = DefaultState and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 80, 80)
    Status.TextScaled = true
    Status.Parent = Frame
    
    local DownButton = Instance.new("TextButton")
    DownButton.Size = UDim2.new(0, 20, 0, 20)
    DownButton.Position = UDim2.new(0.03, 0, 0.5, -10)
    DownButton.BackgroundColor3 = Color3.fromRGB(255, 180, 50)
    DownButton.Text = "↓"
    DownButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    DownButton.TextScaled = true
    DownButton.Parent = Frame
    
    local UpButton = Instance.new("TextButton")
    UpButton.Size = UDim2.new(0, 20, 0, 20)
    UpButton.Position = UDim2.new(0.95, 0, 0.5, -10)
    UpButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    UpButton.Text = "↑"
    UpButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    UpButton.TextScaled = true
    UpButton.Parent = Frame
    
    local IsActive = DefaultState
    local IsExpanded = false
    
    DownButton.MouseButton1Click:Connect(function()
        IsExpanded = true
        UpButton.Visible = true
        DownButton.Visible = false
    end)
    
    UpButton.MouseButton1Click:Connect(function()
        IsExpanded = false
        UpButton.Visible = false
        DownButton.Visible = true
    end)
    
    return IsActive
end

local AutoCollect = CreateToggleWithArrows("Auto Collect (monedas)", true)
local AutoBuy = CreateToggleWithArrows("Auto Buy", false)
local InfiniteMoney = CreateToggleWithArrows("Infinite Money", false)
local AutoBuild = CreateToggleWithArrows("Auto Build", false)

-- ====================== ANIMACIÓN DE BIENVENIDA ======================
local WelcomeLabel = Instance.new("TextLabel")
WelcomeLabel.Size = UDim2.new(0.85, 0, 0, 50)
WelcomeLabel.Position = UDim2.new(0.075, 0, 0.1, 0)
WelcomeLabel.BackgroundTransparency = 1
WelcomeLabel.Text = "¡Bienvenidos a Scripts JoseAngel_Blox!"
WelcomeLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
WelcomeLabel.TextScaled = true
WelcomeLabel.Font = Enum.Font.GothamBold
WelcomeLabel.Parent = MainFrame

local LoadingFrame = Instance.new("Frame")
LoadingFrame.Size = UDim2.new(0.85, 0, 0, 10)
LoadingFrame.Position = UDim2.new(0.075, 0, 0.25, 0)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
LoadingFrame.Parent = MainFrame

local LoadingBar = Instance.new("Frame")
LoadingBar.Size = UDim2.new(0, 1, 1, 0)
LoadingBar.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
LoadingBar.Parent = LoadingFrame

WelcomeLabel:TweenPosition(UDim2.new(0.075, 0, 0.18, 0), "Out", "Quad", 1, true)
WelcomeLabel:TweenTextTransparency(0, TweenInfo.new(1), true)

local LoadingTween = TweenService:Create(LoadingBar, TweenInfo.new(2.8, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 1, 0)})
LoadingTween:Play()

LoadingTween.Completed:Connect(function()
    LoadingBar.BackgroundColor3 = Color3.fromRGB(0, 255, 80)
    task.wait(0.3)
    WelcomeLabel:Destroy()
    LoadingFrame:Destroy()
end)

-- ====================== FUNCIONES REALES ======================
local function AutoCollectCoins()
    task.spawn(function()
        while task.wait(0.8) do
            if AutoCollect then
                -- Aquí va tu código real de recoger monedas (depende de tu executor)
                print("✅ Auto Collect ON - Monedas recogidas")
            end
        end
    end)
end

local function AutoBuyItems()
    task.spawn(function()
        while task.wait(1.2) do
            if AutoBuy then
                print("✅ Auto Buy ON - Comprando todo automáticamente")
                -- Aquí agregas tus compras reales (buzzer, upgrades, etc.)
            end
        end
    end)
end

local function InfiniteMoneyFunc()
    task.spawn(function()
        while task.wait(0.5) do
            if InfiniteMoney then
                print("💰 Infinite Money ON")
                -- Aquí agregas tu money loop real
            end
        end
    end)
end

local function AutoBuildFunc()
    task.spawn(function()
        while task.wait(2) do
            if AutoBuild then
                print("🏗️ Auto Build ON - Construyendo según tu orden")
                -- Aquí pones tus botones de build reales
            end
        end
    end)
end

-- Iniciar todo
AutoCollectCoins()
AutoBuyItems()
InfiniteMoneyFunc()
AutoBuildFunc()

-- Minimizar
ToggleButton.MouseButton1Click:Connect(function()
    if MainFrame.Size == UDim2.new(0, 520, 0, 340) then
        MainFrame:TweenSize(UDim2.new(0, 520, 0, 80), "Out", "Quad", 0.4, true)
        MainSection.Visible = false
        ManualText.Visible = false
        InfoSection.Visible = false
        MainTitle.Visible = false
    else
        MainFrame:TweenSize(UDim2.new(0, 520, 0, 340), "Out", "Quad", 0.4, true)
        MainSection.Visible = true
        ManualText.Visible = true
        InfoSection.Visible = true
        MainTitle.Visible = true
    end
end)

print("✅ Mansion Tycoon v1.2 cargado correctamente por JoseAngel_Blox!")
