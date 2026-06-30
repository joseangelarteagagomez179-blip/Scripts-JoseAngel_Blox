--// SERVICES
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui
local VirtualInputManager = game:GetService("VirtualInputManager")
local UserInputService = game:GetService("UserInputService")

--// DESTROY OLD UI
if PlayerGui:FindFirstChild("MansionTycoonUI") then 
    PlayerGui.MansionTycoonUI:Destroy() 
end

--// ========== SISTEMA DE CONTROL DE PROCESOS ==========
local ProcessManager = {
    processes = {},
    
    Start = function(self, processId, callback, interval)
        if self.processes[processId] then
            self:Stop(processId)
        end
        
        local running = true
        local connection
        
        connection = RunService.Heartbeat:Connect(function()
            if not running then
                connection:Disconnect()
                return
            end
            pcall(callback)
        end)
        
        self.processes[processId] = {
            running = running,
            connection = connection
        }
        
        return true
    end,
    
    Stop = function(self, processId)
        local process = self.processes[processId]
        if process then
            process.running = false
            if process.connection then
                process.connection:Disconnect()
                process.connection = nil
            end
            self.processes[processId] = nil
            return true
        end
        return false
    end,
    
    IsRunning = function(self, processId)
        return self.processes[processId] ~= nil
    end,
    
    StopAll = function(self)
        for id, _ in pairs(self.processes) do
            self:Stop(id)
        end
    end
}

--// ========== FUNCIONES DE UTILIDAD PARA MANSION TYCOON ==========

-- Buscar todos los botones clickeables en el juego
local function FindAllButtons()
    local buttons = {}
    
    -- Buscar en todas las GUI
    for _, gui in pairs(PlayerGui:GetChildren()) do
        for _, button in pairs(gui:GetDescendants()) do
            if button:IsA("TextButton") or button:IsA("ImageButton") then
                if button.Visible and button.Active then
                    table.insert(buttons, button)
                end
            end
        end
    end
    
    -- Buscar en StarterGui
    for _, gui in pairs(game:GetService("StarterGui"):GetChildren()) do
        for _, button in pairs(gui:GetDescendants()) do
            if button:IsA("TextButton") or button:IsA("ImageButton") then
                if button.Visible and button.Active then
                    table.insert(buttons, button)
                end
            end
        end
    end
    
    return buttons
end

-- Buscar ClickDetectors en el mundo
local function FindAllClickDetectors()
    local detectors = {}
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ClickDetector") then
            table.insert(detectors, obj)
        end
    end
    return detectors
end

-- Buscar objetos de dinero (más agresivo)
local function FindAllMoney()
    local money = {}
    local char = Player.Character
    if not char then return money end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return money end
    
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj:IsDescendantOf(workspace) and obj.CanCollide then
            local name = string.lower(obj.Name or "")
            local className = string.lower(obj.ClassName or "")
            
            -- Palabras clave para dinero
            if name:find("money") or name:find("cash") or name:find("coin") or 
               name:find("drop") or name:find("dollar") or name:find("peso") or
               name:find("oro") or name:find("gold") or name:find("billete") or
               name:find("moneda") or name:find("valor") or name:find("premio") or
               className:find("part") then
                table.insert(money, obj)
            end
        end
    end
    return money
end

--// VARIABLES DE UI
local ScreenGui = Instance.new("ScreenGui")
local MainUI = Instance.new("Frame")
local BackgroundGlow = Instance.new("Frame")
local MovingBackground = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Container = Instance.new("Frame")
local LoadingText = Instance.new("TextLabel")
local LoadingSubText = Instance.new("TextLabel")
local LoadingUI = Instance.new("Frame")
local LoadingBar = Instance.new("Frame")
local LoadingBarFill = Instance.new("Frame")

--// PROPERTIES
ScreenGui.Name = "MansionTycoonUI"
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

--// ========== ANIMACION DE CARGA ==========
LoadingUI.Name = "LoadingUI"
LoadingUI.BackgroundColor3 = Color3.fromRGB(8, 8, 15)
LoadingUI.BackgroundTransparency = 0.95
LoadingUI.Size = UDim2.new(0, 500, 0, 300)
LoadingUI.Position = UDim2.new(0.5, -250, 0.5, -150)
LoadingUI.AnchorPoint = Vector2.new(0, 0)
LoadingUI.Visible = true
LoadingUI.Parent = ScreenGui

