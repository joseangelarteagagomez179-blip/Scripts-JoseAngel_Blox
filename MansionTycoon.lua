--// SERVICES
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui
local Camera = workspace.CurrentCamera

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

--// ========== ANIMACION DE CARGA CORREGIDA ==========
LoadingUI.Name = "LoadingUI"
LoadingUI.BackgroundTransparency = 1
LoadingUI.Size = UDim2.new(0, 400, 0, 200) -- Tamaño fijo
LoadingUI.Position = UDim2.new(0.5, -200, 0.5, -100) -- Centrado exacto
LoadingUI.AnchorPoint = Vector2.new(0, 0) -- CAMBIADO: antes era 0.5
LoadingUI.Visible = true
LoadingUI.Parent = ScreenGui

-- Efecto de Rayos Azules (CORREGIDO)
local Rayos = Instance.new("Frame")
Rayos.Name = "RayosAzules"
Rayos.BackgroundTransparency = 1
Rayos.Size = UDim2.new(0, 200, 0, 200) -- Tamaño fijo
Rayos.Position = UDim2.new(0.5, -100, 0.5, -100) -- Centrado dentro del LoadingUI
Rayos.AnchorPoint = Vector2.new(0, 0)
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

-- Crear un círculo para los rayos
local RayosCorner = Instance.new("UICorner")
RayosCorner.CornerRadius = UDim.new(1, 0)
RayosCorner.Parent = Rayos

local RayConnection = RunService.Heartbeat:Connect(function()
    UIGradient.Rotation = tick() * 100
    -- Animación de pulsación
    local scale = 1 + math.sin(tick() * 3) * 0.1
    Rayos.Size = UDim2.new(0, 200 * scale, 0, 200 * scale)
    Rayos.Position = UDim2.new(0.5, -100 * scale, 0.5, -100 * scale)
end)

-- LETRAS (CORREGIDO)
LoadingText.Name = "LoadingText"
LoadingText.BackgroundTransparency = 1
LoadingText.Size = UDim2.new(1, 0, 0.5, 0)
LoadingText.Position = UDim2.new(0.5, 0, 0.6, 0)
LoadingText.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingText.Font = Enum.Font.FredokaOne
LoadingText.TextColor3 = Color3.new(1,1,1)
LoadingText.TextSize = 35 -- Reducido para móvil
LoadingText.TextWrapped = true
LoadingText.Text = "Bienvenidos a\nScripts JoseAngel_Blox"
LoadingText.TextTransparency = 1
LoadingText.TextStrokeTransparency = 0.2
LoadingText.TextStrokeColor3 = Color3.new(0,0,0)
LoadingText.Parent = LoadingUI

-- Efecto arcoíris en el texto
local ColorConnection = RunService.Heartbeat:Connect(function()
    local Hue = (tick() * 0.1) % 1 -- Velocidad más lenta
    LoadingText.TextColor3 = Color3.fromHSV(Hue, 1, 1)
end)

--// ========== MAIN UI CORREGIDO ==========
MainUI.Name = "MainUI"
MainUI.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
MainUI.Size = UDim2.new(0, 320, 0, 420)
MainUI.Position = UDim2.new(0.5, -160, 0.5, -210)
MainUI.AnchorPoint = Vector2.new(0, 0) -- CAMBIADO
MainUI.BorderSizePixel = 0
MainUI.Active = true
MainUI.Draggable = true
MainUI.Visible = false
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

-- Crear un ScrollView para el contenido
local ScrollContainer = Instance.new("ScrollingFrame")
ScrollContainer.Size = UDim2.new(1, 0, 1, -10)
ScrollContainer.Position = UDim2.new(0, 0, 0, 5)
ScrollContainer.BackgroundTransparency = 1
ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollContainer.ScrollBarThickness = 4
ScrollContainer.ScrollBarImageColor3 = Color3.fromRGB(80, 0, 150)
ScrollContainer.Parent = Container

local ScrollLayout = Instance.new("UIListLayout")
ScrollLayout.Padding = UDim.new(0, 8)
ScrollLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ScrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
ScrollLayout.Parent = ScrollContainer

--// FUNCION PARA SECCIONES CLICKABLES (CORREGIDO)
local function CreateCollapsibleSection(name)
    local Section = Instance.new("Frame")
    local SectionTitle = Instance.new("TextButton")
    local SectionContent = Instance.new("Frame")
    local Layout = Instance.new("UIListLayout")

    Section.Name = name.."Section"
    Section.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
    Section.Size = UDim2.new(1, 0, 0, 45)
    Section.ClipsDescendants = true
    Section.Parent = ScrollContainer

    local SecCorner = Instance.new("UICorner")
    SecCorner.CornerRadius = UDim.new(0, 10)
    SecCorner.Parent = Section

    SectionTitle.Name = "SectionTitle"
    SectionTitle.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    SectionTitle.Size = UDim2.new(1, 0, 0, 35)
    SectionTitle.Font = Enum.Font.GothamBold
    SectionTitle.TextColor3 = Color3.new(1,1,1)
    SectionTitle.TextSize = 16
    SectionTitle.Text = name.." ▼"
    SectionTitle.Parent = Section
    SectionTitle.AutoButtonColor = false

    local TitleSecCorner = Instance.new("UICorner")
    TitleSecCorner.CornerRadius = UDim.new(0, 8)
    TitleSecCorner.Parent = SectionTitle

    SectionContent.Name = "Content"
    SectionContent.BackgroundTransparency = 1
    SectionContent.Size = UDim2.new(1, -20, 1, -40)
    SectionContent.Position = UDim2.new(0, 10, 0, 40)
    SectionContent.Visible = false
    SectionContent.Parent = Section

    Layout.Parent = SectionContent
    Layout.Padding = UDim.new(0, 6)
    Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    -- LOGICA DE ABRIR Y CERRAR
    local Open = false
    SectionTitle.MouseButton1Click:Connect(function()
        Open = not Open
        if Open then
            SectionTitle.Text = name.." ▲"
            SectionContent.Visible = true
            local contentSize = #SectionContent:GetChildren() * 38 + 10
            TweenService:Create(Section, TweenInfo.new(0.3), {Size = UDim2.new(1, 0, 0, 45 + contentSize)}):Play()
        else
            SectionTitle.Text = name.." ▼"
            SectionContent.Visible = false
            TweenService:Create(Section, TweenInfo.new(0.3), {Size = UDim2.new(1, 0, 0, 45)}):Play()
        end
        -- Actualizar CanvasSize del ScrollContainer
        task.wait(0.35)
        ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, ScrollContainer:GetChildren()[1].AbsoluteContentSize.Y + 50)
    end)

    return SectionContent
