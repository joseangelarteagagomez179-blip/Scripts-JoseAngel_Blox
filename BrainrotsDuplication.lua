-- SERVICIOS
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- VARIABLES
local Player = game.Players.LocalPlayer
local Backpack = Player:WaitForChild("Backpack")

-- CREANDO LA GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")

-- BOTONES Y ELEMENTOS
local ButtonInfo = Instance.new("TextButton")
local ButtonDupe = Instance.new("TextButton")
local InfoText = Instance.new("TextLabel")
local ScrollingFrame = Instance.new("ScrollingFrame") -- Para la lista
local UIListLayout = Instance.new("UIListLayout")

-- PROPIEDADES
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- =============================================
-- ✨ VENTANA PRINCIPAL (MÁS PEQUEÑA Y MOVIBLE)
-- =============================================
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.02, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0, 280, 0, 380) -- Tamaño más pequeño
MainFrame.ClipsDescendants = true
MainFrame.Active = true -- Hace que se pueda mover
MainFrame.Draggable = true -- ✨ DESLIZABLE POR TODA LA PANTALLA ✨

-- ESQUINAS REDONDEADAS
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 16)
UICorner.Parent = MainFrame

-- TITULO
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "💠 Brainrots duplications VIP 💠"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15

-- =============================================
-- 📜 LISTA DONDE SALEN LOS BRAINROTS
-- =============================================
ScrollingFrame.Parent = MainFrame
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.Position = UDim2.new(0.05, 0, 0.18, 0)
ScrollingFrame.Size = UDim2.new(0.9, 0, 0.35, 0)
ScrollingFrame.CanvasSize = UDim2.new(0,0,0,0)
ScrollingFrame.ScrollBarThickness = 4

local UICornerScroll = Instance.new("UICorner")
UICornerScroll.CornerRadius = UDim.new(0, 8)
UICornerScroll.Parent = ScrollingFrame

UIListLayout.Parent = ScrollingFrame
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- =============================================
-- ℹ️ BOTÓN INFO
-- =============================================
ButtonInfo.Name = "ButtonInfo"
ButtonInfo.Parent = MainFrame
ButtonInfo.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ButtonInfo.Position = UDim2.new(0.05, 0, 0.58, 0)
ButtonInfo.Size = UDim2.new(0.42, 0, 0.12, 0) -- Tamaño perfecto
ButtonInfo.Font = Enum.Font.GothamBold
ButtonInfo.Text = "ℹ️ Info"
ButtonInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
ButtonInfo.TextSize = 14

local UICornerInfo = Instance.new("UICorner")
UICornerInfo.CornerRadius = UDim.new(0, 10)
UICornerInfo.Parent = ButtonInfo

-- TEXTO DE INFO
InfoText.Name = "InfoText"
InfoText.Parent = MainFrame
InfoText.BackgroundTransparency = 1
InfoText.Position = UDim2.new(0.05, 0, 0.72, 0)
InfoText.Size = UDim2.new(0.9, 0, 0, 60)
InfoText.Font = Enum.Font.Gotham
InfoText.Text = "Creador: JoseAngel_Blox\nFecha: 22/06/2026"
InfoText.TextColor3 = Color3.fromRGB(200, 200, 200)
InfoText.TextSize = 12
InfoText.TextWrapped = true
InfoText.Visible = false

local InfoVisible = false
ButtonInfo.MouseButton1Click:Connect(function()
    InfoVisible = not InfoVisible
    InfoText.Visible = InfoVisible
end)

-- =============================================
-- 🚀 BOTÓN DUPLICAR
-- =============================================
ButtonDupe.Name = "ButtonDupe"
ButtonDupe.Parent = MainFrame
ButtonDupe.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ButtonDupe.Position = UDim2.new(0.53, 0, 0.58, 0) -- A un lado del otro
ButtonDupe.Size = UDim2.new(0.42, 0, 0.12, 0)
ButtonDupe.Font = Enum.Font.GothamBold
ButtonDupe.Text = "🚀 Duplicar"
ButtonDupe.TextColor3 = Color3.fromRGB(255, 255, 255)
ButtonDupe.TextSize = 14

local UICornerDupe = Instance.new("UICorner")
UICornerDupe.CornerRadius = UDim.new(0, 10)
UICornerDupe.Parent = ButtonDupe

-- =============================================
-- ⚡ FUNCIONES MEJORADAS
-- =============================================
local Activado = false
local Bucle = nil
local ItemSeleccionado = nil

-- Función para actualizar la lista
local function ActualizarLista()
    -- Limpiar lista anterior
    for _, child in pairs(ScrollingFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    -- Buscar Brainrots
    for _, Item in pairs(Backpack:GetChildren()) do
        if string.find(Item.Name:lower(), "brainrot") or Item:IsA("Tool") then
            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(0.95, 0, 0, 30)
            Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Btn.Font = Enum.Font.Gotham
            Btn.Text = "🧠 " .. Item.Name -- Muestra nombre y mutación
            Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            Btn.TextSize = 12
            Btn.Parent = ScrollingFrame
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = Btn
            
            -- Al darle click seleccionas cual duplicar
            Btn.MouseButton1Click:Connect(function()
                ItemSeleccionado = Item
                -- Cambiar color para marcar seleccionado
                for _, c in pairs(ScrollingFrame:GetChildren()) do
                    if c:IsA("TextButton") then c.BackgroundColor3 = Color3.fromRGB(40,40,40) end
                end
                Btn.BackgroundColor3 = Color3.fromRGB(0, 120, 120)
                print("Seleccionado: " .. Item.Name)
            end)
        end
    end
    ScrollingFrame.CanvasSize = UDim2.new(0,0,0, UIListLayout.AbsoluteContentSize.Y)
end

-- Duplicar el item seleccionado
local function DuplicarSeleccionado()
    if ItemSeleccionado then
        local Clon = ItemSeleccionado:Clone()
        Clon.Parent = Backpack
        print("Duplicado: " .. ItemSeleccionado.Name)
    end
end

-- Actualizar lista cada 2 segundos
spawn(function()
    while wait(2) do
        ActualizarLista()
    end
end)

-- Lógica del botón
ButtonDupe.MouseButton1Click:Connect(function()
    Activado = not Activado
    if Activado then
        ButtonDupe.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        ButtonDupe.Text = "✅ ACTIVADO"
        Bucle = RunService.Heartbeat:Connect(DuplicarSeleccionado)
    else
        ButtonDupe.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        ButtonDupe.Text = "🚀 Duplicar"
        if Bucle then Bucle:Disconnect() end
    end
end)

-- =============================================
-- ✨ EFECTOS
-- =============================================
ButtonInfo.MouseEnter:Connect(function()
    TweenService:Create(ButtonInfo, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
end)
ButtonInfo.MouseLeave:Connect(function()
    if ButtonInfo.BackgroundColor3 ~= Color3.fromRGB(0,150,0) then
        TweenService:Create(ButtonInfo, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
    end
end)

ButtonDupe.MouseEnter:Connect(function()
    if not Activado then
        TweenService:Create(ButtonDupe, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
    end
end)
ButtonDupe.MouseLeave:Connect(function()
    if not Activado then
        TweenService:Create(ButtonDupe, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
    end
end)

-- Cargar lista al inicio
ActualizarLista()
print("✅ Script cargado correctamente!")
