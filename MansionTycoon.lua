--// Services
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local PlayerGui = Players.LocalPlayer.PlayerGui

--// Variables
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local Topbar = Instance.new("Frame")
local MinimizeButton = Instance.new("TextButton")
local MenuButtons = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local ContentFrame = Instance.new("Frame")
local WelcomeText = Instance.new("TextLabel")
local BackgroundEffect = Instance.new("Frame")
local UIGradient = Instance.new("UIGradient")

--// Propiedades de la GUI
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

--// Ventana Principal
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.2, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 450, 0, 350)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Visible = false

--// Esquinas Redondeadas
UICorner.CornerRadius = UDim.new(0, 18)
UICorner.Parent = MainFrame

--// Fondo Animado Neon
BackgroundEffect.Name = "BackgroundEffect"
BackgroundEffect.Parent = MainFrame
BackgroundEffect.BackgroundColor3 = Color3.new(1,1,1)
BackgroundEffect.BackgroundTransparency = 0.9
BackgroundEffect.Size = UDim2.new(2, 0, 2, 0)
BackgroundEffect.Position = UDim2.new(-0.5, 0, -0.5, 0)
BackgroundEffect.ZIndex = 0

UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 0))
}
UIGradient.Rotation = 45
UIGradient.Parent = BackgroundEffect

coroutine.wrap(function()
    while task.wait(0.03) do
        UIGradient.Rotation = UIGradient.Rotation + 5
    end
end)()

--// Topbar
Topbar.Name = "Topbar"
Topbar.Parent = MainFrame
Topbar.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
Topbar.BorderSizePixel = 0
Topbar.Size = UDim2.new(1, 0, 0, 45)
Topbar.ZIndex = 2

Title.Name = "Title"
Title.Parent = Topbar
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(0.8, 0, 1, 0)
Title.Position = UDim2.new(0.1, 0, 0, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "🏠 Mansion Tycoon Script"
Title.TextColor3 = Color3.new(1,1,1)
Title.TextSize = 18

--// Botón Minimizar
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = Topbar
MinimizeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
MinimizeButton.Size = UDim2.new(0, 35, 0, 35)
MinimizeButton.Position = UDim2.new(1, -40, 0, 5)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.Text = "_"
MinimizeButton.TextColor3 = Color3.new(1,1,1)
MinimizeButton.TextSize = 20
MinimizeButton.ZIndex = 3

local MinimizeCorner = Instance.new("UICorner", MinimizeButton)
MinimizeCorner.CornerRadius = UDim.new(0, 10)

--// Menú de Botones
MenuButtons.Name = "MenuButtons"
MenuButtons.Parent = MainFrame
MenuButtons.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
MenuButtons.BorderSizePixel = 0
MenuButtons.Position = UDim2.new(0, 10, 0, 55)
MenuButtons.Size = UDim2.new(0, 100, 1, -65)
MenuButtons.ZIndex = 2

UIListLayout.Parent = MenuButtons
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

--// Contenido
ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 120, 0, 55)
ContentFrame.Size = UDim2.new(1, -130, 1, -65)
ContentFrame.ZIndex = 2

--// ANIMACIÓN DE BIENVENIDA RGB
WelcomeText.Name = "WelcomeText"
WelcomeText.Parent = ScreenGui
WelcomeText.BackgroundTransparency = 1
WelcomeText.Size = UDim2.new(0, 600, 0, 100)
WelcomeText.Position = UDim2.new(0.5, -300, 0.5, -50)
WelcomeText.Font = Enum.Font.GothamBlack
WelcomeText.Text = "Bienvenidos a Scripts JoseAngel_Blox"
WelcomeText.TextSize = 36
WelcomeText.TextTransparency = 0
WelcomeText.TextScaled = true

--// Efecto RGB en letras
coroutine.wrap(function()
    local hue = 0
    while WelcomeText and WelcomeText.Parent do
        hue = hue + 0.01
        if hue > 1 then hue = 0 end
        WelcomeText.TextColor3 = Color3.fromHSV(hue, 0.8, 1)
        RunService.Heartbeat:Wait()
    end
end)()

--// Funciones
local function CreateButton(name, order, callback)
    local Button = Instance.new("TextButton")
    Button.Name = name.."Button"
    Button.Parent = MenuButtons
    Button.BackgroundColor3 = Color3.fromRGB(55, 55, 80)
    Button.BorderSizePixel = 0
    Button.Size = UDim2.new(0.9, 0, 0, 40)
    Button.Font = Enum.Font.GothamBold
    Button.Text = name
    Button.TextColor3 = Color3.new(1,1,1)
    Button.TextSize = 16
    Button.LayoutOrder = order
    Button.ZIndex = 3
    
    local BtnCorner = Instance.new("UICorner", Button)
    BtnCorner.CornerRadius = UDim.new(0, 10)
    
    Button.MouseButton1Click:Connect(callback)
end

local function ClearContent()
    for _, v in pairs(ContentFrame:GetChildren()) do
        if v.Name ~= "BackgroundEffect" then
            v:Destroy()
        end
    end
end

