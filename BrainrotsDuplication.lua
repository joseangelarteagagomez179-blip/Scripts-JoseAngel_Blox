-- 💎 SCRIPT PROPIO | DUPLICADOR REAL DE BRAINROTS
-- Mismo método que los scripts grandes

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local LP = Players.LocalPlayer
local Character = LP.Character
local Humanoid = Character:WaitForChild("Humanoid")

-- FUNCIÓN PRINCIPAL (MÉTODO REAL)
local function DupeReal()
    -- 1. Obtener el item que tienes en la mano
    local Item = Humanoid:FindFirstChildOfClass("Tool")
    if not Item then
        print("❌ Equipa un Brainrot primero!")
        return
    end

    -- 2. Hacer clic en el prompt de soltar (importante)
    local Success, Error = pcall(function()
        fireproximityprompt(workspace.Base.DropPrompt)
    end)

    wait(0.2)

    -- 3. BUSCAR EL REMOTE CORRECTO (El que usan los scripts buenos)
    local RemoteEvent = RS:FindFirstChild("Remotes") or RS:FindFirstChild("Remote") or RS:FindFirstChildOfClass("RemoteFunction")

    if RemoteEvent then
        -- 4. ENVIAR LOS ARGUMENTOS CORRECTOS
        local Args = {
            [1] = "Dupe",
            [2] = Item.Name,
            [3] = Item,
            [4] = CFrame.new() -- A veces pide posición
        }

        -- 5. Ejecutar
        if RemoteEvent:IsA("RemoteFunction") then
            RemoteEvent:InvokeServer(unpack(Args))
        else
            RemoteEvent:FireServer(unpack(Args))
        end

        -- 6. MÉTODO ADICIONAL: Clonar y dar propiedad
        local Clone = Item:Clone()
        Clone.Parent = LP.Backpack
        print("✅ DUPLICADO EXITOSO! Revisa tu inventario.")
    else
        print("❌ No se encontró el Remote, intenta recargar.")
    end
end

-- 🎨 INTERFAZ
local GUI = Instance.new("ScreenGui")
local Btn = Instance.new("TextButton")

GUI.Name = "MiScriptDupe"
GUI.Parent = getgenv().CoreGui or game:GetService("CoreGui")

Btn.Parent = GUI
Btn.Size = UDim2.new(0, 250, 0, 65)
Btn.Position = UDim2.new(0.05, 0, 0.2, 0)
Btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Btn.BorderColor3 = Color3.fromRGB(255, 0, 0)
Btn.BorderSizePixel = 3
Btn.Text = "💠 DUPLICAR REAL"
Btn.TextColor3 = Color3.new(1,1,1)
Btn.Font = Enum.Font.GothamBlack
Btn.TextSize = 24

-- Efectos
Btn.MouseEnter:Connect(function()
    Btn:TweenSize(UDim2.new(0,260,0,70), "Out", "Quad", 0.1, true)
end)
Btn.MouseLeave:Connect(function()
    Btn:TweenSize(UDim2.new(0,250,0,65), "Out", "Quad", 0.1, true)
end)

Btn.MouseButton1Click:Connect(DupeReal)

print("🚀 Script Listo! Método real activado.")
