-- // Script Creado por Ti
-- // Nombre: +1 Speed keyboard Escape-Candy-Chocolate

local Player = game.Players.LocalPlayer
local PlayerGui = Player.PlayerGui

-- === ELIMINAR SI EXISTE ===
if PlayerGui:FindFirstChild("MenuSpeed") then
    PlayerGui.MenuSpeed:Destroy()
end

-- === CREAR LA VENTANA ===
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIGradient = Instance.new("UIGradient")
local Title = Instance.new("TextLabel")

ScreenGui.Name = "MenuSpeed"
ScreenGui.Parent = PlayerGui

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.03, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 320, 0, 420)

-- Bordes redondos
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Borde color morado/neón
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(130, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 0, 90))
}
UIGradient.Rotation = 45
UIGradient.Parent = MainFrame

-- TÍTULO
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Position = UDim2.new(0, 0, 0, 5)
Title.Font = Enum.Font.GothamBold
Title.Text = "+1 Speed keyboard Escape-Candy-Chocolate"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.TextWrapped = true
Title.TextStrokeTransparency = 0.5
Title.TextStrokeColor3 = Color3.fromRGB(150, 0, 255)

-- === FUNCIÓN PARA CREAR OPCIONES ===
local function CrearOpcion(nombre, posY, tieneBoton)
    local Container = Instance.new("Frame")
    local Label = Instance.new("TextLabel")
    local Toggle = Instance.new("TextButton")
    local UICornerBtn = Instance.new("UICorner")

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
    Label.TextColor3 = Color3.fromRGB(220, 220, 220)
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left

    if tieneBoton then
        Toggle.Name = "Toggle"
        Toggle.Parent = Container
        Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        Toggle.Size = UDim2.new(0, 50, 0, 25)
        Toggle.Position = UDim2.new(0.8, 0, 0.5, -12)
        Toggle.Font = Enum.Font.GothamBold
        Toggle.Text = "OFF"
        Toggle.TextColor3 = Color3.fromRGB(255, 80, 80)
        Toggle.TextSize = 12

        UICornerBtn.CornerRadius = UDim.new(0, 10)
        UICornerBtn.Parent = Toggle

        Toggle.MouseButton1Click:Connect(function()
            if Toggle.Text == "OFF" then
                Toggle.Text = "ON"
                Toggle.TextColor3 = Color3.fromRGB(80, 255, 120)
                Toggle.BackgroundColor3 = Color3.fromRGB(60, 100, 60)
            else
                Toggle.Text = "OFF"
                Toggle.TextColor3 = Color3.fromRGB(255, 80, 80)
                Toggle.BackgroundColor3 = Color3.fromRGB(60, 40, 40)
            end
        end)
    end
    return Container
end

-- === 1) SECCION INFO ===
local InfoContainer = CrearOpcion("Info ↓", 50, false)

local InfoContent = Instance.new("Frame")
InfoContent.Name = "InfoContent"
InfoContent.Parent = MainFrame
InfoContent.BackgroundTransparency = 1
InfoContent.Size = UDim2.new(1, -40, 0, 180) -- Aumenté el tamaño para que entre todo
InfoContent.Position = UDim2.new(0, 20, 0, 85)
InfoContent.Visible = false

-- Datos del creador
local CreadorText = Instance.new("TextLabel")
CreadorText.Parent = InfoContent
CreadorText.BackgroundTransparency = 1
CreadorText.Size = UDim2.new(1, 0, 0, 25)
CreadorText.Position = UDim2.new(0, 0, 0, 0)
CreadorText.Font = Enum.Font.GothamBold
CreadorText.Text = "• Nombre del Creador: JoseAngel_Blox"
CreadorText.TextColor3 = Color3.fromRGB(180, 180, 255)
CreadorText.TextSize = 12
CreadorText.TextXAlignment = Enum.TextXAlignment.Left

local FechaText = Instance.new("TextLabel")
FechaText.Parent = InfoContent
FechaText.BackgroundTransparency = 1
FechaText.Size = UDim2.new(1, 0, 0, 25)
FechaText.Position = UDim2.new(0, 0, 0, 20)
FechaText.Font = Enum.Font.GothamBold
FechaText.Text = "• Fecha de Creación: 23/06/2026"
FechaText.TextColor3 = Color3.fromRGB(180, 180, 255)
FechaText.TextSize = 12
FechaText.TextXAlignment = Enum.TextXAlignment.Left

-- BIENVENIDA Y MANUAL
local BienvenidaTitle = Instance.new("TextLabel")
BienvenidaTitle.Parent = InfoContent
BienvenidaTitle.BackgroundTransparency = 1
BienvenidaTitle.Size = UDim2.new(1, 0, 0, 20)
BienvenidaTitle.Position = UDim2.new(0, 0, 0, 50)
BienvenidaTitle.Font = Enum.Font.GothamBold
BienvenidaTitle.Text = "📢 BIENVENIDA"
BienvenidaTitle.TextColor3 = Color3.fromRGB(255, 200, 0)
BienvenidaTitle.TextSize = 13
BienvenidaTitle.TextXAlignment = Enum.TextXAlignment.Left

