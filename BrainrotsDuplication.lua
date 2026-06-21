-- Servicios
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui

-- Creación de la Interfaz
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local SlotDisplay = Instance.new("Frame")
local SlotText = Instance.new("TextLabel")
local ListFrame = Instance.new("ScrollingFrame")
local ListLayout = Instance.new("UIListLayout")
local DupeButton = Instance.new("TextButton")

ScreenGui.Name = "BrainDupePRO"
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Marco Principal
MainFrame.Name = "MainUI"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
MainFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 280)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0,14)

-- Título
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "🧠 DUPE PRO"
Title.TextColor3 = Color3.new(0, 0, 0)
Title.TextSize = 16

-- Cuadro Vacío
SlotDisplay.Name = "SlotDisplay"
SlotDisplay.Parent = MainFrame
SlotDisplay.BackgroundColor3 = Color3.fromRGB(225, 225, 225)
SlotDisplay.Position = UDim2.new(0.5, -70, 0.14, 0)
SlotDisplay.Size = UDim2.new(0, 140, 0, 70)

local SlotCorner = Instance.new("UICorner", SlotDisplay)
SlotCorner.CornerRadius = UDim.new(0,10)

SlotText.Parent = SlotDisplay
SlotText.BackgroundTransparency = 1
SlotText.Size = UDim2.new(1, -10, 1, -10)
SlotText.Font = Enum.Font.GothamBold
SlotText.Text = "SELECCIONA"
SlotText.TextColor3 = Color3.new(0, 0, 0)
SlotText.TextSize = 12

-- Lista de Items
ListFrame.Name = "ItemList"
ListFrame.Parent = MainFrame
ListFrame.BackgroundColor3 = Color3.fromRGB(235, 235, 235)
ListFrame.Position = UDim2.new(0.05, 0, 0.43, 0)
ListFrame.Size = UDim2.new(0.9, 0, 0, 80)
ListFrame.ScrollBarThickness = 4
ListFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ListFrame.CanvasSize = UDim2.new(0,0,0,0)

local ListCorner = Instance.new("UICorner", ListFrame)
ListCorner.CornerRadius = UDim.new(0,8)

ListLayout.Parent = ListFrame
ListLayout.FillDirection = Enum.FillDirection.Horizontal
ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Padding = UDim.new(0, 6)

ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ListFrame.CanvasSize = UDim2.new(0,0,0, ListLayout.AbsoluteContentSize.Y)
end)

-- Botón Duplicar
DupeButton.Name = "DupeButton"
DupeButton.Parent = MainFrame
DupeButton.BackgroundColor3 = Color3.fromRGB(255, 220, 0)
DupeButton.Position = UDim2.new(0.1, 0, 0.76, 0)
DupeButton.Size = UDim2.new(0.8, 0, 0, 40)
DupeButton.Font = Enum.Font.GothamBold
DupeButton.Text = "✅ DUPLICAR"
DupeButton.TextColor3 = Color3.new(0, 0, 0)
DupeButton.TextSize = 15

local BtnCorner = Instance.new("UICorner", DupeButton)
BtnCorner.CornerRadius = UDim.new(0,10)

-- Variables
local SelectedName = ""
local SelectedIsMutated = false

-- Funciones
local function crearBotonItem(nombre, esMutado)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 90, 0, 45)
    
    if esMutado then
        btn.BackgroundColor3 = Color3.fromRGB(255, 180, 255)
    else
        btn.BackgroundColor3 = Color3.fromRGB(200, 200, 255)
    end
    
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.TextWrapped = true
    btn.Text = nombre
    btn.TextColor3 = Color3.new(0, 0, 0)
    
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0,8)
    
    btn.Parent = ListFrame
    
    btn.MouseButton1Click:Connect(function()
        SelectedName = nombre
        SelectedIsMutated = esMutado
        SlotText.Text = nombre
        
        if esMutado then
            SlotDisplay.BackgroundColor3 = Color3.fromRGB(255, 180, 255)
        else
            SlotDisplay.BackgroundColor3 = Color3.fromRGB(200, 200, 255)
        end
    end)
end

local function actualizarInventario()
    for _,v in pairs(ListFrame:GetChildren()) do
        if v:IsA("TextButton") then v:Destroy() end
    end
    
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not backpack then return end
    
    local encontrados = {}
    
    for _, item in pairs(backpack:GetChildren()) do
        if item:IsA("Tool") and item.Name:lower():find("brainrot") then
            local nombreLimpio = item.Name
            local esMutado = string.find(item.Name:lower(), "mut") or string.find(item.Name:lower(), "shiny") or string.find(item.Name:lower(), "gold") or false
            
            if not encontrados[nombreLimpio] then
                encontrados[nombreLimpio] = true
                crearBotonItem(nombreLimpio, esMutado)
            end
        end
    end
end

local function duplicarYColocar()
    if SelectedName == "" then
        SlotText.Text = "SELECCIONA"
        return
    end

    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not backpack then return end

    local original = nil
    for _, item in pairs(backpack:GetChildren()) do
        if item.Name == SelectedName then
            original = item
            break
        end
    end

    if original then
        local copia = original:Clone()
        copia.Parent = backpack

        local base = workspace:FindFirstChild(LocalPlayer.Name .. "'s Base") or workspace:FindFirstChild("Base_"..LocalPlayer.UserId)
        if base then
            local objetoEnBase = copia:Clone()
            objetoEnBase.Parent = base
        end

        SlotText.Text = "✅ DUPLICADO"
        task.wait(1)
        SlotText.Text = SelectedName
    end
end

DupeButton.MouseButton1Click:Connect(duplicarYColocar)

while task.wait(2) do
    actualizarInventario()
end
