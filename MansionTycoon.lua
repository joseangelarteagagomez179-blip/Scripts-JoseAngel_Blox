--// Services
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

--// Destroy old UI if exists
if PlayerGui:FindFirstChild("MansionTycoonUI") then
    PlayerGui:FindFirstChild("MansionTycoonUI"):Destroy()
end

--// Variables
local ScreenGui = Instance.new("ScreenGui")
local MainUI = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Container = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local LoadingText = Instance.new("TextLabel")

--// Properties
ScreenGui.Name = "MansionTycoonUI"
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

--// ANIMACIÓN DE CARGA (Solo letras con colores)
LoadingText.Name = "LoadingText"
LoadingText.BackgroundTransparency = 1
LoadingText.Size = UDim2.new(0, 600, 0, 150)
LoadingText.Position = UDim2.new(0.5, -300, 0.5, -75)
LoadingText.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingText.Font = Enum.Font.FredokaOne -- Fuente más bonita y gruesa
LoadingText.TextColor3 = Color3.new(1,1,1)
LoadingText.TextSize = 45
LoadingText.TextWrapped = true
LoadingText.Text = "Bienvenidos a\nScripts JoseAngel_Blox"
LoadingText.TextTransparency = 1
LoadingText.Parent = ScreenGui

--// EFECTO DE COLORES GIRANDO
local ColorConnection = game:GetService("RunService").RenderStepped:Connect(function()
    local Hue = tick() % 5 / 5 -- Cambia el color suavemente
    LoadingText.TextColor3 = Color3.fromHSV(Hue, 0.7, 1)
end)

--// Main UI (Hidden at start)
MainUI.Name = "MainUI"
MainUI.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainUI.Size = UDim2.new(0, 400, 0, 500)
MainUI.Position = UDim2.new(0.5, -200, 0.5, -250)
MainUI.AnchorPoint = Vector2.new(0.5, 0.5)
MainUI.BorderSizePixel = 0
MainUI.Visible = false
MainUI.Parent = ScreenGui

local MainCorner = Instance.new("UICorner", MainUI)
MainCorner.CornerRadius = UDim.new(0, 20)

Title.Name = "Title"
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 22
Title.Text = "Mansion Tycoon v1.0"
Title.Parent = MainUI

local TitleCorner = Instance.new("UICorner", Title)
TitleCorner.CornerRadius = UDim.new(0, 10)

Container.Name = "Container"
Container.BackgroundTransparency = 1
Container.Size = UDim2.new(1, -20, 1, -70)
Container.Position = UDim2.new(0, 10, 0, 60)
Container.Parent = MainUI

UIListLayout.Parent = Container
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

--// Function to create Sections
local function CreateSection(name)
	local Section = Instance.new("Frame")
	local SectionTitle = Instance.new("TextLabel")
	local SectionContent = Instance.new("Frame")
	local Layout = Instance.new("UIListLayout")

	Section.Name = name.."Section"
	Section.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
	Section.Size = UDim2.new(1, 0, 0, 200)
	Section.ClipsDescendants = true
	Section.Parent = Container
    Section.LayoutOrder = 1

	local SecCorner = Instance.new("UICorner", Section)
	SecCorner.CornerRadius = UDim.new(0, 12)

	SectionTitle.Name = "SectionTitle"
	SectionTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	SectionTitle.Size = UDim2.new(1, 0, 0, 35)
	SectionTitle.Font = Enum.Font.GothamBold
	SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	SectionTitle.TextSize = 16
	SectionTitle.Text = name
	SectionTitle.Parent = Section

	local TitleSecCorner = Instance.new("UICorner", SectionTitle)
	TitleSecCorner.CornerRadius = UDim.new(0, 8)

	SectionContent.Name = "Content"
	SectionContent.BackgroundTransparency = 1
	SectionContent.Size = UDim2.new(1, -20, 1, -45)
	SectionContent.Position = UDim2.new(0, 10, 0, 40)
	SectionContent.Parent = Section

	Layout.Parent = SectionContent
	Layout.Padding = UDim.new(0, 8)
	Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

	return SectionContent
end

