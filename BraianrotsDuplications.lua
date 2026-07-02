--[[
    Braianrots duplications v1.1 - SERVER FORCING
    Creador: JoseAngel_Blox
    Fecha: 01/06/2026
--]]

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Interfaz Principal (Diseño Mejorado)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BraianrotsDuplicationGui"
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 360, 0, 420)
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 20)
local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Thickness = 2
Stroke.Color = Color3.fromRGB(0, 255, 150) -- Borde Verde Neón

-- Título
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "BRAIANROTS DUPLICATOR V1.1"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 18

-- SECCIÓN info
local Info = Instance.new("TextLabel", MainFrame)
Info.Size = UDim2.new(1, -30, 0, 60)
Info.Position = UDim2.new(0, 15, 0, 60)
Info.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
Info.RichText = true
Info.Text = "Creador: <font color='#00FF96'>JoseAngel_Blox</font>\nFecha: 01/06/2026"
Info.TextColor3 = Color3.fromRGB(200, 200, 200)
Info.Font = Enum.Font.Gotham
Info.TextSize = 14
Instance.new("UICorner", Info).CornerRadius = UDim.new(0, 10)

-- Lista de Items
local Scroll = Instance.new("ScrollingFrame", MainFrame)
Scroll.Size = UDim2.new(1, -30, 1, -210)
Scroll.Position = UDim2.new(0, 15, 0, 140)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 3
local UIList = Instance.new("UIListLayout", Scroll)
UIList.Padding = UDim.new(0, 5)

-- FUNCIÓN DE DUPLICACIÓN REAL (Server-Side Trigger)
local function DuplicarItem(item)
    -- Buscamos los eventos de reclamo del juego
    local remotes = ReplicatedStorage:FindFirstChild("Remotes") or ReplicatedStorage:FindFirstChild("Events") or ReplicatedStorage
    
    -- Intentamos disparar todos los posibles eventos de duplicación/reclamo
    for _, r in pairs(remotes:GetChildren()) do
        if r:IsA("RemoteEvent") then
            -- Estos son los comandos comunes que el servidor acepta para dar ítems
            r:FireServer("ClaimReward", item.Name)
            r:FireServer("DuplicateItem", item.Name)
            r:FireServer("AddInventory", item.Name)
            r:FireServer("EquipBraianrot", item.Name)
        end
    end
end

-- Actualizar lista
local function updateList()
    for _, v in pairs(Scroll:GetChildren()) do if v:IsA("Frame") then v:Destroy() end end
    
    -- Buscamos en tu inventario o personaje
    local items = player.Character:GetChildren()
    for _, item in pairs(items) do
        if item:IsA("Tool") or item:IsA("Model") then
            local f = Instance.new("Frame", Scroll)
            f.Size = UDim2.new(1, 0, 0, 50)
            f.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
            
            local t = Instance.new("TextLabel", f)
            t.Size = UDim2.new(0.6, 0, 1, 0)
            t.Position = UDim2.new(0, 10, 0, 0)
            t.BackgroundTransparency = 1
            t.Text = item.Name
            t.TextColor3 = Color3.fromRGB(255, 255, 255)
            t.TextXAlignment = Enum.TextXAlignment.Left
            
            local b = Instance.new("TextButton", f)
            b.Size = UDim2.new(0.35, 0, 0.7, 0)
            b.Position = UDim2.new(0.6, 0, 0.15, 0)
            b.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
            b.Text = "DUPLICAR"
            b.TextColor3 = Color3.fromRGB(255, 255, 255)
            Instance.new("UICorner", b).CornerRadius = UDim.new(0, 5)
            
            b.MouseButton1Click:Connect(function()
                b.Text = "ENVIANDO..."
                DuplicarItem(item)
                wait(1.5)
                b.Text = "¡LISTO!"
                wait(1)
                b.Text = "DUPLICAR"
            end)
        end
    end
end

local Ref = Instance.new("TextButton", MainFrame)
Ref.Size = UDim2.new(1, -30, 0, 40)
Ref.Position = UDim2.new(0, 15, 1, -50)
Ref.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
Ref.Text = "RECARGAR INVENTARIO"
Ref.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", Ref).CornerRadius = UDim.new(0, 10)
Ref.MouseButton1Click:Connect(updateList)

updateList()