local LoadingCorner = Instance.new("UICorner")
LoadingCorner.CornerRadius = UDim.new(0, 20)
LoadingCorner.Parent = LoadingUI

local WaveBackground = Instance.new("Frame")
WaveBackground.Name = "WaveBackground"
WaveBackground.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
WaveBackground.BackgroundTransparency = 0.8
WaveBackground.Size = UDim2.new(0, 500, 0, 300)
WaveBackground.Position = UDim2.new(0, 0, 0, 0)
WaveBackground.Parent = LoadingUI

local WaveCorner = Instance.new("UICorner")
WaveCorner.CornerRadius = UDim.new(0, 20)
WaveCorner.Parent = WaveBackground

local WaveGradient = Instance.new("UIGradient")
WaveGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 20, 80)),
    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(80, 30, 120)),
    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(40, 20, 80)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 30, 120))
}
WaveGradient.Rotation = 0
WaveGradient.Parent = WaveBackground

LoadingText.Name = "LoadingText"
LoadingText.BackgroundTransparency = 1
LoadingText.Size = UDim2.new(1, 0, 0.6, 0)
LoadingText.Position = UDim2.new(0.5, 0, 0.4, 0)
LoadingText.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingText.Font = Enum.Font.FredokaOne
LoadingText.TextColor3 = Color3.new(1, 1, 1)
LoadingText.TextSize = 55
LoadingText.TextWrapped = true
LoadingText.Text = "Bienvenidos a Scripts"
LoadingText.TextTransparency = 1
LoadingText.TextStrokeTransparency = 0.3
LoadingText.TextStrokeColor3 = Color3.fromRGB(80, 0, 180)
LoadingText.Parent = LoadingUI

LoadingSubText.Name = "LoadingSubText"
LoadingSubText.BackgroundTransparency = 1
LoadingSubText.Size = UDim2.new(1, 0, 0.3, 0)
LoadingSubText.Position = UDim2.new(0.5, 0, 0.7, 0)
LoadingSubText.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingSubText.Font = Enum.Font.GothamBold
LoadingSubText.TextColor3 = Color3.fromRGB(180, 120, 255)
LoadingSubText.TextSize = 28
LoadingSubText.Text = "JoseAngel_Blox"
LoadingSubText.TextTransparency = 1
LoadingSubText.TextStrokeTransparency = 0.5
LoadingSubText.TextStrokeColor3 = Color3.fromRGB(40, 0, 80)
LoadingSubText.Parent = LoadingUI

LoadingBar.Name = "LoadingBar"
LoadingBar.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
LoadingBar.Size = UDim2.new(0.8, 0, 0, 6)
LoadingBar.Position = UDim2.new(0.5, -200, 0, 260)
LoadingBar.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingBar.Parent = LoadingUI

local BarCorner = Instance.new("UICorner")
BarCorner.CornerRadius = UDim.new(0, 3)
BarCorner.Parent = LoadingBar

LoadingBarFill.Name = "Fill"
LoadingBarFill.BackgroundColor3 = Color3.fromRGB(150, 50, 255)
LoadingBarFill.Size = UDim2.new(0, 0, 1, 0)
LoadingBarFill.Parent = LoadingBar

local FillCorner = Instance.new("UICorner")
FillCorner.CornerRadius = UDim.new(0, 3)
FillCorner.Parent = LoadingBarFill

