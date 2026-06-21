-- Duplicador Brainrots - Kick a Lucky Block
-- Versión personalizada

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local backpack = player.Backpack

-- Variables configurables
local CANTIDAD_DESEADA = 999  -- Cantidad de Brainrots a duplicar
local INTERVALO_DUPE = 0.5    -- Segundos entre cada duplicación

-- Función para obtener los Brainrots del inventario
local function obtenerBrainrots()
    local brainrots = {}
    -- Buscar en el inventario del jugador
    for _, item in pairs(player:GetChildren()) do
        if item:IsA("Tool") and item.Name:find("Brainrot") then
            table.insert(brainrots, item)
        end
    end
    return brainrots
end

-- Función principal de duplicación
local function duplicarBrainrots()
    local brainrots = obtenerBrainrots()
    if #brainrots == 0 then
        print("❌ No tienes Brainrots en el inventario")
        return
    end
    
    local brainrot = brainrots[1]
    print("✅ Brainrot encontrado: " .. brainrot.Name)
    
    -- Intentar duplicar (método básico)
    -- NOTA: Necesitas identificar cómo funciona el sistema de items en el juego
    -- Puede ser replicando el item o explotando un bug de inventario
    
    -- Ejemplo: Equipar y desequipar rápidamente
    if character:FindFirstChild(brainrot.Name) then
        brainrot = character:FindFirstChild(brainrot.Name)
    end
    
    -- Simular duplicación (esto varía según el juego)
    for i = 1, CANTIDAD_DESEADA do
        -- Código de duplicación aquí
        -- Esto depende de cómo maneje los items el juego específico
        wait(INTERVALO_DUPE)
        
        -- Intento de duplicar moviendo items
        local clone = brainrot:Clone()
        clone.Parent = backpack
        print("🔄 Brainrot duplicado #" .. i)
    end
end

-- Función para farmeo automático
local function autoFarm()
    print("🌾 Iniciando Auto Farm de Brainrots...")
    
    -- Buscar Lucky Blocks en el mapa
    local luckyBlocks = workspace:FindFirstChild("LuckyBlocks") or {}
    
    for _, block in pairs(luckyBlocks:GetChildren()) do
        if block:IsA("Part") and block.Name:find("Lucky") then
            -- Simular patada al lucky block
            game:GetService("ReplicatedStorage"):FindFirstChild("KickBlock"):FireServer(block)
            wait(1)
        end
    end
end

-- Función para evitar detección (anti-ban)
local function evitarDeteccion()
    -- Simular movimiento humano
    local randomWait = math.random(5, 15)
    wait(randomWait)
    
    -- Movimientos aleatorios
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid:MoveTo(Vector3.new(
            math.random(-100, 100),
            0,
            math.random(-100, 100)
        ))
    end
end

-- Función para crear GUI
local function crearGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = player.PlayerGui
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 400)
    frame.Position = UDim2.new(0.5, -150, 0.5, -200)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BackgroundTransparency = 0.1
    frame.Parent = screenGui
    
    -- Título
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Text = "🧠 Duplicador Brainrot"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundTransparency = 1
    title.Parent = frame
    
    -- Botón Duplicar
    local dupeBtn = Instance.new("TextButton")
    dupeBtn.Size = UDim2.new(0, 200, 0, 40)
    dupeBtn.Position = UDim2.new(0.5, -100, 0.2, 0)
    dupeBtn.Text = "🔄 Duplicar Brainrots"
    dupeBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    dupeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    dupeBtn.Parent = frame
    dupeBtn.MouseButton1Click:Connect(duplicarBrainrots)
    
    -- Botón Auto Farm
    local farmBtn = Instance.new("TextButton")
    farmBtn.Size = UDim2.new(0, 200, 0, 40)
    farmBtn.Position = UDim2.new(0.5, -100, 0.4, 0)
    farmBtn.Text = "🌾 Auto Farm"
    farmBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    farmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    farmBtn.Parent = frame
    farmBtn.MouseButton1Click:Connect(autoFarm)
    
    -- Botón Anti-Ban
    local antiBanBtn = Instance.new("TextButton")
    antiBanBtn.Size = UDim2.new(0, 200, 0, 40)
    antiBanBtn.Position = UDim2.new(0.5, -100, 0.6, 0)
    antiBanBtn.Text = "🛡️ Anti-Ban (ON)"
    antiBanBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
    antiBanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    antiBanBtn.Parent = frame
    
    local antiBanActive = false
    antiBanBtn.MouseButton1Click:Connect(function()
        antiBanActive = not antiBanActive
        antiBanBtn.Text = antiBanActive and "🛡️ Anti-Ban (ON)" or "🛡️ Anti-Ban (OFF)"
        while antiBanActive do
            evitarDeteccion()
            wait(10)
        end
    end)
end

-- Iniciar GUI
print("🚀 Script cargado correctamente")
crearGUI()
