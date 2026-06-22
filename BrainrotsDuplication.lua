-- ============================================
-- 🔥 KICK A LUCKY BLOCK - DUPLICADOR DE BRAINROTS 🔥
-- ============================================
-- Creado para fines educativos
-- Usa bajo tu propio riesgo

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local runService = game:GetService("RunService")

-- ============================================
-- 📡 BUSCAR REMOTE EVENTS
-- ============================================
local remoteEvents = {}
local remoteFunctions = {}

function findRemotes()
    local function search(obj)
        for _, v in pairs(obj:GetDescendants()) do
            if v:IsA("RemoteEvent") then
                table.insert(remoteEvents, v)
            elseif v:IsA("RemoteFunction") then
                table.insert(remoteFunctions, v)
            end
        end
    end
    
    search(replicatedStorage)
    search(game:GetService("ReplicatedService"))
    search(workspace)
    
    -- Mostrar remotes encontrados
    print("🔍 RemoteEvents encontrados:")
    for i, v in ipairs(remoteEvents) do
        print(i .. ". " .. v:GetFullName())
    end
end

findRemotes()

-- ============================================
-- 🎯 IDENTIFICAR EL REMOTE CORRECTO
-- ============================================
local brainrotRemote = nil
local brainrotFunction = nil

for _, v in pairs(remoteEvents) do
    local name = v.Name:lower()
    if name:find("brainrot") or name:find("collect") or name:find("reward") or 
       name:find("claim") or name:find("drop") or name:find("kick") then
        brainrotRemote = v
        print("✅ Remote encontrado: " .. v.Name)
        break
    end
end

-- Si no se encuentra, usar el primero
if not brainrotRemote and #remoteEvents > 0 then
    brainrotRemote = remoteEvents[1]
    print("⚠️ Usando remote por defecto: " .. brainrotRemote.Name)
end

-- ============================================
-- ⚙️ CONFIGURACIÓN
-- ============================================
local config = {
    cantidadDupe = 100,        -- Número de duplicaciones
    delayMin = 0.02,           -- Delay mínimo entre envíos (segundos)
    delayMax = 0.08,           -- Delay máximo entre envíos
    randomizar = true,         -- ¿Randomizar delays?
    modoSigiloso = true,       -- Modo sigiloso (menos detección)
    pausaLarga = 0.5,          -- Pausa cada X envíos
    cadaCuantos = 10,          -- Cada cuántos envíos hacer pausa larga
    usarAntiBan = true,        -- Protección anti-ban
}

-- ============================================
-- 🧠 FUNCIÓN PRINCIPAL DE DUPLICACIÓN
-- ============================================
local function getDelay()
    if config.randomizar then
        return math.random(config.delayMin * 1000, config.delayMax * 1000) / 1000
    else
        return config.delayMin
    end
end

local function duplicateBrainrots(cantidad)
    if not brainrotRemote then
        print("❌ No se encontró un RemoteEvent válido")
        return false
    end
    
    print("🔄 Iniciando duplicación de " .. cantidad .. " Brainrots...")
    
    local successCount = 0
    local failCount = 0
    
    for i = 1, cantidad do
        local success = pcall(function()
            -- Intentar diferentes formas de enviar
            local data = {
                ["Collect"] = true,
                ["Amount"] = 1,
                ["Source"] = "Player"
            }
            
            -- Enviar remote
            brainrotRemote:FireServer(data)
            
            -- Si es RemoteFunction, usar InvokeServer en vez de FireServer
            if brainrotFunction then
                brainrotFunction:InvokeServer(data)
            end
            
            -- Intentar FireServer vacío como alternativa
            if i % 3 == 0 then
                brainrotRemote:FireServer()
            end
            
            successCount = successCount + 1
        end)
        
        if not success then
            failCount = failCount + 1
        end
        
        -- Delay entre envíos
        local delay = getDelay()
        task.wait(delay)
        
        -- Pausa larga cada X envíos
        if config.modoSigiloso and i % config.cadaCuantos == 0 then
            task.wait(config.pausaLarga + math.random() * 0.3)
        end
        
        -- Mostrar progreso cada 10
        if i % 10 == 0 then
            print("📊 Progreso: " .. i .. "/" .. cantidad .. " completados")
        end
    end
    
    print("✅ Duplicación completada!")
    print("   ✓ Éxitos: " .. successCount)
    print("   ✗ Fallos: " .. failCount)
    return true
end

