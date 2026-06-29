--// Services
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local PlayerGui = Players.LocalPlayer.PlayerGui

--// Variables
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local Topbar = Instance.new("Frame")
local MenuButtons = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local ContentFrame = Instance.new("Frame")
local WelcomeFrame = Instance.new("Frame")
local WelcomeText = Instance.new("TextLabel")

--// Propiedades de la GUI
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.15, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 600, 0, 400) -- Cuadrado y ancho
MainFrame.Active = true
MainFrame.Draggable = true -- Deslizable por la pantalla

UICorner.CornerRadius = UDim.new(0, 16) -- Esquinas redondeadas
UICorner.Parent = MainFrame

--// Topbar
Topbar.Name = "Topbar"
Topbar.Parent = MainFrame
Topbar.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
Topbar.BorderSizePixel = 0
Topbar.Size = UDim2.new(1, 0, 0, 50)

Title.Name = "Title"
Title.Parent = Topbar
Title.BackgroundTransparency = 1.000
Title.Size = UDim2.new(1, 0, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "🏠 Mansion Tycoon Script"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20.000

--// Menú de Botones
MenuButtons.Name = "MenuButtons"
MenuButtons.Parent = MainFrame
MenuButtons.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
MenuButtons.BorderSizePixel = 0
MenuButtons.Position = UDim2.new(0, 0, 0, 50)
MenuButtons.Size = UDim2.new(0, 120, 1, -50)

UIListLayout.Parent = MenuButtons
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

--// Contenido
ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
ContentFrame.BorderSizePixel = 0
ContentFrame.Position = UDim2.new(0, 120, 0, 50)
ContentFrame.Size = UDim2.new(1, -120, 1, -50)

--// Animación de Bienvenida
WelcomeFrame.Name = "WelcomeFrame"
WelcomeFrame.Parent = ScreenGui
WelcomeFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
WelcomeFrame.BorderSizePixel = 0
WelcomeFrame.Position = UDim2.new(0.5, -200, 0.5, -50)
WelcomeFrame.Size = UDim2.new(0, 400, 0, 100)
WelcomeFrame.Visible = false

local WelcomeCorner = Instance.new("UICorner", WelcomeFrame)
WelcomeCorner.CornerRadius = UDim.new(0, 12)

WelcomeText.Name = "WelcomeText"
WelcomeText.Parent = WelcomeFrame
WelcomeText.BackgroundTransparency = 1.000
WelcomeText.Size = UDim2.new(1, 0, 1, 0)
WelcomeText.Font = Enum.Font.GothamBold
WelcomeText.Text = "Bienvenidos a Scripts JoseAngel_Blox"
WelcomeText.TextColor3 = Color3.fromRGB(255, 215, 0)
WelcomeText.TextSize = 24.000
WelcomeText.TextTransparency = 1

--// Funciones
local function CreateButton(name, order, callback)
    local Button = Instance.new("TextButton")
    Button.Name = name.."Button"
    Button.Parent = MenuButtons
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    Button.BorderSizePixel = 0
    Button.Size = UDim2.new(0.8, 0, 0, 40)
    Button.Font = Enum.Font.GothamBold
    Button.Text = name
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 16.000
    Button.LayoutOrder = order
    
    local BtnCorner = Instance.new("UICorner", Button)
    BtnCorner.CornerRadius = UDim.new(0, 8)
    
    Button.MouseButton1Click:Connect(callback)
end

local function ClearContent()
    for _, v in pairs(ContentFrame:GetChildren()) do
        if v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("Frame") then
            v:Destroy()
        end
    end
end

--// Página Info
local function PageInfo()
    ClearContent()
    
    local InfoTitle = Instance.new("TextLabel")
    InfoTitle.Parent = ContentFrame
    InfoTitle.BackgroundTransparency = 1
    InfoTitle.Size = UDim2.new(1, -20, 0, 40)
    InfoTitle.Position = UDim2.new(0, 10, 0, 20)
    InfoTitle.Font = Enum.Font.GothamBold
    InfoTitle.Text = "📄 Información"
    InfoTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
    InfoTitle.TextSize = 22
    InfoTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    local Creator = Instance.new("TextLabel")
    Creator.Parent = ContentFrame
    Creator.BackgroundTransparency = 1
    Creator.Size = UDim2.new(1, -20, 0, 30)
    Creator.Position = UDim2.new(0, 10, 0, 70)
    Creator.Font = Enum.Font.Gotham
    Creator.Text = "👨‍💻 Nombre del creador: JoseAngel_Blox"
    Creator.TextColor3 = Color3.fromRGB(255,255,255)
    Creator.TextSize = 16
    Creator.TextXAlignment = Enum.TextXAlignment.Left
    
    local Date = Instance.new("TextLabel")
    Date.Parent = ContentFrame
    Date.BackgroundTransparency = 1
    Date.Size = UDim2.new(1, -20, 0, 30)
    Date.Position = UDim2.new(0, 10, 0, 110)
    Date.Font = Enum.Font.Gotham
    Date.Text = "📅 Fecha de lanzamiento: 29/06/2026"
    Date.TextColor3 = Color3.fromRGB(255,255,255)
    Date.TextSize = 16
    Date.TextXAlignment = Enum.TextXAlignment.Left
end

--// Página Main (Funciones)
local function PageMain()
    ClearContent()
    
    local MainTitle = Instance.new("TextLabel")
    MainTitle.Parent = ContentFrame
    MainTitle.BackgroundTransparency = 1
    MainTitle.Size = UDim2.new(1, -20, 0, 40)
    MainTitle.Position = UDim2.new(0, 10, 0, 20)
    MainTitle.Font = Enum.Font.GothamBold
    MainTitle.Text = "⚡ Funciones Principales"
    MainTitle.TextColor3 = Color3.fromRGB(0, 255, 150)
    MainTitle.TextSize = 22
    MainTitle.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Funciones
    local functions = {
        "Auto Recolectar Dinero",
        "Auto Construir Todo",
        "Auto Comprar Mejoras",
        "Teletransportarse a Base",
        "Dinero Infinito",
        "Quitar Gravedad"
    }
    
    local YPos = 70
    for i, funcName in pairs(functions) do
        local Btn = Instance.new("TextButton")
        Btn.Parent = ContentFrame
        Btn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        Btn.Size = UDim2.new(0.9, 0, 0, 40)
        Btn.Position = UDim2.new(0.05, 0, 0, YPos)
        Btn.Font = Enum.Font.GothamBold
        Btn.Text = "▶ "..funcName
        Btn.TextColor3 = Color3.fromRGB(255,255,255)
        Btn.TextSize = 14
        
        local Corner = Instance.new("UICorner", Btn)
        Corner.CornerRadius = UDim.new(0, 8)
        
        Btn.MouseButton1Click:Connect(function()
            if Btn.Text:find("▶") then
                Btn.Text = "⏸ "..funcName
                Btn.BackgroundColor3 = Color3.fromRGB(0, 150, 80)
                -- Aquí iría la lógica de la función
            else
                Btn.Text = "▶ "..funcName
                Btn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
            end
        end)
        
        YPos = YPos + 50
    end
end

--// Crear Botones
CreateButton("Info", 1, PageInfo)
CreateButton("Main", 2, PageMain)

--// Animación de Bienvenida
WelcomeFrame.Visible = true
WelcomeFrame.Size = UDim2.new(0, 0, 0, 100)

local TweenIn = TweenService:Create(WelcomeFrame, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 400, 0, 100)})
local TweenText = TweenService:Create(WelcomeText, TweenInfo.new(0.5), {TextTransparency = 0})
local TweenOut = TweenService:Create(WelcomeFrame, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 100)})

TweenIn:Play()
TweenText:Play()

TweenIn.Completed:Connect(function()
    wait(2)
    TweenOut:Play()
    TweenOut.Completed:Connect(function()
        WelcomeFrame:Destroy()
    end)
end)

--// Cargar página por defecto
PageMain()
