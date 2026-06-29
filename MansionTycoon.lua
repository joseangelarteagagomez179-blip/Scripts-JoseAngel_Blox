--[[
    Script: Mansion Tycoon
    Creador: JoseAngel_Blox
    Fecha: 29/06/2026
    Versión: 2.0 - Diseño Premium
]]

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local guiService = game:GetService("GuiService")
local tweenService = game:GetService("TweenService")
local userInput = game:GetService("UserInputService")
local runService = game:GetService("RunService")

-- ============================================
-- 1. ANIMACIÓN DE BIENVENIDA (LETRAS RGB ANIMADAS)
-- ============================================
local function showWelcomeAnimation()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = player.PlayerGui
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Name = "WelcomeGUI"
    screenGui.ResetOnSpawn = false
    
    -- Fondo oscuro con degradado
    local background = Instance.new("Frame")
    background.Size = UDim2.new(1, 0, 1, 0)
    background.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    background.BackgroundTransparency = 0.3
    background.Parent = screenGui
    
    -- Texto principal RGB animado
    local welcomeText = Instance.new("TextLabel")
    welcomeText.Size = UDim2.new(0.9, 0, 0.4, 0)
    welcomeText.Position = UDim2.new(0.05, 0, 0.25, 0)
    welcomeText.BackgroundTransparency = 1
    welcomeText.Text = "🌟 BIENVENIDOS A 🌟\nSCRIPTS JOSEANGEL_BLOX"
    welcomeText.TextColor3 = Color3.fromRGB(255, 255, 255)
    welcomeText.TextScaled = true
    welcomeText.Font = Enum.Font.GothamBold
    welcomeText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    welcomeText.TextStrokeTransparency = 0.2
    welcomeText.RichText = true
    welcomeText.Parent = screenGui
    
    -- Efecto RGB en el texto (cambia de color)
    local hue = 0
    local rgbLoop
    rgbLoop = runService.RenderStepped:Connect(function()
        hue = (hue + 0.5) % 360
        local color = Color3.fromHSV(hue/360, 1, 1)
        welcomeText.TextColor3 = color
    end)
    
    -- Subtítulo con efecto de escritura
    local subText = Instance.new("TextLabel")
    subText.Size = UDim2.new(0.7, 0, 0.1, 0)
    subText.Position = UDim2.new(0.15, 0, 0.6, 0)
    subText.BackgroundTransparency = 1
    subText.Text = ""
    subText.TextColor3 = Color3.fromRGB(200, 200, 255)
    subText.TextScaled = true
    subText.Font = Enum.Font.Gotham
    subText.Parent = screenGui
    
    -- Efecto de escritura letra por letra
    local fullText = "⚡ Cargando Mansion Tycoon Script... ⚡"
    local charIndex = 0
    spawn(function()
        while charIndex < #fullText do
            wait(0.05)
            charIndex = charIndex + 1
            subText.Text = string.sub(fullText, 1, charIndex)
        end
    end)
    
    -- Animación de entrada (fade-in)
    welcomeText.TextTransparency = 1
    subText.TextTransparency = 1
    
    local tweenInfo = TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween1 = tweenService:Create(welcomeText, tweenInfo, {TextTransparency = 0})
    local tween2 = tweenService:Create(subText, tweenInfo, {TextTransparency = 0})
    tween1:Play()
    tween2:Play()
    
    -- Esperar 4 segundos
    wait(4)
    
    -- Desvanecer
    local fadeOut = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    tweenService:Create(welcomeText, fadeOut, {TextTransparency = 1}):Play()
    tweenService:Create(subText, fadeOut, {TextTransparency = 1}):Play()
    tweenService:Create(background, fadeOut, {BackgroundTransparency = 1}):Play()
    
    wait(1)
    rgbLoop:Disconnect()
    screenGui:Destroy()
end

