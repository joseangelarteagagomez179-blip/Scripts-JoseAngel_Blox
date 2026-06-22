-- SERVICIOS
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- VARIABLES
local Player = game.Players.LocalPlayer
local Backpack = Player:WaitForChild("Backpack")

-- CREANDO LA GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")

-- ELEMENTOS
local ButtonInfo = Instance.new("TextButton")
local ButtonDupe = Instance.new("TextButton")
local InfoText = Instance.new("TextLabel")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local InputCantidad = Instance.new("TextBox")
local TextoCantidad = Instance.new("TextLabel")
local Notificacion = Instance.new("TextLabel")

-- PROPIEDADES
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- =============================================
-- ✨ VENTANA PRINCIPAL
-- =============================================
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.02, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0, 280, 0, 420)
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true

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
-- 📜 LISTA DE BRAINROTS
-- =============================================
ScrollingFrame.Parent = MainFrame
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
ScrollingFrame.Size = UDim2.new(0.9, 0, 0.28, 0)
ScrollingFrame.CanvasSize = UDim2.new(0,0,0,0)
ScrollingFrame.ScrollBarThickness = 4

local UICornerScroll = Instance.new("UICorner")
UICornerScroll.CornerRadius = UDim.new(0, 8)
UICornerScroll.Parent = ScrollingFrame

UIListLayout.Parent = ScrollingFrame
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- =============================================
-- 🔢 SELECCIONAR CANTIDAD
-- =============================================
TextoCantidad.Parent = MainFrame
TextoCantidad.BackgroundTransparency = 1
TextoCantidad.Position = UDim2.new(0.05, 0, 0.45, 0)
TextoCantidad.Size = UDim2.new(1, -10, 0, 20)
TextoCantidad.Font = Enum.Font.Gotham
TextoCantidad.Text = "🔢 Cantidad a duplicar:"
TextoCantidad.TextColor3 = Color3.fromRGB(255, 255, 255)
TextoCantidad.TextSize = 12

InputCantidad.Parent = MainFrame
InputCantidad.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
InputCantidad.Position = UDim2.new(0.05, 0, 0.50, 0)
InputCantidad.Size = UDim2.new(0.9, 0, 0, 30)
InputCantidad.Font = Enum.Font.GothamBold
InputCantidad.Text = "5"
InputCantidad.TextColor3 = Color3.fromRGB(255, 255, 255)
InputCantidad.TextSize = 14
InputCantidad.ClearTextOnFocus = false

-- 🔒 SÓLO PERMITIR NÚMEROS
InputCantidad:GetPropertyChangedSignal("Text"):Connect(function()
    InputCantidad.Text = InputCantidad.Text:gsub("%D", "")
end)

local UICornerInput = Instance.new("UICorner")
UICornerInput.CornerRadius = UDim.new(0, 8)
UICornerInput.Parent = InputCantidad

-- =============================================
-- 🎛️ BOTONES
-- =============================================
ButtonInfo.Name = "ButtonInfo"
ButtonInfo.Parent = MainFrame
ButtonInfo.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ButtonInfo.Position = UDim2.new(0.05, 0, 0.60, 0)
ButtonInfo.Size = UDim2.new(0.42, 0, 0.12, 0)
ButtonInfo.Font = Enum.Font.GothamBold
ButtonInfo.Text = "ℹ️ Info"
ButtonInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
ButtonInfo.TextSize = 14

local UICornerInfo = Instance.new("UICorner")
UICornerInfo.CornerRadius = UDim.new(0, 10)
UICornerInfo.Parent = ButtonInfo

ButtonDupe.Name = "ButtonDupe"
ButtonDupe.Parent = MainFrame
ButtonDupe.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ButtonDupe.Position = UDim2.new(0.53, 0, 0.60, 0)
ButtonDupe.Size = UDim2.new(0.42, 0, 0.12, 0)
ButtonDupe.Font = Enum.Font.GothamBold
ButtonDupe.Text = "🚀 Duplicar"
ButtonDupe.TextColor3 = Color3.fromRGB(255, 255, 255)
ButtonDupe.TextSize = 14

local UICornerDupe = Instance.new("UICorner")
UICornerDupe.CornerRadius = UDim.new(0, 10)
UICornerDupe.Parent = ButtonDupe

-- TEXTO INFO
InfoText.Name = "InfoText"
InfoText.Parent = MainFrame
InfoText.BackgroundTransparency = 1
InfoText.Position = UDim2.new(0.05, 0, 0.75, 0)
InfoText.Size = UDim2.new(0.9, 0, 0, 60)
InfoText.Font = Enum.Font.Gotham
InfoText.Text = "Creador: JoseAngel_Blox\nFecha: 22/06/2026\nPara: Kick a Lucky Block"
InfoText.TextColor3 = Color3.fromRGB(200, 200, 200)
InfoText.TextSize = 12
InfoText.TextWrapped = true
InfoText.Visible = false

-- ✨ NOTIFICACIÓN FLOTANTE
Notificacion.Name = "Notificacion"
Notificacion.Parent = MainFrame
Notificacion.BackgroundTransparency = 1
Notificacion.Position = UDim2.new(0, 0, 0, -30)
Notificacion.Size = UDim2.new(1, 0, 0, 30)
Notificacion.Font = Enum.Font.GothamBold
Notificacion.Text = "✅ ¡Duplicados con exito!"
Notificacion.TextColor3 = Color3.fromRGB(0, 255, 0)
Notificacion.TextSize = 14
Notificacion.ZIndex = 10

