-- **DUPLICADOR DE BRAINROTS - INVENTARIO**
-- Script diseñado para duplicar los Brainrots existentes en tu inventario

-- ======================
-- ## CONFIGURACIÓN INICIAL
-- ======================
local inventario = {
    brainrots = 15, -- Cantidad ACTUAL de Brainrots en tu inventario
    otrosItems = { -- Ejemplo de otros ítems que podrías tener
        monedas = 250,
        potenciadores = 3
    }
}

-- Ajustes de duplicación
local configuracion = {
    factorDuplicacion = 2, -- Por defecto: duplicar (x2)
    permitirFactorPersonalizado = true, -- Si se puede elegir cuánto multiplicar
    limiteMaximo = 1000, -- Límite máximo de Brainrots permitidos (0 = sin límite)
    confirmacionNecesaria = true -- Pedir confirmación antes de duplicar
}

-- ======================
-- ## FUNCIÓN: MOSTRAR INVENTARIO
-- ======================
local function mostrarInventario()
    print("\n=====================================")
    print("**INVENTARIO - BRAINROTS**")
    print("-------------------------------------")
    print("- Brainrots disponibles: " .. inventario.brainrots)
    print("- Otros ítems:")
    print("  > Monedas: " .. inventario.otrosItems.monedas)
    print("  > Potenciadores: " .. inventario.otrosItems.potenciadores)
    print("-------------------------------------")
    print("Ajustes de duplicación:")
    print("  > Factor por defecto: x" .. configuracion.factorDuplicacion)
    print("  > Límite máximo permitido: " .. (configuracion.limiteMaximo > 0 and configuracion.limiteMaximo or "Sin límite"))
    print("=====================================")
end

-- ======================
-- ## FUNCIÓN: DUPLICAR BRAINROTS
-- ======================
local function duplicarBrainrots(factor)
    -- Verificar si hay Brainrots para duplicar
    if inventario.brainrots <= 0 then
        print("\n## ERROR: No tienes Brainrots en tu inventario para duplicar!")
        return
    end

    -- Establecer factor de duplicación
    local factorUsar = factor or configuracion.factorDuplicacion
    if factorUsar < 1 then
        print("\n## ERROR: El factor de duplicación debe ser mayor o igual a 1!")
        return
    end

    -- Calcular cantidad final
    local cantidadAntes = inventario.brainrots
    local cantidadFinal = cantidadAntes * factorUsar

    -- Verificar límite máximo
    if configuracion.limiteMaximo > 0 and cantidadFinal > configuracion.limiteMaximo then
        print("\n## ADVERTENCIA: La duplicación excedería el límite máximo permitido!")
        print("- Cantidad actual: " .. cantidadAntes)
        print("- Cantidad con duplicación: " .. cantidadFinal)
        print("- Límite máximo: " .. configuracion.limiteMaximo)
        print("- Se ajustará a la cantidad máxima permitida.")
        cantidadFinal = configuracion.limiteMaximo
    end

    -- Pedir confirmación si es necesario
    if configuracion.confirmacionNecesaria then
        print("\n¿Confirmas la duplicación?")
        print("- Brainrots antes: " .. cantidadAntes)
        print("- Brainrots después: " .. cantidadFinal .. " (x" .. factorUsar .. ")")
        io.write("Escribe 'si' para confirmar: ")
        local confirmacion = io.read():lower()
        if confirmacion ~= "si" then
            print("\n## Duplicación cancelada.")
            return
        end
    end

    -- Aplicar duplicación
    inventario.brainrots = cantidadFinal
    print("\n✅ **DUPLICACIÓN EXITOSA!**")
    print("- Cantidad anterior: " .. cantidadAntes)
    print("- Cantidad actual: " .. inventario.brainrots)
end

-- ======================
-- ## FUNCIÓN: CAMBIAR AJUSTES
-- ======================
local function cambiarAjustes()
    print("\n--- CAMBIAR AJUSTES DE DUPLICACIÓN ---")
    io.write("Nuevo factor de duplicación por defecto (ej: 2 = x2): ")
    local nuevoFactor = tonumber(io.read())
    if nuevoFactor and nuevoFactor >= 1 then
        configuracion.factorDuplicacion = nuevoFactor
        print("- Factor de duplicación actualizado a x" .. nuevoFactor)
    else
        print("## ERROR: Ingresa un número válido mayor o igual a 1!")
    end

    io.write("Nuevo límite máximo de Brainrots (0 = sin límite): ")
    local nuevoLimite = tonumber(io.read())
    if nuevoLimite and nuevoLimite >= 0 then
        configuracion.limiteMaximo = nuevoLimite
        print("- Límite máximo actualizado a " .. (nuevoLimite > 0 and nuevoLimite or "Sin límite"))
    else
        print("## ERROR: Ingresa un número válido mayor o igual a 0!")
    end
end

-- ======================
-- ## BUCLE PRINCIPAL
-- ======================
print("**¡DUPLICADOR DE BRAINROTS DEL INVENTARIO!**")
print("- Comandos disponibles:")
print("  > 'inventario' → Ver tu inventario y ajustes")
print("  > 'duplicar' → Duplicar con el factor por defecto")
print("  > 'duplicarX' → Duplicar con un factor personalizado (ej: 'duplicarX 3' = x3)")
print("  > 'ajustes' → Cambiar factor de duplicación o límite máximo")
print("  > 'salir' → Cerrar el duplicador")

while true do
    io.write("\n¿Qué acción quieres realizar? ")
    local entrada = io.read():lower()
    local partesEntrada = {}
    for parte in string.gmatch(entrada, "%S+") do
        table.insert(partesEntrada, parte)
    end
    local accion = partesEntrada[1]
    local parametro = tonumber(partesEntrada[2])

    if accion == "salir" then
        print("\n✅ **PROCESO FINALIZADO**")
        print("- Brainrots finales en inventario: " .. inventario.brainrots)
        break
    elseif accion == "inventario" then
        mostrarInventario()
    elseif accion == "duplicar" then
        duplicarBrainrots()
    elseif accion == "duplicarx" then
        if configuracion.permitirFactorPersonalizado and parametro then
            duplicarBrainrots(parametro)
        else
            print("\n## ERROR: No se permite factor personalizado o el valor es inválido!")
            print("- Usa el formato: 'duplicarX [número]' (ej: 'duplicarX 4')")
        end
    elseif accion == "ajustes" then
        cambiarAjustes()
    else
        print("\n## COMANDO NO VÁLIDO")
        print("- Revisa la lista de comandos disponibles.")
    end
end
