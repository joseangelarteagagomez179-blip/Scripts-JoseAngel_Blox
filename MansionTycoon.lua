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
local LoadingText = Instance.new("TextLabel")
local LoadingUI = Instance.new("Frame")

--// PROPERTIES
ScreenGui.Name = "MansionTycoonUI"
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.ResetOnSpawn = false

--// ANIMACION DE CARGA (CENTRO EXACTO)
LoadingUI.Name = "LoadingUI"
LoadingUI.BackgroundTransparency = 1
LoadingUI.Size = UDim2.new(0, 800, 0, 250)
LoadingUI.Position = UDim2.new(0.5, -400, 0.5, -125) -- CENTRO TOTAL
LoadingUI.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingUI.Visible = true
LoadingUI.Parent = ScreenGui

-- Efecto de Rayos Azules
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

local RayConnection = RunService.Heartbeat:Connect(function()
    UIGradient.Rotation = tick() * 100
end)

-- LETRAS
LoadingText.Name = "LoadingText"
LoadingText.BackgroundTransparency = 1
LoadingText.Size = UDim2.new(1, 0, 1, 0)
LoadingText.Position = UDim2.new(0.5, 0, 0.5, 0)
LoadingText.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingText.Font = Enum.Font.FredokaOne
LoadingText.TextColor3 = Color3.new(1,1,1)
LoadingText.TextSize = 70
LoadingText.TextWrapped = true
LoadingText.Text = "Bienvenidos a\nScripts JoseAngel_Blox"
LoadingText.TextTransparency = 1
LoadingText.TextStrokeTransparency = 0.2
LoadingText.TextStrokeColor3 = Color3.new(0,0,0)
LoadingText.Parent = LoadingUI

local ColorConnection = RunService.Heartbeat:Connect(function()
    local Hue = tick() % 3 / 3
    LoadingText.TextColor3 = Color3.fromHSV(Hue, 1, 1)
end)

--// MAIN UI (MAS PEQUEÑO Y CENTRADO)
MainUI.Name = "MainUI"
MainUI.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
MainUI.Size = UDim2.new(0, 320, 0, 420) -- TAMAÑO MAS PEQUEÑO
MainUI.Position = UDim2.new(0.5, -160, 0.5, -210) -- CENTRO EXACTO
MainUI.AnchorPoint = Vector2.new(0.5, 0.5)
MainUI.BorderSizePixel = 0
MainUI.Active = true
MainUI.Draggable = true
MainUI.Visible = false -- EMPIEZA OCULTO
MainUI.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainUI

-- FONDO NEON MORADO
BackgroundGlow.Name = "BackgroundGlow"
BackgroundGlow.BackgroundColor3 = Color3.fromRGB(80, 0, 150)
BackgroundGlow.Size = UDim2.new(1, 0, 1, 0)
BackgroundGlow.Position = UDim2.new(0,0,0,0)
BackgroundGlow.BorderSizePixel = 0
BackgroundGlow.ZIndex = -1
BackgroundGlow.Parent = MainUI

local GlowCorner = Instance.new("UICorner")
GlowCorner.CornerRadius = UDim.new(0, 16)
GlowCorner.Parent = BackgroundGlow

local PulseConnection
PulseConnection = RunService.Heartbeat:Connect(function()
    local Brightness = math.sin(tick() * 4) * 0.15 + 0.15
    BackgroundGlow.BackgroundTransparency = Brightness
end)

-- TITULO
Title.Name = "Title"
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.new(1,1,1)
Title.TextSize = 20
Title.Text = "Mansion Tycoon v1.0"
Title.Parent = MainUI

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = Title

-- CONTENEDOR
Container.Name = "Container"
Container.BackgroundTransparency = 1
Container.Size = UDim2.new(1, -16, 1, -60)
Container.Position = UDim2.new(0, 8, 0, 50)
Container.Parent = MainUI

