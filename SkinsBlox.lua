-- ========================================================= --
-- ||        SCRIPT CREADOR DE CONTENIDO (SKINS V2)       || --
-- ========================================================= --

-- ⚙️ ELIGE EL MODO AQUÍ ⚙️
-- Escribe 1 para copiar a un jugador (por Nombre o ID).
-- Escribe 2 para cargar un Avatar/Atuendo completo por su ID.
local MODO_ELEGIDO = 1 


-- 👤 [ OPCIÓN 1: COPIAR JUGADOR ] --
-- Puedes poner el nombre del jugador entre comillas (Ej: "Roblox") 
-- O puedes poner el ID numérico sin comillas (Ej: 1)
local JUGADOR_OBJETIVO = "Roblox" 


-- 📦 [ OPCIÓN 2: AVATAR COMPLETO ] --
-- Coloca aquí el ID numérico del Avatar/Atuendo completo.
local ID_DEL_AVATAR = 0 


-- ========================================================= --
-- || 🚫 NO MODIFIQUES NADA DE AQUÍ PARA ABAJO 🚫         || --
-- ========================================================= --

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

if MODO_ELEGIDO == 1 then
    print("Buscando datos del jugador...")
    local userId = 0
    
    -- Detectar si escribiste un nombre (texto) o un ID (número)
    if type(JUGADOR_OBJETIVO) == "string" then
        local success, result = pcall(function()
            return game.Players:GetUserIdFromNameAsync(JUGADOR_OBJETIVO)
        end)
        if success then
            userId = result
        else
            warn("No se encontró ese nombre de usuario. Revisa cómo está escrito.")
            return
        end
    elseif type(JUGADOR_OBJETIVO) == "number" then
        userId = JUGADOR_OBJETIVO
    end

    -- Aplicar la skin del jugador
    local success, nuevaApariencia = pcall(function()
        return game.Players:GetHumanoidDescriptionFromUserId(userId)
    end)

    if success and nuevaApariencia then
        humanoid:ApplyDescription(nuevaApariencia)
        print("¡Éxito! Skin del jugador cargada localmente.")
    else
        warn("Error al cargar la skin del jugador. El perfil podría ser privado o el ID incorrecto.")
    end

elseif MODO_ELEGIDO == 2 then
    print("Cargando Avatar/Atuendo completo desde el catálogo...")
    
    -- Aplicar el avatar por ID de outfit
    local success, nuevaApariencia = pcall(function()
        return game.Players:GetHumanoidDescriptionFromOutfitId(ID_DEL_AVATAR)
    end)

    if success and nuevaApariencia then
        humanoid:ApplyDescription(nuevaApariencia)
        print("¡Éxito! Avatar completo cargado localmente.")
    else
        warn("Error al cargar el Avatar. Asegúrate de que el ID ingresado pertenezca a un Atuendo (Outfit ID) válido y público.")
    end

else
    warn("El MODO_ELEGIDO es incorrecto. Por favor escribe 1 o 2 en la configuración de
        arriba.")
end
