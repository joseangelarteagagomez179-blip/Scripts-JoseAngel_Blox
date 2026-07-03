-- // FREE GAMEPASS v1.1
-- // Creador: JoseAngel_Blox
-- // Fecha: 01/06/2026
-- // CORREGIDO: Ahora sí muestran los botones y la info

-- Servicios
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local StarterGui = game:GetService("StarterGui")

-- Variables
local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

-- [[ CREACIÓN DE LA GUI ]]

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")

-- Sección Info
local InfoSection = Instance.new("Frame")
local InfoButton = Instance.new("TextButton")
local InfoContent = Instance.new("Frame")
local InfoText = Instance.new("TextLabel")

-- Sección Gamepasses
local GPSection = Instance.new("Frame")
local GPTitle = Instance.new("TextLabel")
local GPsContainer = Instance.new("Frame")
local GPsLayout = Instance.new("UIListLayout")

-- Propiedades
ScreenGui.Name = "FreeGamepassUI"
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.02, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 360, 0, 230)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true

-- Esquinas Redondeadas
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 14)
UICorner.Parent = MainFrame

-- Título
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Font = Enum.Font.GothamBold
Title.Text = "📦 FREE GAMEPASS v1.1"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 17

-- [[ SECCIÓN INFO ]]

InfoSection.Name = "InfoSection"
InfoSection.Parent = MainFrame
InfoSection.BackgroundTransparency = 1
InfoSection.Size = UDim2.new(1, -20, 0, 40)
InfoSection.Position = UDim2.new(0, 10, 0, 40)

InfoButton.Name = "InfoButton"
InfoButton.Parent = InfoSection
InfoButton.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
InfoButton.Size = UDim2.new(1, 0, 0, 38)
InfoButton.Font = Enum.Font.GothamBold
InfoButton.Text = "ℹ️ INFO ↓"
InfoButton.TextColor3 = Color3.new(1,1,1)
InfoButton.TextSize = 14

local cornerInfo = Instance.new("UICorner")
cornerInfo.CornerRadius = UDim.new(0, 10)
cornerInfo.Parent = InfoButton

InfoContent.Name = "InfoContent"
InfoContent.Parent = MainFrame
InfoContent.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
InfoContent.Size = UDim2.new(1, -20, 0, 0)
InfoContent.Position = UDim2.new(0, 10, 0, 88)
InfoContent.ClipsDescendants = true

local cornerContent = Instance.new("UICorner")
cornerContent.CornerRadius = UDim.new(0, 10)
cornerContent.Parent = InfoContent

InfoText.Name = "InfoText"
InfoText.Parent = InfoContent
InfoText.BackgroundTransparency = 1
InfoText.Size = UDim2.new(1, -10, 1, -10)
InfoText.Position = UDim2.new(0, 5, 0, 5)
InfoText.Font = Enum.Font.Gotham
InfoText.Text = "👋 ¡Bienvenido! Disfruta de todos los beneficios totalmente gratis.\n\n"..
                "👤 Creador: JoseAngel_Blox\n"..
                "📅 Lanzamiento: 01/06/2026\n"..
                "🔢 Versión: 1.1\n\n"..
                "✅ Optimizado para Celular\n👋 ¡Gracias por usar mi script!"
InfoText.TextColor3 = Color3.new(1,1,1)
InfoText.TextSize = 13
InfoText.TextWrapped = true

-- [[ SECCIÓN GAMEPASSES ]]

GPSection.Name = "GPSection"
GPSection.Parent = MainFrame
GPSection.BackgroundTransparency = 1
GPSection.Size = UDim2.new(1, -20, 0, 120) -- Aumentado el tamaño
GPSection.Position = UDim2.new(0, 10, 0, 90) -- Bajado un poco

GPTitle.Name = "GPTitle"
GPTitle.Parent = GPSection
GPTitle.BackgroundTransparency = 1
GPTitle.Size = UDim2.new(1, 0, 0, 25)
GPTitle.Font = Enum.Font.GothamBold
GPTitle.Text = "🔓 FREE GAMEPASS"
GPTitle.TextColor3 = Color3.new(1,1,1)
GPTitle.TextSize = 14