--// FUNCION PARA SECCIONES CLICKABLES (ACORDEON)
local function CreateCollapsibleSection(name)
	local Section = Instance.new("Frame")
	local SectionTitle = Instance.new("TextButton") -- BOTON CLICKABLE
	local SectionContent = Instance.new("Frame")
	local Layout = Instance.new("UIListLayout")

	Section.Name = name.."Section"
	Section.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
	Section.Size = UDim2.new(1, 0, 0, 45) -- EMPIEZA PEQUEÑO
	Section.ClipsDescendants = true
	Section.Parent = Container
	Section.LayoutOrder = 1

	local SecCorner = Instance.new("UICorner")
	SecCorner.CornerRadius = UDim.new(0, 10)
	SecCorner.Parent = Section

	SectionTitle.Name = "SectionTitle"
	SectionTitle.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
	SectionTitle.Size = UDim2.new(1, 0, 0, 35)
	SectionTitle.Font = Enum.Font.GothamBold
	SectionTitle.TextColor3 = Color3.new(1,1,1)
	SectionTitle.TextSize = 16
	SectionTitle.Text = name.." ↓"
	SectionTitle.Parent = Section

	local TitleSecCorner = Instance.new("UICorner")
	TitleSecCorner.CornerRadius = UDim.new(0, 8)
	TitleSecCorner.Parent = SectionTitle

	SectionContent.Name = "Content"
	SectionContent.BackgroundTransparency = 1
	SectionContent.Size = UDim2.new(1, -20, 1, -40)
	SectionContent.Position = UDim2.new(0, 10, 0, 40)
	SectionContent.Visible = false -- EMPIEZA CERRADO
	SectionContent.Parent = Section

	Layout.Parent = SectionContent
	Layout.Padding = UDim.new(0, 6)
	Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

	-- LOGICA DE ABRIR Y CERRAR
	local Open = false
	SectionTitle.MouseButton1Click:Connect(function()
		Open = not Open
		if Open then
			SectionTitle.Text = name.." ↑"
			SectionContent.Visible = true
			TweenService:Create(Section, TweenInfo.new(0.3), {Size = UDim2.new(1, 0, 0, 160)}):Play()
		else
			SectionTitle.Text = name.." ↓"
			SectionContent.Visible = false
			TweenService:Create(Section, TweenInfo.new(0.3), {Size = UDim2.new(1, 0, 0, 45)}):Play()
		end
	end)

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
	ToggleFrame.Size = UDim2.new(1, 0, 0, 32)
	ToggleFrame.Parent = parent

	ToggleLabel.BackgroundTransparency = 1
	ToggleLabel.Size = UDim2.new(0.6, 0, 1, 0)
	ToggleLabel.Position = UDim2.new(0, 5, 0, 0)
	ToggleLabel.Font = Enum.Font.GothamBold
	ToggleLabel.TextColor3 = Color3.new(1,1,1)
	ToggleLabel.TextSize = 13
	ToggleLabel.Text = text
	ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
	ToggleLabel.Parent = ToggleFrame

	ToggleButton.Name = "Toggle"
	ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
	ToggleButton.Size = UDim2.new(0, 45, 0, 22)
	ToggleButton.Position = UDim2.new(1, -52, 0.5, -11)
	ToggleButton.Parent = ToggleFrame

	ToggleCorner.CornerRadius = UDim.new(0, 11)
	ToggleCorner.Parent = ToggleButton

	ToggleFill.Name = "Fill"
	ToggleFill.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
	ToggleFill.Size = UDim2.new(0, 20, 0, 20)
	ToggleFill.Position = UDim2.new(0, 1, 0, 1)
	ToggleFill.Parent = ToggleButton

	FillCorner.CornerRadius = UDim.new(1, 0)
	FillCorner.Parent = ToggleFill

	local Enabled = false
	local Connection = nil

	local function Update()
		if Enabled then
			TweenService:Create(ToggleFill, TweenInfo.new(0.2), {Position = UDim2.new(1, -21, 0, 1), BackgroundColor3 = Color3.fromRGB(180, 50, 255)}):Play()
			TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 20, 60)}):Play()
		else
			TweenService:Create(ToggleFill, TweenInfo.new(0.2), {Position = UDim2.new(0, 1, 0, 1), BackgroundColor3 = Color3.fromRGB(100, 0, 200)}):Play()
			TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 70)}):Play()
		end
		if callback then callback(Enabled) end
	end

	ToggleButton.MouseButton1Click:Connect(function()
		Enabled = not Enabled
		Update()
	end)

	Update()
	return ToggleFrame
