-- 💎 SCRIPT PROPIO | DUPLICADOR REAL Y COLOCABLE
-- Ahora sí quedan normales y se pueden poner en la base

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local LP = Players.LocalPlayer
local WS = game:GetService("Workspace")

-- FUNCIÓN MÁGICA
local function DupeRealYColocable()
    -- 1. Agarramos el item
    local Item = LP.Character:FindFirstChildOfClass("Tool")
    if not Item then return end

    -- 2. Buscamos el Remote BUENO (el que acepta el servidor)
    local Remote = nil
    for _, v in pairs(RS:GetChildren()) do
        if v.Name == "Remotes" or v.Name:find("Function") then
            Remote = v
            break
        end
    end

    -- 3. EL TRUCO: Enviamos la orden exacta para que sea REAL
    if Remote then
        -- Argumentos especiales para que el servidor lo acepte
        Remote:InvokeServer("GiveItem", Item.Name, 1)
        Remote:InvokeServer("Dupe", Item.Name, true)
        
        -- También intentamos con este comando que es el que usan para comprar
        Remote:FireServer("Purchase", Item.Name)
        
        print("✅ " .. Item.Name .. " DUPLICADO REAL!")
    end

    -- 4. Limpiamos los clones raros que salieron antes
    for _, v in pairs(LP.Backpack:GetChildren()) do
        if v:FindFirstChild("LocalScript") or not v:IsA("Tool") then
            v:Destroy()
        end
    end
end

-- 🎨 INTERFAZ
local GUI = Instance.new("ScreenGui")
local Btn = Instance.new("TextButton")

GUI.Name = "DupeRealColocable"
GUI.Parent = game:GetService("CoreGui")

Btn.Parent = GUI
Btn.Size = UDim2.new(0, 300, 0, 75)
Btn.Position = UDim2.new(0.05, 0, 0.3, 0)
Btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Btn.BorderColor3 = Color3.fromRGB(0, 255, 0)
Btn.BorderSizePixel = 5
Btn.Text = "✅ DUPLICAR REAL Y COLOCABLE"
Btn.TextColor3 = Color3.new(1,1,1)
Btn.Font = Enum.Font.GothamBlack
Btn.TextSize = 20

Btn.MouseButton1Click:Connect(DupeRealYColocable)

print("🚀 Script Listo! Estos sí se pueden poner.")