--// ========== ANIMACIONES DE CARGA ==========
local function PlayLoadingAnimation()
    local Tween1 = TweenService:Create(LoadingText, TweenInfo.new(1.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
        TextTransparency = 0,
        TextSize = 60
    })
    Tween1:Play()
    
    task.wait(0.3)
    local Tween2 = TweenService:Create(LoadingSubText, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        TextTransparency = 0,
        TextSize = 30
    })
    Tween2:Play()
    
    local StartTime = tick()
    local function UpdateBar()
        local elapsed = tick() - StartTime
        local progress = math.min(elapsed / 3.5, 1)
        LoadingBarFill.Size = UDim2.new(progress, 0, 1, 0)
        
        if progress < 0.3 then
            LoadingBarFill.BackgroundColor3 = Color3.fromRGB(100, 50, 200)
        elseif progress < 0.6 then
            LoadingBarFill.BackgroundColor3 = Color3.fromRGB(150, 50, 255)
        elseif progress < 0.9 then
            LoadingBarFill.BackgroundColor3 = Color3.fromRGB(200, 80, 255)
        else
            LoadingBarFill.BackgroundColor3 = Color3.fromRGB(0, 255, 200)
        end
        
        if progress < 1 then
            RunService.Heartbeat:Wait()
            UpdateBar()
        end
    end
    
    coroutine.wrap(UpdateBar)()
    
    local WaveConnection
    WaveConnection = RunService.Heartbeat:Connect(function()
        WaveGradient.Rotation = (WaveGradient.Rotation or 0) + 0.3
        local breath = math.sin(tick() * 0.5) * 0.1 + 0.8
        WaveBackground.BackgroundTransparency = breath
    end)
    
    return WaveConnection
end

--// ========== MAIN UI ==========
MainUI.Name = "MainUI"
MainUI.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
MainUI.Size = UDim2.new(0, 350, 0, 450)
MainUI.Position = UDim2.new(0.5, -175, 0.5, -225)
MainUI.AnchorPoint = Vector2.new(0, 0)
MainUI.BorderSizePixel = 0
MainUI.Active = true
MainUI.Draggable = true
MainUI.Visible = false
MainUI.Parent = ScreenGui
MainUI.ClipsDescendants = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainUI

MovingBackground.Name = "MovingBackground"
MovingBackground.BackgroundColor3 = Color3.fromRGB(20, 10, 40)
MovingBackground.Size = UDim2.new(2, 0, 2, 0)
MovingBackground.Position = UDim2.new(-0.5, 0, -0.5, 0)
MovingBackground.BackgroundTransparency = 0.5
MovingBackground.ZIndex = -1
MovingBackground.Parent = MainUI

local MovingGradient = Instance.new("UIGradient")
MovingGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 20, 80)),
    ColorSequenceKeypoint.new(0.25, Color3.fromRGB(80, 30, 150)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(40, 20, 80)),
    ColorSequenceKeypoint.new(0.75, Color3.fromRGB(80, 30, 150)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 20, 80))
}
MovingGradient.Rotation = 0
MovingGradient.Parent = MovingBackground

BackgroundGlow.Name = "BackgroundGlow"
BackgroundGlow.BackgroundColor3 = Color3.fromRGB(80, 0, 150)
BackgroundGlow.Size = UDim2.new(1, 0, 1, 0)
BackgroundGlow.Position = UDim2.new(0,0,0,0)
BackgroundGlow.BorderSizePixel = 0
BackgroundGlow.ZIndex = -2
BackgroundGlow.BackgroundTransparency = 0.2
BackgroundGlow.Parent = MainUI

local GlowCorner = Instance.new("UICorner")
GlowCorner.CornerRadius = UDim.new(0, 16)
GlowCorner.Parent = BackgroundGlow

Title.Name = "Title"
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.new(1,1,1)
Title.TextSize = 20
Title.Text = "🏰 Mansion Tycoon v3.1"
Title.Parent = MainUI

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = Title

Container.Name = "Container"
Container.BackgroundTransparency = 1
Container.Size = UDim2.new(1, -16, 1, -60)
Container.Position = UDim2.new(0, 8, 0, 50)
Container.Parent = MainUI

local ScrollContainer = Instance.new("ScrollingFrame")
ScrollContainer.Size = UDim2.new(1, 0, 1, -10)
ScrollContainer.Position = UDim2.new(0, 0, 0, 5)
ScrollContainer.BackgroundTransparency = 1
ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollContainer.ScrollBarThickness = 4
ScrollContainer.ScrollBarImageColor3 = Color3.fromRGB(80, 0, 150)
ScrollContainer.Parent = Container

local ScrollLayout = Instance.new("UIListLayout")
ScrollLayout.Padding = UDim.new(0, 8)
ScrollLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ScrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
ScrollLayout.Parent = ScrollContainer

