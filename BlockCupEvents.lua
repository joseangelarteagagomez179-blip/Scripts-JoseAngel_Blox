-- ============================================
--  JOSEANGEL_BLOX BLOCK CUP - MODO IMÁN
--  Atrae todas las balls hacia el jugador
-- ============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- ============================================
--  CONFIGURACIÓN DEL IMÁN
-- ============================================
local CONFIG = {
    RadioImán = 50,              -- Distancia de atracción
    FuerzaImán = 5,              -- Velocidad de atracción (0.5 - 10)
    TeclaActivar = Enum.KeyCode.F1,
    -- Lista de posibles nombres (probamos todos)
    NombresBalls = {
        "Ball", "RareBall", "EpicBall", "LegendaryBall", 
        "MutationBall", "CupBall", "EventBall", "SoccerBall",
        "Bola", "Rare", "Epic", "Legendary", "Mutation",
        "Collectible", "Cup_Collectible", "Part"
    }
}

local imanActivo = false
local ballsAtraidas = 0

-- ============================================
--  FUNCIÓN: DETECTAR BALLS
-- ============================================
local function detectarBalls()
    local balls = {}
    local posJugador = rootPart.Position
    
    for _, obj in ipairs(Workspace:GetDescendants()) do
        -- Solo partes que sean físicas
        if obj:IsA("Part") or obj:IsA("MeshPart") then
            local nombre = obj.Name or ""
            local nombreLower = string.lower(nombre)
            
            -- Verificar si es una ball
            local esBall = false
            for _, palabra in ipairs(CONFIG.NombresBalls) do
                if string.find(nombreLower, string.lower(palabra)) then
                    esBall = true
                    break
                end
            end
            
            -- Si es una ball, verificar distancia
            if esBall and obj.Parent ~= character then
                local distancia = (obj.Position - posJugador).Magnitude
                if distancia <= CONFIG.RadioImán then
                    table.insert(balls, {
                        objeto = obj,
                        posicion = obj.Position,
                        distancia = distancia
                    })
                end
            end
        end
    end
    
    return balls
end

-- ============================================
--  FUNCIÓN: ATRAER BALLS (EFECTO IMÁN)
-- ============================================
local function atraerBalls()
    local balls = detectarBalls()
    
    if #balls == 0 then
        -- Si no hay balls, mostrar mensaje ocasional
        if math.random(1, 100) == 1 then
            print("[🔍] Buscando balls... (Activa F1 para desactivar)")
        end
        return
    end
    
    local posJugador = rootPart.Position
    
    for _, ballData in ipairs(balls) do
        local obj = ballData.objeto
        local posBall = ballData.posicion
        local distancia = ballData.distancia
        
        -- Calcular dirección hacia el jugador
        local direccion = (posJugador - posBall).Unit
        local fuerza = CONFIG.FuerzaImán / (distancia / 10 + 1) -- Más fuerza si está cerca
        
        -- Mover la ball hacia el jugador
        local nuevaPos = posBall + direccion * fuerza * 0.5
        
        -- Aplicar movimiento (si tiene masa)
        if obj:IsA("Part") then
            -- Método 1: Mover directamente (más agresivo)
            obj.Position = nuevaPos
            
            -- También podemos usar Velocity para un efecto más suave
            -- obj.Velocity = direccion * 20
        end
        
        -- Si está muy cerca, recolectar
        if distancia < 3 then
            print("[✅] Ball RECOLECTADA: " .. obj.Name)
            ballsAtraidas = ballsAtraidas + 1
            -- Guardar en el jugador
            if obj.Parent then
                obj:Destroy() -- Eliminar la ball (simula recolección)
            end
        end
    end
    
    -- Mostrar conteo cada 10 balls
    if ballsAtraidas > 0 and ballsAtraidas % 10 == 0 then
        print("[📊] Balls recolectadas: " .. ballsAtraidas)
    end
end

-- ============================================
--  FUNCIÓN: LOOP DEL IMÁN
-- ============================================
local function loopIman()
    print("[🧲] MODO IMÁN ACTIVADO")
    print("[⚡] Atrayendo balls...")
    
    while imanActivo do
        wait(0.05) -- Loop rápido para efecto suave
        atraerBalls()
    end
end

-- ============================================
--  ACTIVAR/DESACTIVAR CON F1
-- ============================================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == CONFIG.TeclaActivar then
        imanActivo = not imanActivo
        
        if imanActivo then
            print("[✅] IMÁN ACTIVADO | Presiona F1 para desactivar")
            task.spawn(loopIman)
        else
            print("[⏹️] IMÁN DESACTIVADO")
            print("[📊] Total recolectado: " .. ballsAtraidas .. " balls")
        end
    end
end)

-- ============================================
--  EFECTO VISUAL (Opcional)
-- ============================================
-- Crea partículas alrededor del jugador (se ve cool)
local function crearEfectoIman()
    local attachment = Instance.new("Attachment")
    attachment.Parent = rootPart
    attachment.Position = Vector3.new(0, 2, 0)
    
    local particle = Instance.new("ParticleEmitter")
    particle.Parent = attachment
    particle.Texture = "rbxasset://textures/particles/sparkles_main.dds"
    particle.Rate = 50
    particle.SpreadAngle = Vector2.new(360, 360)
    particle.Speed = NumberRange.new(1, 3)
    particle.Lifetime = NumberRange.new(0.5, 1)
    particle.Color = ColorSequence.new(Color3.new(0, 0.8, 1))
    particle.Transparency = NumberSequence.new(0.7)
    particle.Size = NumberSequence.new(0.5)
    particle.Enabled = true
    
    print("[✨] Efecto visual activado")
end

-- Descomentar para activar efecto visual
-- task.spawn(crearEfectoIman)

-- ============================================
--  INICIO
-- ============================================
print("")
print("========================================")
print("  🧲 JOSEANGEL_BLOX BLOCK CUP - IMÁN")
print("  Presiona F1 para ACTIVAR/DESACTIVAR")
print("  Radio de atracción: " .. CONFIG.RadioImán .. " estudios")
print("========================================")
print("")
