-- ==============================================
-- SISTEMA COMPLETO DE DUPLICACIÓN DE BRAINROTS
-- ADAPTADO PARA DISPOSITIVOS ANDROID (TÁCTIL)
-- VERSIÓN AMPLIADA CON EFECTOS Y SEGURIDAD
-- ==============================================

-- SERVICIOS PRINCIPALES
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")

-- ==============================================
-- CONFIGURACIÓN DETALLADA (AJUSTA A TU GUSTO)
-- ==============================================
local CONFIG = {
    NOMBRE_LUCKY_BLOCK = "LuckyBlock_Kick",
    NOMBRE_BRAINROTS = "Brainrots",
    RUTA_BRAINROTS = ServerStorage:WaitForChild("Recursos"):WaitForChild("Brainrots"),
    PROBABILIDAD_DUPLICACION = 0.35, -- 35% de probabilidad
    RANGO_COLOCACION = 75,
    COLOR_BASE = Color3.new(0.2, 0.6, 0.2),
    COLOR_BRAINROTS = Color3.new(0.8, 0.2, 0.2),
    EFECTOS_ACTIVADOS = true,
    SONIDOS_ACTIVADOS = true,
    LIMITE_DUPLICADOS_POR_JUGADOR = 2 -- Evitar spam de duplicados
}

-- ==============================================
-- ALMACENAMIENTO DE DATOS DE JUGADORES
-- ==============================================
local datosJugadores = {}

-- Inicializar datos al unirse un jugador
local function onJugadorUnirse(jugador)
    datosJugadores[jugador.UserId] = {
        duplicadosObtenidos = 0,
        baseCreada = false,
        brainrotsColocadas = 0
    }

    -- Crear base automáticamente si no existe
    local baseExistente = Workspace:FindFirstChild("Base_" .. jugador.Name)
    if not baseExistente then
        crearBaseJugador(jugador)
        datosJugadores[jugador.UserId].baseCreada = true
    end

    -- Conectar evento de salida
    jugador.PlayerRemoving:Connect(function()
        datosJugadores[jugador.UserId] = nil
    end)
end

-- ==============================================
-- FUNCIÓN PARA CREAR BASE DE JUGADOR (CON EFECTOS)
-- ==============================================
local function crearBaseJugador(jugador)
    local base = Instance.new("Model")
    base.Name = "Base_" .. jugador.Name
    base.Parent = Workspace

    -- Zona de colocación
    local zonaColocacion = Instance.new("Part")
    zonaColocacion.Name = "ZonaColocacion"
    zonaColocacion.Size = Vector3.new(50, 0.5, 50)
    zonaColocacion.Position = Vector3.new(math.random(-100, 100), 0, math.random(-100, 100))
    zonaColocacion.Color = CONFIG.COLOR_BASE
    zonaColocacion.Transparency = 0.7
    zonaColocacion.CanCollide = false
    zonaColocacion.Anchored = true
    zonaColocacion.Parent = base

    -- Muro de la base
    for i = 1, 4 do
        local muro = Instance.new("Part")
        muro.Name = "Muro_" .. i
        muro.Size = Vector3.new(50, 5, 1)
        muro.Anchored = true
        muro.Color = CONFIG.COLOR_BASE
        muro.Parent = base

        if i == 1 then muro.CFrame = zonaColocacion.CFrame * CFrame.new(0, 2.5, 25) end
        if i == 2 then muro.CFrame = zonaColocacion.CFrame * CFrame.new(0, 2.5, -25) end
        if i == 3 then muro.CFrame = zonaColocacion.CFrame * CFrame.new(25, 2.5, 0) * CFrame.Angles(0, math.rad(90), 0) end
        if i == 4 then muro.CFrame = zonaColocacion.CFrame * CFrame.new(-25, 2.5, 0) * CFrame.Angles(0, math.rad(90), 0) end
    end

    -- Efecto de aparición de la base
    if CONFIG.EFECTOS_ACTIVADOS then
        local partAparicion = Instance.new("Part")
        partAparicion.Size = Vector3.new(50, 50, 50)
        partAparicion.Position = zonaColocacion.Position
        partAparicion.Transparency = 1
        partAparicion.Anchored = true
        partAparicion.CanCollide = false
        partAparicion.Parent = Workspace

        local efecto = Instance.new("ParticleEmitter")
        efecto.Texture = "rbxassetid://154966922"
        efecto.Color = ColorSequence.new(CONFIG.COLOR_BASE)
        efecto.Rate = 100
        efecto.Lifetime = NumberRange.new(1, 2)
        efecto.Speed = NumberRange.new(5, 10)
        efecto.Parent = partAparicion

        wait(2)
        efecto:Destroy()
        partAparicion:Destroy()
    end

    -- Sonido de creación de base
    if CONFIG.SONIDOS_ACTIVADOS then
        local sonido = Instance.new("Sound")
        sonido.SoundId = "rbxassetid://183870707"
        sonido.Volume = 0.5
        sonido.Parent = zonaColocacion
        sonido:Play()
        wait(3)
        sonido:Destroy()
    end

    jugador:SendNotification("¡Tu base ha sido creada! Puedes colocar aquí tus Brainrots")
    return base
