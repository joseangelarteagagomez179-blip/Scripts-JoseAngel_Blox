-- // Script Creado por JoseAngel_Blox
-- // Juego: +1 Speed keyboard Escape-Candy-Chocolate

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

-- === LIMPIAR SI EXISTE ===
if PlayerGui:FindFirstChild("MenuSpeed") then PlayerGui.MenuSpeed:Destroy() end
if PlayerGui:FindFirstChild("BotonBurbuja") then PlayerGui.BotonBurbuja:Destroy() end

-- === 🌟 BURBUJA FLOTANTE ===
local Burbuja = Instance.new("TextButton")
local BurbujaCorner = Instance.new("UICorner")
local BurbujaGradient = Instance.new("UIGradient")

Burbuja.Name = "BotonBurbuja"
Burbuja.Parent = PlayerGui
Burbuja.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Burbuja.Size = UDim2.new(0, 60, 0, 60)
Burbuja.Position = UDim2.new(0.02, 0, 0.1, 0)
Burbuja.Font = Enum.Font.GothamBold
Burbuja.Text = "SCRIPT"
Burbuja.TextColor3 = Color3.new(1, 1, 1)
Burbuja.TextSize = 12
Burbuja.ZIndexBehavior = Enum.ZIndexBehavior.Global

BurbujaCorner.CornerRadius = UDim.new(1, 0)
BurbujaCorner.Parent = Burbuja

BurbujaGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.new(0.5, 0, 1)),
    ColorSequenceKeypoint.new(1, Color3.new(0.2, 0, 0.4))
}
BurbujaGradient.Rotation = 45
BurbujaGradient.Parent = Burbuja

-- === VENTANA PRINCIPAL ===
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIGradient = Instance.new("UIGradient")
local Title = Instance.new("TextLabel")

ScreenGui.Name = "MenuSpeed"
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.new(0.05, 0.05, 0.08)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -210) -- CENTRADO EXACTO
MainFrame.Size = UDim2.new(0, 320, 0, 420)
MainFrame.Visible = false

UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.new(0.4, 0, 0.8)),
    ColorSequenceKeypoint.new(1, Color3.new(0.1, 0, 0.3))
}
UIGradient.Rotation = 45
UIGradient.Parent = MainFrame

-- TITULO
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 5)
Title.Font = Enum.Font.GothamBold
Title.Text = "+1 Speed keyboard Escape-Candy-Chocolate"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 14
Title.TextWrapped = true
Title.TextStrokeTransparency = 0.5
Title.TextStrokeColor3 = Color3.new(0.6, 0, 1)

-- === FUNCION CREAR OPCIONES ===
local function CrearOpcion(nombre, posY, tieneBoton)
    local Container = Instance.new("Frame")
    local Label = Instance.new("TextLabel")
    local Toggle = Instance.new("TextButton")
    local UICornerBtn = Instance.new("UICorner")
    local Line = Instance.new("Frame")

    Container.Name = "Container"
    Container.Parent = MainFrame
    Container.BackgroundTransparency = 1
    Container.Size = UDim2.new(1, -20, 0, 35)
    Container.Position = UDim2.new(0, 10, 0, posY)

    Label.Name = "Label"
    Label.Parent = Container
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 5, 0, 0)
    Label.Font = Enum.Font.Gotham
    Label.Text = nombre
    Label.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left

    if tieneBoton then
        Toggle.Name = "Toggle"
        Toggle.Parent = Container
        Toggle.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        Toggle.Size = UDim2.new(0, 50, 0, 25)
        Toggle.Position = UDim2.new(0.8, 0, 0.5, -12)
        Toggle.Font = Enum.Font.GothamBold
        Toggle.Text = "OFF"
        Toggle.TextColor3 = Color3.new(1, 0.3, 0.3)
        Toggle.TextSize = 12

        UICornerBtn.CornerRadius = UDim.new(0, 10)
        UICornerBtn.Parent = Toggle

        Toggle.MouseButton1Click:Connect(function()
            if Toggle.Text == "OFF" then
                Toggle.Text = "ON"
                Toggle.TextColor3 = Color3.new(0.3, 1, 0.5)
                Toggle.BackgroundColor3 = Color3.new(0.2, 0.4, 0.2)
            else
                Toggle.Text = "OFF"
                Toggle.TextColor3 = Color3.new(1, 0.3, 0.3)
                Toggle.BackgroundColor3 = Color3.new(0.3, 0.2, 0.2)
            end
        end)
    end

    Line.Parent = Container
    Line.BackgroundColor3 = Color3.new(0.2, 0.2, 0.25)
    Line.BorderSizePixel = 0
    Line.Size = UDim2.new(1, 0, 0, 1)
    Line.Position = UDim2.new(0, 0, 1, -1)

    return Container
