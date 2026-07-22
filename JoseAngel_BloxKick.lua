-- ╔════════════════════════════════════════╗
-- ║     JoseAngel_Blox Kick | v1.1          ║
-- ║     Kick a Lucky Block Script           ║
-- ╚════════════════════════════════════════╝

-- Servicios
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- ═══ CREACIÓN DEL PANEL PRINCIPAL ═══
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "JoseAngel_BloxKick"
MainGui.Parent = PlayerGui
MainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
MainGui.ResetOnSpawn = false

-- Panel principal (Cuadrado, esquinas redondeadas)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 380) -- Ancho 320px / Alto 380px
MainFrame.Position = UDim2.new(0.05, 0, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromHex("#1a1a2e")
MainFrame.BorderColor3 = Color3.fromHex("#0f3460")
MainFrame.BorderSizePixel = 2
MainFrame.CornerRadius = UDim.new(0, 16) -- Esquinas redondeadas
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = MainGui

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "JoseAngel_Blox Kick"
Title.TextColor3 = Color3.fromHex("#e94560")
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Title.Parent = MainFrame

-- Botón Cerrar
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromHex("#e94560")
CloseBtn.CornerRadius = UDim.new(0, 8)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextScaled = true
CloseBtn.Parent = MainFrame
CloseBtn.MouseButton1Click:Connect(function() MainGui:Destroy() end)

-- Contenedor de secciones
local SectionsContainer = Instance.new("ScrollingFrame")
SectionsContainer.Size = UDim2.new(1, -10, 1, -50)
SectionsContainer.Position = UDim2.new(0, 5, 0, 45)
SectionsContainer.BackgroundTransparency = 1
SectionsContainer.ScrollBarThickness = 4
SectionsContainer.Parent = MainFrame

-- ═══ FUNCIÓN PARA CREAR SECCIONES DESPLEGABLES ═══
local function CreateSection(name, yPos)
    local Section = Instance.new("Frame")
    Section.Size = UDim2.new(1, 0, 0, 35)
    Section.Position = UDim2.new(0, 0, 0, yPos)
    Section.BackgroundTransparency = 1
    Section.Parent = SectionsContainer

    local Header = Instance.new("TextButton")
    Header.Size = UDim2.new(1, 0, 0, 30)
    Header.BackgroundColor3 = Color3.fromHex("#16213e")
    Header.CornerRadius = UDim.new(0, 8)
    Header.Text = "  "..name.." ↓"
    Header.TextColor3 = Color3.new(1,1,1)
    Header.Font = Enum.Font.GothamSemibold
    Header.TextXAlignment = Enum.TextXAlignment.Left
    Header.Parent = Section

    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(1, 0, 0, 0)
    Content.Position = UDim2.new(0, 0, 0, 32)
    Content.BackgroundTransparency = 1
    Content.ClipsDescendants = true
    Content.Parent = Section
    local Open = false

    Header.MouseButton1Click:Connect(function()
        Open = not Open
        Header.Text = "  "..name.." "..(Open and "↑" or "↓")
        TweenService:Create(Content, TweenInfo.new(0.2), {Size = UDim2.new(1,0,0, Open and #Content:GetChildren()*32 or 0)}):Play()
    end)

    return Section, Content
end

-- ═══ CREAR SECCIONES ═══
local InfoSection, InfoContent = CreateSection("Info", 0)
local MainSection, MainContent = CreateSection("Main", 40)

-- ═══ CONTENIDO DE INFO ═══
local InfoText = Instance.new("TextLabel")
InfoText.Size = UDim2.new(1, 0, 0, 130)
InfoText.BackgroundTransparency = 1
InfoText.Text = [[
Creador: JoseAngel_Blox
Lanzamiento: 22/07/2026
Versión: 1.1

👋 ¡Hola! Bienvenido,
disfruta mucho del script ✨
]]
InfoText.TextColor3 = Color3.new(0.9,0.9,0.9)
InfoText.Font = Enum.Font.Gotham
InfoText.TextWrapped = true
InfoText.TextXAlignment = Enum.TextXAlignment.Left
InfoText.Parent = InfoContent

-- ═══ FUNCIÓN PARA CREAR TOGGLES ═══
local function CreateToggle(text, yPos, callback)
    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(1, 0, 0, 28)
    Toggle.Position = UDim2.new(0, 0, 0, yPos)
    Toggle.BackgroundTransparency = 1
    Toggle.Text = "  ⚫ "..text
    Toggle.TextColor3 = Color3.new(0.7,0.7,0.7)
    Toggle.Font = Enum.Font.Gotham
    Toggle.TextXAlignment = Enum.TextXAlignment.Left
    Toggle.Parent = MainContent
    local Enabled = false

    Toggle.MouseButton1Click:Connect(function()
        Enabled = not Enabled
        Toggle.Text = "  "..(Enabled and "🟢" or "⚫").." "..text
        Toggle.TextColor3 = Enabled and Color3.new(0.3,1,0.3) or Color3.new(0.7,0.7,0.7)
        callback(Enabled)
    end)
    return Toggle
end

-- ═══ CONTENIDO DE MAIN (TODAS LAS FUNCIONES) ═══
CreateToggle("Auto-Kick", 0, function(Enabled)
    _G.AutoKick = Enabled
end)

CreateToggle("Auto-Esquivar Tsunami", 30, function(Enabled)
    _G.AutoTsunami = Enabled
end)

CreateToggle("Auto Pesar (Pesas)", 60, function(Enabled)
    _G.AutoWeight = Enabled
end)

CreateToggle("Auto Click x2", 90, function(Enabled)
    _G.AutoClick2x = Enabled
end)

CreateToggle("Moverse con Pesa", 120, function(Enabled)
    _G.EnableMove = Enabled
end)

CreateToggle("Auto Reclamar Dinero", 150, function(Enabled)
    _G.AutoMoney = Enabled
end)

CreateToggle("Anti-AFK", 180, function(Enabled)
    _G.AntiAFK = Enabled
end)

CreateToggle("Auto Comprar Mejoras", 210, function(Enabled)
    _G.AutoUpgrade = Enabled
end)

-- Panel de Predicción Brainrot
local BrainrotPanel = Instance.new("Frame")
BrainrotPanel.Size = UDim2.new(1, 0, 0, 80)
BrainrotPanel.Position = UDim2.new(0, 0, 0, 240)
BrainrotPanel.BackgroundColor3 = Color3.fromHex("#0f3460")
BrainrotPanel.CornerRadius = UDim.new(0, 8)
BrainrotPanel.Parent = MainContent

local BrainrotTitle = Instance.new("TextLabel")
BrainrotTitle.Size = UDim2.new(1,0,0,20)
BrainrotTitle.BackgroundTransparency = 1
BrainrotTitle.Text = "🔮 Brainrot que saldrá:"
BrainrotTitle.TextColor3 = Color3.new(1,1,1)
BrainrotTitle.Font = Enum.Font.GothamSemibold
BrainrotTitle.TextScaled = true
BrainrotTitle.Parent = BrainrotPanel

local BrainrotInfo = Instance.new("TextLabel")
BrainrotInfo.Size = UDim2.new(1,0,0,55)
BrainrotInfo.Position = UDim2.new(0,0,0,22)
BrainrotInfo.BackgroundTransparency = 1
BrainrotInfo.Text = "Esperando bloque..."
BrainrotInfo.TextColor3 = Color3.new(0.8,0.8,0.8)
BrainrotInfo.Font = Enum.Font.Gotham
BrainrotInfo.TextWrapped = true
BrainrotInfo.Parent = BrainrotPanel

-- ═══ LÓGICA DE LAS FUNCIONES ═══
-- Anti-AFK
spawn(function()
    while task.wait(60) do
        if _G.AntiAFK and Humanoid then
            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- Bucle principal
RunService.Heartbeat:Connect(function()
    if not Character or not Humanoid then return end

    -- Auto-Kick
    if _G.AutoKick then
        local Block = workspace:FindFirstChild("LuckyBlock")
        if Block and Player:DistanceFromCharacter(Block.Position) < 15 then
            -- Simular patada cuando termine cooldown
            task.wait(2)
            fireclickdetector(Block.ClickDetector)
        end
    end

    -- Auto Tsunami
    if _G.AutoTsunami and workspace:FindFirstChild("Tsunami") then
        local SafeZone = workspace:FindFirstChild("SafeZone")
        if SafeZone then
            Humanoid:MoveTo(SafeZone.Position)
            task.wait(5)
            Humanoid:MoveTo(Character.Position)
        end
    end

    -- Auto Weight
    if _G.AutoWeight then
        local Weight = workspace:FindFirstChildWhichIsA("Tool", true)
        if Weight and Weight.Name:find("Weight") then
            Player.Character.Humanoid:EquipTool(Weight)
        end
    end

    -- Auto Click x2
    if _G.AutoClick2x then
        local Button = PlayerGui:FindFirstChild("2xButton", true)
        if Button then fireclickdetector(Button) end
    end

    -- Mover con pesa
    if _G.EnableMove then
        Humanoid.WalkSpeed = 16
    end

    -- Auto Dinero
    if _G.AutoMoney then
        for _,v in pairs(workspace.PlotOwners[Player.Name].Brainrots:GetChildren()) do
            if v:FindFirstChild("Collect") then fireclickdetector(v.Collect) end
        end
    end

    -- Auto Mejoras
    if _G.AutoUpgrade then
        local Money = Player.leaderstats.Money.Value
        local Shop = PlayerGui:FindFirstChild("Shop", true)
        if Shop and Money >= 500 then
            fireclickdetector(Shop.Upgrades.Legs)
        end
    end

    -- Mostrar Brainrot
    local NextRoll = workspace:FindFirstChild("NextRoll")
    if NextRoll then
        local Rarity = {
            Common = Color3.new(1,1,1),
            Rare = Color3.new(0,0.7,1),
            OG = Color3.new(1,0.8,0),
            Celestial = Color3.new(1,0,1),
            Diamond = Color3.new(0,1,1),
            Gold = Color3.new(1,0.84,0)
        }
        BrainrotInfo.Text = "📦 "..NextRoll.Name.."\n✨ Rareza: "..NextRoll.Rarity.Value
        BrainrotInfo.TextColor3 = Rarity[NextRoll.Rarity.Value] or Color3.new(1,1,1)
    end
end)

-- ═══ FINALIZADO ═══
print("[✅] JoseAngel_Blox Kick v1.1 Cargado Correctamente!")
