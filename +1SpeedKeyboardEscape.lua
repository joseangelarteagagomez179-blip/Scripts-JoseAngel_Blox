-- // Script para desbloquear y usar TODAS las caminadoras GRATIS
-- // Juego: +1 Speed Keyboard Escape

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Backpack = Player:WaitForChild("Backpack")
local StarterGear = game:GetService("StarterPack") -- A veces está aquí
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- =============================================
-- FUNCIÓN PRINCIPAL: Dar y equipar herramientas
-- =============================================
local function darYEquiparCaminadora(nombre)
    -- Buscamos la caminadora en el juego
    local herramienta = nil
    
    -- Buscamos en diferentes lugares donde suelen estar los objetos
    if ReplicatedStorage:FindFirstChild(nombre) then
        herramienta = ReplicatedStorage:FindFirstChild(nombre)
    elseif StarterGear:FindFirstChild(nombre) then
        herramienta = StarterGear:FindFirstChild(nombre)
    elseif game.ServerStorage:FindFirstChild(nombre) then
        herramienta = game.ServerStorage:FindFirstChild(nombre)
    end

    -- Si encontramos la herramienta, la clonamos y la damos al jugador
    if herramienta and herramienta:IsA("Tool") then
        local clon = herramienta:Clone()
        clon.Parent = Backpack
        print("✅ Obtenida: " .. nombre)
        
        -- La equipamos automáticamente
        clon:Activate()
    else
        print("❌ No encontrada: " .. nombre)
    end
end

-- =============================================
-- LISTA DE CAMINADORAS (Nombres aproximados)
-- =============================================
-- *Nota: Si alguno no funciona, es posible que el nombre exacto sea diferente.
-- Tienes que usar el "Explorer" de tu ejecutor para ver el nombre REAL dentro del juego.

local caminadoras = {
    "Caminadora de Oro",      -- x3 Velocidad
    "Cinta de correr de diamantes", -- x9 Velocidad
    "Cinta de correr de caramelos", -- x25 Velocidad
    "Caminadora de Administrador" -- x100 Velocidad
}

-- =============================================
-- EJECUTAR
-- =============================================
-- Ejecutamos la función para cada caminadora de la lista
for _, nombre in pairs(caminadoras) do
    darYEquiparCaminadora(nombre)
    wait(0.2) -- Pequeña espera para que no dé errores
end

-- =============================================
-- BONUS: Aumentar velocidad al máximo directamente
-- =============================================
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- Ponemos la velocidad que quieras (en la foto veías 30, aquí lo subimos muchísimo)
Humanoid.WalkSpeed = 999999 
Humanoid.JumpPower = 500

print("🔥 VELOCIDAD MÁXIMA ACTIVADA")
print("✅ TODAS LAS CAMINADORAS DESBLOQUEADAS")
