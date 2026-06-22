-- == PARTE 1: INTERFAZ VISUAL ==
-- Servicios necesarios
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local PlayerGui = Players.LocalPlayer.PlayerGui

-- Destruir GUI anterior si existe
if PlayerGui:FindFirstChild("BrainrotsDuplication") then
    PlayerGui.BrainrotsDuplication:Destroy()
end

-- Crear la pantalla principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BrainrotsDuplication"
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- == MARCO PRINCIPAL ==
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 15)
MainFrame.Size = UDim2.new(0, 280, 0, 400)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -200)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.ClipsDescendants = true
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- ✅ SE PUEDE MOVER

-- ESQUINAS REDONDEADAS
local UICorner = Instance.new("UICorner")
UICorner.Parent = MainFrame
UICorner.CornerRadius = UDim.new(0, 15)

-- == FONDO DE ESTRELLAS (TU IMAGEN) ==
local StarsBackground = Instance.new("ImageLabel")
StarsBackground.Name = "StarsBackground"
StarsBackground.Parent = MainFrame
StarsBackground.Size = UDim2.new(1, 0, 1, 0)
StarsBackground.Position = UDim2.new(0, 0, 0, 0)
StarsBackground.BackgroundTransparency = 1
-- ✅ ID CORRECTO DE TU IMAGEN ✅
StarsBackground.Image = "rbxassetid://120999595778887"
StarsBackground.ImageColor3 = Color3.fromRGB(255, 255, 255)
StarsBackground.ScaleType = Enum.ScaleType.Crop
StarsBackground.ZIndex = 0

-- == TÍTULO DEL SCRIPT ==
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, -20, 0, 40)
Title.Position = UDim2.new(0, 10, 0, 10)
Title.Font = Enum.Font.GothamBold
Title.Text = "Brainrots duplications"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.ZIndex = 2

-- == EFECTO DE LUZ BRILLANDO ==
local Glow = Instance.new("ImageLabel")
Glow.Name = "GlowEffect"
Glow.Parent = MainFrame
Glow.BackgroundTransparency = 1
Glow.Size = UDim2.new(1.5, 0, 1.5, 0)
Glow.Position = UDim2.new(-0.25, 0, -0.25, 0)
Glow.Image = "rbxassetid://9112847281"
Glow.ImageColor3 = Color3.fromRGB(130, 130, 255)
Glow.ImageTransparency = 0.6
Glow.ZIndex = 1

-- Animación suave del brillo girando
local TweenInfoSettings = TweenInfo.new(5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local Tween = TweenService:Create(Glow, TweenInfoSettings, {Rotation = 360})
Tween:Play()

-- ==============================================
-- ==            OPCIÓN 1: INFORMACIÓN        ==
-- ==============================================

local InfoFrame = Instance.new("Frame")
InfoFrame.Name = "InfoFrame"
InfoFrame.Parent = MainFrame
InfoFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 45)
InfoFrame.Size = UDim2.new(0, 250, 0, 90)
InfoFrame.Position = UDim2.new(0.5, -125, 0, 60)
InfoFrame.AnchorPoint = Vector2.new(0.5, 0)
InfoFrame.ZIndex = 2

-- Esquinas redondeadas al info
local UICornerInfo = Instance.new("UICorner")
UICornerInfo.Parent = InfoFrame
UICornerInfo.CornerRadius = UDim.new(0, 10)

-- Texto de la información
local InfoText = Instance.new("TextLabel")
InfoText.Name = "InfoText"
InfoText.Parent = InfoFrame
InfoText.BackgroundTransparency = 1
InfoText.Size = UDim2.new(1, -15, 1, -15)
InfoText.Position = UDim2.new(0, 7, 0, 7)
InfoText.Font = Enum.Font.GothamBold
InfoText.Text = "📄 INFORMACIÓN\n\n👤 Creador: JoseAngel_Blox\n📅 Fecha: 22/06/2026"
InfoText.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoText.TextSize = 14
InfoText.TextWrapped = true
InfoText.ZIndex = 3
InfoText.TextXAlignment = Enum.TextXAlignment.Left

print("✅ Todo listo y corregido!")
