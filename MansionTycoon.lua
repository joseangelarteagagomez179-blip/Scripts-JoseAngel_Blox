--// SERVICES
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

--// DESTROY OLD UI
if PlayerGui:FindFirstChild("MansionTycoonUI") then 
    PlayerGui.MansionTycoonUI:Destroy() 
end

--// VARIABLES
local ScreenGui = Instance.new("ScreenGui")
local MainUI = Instance.new("Frame")
local BackgroundGlow = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Container = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local LoadingText = Instance.new("TextLabel")
local LoadingUI = Instance.new("Frame") -- Para el efecto de rayos

--// PROPERTIES
ScreenGui.Name = "MansionTycoonUI"
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.ResetOnSpawn = false

--// ANIMACION DE CARGA (LETRAS GRUESAS + RAYOS AZULES)
LoadingUI.Name = "LoadingUI"
LoadingUI.BackgroundTransparency = 1
LoadingUI.Size = UDim2.new(0, 800, 0, 250)
LoadingUI.Position = UDim2.new(0.5, -400, 0.5, -125)
LoadingUI.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingUI.Parent = ScreenGui

-- Efecto de Rayos Azules (UIGradient rotando)
local Rayos = Instance.new("Frame")
Rayos.Name = "RayosAzules"
Rayos.BackgroundTransparency = 1
Rayos.Size = UDim2.new(1, 40, 1, 40)
Rayos.Position = UDim2.new(0.5, -20, 0.5, -20)
Rayos.AnchorPoint = Vector2.new(0.5, 0.5)
Rayos.Parent = LoadingUI

local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 150, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 200, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 150, 255))
}
UIGradient.Transparency = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 0),
    NumberSequenceKeypoint.new(0.5, 0.4),
    NumberSequenceKeypoint.new(1, 1)
}
UIGradient.Rotation = 0
UIGradient.Parent = Rayos

-- Animacion de los rayos girando
local RayConnection = RunService.Heartbeat:Connect(function()
    UIGradient.Rotation = tick() * 100 -- Gira rapido
end)

-- LAS LETRAS (SUPER GRUESAS)
LoadingText.Name = "LoadingText"
LoadingText.BackgroundTransparency = 1
LoadingText.Size = UDim2.new(1, 0, 1, 0)
LoadingText.Position = UDim2.new(0.5, 0, 0.5, 0)
LoadingText.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingText.Font = Enum.Font.FredokaOne -- La mas gruesa y bonita
LoadingText.TextColor3 = Color3.new(1,1,1)
LoadingText.TextSize = 70 -- Tamaño enorme
LoadingText.TextWrapped = true
LoadingText.Text = "Bienvenidos a\nScripts JoseAngel_Blox"
LoadingText.TextTransparency = 1
LoadingText.TextStrokeTransparency = 0.2
LoadingText.TextStrokeColor3 = Color3.new(0,0,0) -- Borde negro para resaltar
LoadingText.TextScaled = true
LoadingText.Parent = LoadingUI

--// EFECTO RGB FUERTE EN LAS LETRAS
local ColorConnection
ColorConnection = RunService.Heartbeat:Connect(function()
    local Hue = tick() % 3 / 3
    LoadingText.TextColor3 = Color3.fromHSV(Hue, 1, 1)
end)

--// MAIN UI
MainUI.Name = "MainUI"
MainUI.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
MainUI.Size = UDim2.new(0, 420, 0, 550)
MainUI.Position = UDim2.new(0.5, -210, 0.5, -275)
MainUI.AnchorPoint = Vector2.new(0.5, 0.5)
MainUI.BorderSizePixel = 0
MainUI.Active = true
MainUI.Draggable = true
MainUI.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 20)
MainCorner.Parent = MainUI

--// 🌟 EFECTO DE RELLENO NEON MORADO POR DENTRO 🌟
BackgroundGlow.Name = "BackgroundGlow"
BackgroundGlow.BackgroundColor3 = Color3.fromRGB(80, 0, 150)
BackgroundGlow.Size = UDim2.new(1, 0, 1, 0)
BackgroundGlow.Position = UDim2.new(0,0,0,0)
BackgroundGlow.BorderSizePixel = 0
BackgroundGlow.ZIndex = -1
BackgroundGlow.Parent = MainUI