--// FUNCIONES UI
local function CreateCollapsibleSection(name)
    local Section = Instance.new("Frame")
    local SectionTitle = Instance.new("TextButton")
    local SectionContent = Instance.new("Frame")
    local Layout = Instance.new("UIListLayout")

    Section.Name = name.."Section"
    Section.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
    Section.Size = UDim2.new(1, 0, 0, 40)
    Section.ClipsDescendants = true
    Section.Parent = ScrollContainer

    local SecCorner = Instance.new("UICorner")
    SecCorner.CornerRadius = UDim.new(0, 10)
    SecCorner.Parent = Section

    SectionTitle.Name = "SectionTitle"
    SectionTitle.BackgroundColor3 = Color3.fromRGB(30, 30, 55)
    SectionTitle.Size = UDim2.new(1, 0, 0, 35)
    SectionTitle.Font = Enum.Font.GothamBold
    SectionTitle.TextColor3 = Color3.new(1,1,1)
    SectionTitle.TextSize = 15
    SectionTitle.Text = name.." ▼"
    SectionTitle.Parent = Section
    SectionTitle.AutoButtonColor = false

    local TitleSecCorner = Instance.new("UICorner")
    TitleSecCorner.CornerRadius = UDim.new(0, 8)
    TitleSecCorner.Parent = SectionTitle

    SectionContent.Name = "Content"
    SectionContent.BackgroundTransparency = 1
    SectionContent.Size = UDim2.new(1, -20, 0, 0)
    SectionContent.Position = UDim2.new(0, 10, 0, 40)
    SectionContent.Visible = false
    SectionContent.Parent = Section

    Layout.Parent = SectionContent
    Layout.Padding = UDim.new(0, 4)
    Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local Open = false
    SectionTitle.MouseButton1Click:Connect(function()
        Open = not Open
        if Open then
            SectionTitle.Text = name.." ▲"
            SectionContent.Visible = true
            local contentSize = #SectionContent:GetChildren() * 35 + 10
            TweenService:Create(Section, TweenInfo.new(0.3), {Size = UDim2.new(1, 0, 0, 40 + contentSize)}):Play()
        else
            SectionTitle.Text = name.." ▼"
            SectionContent.Visible = false
            TweenService:Create(Section, TweenInfo.new(0.3), {Size = UDim2.new(1, 0, 0, 40)}):Play()
        end
        task.wait(0.35)
        ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, ScrollContainer:GetChildren()[1].AbsoluteContentSize.Y + 50)
    end)

    return SectionContent
end

local function CreateToggle(parent, text, callback)
    local ToggleFrame = Instance.new("Frame")
    local ToggleLabel = Instance.new("TextLabel")
    local ToggleButton = Instance.new("TextButton")
    local ToggleFill = Instance.new("Frame")
    local ToggleCorner = Instance.new("UICorner")
    local FillCorner = Instance.new("UICorner")

    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Size = UDim2.new(1, 0, 0, 30)
    ToggleFrame.Parent = parent

    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Size = UDim2.new(0.6, 0, 1, 0)
    ToggleLabel.Position = UDim2.new(0, 5, 0, 0)
    ToggleLabel.Font = Enum.Font.GothamBold
    ToggleLabel.TextColor3 = Color3.new(1,1,1)
    ToggleLabel.TextSize = 12
    ToggleLabel.Text = text
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.Parent = ToggleFrame

    ToggleButton.Name = "Toggle"
    ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
    ToggleButton.Size = UDim2.new(0, 40, 0, 20)
    ToggleButton.Position = UDim2.new(1, -46, 0.5, -10)
    ToggleButton.Parent = ToggleFrame
    ToggleButton.AutoButtonColor = false

    ToggleCorner.CornerRadius = UDim.new(0, 10)
    ToggleCorner.Parent = ToggleButton

    ToggleFill.Name = "Fill"
    ToggleFill.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
    ToggleFill.Size = UDim2.new(0, 18, 0, 18)
    ToggleFill.Position = UDim2.new(0, 1, 0, 1)
    ToggleFill.Parent = ToggleButton

    FillCorner.CornerRadius = UDim.new(1, 0)
    FillCorner.Parent = ToggleFill

    local Enabled = false

    local function Update()
        if Enabled then
            TweenService:Create(ToggleFill, TweenInfo.new(0.15), {Position = UDim2.new(1, -19, 0, 1), BackgroundColor3 = Color3.fromRGB(180, 50, 255)}):Play()
            TweenService:Create(ToggleButton, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(40, 20, 70)}):Play()
        else
            TweenService:Create(ToggleFill, TweenInfo.new(0.15), {Position = UDim2.new(0, 1, 0, 1), BackgroundColor3 = Color3.fromRGB(100, 0, 200)}):Play()
            TweenService:Create(ToggleButton, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(50, 50, 80)}):Play()
        end
        if callback then callback(Enabled) end
    end

    ToggleButton.MouseButton1Click:Connect(function()
        Enabled = not Enabled
        Update()
    end)

    Update()
    return ToggleFrame