end

-- ==============================================
-- FUNCIÓN PARA CREAR BRAINROTS DUPLICADA (COMPLETA)
-- ==============================================
local function crearBrainrotsDuplicada(jugador)
    -- Verificar límite de duplicados
    if datosJugadores[jugador.UserId].duplicadosObtenidos >= CONFIG.LIMITE_DUPLICADOS_POR_JUGADOR then
        jugador:SendNotification("¡Límite de duplicados alcanzado! Solo puedes tener " .. CONFIG.LIMITE_DUPLICADOS_POR_JUGADOR .. " duplicados")
        return nil
    end

    -- Clonar modelo original
    local brainrots = CONFIG.RUTA_BRAINROTS:Clone()
    brainrots.Name = CONFIG.NOMBRE_BRAINROTS
    brainrots:SetAttribute("EsDuplicado", true)
    brainrots:SetAttribute("Dueño", jugador.UserId)

    -- Copiar todas las propiedades (visuales y funcionales)
    for _, elemento in ipairs(brainrots:GetDescendants()) do
        local original = CONFIG.RUTA_BRAINROTS:FindFirstChild(elemento.Name, true)
        if original then
            -- Propiedades visuales
            if elemento:IsA("BasePart") then
                elemento.Color = original.Color or CONFIG.COLOR_BRAINROTS
                elemento.Material = original.Material or Enum.Material.Metal
                elemento.Size = original.Size or Vector3.new(3, 5, 3)
                elemento.Transparency = original.Transparency or 0
                elemento.CanCollide = original.CanCollide or true
                elemento.Anchored = original.Anchored or false

                -- Efecto de brillo en el duplicado
                if CONFIG.EFECTOS_ACTIVADOS then
                    local brillo = Instance.new("SurfaceGui")
                    brillo.Name = "BrilloDuplicado"
                    local frame = Instance.new("Frame")
                    frame.Size = UDim2.new(1, 0, 1, 0)
                    frame.BackgroundColor3 = Color3.new(1, 1, 1)
                    frame.BackgroundTransparency = 0.8
                    frame.Parent = brillo
                    brillo.Parent = elemento
                end
            elseif elemento:IsA("Decal") then
                elemento.Texture = original.Texture or elemento.Texture
                elemento.Transparency = original.Transparency or 0
            elseif elemento:IsA("Script") then
                elemento.Source = original.Source
                elemento.Disabled = original.Disabled
            elseif elemento:IsA("ValueBase") then
                elemento.Value = original.Value
            end
        end
    end

    -- Sistema de colocación táctil
    local sistemaColocacion = Instance.new("RemoteFunction")
    sistemaColocacion.Name = "ColocarBrainrots"
    sistemaColocacion.Parent = brainrots

    -- Lógica de colocación
    sistemaColocacion.OnServerInvoke = function(jugadorInvocador, posicionSolicitada)
        -- Verificar que sea el dueño
        if jugadorInvocador.UserId ~= jugador.UserId then
            jugadorInvocador:SendNotification("¡Este no es tu duplicado!")
            return false
        end

        -- Verificar base válida
        local base = Workspace:FindFirstChild("Base_" .. jugador.Name)
        if not base or not base:FindFirstChild("ZonaColocacion") then
            jugador:SendNotification("¡Primero necesitas una base!")
            return false
        end

        -- Verificar distancia
        local distancia = (posicionSolicitada - base.ZonaColocacion.Position).Magnitude
        if distancia > CONFIG.RANGO_COLOCACION then
            jugador:SendNotification("¡Demasiado lejos de tu base! Acércate más")
            return false
        end

        -- Verificar que no haya demasiadas en la base
        if datosJugadores[jugador.UserId].brainrotsColocadas >= 3 then
            jugador:SendNotification("¡No puedes colocar más de 3 Brainrots en tu base!")
            return false
        end

        -- Colocar la Brainrots
        brainrots:PivotTo(CFrame.new(posicionSolicitada) * CFrame.new(0, brainrots.PrimaryPart.Size.Y/2, 0))
        brainrots.Parent = base

        -- Efecto de colocación
        if CONFIG.EFECTOS_ACTIVADOS then
            local efecto = Instance.new("ParticleEmitter")
            efecto.Texture = "rbxassetid://154966922"
            efecto.Color = ColorSequence.new(CONFIG.COLOR_BRAINROTS)
            efecto.Rate = 150
            efecto.Lifetime = NumberRange.new(0.5, 1.5)
            efecto.Speed = NumberRange.new(3, 8)
            efecto.Parent = brainrots.PrimaryPart
            wait(1.5)
            efecto:Destroy()

            -- Animación de escala
            local tweenInfo = TweenInfo.new(0.8, Enum.EasingStyle.Elastic)
            local objetivo = {Size = brainrots.PrimaryPart.Size}
            brainrots.PrimaryPart.Size = Vector3.new(0.1, 0.1, 0.1)
            local tween = TweenService:Create(brainrots.PrimaryPart, tweenInfo, objetivo)
            tween:Play()
        end

        -- Sonido de colocación
        if CONFIG.SONIDOS_ACTIVADOS then
            local sonido = Instance.new("Sound")
            sonido.SoundId = "rbxassetid://179624070"
            sonido.Volume = 0.4
            sonido.Parent = brainrots.PrimaryPart
            sonido:Play()
            wait(2)
            sonido:Destroy()
        end

        -- Actualizar datos del jugador
        datosJugadores[jugador.UserId].brainrotsColocadas += 1
        sistemaColocacion:Destroy()

        return true
    end

    -- Incrementar contador de duplicados
    datosJugadores[jugador.UserId].duplicadosObtenidos += 1
    return brainrots
