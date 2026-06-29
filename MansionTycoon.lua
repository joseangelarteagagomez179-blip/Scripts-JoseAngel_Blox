--// Services
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local PlayerGui = Players.LocalPlayer.PlayerGui

--// Variables
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleBar = Instance.new("Frame")
local TitleText = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local MinimizeButton = Instance.new("TextButton")
local Container = Instance.new("Frame")
local BackgroundEffect = Instance.new("Frame")
local UIGradient = Instance.new("UIGradient")

--// == ANIMACIÓN DE BIENVENIDA (SOLO LETRAS RGB) ==
local WelcomeText = Instance.new("TextLabel")
WelcomeText.Parent = PlayerGui
WelcomeText.BackgroundTransparency = 1
WelcomeText.Size = UDim2.new(1, 0, 1, 0)
WelcomeText.Font = Enum.Font.GothamBold
WelcomeText.Text = "Bienvenidos a Scripts JoseAngel_Blox"
WelcomeText.TextColor3 = Color3.new(1,1,1)
WelcomeText.TextSize = 50
WelcomeText.TextTransparency = 1
WelcomeText.TextStrokeTransparency = 0.5
WelcomeText.ZIndex = 10

-- Efecto RGB Giratorio
local hue = 0
local RGBLoop
RGBLoop = RunService.Heartbeat:Connect(function()
    hue = hue + 0.01
    if hue > 1 then hue = 0 end
    WelcomeText.TextColor3 = Color3.fromHSV(hue, 0.7, 1)
end)

-- Animación de entrada y salida
local TweenInfo = TweenInfo.new(1.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
local FadeIn = TweenService:Create(WelcomeText, TweenInfo, {TextTransparency = 0, TextStrokeTransparency = 0})
local FadeOut = TweenService:Create(WelcomeText, TweenInfo, {TextTransparency = 1, TextStrokeTransparency = 1})

FadeIn:Play()
task.wait(3.5)
FadeOut:Play()
task.wait(1.2)
RGBLoop:Disconnect() -- Detener colores
WelcomeText:Destroy()

--// == CREACIÓN DE LA INTERFAZ PRINCIPAL ==
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame (Pequeño y Redondeado)
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Size = UDim2.new(0, 420, 0, 500) -- Tamaño más pequeño
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -250)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.ClipsDescendants = true

-- Esquinas Redondeadas
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0,18)
Corner.Parent = MainFrame

-- Fondo con Efecto Neón Movimiento
BackgroundEffect.Parent = MainFrame
BackgroundEffect.BackgroundColor3 = Color3.fromRGB(25,25,25)
BackgroundEffect.Size = UDim2.new(1.5,0,1.5,0)
BackgroundEffect.Position = UDim2.new(-0.25,0,-0.25,0)
BackgroundEffect.ZIndex = 0
local bgCorner = Instance.new("UICorner")
bgCorner.CornerRadius = UDim.new(0,18)
bgCorner.Parent = BackgroundEffect

UIGradient.Parent = BackgroundEffect
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 0))
}
UIGradient.Rotation = 45

-- Animar fondo
spawn(function()
    while wait(0.05) do
        UIGradient.Rotation = UIGradient.Rotation + 5
    end
end)

-- Barra de Titulo
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(20,20,20)
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.ZIndex = 2
local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0,18)
titleCorner.Parent = TitleBar

TitleText.Parent = TitleBar
TitleText.BackgroundTransparency = 1
TitleText.Size = UDim2.new(0.6, 0, 1, 0)
TitleText.Position = UDim2.new(0.2, 0, 0, 0)
TitleText.Font = Enum.Font.GothamBold
TitleText.Text = "🏠 Mansion Tycoon"
TitleText.TextColor3 = Color3.new(1,1,1)
TitleText.TextSize = 18
TitleText.ZIndex = 3

-- Boton Minimizar
MinimizeButton = Instance.new("TextButton")
MinimizeButton.Parent = TitleBar
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 180, 0)
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -75, 0, 5)
MinimizeButton.Text = "_"
MinimizeButton.TextColor3 = Color3.new(0,0,0)
MinimizeButton.Font = Enum.Font.GothamBold
local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0,6)
minCorner.Parent = MinimizeButton

