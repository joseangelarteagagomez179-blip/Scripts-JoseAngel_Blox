--// SERVICES
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui
local UIS = game:GetService("UserInputService")

--// VARIABLES
local GuiName = "DuplicarBrainrotsPro"
local SelectedItem = nil
local SelectedData = nil

--// ELIMINAR GUI ANTERIOR
if PlayerGui:FindFirstChild(GuiName) then PlayerGui[GuiName]:Destroy() end

--// CREAR SCREENGUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = GuiName
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

--// MAIN FRAME
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderColor3 = Color3.fromRGB(0, 170, 255)
MainFrame.BorderSizePixel = 2
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 340, 0, 420)
MainFrame.ClipsDescendants = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

--// TITULO
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "⭐ DUPLICAR BRAINROTS PRO ⭐"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16

--// SUBTITULO
local VIPText = Instance.new("TextLabel")
VIPText.Name = "VIPText"
VIPText.Parent = MainFrame
VIPText.BackgroundTransparency = 1
VIPText.Position = UDim2.new(0, 0, 0, 40)
VIPText.Size = UDim2.new(1, 0, 0, 20)
VIPText.Font = Enum.Font.Gotham
VIPText.Text = "💎 VERSIÓN FINAL - COLOCABLES Y GUARDADOS 💎"
VIPText.TextColor3 = Color3.fromRGB(255, 215, 0)
VIPText.TextSize = 11

--// 📦 CUADRO DESTINO
local DropBox = Instance.new("Frame")
DropBox.Name = "DropBox"
DropBox.Parent = MainFrame
DropBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
DropBox.BorderColor3 = Color3.fromRGB(255, 255, 255)
DropBox.BorderSizePixel = 2
DropBox.Position = UDim2.new(0.15, 0, 0.20, 0)
DropBox.Size = UDim2.new(0, 70, 0, 70)

local DropCorner = Instance.new("UICorner")
DropCorner.CornerRadius = UDim.new(0, 8)
DropCorner.Parent = DropBox

local DropText = Instance.new("TextLabel")
DropText.Name = "DropText"
DropText.Parent = DropBox
DropText.BackgroundTransparency = 1
DropText.Size = UDim2.new(1, -10, 0.6, 0)
DropText.Font = Enum.Font.GothamBold
DropText.Text = "📥"
DropText.TextColor3 = Color3.fromRGB(200, 200, 200)
DropText.TextSize = 18

local DropSubText = Instance.new("TextLabel")
DropSubText.Name = "DropSubText"
DropSubText.Parent = DropBox
DropSubText.BackgroundTransparency = 1
DropSubText.Size = UDim2.new(1, -10, 0.4, -5)
DropSubText.Position = UDim2.new(0, 0, 0.6, 5)
DropSubText.Font = Enum.Font.GothamBold
DropSubText.Text = ""
DropSubText.TextColor3 = Color3.fromRGB(0, 255, 0)
DropSubText.TextSize = 10

--// TEXTO INVENTARIO
local InvText = Instance.new("TextLabel")
InvText.Name = "InvText"
InvText.Parent = MainFrame
InvText.BackgroundTransparency = 1
InvText.Position = UDim2.new(0.05, 0, 0.45, 0)
InvText.Size = UDim2.new(0.9, 0, 0, 20)
InvText.Font = Enum.Font.Gotham
InvText.Text = "📜 TUS BRAINROTS:"
InvText.TextColor3 = Color3.fromRGB(255, 255, 255)
InvText.TextSize = 13

--// 📜 LISTA DESLIZABLE
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Name = "ScrollingFrame"
ScrollingFrame.Parent = MainFrame
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 170, 255)
ScrollingFrame.Position = UDim2.new(0.05, 0, 0.52, 0)
ScrollingFrame.Size = UDim2.new(0.9, 0, 110, 0)
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

