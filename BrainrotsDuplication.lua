-- 🧠 Script Propio | Duplicar Brainrots (ACTUALIZADO)
-- Para Kick A Lucky Block

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- FUNCIÓN PRINCIPAL
local function DuplicarBrainrot()
    -- Buscamos el Remote correcto
    local Remote = nil
    for _, v in pairs(ReplicatedStorage:GetChildren()) do
        if v.Name:lower():find("remote") or v.Name:lower():find("event") then
            Remote = v
            break
        end
    end

    if not Remote then
        Remote = ReplicatedStorage:FindFirstChildWhichIsA("RemoteFunction") or ReplicatedStorage:FindFirstChildWhichIsA("RemoteEvent")
    end

    -- Obtener el item que tienes en la mano
    local Character = LocalPlayer.Character
    local Item = nil
    
    -- Buscar en la mochila o herramienta equipada
    if LocalPlayer.Backpack then
        Item = LocalPlayer.Backpack:GetChildren()[1]
    end
    if not Item and Character then
        Item = Character:FindFirstChildOfClass("Tool") or Character:GetChildren()[2]
    end

    if Item then
        -- Método de duplicación
        local Args = {
            [1] = "dupe",
            [2] = Item.Name,
            [3] = Item
        }

        -- Disparar al servidor
        if Remote:IsA("RemoteFunction") then
            Remote:InvokeServer(unpack(Args))
        else
            Remote:FireServer(unpack(Args))
        end

        -- También intentamos con el método de soltar y coger
        fireproximityprompt(workspace.Base.DropPrompt)
        wait(0.1)
        print("✅ Brainrot: " .. Item.Name .. " Duplicado!")
    else
        print("❌ No encontré ningún Brainrot equipado!")
    end
end

-- 🎨 INTERFAZ
local GUI = Instance.new("ScreenGui")
local Btn = Instance.new("TextButton")

GUI.Name = "MiScript"
GUI.Parent = game:GetService("CoreGui")
GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Btn.Parent = GUI
Btn.Size = UDim2.new(0, 220, 0, 60)
Btn.Position = UDim2.new(0.05, 0, 0.15, 0)
Btn.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Btn.BorderSizePixel = 2
Btn.BorderColor3 = Color3.new(1, 0, 0)
Btn.Text = "🔥 DUPLICAR"
Btn.TextColor3 = Color3.new(1,1,1)
Btn.Font = Enum.Font.GothamBold
Btn.TextSize = 22

-- Efecto al presionar
Btn.MouseButton1Down:Connect(function()
    Btn.BackgroundColor3 = Color3.new(0.3,0,0)
end)
Btn.MouseButton1Up:Connect(function()
    Btn.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
end)

Btn.MouseButton1Click:Connect(DuplicarBrainrot)

print("🚀 Script Listo! Equipa un Brainrot y dale al botón.")