end

--// CREAR SECCIONES
local InfoSection = CreateCollapsibleSection("ℹ️ Info")
local InfoLabel = Instance.new("TextLabel")
InfoLabel.BackgroundTransparency = 1
InfoLabel.Size = UDim2.new(1, 0, 0, 50)
InfoLabel.Font = Enum.Font.GothamBold
InfoLabel.TextColor3 = Color3.new(1,1,1)
InfoLabel.TextSize = 13
InfoLabel.Text = "👑 Creador: JoseAngel_Blox\n📅 Versión: 3.1 - Mansion Tycoon"
InfoLabel.TextWrapped = true
InfoLabel.Parent = InfoSection

local MainSection = CreateCollapsibleSection("⚙️ Main")
local AutoSection = CreateCollapsibleSection("🤖 Automatización")

--// =============================================
--// FUNCIONES ESPECÍFICAS PARA MANSION TYCOON (MEJORADAS)
--// =============================================

--// 1. AUTO RECOGER DINERO (VERSIÓN MEJORADA)
CreateToggle(AutoSection, "💰 Auto Recoger", function(state)
    local processId = "AutoRecoger"
    
    if state then
        ProcessManager:Start(processId, function()
            local char = Player.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            
            -- Buscar dinero de forma más agresiva
            local moneyObjects = FindAllMoney()
            for _, obj in pairs(moneyObjects) do
                if obj and obj:IsA("BasePart") and obj:IsDescendantOf(workspace) then
                    -- Intentar diferentes métodos para recoger
                    pcall(function()
                        obj.CFrame = hrp.CFrame + Vector3.new(0, 2, 0)
                        -- También intentar firetouch
                        local touchParts = obj:GetTouchingParts()
                        for _, touchPart in pairs(touchParts) do
                            if touchPart:IsDescendantOf(char) then
                                -- Ya está tocando
                            end
                        end
                    end)
                end
            end
            
            -- Método alternativo: buscar objetos con TouchTransmitter
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj:FindFirstChild("TouchTransmitter") then
                    local name = string.lower(obj.Name or "")
                    if name:find("money") or name:find("cash") or name:find("coin") or
                       name:find("drop") or name:find("dollar") then
                        pcall(function()
                            obj.CFrame = hrp.CFrame + Vector3.new(0, 2, 0)
                        end)
                    end
                end
            end
        end, 0.1)
    else
        ProcessManager:Stop(processId)
    end
end)

--// 2. AUTO CONSTRUIR (VERSIÓN MEJORADA)
CreateToggle(AutoSection, "🔨 Auto Construir", function(state)
    local processId = "AutoConstruir"
    
    if state then
        ProcessManager:Start(processId, function()
            -- Buscar TODOS los botones
            local allButtons = FindAllButtons()
            
            for _, button in pairs(allButtons) do
                if button.Visible and button.Active then
                    local name = string.lower(button.Name or "")
                    local text = string.lower(button.Text or "")
                    local className = string.lower(button.ClassName or "")
                    
                    -- Palabras clave para construcción
                    local keywords = {"buy", "build", "claim", "construir", "comprar", 
                                    "purchase", "adquirir", "comprar", "construir", 
                                    "edificar", "levantar", "construir"}
                    
                    local shouldClick = false
                    for _, keyword in pairs(keywords) do
                        if name:find(keyword) or text:find(keyword) then
                            shouldClick = true
                            break
                        end
                    end
                    
                    if shouldClick then
                        pcall(function()
                            button:MouseButton1Click()
                            task.wait(0.05)
                        end)
                    end
                end
            end
            
            -- También buscar ClickDetectors de construcción
            local detectors = FindAllClickDetectors()
            for _, detector in pairs(detectors) do
                local parentName = string.lower(detector.Parent and detector.Parent.Name or "")
                if parentName:find("build") or parentName:find("construir") or 
                   parentName:find("buy") or parentName:find("comprar") then
                    pcall(function()
                        fireclickdetector(detector)
                        task.wait(0.05)
                    end)
                end
            end
        end, 0.3)
    else
        ProcessManager:Stop(processId)
    end
end)

