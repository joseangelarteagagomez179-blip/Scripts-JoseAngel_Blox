--[[
    Script: Duplicador de Brainrots | MOBILE
    Juego: Kick a Lucky Block
    Autor: Tu Nombre
    Descripción: Duplica Brainrots con un botón en pantalla
    Compatible con: Delta, Arceus X, Hydrogen, Fluxus y más
]]

-- Servicios
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Función de duplicación
local function duplicar()
    -- Inventario
    local Backpack = LocalPlayer:FindFirstChild("Backpack")
    if Backpack then
        for _, item in pairs(Backpack:GetChildren()) do
            if item:IsA("Tool") and item.Name:lower():find("brainrot") then
                local clone = item:Clone()
                clone.Parent = Backpack
            end
        end
    end

    -- Terreno/Base
    local base = workspace:FindFirstChild(LocalPlayer.Name .. "'s Base") or workspace:FindFirstChild("Base_"..LocalPlayer.UserId)
    if base then
        for _, obj in pairs(base:GetChildren()) do
            if obj.Name:lower():find("brainrot") then
                local clone = obj:Clone()
                clone.Parent = base
            end
        end
    end

    -- Notificación
    StarterGui:SetCore("SendNotification", {
        Title = "✅ Éxito";
        Text = "Brainrots duplicados!";
        Duration = 2;
    })
end

-- Crear Botón en Pantalla
local ScreenGui = Instance.new("ScreenGui")
local Boton = Instance.new("TextButton")

ScreenGui.Name = "DuplicadorGui"
ScreenGui.Parent = LocalPlayer.PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Boton.Name = "BotonDuplicar"
Boton.Parent = ScreenGui
Boton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Boton.Position = UDim2.new(0.05, 0, 0.4, 0) -- Posición izquierda
Boton.Size = UDim2.new(0, 120, 0, 50)
Boton.Font = Enum.Font.GothamBold
Boton.Text = "DUPLICAR 🧠"
Boton.TextColor3 = Color3.new(1, 1, 1)
Boton.TextSize = 18
Boton.BorderSizePixel = 0
Boton.CornerRadius = UDim.new(0, 10)

-- Efecto de sombra
local UIStroke = Instance.new("UIStroke")
UIStroke.Parent = Boton
UIStroke.Thickness = 2
UIStroke.Color = Color3.new(0,0,0)

-- Acción al tocar
Boton.MouseButton1Click:Connect(duplicar)

-- Hacer el botón arrastrable
local dragging, dragStart, startPos = false, nil, nil

Boton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Boton.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local Delta = input.Position - dragStart
        Boton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
    end
end)

print("🚀 Script Móvil cargado! Toca el botón ROJO para duplicar")
