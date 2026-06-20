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
MainFrame.Size = UDim2.new(0, 320, 0, 360)
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
VIPText.Text = "💎 MODO ARRASTRAR Y SOLTAR 💎"
VIPText.TextColor3 = Color3.fromRGB(255, 215, 0)
VIPText.TextSize = 12

--// 📦 CUADRO VACÍO
local DropBox = Instance.new("Frame")
DropBox.Name = "DropBox"
DropBox.Parent = MainFrame
DropBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
DropBox.BorderColor3 = Color3.fromRGB(255, 255, 255)
DropBox.BorderSizePixel = 2
DropBox.Position = UDim2.new(0.25, 0, 0.20, 0)
DropBox.Size = UDim2.new(0.5, 0, 0, 70)

local DropCorner = Instance.new("UICorner")
DropCorner.CornerRadius = UDim.new(0, 10)
DropCorner.Parent = DropBox

local DropText = Instance.new("TextLabel")
DropText.Name = "DropText"
DropText.Parent = DropBox
DropText.BackgroundTransparency = 1
DropText.Size = UDim2.new(1, -20, 1, 0)
DropText.Font = Enum.Font.GothamBold
DropText.Text = "📥 COLOCA AQUÍ"
DropText.TextColor3 = Color3.fromRGB(200, 200, 200)
DropText.TextSize = 14

--// Texto Inventario
local InvText = Instance.new("TextLabel")
InvText.Name = "InvText"
InvText.Parent = MainFrame
InvText.BackgroundTransparency = 1
InvText.Position = UDim2.new(0.05, 0, 0.45, 0)
InvText.Size = UDim2.new(0.9, 0, 0, 20)
InvText.Font = Enum.Font.Gotham
InvText.Text = "📜 Tu Inventario:"
InvText.TextColor3 = Color3.fromRGB(255, 255, 255)
InvText.TextSize = 13

--// 📜 LISTA DESLIZABLE
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Name = "ScrollingFrame"
ScrollingFrame.Parent = MainFrame
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 170, 255)
ScrollingFrame.Position = UDim2.new(0.05, 0, 0.51, 0)
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

--// 💥 FUNCIÓN ARRASTRAR ITEM 💥
local function MakeDraggable(itemButton, itemName, itemObject)
    local dragging = false
    local startPos = nil
    local originalPos = itemButton.Position

    itemButton.MouseButton1Down:Connect(function()
        dragging = true
        startPos = UIS:GetMouseLocation()
        originalPos = itemButton.Position
        itemButton.ZIndex = 100
        itemButton.Position = UDim2.new(0, startPos.X - 35, 0, startPos.Y - 35)
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = UIS:GetMouseLocation()
            itemButton.Position = UDim2.new(0, mousePos.X - 35, 0, mousePos.Y - 35)
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if dragging then
                dragging = false
                local mousePos = UIS:GetMouseLocation()
                local boxPos = DropBox.AbsolutePosition
                local boxSize = DropBox.AbsoluteSize

                -- Verificar si está dentro del cuadro
                if mousePos.X > boxPos.X and mousePos.X < boxPos.X + boxSize.X and
                   mousePos.Y > boxPos.Y and mousePos.Y < boxPos.Y + boxSize.Y then
                    
                    SelectedItem = itemObject
                    DropText.Text = "✅ " .. itemName
                    DropText.TextColor3 = Color3.fromRGB(0, 255, 0)
                else
                    DropText.Text = "❌ Fuera"
                    DropText.TextColor3 = Color3.fromRGB(255, 0, 0)
                end
                
                -- Regresar botón a su lugar
                itemButton.Position = originalPos
                itemButton.ZIndex = 1
            end
        end
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

    -- Buscar items
    for _, descendant in pairs(Player:GetDescendants()) do
        if descendant:IsA("Tool") or descendant:IsA("Folder") or descendant:IsA("Model") or descendant:IsA("StringValue") or descendant:IsA("NumberValue") then
            if not itemsFound[descendant.Name] then
                itemsFound[descendant.Name] = descendant
            end
        end
    end

    -- Crear botones
    for name, obj in pairs(itemsFound) do
        local ItemBtn = Instance.new("TextButton")
        ItemBtn.Size = UDim2.new(0, 70, 0, 70)
        ItemBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        ItemBtn.BorderColor3 = Color3.fromRGB(0, 170, 255)
        ItemBtn.Text = name
        ItemBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        ItemBtn.TextSize = 11
        ItemBtn.Font = Enum.Font.GothamBold
        ItemBtn.Parent = ScrollingFrame

        local BtnCorner2 = Instance.new("UICorner")
        BtnCorner2.CornerRadius = UDim.new(0, 8)
        BtnCorner2.Parent = ItemBtn

        MakeDraggable(ItemBtn, name, obj)
    end

    -- Ajustar tamaño del scroll
    local numItems = #ScrollingFrame:GetChildren() - 1
    ScrollingFrame.CanvasSize = UDim2.new(0, (numItems * 78) + 10, 0, 0)
end

-- Cargar al iniciar
LoadInventory()

--// 💥 DUPLICAR 💥
DuplicateBtn.MouseButton1Click:Connect(function()
    if not SelectedItem then
        DropText.Text = "⚠️ SELECCIONA UNO!"
        DropText.TextColor3 = Color3.fromRGB(255, 0, 0)
        return
    end

    DuplicateBtn.Text = "🔄 CLONANDO..."

    local success, err = pcall(function()
        local Clone = SelectedItem:Clone()
        Clone.Parent = SelectedItem.Parent
        
        DuplicateBtn.Text = "✅ ¡DUPLICADO!"
        wait(0.5)
        DuplicateBtn.Text = "🚀 DUPLICAR"
        
        -- Actualizar lista
        LoadInventory()
    end)

    if not success then
        DuplicateBtn.Text = "❌ ERROR"
        wait(0.5)
        DuplicateBtn.Text = "🚀 DUPLICAR"
    end
end)

--// MOVER GUI PRINCIPAL
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

print("✅ Script CARGADO y LISTO!")