end

-- ==============================================
-- FUNCIÓN PARA PROCESAR LUCKY BLOCK ABIERTO
-- ==============================================
local function procesarLuckyBlock(luckyBlock, jugador)
    -- Verificar que el Lucky Block sea válido
    if not luckyBlock or not luckyBlock:IsA("Model") or luckyBlock.Name ~= CONFIG.NOMBRE_LUCKY_BLOCK then
        return
    end

    if not jugador or not datosJugadores[jugador.UserId] then
        return
    end

    -- Efecto de apertura del Lucky Block
    if CONFIG.EFECTOS_ACTIVADOS then
        local explosion = Instance.new("Explosion")
        explosion.Position = luckyBlock.PrimaryPart.Position
        explosion.BlastRadius = 4
        explosion.BlastPressure = 0
        explosion.Parent = Workspace

        local efecto = Instance.new("ParticleEmitter")
        efecto.Texture = "rbxassetid://107280427"
        efecto.Color = ColorSequence.new(Color3.new(1, 1, 0), Color3.new(1, 0.5, 0))
        efecto.Rate = 200
        efecto.Lifetime = NumberRange.new(1, 2)
        efecto.Speed = NumberRange.new(5, 15)
        efecto.Parent = luckyBlock.PrimaryPart
        wait(1)
        efecto:Destroy()
    end

    -- Sonido de apertura
    if CONFIG.SONIDOS_ACTIVADOS then
        local sonidoApertura = Instance.new("Sound")
        sonidoApertura.SoundId = "rbxassetid://161366602"
        sonidoApertura.Volume = 0.6
        sonidoApertura.Parent = luckyBlock.PrimaryPart
        sonidoApertura:Play()
    end

    -- Dar Brainrots original
    local brainrotsOriginal = CONFIG.RUTA_BRAINROTS:Clone()
    brainrotsOriginal.Parent = jugador.Backpack
    jugador:SendNotification("✅ Has obtenido BRAINROTS del Lucky Block!")

    -- Verificar si hay duplicación
    if math.random() <= CONFIG.PROBABILIDAD_DUPLICACION then
        local duplicado = crearBrainrotsDuplicada(jugador)
        if duplicado then
            duplicado.Parent = jugador.Backpack

            -- Notificación con emojis (mejor en móvil)
            jugador:SendNotification("🎉 ¡SORTE EXTREMA! Has obtenido un DUPLICADO de Brainrots!")
            
            -- Sonido de premio especial
            if CONFIG.SONIDOS_ACTIVADOS then
                local sonidoPremio = Instance.new("Sound")
                sonidoPremio.SoundId = "rbxassetid://183870710"
                sonidoPremio.Volume = 0.7
                sonidoPremio.Parent = jugador.Character.HumanoidRootPart
                sonidoPremio:Play()
            end

            print("[SISTEMA DE DUPLICACIÓN] Jugador " .. jugador.Name .. " obtuvo un duplicado de Brainrots")
        end
    else
        -- Mensaje si no hay duplicado (para que no quede en blanco)
        jugador:SendNotification("🤞 ¡Prueba la suerte de nuevo! Puede salir un duplicado")
    end

    -- Eliminar Lucky Block después de procesar
    wait(0.5)
    luckyBlock:Destroy()