local InfoVisible = false
ButtonInfo.MouseButton1Click:Connect(function()
    InfoVisible = not InfoVisible
    InfoText.Visible = InfoVisible
end)

-- =============================================
-- ⚡ FUNCIONES PRINCIPALES
-- =============================================
local ItemSeleccionado = nil

-- Función para detectar la mutación
local function ObtenerMutacionReal(item)
    local mutacion = "Normal"
    local emoji = "🧠"

    for _, hijo in pairs(item:GetDescendants()) do
        local nombre = hijo.Name:lower()
        local valor = ""
        if hijo:IsA("StringValue") then valor = hijo.Value:lower() end

        if string.find(nombre, "alien") or string.find(valor, "alien") or string.find(nombre, "extraterrestre") then
            mutacion = "Alienígena"
            emoji = "👽"
        elseif string.find(nombre, "shadow") or string.find(valor, "shadow") or string.find(nombre, "sombra") then
            mutacion = "Sombra"
            emoji = "🌑"
        elseif string.find(nombre, "radioactive") or string.find(valor, "radioactive") then
            mutacion = "Radioactivo"
            emoji = "☢️"
        elseif string.find(nombre, "og") or string.find(valor, "og") then
            mutacion = "OG"
            emoji = "💎"
        elseif string.find(nombre, "celestial") or string.find(valor, "celestial") then
            mutacion = "Celestial"
            emoji = "✨"
        end
    end
    return mutacion, emoji
end

-- Actualizar lista
local function ActualizarLista()
    for _, child in pairs(ScrollingFrame:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    for _, Item in pairs(Backpack:GetChildren()) do
        if Item:IsA("Tool") then
            local mutacion, emoji = ObtenerMutacionReal(Item)
            
            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(0.95, 0, 0, 30)
            Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Btn.Font = Enum.Font.Gotham
            Btn.Text = emoji .. " " .. Item.Name .. " [" .. mutacion .. "]"
            Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            Btn.TextSize = 11
            Btn.Parent = ScrollingFrame
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = Btn
            
            Btn.MouseButton1Click:Connect(function()
                if Item.Parent then
                    ItemSeleccionado = Item
                    for _, c in pairs(ScrollingFrame:GetChildren()) do
                        if c:IsA("TextButton") then c.BackgroundColor3 = Color3.fromRGB(40,40,40) end
                    end
                    Btn.BackgroundColor3 = Color3.fromRGB(0, 120, 120)
                end
            end)
        end
    end
    ScrollingFrame.CanvasSize = UDim2.new(0,0,0, UIListLayout.AbsoluteContentSize.Y)
end

-- Duplicar PERFECTAMENTE igual al original
local function DuplicarExacto()
    if not ItemSeleccionado then return end
    
    local Cantidad = math.min(tonumber(InputCantidad.Text) or 1, 50)
    
    for i = 1, Cantidad do
        local Clon = ItemSeleccionado:Clone()
        Clon.Parent = Backpack
        
        -- ✅ CONFIGURACIÓN ESPECIAL PARA QUE SE PUEDA COLOCAR Y GENERE DINERO
        Clon.Enabled = true
        Clon.CanBeDropped = true
        
        -- Asegurar que tenga Handle
        if not Clon:FindFirstChild("Handle") then
            for _, parte in pairs(Clon:GetChildren()) do
                if parte:IsA("BasePart") then
                    parte.Name = "Handle"
                    parte.CanCollide = false
                    break
                end
            end
        end
        
        -- Activar valores que el juego lee
        for _, obj in pairs(Clon:GetDescendants()) do
            if obj:IsA("BasePart") then
                parte.CanCollide = true
                parte.Anchored = false
            elseif obj:IsA("BoolValue") then
                if obj.Name == "IsBrainrot" or obj.Name == "IsUnit" or obj.Name == "CanPlace" then
                    obj.Value = true
                end
            end
        end
        
        task.wait(0.05)
    end
    
    -- ✨ ANIMACIÓN DE AVISO
    Notificacion.Text = "✅ "..Cantidad.."x Brainrots duplicados!"
    TweenService:Create(Notificacion, TweenInfo.new(0.3), {Position = UDim2.new(0,0,0,0)}):Play()
    task.wait(2)
    TweenService:Create(Notificacion, TweenInfo.new(0.3), {Position = UDim2.new(0,0,0,-30)}):Play()
end

-- Lógica botón
local Activado = false
ButtonDupe.MouseButton1Click:Connect(function()
    if not Activado then
        Activado = true
        ButtonDupe.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        ButtonDupe.Text = "✅ PROCESANDO..."
        DuplicarExacto()
        task.wait(0.5)
        ButtonDupe.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        ButtonDupe.Text = "🚀 Duplicar"
        Activado = false
    end
end)

-- Actualizar lista
task.spawn(function()
    while task.wait(2) do
        ActualizarLista()
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

-- INICIO
ActualizarLista()
print("✅ Script listo para Kick a Lucky Block!")