-- Boton Cerrar
CloseButton.Parent = TitleBar
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.new(1,1,1)
CloseButton.Font = Enum.Font.GothamBold
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0,6)
closeCorner.Parent = CloseButton

-- Contenedor Principal
Container.Parent = MainFrame
Container.BackgroundTransparency = 1
Container.Size = UDim2.new(1, -20, 1, -60)
Container.Position = UDim2.new(0, 10, 0, 45)
Container.ZIndex = 2

--// == FUNCION DE ARRASTRE ==
local Dragging = false
local DragStart, StartPos = nil, nil
local Minimized = false

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = true
        DragStart = input.Position
        StartPos = MainFrame.Position
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local Delta = input.Position - DragStart
        MainFrame.Position = UDim2.new(StartPos.X.Scale, StartPos.X.X + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)
    end
end)

MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = false
    end
end)

-- Minimizar / Maximizar
MinimizeButton.MouseButton1Click:Connect(function()
    Minimized = not Minimized
    if Minimized then
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0,420,0,40)}):Play()
        Container.Visible = false
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0,420,0,500)}):Play()
        Container.Visible = true
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    MainFrame:Destroy()
end)

--// == SECCIONES DESPLEGABLES ==

-- === SECCION INFO ===
local InfoSection = Instance.new("Frame")
InfoSection.Parent = Container
InfoSection.BackgroundColor3 = Color3.fromRGB(30,30,30)
InfoSection.Size = UDim2.new(1, 0, 0, 45)
InfoSection.Position = UDim2.new(0,0,0,0)
local infoCorner = Instance.new("UICorner")
infoCorner.CornerRadius = UDim.new(0,10)
infoCorner.Parent = InfoSection

local InfoArrow = Instance.new("TextButton")
InfoArrow.Parent = InfoSection
InfoArrow.BackgroundTransparency = 1
InfoArrow.Size = UDim2.new(1,0,1,0)
InfoArrow.Text = "ℹ️ INFORMACIÓN ▼"
InfoArrow.TextColor3 = Color3.new(1,1,1)
InfoArrow.Font = Enum.Font.GothamBold
InfoArrow.TextSize = 16

local InfoContent = Instance.new("Frame")
InfoContent.Parent = Container
InfoContent.BackgroundColor3 = Color3.fromRGB(25,25,25)
InfoContent.Size = UDim2.new(1, 0, 0, 80)
InfoContent.Position = UDim2.new(0,0,0,50)
InfoContent.Visible = false
local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0,10)
contentCorner.Parent = InfoContent

local CreatorTxt = Instance.new("TextLabel")
CreatorTxt.Parent = InfoContent
CreatorTxt.BackgroundTransparency = 1
CreatorTxt.Size = UDim2.new(1,-20,0,35)
CreatorTxt.Position = UDim2.new(0,10,0,5)
CreatorTxt.Text = "👨‍💻 Creador: JoseAngel_Blox"
CreatorTxt.TextColor3 = Color3.new(1,1,1)
CreatorTxt.Font = Enum.Font.GothamBold
CreatorTxt.TextXAlignment = Enum.TextXAlignment.Left

local DateTxt = Instance.new("TextLabel")
DateTxt.Parent = InfoContent
DateTxt.BackgroundTransparency = 1
DateTxt.Size = UDim2.new(1,-20,0,35)
DateTxt.Position = UDim2.new(0,10,0,40)
DateTxt.Text = "📅 Fecha: 29/06/2026"
DateTxt.TextColor3 = Color3.new(1,1,1)
DateTxt.Font = Enum.Font.GothamBold
DateTxt.TextXAlignment = Enum.TextXAlignment.Left

-- === SECCION MAIN ===
local MainSection = Instance.new("Frame")
MainSection.Parent = Container
MainSection.BackgroundColor3 = Color3.fromRGB(30,30,30)
MainSection.Size = UDim2.new(1, 0, 0, 45)
MainSection.Position = UDim2.new(0,0,0,140)
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0,10)
mainCorner.Parent = MainSection