GPsContainer.Name = "GPsContainer"
GPsContainer.Parent = GPSection
GPsContainer.BackgroundTransparency = 1
GPsContainer.Size = UDim2.new(1, 0, 1, -25)
GPsContainer.Position = UDim2.new(0, 0, 0, 25)

GPsLayout.Name = "GPsLayout"
GPsLayout.Parent = GPsContainer
GPsLayout.FillDirection = Enum.FillDirection.Horizontal
GPsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
GPsLayout.SortOrder = Enum.SortOrder.LayoutOrder
GPsLayout.Padding = UDim.new(0, 6)
GPsLayout.Wrap = true

-- [[ LÓGICA ]]

local Open = false
InfoButton.MouseButton1Click:Connect(function()
    Open = not Open
    if Open then
        InfoButton.Text = "ℹ️ INFO ↑"
        TweenService:Create(InfoContent, TweenInfo.new(0.3), {Size = UDim2.new(1, -20, 0, 85)}):Play()
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 360, 0, 320)}):Play()
    else
        InfoButton.Text = "ℹ️ INFO ↓"
        TweenService:Create(InfoContent, TweenInfo.new(0.3), {Size = UDim2.new(1, -20, 0, 0)}):Play()
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 360, 0, 230)}):Play()
    end
end)

-- Función para crear Botones
local Gamepasses = {}

local function CreateToggle(Name, Id)
    local Button = Instance.new("TextButton")
    Button.Name = "GP_"..Name
    Button.Parent = GPsContainer
    Button.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    Button.Size = UDim2.new(0, 75, 0, 42)
    Button.Font = Enum.Font.GothamBold
    Button.Text = Name
    Button.TextColor3 = Color3.new(1,1,1)
    Button.TextSize = 10
    Button.ClipsDescendants = true
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = Button
    
    local Enabled = false
    
    Button.MouseButton1Click:Connect(function()
        Enabled = not Enabled
        if Enabled then
            Button.BackgroundColor3 = Color3.fromRGB(40, 180, 70)
            Gamepasses[Id] = true
            StarterGui:SetCore("SendNotification", {
                Title = "✅ ACTIVADO",
                Text = Name .. " desbloqueado!",
                Duration = 1
            })
        else
            Button.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            Gamepasses[Id] = false
            StarterGui:SetCore("SendNotification", {
                Title = "❌ DESACTIVADO",
                Text = Name .. " desactivado",
                Duration = 1
            })
        end
    end)
end

-- [[ HOOK DEL MARKETPLACE ]]

local mt = getrawmetatable(MarketplaceService)
local old = mt.__namecall

setreadonly(mt, false)

mt.__namecall = function(self, ...)
    local args = {...}
    local method = args[#args]
    
    if method == "UserOwnsGamePassAsync" then
        local ID = args[1]
        if Gamepasses[ID] == true then
            return true
        end
    end
    return old(self, ...)
end

setreadonly(mt, true)

-- [[ LISTA DE GAMEPASSES ]]

CreateToggle("Speed", 9066970)
CreateToggle("Music", 9066988)
CreateToggle("Penthouse", 19660651)
CreateToggle("Vehicles", 15927395)
CreateToggle("Estates", 82773869)
CreateToggle("Premium", 9066980)
CreateToggle("VIP", 850049439)
CreateToggle("Themes", 25341106)
CreateToggle("Horse", 10991687)
CreateToggle("Boats", 667983868)
CreateToggle("Upgrade", 9066924)
CreateToggle("Fire", 10991517)
CreateToggle("Disaster", 48857519)
CreateToggle("Custom", 1459820822)
CreateToggle("Land", 13405328)

-- [[ MENSAJE ]]

StarterGui:SetCore("SendNotification", {
    Title = "✨ FREE GAMEPASS v1.1",
    Text = "Script cargado y corregido!\nBy JoseAngel_Blox",
    Duration = 4
})

print("✅ Script Listo - By JoseAngel_Blox")