--// 3. AUTO MEJORAS (VERSIÓN MEJORADA)
CreateToggle(AutoSection, "⬆️ Auto Mejoras", function(state)
    local processId = "AutoMejoras"
    
    if state then
        ProcessManager:Start(processId, function()
            -- ClickDetectors de mejoras
            local detectors = FindAllClickDetectors()
            for _, detector in pairs(detectors) do
                local parentName = string.lower(detector.Parent and detector.Parent.Name or "")
                local detectorName = string.lower(detector.Name or "")
                
                if parentName:find("upgrade") or parentName:find("mejora") or 
                   parentName:find("improve") or parentName:find("level") or
                   detectorName:find("upgrade") or detectorName:find("mejora") then
                    pcall(function()
                        fireclickdetector(detector)
                        task.wait(0.05)
                    end)
                end
            end
            
            -- Botones de mejoras
            local allButtons = FindAllButtons()
            for _, button in pairs(allButtons) do
                if button.Visible and button.Active then
                    local name = string.lower(button.Name or "")
                    local text = string.lower(button.Text or "")
                    
                    if name:find("upgrade") or name:find("mejora") or 
                       text:find("upgrade") or text:find("mejora") or
                       text:find("mejorar") or text:find("improve") then
                        pcall(function()
                            button:MouseButton1Click()
                            task.wait(0.05)
                        end)
                    end
                end
            end
        end, 0.4)
    else
        ProcessManager:Stop(processId)
    end
end)

--// 4. AUTO REBAJAS (VERSIÓN MEJORADA)
CreateToggle(AutoSection, "🛒 Auto Re bajas", function(state)
    local processId = "AutoRebajas"
    
    if state then
        ProcessManager:Start(processId, function()
            local allButtons = FindAllButtons()
            for _, button in pairs(allButtons) do
                if button.Visible and button.Active then
                    local text = string.lower(button.Text or "")
                    local name = string.lower(button.Name or "")
                    
                    if text:find("reba") or text:find("ofert") or text:find("descu") or
                       text:find("sale") or text:find("discount") or text:find("promo") or
                       name:find("reba") or name:find("ofert") or name:find("promo") then
                        pcall(function()
                            button:MouseButton1Click()
                            task.wait(0.05)
                        end)
                    end
                end
            end
        end, 0.5)
    else
        ProcessManager:Stop(processId)
    end
end)

--// 5. AUTO FARM COMPLETO (VERSIÓN MEJORADA)
CreateToggle(AutoSection, "⚡ Auto Farm", function(state)
    local processId = "AutoFarm"
    
    if state then
        ProcessManager:Start(processId, function()
            local char = Player.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            
            -- 1. Recoger dinero
            local moneyObjects = FindAllMoney()
            for _, obj in pairs(moneyObjects) do
                if obj and obj:IsA("BasePart") then
                    pcall(function()
                        obj.CFrame = hrp.CFrame + Vector3.new(0, 2, 0)
                    end)
                end
            end
            
            -- 2. Construir automáticamente
            local allButtons = FindAllButtons()
            for _, button in pairs(allButtons) do
                if button.Visible and button.Active then
                    local text = string.lower(button.Text or "")
                    local name = string.lower(button.Name or "")
                    
                    if text:find("comprar") or text:find("construir") or 
                       text:find("build") or text:find("buy") or
                       name:find("build") or name:find("buy") then
                        pcall(function()
                            button:MouseButton1Click()
                            task.wait(0.05)
                        end)
                    end
                end
            end
            
            -- 3. ClickDetectors
            local detectors = FindAllClickDetectors()
            for _, detector in pairs(detectors) do
                local parentName = string.lower(detector.Parent and detector.Parent.Name or "")
                if parentName:find("build") or parentName:find("buy") or 
                   parentName:find("construir") or parentName:find("comprar") then
                    pcall(function()
                        fireclickdetector(detector)
                        task.wait(0.05)
                    end)
                end
            end
        end, 0.15)
    else
        ProcessManager:Stop(processId)
    end
end)