end

-- ==============================================
-- CONEXIÓN DE EVENTOS PRINCIPALES
-- ==============================================
-- Evento de unión de jugadores
Players.PlayerAdded:Connect(onJugadorUnirse)

-- Evento de apertura de Lucky Block (desde cliente)
local eventoAbrir = ReplicatedStorage:WaitForChild("EventoAbrirLuckyBlock_Kick")
eventoAbrir.OnServerEvent:Connect(procesarLuckyBlock)

-- Detección de Lucky Block destruido (alternativa)
Workspace.DescendantRemoving:Connect(function(objeto)
    if objeto.Name == CONFIG.NOMBRE_LUCKY_BLOCK then
        local nombreDueño = objeto:GetAttribute("Dueño")
        if nombreDueño then
            local jugador = Players:FindFirstChild(nombreDueño)
            if jugador then
                procesarLuckyBlock(objeto, jugador)
            end
        end
    end
end)

-- ==============================================
-- SCRIPT DEL CLIENTE (GUARDADO EN STARTERGUI)
-- ==============================================
local scriptCliente = [[
-- SCRIPT CLIENTE PARA ANDROID (TÁCTIL)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local jugador = Players.LocalPlayer

-- CREACIÓN DE LA GUI TÁCTIL
local gui = Instance.new("ScreenGui")
gui.Name = "GUI_Brainrots_Android"
gui.Parent = jugador.PlayerGui

-- BOTÓN DE COLOCACIÓN
local boton = Instance.new("TextButton")
boton.Name = "BotonColocarBrainrots"
boton.Size = UDim2.new(0, 180, 0, 70)
boton.Position = UDim2.new(1, -200, 1, -90)
boton.BackgroundColor3 = Color3.new(0, 0.6, 0)
boton.BorderSizePixel = 3
boton.BorderColor3 = Color3.new(1, 1, 1)
boton.Text = "Colocar Brainrots"
boton.TextColor3 = Color3.new(1, 1, 1)
boton.TextSize = 22
boton.Font = Enum.Font.Arcade
boton.Visible = false
boton.Parent = gui

-- EFECTO DE BOTÓN AL TOCAR
local function efectoBoton()
    boton.BackgroundColor3 = Color3.new(0, 0.8, 0)
    wait(0.2)
    boton.BackgroundColor3 = Color3.new(0, 0.6, 0)
end

-- DETECCIÓN DE TOCADO EN EL SUELO
local posicionTocada = nil

UserInputService.TouchTapInWorld:Connect(function(posicion, _)
    local rayo = Workspace.CurrentCamera:ViewportPointToRay(posicion.X, posicion.Y)
    local resultado = Workspace:Raycast(rayo.Origin, rayo.Direction * 150)
    if resultado then
        posicionTocada = resultado.Position
    end
end)

-- FUNCIÓN DE COLOCACIÓN
local function colocarBrainrots()
    efectoBoton()
    local brainrots = jugador.Backpack:FindFirstChild("Brainrots") or jugador.Character:FindFirstChild("Brainrots")
    if not brainrots then
        boton.Text = "❌ No tienes Brainrots!"
        wait(2)
        boton.Text = "Colocar Brainrots"
        return
    end

    if not posicionTocada then
        boton.Text = "👉 Toca el suelo primero!"
        wait(2)
        boton.Text = "Colocar Brainrots"
        return
    end

    local exito = brainrots:FindFirstChild("ColocarBrainrots"):InvokeServer(posicionTocada)
    if exito then
        boton.Visible = false
    end
end

-- ACTUALIZAR VISIBILIDAD DEL BOTÓN
local function actualizarBoton()
    local tieneBrainrots = jugador.Backpack:FindFirstChild("Brainrots") or jugador.Character:FindFirstChild("Brainrots")
    local tieneSistemaColocacion = false
    if tieneBrainrots then
        tieneSistemaColocacion = brainrots:FindFirstChild("ColocarBrainrots") ~= nil
    end
    boton.Visible = tieneBrainrots and tieneSistemaColocacion
end

-- CONECTAR EVENTOS
boton.MouseButton1Click:Connect(colocarBrainrots)
jugador.Backpack.ChildAdded:Connect(actualizarBoton)
jugador.Backpack.ChildRemoved:Connect(actualizarBoton)
jugador.CharacterAdded:Connect(function()
    actualizarBoton()
end)

-- BOTÓN DE AYUDA (EXTRA)
local botonAyuda = Instance.new("TextButton")
botonAyuda.Size = UDim2.new(0, 70, 0, 70)
botonAyuda.Position = UDim2.new(1, -200, 1, -170)
botonAyuda.BackgroundColor3 = Color3.new(0.2, 0.2, 0.8)
botonAyuda.Text = "?"
botonAyuda.TextSize = 30
botonAyuda.Parent = gui

botonAyuda.MouseButton1Click:Connect(function()
    jugador:SendNotification("📝 PASOS PARA COLOCAR:\n1. Ve a tu base\n2. Toca el suelo donde quieras ponerla\n3. Presiona el botón verde")
end)

-- INICIALIZAR
actualizarBoton()
]]

-- Guardar script del cliente en StarterGui
local guiCliente = Instance.new("ScreenGui")
guiCliente.Name = "GUI_Brainrots_Cliente"
guiCliente.Parent = game:GetService("StarterGui")

local localScript = Instance.new("LocalScript")
localScript.Name = "Script_Cliente_Android"
localScript.Source = scriptCliente
localScript.Parent = guiCliente

-- ==============================================
-- MENSAJE DE INICIALIZACIÓN
-- ==============================================
print("==============================================")
print("SISTEMA DE DUPLICACIÓN DE BRAINROTS ACTIVADO")
print("✅ Adaptado para dispositivos Android")
print("✅ Probabilidad de duplicado: " .. CONFIG.PROBABILIDAD_DUPLICACION * 100 .. "%")
print("==============================================")