--// Página Info con Acordeón
local function PageInfo()
    ClearContent()
    
    local DropdownButton = Instance.new("TextButton")
    DropdownButton.Parent = ContentFrame
    DropdownButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    DropdownButton.Size = UDim2.new(1, -10, 0, 45)
    DropdownButton.Position = UDim2.new(0, 5, 0, 10)
    DropdownButton.Font = Enum.Font.GothamBold
    DropdownButton.Text = "📄 Información ▼"
    DropdownButton.TextColor3 = Color3.new(1,1,1)
    DropdownButton.TextSize = 16
    DropdownButton.ZIndex = 2
    
    local DDCorner = Instance.new("UICorner", DropdownButton)
    DDCorner.CornerRadius = UDim.new(0, 10)
    
    local ContentInfo = Instance.new("Frame")
    ContentInfo.Parent = ContentFrame
    ContentInfo.BackgroundTransparency = 1
    ContentInfo.Size = UDim2.new(1, -10, 0, 0)
    ContentInfo.Position = UDim2.new(0, 5, 0, 65)
    ContentInfo.ClipsDescendants = true
    ContentInfo.ZIndex = 1
    
    local Creator = Instance.new("TextLabel")
    Creator.Parent = ContentInfo
    Creator.BackgroundTransparency = 1
    Creator.Size = UDim2.new(1, 0, 0, 35)
    Creator.Position = UDim2.new(0, 0, 0, 10)
    Creator.Font = Enum.Font.Gotham
    Creator.Text = "👨‍💻 Creador: JoseAngel_Blox"
    Creator.TextColor3 = Color3.new(1,1,1)
    Creator.TextSize = 15
    Creator.TextXAlignment = Enum.TextXAlignment.Left
    
    local Date = Instance.new("TextLabel")
    Date.Parent = ContentInfo
    Date.BackgroundTransparency = 1
    Date.Size = UDim2.new(1, 0, 0, 35)
    Date.Position = UDim2.new(0, 0, 0, 50)
    Date.Font = Enum.Font.Gotham
    Date.Text = "📅 Lanzamiento: 29/06/2026"
    Date.TextColor3 = Color3.new(1,1,1)
    Date.TextSize = 15
    Date.TextXAlignment = Enum.TextXAlignment.Left
    
    local open = false
    DropdownButton.MouseButton1Click:Connect(function()
        open = not open
        if open then
            DropdownButton.Text = "📄 Información ▲"
            TweenService:Create(ContentInfo, TweenInfo.new(0.3), {Size = UDim2.new(1, -10, 0, 100)}):Play()
        else
            DropdownButton.Text = "📄 Información ▼"
            TweenService:Create(ContentInfo, TweenInfo.new(0.3), {Size = UDim2.new(1, -10, 0, 0)}):Play()
        end
    end)
end

--// Página Main con Toggle Switch
local function PageMain()
    ClearContent()
    
    local functions = {
        {name = "Auto Recolectar Dinero", enabled = false},
        {name = "Auto Construir Todo", enabled = false},
        {name = "Auto Comprar Mejoras", enabled = false},
        {name = "Teletransportarse a Base", enabled = false},
        {name = "Dinero Infinito", enabled = false},
        {name = "Quitar Gravedad", enabled = false}
    }
    
    local YPos = 10
    for i, func in pairs(functions) do
        local FuncFrame = Instance.new("Frame")
        FuncFrame.Parent = ContentFrame
        FuncFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        FuncFrame.Size = UDim2.new(1, -10, 0, 45)
        FuncFrame.Position = UDim2.new(0, 5, 0, YPos)
        FuncFrame.ZIndex = 2
        
        local FCorner = Instance.new("UICorner", FuncFrame)
        FCorner.CornerRadius = UDim.new(0, 10)
        
        local FuncName = Instance.new("TextLabel")
        FuncName.Parent = FuncFrame
        FuncName.BackgroundTransparency = 1
        FuncName.Size = UDim2.new(0.7, 0, 1, 0)
        FuncName.Position = UDim2.new(0.05, 0, 0, 0)
        FuncName.Font = Enum.Font.GothamBold
        FuncName.Text = "• "..func.name
        FuncName.TextColor3 = Color3.new(1,1,1)
        FuncName.TextSize = 14
        FuncName.TextXAlignment = Enum.TextXAlignment.Left
        
        --// Interruptor (Toggle)
        local Toggle = Instance.new("TextButton")
        Toggle.Parent = FuncFrame
        Toggle.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
        Toggle.Size = UDim2.new(0, 50, 0, 25)
        Toggle.Position = UDim2.new(0.85, -25, 0.5, -12)
        Toggle.Text = ""
        Toggle.ZIndex = 3
        
        local TCorner = Instance.new("UICorner", Toggle)
        TCorner.CornerRadius = UDim.new(0, 12)
        
        local Circle = Instance.new("Frame")
        Circle.Parent = Toggle
        Circle.BackgroundColor3 = Color3.new(1,1,1)
        Circle.Size = UDim2.new(0, 20, 0, 20)
        Circle.Position = UDim2.new(0, 3, 0, 2)
        Circle.ZIndex = 4
        
        local CCircle = Instance.new("UICorner", Circle)
        CCircle.CornerRadius = UDim.new(1, 0)
        
        --// Logica Toggle
        Toggle.MouseButton1Click:Connect(function()
            func.enabled = not func.enabled
            if func.enabled then
                TweenService:Create(Toggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 255, 120)}):Play()
                TweenService:Create(Circle, TweenInfo.new(0.2), {Position = UDim2.new(1, -23, 0, 2)}):Play()
            else
                TweenService:Create(Toggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 100)}):Play()
                TweenService:Create(Circle, TweenInfo.new(0.2), {Position = UDim2.new(0, 3, 0, 2)}):Play()
            end
        end)
        
        YPos = YPos + 55
    end
end

--// Botón Minimizar funcional
local minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 150, 0, 45)}):Play()
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 450, 0, 350)}):Play()
    end
end)

--// Crear Botones
CreateButton("Info", 1, PageInfo)
CreateButton("Main", 2, PageMain)

--// ANIMACIÓN DE INICIO
task.wait(1)
TweenService:Create(WelcomeText, TweenInfo.new(1, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
task.wait(1.5)
if WelcomeText then WelcomeText:Destroy() end
MainFrame.Visible = true
PageMain()