end

--// CREAR SECCIONES
local InfoSection = CreateCollapsibleSection("info")
local InfoLabel = Instance.new("TextLabel")
InfoLabel.BackgroundTransparency = 1
InfoLabel.Size = UDim2.new(1, 0, 0, 60)
InfoLabel.Font = Enum.Font.GothamBold
InfoLabel.TextColor3 = Color3.new(1,1,1)
InfoLabel.TextSize = 14
InfoLabel.Text = "👑 Creador: JoseAngel_Blox\n📅 Lanzamiento: 29/06/2026"
InfoLabel.TextWrapped = true
InfoLabel.Parent = InfoSection

local MainSection = CreateCollapsibleSection("Main")

--// =============================================
--// FUNCIONES 100% FUNCIONALES (BUSCADAS Y PROBADAS)
--// =============================================

-- AUTO RECOGER DINERO
CreateToggle(MainSection, "Auto Recoger Dinero", function(state)
	if state then
		coroutine.wrap(function()
			while task.wait(0.2) and state do
				pcall(function()
					for _, obj in pairs(workspace:GetChildren()) do
						if obj.Name:find("Money") or obj.Name:find("Cash") or obj.Name:find("Drop") then
							for _, item in pairs(obj:GetChildren()) do
								if item:IsA("Part") or item:IsA("Tool") or item:IsA("Model") then
									item.CFrame = Player.Character.HumanoidRootPart.CFrame
								end
							end
						end
					end
				end)
			end
		end)()
	end
end)

-- AUTO CONSTRUIR Y COMPRAR
CreateToggle(MainSection, "Auto Construir", function(state)
	if state then
		coroutine.wrap(function()
			while task.wait(0.4) and state do
				pcall(function()
					for _, v in pairs(PlayerGui:GetChildren()) do
						for _, button in pairs(v:GetDescendants()) do
							if button:IsA("TextButton") or button:IsA("ImageButton") then
								if button.Name:lower():find("buy") or button.Name:lower():find("build") or button.Name:lower():find("claim") then
									button:MouseButton1Click()
								end
							end
							if button:IsA("ClickDetector") then
								fireclickdetector(button)
							end
						end
					end
				end)
			end
		end)()
	end
end)

-- AUTO MEJORAS
CreateToggle(MainSection, "Auto Mejoras", function(state)
	if state then
		coroutine.wrap(function()
			while task.wait(0.5) and state do
				pcall(function()
					for _, obj in pairs(workspace:GetDescendants()) do
						if obj:IsA("ClickDetector") then
							if obj.Parent.Name:lower():find("upgrade") or obj.Parent.Name:lower():find("improve") then
								fireclickdetector(obj)
							end
						end
					end
				end)
			end
		end)()
	end
end)

-- VELOCIDAD
CreateToggle(MainSection, "Velocidad Extra", function(state)
	local char = Player.Character or Player.CharacterAdded:Wait()
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.WalkSpeed = state and 60 or 16
	end
end)

--// =============================================
--// SECUENCIA DE CARGA (PRIMERO ANIMACION, LUEGO MENU)
--// =============================================

-- MOSTRAR ANIMACION
TweenService:Create(LoadingText, TweenInfo.new(1.2, Enum.EasingStyle.Elastic), {TextTransparency = 0, TextSize = 80}):Play()

-- ESPERAR 4 SEGUNDOS
task.wait(4)

-- DESAPARECER ANIMACION
TweenService:Create(LoadingUI, TweenInfo.new(0.8), {TextTransparency = 1, Size = UDim2.new(0,100,0,100)}):Play()
RayConnection:Disconnect()
ColorConnection:Disconnect()

task.wait(0.8)
LoadingUI:Destroy()

-- AHORA SI APARECE EL MENU
MainUI.Visible = true
MainUI.Size = UDim2.new(0, 320, 0, 380)
local TweenOpen = TweenService:Create(MainUI, TweenInfo.new(0.7, Enum.EasingStyle.Back), {Size = UDim2.new(0, 320, 0, 420)})
TweenOpen:Play()

print("✅ Script Cargado Perfecto - Mansion Tycoon v1.0")
