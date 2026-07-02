--[[
    Braianrots duplications v1.1
    Creador: JoseAngel_Blox
    Fecha de Creación: 01/06/2026
    Optimizado para Delta Android
--]]

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- Interfaz Principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BraianrotsDuplicationGui"
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 400)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- Para moverlo en la pantalla
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

-- Título del Script
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "Braianrots duplications v1.1"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = MainFrame

-- SECCIÓN 1: info ↓↑
local InfoBox = Instance.new("TextLabel")
InfoBox.Size = UDim2.new(1, -20, 0, 70)
InfoBox.Position = UDim2.new(0, 10, 0, 50)
InfoBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
InfoBox.Text = "info ↓↑\nNombre del creador: JoseAngel_Blox\nFecha de Creación: 01/06/2026"
InfoBox.TextColor3 = Color3.fromRGB(200, 200, 200)
InfoBox.Font = Enum.Font.Gotham
InfoBox.TextSize = 14
InfoBox.Parent = MainFrame
local ICorn = Instance.new("UICorner")
ICorn.CornerRadius = UDim.new(0, 10)
ICorn.Parent = InfoBox

-- SECCIÓN 2: duplicar (Lista de Inventario)
local DupeLabel = Instance.new("TextLabel")
DupeLabel.Size = UDim2.new(1, 0, 0, 30)
DupeLabel.Position = UDim2.new(0, 0, 0, 130)
DupeLabel.BackgroundTransparency = 1
DupeLabel.Text = "duplicar"
DupeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
DupeLabel.Font = Enum.Font.GothamBold
DupeLabel.TextSize = 16
DupeLabel.Parent = MainFrame

local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -20, 1, -180)
Scroll.Position = UDim2.new(0, 10, 0, 160)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 2, 0)
Scroll.ScrollBarThickness = 4
Scroll.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.Padding = UDim.new(0, 5)
UIList.Parent = Scroll

-- Función para refrescar la lista de Braianrots equipados
local function updateList()
    for _, v in pairs(Scroll:GetChildren()) do 
        if v:IsA("Frame") then v:Destroy() end 
    end
    
    -- Detectar items en el personaje (lo que tienes en mano o equipado)
    local items = player.Character:GetChildren()
    local found = false
    
    for _, item in pairs(items) do
        if item:IsA("Tool") or (item:IsA("Model") and item:FindFirstChild("Level")) then
            found = true
            local f = Instance.new("Frame")
            f.Size = UDim2.new(1, 0, 0, 55)
            f.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            f.Parent = Scroll
            Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
            
            local mut = item:FindFirstChild("Mutation") and item.Mutation.Value or "Normal"
            local lvl = item:FindFirstChild("Level") and item.Level.Value or "1"
            
            local txt = Instance.new("TextLabel", f)
            txt.Size = UDim2.new(0.7, 0, 1, 0)
            txt.Position = UDim2.new(0, 10, 0, 0)
            txt.BackgroundTransparency = 1
            txt.Text = item.Name .. "\nMutación: " .. mut .. " | Nivel: " .. lvl
            txt.TextColor3 = Color3.fromRGB(255, 255, 255)
            txt.TextSize = 12
            txt.TextXAlignment = Enum.TextXAlignment.Left
            
            local btn = Instance.new("TextButton", f)
            btn.Size = UDim2.new(0.25, 0, 0.6, 0)
            btn.Position = UDim2.new(0.7, 0, 0.2, 0)
            btn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
            btn.Text = "Duplicar"
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Font = Enum.Font.GothamBold
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
            
            btn.MouseButton1Click:Connect(function()
                -- Simulación de duplicación (para efecto visual en el script)
                btn.Text = "Copiando..."
                wait(1)
                btn.Text = "¡Éxito!"
                wait(1)
                btn.Text = "Duplicar"
            end)
        end
    end
    
    if not found then
        local empty = Instance.new("TextLabel", Scroll)
        empty.Size = UDim2.new(1, 0, 0, 30)
        empty.BackgroundTransparency = 1
        empty.Text = "Equipa un Braianrot para verlo aquí"
        empty.TextColor3 = Color3.fromRGB(150, 150, 150)
        empty.TextSize = 12
    end
end

-- Botón para actualizar manualmente la lista
local Refresh = Instance.new("TextButton")
Refresh.Size = UDim2.new(1, -20, 0, 30)
Refresh.Position = UDim2.new(0, 10, 1, -40)
Refresh.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Refresh.Text = "Actualizar Lista"
Refresh.TextColor3 = Color3.fromRGB(255, 255, 255)
Refresh.Parent = MainFrame
Instance.new("UICorner", Refresh).CornerRadius = UDim.new(0, 8)
Refresh.MouseButton1Click:Connect(updateList)

updateList()
print("✅ Braianrots duplications v1.1 cargado")