--// Function to create Toggle
local function CreateToggle(parent, text, callback)
	local ToggleFrame = Instance.new("Frame")
	local ToggleLabel = Instance.new("TextLabel")
	local ToggleButton = Instance.new("TextButton")
	local ToggleFill = Instance.new("Frame")
	local ToggleCorner = Instance.new("UICorner")
	local FillCorner = Instance.new("UICorner")

	ToggleFrame.BackgroundTransparency = 1
	ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
	ToggleFrame.Parent = parent

	ToggleLabel.BackgroundTransparency = 1
	ToggleLabel.Size = UDim2.new(0.6, 0, 1, 0)
	ToggleLabel.Position = UDim2.new(0, 5, 0, 0)
	ToggleLabel.Font = Enum.Font.Gotham
	ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	ToggleLabel.TextSize = 14
	ToggleLabel.Text = text
	ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
	ToggleLabel.Parent = ToggleFrame

	ToggleButton.Name = "Toggle"
	ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	ToggleButton.Size = UDim2.new(0, 50, 0, 25)
	ToggleButton.Position = UDim2.new(1, -55, 0.5, -12.5)
	ToggleButton.Parent = ToggleFrame

	ToggleCorner.CornerRadius = UDim.new(0, 12)
	ToggleCorner.Parent = ToggleButton

	ToggleFill.Name = "Fill"
	ToggleFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	ToggleFill.Size = UDim2.new(0, 23, 0, 23)
	ToggleFill.Position = UDim2.new(0, 1, 0, 1)
	ToggleFill.Parent = ToggleButton

	FillCorner.CornerRadius = UDim.new(1, 0)
	FillCorner.Parent = ToggleFill

	local Enabled = false
    local Connection = nil

	local function Update()
		if Enabled then
			TweenService:Create(ToggleFill, TweenInfo.new(0.2), {Position = UDim2.new(1, -24, 0, 1), BackgroundColor3 = Color3.fromRGB(0, 255, 127)}):Play()
			TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 70, 55)}):Play()
		else
			TweenService:Create(ToggleFill, TweenInfo.new(0.2), {Position = UDim2.new(0, 1, 0, 1), BackgroundColor3 = Color3.fromRGB(0, 170, 255)}):Play()
			TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
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

--// CREATE SECTIONS

-- 1) INFO SECTION
local InfoSection = CreateSection("info↓")

local InfoLabel = Instance.new("TextLabel")
InfoLabel.BackgroundTransparency = 1
InfoLabel.Size = UDim2.new(1, 0, 0, 100)
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoLabel.TextSize = 16
InfoLabel.Text = "Nombre del Creador: JoseAngel_Blox\nFecha de lanzamiento: 29/06/2026"
InfoLabel.TextWrapped = true
InfoLabel.Parent = InfoSection

-- 2) MAIN SECTION
local MainSection = CreateSection("Main↓")

-- FUNCIONES
CreateToggle(MainSection, "Auto Recoger Dinero", function(state)
	if state then
		print("Auto Dinero ON")
		spawn(function()
			while task.wait(0.5) and state do
				pcall(function()
					-- Codigo aqui
				end)
			end
		end)
	else
		print("Auto Dinero OFF")
	end
end)

CreateToggle(MainSection, "Auto Construir", function(state)
	if state then
		print("Auto Construir ON")
		spawn(function()
			while task.wait(1) and state do
				pcall(function()
					-- Codigo aqui
				end)
			end
		end)
	else
		print("Auto Construir OFF")
	end
end)

CreateToggle(MainSection, "Auto Comprar Mejoras", function(state)
	if state then
		print("Auto Mejoras ON")
		spawn(function()
			while task.wait(1.5) and state do
				pcall(function()
					-- Codigo aqui
				end)
			end)
		end)
	else
		print("Auto Mejoras OFF")
	end
end)

CreateToggle(MainSection, "Velocidad Extra", function(state)
	local char = Player.Character or Player.CharacterAdded:Wait()
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.WalkSpeed = state and 50 or 16
	end
end)

--// SECUENCIA DE ANIMACIÓN
TweenService:Create(LoadingText, TweenInfo.new(1), {TextTransparency = 0, TextSize = 50}):Play()

task.wait(3) -- Tiempo que dura el efecto

-- Desaparecer suavemente
TweenService:Create(LoadingText, TweenInfo.new(0.8), {TextTransparency = 1, TextSize = 10}):Play()
ColorConnection:Disconnect() -- Detener el cambio de color

task.wait(0.8)
LoadingText:Destroy()

-- Aparece el menú principal
MainUI.Visible = true
MainUI.Size = UDim2.new(0, 400, 0, 450)
local TweenOpen = TweenService:Create(MainUI, TweenInfo.new(0.6, Enum.EasingStyle.Back), {Size = UDim2.new(0, 400, 0, 500)})
TweenOpen:Play()

print("✅ Script Cargado Correctamente - Mansion Tycoon v1.0")
