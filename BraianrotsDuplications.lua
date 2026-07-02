--[[
    Braianrots Duplications v1.1 - ADVANCED SCANNER
    Creador: JoseAngel_Blox
    Fecha: 01/06/2026
--]]

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Interfaz con fondo mejorado
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BraianrotsDuplicationGui"
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 360, 0, 420)
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Thickness = 3
UIStroke.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0), Color3.fromRGB(150, 0, 255)).Keypoints[1].Value -- Borde Rojo/Morado

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 20)

-- Título
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "BRAIANROTS DUPLICATOR PRO"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 18

-- Info del Creador
local Info = Instance.new("TextLabel", MainFrame)
Info.Size = UDim2.new(1, -30, 0, 60)
Info.Position = UDim2.new(0, 15, 0, 60)
Info.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
Info.RichText = true
Info.Text = "Creador: <font color='#FF0000'>JoseAngel_Blox</font>\nEstado: <font color='#00FF00'>Escaneando Eventos...</font>"
Info.TextColor3 = Color3.fromRGB(200, 200, 200)
Info.Font = Enum.Font.Gotham
Info.TextSize = 13
Instance.new("UICorner", Info).CornerRadius = UDim.new(0, 10)

-- Lista
local Scroll = Instance.new("ScrollingFrame", MainFrame)
Scroll.Size = UDim2.new(1, -30, 1, -210)
Scroll.Position = UDim2.new(0, 15, 0, 140)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 2
local UIList = Instance.new("UIListLayout", Scroll)
UIList.Padding = UDim.new(0, 5)

-- LÓGICA DE DUPLICACIÓN POR ESCANEO (Intento de Bypass)
local function IntentarDuplicarTotal(itemName)
    -- Buscamos en todo el juego cualquier evento que pueda darnos el ítem
    local function search(folder)
        for _, v in pairs(folder:GetDescendants()) do
            if v:IsA("RemoteEvent") then
                -- Intentamos combinaciones comunes de comandos para "engañar" al server
                v:FireServer("GiveItem", itemName)
                v:FireServer("Add", itemName)
                v:FireServer("Claim", itemName)
                v:FireServer("Reward", itemName, 1)
                v:FireServer("LuckyBlock", "Duplicate", itemName)
            end
        end
    end
    
    search(ReplicatedStorage)
    search(game:GetService("Lighting")) -- A veces los esconden aquí
end

-- Actualizar lista
local function updateList()
    for _, v in pairs(Scroll:GetChildren()) do if v:IsA("Frame") then v:Destroy() end end
    
    for _, item in pairs(player.Character:GetChildren()) do
        if item:IsA("Tool") or (item:IsA("Model") and item:FindFirstChild("Level")) then
            local f = Instance.new("Frame", Scroll)
            f.Size = UDim2.new(1, 0, 0, 50)
            f.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
            
            local t = Instance.new("TextLabel", f)
            t.Size = UDim2.new(0.6, 0, 1, 0)
            t.Position = UDim2.new(0, 10, 0, 0)
            t.BackgroundTransparency = 1
            t.Text = "<b>" .. item.Name .. "</b>"
            t.RichText = true
            t.TextColor3 = Color3.fromRGB(255, 255, 255)
            t.TextXAlignment = Enum.TextXAlignment.Left
            
            local b = Instance.new("TextButton", f)
            b.Size = UDim2.new(0.35, 0, 0.7, 0)
            b.Position = UDim2.new(0.6, 0, 0.15, 0)
            b.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            b.Text = "FORZAR DUPE"
            b.TextColor3 = Color3.fromRGB(255, 255, 255)
            Instance.new("UICorner", b).CornerRadius = UDim.new(0, 5)
            
            b.MouseButton1Click:Connect(function()
                b.Text = "FORZANDO..."
                IntentarDuplicarTotal(item.Name)
                wait(2)
                b.Text = "ENVIADO"
                wait(1)
                b.Text = "FORZAR DUPE"
            end)
        end
    end
end

local Ref = Instance.new("TextButton", MainFrame)
Ref.Size = UDim2.new(1, -30, 0, 40)
Ref.Position = UDim2.new(0, 15, 1, -50)
Ref.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
Ref.Text = "ACTUALIZAR INVENTARIO"
Ref.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", Ref).CornerRadius = UDim.new(0, 10)
Ref.MouseButton1Click:Connect(updateList)

updateList()