-- ============================================
-- 2. INTERFAZ PRINCIPAL PREMIUM
-- ============================================
local function createMainGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = player.PlayerGui
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Name = "MansionTycoonGUI"
    screenGui.ResetOnSpawn = false
    
    -- Marco principal (redondeado, tamaño más pequeño)
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 320, 0, 420)
    mainFrame.Position = UDim2.new(0.5, -160, 0.5, -210)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
    mainFrame.BackgroundTransparency = 0.1
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui
    
    -- Esquinas redondeadas
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 20)
    corner.Parent = mainFrame
    
    -- Fondo neon en movimiento (luces)
    local neonBg = Instance.new("Frame")
    neonBg.Size = UDim2.new(1.5, 0, 1.5, 0)
    neonBg.Position = UDim2.new(-0.25, 0, -0.25, 0)
    neonBg.BackgroundColor3 = Color3.fromRGB(255, 0, 150)
    neonBg.BackgroundTransparency = 0.9
    neonBg.BorderSizePixel = 0
    neonBg.Parent = mainFrame
    
    local neonCorner = Instance.new("UICorner")
    neonCorner.CornerRadius = UDim.new(0, 20)
    neonCorner.Parent = neonBg
    
    -- Animación de fondo neon
    spawn(function()
        local hue = 0
        while true do
            hue = (hue + 0.2) % 360
            local color = Color3.fromHSV(hue/360, 0.8, 1)
            neonBg.BackgroundColor3 = color
            wait(0.05)
        end
    end)
    
    -- Borde brillante
    local border = Instance.new("Frame")
    border.Size = UDim2.new(1, 0, 1, 0)
    border.BackgroundTransparency = 1
    border.BorderSizePixel = 2
    border.BorderColor3 = Color3.fromRGB(255, 215, 0)
    border.Parent = mainFrame
    
    local borderCorner = Instance.new("UICorner")
    borderCorner.CornerRadius = UDim.new(0, 20)
    borderCorner.Parent = border
    
    -- Título con gradiente
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0.08, 0)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "🏠 MANSION TYCOON"
    title.TextColor3 = Color3.fromRGB(255, 215, 0)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = mainFrame
    
    -- Subtítulo
    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(1, 0, 0.05, 0)
    subtitle.Position = UDim2.new(0, 0, 0.08, 0)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "by JoseAngel_Blox | v2.0"
    subtitle.TextColor3 = Color3.fromRGB(150, 150, 200)
    subtitle.TextScaled = true
    subtitle.Font = Enum.Font.Gotham
    subtitle.Parent = mainFrame
    
    -- ============================================
    -- 2.1 BOTÓN MINIMIZAR (Quitar/Colocar)
    -- ============================================
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Size = UDim2.new(0, 25, 0, 25)
    minimizeBtn.Position = UDim2.new(1, -60, 0, 5)
    minimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    minimizeBtn.Text = "−"
    minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeBtn.TextScaled = true
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.BorderSizePixel = 0
    minimizeBtn.Parent = mainFrame
    
    local minCorner = Instance.new("UICorner")
    minCorner.CornerRadius = UDim.new(0, 5)
    minCorner.Parent = minimizeBtn
    
    -- Variable para controlar minimizado
    local isMinimized = false
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, 0, 0.87, 0)
    contentFrame.Position = UDim2.new(0, 0, 0.13, 0)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = mainFrame
    
    minimizeBtn.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        contentFrame.Visible = not isMinimized
        minimizeBtn.Text = isMinimized and "+" or "−"
        mainFrame.Size = isMinimized and UDim2.new(0, 320, 0, 40) or UDim2.new(0, 320, 0, 420)
    end)
    
    -- Botón cerrar
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 25, 0, 25)
    closeBtn.Position = UDim2.new(1, -30, 0, 5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextScaled = true
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.BorderSizePixel = 0
    closeBtn.Parent = mainFrame
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 5)
    closeCorner.Parent = closeBtn
    
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    
    -- ============================================
    -- 2.2 MENÚ DESPLEGABLE INFO (con flecha)
    -- ============================================
    local infoSection = Instance.new("Frame")
    infoSection.Size = UDim2.new(1, -10, 0.3, 0)
    infoSection.Position = UDim2.new(0, 5, 0, 0)
    infoSection.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    infoSection.BackgroundTransparency = 0.7
    infoSection.BorderSizePixel = 0
    infoSection.ClipsDescendants = true
    infoSection.Parent = contentFrame
    
    local infoCorner = Instance.new("UICorner")
    infoCorner.CornerRadius = UDim.new(0, 10)
    infoCorner.Parent = infoSection
    
    -- Botón flecha INFO
    local infoArrow = Instance.new("TextButton")
    infoArrow.Size = UDim2.new(0, 30, 0, 30)
    infoArrow.Position = UDim2.new(1, -35, 0, 2)
    infoArrow.BackgroundTransparency = 1
    infoArrow.Text = "▼"
    infoArrow.TextColor3 = Color3.fromRGB(255, 215, 0)
    infoArrow.TextScaled = true
    infoArrow.Font = Enum.Font.GothamBold
    infoArrow.Parent = infoSection
    
    -- Contenido INFO
    local infoContent = Instance.new("Frame")
    infoContent.Size = UDim2.new(1, 0, 1, -35)
    infoContent.Position = UDim2.new(0, 0, 0, 35)
    infoContent.BackgroundTransparency = 1
    infoContent.Parent = infoSection
    
    local infoText = Instance.new("TextLabel")
    infoText.Size = UDim2.new(1, -10, 1, -10)
    infoText.Position = UDim2.new(0, 5, 0, 5)
    infoText.BackgroundTransparency = 1
    infoText.Text = "👤 Creador: JoseAngel_Blox\n📅 Fecha: 29/06/2026\n🏷️ Versión: 2.0\n🎮 Juego: Mansion Tycoon"
    infoText.TextColor3 = Color3.fromRGB(200, 200, 230)
    infoText.TextScaled = true
    infoText.TextXAlignment = Enum.TextXAlignment.Left
    infoText.TextYAlignment = Enum.TextYAlignment.Top
    infoText.Font = Enum.Font.Gotham
    infoText.Parent = infoContent
    
    local infoOpen = true
    infoArrow.MouseButton1Click:Connect(function()
        infoOpen = not infoOpen
        infoArrow.Text = infoOpen and "▼" or "▶"
        infoContent.Visible = infoOpen
        infoSection.Size = infoOpen and UDim2.new(1, -10, 0.3, 0) or UDim2.new(1, -10, 0.05, 0)
    end)
    
    -- ============================================
    -- 2.3 MENÚ DESPLEGABLE MAIN (con flecha)
    -- ============================================
    local mainSection = Instance.new("Frame")
    mainSection.Size = UDim2.new(1, -10, 0.6, 0)
    mainSection.Position = UDim2.new(0, 5, 0.32, 0)
    mainSection.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    mainSection.BackgroundTransparency = 0.7
    mainSection.BorderSizePixel = 0
    mainSection.ClipsDescendants = true
    mainSection.Parent = contentFrame
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 10)
    mainCorner.Parent = mainSection
    
    -- Botón flecha MAIN
    local mainArrow = Instance.new("TextButton")
    mainArrow.Size = UDim2.new(0, 30, 0, 30)
    mainArrow.Position = UDim2.new(1, -35, 0, 2)
    mainArrow.BackgroundTransparency = 1
    mainArrow.Text = "▼"
    mainArrow.TextColor3 = Color3.fromRGB(255, 215, 0)
    mainArrow.TextScaled = true
    mainArrow.Font = Enum.Font.GothamBold
    mainArrow.Parent = mainSection
    
    -- Título MAIN
    local mainTitle = Instance.new("TextLabel")
    mainTitle.Size = UDim2.new(0.5, 0, 0.08, 0)
    mainTitle.Position = UDim2.new(0.02, 0, 0, 0)
    mainTitle.BackgroundTransparency = 1
    mainTitle.Text = "⚙️ FUNCIONES"
    mainTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
    mainTitle.TextScaled = true
    mainTitle.Font = Enum.Font.GothamBold
    mainTitle.TextXAlignment = Enum.TextXAlignment.Left
    mainTitle.Parent = mainSection
    
    -- Contenido MAIN (interruptores)
    local mainContent = Instance.new("Frame")
    mainContent.Size = UDim2.new(1, 0, 1, -35)
    mainContent.Position = UDim2.new(0, 0, 0, 35)
    mainContent.BackgroundTransparency = 1
    mainContent.Parent = mainSection
    
    local mainOpen = true
    mainArrow.MouseButton1Click:Connect(function()
        mainOpen = not mainOpen
        mainArrow.Text = mainOpen and "▼" or "▶"
        mainContent.Visible = mainOpen
        mainSection.Size = mainOpen and UDim2.new(1, -10, 0.6, 0) or UDim2.new(1, -10, 0.05, 0)
    end)
    
    -- ============================================
    -- 2.4 INTERRUPTORES PREMIUM
    -- ============================================
    local functions = {
        {name = "💰 Auto-Farme", key = "G", color = Color3.fromRGB(0, 200, 100)},
        {name = "🔧 Auto-Mejoras", key = "H", color = Color3.fromRGB(0, 150, 255)},
        {name = "🏎️ Auto-Racing", key = "J", color = Color3.fromRGB(255, 150, 0)},
        {name = "📦 Auto-Cofres", key = "K", color = Color3.fromRGB(200, 0, 255)},
        {name = "💤 Anti-AFK", key = "L", color = Color3.fromRGB(255, 50, 50)},
    }
    
    local functionButtons = {}
    
    for i, func in ipairs(functions) do
        local yPos = (i-1) * 0.18 + 0.02
        
        -- Fondo del interruptor
        local switchBg = Instance.new("Frame")
        switchBg.Size = UDim2.new(0.95, 0, 0.16, 0)
        switchBg.Position = UDim2.new(0.025, 0, yPos, 0)
        switchBg.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        switchBg.BackgroundTransparency = 0.5
        switchBg.BorderSizePixel = 0
        switchBg.Parent = mainContent
        
        local switchCorner = Instance.new("UICorner")
        switchCorner.CornerRadius = UDim.new(0, 8)
        switchCorner.Parent = switchBg
        
        -- Texto función
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.55, 0, 1, 0)
        label.Position = UDim2.new(0.02, 0, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = func.name
        label.TextColor3 = Color3.fromRGB(220, 220, 255)
        label.TextScaled = true
        label.Font = Enum.Font.Gotham
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = switchBg
        
        -- Interruptor (toggle)
        local toggleBg = Instance.new("Frame")
        toggleBg.Size = UDim2.new(0, 50, 0, 25)
        toggleBg.Position = UDim2.new(0.75, 0, 0.15, 0)
        toggleBg.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        toggleBg.BorderSizePixel = 0
        toggleBg.Parent = switchBg
        
        local toggleCorner = Instance.new("UICorner")
        toggleCorner.CornerRadius = UDim.new(0, 12)
        toggleCorner.Parent = toggleBg
        
        -- Círculo del interruptor
        local toggleCircle = Instance.new("Frame")
        toggleCircle.Size = UDim2.new(0, 20, 0, 20)
        toggleCircle.Position = UDim2.new(0, 3, 0, 2.5)
        toggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        toggleCircle.BorderSizePixel = 0
        toggleCircle.Parent = toggleBg
        
        local circleCorner = Instance.new("UICorner")
        circleCorner.CornerRadius = UDim.new(0, 10)
        circleCorner.Parent = toggleCircle
        
        -- Estado
        local isActive = false
        
        -- Función de toggle
        local function toggleSwitch()
            isActive = not isActive
            toggleBg.BackgroundColor3 = isActive and func.color or Color3.fromRGB(60, 60, 80)
            toggleCircle.Position = isActive and UDim2.new(0, 27, 0, 2.5) or UDim2.new(0, 3, 0, 2.5)
            
            -- Actualizar estado en funciónButtons
            functionButtons[func.key].active = isActive
            
            -- Iniciar/Detener función
            if isActive then
                spawn(function()
                    if func.key == "G" then autoFarm()
                    elseif func.key == "H" then autoUpgrade()
                    elseif func.key == "J" then autoRacing()
                    elseif func.key == "K" then autoChests()
                    elseif func.key == "L" then antiAFK()
                    end
                end)
                print("✅ " .. func.name .. " ACTIVADO")
            else
                print("⛔ " .. func.name .. " DESACTIVADO")
            end
        end
        
        -- Click en el interruptor
        toggleBg.MouseButton1Click:Connect(toggleSwitch)
        toggleBg.MouseButton1Click:Connect(toggleSwitch) -- Para móvil
        
        -- Click en el fondo también activa
        switchBg.MouseButton1Click:Connect(toggleSwitch)
        switchBg.MouseButton1Click:Connect(toggleSwitch) -- Para móvil
        
        functionButtons[func.key] = {
            active = false,
            name = func.name,
            toggle = toggleSwitch,
            bg = toggleBg,
            circle = toggleCircle
        }
    end
    
    -- ============================================
    -- 2.5 SISTEMA DE ARRASTRE (mejorado)
    -- ============================================
    local dragging = false
    local dragStart, startPos
    local dragObj = title
    
    dragObj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)
    
    dragObj.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    userInput.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or 
                         input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    return screenGui, functionButtons
