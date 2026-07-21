-- =============================================
-- BRAINROTS DUPLICATIONS
-- Script Profesional para duplicar Brainrots
-- Creado por: JoseAngel_Blox
-- Fecha: 20/07/2026
-- Versión: 1.1
-- =============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

-- ==================== VARIABLES ====================
local guiEnabled = false
local dupeEnabled = false
local selectedBrainrot = nil

local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local root = character:WaitForChild("HumanoidRootPart")

-- ==================== CREAR GUI PROFESIONAL ====================
local function createGui()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "BrainrotsDuplications"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")

    -- Fondo bonito y moderno
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 520, 0, 420)
    mainFrame.Position = UDim2.new(0.5, -260, 0.5, -210)
    mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui

    -- Esquinas redondeadas
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 16)
    corner.Parent = mainFrame

    -- Sombra elegante
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(0, 170, 255)
    stroke.Thickness = 2
    stroke.Parent = mainFrame

    -- Título principal
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 60)
    title.BackgroundTransparency = 1
    title.Text = "BRAINROTS DUPLICATIONS"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = mainFrame

    -- Línea decorativa
    local line = Instance.new("Frame")
    line.Size = UDim2.new(0.9, 0, 0, 3)
    line.Position = UDim2.new(0.05, 0, 0, 55)
    line.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    line.BorderSizePixel = 0
    line.Parent = mainFrame
    local lineCorner = Instance.new("UICorner")
    lineCorner.CornerRadius = UDim.new(0, 2)
    lineCorner.Parent = line

    -- Info (sección superior)
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(1, -20, 0, 80)
    infoLabel.Position = UDim2.new(0.05, 0, 0, 70)
    infoLabel.BackgroundTransparency = 1
    infoLabel.Text = [[
Nombre del Creador: JoseAngel_Blox
Fecha de lanzamiento: 20/07/2026
Versión: 1.1
    ]]
    infoLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    infoLabel.TextXAlignment = Enum.TextXAlignment.Left
    infoLabel.TextYAlignment = Enum.TextYAlignment.Top
    infoLabel.TextScaled = false
    infoLabel.Font = Enum.Font.Gotham
    infoLabel.Parent = mainFrame

    -- Sección "Duplicar"
    local dupLabel = Instance.new("TextLabel")
    dupLabel.Size = UDim2.new(1, -20, 0, 35)
    dupLabel.Position = UDim2.new(0.05, 0, 0, 155)
    dupLabel.BackgroundTransparency = 1
    dupLabel.Text = "Duplicar"
    dupLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
    dupLabel.TextScaled = true
    dupLabel.Font = Enum.Font.GothamBold
    dupLabel.Parent = mainFrame

    -- Toggle bonito
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(0, 80, 0, 40)
    toggleFrame.Position = UDim2.new(0.75, 0, 0, 155)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    toggleFrame.Parent = mainFrame
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 20)
    toggleCorner.Parent = toggleFrame

    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(1, 0, 1, 0)
    toggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    toggleButton.Text = "OFF"
    toggleButton.TextColor3 = Color3.new(1, 1, 1)
    toggleButton.TextScaled = true
    toggleButton.Font = Enum.Font.GothamBold
    toggleButton.Parent = toggleFrame
    local toggleBtnCorner = Instance.new("UICorner")
    toggleBtnCorner.CornerRadius = UDim.new(0, 20)
    toggleBtnCorner.Parent = toggleButton

    -- Lista de Brainrots (scrolling)
    local listFrame = Instance.new("ScrollingFrame")
    listFrame.Size = UDim2.new(0.9, 0, 0, 180)
    listFrame.Position = UDim2.new(0.05, 0, 0, 200)
    listFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    listFrame.ScrollBarThickness = 8
    listFrame.Parent = mainFrame
    local listCorner = Instance.new("UICorner")
    listCorner.CornerRadius = UDim.new(0, 12)
    listCorner.Parent = listFrame

    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 8)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Parent = listFrame

    -- Función para actualizar lista
    local function updateList()
        for _, child in ipairs(listFrame:GetChildren()) do
            if child:IsA("TextButton") then child:Destroy() end
        end

        local brainrotsFolder = workspace:FindFirstChild("Brainrots") or workspace:FindFirstChild("Brainrot") or ReplicatedStorage:FindFirstChild("Brainrots")
        if not brainrotsFolder then return end

        for _, obj in ipairs(brainrotsFolder:GetChildren()) do
            if obj:IsA("Model") or obj:IsA("Part") then
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, -10, 0, 45)
                btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                btn.Text = obj.Name
                btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                btn.TextScaled = true
                btn.Font = Enum.Font.Gotham
                btn.Parent = listFrame
                local btnCorner = Instance.new("UICorner")
                btnCorner.CornerRadius = UDim.new(0, 10)
                btnCorner.Parent = btn

                btn.MouseButton1Click:Connect(function()
                    selectedBrainrot = obj
                    -- Feedback visual
                    for _, b in ipairs(listFrame:GetChildren()) do
                        if b:IsA("TextButton") then
                            b.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                        end
                    end
                    btn.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
                end)
            end
        end
    end

    -- Toggle dupe
    toggleButton.MouseButton1Click:Connect(function()
        dupeEnabled = not dupeEnabled
        if dupeEnabled then
            toggleButton.Text = "ON"
            toggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
        else
            toggleButton.Text = "OFF"
            toggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        end
    end)

    -- Loop para mantener lista actualizada
    task.spawn(function()
        while true do
            updateList()
            task.wait(1)
        end
    end)

    -- Loop de duplicación
    RunService.Heartbeat:Connect(function()
        if not dupeEnabled or not selectedBrainrot then return end

        local brainrotsFolder = workspace:FindFirstChild("Brainrots") or workspace:FindFirstChild("Brainrot")
        if not brainrotsFolder then return end

        -- Crear copia perfecta (mismo nombre y apariencia)
        local clone = selectedBrainrot:Clone()
        clone.Name = selectedBrainrot.Name
        clone.Parent = brainrotsFolder

        -- Animación de "duplicación"
        clone:PivotTo(selectedBrainrot:GetPivot())
        clone:MakeJoints()

        -- Efecto visual bonito
        local effect = Instance.new("ParticleEmitter")
        effect.Texture = "rbxassetid://241837771"
        effect.Color = ColorSequence.new(Color3.fromRGB(0, 255, 150))
        effect.Rate = 50
        effect.Lifetime = NumberRange.new(0.8)
        effect.Speed = NumberRange.new(3)
        effect.Parent = clone

        task.delay(2, function()
            effect:Destroy()
        end)

        -- Pequeño delay para que no spamee
        task.wait(0.3)
    end)

    -- Cerrar con ESC
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.Escape then
            screenGui.Enabled = false
        end
    end)

    -- Auto abrir al cargar
    print("✅ Brainrots Duplications cargado correctamente")
    print("Presiona ESC para cerrar • Selecciona un Brainrot de la lista y actívalo el toggle")

    return screenGui
end

-- ==================== INICIO ====================
local gui = createGui()

-- Actualizar lista inicial
task.wait(1)
updateList()

-- Character added
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = newChar:WaitForChild("Humanoid")
    root = newChar:WaitForChild("HumanoidRootPart")
end)