local BienvenidaText = Instance.new("TextLabel")
BienvenidaText.Parent = InfoContent
BienvenidaText.BackgroundTransparency = 1
BienvenidaText.Size = UDim2.new(1, 0, 0, 40)
BienvenidaText.Position = UDim2.new(0, 0, 0, 70)
BienvenidaText.Font = Enum.Font.Gotham
BienvenidaText.Text = "Hola a todos Bienvenido(a) al Script JoseAngel_Blox. Este scripts tiene la posibilidad de hacerte pro y rico en el juego espero y disfrutes mucho el Script"
BienvenidaText.TextColor3 = Color3.fromRGB(230, 230, 230)
BienvenidaText.TextSize = 11
BienvenidaText.TextWrapped = true
BienvenidaText.TextXAlignment = Enum.TextXAlignment.Left

local ManualTitle = Instance.new("TextLabel")
ManualTitle.Parent = InfoContent
ManualTitle.BackgroundTransparency = 1
ManualTitle.Size = UDim2.new(1, 0, 0, 20)
ManualTitle.Position = UDim2.new(0, 0, 0, 115)
ManualTitle.Font = Enum.Font.GothamBold
ManualTitle.Text = "📖 MANUAL"
ManualTitle.TextColor3 = Color3.fromRGB(255, 200, 0)
ManualTitle.TextSize = 13
ManualTitle.TextXAlignment = Enum.TextXAlignment.Left

local ManualText = Instance.new("TextLabel")
ManualText.Parent = InfoContent
ManualText.BackgroundTransparency = 1
ManualText.Size = UDim2.new(1, 0, 0, 60)
ManualText.Position = UDim2.new(0, 0, 0, 135)
ManualText.Font = Enum.Font.Gotham
ManualText.Text = "Este Script es sencillo de usar: tiene Auto Farm para velocidad infinita y velocidad ajustable, Walkspeed velocidad ajustable, y tiene Free Shop Ítems. Esta opción te da la posibilidad y la oportunidad de desbloquear todo de la tienda como las caminadoras, los Rastros y las Auras."
ManualText.TextColor3 = Color3.fromRGB(230, 230, 230)
ManualText.TextSize = 11
ManualText.TextWrapped = true
ManualText.TextXAlignment = Enum.TextXAlignment.Left

InfoContainer.Label.MouseButton1Click:Connect(function()
    InfoContent.Visible = not InfoContent.Visible
    InfoContainer.Label.Text = InfoContent.Visible and "Info ↑" or "Info ↓"
end)

-- === 2) SECCION MAIN ===
local MainContainer = CrearOpcion("Main ↓", 240, false) -- Bajé la posición

local MainContent = Instance.new("Frame")
MainContent.Name = "MainContent"
MainContent.Parent = MainFrame
MainContent.BackgroundTransparency = 1
MainContent.Size = UDim2.new(1, -40, 0, 80)
MainContent.Position = UDim2.new(0, 20, 0, 275)
MainContent.Visible = false

-- Opcion Auto Farm
local AutoFarmOption = CrearOpcion("Auto farm con velocidad ajustable", 280, true)
AutoFarmOption.Parent = MainContent
AutoFarmOption.Position = UDim2.new(0, 0, 0, 0)

-- Opcion Walk Speed
local WalkSpeedOption = CrearOpcion("Walk speed velocidad ajustable", 315, true)
WalkSpeedOption.Parent = MainContent
WalkSpeedOption.Position = UDim2.new(0, 0, 0, 35)

MainContainer.Label.MouseButton1Click:Connect(function()
    MainContent.Visible = not MainContent.Visible
    MainContainer.Label.Text = MainContent.Visible and "Main ↑" or "Main ↓"
end)

-- === 3) SECCION FREE SHOP ITEMS ===
local ShopContainer = CrearOpcion("Free Shop Ítems ↓", 360, false) -- Bajé la posición

local ShopContent = Instance.new("Frame")
ShopContent.Name = "ShopContent"
ShopContent.Parent = MainFrame
ShopContent.BackgroundTransparency = 1
ShopContent.Size = UDim2.new(1, -40, 0, 115)
ShopContent.Position = UDim2.new(0, 20, 0, 395)
ShopContent.Visible = false

-- Opcion Caminadoras
local CaminadorasOption = CrearOpcion("Desbloquear todas las caminadoras", 400, true)
CaminadorasOption.Parent = ShopContent
CaminadorasOption.Position = UDim2.new(0, 0, 0, 0)

-- Opcion Rastros
local RastrosOption = CrearOpcion("Desbloquear todos los rastros", 435, true)
RastrosOption.Parent = ShopContent
RastrosOption.Position = UDim2.new(0, 0, 0, 35)

-- Opcion Auras
local AurasOption = CrearOpcion("Desbloquear todas las auras", 470, true)
AurasOption.Parent = ShopContent
AurasOption.Position = UDim2.new(0, 0, 0, 70)

ShopContainer.Label.MouseButton1Click:Connect(function()
    ShopContent.Visible = not ShopContent.Visible
    ShopContainer.Label.Text = ShopContent.Visible and "Free Shop Ítems ↑" or "Free Shop Ítems ↓"
end)

-- === HACERLO ARRASTRABLE ===
local Dragging = nil
local DragStart = nil
local StartPos = nil

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = true
        DragStart = input.Position
        StartPos = MainFrame.Position
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if Dragging then
        local Delta = input.Position - DragStart
        MainFrame.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = false
    end
end)

print("✅ Menu completo con Manual y Bienvenida!")