local GlowCorner = Instance.new("UICorner")
GlowCorner.CornerRadius = UDim.new(0, 20)
GlowCorner.Parent = BackgroundGlow

-- Animacion de parpadeo suave
local PulseConnection
PulseConnection = RunService.Heartbeat:Connect(function()
    local Brightness = math.sin(tick() * 4) * 0.15 + 0.15
    BackgroundGlow.BackgroundTransparency = Brightness
end)

--// TITULO
Title.Name = "Title"
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.new(1,1,1)
Title.TextSize = 24
Title.Text = "Mansion Tycoon v1.0"
Title.Parent = MainUI

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = Title

--// CONTENEDOR
Container.Name = "Container"
Container.BackgroundTransparency = 1
Container.Size = UDim2.new(1, -20, 1, -70)
Container.Position = UDim2.new(0, 10, 0, 60)
Container.Parent = MainUI

UIListLayout.Parent = Container
UIListLayout.Padding = UDim.new(0, 12)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

--// FUNCION CREAR SECCION
local function CreateSection(name)
	local Section = Instance.new("Frame")
	local SectionTitle = Instance.new("TextLabel")
	local SectionContent = Instance.new("Frame")
	local Layout = Instance.new("UIListLayout")

	Section.Name = name.."Section"
	Section.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
	Section.Size = UDim2.new(1, 0, 0, 220)
	Section.ClipsDescendants = true
	Section.Parent = Container
    Section.LayoutOrder = 1

	local SecCorner = Instance.new("UICorner")
	SecCorner.CornerRadius = UDim.new(0, 12)
	SecCorner.Parent = Section

	SectionTitle.Name = "SectionTitle"
	SectionTitle.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
	SectionTitle.Size = UDim2.new(1, 0, 0, 40)
	SectionTitle.Font = Enum.Font.GothamBold
	SectionTitle.TextColor3 = Color3.new(1,1,1)
	SectionTitle.TextSize = 18
	SectionTitle.Text = name
	SectionTitle.Parent = Section

	local TitleSecCorner = Instance.new("UICorner")
	TitleSecCorner.CornerRadius = UDim.new(0, 8)
	TitleSecCorner.Parent = SectionTitle

	SectionContent.Name = "Content"
	SectionContent.BackgroundTransparency = 1
	SectionContent.Size = UDim2.new(1, -20, 1, -50)
	SectionContent.Position = UDim2.new(0, 10, 0, 45)
	SectionContent.Parent = Section

	Layout.Parent = SectionContent
	Layout.Padding = UDim.new(0, 10)
	Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

	return SectionContent
end

--// FUNCION CREAR TOGGLE
local function CreateToggle(parent, text, callback)
	local ToggleFrame = Instance.new("Frame")
	local ToggleLabel = Instance.new("TextLabel")
	local ToggleButton = Instance.new("TextButton")
	local ToggleFill = Instance.new("Frame")
	local ToggleCorner = Instance.new("UICorner")
	local FillCorner = Instance.new("UICorner")

	ToggleFrame.BackgroundTransparency = 1
	ToggleFrame.Size = UDim2.new(1, 0, 0, 40)
	ToggleFrame.Parent = parent

	ToggleLabel.BackgroundTransparency = 1
	ToggleLabel.Size = UDim2.new(0.6, 0, 1, 0)
	ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
	ToggleLabel.Font = Enum.Font.GothamBold
	ToggleLabel.TextColor3 = Color3.new(1,1,1)
	ToggleLabel.TextSize = 15
	ToggleLabel.Text = text
	ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
	ToggleLabel.Parent = ToggleFrame

	ToggleButton.Name = "Toggle"
	ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
	ToggleButton.Size = UDim2.new(0, 60, 0, 30)
	ToggleButton.Position = UDim2.new(1, -70, 0.5, -15)
	ToggleButton.Parent = ToggleFrame

	ToggleCorner.CornerRadius = UDim.new(0, 15)
	ToggleCorner.Parent = ToggleButton

	ToggleFill.Name = "Fill"
	ToggleFill.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
	ToggleFill.Size = UDim2.new(0, 28, 0, 28)
	ToggleFill.Position = UDim2.new(0, 1, 0, 1)
	ToggleFill.Parent = ToggleButton

	FillCorner.CornerRadius = UDim.new(1, 0)
	FillCorner.Parent = ToggleFill

	local Enabled = false
    local Connection = nil

	local function Update()
		if Enabled then
			TweenService:Create(ToggleFill, TweenInfo.new(0.2), {Position = UDim2.new(1, -29, 0, 1), BackgroundColor3 = Color3.fromRGB(180, 50, 255)}):Play()
			TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 20, 60)}):Play()
		else
			TweenService:Create(ToggleFill, TweenInfo.new(0.2), {Position = UDim2.new(0, 1, 0, 1), BackgroundColor3 = Color3.fromRGB(100, 0, 200)}):Play()
			TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 70)}):Play()
		end
        if callback then
            callback(Enabled)
        end
	end

	ToggleButton.MouseButton1Click:Connect(function()
		Enabled = not Enabled
		Update()
	end)

	Update()
	return ToggleFrame