end

--// FUNCION CREAR TOGGLE (MEJORADA)
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
    ToggleButton.AutoButtonColor = false

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
local InfoSection = CreateCollapsibleSection("Info")
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
local AutoSection = CreateCollapsibleSection("Automatización")

--// ========== FUNCIONES MEJORADAS ==========

-- AUTO RECOGER DINERO (MEJORADO)
CreateToggle(AutoSection, "Auto Recoger Dinero", function(state)
    local collecting = false
    if state then
        collecting = true
        coroutine.wrap(function()
            while collecting and state do
                task.wait(0.2)
                pcall(function()
                    local character = Player.Character
                    if not character then return end
                    local hrp = character:FindFirstChild("HumanoidRootPart")
                    if not hrp then return end
                    
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("BasePart") and not obj:IsA("Terrain") then
                            local name = obj.Name:lower()
                            if name:find("money") or name:find("cash") or name:find("drop") or name:find("coin") then
                                if obj:IsA("Part") then
                                    obj.CFrame = hrp.CFrame + Vector3.new(0, 2, 0)
                                end
                            end
                        end
                    end
                end)
            end
        end)()
    else
        collecting = false
    end
end)

-- AUTO CONSTRUIR Y COMPRAR (MEJORADO)
CreateToggle(AutoSection, "Auto Construir", function(state)
    local building = false
    if state then
        building = true
        coroutine.wrap(function()
            while building and state do
                task.wait(0.3)
                pcall(function()
                    -- Buscar en todas las GUI
                    for _, gui in pairs(PlayerGui:GetChildren()) do
                        for _, button in pairs(gui:GetDescendants()) do
                            if button:IsA("TextButton") or button:IsA("ImageButton") then
                                local name = button.Name:lower()
                                if name:find("buy") or name:find("build") or name:find("claim") or name:find("purchase") then
                                    if button.Visible and button.Active then
                                        button:MouseButton1Click()
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end)()
    else
        building = false
    end
end)

-- AUTO MEJORAS (MEJORADO)
CreateToggle(AutoSection, "Auto Mejoras", function(state)
    local upgrading = false
    if state then
        upgrading = true
        coroutine.wrap(function()
            while upgrading and state do
                task.wait(0.5)
                pcall(function()
                    for _, obj in pairs(workspace:GetDescendants()) do
                        if obj:IsA("ClickDetector") then
                            local parentName = obj.Parent and obj.Parent.Name:lower() or ""
                            if parentName:find("upgrade") or parentName:find("improve") or parentName:find("mejora") then
                                fireclickdetector(obj)
                            end
                        end
                    end
                end)
            end
        end)()
    else
        upgrading = false
    end
end)

-- VELOCIDAD (MEJORADO)
CreateToggle(MainSection, "Velocidad Extra", function(state)
    local function setSpeed()
        local char = Player.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = state and 60 or 16
            end
        end
    end
    
    setSpeed()
    
    -- Evento para cuando el personaje se añade
    local connection
    connection = Player.CharacterAdded:Connect(function()
        task.wait(0.1)
        setSpeed()
    end)
    
    if not state then
        connection:Disconnect()
    end
end)

--// ========== SECUENCIA DE CARGA ==========

-- MOSTRAR ANIMACION
LoadingText.TextTransparency = 0
TweenService:Create(LoadingText, TweenInfo.new(1.2, Enum.EasingStyle.Elastic), {TextTransparency = 0, TextSize = 45}):Play()

-- ESPERAR 4 SEGUNDOS
task.wait(4)

-- DESAPARECER ANIMACION CON EFECTO
TweenService:Create(LoadingUI, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 50, 0, 50),
    Position = UDim2.new(0.5, -25, 0.5, -25)
}):Play()

-- Desconectar conexiones de animación
RayConnection:Disconnect()
ColorConnection:Disconnect()

task.wait(0.8)
LoadingUI:Destroy()

-- APARECER MENU CON ANIMACION
MainUI.Visible = true
MainUI.Size = UDim2.new(0, 300, 0, 380)
MainUI.Position = UDim2.new(0.5, -150, 0.5, -190)

-- Animación de entrada
local TweenOpen = TweenService:Create(MainUI, TweenInfo.new(0.7, Enum.EasingStyle.Back), {
    Size = UDim2.new(0, 320, 0, 420),
    Position = UDim2.new(0.5, -160, 0.5, -210)
})
TweenOpen:Play()

print("✅ Script Cargado Perfecto - Mansion Tycoon v1.0")