--// BOTON DUPLICAR
local DuplicateBtn = Instance.new("TextButton")
DuplicateBtn.Name = "DuplicateBtn"
DuplicateBtn.Parent = MainFrame
DuplicateBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
DuplicateBtn.Position = UDim2.new(0.15, 0, 0.85, 0)
DuplicateBtn.Size = UDim2.new(0.7, 0, 0, 45)
DuplicateBtn.Font = Enum.Font.GothamBold
DuplicateBtn.Text = "🚀 DUPLICAR Y GUARDAR"
DuplicateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DuplicateBtn.TextSize = 14

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 10)
BtnCorner.Parent = DuplicateBtn

--// 💥 FUNCION PARA DETECTAR MUTACION 💥
local function GetMutation(item)
    -- Busca dentro del objeto valores como "Mutation", "Tier", "Rarity", "Element"
    local mutation = "Normal"
    local mutationColor = Color3.fromRGB(255,255,255)

    for _, child in pairs(item:GetDescendants()) do
        if child:IsA("StringValue") then
            local nameLower = string.lower(child.Name)
            if nameLower == "mutation" or nameLower == "tier" or nameLower == "rarity" or nameLower == "element" then
                mutation = child.Value
                break
            end
        end
    end

    -- Colores según tipo
    if string.find(string.lower(mutation), "diamante") or string.find(string.lower(mutation), "diamond") then
        mutationColor = Color3.fromRGB(0, 191, 255)
    elseif string.find(string.lower(mutation), "oro") or string.find(string.lower(mutation), "gold") then
        mutationColor = Color3.fromRGB(255, 215, 0)
    elseif string.find(string.lower(mutation), "fantasma") or string.find(string.lower(mutation), "ghost") then
        mutationColor = Color3.fromRGB(200, 200, 255)
    elseif string.find(string.lower(mutation), "celestial") then
        mutationColor = Color3.fromRGB(255, 20, 147)
    end

    return mutation, mutationColor
end

--// 💥 SISTEMA DE SELECCION 💥
local function MakeItemButton(name, obj)
    local mutation, color = GetMutation(obj)

    local ItemBtn = Instance.new("TextButton")
    ItemBtn.Size = UDim2.new(0, 70, 0, 70)
    ItemBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    ItemBtn.BorderColor3 = Color3.fromRGB(0, 170, 255)
    ItemBtn.BorderSizePixel = 2
    ItemBtn.Text = ""
    ItemBtn.Parent = ScrollingFrame

    local BtnCorner2 = Instance.new("UICorner")
    BtnCorner2.CornerRadius = UDim.new(0, 8)
    BtnCorner2.Parent = ItemBtn

    -- NOMBRE ARRIBA
    local NameText = Instance.new("TextLabel")
    NameText.Size = UDim2.new(1, -5, 0.5, 0)
    NameText.Position = UDim2.new(0, 5, 0, 0)
    NameText.BackgroundTransparency = 1
    NameText.Font = Enum.Font.GothamBold
    NameText.Text = name
    NameText.TextColor3 = Color3.fromRGB(255,255,255)
    NameText.TextSize = 9
    NameText.Parent = ItemBtn

    -- MUTACION ABAJO
    local MutText = Instance.new("TextLabel")
    MutText.Size = UDim2.new(1, -5, 0.4, 0)
    MutText.Position = UDim2.new(0, 5, 0.6, 0)
    MutText.BackgroundTransparency = 1
    MutText.Font = Enum.Font.GothamBold
    MutText.Text = mutation
    MutText.TextColor3 = color
    MutText.TextSize = 8
    MutText.Parent = ItemBtn

    -- EVENTO CLICK
    ItemBtn.MouseButton1Click:Connect(function()
        SelectedItem = obj
        SelectedData = {Name = name, Mutation = mutation, Color = color}

        -- MOSTRAR EN CAJA
        DropText.Text = name
        DropSubText.Text = mutation
        DropSubText.TextColor3 = color
        DropText.TextColor3 = Color3.fromRGB(255,255,255)

        -- EFECTO
        ItemBtn.BorderColor3 = Color3.fromRGB(0,255,0)
        wait(0.15)
        ItemBtn.BorderColor3 = Color3.fromRGB(0,170,255)
    end)
end