--// 6. VELOCIDAD (MEJORADO)
CreateToggle(MainSection, "🏃 Velocidad x3", function(state)
    local function setSpeed()
        local char = Player.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = state and 50 or 16
            end
        end
    end
    
    setSpeed()
    local connection = Player.CharacterAdded:Connect(function()
        task.wait(0.5)
        setSpeed()
    end)
    
    if not state then
        connection:Disconnect()
    end
end)

--// 7. SALTO EXTRA
CreateToggle(MainSection, "🦘 Salto Extra", function(state)
    local function setJump()
        local char = Player.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.JumpPower = state and 100 or 50
            end
        end
    end
    
    setJump()
    local connection = Player.CharacterAdded:Connect(function()
        task.wait(0.5)
        setJump()
    end)
    
    if not state then
        connection:Disconnect()
    end
end)

--// 8. AUTO CLICK (NUEVO - Hace clic en todo)
CreateToggle(AutoSection, "🖱️ Auto Click", function(state)
    local processId = "AutoClick"
    
    if state then
        ProcessManager:Start(processId, function()
            local allButtons = FindAllButtons()
            for _, button in pairs(allButtons) do
                if button.Visible and button.Active then
                    pcall(function()
                        button:MouseButton1Click()
                        task.wait(0.01)
                    end)
                end
            end
        end, 0.05)
    else
        ProcessManager:Stop(processId)
    end
end)

--// ========== INICIAR ANIMACIONES DE FONDO ==========
local function StartBackgroundAnimations()
    local BgConnection = RunService.Heartbeat:Connect(function()
        local time = tick() * 0.05
        MovingBackground.Position = UDim2.new(
            -0.5 + math.sin(time * 0.7) * 0.3,
            0,
            -0.5 + math.cos(time * 0.5) * 0.3,
            0
        )
        MovingGradient.Rotation = (MovingGradient.Rotation or 0) + 0.1
    end)
    
    local GlowConnection = RunService.Heartbeat:Connect(function()
        local breath = math.sin(tick() * 2) * 0.1 + 0.2
        BackgroundGlow.BackgroundTransparency = breath
    end)
    
    return BgConnection, GlowConnection
end

--// ========== SECUENCIA DE CARGA ==========
local WaveConnection = PlayLoadingAnimation()
task.wait(4)

local FadeOut = TweenService:Create(LoadingUI, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    BackgroundTransparency = 1,
    Size = UDim2.new(0, 200, 0, 100),
    Position = UDim2.new(0.5, -100, 0.5, -50)
})
FadeOut:Play()

if WaveConnection then
    WaveConnection:Disconnect()
end

task.wait(0.8)
LoadingUI:Destroy()

MainUI.Visible = true
MainUI.Size = UDim2.new(0, 300, 0, 400)
MainUI.Position = UDim2.new(0.5, -150, 0.5, -200)

local TweenOpen = TweenService:Create(MainUI, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 350, 0, 450),
    Position = UDim2.new(0.5, -175, 0.5, -225)
})
TweenOpen:Play()

local BgConnection, GlowConnection = StartBackgroundAnimations()

--// ========== LIMPIEZA AL CERRAR ==========
ScreenGui.AncestryChanged:Connect(function()
    if not ScreenGui.Parent then
        ProcessManager:StopAll()
        if BgConnection then BgConnection:Disconnect() end
        if GlowConnection then GlowConnection:Disconnect() end
    end
end)

print("✅ Script Cargado - Mansion Tycoon v3.1 Optimizado")