end

-- === SECCION INFO ===
local InfoContainer = CrearOpcion("Info ↓", 50, false)
local InfoContent = Instance.new("Frame")
InfoContent.Name = "InfoContent"
InfoContent.Parent = MainFrame
InfoContent.BackgroundTransparency = 1
InfoContent.Size = UDim2.new(1, -40, 0, 180)
InfoContent.Position = UDim2.new(0, 20, 0, 85)
InfoContent.Visible = false

-- Datos
local CreadorText = Instance.new("TextLabel")
CreadorText.Parent = InfoContent
CreadorText.BackgroundTransparency = 1
CreadorText.Size = UDim2.new(1, 0, 0, 25)
CreadorText.Position = UDim2.new(0, 0, 0, 0)
CreadorText.Font = Enum.Font.GothamBold
CreadorText.Text = "• Creador: JoseAngel_Blox"
CreadorText.TextColor3 = Color3.new(0.7, 0.7, 1)
CreadorText.TextSize = 12

local FechaText = Instance.new("TextLabel")
FechaText.Parent = InfoContent
FechaText.BackgroundTransparency = 1
FechaText.Size = UDim2.new(1, 0, 0, 25)
FechaText.Position = UDim2.new(0, 0, 0, 25)
FechaText.Font = Enum.Font.GothamBold
FechaText.Text = "• Creado: 23/06/2026"
FechaText.TextColor3 = Color3.new(0.7, 0.7, 1)
FechaText.TextSize = 12

-- Bienvenida y Manual
local BienvenidaTitle = Instance.new("TextLabel")
BienvenidaTitle.Parent = InfoContent
BienvenidaTitle.BackgroundTransparency = 1
BienvenidaTitle.Size = UDim2.new(1, 0, 0, 20)
BienvenidaTitle.Position = UDim2.new(0, 0, 0, 60)
BienvenidaTitle.Font = Enum.Font.GothamBold
BienvenidaTitle.Text = "📢 BIENVENIDA"
BienvenidaTitle.TextColor3 = Color3.new(1, 0.8, 0)
BienvenidaTitle.TextSize = 13

local BienvenidaText = Instance.new("TextLabel")
BienvenidaText.Parent = InfoContent
BienvenidaText.BackgroundTransparency = 1
BienvenidaText.Size = UDim2.new(1, 0, 0, 40)
BienvenidaText.Position = UDim2.new(0, 0, 0, 80)
BienvenidaText.Font = Enum.Font.Gotham
BienvenidaText.Text = "Hola! Bienvenido al Script de JoseAngel_Blox. Este script te ayudará a ser el mejor y tener todo desbloqueado. ¡Disfrútalo!"
BienvenidaText.TextColor3 = Color3.new(0.9, 0.9, 0.9)
BienvenidaText.TextSize = 11
BienvenidaText.TextWrapped = true

local ManualTitle = Instance.new("TextLabel")
ManualTitle.Parent = InfoContent
ManualTitle.BackgroundTransparency = 1
ManualTitle.Size = UDim2.new(1, 0, 0, 20)
ManualTitle.Position = UDim2.new(0, 0, 0, 125)
ManualTitle.Font = Enum.Font.GothamBold
ManualTitle.Text = "📖 MANUAL"
ManualTitle.TextColor3 = Color3.new(1, 0.8, 0)
ManualTitle.TextSize = 13

