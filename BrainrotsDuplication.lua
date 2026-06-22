-- SERVICIOS
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- VARIABLES
local Player = game.Players.LocalPlayer
local Backpack = Player:WaitForChild("Backpack")

-- CREANDO LA GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")

-- BOTONES Y TEXTO
local Button1 = Instance.new("TextButton")
local Button2 = Instance.new("TextButton")
local InfoText = Instance.new("TextLabel")

-- PROPIEDADES
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- VENTANA PRINCIPAL
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 320, 0, 450)
MainFrame.ClipsDescendants = true

-- ESQUINAS REDONDEADAS
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 18)
UICorner.Parent = MainFrame

-- TITULO
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Font = Enum.Font.GothamBold
Title.Text = "💠 Brainrots duplications VIP 💠"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 17

-- =============================================
-- 🟢 BOTÓN 1: INFO
-- =============================================
Button1.Name = "BotonInfo"
Button1.Parent = MainFrame
Button1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Button1.Position = UDim2.new(0.1, 0, 0.25, 0)
Button1.Size = UDim2.new(0.8, 0, 0.15, 0)
Button1.Font = Enum.Font.GothamBold
Button1.Text = "ℹ️ Info"
Button1.TextColor3 = Color3.fromRGB(255, 255, 255)
Button1.TextSize = 16

local UICorner1 = Instance.new("UICorner")
UICorner1.CornerRadius = UDim.new(0, 12)
UICorner1.Parent = Button1

-- TEXTO DE INFO
InfoText.Name = "InfoText"
InfoText.Parent = MainFrame
InfoText.BackgroundTransparency = 1
InfoText.Position = UDim2.new(0.05, 0, 0.42, 0)
InfoText.Size = UDim2.new(0.9, 0, 0, 100)
InfoText.Font = Enum.Font.Gotham
InfoText.Text = "Creador: JoseAngel_Blox\nFecha: 22/06/2026"
InfoText.TextColor3 = Color3.fromRGB(200, 200, 200)
InfoText.TextSize = 14
InfoText.TextWrapped = true
InfoText.Visible = false

local InfoVisible = false
Button1.MouseButton1Click:Connect(function()
    InfoVisible = not InfoVisible
    InfoText.Visible = InfoVisible
end)

-- =============================================
-- 🚀 BOTÓN 2: DUPLICAR BRAINROTS
-- =============================================
Button2.Name = "BotonDupe"
Button2.Parent = MainFrame
Button2.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Button2.Position = UDim2.new(0.1, 0, 0.65, 0)
Button2.Size = UDim2.new(0.8, 0, 0.15, 0)
Button2.Font = Enum.Font.GothamBold
Button2.Text = "🚀 Duplicar Brainrots"
Button2.TextColor3 = Color3.fromRGB(255, 255, 255)
Button2.TextSize = 16

local UICorner2 = Instance.new("UICorner")
UICorner2.CornerRadius = UDim.new(0, 12)
UICorner2.Parent = Button2

-- 💠 FUNCIÓN DE DUPLICAR
local Activado = false
local Bucle = nil

local function Duplicar()
    for _, Item in pairs(Backpack:GetChildren()) do
        if string.find(Item.Name:lower(), "brainrot") then
            local Clon = Item:Clone()
            Clon.Parent = Backpack
        end
    end
end

Button2.MouseButton1Click:Connect(function()
    Activado = not Activado
    if Activado then
        Button2.BackgroundColor3 = Color3.fromRGB(0, 150, 0) -- Verde cuando está ON
        Button2.Text = "✅ ACTIVADO"
        Bucle = RunService.Heartbeat:Connect(Duplicar)
    else
        Button2.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Gris cuando está OFF
        Button2.Text = "🚀 Duplicar Brainrots"
        Bucle:Disconnect()
    end
end)

-- =============================================
-- ✨ EFECTOS AL PASAR EL MOUSE ✨
-- =============================================
Button1.MouseEnter:Connect(function()
    TweenService:Create(Button1, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
end)
Button1.MouseLeave:Connect(function()
    TweenService:Create(Button1, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
end)

Button2.MouseEnter:Connect(function()
    if not Activado then
        TweenService:Create(Button2, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
    end
end)
Button2.MouseLeave:Connect(function()
    if not Activado then
        TweenService:Create(Button2, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
    end
end)
