--// Services
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui
local UIS = game:GetService("UserInputService")

--// Variables
local GuiName = "DuplicarBrainrotsPro"
local SelectedItem = nil

--// Eliminar GUI anterior
if PlayerGui:FindFirstChild(GuiName) then
    PlayerGui[GuiName]:Destroy()
end

--// Crear ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = GuiName
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

--// Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderColor3 = Color3.fromRGB(0, 170, 255)
MainFrame.BorderSizePixel = 2
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 320, 0, 380)
MainFrame.ClipsDescendants = true

--// Esquinas Redondeadas
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

--// Título
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "⭐ DUPLICAR BRAINROTS PRO ⭐"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16

--// Subtítulo VIP
local VIPText = Instance.new("TextLabel")
VIPText.Name = "VIPText"
VIPText.Parent = MainFrame
VIPText.BackgroundTransparency = 1
VIPText.Position = UDim2.new(0, 0, 0, 40)
VIPText.Size = UDim2.new(1, 0, 0, 20)
VIPText.Font = Enum.Font.Gotham
VIPText.Text = "💎 SOLO BRAINROTS Y MUTACIONES 💎"
VIPText.TextColor3 = Color3.fromRGB(255, 215, 0)
VIPText.TextSize = 12

--// 📦 CUADRO DESTINO
local DropBox = Instance.new("Frame")
DropBox.Name = "DropBox"
DropBox.Parent = MainFrame
DropBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
DropBox.BorderColor3 = Color3.fromRGB(255, 255, 255)
DropBox.BorderSizePixel = 2
DropBox.Position = UDim2.new(0.18, 0, 0.22, 0)
DropBox.Size = UDim2.new(0, 70, 0, 70)

local DropCorner = Instance.new("UICorner")
DropCorner.CornerRadius = UDim.new(0, 8)
DropCorner.Parent = DropBox

local DropText = Instance.new("TextLabel")
DropText.Name = "DropText"
DropText.Parent = DropBox
DropText.BackgroundTransparency = 1
DropText.Size = UDim2.new(1, -10, 1, 0)
DropText.Font = Enum.Font.GothamBold
DropText.Text = "📥"
DropText.TextColor3 = Color3.fromRGB(200, 200, 200)
DropText.TextSize = 20

--// Texto Inventario
local InvText = Instance.new("TextLabel")
InvText.Name = "InvText"
InvText.Parent = MainFrame
InvText.BackgroundTransparency = 1
InvText.Position = UDim2.new(0.05, 0, 0.48, 0)
InvText.Size = UDim2.new(0.9, 0, 0, 20)
InvText.Font = Enum.Font.Gotham
InvText.Text = "📜 TUS BRAINROTS:"
InvText.TextColor3 = Color3.fromRGB(255, 255, 255)
InvText.TextSize = 13

--// 📜 LISTA DESLIZABLE
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Name = "ScrollingFrame"
ScrollingFrame.Parent = MainFrame
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 170, 255)
ScrollingFrame.Position = UDim2.new(0.05, 0, 0.54, 0)
ScrollingFrame.Size = UDim2.new(0.9, 0, 90, 0)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.ScrollBarThickness = 6

local ScrollCorner = Instance.new("UICorner")
ScrollCorner.CornerRadius = UDim.new(0, 8)
ScrollCorner.Parent = ScrollingFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ScrollingFrame
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)

--// Botón Duplicar
local DuplicateBtn = Instance.new("TextButton")
DuplicateBtn.Name = "DuplicateBtn"
DuplicateBtn.Parent = MainFrame
DuplicateBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
DuplicateBtn.Position = UDim2.new(0.15, 0, 0.82, 0)
DuplicateBtn.Size = UDim2.new(0.7, 0, 0, 40)
DuplicateBtn.Font = Enum.Font.GothamBold
DuplicateBtn.Text = "🚀 DUPLICAR"
DuplicateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DuplicateBtn.TextSize = 16

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 10)
BtnCorner.Parent = DuplicateBtn

--// 💥 SISTEMA DE SELECCIÓN 💥
local function MakeSelectable(itemButton, itemName, itemObject)
    itemButton.MouseButton1Click:Connect(function()
        SelectedItem = itemObject
        DropText.Text = itemName
        DropText.TextColor3 = Color3.fromRGB(0, 255, 0)
        itemButton.BorderColor3 = Color3.fromRGB(0, 255, 0)
        wait(0.2)
        itemButton.BorderColor3 = Color3.fromRGB(0, 170, 255)
    end)
