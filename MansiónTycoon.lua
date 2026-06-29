--// Services
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

--// Variables Principales
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local Container = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local WelcomeText = Instance.new("TextLabel")

--// Pestañas
local TabInfo = Instance.new("TextButton")
local TabMain = Instance.new("TextButton")

--// Contenido de las Pestañas
local PageInfo = Instance.new("Frame")
local PageMain = Instance.new("Frame")

--// Propiedades de la GUI
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "MansionTycoonHub"

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MainFrame.Size = UDim2.new(0, 600, 0, 400) -- Tamaño cuadrado y ancho
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
MainFrame.Active = true
MainFrame.Draggable = true -- Hace que se pueda deslizar/mover

UICorner.CornerRadius = UDim.new(0, 15) -- Esquinas bien redondeadas
UICorner.Parent = MainFrame

--// Título
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Font = Enum.Font.GothamBold
Title.Text = "🏰 Mansion Tycoon Script"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 22

local TitleCorner = Instance.new("UICorner", Title)
TitleCorner.CornerRadius = UDim.new(0,15)

--// Pestañas
TabInfo.Name = "TabInfo"
TabInfo.Parent = MainFrame
TabInfo.Position = UDim2.new(0, 10, 0, 60)
TabInfo.Size = UDim2.new(0, 100, 0, 30)
TabInfo.Text = "ℹ️ Info"
TabInfo.BackgroundColor3 = Color3.fromRGB(70, 150, 255)
TabInfo.TextColor3 = Color3.new(1,1,1)
TabInfo.Font = Enum.Font.GothamBold

TabMain.Name = "TabMain"
TabMain.Parent = MainFrame
TabMain.Position = UDim2.new(0, 120, 0, 60)
TabMain.Size = UDim2.new(0, 100, 0, 30)
TabMain.Text = "🚀 Main"
TabMain.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
TabMain.TextColor3 = Color3.new(1,1,1)
TabMain.Font = Enum.Font.GothamBold

--// Contenedor de páginas
Container.Name = "Container"
Container.Parent = MainFrame
Container.Position = UDim2.new(0, 10, 0, 100)
Container.Size = UDim2.new(1, -20, 1, -110)
Container.BackgroundTransparency = 1

--// Página INFO
PageInfo.Name = "PageInfo"
PageInfo.Parent = Container
PageInfo.Size = UDim2.new(1, 0, 1, 0)
PageInfo.BackgroundTransparency = 1

local InfoText = Instance.new("TextLabel", PageInfo)
InfoText.Size = UDim2.new(1, 0, 1, 0)
InfoText.BackgroundTransparency = 1
InfoText.Font = Enum.Font.Gotham
InfoText.TextColor3 = Color3.new(1,1,1)
InfoText.TextSize = 18
InfoText.TextWrapped = true
InfoText.Text = [[
👨‍💻 Creador: JoseAngel_Blox
📅 Fecha: 29/06/2026

📖 MANUAL DE USO

¡Bienvenido al mejor script para Mansion Tycoon!

🔹 ¿Cómo funciona?
Este script ha sido diseñado para automatizar todo el juego y que puedas construir tu mansión mucho más rápido. Es muy fácil de usar, solo tienes que ir a la pestaña "Main" y activar lo que necesites.

🔹 ¿Qué hace cada función?

• Auto Collect: Recoge automáticamente todo el dinero y los objetos que aparecen por el mapa sin que tú tengas que tocarlos.
• Auto Build: Construye las paredes, pisos y habitaciones de tu mansión en orden, sin tener que estar comprando uno por uno.
• Auto Buy Upgrades: Compra automáticamente las mejoras de velocidad y producción en cuanto tengas dinero disponible.
• Speed Boost: Aumenta tu velocidad de caminata para moverte más rápido por la isla.

⚠️ Nota: Úsalo con responsabilidad y disfruta de tu mansión!]]

--// Página MAIN
PageMain.Name = "PageMain"
PageMain.Parent = Container
PageMain.Size = UDim2.new(1, 0, 1, 0)
PageMain.BackgroundTransparency = 1
PageMain.Visible = false -- Empieza oculta