local ManualText = Instance.new("TextLabel")
ManualText.Parent = InfoContent
ManualText.BackgroundTransparency = 1
ManualText.Size = UDim2.new(1, 0, 0, 50)
ManualText.Position = UDim2.new(0, 0, 0, 145)
ManualText.Font = Enum.Font.Gotham
ManualText.Text = "Usa Auto Farm para subir rápido, ajusta tu velocidad y usa Free Shop para tener todas las caminadoras, rastros y auras GRATIS."
ManualText.TextColor3 = Color3.new(0.9, 0.9, 0.9)
ManualText.TextSize = 11
ManualText.TextWrapped = true

InfoContainer.Label.MouseButton1Click:Connect(function()
    InfoContent.Visible = not InfoContent.Visible
    InfoContainer.Label.Text = InfoContent.Visible and "Info ↑" or "Info ↓"
end)

-- === SECCION MAIN ===
local MainContainer = CrearOpcion("Main ↓", 240, false)
local MainContent = Instance.new("Frame")
MainContent.Name = "MainContent"
MainContent.Parent = MainFrame
MainContent.BackgroundTransparency = 1
MainContent.Size = UDim2.new(1, -40, 0, 80)
MainContent.Position = UDim2.new(0, 20, 0, 275)
MainContent.Visible = false

local AutoFarmOption = CrearOpcion("Auto farm con velocidad ajustable", 280, true)
AutoFarmOption.Parent = MainContent
AutoFarmOption.Position = UDim2.new(0, 0, 0, 0)

local WalkSpeedOption = CrearOpcion("Walk speed velocidad ajustable", 315, true)
WalkSpeedOption.Parent = MainContent
WalkSpeedOption.Position = UDim2.new(0, 0, 0, 35)

MainContainer.Label.MouseButton1Click:Connect(function()
    MainContent.Visible = not MainContent.Visible
    MainContainer.Label.Text = MainContent.Visible and "Main ↑" or "Main ↓"
end)

-- === SECCION FREE SHOP ===
local ShopContainer = CrearOpcion("Free Shop Ítems ↓", 360, false)
local ShopContent = Instance.new("Frame")
ShopContent.Name = "ShopContent"
ShopContent.Parent = MainFrame
ShopContent.BackgroundTransparency = 1
ShopContent.Size = UDim2.new(1, -40, 0, 115)
ShopContent.Position = UDim2.new(0, 20, 0, 395)
ShopContent.Visible = false

local CaminadorasOption = CrearOpcion("Desbloquear todas las caminadoras", 400, true)
CaminadorasOption.Parent = ShopContent
CaminadorasOption.Position = UDim2.new(0, 0, 0, 0)

local RastrosOption = CrearOpcion("Desbloquear todos los rastros", 435, true)
RastrosOption.Parent = ShopContent
RastrosOption.Position = UDim2.new(0, 0, 0, 35)

local AurasOption = CrearOpcion("Desbloquear todas las auras", 470, true)
AurasOption.Parent = ShopContent
AurasOption.Position = UDim2.new(0, 0, 0, 70)

ShopContainer.Label.MouseButton1Click:Connect(function()
    ShopContent.Visible = not ShopContent.Visible
    ShopContainer.Label.Text = ShopContent.Visible and "Free Shop Ítems ↑" or "Free Shop Ítems ↓"
end)

-- === ABRIR / CERRAR ===
Burbuja.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- === MOVER BURBUJA ===
local function HacerArrastrable(objeto)
    local dragging, dragStart, startPos
    objeto.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = objeto.Position
        end
    end)
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging then
            local delta = input.Position - dragStart
            objeto.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

HacerArrastrable(MainFrame)
HacerArrastrable(Burbuja)

print("✅ SCRIPT CARGADO EXITOSAMENTE!")