local MainArrow = Instance.new("TextButton")
MainArrow.Parent = MainSection
MainArrow.BackgroundTransparency = 1
MainArrow.Size = UDim2.new(1,0,1,0)
MainArrow.Text = "🎮 FUNCIONES ▼"
MainArrow.TextColor3 = Color3.new(1,1,1)
MainArrow.Font = Enum.Font.GothamBold
MainArrow.TextSize = 16

local MainContent = Instance.new("Frame")
MainContent.Parent = Container
MainContent.BackgroundColor3 = Color3.fromRGB(25,25,25)
MainContent.Size = UDim2.new(1, 0, 0, 280)
MainContent.Position = UDim2.new(0,0,0,190)
MainContent.Visible = false
local mainContCorner = Instance.new("UICorner")
mainContCorner.CornerRadius = UDim.new(0,10)
mainContCorner.Parent = MainContent

--// == LOGICA DE ABRIR/CERRAR ==
local InfoOpen = false
InfoArrow.MouseButton1Click:Connect(function()
    InfoOpen = not InfoOpen
    InfoContent.Visible = InfoOpen
    InfoArrow.Text = InfoOpen and "ℹ️ INFORMACIÓN ▲" or "ℹ️ INFORMACIÓN ▼"
end)

local MainOpen = false
MainArrow.MouseButton1Click:Connect(function()
    MainOpen = not MainOpen
    MainContent.Visible = MainOpen
    MainArrow.Text = MainOpen and "🎮 FUNCIONES ▲" or "🎮 FUNCIONES ▼"
end)

--// == BOTONES TOGGLE (INTERRUPTORES) ==
local function CreateToggle(name, posY)
    local ButtonFrame = Instance.new("Frame")
    ButtonFrame.Parent = MainContent
    ButtonFrame.BackgroundColor3 = Color3.fromRGB(35,35,35)
    ButtonFrame.Size = UDim2.new(1, -10, 0, 40)
    ButtonFrame.Position = UDim2.new(0, 5, 0, posY)
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0,8)
    btnCorner.Parent = ButtonFrame

    local Label = Instance.new("TextLabel")
    Label.Parent = ButtonFrame
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0.05,0,0,0)
    Label.Text = name
    Label.TextColor3 = Color3.new(1,1,1)
    Label.Font = Enum.Font.GothamBold
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local Toggle = Instance.new("TextButton")
    Toggle.Parent = ButtonFrame
    Toggle.BackgroundColor3 = Color3.fromRGB(80,80,80)
    Toggle.Size = UDim2.new(0, 50, 0, 25)
    Toggle.Position = UDim2.new(0.9, -55, 0.5, -12)
    Toggle.Text = ""
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0,50)
    toggleCorner.Parent = Toggle

    local Knob = Instance.new("Frame")
    Knob.Parent = Toggle
    Knob.BackgroundColor3 = Color3.new(1,1,1)
    Knob.Size = UDim2.new(0, 20, 0, 20)
    Knob.Position = UDim2.new(0, 3, 0, 2.5)
    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(0,50)
    knobCorner.Parent = Knob

    local Enabled = false

    Toggle.MouseButton1Click:Connect(function()
        Enabled = not Enabled
        if Enabled then
            TweenService:Create(Toggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0,200,100)}):Play()
            TweenService:Create(Knob, TweenInfo.new(0.2), {Position = UDim2.new(0, 27, 0, 2.5)}):Play()
            -- AQUI IRIA LA FUNCION ACTIVADA
            print(name .. " ACTIVADO")
        else
            TweenService:Create(Toggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80,80,80)}):Play()
            TweenService:Create(Knob, TweenInfo.new(0.2), {Position = UDim2.new(0, 3, 0, 2.5)}):Play()
            -- AQUI IRIA LA FUNCION DESACTIVADA
            print(name .. " DESACTIVADO")
        end
    end)
end

-- CREAR FUNCIONES (Aqui puedes agregar cuantas quieras)
CreateToggle("Auto Farm Dinero", 10)
CreateToggle("Auto Construir", 60)
CreateToggle("Velocidad Rapida", 110)
CreateToggle("Fly / Volar", 160)
CreateToggle("Auto Recoger Items", 210)

print("✅ Script JoseAngel_Blox - Listo!")