local FunctionsText = Instance.new("TextLabel", PageMain)
FunctionsText.Size = UDim2.new(1, 0, 0, 50)
FunctionsText.Position = UDim2.new(0,0,0,10)
FunctionsText.BackgroundTransparency = 1
FunctionsText.Font = Enum.Font.GothamBold
FunctionsText.Text = "⚙️ FUNCIONES DISPONIBLES"
FunctionsText.TextColor3 = Color3.fromRGB(255, 200, 50)
FunctionsText.TextSize = 20

-- Aquí puedes poner los botones después
local Btn1 = Instance.new("TextButton", PageMain)
Btn1.Size = UDim2.new(0.9, 0, 0, 40)
Btn1.Position = UDim2.new(0.05, 0, 0, 70)
Btn1.BackgroundColor3 = Color3.fromRGB(60, 180, 80)
Btn1.Text = "✅ Auto Collect Dinero"
Btn1.TextColor3 = Color3.new(1,1,1)
Btn1.Font = Enum.Font.GothamBold

local Btn2 = Instance.new("TextButton", PageMain)
Btn2.Size = UDim2.new(0.9, 0, 0, 40)
Btn2.Position = UDim2.new(0.05, 0, 0, 120)
Btn2.BackgroundColor3 = Color3.fromRGB(60, 180, 80)
Btn2.Text = "🏗️ Auto Construir"
Btn2.TextColor3 = Color3.new(1,1,1)
Btn2.Font = Enum.Font.GothamBold

local Btn3 = Instance.new("TextButton", PageMain)
Btn3.Size = UDim2.new(0.9, 0, 0, 40)
Btn3.Position = UDim2.new(0.05, 0, 0, 170)
Btn3.BackgroundColor3 = Color3.fromRGB(60, 180, 80)
Btn3.Text = "⚡ Velocidad Extra"
Btn3.TextColor3 = Color3.new(1,1,1)
Btn3.Font = Enum.Font.GothamBold

--// LÓGICA DE PESTAÑAS
TabInfo.MouseButton1Click:Connect(function()
    PageInfo.Visible = true
    PageMain.Visible = false
    TabInfo.BackgroundColor3 = Color3.fromRGB(70, 150, 255)
    TabMain.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
end)

TabMain.MouseButton1Click:Connect(function()
    PageInfo.Visible = false
    PageMain.Visible = true
    TabInfo.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    TabMain.BackgroundColor3 = Color3.fromRGB(70, 150, 255)
end)

--// ANIMACIÓN DE BIENVENIDA
WelcomeText.Name = "WelcomeText"
WelcomeText.Parent = ScreenGui
WelcomeText.Size = UDim2.new(1, 0, 1, 0)
WelcomeText.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
WelcomeText.Font = Enum.Font.GothamBold
WelcomeText.Text = "BIENVENIDO A SCRIPTS\nJoseAngel_Blox"
WelcomeText.TextColor3 = Color3.fromRGB(255, 215, 0)
WelcomeText.TextScaled = true
WelcomeText.ZIndex = 10

-- Efecto de aparecer y desaparecer
local TweenIn = TweenService:Create(WelcomeText, TweenInfo.new(1), {TextTransparency = 0, BackgroundTransparency = 0})
local TweenOut = TweenService:Create(WelcomeText, TweenInfo.new(1), {TextTransparency = 1, BackgroundTransparency = 1})

TweenIn:Play()
wait(2.5)
TweenOut:Play()
wait(1)
WelcomeText:Destroy()

--// AQUÍ IRÍA LA LÓGICA DE LOS BOTONES (Ejemplo rápido)
local collecting = false

Btn1.MouseButton1Click:Connect(function()
    collecting = not collecting
    if collecting then
        Btn1.Text = "❌ Auto Collect (ACTIVO)"
        Btn1.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
    else
        Btn1.Text = "✅ Auto Collect Dinero"
        Btn1.BackgroundColor3 = Color3.fromRGB(60, 180, 80)
    end
end)

print("✅ Script cargado correctamente - JoseAngel_Blox")
