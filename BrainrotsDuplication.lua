--// Services
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

--// Variables
local GuiName = "DuplicarBrainrotsPro"
local BrainrotName = ""

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
MainFrame.Size = UDim2.new(0, 300, 0, 250)
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
Title.TextSize = 18
Title.TextStrokeTransparency = 0.3

--// Subtítulo VIP
local VIPText = Instance.new("TextLabel")
VIPText.Name = "VIPText"
VIPText.Parent = MainFrame
VIPText.BackgroundTransparency = 1
VIPText.Position = UDim2.new(0, 0, 0, 40)
VIPText.Size = UDim2.new(1, 0, 0, 20)
VIPText.Font = Enum.Font.Gotham
VIPText.Text = "💎 VERSIÓN VIP - MUTACIONES 💎"
VIPText.TextColor3 = Color3.fromRGB(255, 215, 0)
VIPText.TextSize = 14

--// Input Box
local InputBox = Instance.new("TextBox")
InputBox.Name = "InputBox"
InputBox.Parent = MainFrame
InputBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
InputBox.BorderColor3 = Color3.fromRGB(0, 170, 255)
InputBox.Position = UDim2.new(0.1, 0, 0.35, 0)
InputBox.Size = UDim2.new(0.8, 0, 0, 40)
InputBox.Font = Enum.Font.Gotham
InputBox.PlaceholderText = "Ej: Nombre (Diamante) o Nombre [Oro]"
InputBox.Text = ""
InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
InputBox.TextSize = 16
InputBox.ClearTextOnFocus = false

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 8)
InputCorner.Parent = InputBox

--// Botón Duplicar
local DuplicateBtn = Instance.new("TextButton")
DuplicateBtn.Name = "DuplicateBtn"
DuplicateBtn.Parent = MainFrame
DuplicateBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
DuplicateBtn.Position = UDim2.new(0.15, 0, 0.65, 0)
DuplicateBtn.Size = UDim2.new(0.7, 0, 0, 45)
DuplicateBtn.Font = Enum.Font.GothamBold
DuplicateBtn.Text = "🚀 DUPLICAR"
DuplicateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DuplicateBtn.TextSize = 18

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 10)
BtnCorner.Parent = DuplicateBtn

--// FUNCIÓN MEJORADA PARA MUTACIONES 🔥
DuplicateBtn.MouseButton1Click:Connect(function()
    BrainrotName = InputBox.Text
    
    if BrainrotName == "" then
        InputBox.PlaceholderText = "⚠️ Escribe un nombre!"
        return
    end
    
    -- Efecto de click
    local tweenOut = TweenService:Create(DuplicateBtn, TweenInfo.new(0.1), {Size = UDim2.new(0.68, 0, 0, 43)})
    local tweenIn = TweenService:Create(DuplicateBtn, TweenInfo.new(0.1), {Size = UDim2.new(0.7, 0, 0, 45)})
    tweenOut:Play()
    tweenIn:Play()
    
    DuplicateBtn.Text = "🔍 BUSCANDO..."
    
    local success, err = pcall(function()
        local found = nil
        
        -- 🔍 BUSQUEDA ULTRA COMPLETA
        -- Busca en TODO lo que tiene el jugador, incluyendo objetos con paréntesis o corchetes
        for _, descendant in pairs(Player:GetDescendants()) do
            -- Compara el nombre EXACTO, incluyendo (Diamante), [Oro], etc.
            if string.lower(descendant.Name) == string.lower(BrainrotName) then
                found = descendant
                break
            end
        end

        -- ✅ SI LO ENCONTRÓ, LO DUPLICA
        if found then
            local Clone = found:Clone()
            Clone.Parent = found.Parent -- Lo pone en el MISMO LUGAR
            DuplicateBtn.Text = "✅ ¡DUPLICADO!"
            wait(1)
            DuplicateBtn.Text = "🚀 DUPLICAR"
        else
            -- ❌ SI NO LO ENCONTRÓ
            DuplicateBtn.Text = "❌ NO ENCONTRADO"
            wait(1)
            DuplicateBtn.Text = "🚀 DUPLICAR"
        end
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

print("✅ Script Duplicar Brainrots Pro VIP V3 (MUTACIONES) Cargado!")
