-- // SCRIPT PARA +1 Speed Keyboard Escape
-- // CREADO POR TI - DESBLOQUEAR CAMINADORAS

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Backpack = Player.Backpack or Player:WaitForChild("Backpack")
local RS = game:GetService("ReplicatedStorage")

-- 📝 LISTA DE NOMBRES (Aquí es donde suele fallar, revisa bien)
local items = {
    "Gold Treadmill",      -- Probable nombre real en inglés
    "Diamond Treadmill",
    "Candy Treadmill",
    "Admin Treadmill"
}

-- FUNCIÓN PARA DAR OBJETOS
local function darItem(nombre)
    local item = RS:FindFirstChild(nombre) or game.ServerStorage:FindFirstChild(nombre)
    
    if item then
        local clon = item:Clone()
        clon.Parent = Backpack
        clon:Activate() -- Equipar automáticamente
        print("✅ CONSEGUIDO: " .. nombre)
    else
        warn("❌ NO ENCONTRADO: " .. nombre)
    end
end

-- EJECUTAR
wait(1)
for _,v in pairs(items) do
    darItem(v)
    wait(0.3)
end

-- 💨 VELOCIDAD INFINITA
local char = Player.Character or Player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
hum.WalkSpeed = 1000000
hum.JumpPower = 1000

print("🔥 VELOCIDAD MAXIMA ACTIVADA")
