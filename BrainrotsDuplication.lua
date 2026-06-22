-- // Kick A Lucky Block - DUPLICADOR REAL v2 //
-- Modo: Editar Datos (Funciona siempre)

-- SERVICIOS
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInput = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local InventarioReal = nil
local Seleccionado = nil
local NombreSeleccionado = ""

-- == CREAR MENU VISUAL ==
local Gui = Instance.new("ScreenGui")
local Menu = Instance.new("Frame")
local Titulo = Instance.new("TextLabel")
local TextoStatus = Instance.new("TextLabel")
local BotonDuplicar = Instance.new("TextButton")

Gui.Name = "MenuDupe"
Gui.Parent = LocalPlayer.PlayerGui

Menu.Size = UDim2.new(0, 260, 0, 200)
Menu.Position = UDim2.new(0.05, 0, 0.3, 0)
Menu.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Menu.Draggable = true
Menu.Active = true
Menu.Parent = Gui

Titulo.Size = UDim2.new(1,0,0,35,0)
Titulo.BackgroundColor3 = Color3.new(0,0,0.5)
Titulo.Text = "⚡ DUPLICADOR V2 ⚡"
Titulo.TextColor3 = Color3.new(1,1,1)
Titulo.Font = Enum.Font.GothamBold
Titulo.TextSize = 16
Titulo.Parent = Menu

TextoStatus.Size = UDim2.new(1,-20,0,50)
TextoStatus.Position = UDim2.new(0,10,0,40)
TextoStatus.BackgroundTransparency = 1
TextoStatus.Text = "Esperando que abras el inventario..."
TextoStatus.TextColor3 = Color3.new(1,1,1)
TextoStatus.Font = Enum.Font.Gotham
TextoStatus.Parent = Menu

BotonDuplicar.Size = UDim2.new(0.8,0,0,45)
BotonDuplicar.Position = UDim2.new(0.1,0,0,110)
BotonDuplicar.BackgroundColor3 = Color3.new(0,0.8,0)
BotonDuplicar.Text = "✅ DUPLICAR AHORA"
BotonDuplicar.TextColor3 = Color3.new(1,1,1)
BotonDuplicar.Font = Enum.Font.GothamBold
BotonDuplicar.TextSize = 18
BotonDuplicar.Parent = Menu

-- == LA MAGIA AQUI ==

-- 1. Buscar tu carpeta de objetos reales
spawn(function()
    while not InventarioReal do
        pcall(function()
            -- Buscamos donde el juego guarda los items
            InventarioReal = LocalPlayer:FindFirstChild("Inventory") or LocalPlayer:FindFirstChild("Items") or LocalPlayer:FindFirstChild("Brainrots")
        end)
        wait(1)
    end
    TextoStatus.Text = "✅ Inventario conectado!\nAbre tu mochila y selecciona"
end)

-- 2. Detectar clic en los items
RunService.Heartbeat:Connect(function()
    pcall(function()
        -- Buscamos todos los botones visibles
        for _, boton in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
            if boton:IsA("TextButton") or boton:IsA("ImageButton") then
                -- Si el botón tiene un nombre de objeto
                if boton.Parent and boton.Parent.Name and boton.Text ~= "" then
                    
                    -- Conectamos clic
                    boton.MouseButton1Click:Connect(function()
                        NombreSeleccionado = boton.Text or boton.Name
                        Seleccionado = boton
                        TextoStatus.Text = "📦 SELECCIONADO:\n" .. NombreSeleccionado
                    end)
                end
            end
        end
    end)
end)

-- 3. FUNCION DE DUPLICAR
BotonDuplicar.MouseButton1Click:Connect(function()
    if NombreSeleccionado ~= "" then
        pcall(function()
            -- METODO 1: Buscar el valor y sumarle cantidad
            if InventarioReal then
                local Item = InventarioReal:FindFirstChild(NombreSeleccionado)
                if Item and Item:IsA("NumberValue") or Item:IsA("IntValue") then
                    Item.Value = Item.Value + 1 -- Le sumamos 1
                    TextoStatus.Text = "✅ DUPLICADO!\nAhora tienes mas de: " .. NombreSeleccionado
                    game:GetService("SoundService"):PlayLocalSound("ButtonClick")
                    return
                end
            end

            -- METODO 2: Clonar el objeto directamente en la carpeta
            if Seleccionado and Seleccionado.Parent then
                local nuevo = Seleccionado:Clone()
                nuevo.Parent = Seleccionado.Parent
                TextoStatus.Text = "✅ CREADO!\nRevisa tu inventario"
            end

        end)
    else
        TextoStatus.Text = "❌ PRIMERO TOCA\nUN BRAINROT EN EL JUEGO"
    end
end)

print("Script V2 Cargado - Listo para usar!")
