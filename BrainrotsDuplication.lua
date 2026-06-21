-- // DOLA - SCRIPT DUPLICADOR AVANZADO \\
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- == CONFIGURACIÓN ==
local NOMBRE_OBJETO = "Brainrot" -- Nombre exacto o aproximado
local CANTIDAD_POR_DUPLICADO = 10 -- Cuantos quieres que salgan cada vez
-- ===================

-- Función principal
local function DuplicarAvanzado()
    -- METODO 1: Buscar en Leaderstats o Características (Valores)
    for _, v in pairs(LocalPlayer:GetChildren()) do
        -- Buscamos si es un NumberValue, IntValue, etc.
        if v:IsA("NumberValue") or v:IsA("IntValue") or v:IsA("StringValue") then
            if string.find(v.Name:lower(), NOMBRE_OBJETO:lower()) then
                -- Si es numero, lo aumentamos
                if typeof(v.Value) == "number" then
                    v.Value = v.Value + CANTIDAD_POR_DUPLICADO
                    print("✅ Valor modificado! Nueva cantidad: "..v.Value)
                    return
                end
            end
        end
    end

    -- METODO 2: Si no hay valores, clonamos directamente en el Backpack o Inventario
    local CarpetaInventario = LocalPlayer:FindFirstChild("Backpack") or LocalPlayer:FindFirstChild("Inventory") or LocalPlayer.PlayerGui
    for _, Item in pairs(CarpetaInventario:GetChildren()) do
        if string.find(Item.Name:lower(), NOMBRE_OBJETO:lower()) then
            -- Hacemos varios clones a la vez
            for i = 1, CANTIDAD_POR_DUPLICADO do
                local Clon = Item:Clone()
                Clon.Parent = Item.Parent
                -- Truco avanzado: Cambiamos ligeramente el ID o propiedades para que el servidor no lo borre
                if Clon:FindFirstChild("OwnerId") then Clon.OwnerId.Value = LocalPlayer.UserId end
            end
            print("✅ Duplicado exitoso! x"..CANTIDAD_POR_DUPLICADO)
            return
        end
    end

    -- Si no encontró nada
    print("❌ No se encontró el Brainrot")
end

-- == INTERFAZ BONITA ==
local Gui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local BtnDuplicar = Instance.new("TextButton")

Gui.Name = "DolaHub"
Gui.Parent = LocalPlayer.PlayerGui
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Parent = Gui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 250, 0, 100)
MainFrame.BorderSizePixel = 0
MainFrame.Draggable = true -- Para que lo puedas mover

BtnDuplicar.Parent = MainFrame
BtnDuplicar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
BtnDuplicar.Size = UDim2.new(0.8, 0, 0.6, 0)
BtnDuplicar.Position = UDim2.new(0.1, 0, 0.2, 0)
BtnDuplicar.Text = "DUPLICAR BRAINROT"
BtnDuplicar.TextColor3 = Color3.new(1,1,1)
BtnDuplicar.Font = Enum.Font.GothamBold
BtnDuplicar.TextSize = 16

-- Acción del botón
BtnDuplicar.MouseButton1Click:Connect(DuplicarAvanzado)

print("🚀 Script Avanzado Cargado!")