end

--// CREAR SECCIONES
local InfoSection = CreateSection("info↓")
local InfoLabel = Instance.new("TextLabel")
InfoLabel.BackgroundTransparency = 1
InfoLabel.Size = UDim2.new(1, 0, 0, 120)
InfoLabel.Font = Enum.Font.GothamBold
InfoLabel.TextColor3 = Color3.new(1,1,1)
InfoLabel.TextSize = 17
InfoLabel.Text = "👑 Nombre del Creador: JoseAngel_Blox\n📅 Fecha de lanzamiento: 29/06/2026"
InfoLabel.TextWrapped = true
InfoLabel.Parent = InfoSection

local MainSection = CreateSection("Main↓")

--// FUNCIONES REALES
local MoneyFolder = workspace:FindFirstChild("Money") or workspace:FindFirstChild("Drops") or workspace

CreateToggle(MainSection, "Auto Recoger Dinero", function(state)
	if state then
		coroutine.wrap(function()
			while task.wait(0.2) and state do
				pcall(function()
					for _, item in pairs(MoneyFolder:GetChildren()) do
						if item:IsA("Part") or item:IsA("Tool") then
							item.CFrame = Player.Character.HumanoidRootPart.CFrame
						end
					end
				end)
			end
		end)()
	end
end)

CreateToggle(MainSection, "Auto Construir / Comprar", function(state)
	if state then
		coroutine.wrap(function()
			while task.wait(0.5) and state do
				pcall(function()
					for _, v in pairs(PlayerGui:GetChildren()) do
						if v:FindFirstChild("BuyButton") or v.Name:lower():find("build") or v.Name:lower():find("buy") then
							fireclickdetector(v:FindFirstChildOfClass("ClickDetector"))
						end
					end
				end)
			end
		end)()
	end
end)

CreateToggle(MainSection, "Auto Mejoras Rapido", function(state)
	if state then
		coroutine.wrap(function()
			while task.wait(0.3) and state do
				pcall(function()
					for _, obj in pairs(workspace:GetDescendants()) do
						if obj:IsA("ClickDetector") and obj.Parent.Name:lower():find("upgrade") then
							fireclickdetector(obj)
						end
					end
				end)
			end
		end)()
	end
end)

CreateToggle(MainSection, "Velocidad Extra", function(state)
	local char = Player.Character or Player.CharacterAdded:Wait()
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.WalkSpeed = state and 60 or 16
	end
end)

--// ANIMACION DE ENTRADA Y SALIDA
TweenService:Create(LoadingText, TweenInfo.new(1.2, Enum.EasingStyle.Elastic), {TextTransparency = 0, TextSize = 80}):Play()

task.wait(4)

TweenService:Create(LoadingUI, TweenInfo.new(0.8), {TextTransparency = 1, Size = UDim2.new(0,100,0,100)}):Play()
RayConnection:Disconnect()
ColorConnection:Disconnect()

task.wait(0.8)
LoadingUI:Destroy()

MainUI.Visible = true
MainUI.Size = UDim2.new(0, 420, 0, 500)
local TweenOpen = TweenService:Create(MainUI, TweenInfo.new(0.7, Enum.EasingStyle.Back), {Size = UDim2.new(0, 420, 0, 550)})
TweenOpen:Play()

print("✅ Script Cargado Perfecto - Mansion Tycoon v1.0")