end

--// 💥 CARGAR INVENTARIO 💥
local function LoadInventory()
    -- Limpiar
    for _, child in pairs(ScrollingFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end

    local itemsFound = {}
    -- Lista de palabras clave para identificar Brainrots
    local palabrasClave = {"Miau", "Krupuk", "Brainrot", "Skibidi", "Grimace", "Camera", "Speaker", "TV", "Man", "Woman", "Dog", "Cat"}

    -- BUSCAR ITEMS
    -- Busca en Backpack y Character
    local contenedores = {Player.Backpack, Player.Character}
    
    for _, container in pairs(contenedores) do
        if container then
            for _, item in pairs(container:GetChildren()) do
                -- Verifica si el nombre contiene alguna palabra clave
                local esBrainrot = false
                local nombreMinuscula = string.lower(item.Name)
                
                for _, palabra in pairs(palabrasClave) do
                    if string.find(nombreMinuscula, string.lower(palabra)) then
                        esBrainrot = true
                        break
                    end
                end
                
                -- Si es Brainrot y no está repetido, lo agrega
                if esBrainrot and not itemsFound[item.Name] then
                    itemsFound[item.Name] = item
                end
            end
        end
    end

    -- Crear botones
    for name, obj in pairs(itemsFound) do
        local ItemBtn = Instance.new("TextButton")
        ItemBtn.Name = "Item_"..name
        ItemBtn.Size = UDim2.new(0, 70, 0, 70)
        ItemBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        ItemBtn.BorderColor3 = Color3.fromRGB(0, 170, 255)
        ItemBtn.BorderSizePixel = 2
        ItemBtn.Text = name -- Aquí sale el nombre completo con la mutación (Diamante), (Oro), etc.
        ItemBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        ItemBtn.TextSize = 10
        ItemBtn.Font = Enum.Font.GothamBold
        ItemBtn.Parent = ScrollingFrame

        local BtnCorner2 = Instance.new("UICorner")
        BtnCorner2.CornerRadius = UDim.new(0, 8)
        BtnCorner2.Parent = ItemBtn

        MakeSelectable(ItemBtn, name, obj)
    end

    -- Ajustar scroll
    local count = 0
    for _ in pairs(itemsFound) do count = count + 1 end
    ScrollingFrame.CanvasSize = UDim2.new(0, (count * 78), 0, 0)
    
    if count == 0 then
        local nada = Instance.new("TextLabel")
        nada.Size = UDim2.new(0, 200, 0, 70)
        nada.BackgroundTransparency = 1
        nada.Text = "No se encontraron Brainrots 😢"
        nada.TextColor3 = Color3.fromRGB(255,255,255)
        nada.Parent = ScrollingFrame
    end
end

-- Cargar al iniciar
LoadInventory()

--// 💥 DUPLICAR 💥
DuplicateBtn.MouseButton1Click:Connect(function()
    if not SelectedItem then
        DropText.Text = "⚠️"
        DropText.TextColor3 = Color3.fromRGB(255, 0, 0)
        return
    end

    DuplicateBtn.Text = "🔄..."

    local success, err = pcall(function()
        local Clone = SelectedItem:Clone()
        
        -- Asegurar que va a la mochila correctamente
        if Clone:IsA("Tool") then
            Clone.Parent = Player.Backpack
        else
            Clone.Parent = SelectedItem.Parent
        end
        
        DuplicateBtn.Text = "✅ ¡DUPLICADO!"
        wait(0.8)
        DuplicateBtn.Text = "🚀 DUPLICAR"
        
        LoadInventory()
    end)

    if not success then
        warn(err)
        DuplicateBtn.Text = "❌ ERROR"
        wait(0.8)
        DuplicateBtn.Text = "🚀 DUPLICAR"
    end
end)

--// MOVER GUI
local DraggingGUI = nil
local DragStart = nil
local StartPos = nil

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        DraggingGUI = true
        DragStart = input.Position
        StartPos = MainFrame.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if DraggingGUI and input.UserInputType == Enum.UserInputType.MouseMovement then
        local Delta = input.Position - DragStart
        MainFrame.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        DraggingGUI = false
    end
end)

print("✅ Script LISTO - SOLO MUESTRA BRAINROTS!")
