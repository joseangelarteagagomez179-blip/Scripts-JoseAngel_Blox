-- // SCRIPT ESPECIAL PARA KICK A LUCKY BLOCK - VERSION ACTUAL \\
-- // HECHO ESPECIALMENTE PARA QUE FUNCIONE CON 1 SOLO BRAINROT \\

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- == CONFIGURACIÓN ==
local NOMBRE_OBJETO = "Brainrot"
local CANTIDAD = 999 -- Cantidad que quieres
-- ===================

-- Función Super Duplicadora
local function SuperDuplicar()
    print("🔍 Buscando datos del Brainrot...")

    -- METODO 1: Buscar en Leaderstats y Stats
    local encontrado = false
    for _, objeto in pairs(LocalPlayer:GetChildren()) do
        pcall(function()
            if objeto:IsA("NumberValue") or objeto:IsA("IntValue") then
                if string.find(objeto.Name:lower(), NOMBRE_OBJETO:lower()) then
                    objeto.Value = objeto.Value + CANTIDAD
                    print("✅ ÉXITO! Ahora tienes: " .. objeto.Value)
                    encontrado = true
                end
            end
        end)
    end

    -- METODO 2: Buscar en Carpetas de Inventario (muy común en este juego)
    if not encontrado then
        for _, carpeta in pairs(LocalPlayer:GetChildren()) do
            if carpeta:IsA("Folder") then
                for _, item in pairs(carpeta:GetChildren()) do
                    pcall(function()
                        if string.find(item.Name:lower(), NOMBRE_OBJETO:lower()) then
                            -- Si tiene un valor de cantidad, lo modificamos
                            if item:FindFirstChild("Amount") or item:FindFirstChild("Count") or item:FindFirstChild("Value") then
                                local valor = item:FindFirstChild("Amount") or item:FindFirstChild("Count") or item:FindFirstChild("Value")
                                valor.Value = valor.Value + CANTIDAD
                                print("✅ Cantidad aumentada!")
                                encontrado = true
                            else
                                -- Si no tiene cantidad, lo clonamos dentro de su propia carpeta
                                local clon = item:Clone()
                                clon.Parent = item.Parent
                                print("✅ Item clonado en inventario!")
                                encontrado = true
                            end
                        end
                    end)
                end
            end
        end
    end

    -- METODO 3: Truco de Memoria (Nivel Avanzado)
    if not encontrado then
        -- Buscamos en todo el juego el string "Brainrot" y modificamos sus valores cercanos
        local success, err = pcall(function()
            for _, v in pairs(getgc(true)) do
                if typeof(v) == "table" and rawget(v, "Name") and string.find(tostring(rawget(v, "Name")):lower(), NOMBRE_OBJETO:lower()) then
                    if rawget(v, "Amount") then
                        rawset(v, "Amount", CANTIDAD)
                        print("✅ Modificado en memoria!")
                        encontrado = true
                        break
                    end
                end
            end
        end)
    end


    if encontrado then
        game.StarterGui:SetCore("SendNotification", {
            Title = "¡DUPLICADO!",
            Text = "Brainrots agregados con éxito!",
            Duration = 3
        })
    else
        print("❌ No se pudo duplicar automaticamente.")
        print("💡 Consejo: Abre el menú de Inventario del juego y vuelve a darle al botón.")
    end
end

-- == INTERFAZ MEJORADA ==
-- Borra GUI anteriores
if LocalPlayer.PlayerGui:FindFirstChild("DolaHub") then
    LocalPlayer.PlayerGui.DolaHub:Destroy()
end

local Gui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local BtnDuplicar = Instance.new("TextButton")
local Titulo = Instance.new("TextLabel")

Gui.Name = "DolaHub"
Gui.Parent = LocalPlayer.PlayerGui
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.ResetOnSpawn = false

MainFrame.Parent = Gui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.02, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0, 280, 0, 140)
MainFrame.BorderSizePixel = 0
MainFrame.Draggable = true
MainFrame.Active = true

Titulo.Parent = MainFrame
Titulo.Size = UDim2.new(1, 0, 0.2, 0)
Titulo.BackgroundTransparency = 1
Titulo.Text = "DOLA HUB - DUPLICADOR"
Titulo.TextColor3 = Color3.new(1,1,1)
Titulo.Font = Enum.Font.GothamBold
Titulo.TextSize = 16

BtnDuplicar.Parent = MainFrame
BtnDuplicar.BackgroundColor3 = Color3.fromRGB(255, 0, 50)
BtnDuplicar.Size = UDim2.new(0.9, 0, 0.5, 0)
BtnDuplicar.Position = UDim2.new(0.05, 0, 0.3, 0)
BtnDuplicar.Text = "🔥 DUPLICAR BRAINROT 🔥"
BtnDuplicar.TextColor3 = Color3.new(1,1,1)
BtnDuplicar.Font = Enum.Font.GothamBold
BtnDuplicar.TextSize = 18

-- Efecto al presionar
BtnDuplicar.MouseButton1Down:Connect(function()
    BtnDuplicar.BackgroundColor3 = Color3.fromRGB(200,0,0)
end)
BtnDuplicar.MouseButton1Up:Connect(function()
    BtnDuplicar.BackgroundColor3 = Color3.fromRGB(255,0,50)
end)

BtnDuplicar.MouseButton1Click:Connect(SuperDuplicar)

print("🚀 Script Cargado y Listo!")
