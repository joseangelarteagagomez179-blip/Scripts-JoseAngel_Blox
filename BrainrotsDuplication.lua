--// Services
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

--// Variables
local GuiName = "DuplicarBrainrotsPro"
local SelectedItem = nil

--// Eliminar GUI anterior si existe
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
MainFrame.BorderMode = Enum.BorderMode.Inset
MainFrame.BorderSizePixel = 2
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 300, 0, 280)
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
Title.TextStrokeTransparency = 0.3

--// Subtítulo VIP
local VIPText = Instance.new("TextLabel")
VIPText.Name = "VIPText"
VIPText.Parent = MainFrame
VIPText.BackgroundTransparency = 1
VIPText.Position = UDim2.new(0, 0, 0, 40)
VIPText.Size = UDim2.new(1, 0, 0, 20)
VIPText.Font = Enum.Font.Gotham
VIPText.Text = "💎 SELECCIONA Y CLONA 💎"
VIPText.TextColor3 = Color3.fromRGB(255, 215, 0)
VIPText.TextSize = 12

--// TEXTO INDICADOR
local SelectText = Instance.new("TextLabel")
SelectText.Name = "SelectText"
SelectText.Parent = MainFrame
SelectText.BackgroundTransparency = 1
SelectText.Position = UDim2.new(0.1, 0, 0.22, 0)
SelectText.Size = UDim2.new(0.8, 0, 0, 20)
SelectText.Font = Enum.Font.Gotham
SelectText.Text = "📋 Selecciona de la lista:"
SelectText.TextColor3 = Color3.fromRGB(255, 255, 255)
SelectText.TextSize = 13

--// 📋 CAJA DE SELECCIÓN (LISTA)
local SelectionBox = Instance.new("TextBox")
SelectionBox.Name = "SelectionBox"
SelectionBox.Parent = MainFrame
SelectionBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SelectionBox.BorderColor3 = Color3.fromRGB(0, 170, 255)
SelectionBox.Position = UDim2.new(0.1, 0, 0.32, 0)
SelectionBox.Size = UDim2.new(0.8, 0, 0, 40)
SelectionBox.Font = Enum.Font.Gotham
SelectionBox.PlaceholderText = "Cargando inventario..."
SelectionBox.Text = ""
SelectionBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SelectionBox.TextSize = 14
SelectionBox.ClearTextOnFocus = false

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 8)
InputCorner.Parent = SelectionBox

--// BOTÓN CARGAR INVENTARIO
local LoadBtn = Instance.new("TextButton")
LoadBtn.Name = "LoadBtn"
LoadBtn.Parent = MainFrame
LoadBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
LoadBtn.Position = UDim2.new(0.1, 0, 0.47, 0)
LoadBtn.Size = UDim2.new(0.8, 0, 0, 30)
LoadBtn.Font = Enum.Font.GothamBold
LoadBtn.Text = "🔄 ACTUALIZAR LISTA"
LoadBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadBtn.TextSize = 13

local BtnCorner2 = Instance.new("UICorner")
BtnCorner2.CornerRadius = UDim.new(0, 6)
BtnCorner2.Parent = LoadBtn

--// Botón Duplicar
local DuplicateBtn = Instance.new("TextButton")
DuplicateBtn.Name = "DuplicateBtn"
DuplicateBtn.Parent = MainFrame
DuplicateBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
DuplicateBtn.Position = UDim2.new(0.15, 0, 0.62, 0)
DuplicateBtn.Size = UDim2.new(0.7, 0, 0, 45)
DuplicateBtn.Font = Enum.Font.GothamBold
DuplicateBtn.Text = "🚀 DUPLICAR"
DuplicateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DuplicateBtn.TextSize = 16

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 10)
BtnCorner.Parent = DuplicateBtn

--// 💥 FUNCIÓN PARA CARGAR LA LISTA 💥
local function cargarInventario()
    local items = {}
    SelectedItem = nil
    
    -- Busca TODOS los objetos que tengas
    for _, descendant in pairs(Player:GetDescendants()) do
        if descendant:IsA("Tool") or descendant:IsA("Folder") or descendant:IsA("Model") or descendant:IsA("StringValue") then
            if not items[descendant.Name] then
                items[descendant.Name] = true
            end
        end
    end
    
    -- Convierte la tabla en lista
    local itemList = {}
    for name in pairs(items) do
        table.insert(itemList, name)
    end
    
    if #itemList == 0 then
        SelectionBox.Text = "⚠️ No se encontraron items"
    else
        SelectionBox.Text = "📋 Tienes "..#itemList.." items"
        -- Crea un menú flotante o permite escribir, pero aquí lo dejamos listo para seleccionar
        -- Para simplificar, el script usará el texto que pongas o selecciones
    end
    
    return itemList
end

-- Cargar al iniciar
cargarInventario()

-- Botón actualizar
LoadBtn.MouseButton1Click:Connect(function()
    cargarInventario()
    LoadBtn.Text = "✅ LISTA ACTUALIZADA"
    wait(0.5)
    LoadBtn.Text = "🔄 ACTUALIZAR LISTA"
end)

--// 💥 FUNCIÓN DUPLICAR 💥
DuplicateBtn.MouseButton1Click:Connect(function()
    local ItemName = SelectionBox.Text
    
    if ItemName == "" or ItemName == "⚠️ No se encontraron items" then
        SelectionBox.PlaceholderText = "⚠️ Escribe o selecciona uno!"
        return
    end
    
    -- Efecto de click
    local tweenOut = TweenService:Create(DuplicateBtn, TweenInfo.new(0.1), {Size = UDim2.new(0.68, 0, 0, 43)})
    local tweenIn = TweenService:Create(DuplicateBtn, TweenInfo.new(0.1), {Size = UDim2.new(0.7, 0, 0, 45)})
    tweenOut:Play()
    tweenIn:Play()
    
    DuplicateBtn.Text = "🔄 CLONANDO..."
    
    local success, err = pcall(function()
        local found = nil
        
        -- BUSCA EL OBJETO SELECCIONADO
        for _, descendant in pairs(Player:GetDescendants()) do
            if descendant.Name == ItemName then
                found = descendant
                break
            end
        end

        if found then
            -- 🧬 CLONACIÓN PERFECTA
            local Clone = found:Clone()
            Clone.Parent = found.Parent
            
            -- Si es un valor numérico, aumenta la cantidad
            if Clone:IsA("NumberValue") or Clone:IsA("IntValue") then
                Clone.Value = Clone.Value + 1
            end
            
            DuplicateBtn.Text = "✅ ¡DUPLICADO!"
        else
            DuplicateBtn.Text = "❌ NO ENCONTRADO"
        end
        
        wait(1)
        DuplicateBtn.Text = "🚀 DUPLICAR"
    end)
    
    if not success then
        warn("Error: " .. err)
        DuplicateBtn.Text = "⚠️ ERROR"
        wait(1)
        DuplicateBtn.Text = "🚀 DUPLICAR"
    end
end)

--// Hacer la GUI arrastrable
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
    if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local Delta = input.Position - DragStart
        MainFrame.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = false
    end
end)

print("✅ Script Modo Selección Cargado!")