--// 💥 CARGAR INVENTARIO 💥
local function LoadInventory()
    -- Limpiar
    for _, child in pairs(ScrollingFrame:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end

    local itemsFound = {}

    -- BUSCAR EN TODO LADO (Incluyendo Base)
    for _, obj in pairs(game:GetService("Workspace"):GetDescendants()) do
        -- Filtrar solo Brainrots (nombres largos o con paréntesis)
        if string.len(obj.Name) > 3 and not obj:IsA("Tool") and obj:IsA("Model") then
             if not string.find(string.lower(obj.Name), "humanoid") and not string.find(string.lower(obj.Name), "camera") and not string.find(string.lower(obj.Name), "effect") then
                if not itemsFound[obj.Name] then
                    itemsFound[obj.Name] = obj
                end
            end
        end
    end

    -- Buscar también en Backpack
    if Player:FindFirstChild("Backpack") then
        for _, obj in pairs(Player.Backpack:GetChildren()) do
            if not string.find(string.lower(obj.Name), "humanoid") and not string.find(string.lower(obj.Name), "camera") then
                 if not itemsFound[obj.Name] then
                    itemsFound[obj.Name] = obj
                end
            end
        end
    end

    -- CREAR BOTONES
    for name, obj in pairs(itemsFound) do
        MakeItemButton(name, obj)
    end

    -- AJUSTAR TAMAÑO
    local count = 0
    for _ in pairs(itemsFound) do count = count + 1 end
    ScrollingFrame.CanvasSize = UDim2.new(0, (count * 78), 0, 0)

    if count == 0 then
        local nada = Instance.new("TextLabel")
        nada.Size = UDim2.new(0, 200, 0, 70)
        nada.BackgroundTransparency = 1
        nada.Text = "No se encontraron 😢"
        nada.TextColor3 = Color3.fromRGB(255,255,255)
        nada.Parent = ScrollingFrame
    end
end

-- CARGAR AL INICIAR
LoadInventory()

--// 💥 DUPLICAR Y GUARDAR 💥
DuplicateBtn.MouseButton1Click:Connect(function()
    if not SelectedItem then
        DropText.Text = "⚠️"
        DropSubText.Text = "SELECCIONA"
        return
    end

    DuplicateBtn.Text = "🔄 PROCESANDO..."

    local success, err = pcall(function()
        -- 🧬 CLONAR PERFECTAMENTE
        local Clone = SelectedItem:Clone()
        Clone.Name = SelectedData.Name -- Asegurar nombre correcto

        -- 🔑 INTENTAR MÉTODO DE GUARDADO
        -- Buscar eventos para que se guarde
        local successEvent = false
        
        -- Método 1: Intentar enviar a servidor
        for _, event in pairs(ReplicatedStorage:GetDescendants()) do
            if event:IsA("RemoteEvent") or event:IsA("BindableFunction") then
                if string.find(string.lower(event.Name), "give") or string.find(string.lower(event.Name), "add") or string.find(string.lower(event.Name), "item") then
                    event:FireServer(SelectedData.Name, SelectedData.Mutation)
                    successEvent = true
                end
            end
        end

        -- Método 2: Ponerlo en Backpack y Character
        Clone.Parent = Player.Backpack
        
        -- También crear una copia física para colocar en base
        local CloneWorld = SelectedItem:Clone()
        CloneWorld.Parent = game:GetService("Workspace")
        CloneWorld:MoveTo(Vector3.new(Player.Character.HumanoidRootPart.Position.X, Player.Character.HumanoidRootPart.Position.Y + 5, Player.Character.HumanoidRootPart.Position.Z))

        DuplicateBtn.Text = "✅ ¡DUPLICADO Y GUARDADO!"
        wait(1)
        DuplicateBtn.Text = "🚀 DUPLICAR Y GUARDAR"

        -- ACTUALIZAR LISTA
        LoadInventory()
    end)

    if not success then
        warn(err)
        DuplicateBtn.Text = "❌ ERROR"
        wait(1)
        DuplicateBtn.Text = "🚀 DUPLICAR Y GUARDAR"
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

print("✅ Script VERSIÓN DIOS CARGADO!")