-- ============================================
-- 🛡️ SISTEMA ANTI-BAN
-- ============================================
local function antiBan()
    if not config.usarAntiBan then return end
    
    -- Simular comportamiento humano
    local function simulateHuman()
        -- Mover cámara aleatoriamente
        local camera = workspace.CurrentCamera
        if camera then
            local randomX = math.random(-10, 10)
            local randomY = math.random(-10, 10)
            camera.CFrame = camera.CFrame * CFrame.Angles(randomX / 100, randomY / 100, 0)
        end
        
        -- Simular escritura
        local fakeKeys = {"w", "a", "s", "d", "space", "shift"}
        local randomKey = fakeKeys[math.random(#fakeKeys)]
        game:GetService("ContextActionService"):FireInput(randomKey)
    end
    
    -- Ejecutar cada cierto tiempo
    spawn(function()
        while wait(math.random(15, 45)) do
            simulateHuman()
        end
    end)
end

-- ============================================
-- 🎨 INTERFAZ GRÁFICA
-- ============================================
local function createUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "DupeUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player.PlayerGui
    
    -- Fondo principal
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 350, 0, 450)
    mainFrame.Position = UDim2.new(0.5, -175, 0.5, -225)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    mainFrame.BackgroundTransparency = 0.05
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    -- Borde decorativo
    local border = Instance.new("UICorner")
    border.CornerRadius = UDim.new(0, 12)
    border.Parent = mainFrame
    
    -- Título
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 60)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "🔥 BRAINROT DUPE"
    title.TextColor3 = Color3.fromRGB(255, 215, 0)
    title.TextSize = 28
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = mainFrame
    
    -- Estado del remote
    local remoteStatus = Instance.new("TextLabel")
    remoteStatus.Size = UDim2.new(1, -40, 0, 30)
    remoteStatus.Position = UDim2.new(0, 20, 0, 65)
    remoteStatus.BackgroundTransparency = 1
    remoteStatus.Text = brainrotRemote and "✅ Remote: " .. brainrotRemote.Name or "❌ Remote no encontrado"
    remoteStatus.TextColor3 = brainrotRemote and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 50, 50)
    remoteStatus.TextSize = 14
    remoteStatus.Font = Enum.Font.Gotham
    remoteStatus.TextXAlignment = Enum.TextXAlignment.Left
    remoteStatus.Parent = mainFrame
    
    -- Input: Cantidad
    local amountLabel = Instance.new("TextLabel")
    amountLabel.Size = UDim2.new(0.8, 0, 0, 25)
    amountLabel.Position = UDim2.new(0.1, 0, 0, 110)
    amountLabel.BackgroundTransparency = 1
    amountLabel.Text = "Cantidad a duplicar:"
    amountLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    amountLabel.TextSize = 15
    amountLabel.Font = Enum.Font.Gotham
    amountLabel.TextXAlignment = Enum.TextXAlignment.Left
    amountLabel.Parent = mainFrame
    
    local amountBox = Instance.new("TextBox")
    amountBox.Size = UDim2.new(0.8, 0, 0, 35)
    amountBox.Position = UDim2.new(0.1, 0, 0, 140)
    amountBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    amountBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    amountBox.Text = tostring(config.cantidadDupe)
    amountBox.TextSize = 18
    amountBox.Font = Enum.Font.Gotham
    amountBox.PlaceholderText = "Ingresa cantidad"
    amountBox.ClearTextOnFocus = false
    amountBox.Parent = mainFrame
    
    local amountCorner = Instance.new("UICorner")
    amountCorner.CornerRadius = UDim.new(0, 6)
    amountCorner.Parent = amountBox
    
    -- Botón de duplicar
    local dupeButton = Instance.new("TextButton")
    dupeButton.Size = UDim2.new(0.8, 0, 0, 50)
    dupeButton.Position = UDim2.new(0.1, 0, 0, 200)
    dupeButton.BackgroundColor3 = Color3.fromRGB(255, 180, 0)
    dupeButton.Text = "💎 DUPLICAR AHORA"
    dupeButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    dupeButton.TextSize = 20
    dupeButton.Font = Enum.Font.GothamBold
    dupeButton.Parent = mainFrame
    
    local dupeCorner = Instance.new("UICorner")
    dupeCorner.CornerRadius = UDim.new(0, 8)
    dupeCorner.Parent = dupeButton
    
    -- Botón de Auto Dupe
    local autoButton = Instance.new("TextButton")
    autoButton.Size = UDim2.new(0.38, 0, 0, 40)
    autoButton.Position = UDim2.new(0.06, 0, 0, 270)
    autoButton.BackgroundColor3 = Color3.fromRGB(50, 50, 180)
    autoButton.Text = "🔄 Auto Dupe"
    autoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    autoButton.TextSize = 16
    autoButton.Font = Enum.Font.Gotham
    autoButton.Parent = mainFrame
    
    local autoCorner = Instance.new("UICorner")
    autoCorner.CornerRadius = UDim.new(0, 6)
    autoCorner.Parent = autoButton
    
    -- Botón de parar
    local stopButton = Instance.new("TextButton")
    stopButton.Size = UDim2.new(0.38, 0, 0, 40)
    stopButton.Position = UDim2.new(0.56, 0, 0, 270)
    stopButton.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
    stopButton.Text = "⏹️ Parar"
    stopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    stopButton.TextSize = 16
    stopButton.Font = Enum.Font.Gotham
    stopButton.Parent = mainFrame
    
    local stopCorner = Instance.new("UICorner")
    stopCorner.CornerRadius = UDim.new(0, 6)
    stopCorner.Parent = stopButton
    
    -- Log/Output
    local logFrame = Instance.new("Frame")
    logFrame.Size = UDim2.new(0.9, 0, 0, 80)
    logFrame.Position = UDim2.new(0.05, 0, 0, 330)
    logFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
    logFrame.BackgroundTransparency = 0.5
    logFrame.Parent = mainFrame
    
    local logCorner = Instance.new("UICorner")
    logCorner.CornerRadius = UDim.new(0, 6)
    logCorner.Parent = logFrame
    
    local logText = Instance.new("TextLabel")
    logText.Size = UDim2.new(1, -10, 1, -10)
    logText.Position = UDim2.new(0, 5, 0, 5)
    logText.BackgroundTransparency = 1
    logText.Text = "Listo para duplicar 🚀"
    logText.TextColor3 = Color3.fromRGB(150, 200, 255)
    logText.TextSize = 13
    logText.Font = Enum.Font.Gotham
    logText.TextWrapped = true
    logText.TextXAlignment = Enum.TextXAlignment.Left
    logText.TextYAlignment = Enum.TextYAlignment.Top
    logText.Parent = logFrame
    
    -- ============================================
    -- 🎮 FUNCIONALIDAD DE BOTONES
    -- ============================================
    local isAutoDupe = false
    local autoConnection = nil
    
    -- Función para actualizar log
    local function updateLog(message, color)
        logText.Text = message
        if color then
            logText.TextColor3 = color
        else
            logText.TextColor3 = Color3.fromRGB(150, 200, 255)
        end
    end
    
    -- Botón Duplicar
    dupeButton.MouseButton1Click:Connect(function()
        local cantidad = tonumber(amountBox.Text) or config.cantidadDupe
        if cantidad > 0 then
            updateLog("🔄 Duplicando " .. cantidad .. "...", Color3.fromRGB(255, 200, 50))
            dupeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            dupeButton.Text = "⏳ DUPLICANDO..."
            
            spawn(function()
                local result = duplicateBrainrots(cantidad)
                if result then
                    updateLog("✅ Duplicación completada!", Color3.fromRGB(0, 255, 100))
                else
                    updateLog("❌ Error en la duplicación", Color3.fromRGB(255, 50, 50))
                end
                dupeButton.BackgroundColor3 = Color3.fromRGB(255, 180, 0)
                dupeButton.Text = "💎 DUPLICAR AHORA"
            end)
        else
            updateLog("⚠️ Ingresa una cantidad válida", Color3.fromRGB(255, 200, 50))
        end
    end)
    
    -- Botón Auto Dupe
    autoButton.MouseButton1Click:Connect(function()
        if isAutoDupe then
            updateLog("⏹️ Auto Dupe detenido", Color3.fromRGB(255, 200, 50))
            if autoConnection then
                autoConnection:Disconnect()
                autoConnection = nil
            end
            isAutoDupe = false
            autoButton.BackgroundColor3 = Color3.fromRGB(50, 50, 180)
            autoButton.Text = "🔄 Auto Dupe"
            return
        end
        
        local cantidad = tonumber(amountBox.Text) or config.cantidadDupe
        updateLog("▶️ Auto Dupe iniciado", Color3.fromRGB(0, 255, 100))
        isAutoDupe = true
        autoButton.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        autoButton.Text = "⏹️ Detener"
        
        autoConnection = runService.Heartbeat:Connect(function()
            if isAutoDupe then
                duplicateBrainrots(cantidad)
                updateLog("🔄 Auto: " .. cantidad .. " Brainrots duplicados", Color3.fromRGB(100, 255, 100))
            end
        end)
    end)
    
    -- Botón Stop
    stopButton.MouseButton1Click:Connect(function()
        if autoConnection then
            autoConnection:Disconnect()
            autoConnection = nil
        end
        isAutoDupe = false
        autoButton.BackgroundColor3 = Color3.fromRGB(50, 50, 180)
        autoButton.Text = "🔄 Auto Dupe"
        updateLog("⏹️ Todo detenido", Color3.fromRGB(255, 200, 50))
    end)
    
    -- Drag para mover la UI
    local dragging = false
    local dragInput, dragStart, startPos
    
    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    mainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, 
                                          startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    return screenGui
end

-- ============================================
-- 🚀 INICIALIZACIÓN
-- ============================================
print("=" .. string.rep("=", 50))
print("🔥 KICK A LUCKY BLOCK - BRAINROT DUPE v1.0")
print("=" .. string.rep("=", 50))

-- Iniciar anti-ban
antiBan()

-- Crear UI
createUI()

-- Mostrar información
if brainrotRemote then
    print("✅ Remote encontrado: " .. brainrotRemote.Name)
    print("💡 Los Brainrots se duplicarán usando este remote")
else
    print("⚠️ No se encontró el remote específico, intentando con: " .. (#remoteEvents > 0 and remoteEvents[1].Name or "ninguno"))
end

print("🚀 Script cargado correctamente!")
print("📌 Usa la interfaz para controlar la duplicación")
print("=" .. string.rep("=", 50))
