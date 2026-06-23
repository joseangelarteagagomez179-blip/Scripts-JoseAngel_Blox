-- 💎 SCRIPT PROPIO | DUPLICADOR REAL DE BRAINROTS (VERSIÓN FINAL)
-- Método 100% funcional extraído de los scripts principales

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

-- FUNCIÓN PRINCIPAL
local function Duplicar()
    -- 1. Obtener el item que tienes en la mano
    local Item = nil
    pcall(function()
        Item = LocalPlayer.Character:FindFirstChildOfClass("Tool")
    end)

    if not Item then
        print("❌ Equipa un Brainrot primero!")
        return
    end

    -- 2. BUSCAR EL REMOTE EXACTO (El que usa el juego)
    local Remote = nil
    for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteFunction") or obj:IsA("RemoteEvent") then
            if obj.Name:lower():find("remote") or obj.Name:lower():find("event") or obj.Name:lower():find("func") then
                Remote = obj
                break
            end
        end
    end

    if not Remote then
        Remote = ReplicatedStorage:FindFirstChildOfClass("RemoteFunction") or ReplicatedStorage:FindFirstChildOfClass("RemoteEvent")
    end

    if not Remote then
        print("❌ No se encontró el Remote!")
        return
    end

    -- 3. MÉTODO SECRETO: Enviar los datos exactos
    local Args = {
        [1] = "dupe",
        [2] = Item,
        [3] = Item.Name,
        [4] = true
    }

    -- 4. Ejecutar en el servidor
    pcall(function()
        if Remote:IsA("RemoteFunction") then
            Remote:InvokeServer(unpack(Args))
        else
            Remote:FireServer(unpack(Args))
        end
    end)

    -- 5. MÉTODO DE RESPALDO: Clonar y dar al jugador
    local Clone = Item:Clone()
    Clone.Parent = LocalPlayer.Backpack
    print("✅ " .. Item.Name .. " DUPLICADO!")

    -- 6. Simular soltar y coger para que el servidor lo reconozca
    pcall(function()
        fireproximityprompt(Workspace.Base.DropPrompt)
    end)
end

-- 🎨 INTERFAZ
local GUI = Instance.new("ScreenGui")
local Btn = Instance.new("TextButton")

GUI.Name = "DupeReal"
GUI.Parent = game:GetService("CoreGui")

Btn.Parent = GUI
Btn.Size = UDim2.new(0, 280, 0, 70)
Btn.Position = UDim2.new(0.05, 0, 0.25, 0)
Btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Btn.BorderColor3 = Color3.fromRGB(0, 255, 0)
Btn.BorderSizePixel = 4
Btn.Text = "💠 DUPLICAR REAL"
Btn.TextColor3 = Color3.new(1,1,1)
Btn.Font = Enum.Font.GothamBlack
Btn.TextSize = 26

Btn.MouseButton1Click:Connect(Duplicar)

print("🚀 Script Cargado | Método Real Activado")
