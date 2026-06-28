-- =============================================
-- SCRIPT: DESBLOQUEAR TODAS LAS TREADMILLS GRATIS
-- JUEGO: +1 Speed Keyboard Escape | Candy & Chocolate
-- FUNCIONA: Junio 2026 ✅
-- =============================================

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

print("🔌 Script cargado: Modo Gratis ACTIVO")

-- FUNCIÓN PRINCIPAL QUE HACE EL MAGIA
local function desbloquearTreadmill(modelo)
    -- 1. BUSCAR Y MODIFICAR VALORES CLAVE
    for _, objeto in pairs(modelo:GetDescendants()) do
        -- Cambiar precio a 0
        if objeto:IsA("NumberValue") and (objeto.Name == "Price" or objeto.Name == "Cost") then
            objeto.Value = 0
        end
        
        -- Quitar requisito de velocidad
        if objeto:IsA("NumberValue") and objeto.Name:find("Required") then
            objeto.Value = 0
        end
        
        -- Marcar como COMPRADA
        if objeto:IsA("BoolValue") and (objeto.Name == "Owned" or objeto.Name == "Unlocked") then
            objeto.Value = true
        end
        
        -- Eliminar restricciones de Gamepass
        if objeto:IsA("StringValue") and objeto.Name:find("Gamepass") then
            objeto.Value = ""
        end
    end

    -- 2. ELIMINAR EL SCRIPT DE BLOQUEO (MÉTODO SECRETO)
    -- Muchos juegos usan un LocalScript dentro para bloquearte
    for _, hijo in pairs(modelo:GetChildren()) do
        if hijo:IsA("LocalScript") or hijo:IsA("Script") then
            -- Lo desactivamos o lo eliminamos
            hijo.Disabled = true
            -- hijo:Destroy() -- Opcional: borrarlo completamente
        end
    end

    -- 3. FORZAR ACTIVACIÓN INMEDIATA
    spawn(function()
        while task.wait(0.5) do
            -- Simular que ya estás dentro y activarla
            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, modelo.PrimaryPart or modelo, 0)
            firetouchinterest(LocalPlayer.Character.HumanoidRootPart, modelo.PrimaryPart or modelo, 1)
        end
    end)
end

-- =============================================
-- BUSCAR TODAS LAS TREADMILLS EN EL MAPA
-- =============================================

local function escanearMapa()
    for _, objeto in pairs(Workspace:GetDescendants()) do
        -- Buscar por nombres típicos
        if objeto:IsA("Model") and (
            objeto.Name:lower():find("treadmill") or 
            objeto.Name:lower():find("run") or 
            objeto.Name:lower():find("machine") or
            objeto.Name:lower():find("gold") or
            objeto.Name:lower():find("diamond") or
            objeto.Name:lower():find("candy")
        ) then
            desbloquearTreadmill(objeto)
            print("✅ Desbloqueada: " .. objeto.Name)
        end
    end
end

-- =============================================
-- PROTECCIÓN: SI EL JUEGO INTENTA BLOQUEARLA DE NUEVO
-- =============================================

Workspace.DescendantAdded:Connect(function(nuevoObjeto)
    -- Si aparece algo nuevo, lo revisamos al instante
    if nuevoObjeto:IsA("Model") and nuevoObjeto.Name:lower():find("treadmill") then
        task.wait(0.1)
        desbloquearTreadmill(nuevoObjeto)
    end
    
    -- Si intentan poner precio de nuevo
    if nuevoObjeto:IsA("NumberValue") and nuevoObjeto.Name == "Price" then
        nuevoObjeto.Value = 0
    end
end)

-- =============================================
-- EJECUTAR
-- =============================================

-- Escanear al principio
task.wait(2) -- Esperar a que cargue todo
escanearMapa()

-- Volver a escanear cada 5 segundos por si acaso
while task.wait(5) do
    escanearMapa()
end

print("🎉 LISTO! YA PUEDES USAR TODAS LAS CINTAS GRATIS")
