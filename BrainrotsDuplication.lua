-- ==============================================
-- **DUPLICADOR DE BRAINROTS - KICK A LUCKY BLOCK**
-- **FUNCIONA EN DELTA EXECUTOR (ROBLOX)**
-- ==============================================

-- Primero verificamos que el juego esté cargado
if not game:IsLoaded() then
    game.Loaded:Wait()
end
print("✅ Juego cargado - Iniciando duplicador de Brainrots")

-- Buscamos el sistema de inventario o datos del jugador
local jugador = game.Players.LocalPlayer
local datosJugador = jugador:FindFirstChild("leaderstats") or jugador:FindFirstChild("PlayerData")
local brainrots = nil

-- Buscamos la variable de Brainrots en los datos del jugador
for _, dato in pairs(datosJugador:GetChildren()) do
    if dato.Name:lower() == "brainrots" or dato.Name:lower() == "brainrot" then
        brainrots = dato
        break
    end
end

-- Si no encontramos los Brainrots, intentamos buscar en el inventario del juego
if not brainrots then
    local inventario = jugador:FindFirstChild("Inventory") or workspace:FindFirstChild("Inventory_"..jugador.Name)
    if inventario then
        for _, item in pairs(inventario:GetChildren()) do
            if item.Name:lower() == "brainrots" then
                brainrots = item:FindFirstChild("Count") or item
                break
            end
        end
    end
end

-- Verificamos que se encontraron los Brainrots
if not brainrots then
    warn("❌ No se encontraron los Brainrots en tu inventario!")
    warn("Intenta jugar un rato primero o actualiza el script si el nombre del ítem cambió")
    return
end

print("✅ Brainrots encontrados - Cantidad actual: " .. brainrots.Value)

-- ==============================================
-- ## FUNCIÓN DE DUPLICACIÓN
-- ==============================================
local function duplicarBrainrots(factor)
    -- Evitamos valores inválidos
    factor = factor or 2
    if factor < 1 then factor = 2 end
    
    local cantidadActual = brainrots.Value
    local cantidadNueva = cantidadActual * factor
    
    -- Mostramos confirmación
    print("\n⚠️ ¿Confirmar duplicación?")
    print("   - Antes: " .. cantidadActual .. " Brainrots")
    print("   - Después: " .. cantidadNueva .. " Brainrots (x" .. factor .. ")")
    
    -- Esperamos un segundo antes de duplicar (para que puedas ver la confirmación)
    wait(1)
    
    -- Modificamos el valor en el inventario
    brainrots.Value = cantidadNueva
    print("✅ DUPLICACIÓN EXITOSA! Nueva cantidad: " .. brainrots.Value)
end

-- ==============================================
-- ## MENU PRINCIPAL
-- ==============================================
print("\n=====================================")
print("**DUPLICADOR LISTO PARA USAR**")
print("Comandos disponibles en el chat de Roblox:")
print("- !duplicar → Duplica los Brainrots (x2)")
print("- !duplicarX → Duplica x3 (cambia el número para más)")
print("- !duplicar5 → Duplica x5")
print("- !ver → Muestra la cantidad actual de Brainrots")
print("=====================================")

-- Escuchamos comandos desde el chat del jugador
jugador.Chatted:Connect(function(mensaje)
    mensaje = mensaje:lower()
    
    if mensaje == "!duplicar" then
        duplicarBrainrots(2)
    elseif mensaje == "!duplicar3" then
        duplicarBrainrots(3)
    elseif mensaje == "!duplicar4" then
        duplicarBrainrots(4)
    elseif mensaje == "!duplicar5" then
        duplicarBrainrots(5)
    elseif mensaje == "!ver" then
        print("📊 Cantidad actual de Brainrots: " .. brainrots.Value)
        -- También lo enviamos al chat del juego
        jugador:SendNotification("Tienes " .. brainrots.Value .. " Brainrots en tu inventario")
    elseif string.sub(mensaje, 1, 9) == "!duplicarx" then
        local factor = tonumber(string.sub(mensaje, 10))
        if factor then
            duplicarBrainrots(factor)
        else
            jugador:SendNotification("Usa el comando así: !duplicarX (ej: !duplicar6)")
        end
    end
end)

-- Duplicación automática inicial (opcional)
-- duplicarBrainrots(2) -- Descomenta esta línea si quieres duplicar al iniciar el script
