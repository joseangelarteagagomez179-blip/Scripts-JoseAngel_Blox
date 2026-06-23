-- Script Propio | Duplicar Brainrots (Reales)
-- Creado para Kick A Lucky Block

local args = {
    [1] = "Dupe",
    [2] = game:GetService("Players").LocalPlayer.Character
}

-- Función para duplicar
local function Duplicar()
    fireproximityprompt(workspace.Base.DropPrompt)
    game:GetService("ReplicatedStorage").Remotes:InvokeServer(unpack(args))
    print("✅ Brainrot Duplicado!")
end

-- Crear GUI simple para activarlo
local GUI = Instance.new("ScreenGui")
local Btn = Instance.new("TextButton")

GUI.Name = "MiScript"
GUI.Parent = game:GetService("CoreGui")

Btn.Parent = GUI
Btn.Size = UDim2.new(0, 200, 0, 50)
Btn.Position = UDim2.new(0.1, 0, 0.1, 0)
Btn.BackgroundColor3 = Color3.new(0, 0, 0)
Btn.Text = "👉 DUPLICAR"
Btn.TextColor3 = Color3.new(1,1,1)
Btn.Font = "GothamBold"
Btn.TextSize = 20

-- Al hacer clic, se duplica
Btn.MouseButton1Click:Connect(Duplicar)

print("🚀 Script cargado. Presiona el botón!")