end

-- ============================================
-- 3. FUNCIONES PRINCIPALES (mejoradas)
-- ============================================
local function getCharacter()
    local char = player.Character
    if not char or not char.Parent then
        player.CharacterAdded:Wait()
        char = player.Character
    end
    return char
end

-- 3.1 Auto-Farme
local function autoFarm()
    while functionButtons["G"].active do
        wait(0.3)
        local char = getCharacter()
        local cash = char:FindFirstChild("Cash") or char:FindFirstChild("Money")
        if cash and cash:IsA("BasePart") then
            local clickDetector = cash:FindFirstChild("ClickDetector")
            if clickDetector then
                fireclickdetector(clickDetector)
            end
        end
    end
end

-- 3.2 Auto-Mejoras
local function autoUpgrade()
    while functionButtons["H"].active do
        wait(2)
        local upgrades = workspace:FindFirstChild("Upgrades")
        if upgrades then
            for _, upgrade in ipairs(upgrades:GetChildren()) do
                if upgrade:IsA("Model") then
                    local cd = upgrade:FindFirstChild("ClickDetector")
                    if cd then
                        fireclickdetector(cd)
                    end
                end
            end
        end
    end
end

-- 3.3 Auto-Racing
local function autoRacing()
    while functionButtons["J"].active do
        wait(5)
        local racetrack = workspace:FindFirstChild("Racetrack")
        if racetrack then
            local
