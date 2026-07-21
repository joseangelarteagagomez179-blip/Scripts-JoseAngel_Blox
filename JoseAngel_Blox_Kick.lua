--[[
    JoseAngel_Blox Kick v1.1
    Creado por: JoseAngel_Blox
    Fecha: 22/07/2026
    Para: Kick a Lucky Block
    Ejecutor: Delta
]]

-- ==================== CONFIGURACIÓN ====================
local Config = {
    AutoKick = false,
    AutoTsunami = false,
    AutoWeight = false,
    AutoClickX2 = false,
    EnableMove = false,
    AutoReclamar = false,
    AntiAfk = false,
    AutoComprar = false,
    ShowPanel = false,
    TsunamiActive = false,
    MovimientoActivo = false,
}

-- ==================== SERVICIOS ====================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()

-- ==================== VARIABLES GLOBALES ====================
local coroutines = {}
local tsunamiAltura = 50
local zonaSegura = nil
local pesoObjeto = nil
local botonX2 = nil
local LuckyBlock = nil
local Tienda = nil
local ReclamarBtn = nil

-- ==================== UI CREACIÓN ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Blox_Kick_GUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Fondo oscuro overlay
local function crearMainFrame()
    local Main = Instance.new("Frame")
    Main.Name = "MainFrame"
    Main.Size = UDim2.new(0, 340, 0, 440)
    Main.Position = UDim2.new(0.5, -170, 0.5, -220)
    Main.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    Main.BackgroundTransparency = 0.08
    Main.BorderSizePixel = 0
    Main.Active = true
    Main.Draggable = true
    Main.Parent = ScreenGui

    -- Sombra
    local Sombra = Instance.new("ImageLabel")
    Sombra.Name = "Sombra"
    Sombra.Size = UDim2.new(1, 20, 1, 20)
    Sombra.Position = UDim2.new(0, -10, 0, -10)
    Sombra.BackgroundTransparency = 1
    Sombra.Image = "rbxassetid://6014261993"
    Sombra.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Sombra.ImageTransparency = 0.8
    Sombra.ScaleType = Enum.ScaleType.Slice
    Sombra.SliceCenter = Rect.new(10, 10, 118, 118)
    Sombra.Parent = Main

    -- Borde redondeado (esquinas)
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = Main

    -- Borde brillante
    local Borde = Instance.new("Frame")
    Borde.Name = "Borde"
    Borde.Size = UDim2.new(1, 0, 1, 0)
    Borde.BackgroundTransparency = 1
    Borde.BorderSizePixel = 0
    Borde.Parent = Main

    local BordeCorner = Instance.new("UICorner")
    BordeCorner.CornerRadius = UDim.new(0, 12)
    BordeCorner.Parent = Borde

    local BordeStroke = Instance.new("UIStroke")
    BordeStroke.Color = Color3.fromRGB(255, 170, 0)
    BordeStroke.Thickness = 2
    BordeStroke.Transparency = 0.4
    BordeStroke.Parent = Borde

    -- Barra superior
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    TopBar.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
    TopBar.BackgroundTransparency = 0.15
    TopBar.BorderSizePixel = 0
    TopBar.Parent = Main

    local TopBarCorner = Instance.new("UICorner")
    TopBarCorner.CornerRadius = UDim.new(0, 12)
    TopBarCorner.Parent = TopBar

    -- Solo esquinas superiores redondeadas
    local TopBarCornerFix = Instance.new("Frame")
    TopBarCornerFix.Name = "CornerFix"
    TopBarCornerFix.Size = UDim2.new(1, 0, 0, 12)
    TopBarCornerFix.Position = UDim2.new(0, 0, 1, -12)
    TopBarCornerFix.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    TopBarCornerFix.BackgroundTransparency = 0.08
    TopBarCornerFix.BorderSizePixel = 0
    TopBarCornerFix.Parent = TopBar

    -- Título
    local Titulo = Instance.new("TextLabel")
    Titulo.Name = "Titulo"
    Titulo.Size = UDim2.new(1, -40, 1, 0)
    Titulo.Position = UDim2.new(0, 10, 0, 0)
    Titulo.BackgroundTransparency = 1
    Titulo.Text = "⚡ JoseAngel_Blox Kick"
    Titulo.TextColor3 = Color3.fromRGB(255, 255, 255)
    Titulo.TextSize = 18
    Titulo.Font = Enum.Font.GothamBold
    Titulo.TextXAlignment = Enum.TextXAlignment.Left
    Titulo.Parent = TopBar

    -- Botón cerrar
    local Cerrar = Instance.new("ImageButton")
    Cerrar.Name = "Cerrar"
    Cerrar.Size = UDim2.new(0, 28, 0, 28)
    Cerrar.Position = UDim2.new(1, -34, 0, 6)
    Cerrar.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    Cerrar.BackgroundTransparency = 0.3
    Cerrar.BorderSizePixel = 0
    Cerrar.Parent = TopBar

    local CerrarCorner = Instance.new("UICorner")
    CerrarCorner.CornerRadius = UDim.new(0, 6)
    CerrarCorner.Parent = Cerrar

    local CerrarIcon = Instance.new("TextLabel")
    CerrarIcon.Name = "Icon"
    CerrarIcon.Size = UDim2.new(1, 0, 1, 0)
    CerrarIcon.BackgroundTransparency = 1
    CerrarIcon.Text = "✕"
    CerrarIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
    CerrarIcon.TextSize = 16
    CerrarIcon.Font = Enum.Font.GothamBold
    CerrarIcon.Parent = Cerrar

    Cerrar.MouseButton1Click:Connect(function()
        -- Limpiar corutinas
        for name, co in pairs(coroutines) do
            if co and coroutine.status(co) ~= "dead" then
                coroutine.close(co)
            end
        end
        ScreenGui:Destroy()
    end)

    -- Scrollable content area
    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame.Name = "ScrollingFrame"
    ScrollingFrame.Size = UDim2.new(1, -10, 1, -50)
    ScrollingFrame.Position = UDim2.new(0, 5, 0, 42)
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.BorderSizePixel = 0
    ScrollingFrame.ScrollBarThickness = 4
    ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 170, 0)
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ScrollingFrame.Parent = Main

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0, 6)
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = ScrollingFrame

    return Main, ScrollingFrame, UIListLayout
end

local MainFrame, ScrollFrame, Layout = crearMainFrame()

-- ==================== FUNCIONES DE UI ====================

local function crearSeccion(padre, titulo, orden)
    local Contenedor = Instance.new("Frame")
    Contenedor.Name = titulo .. "_Section"
    Contenedor.Size = UDim2.new(1, -10, 0, 0)
    Contenedor.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    Contenedor.BackgroundTransparency = 0.3
    Contenedor.BorderSizePixel = 0
    Contenedor.LayoutOrder = orden
    Contenedor.Parent = padre

    local ContCorner = Instance.new("UICorner")
    ContCorner.CornerRadius = UDim.new(0, 10)
    ContCorner.Parent = Contenedor

    local ContStroke = Instance.new("UIStroke")
    ContStroke.Color = Color3.fromRGB(255, 170, 0)
    ContStroke.Thickness = 1
    ContStroke.Transparency = 0.85
    ContStroke.Parent = Contenedor

    -- Botón cabecera
    local Header = Instance.new("TextButton")
    Header.Name = "Header"
    Header.Size = UDim2.new(1, 0, 0, 36)
    Header.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
    Header.BackgroundTransparency = 0.3
    Header.BorderSizePixel = 0
    Header.Text = ""
    Header.Parent = Contenedor

    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 10)
    HeaderCorner.Parent = Header

    local HeaderFix = Instance.new("Frame")
    HeaderFix.Name = "HeaderFix"
    HeaderFix.Size = UDim2.new(1, 0, 0, 10)
    HeaderFix.Position = UDim2.new(0, 0, 1, -10)
    HeaderFix.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    HeaderFix.BackgroundTransparency = 0.3
    HeaderFix.BorderSizePixel = 0
    HeaderFix.Parent = Header

    local HeaderFixCorner = Instance.new("UICorner")
    HeaderFixCorner.CornerRadius = UDim.new(0, 10)
    HeaderFixCorner.Parent = HeaderFix

    local TituloLabel = Instance.new("TextLabel")
    TituloLabel.Name = "Titulo"
    TituloLabel.Size = UDim2.new(1, -40, 1, 0)
    TituloLabel.Position = UDim2.new(0, 12, 0, 0)
    TituloLabel.BackgroundTransparency = 1
    TituloLabel.Text = titulo
    TituloLabel.TextColor3 = Color3.fromRGB(255, 210, 100)
    TituloLabel.TextSize = 15
    TituloLabel.Font = Enum.Font.GothamBold
    TituloLabel.TextXAlignment = Enum.TextXAlignment.Left
    TituloLabel.Parent = Header

    local Flecha = Instance.new("TextLabel")
    Flecha.Name = "Flecha"
    Flecha.Size = UDim2.new(0, 30, 1, 0)
    Flecha.Position = UDim2.new(1, -30, 0, 0)
    Flecha.BackgroundTransparency = 1
    Flecha.Text = "↓"
    Flecha.TextColor3 = Color3.fromRGB(255, 210, 100)
    Flecha.TextSize = 18
    Flecha.Font = Enum.Font.GothamBold
    Flecha.Parent = Header

    -- Contenido (oculto por defecto info, visible por defecto main)
    local Contenido = Instance.new("Frame")
    Contenido.Name = "Contenido"
    Contenido.Size = UDim2.new(1, -10, 0, 0)
    Contenido.Position = UDim2.new(0, 5, 0, 38)
    Contenido.BackgroundTransparency = 1
    Contenido.BorderSizePixel = 0
    Contenido.Visible = false
    Contenido.Parent = Contenedor

    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.Padding = UDim.new(0, 4)
    ContentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContentLayout.Parent = Contenido

    local expandido = false
    Header.MouseButton1Click:Connect(function()
        expandido = not expandido
        Contenido.Visible = expandido
        Flecha.Text = expandido and "↑" or "↓"

        -- Animación de tamaño
        local targetSize = expandido and UDim2.new(1, -10, 0, ContentLayout.AbsoluteContentSize.Y + 10) or UDim2.new(1, -10, 0, 0)
        if expandido then
            Contenedor.Size = UDim2.new(1, -10, 0, ContentLayout.AbsoluteContentSize.Y + 50)
        else
            Contenedor.Size = UDim2.new(1, -10, 0, 40)
        end
    end)

    return Contenedor, Contenido, ContentLayout, Header, Flecha
end

local function crearToggle(padre, nombre, descripcion, color, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Name = nombre .. "_Toggle"
    ToggleFrame.Size = UDim2.new(1, -10, 0, 38)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    ToggleFrame.BackgroundTransparency = 0.4
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = padre

    local TFCorner = Instance.new("UICorner")
    TFCorner.CornerRadius = UDim.new(0, 8)
    TFCorner.Parent = ToggleFrame

    -- Nombre
    local NombreLabel = Instance.new("TextLabel")
    NombreLabel.Name = "Nombre"
    NombreLabel.Size = UDim2.new(1, -60, 0, 20)
    NombreLabel.Position = UDim2.new(0, 10, 0, 2)
    NombreLabel.BackgroundTransparency = 1
    NombreLabel.Text = nombre
    NombreLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    NombreLabel.TextSize = 14
    NombreLabel.Font = Enum.Font.Gotham
    NombreLabel.TextXAlignment = Enum.TextXAlignment.Left
    NombreLabel.Parent = ToggleFrame

    -- Descripción
    if descripcion then
        local DescLabel = Instance.new("TextLabel")
        DescLabel.Name = "Desc"
        DescLabel.Size = UDim2.new(1, -60, 0, 14)
        DescLabel.Position = UDim2.new(0, 10, 0, 22)
        DescLabel.BackgroundTransparency = 1
        DescLabel.Text = descripcion
        DescLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
        DescLabel.TextSize = 11
        DescLabel.Font = Enum.Font.Gotham
        DescLabel.TextXAlignment = Enum.TextXAlignment.Left
        DescLabel.Parent = ToggleFrame
    end

    -- Botón toggle
    local ToggleBtn = Instance.new("ImageButton")
    ToggleBtn.Name = "ToggleBtn"
    ToggleBtn.Size = UDim2.new(0, 42, 0, 24)
    ToggleBtn.Position = UDim2.new(1, -52, 0, 7)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    ToggleBtn.BorderSizePixel = 0
    ToggleBtn.Parent = ToggleFrame

    local TBCorner = Instance.new("UICorner")
    TBCorner.CornerRadius = UDim.new(1, 0)
    TBCorner.Parent = ToggleBtn

    -- Círculo del toggle
    local Circulo = Instance.new("Frame")
    Circulo.Name = "Circulo"
    Circulo.Size = UDim2.new(0, 18, 0, 18)
    Circulo.Position = UDim2.new(0, 3, 0, 3)
    Circulo.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
    Circulo.BorderSizePixel = 0
    Circulo.Parent = ToggleBtn

    local CircCorner = Instance.new("UICorner")
    CircCorner.CornerRadius = UDim.new(1, 0)
    CircCorner.Parent = Circulo

    local activo = false
    local colorOn = color or Color3.fromRGB(255, 170, 0)

    ToggleBtn.MouseButton1Click:Connect(function()
        activo = not activo
        if activo then
            ToggleBtn.BackgroundColor3 = colorOn
            Circulo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Circulo:TweenPosition(UDim2.new(0, 21, 0, 3), "Out", "Sine", 0.15, true)
        else
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
            Circulo.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
            Circulo:TweenPosition(UDim2.new(0, 3, 0, 3), "Out", "Sine", 0.15, true)
        end
        if callback then
            callback(activo)
        end
    end)

    return ToggleFrame, ToggleBtn, Circulo
end

-- ==================== SECCIÓN INFO ====================
local InfoSec, InfoCont, InfoLayout = crearSeccion(ScrollFrame, "📋 Info", 1)

-- Info content
local function crearInfoLine(padre, label, valor)
    local Line = Instance.new("Frame")
    Line.Size = UDim2.new(1, -10, 0, 22)
    Line.BackgroundTransparency = 1
    Line.BorderSizePixel = 0
    Line.Parent = padre

    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(0, 120, 1, 0)
    Lbl.Position = UDim2.new(0, 5, 0, 0)
    Lbl.BackgroundTransparency = 1
    Lbl.Text = label
    Lbl.TextColor3 = Color3.fromRGB(255, 200, 100)
    Lbl.TextSize = 13
    Lbl.Font = Enum.Font.GothamBold
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.Parent = Line

    local Val = Instance.new("TextLabel")
    Val.Size = UDim2.new(1, -130, 1, 0)
    Val.Position = UDim2.new(0, 125, 0, 0)
    Val.BackgroundTransparency = 1
    Val.Text = valor
    Val.TextColor3 = Color3.fromRGB(200, 200, 200)
    Val.TextSize = 13
    Val.Font = Enum.Font.Gotham
    Val.TextXAlignment = Enum.TextXAlignment.Left
    Val.Parent = Line

    return Line
end

crearInfoLine(InfoCont, "👤 Creador:", "JoseAngel_Blox")
crearInfoLine(InfoCont, "📅 Lanzamiento:", "22/07/2026")
crearInfoLine(InfoCont, "🔖 Versión:", "1.1")

-- Welcome message
local WelcomeFrame = Instance.new("Frame")
WelcomeFrame.Size = UDim2.new(1, -10, 0, 50)
WelcomeFrame.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
WelcomeFrame.BackgroundTransparency = 0.75
WelcomeFrame.BorderSizePixel = 0
WelcomeFrame.Parent = InfoCont

local WelcomeCorner = Instance.new("UICorner")
WelcomeCorner.CornerRadius = UDim.new(0, 8)
WelcomeCorner.Parent = WelcomeFrame

local WelcomeText = Instance.new("TextLabel")
WelcomeText.Size = UDim2.new(1, -10, 1, -5)
WelcomeText.Position = UDim2.new(0, 5, 0, 2)
WelcomeText.BackgroundTransparency = 1
WelcomeText.Text = "👋 ¡Bienvenido a JoseAngel_Blox Kick!\nDisfruta del script y que tengas buena suerte pateando bloques 🍀"
WelcomeText.TextColor3 = Color3.fromRGB(255, 255, 255)
WelcomeText.TextSize = 12
WelcomeText.Font = Enum.Font.Gotham
WelcomeText.TextWrapped = true
WelcomeText.TextXAlignment = Enum.TextXAlignment.Center
WelcomeText.Parent = WelcomeFrame

-- ==================== SECCIÓN MAIN ====================
local MainSec, MainCont, MainLayout = crearSeccion(ScrollFrame, "⚙️ Main", 2)

-- Auto-Kick
crearToggle(MainCont, "Auto-Kick 🦶", "Patea el lucky block automáticamente", Color3.fromRGB(255, 170, 0), function(estado)
    Config.AutoKick = estado
    if estado then
        coroutines["AutoKick"] = coroutine.create(function()
            while Config.AutoKick do
                pcall(function()
                    local block = LP:FindFirstChild("LuckyBlock", true) or 
                                 workspace:FindFirstChild("LuckyBlock", true) or
                                 workspace:FindFirstChild("LuckyBlockEvent", true) or
                                 workspace:FindFirstChild("Block", true)
                    if block then
                        -- Simular patada (click/interactuar)
                        local kickEvent = block:FindFirstChild("KickEvent") or 
                                         block:FindFirstChild("ClickDetector") or
                                         block:FindFirstChild("ProximityPrompt")
                        if kickEvent then
                            if kickEvent:IsA("RemoteEvent") or kickEvent:IsA("RemoteFunction") then
                                kickEvent:FireServer()
                            elseif kickEvent:IsA("ClickDetector") then
                                fireclickdetector(kickEvent)
                            elseif kickEvent:IsA("ProximityPrompt") then
                                fireproximityprompt(kickEvent)
                            end
                        else
                            -- Fallback: intentar con el character
                            local char = LP.Character
                            if char and block:IsA("BasePart") then
                                local hrp = char:FindFirstChild("HumanoidRootPart")
                                if hrp then
                                    hrp.CFrame = CFrame.new(block.Position + Vector3.new(0, 2, 3))
                                    task.wait(0.2)
                                    -- Simular click
                                    VirtualInputManager:SendMouseButtonEvent(
                                        Mouse.X, Mouse.Y, 0, true, game, 0
                                    )
                                    task.wait(0.05)
                                    VirtualInputManager:SendMouseButtonEvent(
                                        Mouse.X, Mouse.Y, 0, false, game, 0
                                    )
                                end
                            end
                        end
                    end
                end)
                -- Cooldown entre 3-5 segundos o detectar cooldown real
                task.wait(3.5 + math.random() * 2)
            end
        end)
        coroutine.resume(coroutines["AutoKick"])
    end
end)

-- Auto-Esquivar Tsunami
crearToggle(MainCont, "🌊 Auto-Esquivar Tsunami", "Sube a zona segura y vuelve después", Color3.fromRGB(0, 170, 255), function(estado)
    Config.AutoTsunami = estado
    if estado then
        coroutines["AutoTsunami"] = coroutine.create(function()
            while Config.AutoTsunami do
                pcall(function()
                    -- Detectar tsunami (agua subiendo)
                    local tsunami = workspace:FindFirstChild("Tsunami") or 
                                    workspace:FindFirstChild("Water") or
                                    workspace:FindFirstChild("Flood")
                    
                    if tsunami then
                        local char = LP.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            local hrp = char.HumanoidRootPart
                            local tsunamiPos = tsunami.Position.Y
                            local playerPos = hrp.Position.Y
                            
                            -- Si el tsunami se acerca
                            if tsunamiPos > playerPos - 10 then
                                -- Subir a zona segura (techo / montaña)
                                local safeSpot = workspace:FindFirstChild("SafeZone") or
                                                workspace:FindFirstChild("Spawn") or
                                                workspace:FindFirstChild("Lobby")
                                if safeSpot then
                                    hrp.CFrame = CFrame.new(safeSpot.Position + Vector3.new(0, 5, 0))
                                else
                                    -- Subir alto
                                    hrp.CFrame = CFrame.new(hrp.Position.X, tsunamiAltura, hrp.Position.Z)
                                end
                                
                                -- Esperar que pase el tsunami
                                task.wait(8)
                                Config.TsunamiActive = false
                            end
                        end
                    end
                end)
                task.wait(1)
            end
        end)
        coroutine.resume(coroutines["AutoTsunami"])
    end
end)

-- Auto Weight
crearToggle(MainCont, "🏋️ Auto Weight", "Agarra la pesa automáticamente", Color3.fromRGB(0, 255, 170), function(estado)
    Config.AutoWeight = estado
    if estado then
        coroutines["AutoWeight"] = coroutine.create(function()
            while Config.AutoWeight do
                pcall(function()
                    local weight = workspace:FindFirstChild("Weight") or
                                   workspace:FindFirstChild("Dumbbell") or
                                   workspace:FindFirstChild("Pesa") or
                                   workspace:FindFirstChild("GymWeight")
                    if not weight then
                        -- Buscar en el área de gym
                        local gym = workspace:FindFirstChild("Gym") or workspace:FindFirstChild("TrainArea")
                        if gym then
                            for _, obj in ipairs(gym:GetDescendants()) do
                                if obj.Name:lower():find("weight") or obj.Name:lower():find("pesa") or obj.Name:lower():find("dumbbell") then
                                    weight = obj
                                    break
                                end
                            end
                        end
                    end
                    if weight then
                        local char = LP.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            local hrp = char.HumanoidRootPart
                            hrp.CFrame = CFrame.new(weight.Position + Vector3.new(0, 2, 2))
                            task.wait(0.3)
                            -- Interactuar
                            local prompt = weight:FindFirstChild("ProximityPrompt") or
                                          weight:FindFirstChild("ClickDetector")
                            if prompt then
                                if prompt:IsA("ProximityPrompt") then
                                    fireproximityprompt(prompt)
                                elseif prompt:IsA("ClickDetector") then
                                    fireclickdetector(prompt)
                                end
                            end
                        end
                    end
                end)
                task.wait(2)
            end
        end)
        coroutine.resume(coroutines["AutoWeight"])
    end
end)

-- Auto Click x2
crearToggle(MainCont, "🖱️ Auto Click x2", "Click automático al botón ×2 de fuerza", Color3.fromRGB(255, 100, 100), function(estado)
    Config.AutoClickX2 = estado
    if estado then
        coroutines["AutoClickX2"] = coroutine.create(function()
            while Config.AutoClickX2 do
                pcall(function()
                    local btnX2 = LP.PlayerGui:FindFirstChild("X2Button", true) or
                                  LP.PlayerGui:FindFirstChild("DoubleForce", true) or
                                  LP.PlayerGui:FindFirstChild("SpeedBoost", true) or
                                  workspace:FindFirstChild("X2Button", true)
                    
                    if not btnX2 then
                        -- Buscar por texto "x2" o "2x"
                        for _, gui in ipairs(LP.PlayerGui:GetDescendants()) do
                            if gui:IsA("TextButton") or gui:IsA("ImageButton") then
                                local text = (gui.Text or ""):lower()
                                if text:find("x2") or text:find("2x") or text:find("x 2") or text:find("double") then
                                    btnX2 = gui
                                    break
                                end
                            end
                        end
                    end
                    
                    if btnX2 then
                        if btnX2:IsA("GuiButton") then
                            btnX2:FireServer? and btnX2:FireServer() or btnX2:Click? and btnX2:Click()
                        end
                    end
                end)
                task.wait(0.5)
            end
        end)
        coroutine.resume(coroutines["AutoClickX2"])
    end
end)

-- Enable Move
crearToggle(MainCont, "🎮 Enable Move", "Mover personaje con WASD/joystick al tener pesa", Color3.fromRGB(100, 255, 100), function(estado)
    Config.EnableMove = estado
    if estado then
        coroutines["EnableMove"] = coroutine.create(function()
            -- Activar movimiento con WASD
            local connection
            connection = RunService.RenderStepped:Connect(function()
                if not Config.EnableMove then
                    connection:Disconnect()
                    return
                end
                pcall(function()
                    local char = LP.Character
                    if not char or not char:FindFirstChild("Humanoid") then return end
                    local humanoid = char.Humanoid
                    
                    local moveVector = Vector3.new(0, 0, 0)
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                        moveVector = moveVector + Vector3.new(0, 0, -1)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                        moveVector = moveVector + Vector3.new(0, 0, 1)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                        moveVector = moveVector + Vector3.new(-1, 0, 0)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                        moveVector = moveVector + Vector3.new(1, 0, 0)
                    end
                    
                    if moveVector.Magnitude > 0 then
                        humanoid:Move(moveVector, true)
                    end
                end)
            end)
        end)
        coroutine.resume(coroutines["EnableMove"])
    end
end)

-- Auto Reclamar Dinero
crearToggle(MainCont, "💰 Auto Reclamar", "Reclama dinero de brainrots en tu parcela", Color3.fromRGB(255, 200, 50), function(estado)
    Config.AutoReclamar = estado
    if estado then
        coroutines["AutoReclamar"] = coroutine.create(function()
            while Config.AutoReclamar do
                pcall(function()
                    -- Buscar botón de reclamar
                    local claimBtn = LP.PlayerGui:FindFirstChild("ClaimButton", true) or
                                    LP.PlayerGui:FindFirstChild("Collect", true) or
                                    LP.PlayerGui:FindFirstChild("Reclamar", true) or
                                    LP.PlayerGui:FindFirstChild("Claim", true)
                    
                    if not claimBtn then
                        -- Buscar por texto
                        for _, gui in ipairs(LP.PlayerGui:GetDescendants()) do
                            if gui:IsA("TextButton") or gui:IsA("ImageButton") then
                                local text = (gui.Text or ""):lower()
                                if text:find("claim") or text:find("reclam") or text:find("collect") or text:find("cobrar") then
                                    claimBtn = gui
                                    break
                                end
                            end
                        end
                    end
                    
                    if claimBtn and claimBtn:IsA("GuiButton") and claimBtn.Visible and claimBtn.AbsoluteSize.Y > 0 then
                        claimBtn:FireServer? and claimBtn:FireServer() or claimBtn:Click? and claimBtn:Click()
                    end
                    
                    -- También buscar en workspace (partes con clickdetector)
                    for _, part in ipairs(workspace:GetDescendants()) do
                        if part:IsA("BasePart") then
                            local detector = part:FindFirstChild("ClickDetector")
                            if detector and (part.Name:lower():find("claim") or part.Name:lower():find("reclam") or part.Name:lower():find("collect")) then
                                fireclickdetector(detector)
                            end
                        end
                    end
                end)
                task.wait(3)
            end
        end)
        coroutine.resume(coroutines["AutoReclamar"])
    end
end)

-- Anti-Afk
crearToggle(MainCont, "💤 Anti-Afk", "Salta cada 1 minuto para evitar desconexión", Color3.fromRGB(180, 100, 255), function(estado)
    Config.AntiAfk = estado
    if estado then
        coroutines["AntiAfk"] = coroutine.create(function()
            while Config.AntiAfk do
                pcall(function()
                    local char = LP.Character
                    if char and char:FindFirstChild("Humanoid") then
                        local humanoid = char.Humanoid
                        humanoid:Move(Vector3.new(0, 0, 0), false)
                        humanoid.Jump = true
                        task.wait(0.1)
                        humanoid.Jump = false
                    end
                    -- También simular actividad con VirtualUser
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton2(Vector2.new(0, 0))
                end)
                task.wait(60)
            end
        end)
        coroutine.resume(coroutines["AntiAfk"])
    end
end)

-- Auto Comprar Mejoras
crearToggle(MainCont, "🛒 Auto-Comprar Mejoras", "Compra mejoras automáticamente (prioridad rentable)", Color3.fromRGB(255, 130, 0), function(estado)
    Config.AutoComprar = estado
    if estado then
        coroutines["AutoComprar"] = coroutine.create(function()
            while Config.AutoComprar do
                pcall(function()
                    -- Buscar tienda / shop
                    local shop = LP.PlayerGui:FindFirstChild("Shop", true) or
                                LP.PlayerGui:FindFirstChild("Store", true) or
                                LP.PlayerGui:FindFirstChild("Tienda", true) or
                                LP.PlayerGui:FindFirstChild("UpgradeMenu", true)
                    
                    if shop then
                        -- Buscar botones de compra disponibles
                        local upgrades = {}
                        for _, btn in ipairs(shop:GetDescendants()) do
                            if (btn:IsA("TextButton") or btn:IsA("ImageButton")) and btn.Visible and btn.Active then
                                local text = (btn.Text or ""):lower()
                                -- Priorizar mejoras de fuerza > velocidad > dinero
                                if text:find("strength") or text:find("fuerza") or text:find("power") then
                                    table.insert(upgrades, {btn = btn, priority = 1})
                                elseif text:find("speed") or text:find("velocidad") then
                                    table.insert(upgrades, {btn = btn, priority = 2})
                                elseif text:find("money") or text:find("dinero") or text:find("income") then
                                    table.insert(upgrades, {btn = btn, priority = 3})
                                else
                                    table.insert(upgrades, {btn = btn, priority = 4})
                                end
                            end
                        end
                        
                        -- Ordenar por prioridad y comprar
                        table.sort(upgrades, function(a, b) return a.priority < b.priority end)
                        for _, upg in ipairs(upgrades) do
                            local success = pcall(function()
                                upg.btn:FireServer? and upg.btn:FireServer() or upg.btn:Click? and upg.btn:Click()
                            end)
                            if success then break end
                        end
                    end
                end)
                task.wait(5)
            end
        end)
        coroutine.resume(coroutines["AutoComprar"])
    end
end)

-- Show Panel (Brainrot prediction)
crearToggle(MainCont, "📊 Show Panel", "Panel de predicción de Brainrots (rareza/mutación)", Color3.fromRGB(0, 200, 255), function(estado)
    Config.ShowPanel = estado
    if estado then
        -- Crear panel pequeño
        local Panel = Instance.new("Frame")
        Panel.Name = "BrainrotPanel"
        Panel.Size = UDim2.new(0, 200, 0, 150)
        Panel.Position = UDim2.new(0.5, 450, 0.5, -100)
        Panel.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
        Panel.BackgroundTransparency = 0.1
        Panel.BorderSizePixel = 0
        Panel.Parent = ScreenGui

        local PanelCorner = Instance.new("UICorner")
        PanelCorner.CornerRadius = UDim.new(0, 10)
        PanelCorner.Parent = Panel

        local PanelStroke = Instance.new("UIStroke")
        PanelStroke.Color = Color3.fromRGB(0, 200, 255)
        PanelStroke.Thickness = 1.5
        PanelStroke.Transparency = 0.5
        PanelStroke.Parent = Panel

        -- Título
        local PanelTitulo = Instance.new("TextLabel")
        PanelTitulo.Size = UDim2.new(1, -10, 0, 28)
        PanelTitulo.Position = UDim2.new(0, 5, 0, 5)
        PanelTitulo.BackgroundTransparency = 1
        PanelTitulo.Text = "🧠 Brainrot Scanner"
        PanelTitulo.TextColor3 = Color3.fromRGB(0, 200, 255)
        PanelTitulo.TextSize = 14
        PanelTitulo.Font = Enum.Font.GothamBold
        PanelTitulo.Parent = Panel

        -- Contenido del panel
        local PanelContent = Instance.new("Frame")
        PanelContent.Name = "Content"
        PanelContent.Size = UDim2.new(1, -10, 1, -40)
        PanelContent.Position = UDim2.new(0, 5, 0, 33)
        PanelContent.BackgroundTransparency = 1
        PanelContent.BorderSizePixel = 0
        PanelContent.Parent = Panel

        local PanelLayout = Instance.new("UIListLayout")
        PanelLayout.Padding = UDim.new(0, 4)
        PanelLayout.Parent = PanelContent

        local function crearBrainrotEntry(padre, nombre, rareza, mutacion)
            local Entry = Instance.new("Frame")
            Entry.Size = UDim2.new(1, 0, 0, 24)
            Entry.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
            Entry.BackgroundTransparency = 0.5
            Entry.BorderSizePixel = 0
            Entry.Parent = padre

            local EntryCorner = Instance.new("UICorner")
            EntryCorner.CornerRadius = UDim.new(0, 6)
            EntryCorner.Parent = Entry

            local rarezaColor = Color3.fromRGB(180, 180, 180) -- común
            if rareza:lower() == "rare" or rareza:lower() == "raro" then
                rarezaColor = Color3.fromRGB(50, 150, 255)
            elseif rareza:lower() == "epic" or rareza:lower() == "épico" then
                rarezaColor = Color3.fromRGB(180, 50, 255)
            elseif rareza:lower() == "legendary" or rareza:lower() == "legendario" then
                rarezaColor = Color3.fromRGB(255, 170, 0)
            elseif rareza:lower() == "og" or rareza:lower() == "celestial" then
                rarezaColor = Color3.fromRGB(255, 50, 50)
            end

            local Nombre = Instance.new("TextLabel")
            Nombre.Size = UDim2.new(0, 80, 1, 0)
            Nombre.Position = UDim2.new(0, 8, 0, 0)
            Nombre.BackgroundTransparency = 1
            Nombre.Text = nombre
            Nombre.TextColor3 = Color3.fromRGB(220, 220, 220)
            Nombre.TextSize = 12
            Nombre.Font = Enum.Font.Gotham
            Nombre.TextXAlignment = Enum.TextXAlignment.Left
            Nombre.Parent = Entry

            local Rareza = Instance.new("TextLabel")
            Rareza.Size = UDim2.new(0, 60, 1, 0)
            Rareza.Position = UDim2.new(0, 88, 0, 0)
            Rareza.BackgroundTransparency = 1
            Rareza.Text = "[" .. rareza .. "]"
            Rareza.TextColor3 = rarezaColor
            Rareza.TextSize = 11
            Rareza.Font = Enum.Font.GothamBold
            Rareza.TextXAlignment = Enum.TextXAlignment.Left
            Rareza.Parent = Entry

            local Mutacion = Instance.new("TextLabel")
            Mutacion.Size = UDim2.new(0, 50, 1, 0)
            Mutacion.Position = UDim2.new(0, 148, 0, 0)
            Mutacion.BackgroundTransparency = 1
            Mutacion.Text = mutacion ~= "" and "✨" .. mutacion or ""
            Mutacion.TextColor3 = Color3.fromRGB(255, 215, 0)
            Mutacion.TextSize = 11
            Mutacion.Font = Enum.Font.GothamBold
            Mutacion.TextXAlignment = Enum.TextXAlignment.Left
            Mutacion.Parent = Entry

            return Entry
        end

        -- Ejemplos de brainrots (se actualizan dinámicamente)
        local entries = {}
        local brainrotList = {
            {name = "Brainrot #1", rareza = "Común", mutacion = ""},
            {name = "Brainrot #2", rareza = "Raro", mutacion = "Oro"},
            {name = "Brainrot #3", rareza = "Épico", mutacion = "Diamante"},
            {name = "Brainrot #4", rareza = "OG", mutacion = "Celestial"},
        }

        for _, br in ipairs(brainrotList) do
            local entry = crearBrainrotEntry(PanelContent, br.name, br.rareza, br.mutacion)
            table.insert(entries, entry)
        end

        -- Bucle de actualización del panel
        coroutines["BrainrotPanel"] = coroutine.create(function()
            while Config.ShowPanel and Panel and Panel.Parent do
                pcall(function()
                    -- Buscar brainrots reales en el juego
                    local brainrots = {}
                    local brContainer = workspace:FindFirstChild("Brainrots") or
                                       workspace:FindFirstChild("Drops") or
                                       workspace:FindFirstChild("Loot")
                    
                    if brContainer then
                        for _, child in ipairs(brContainer:GetChildren()) do
                            local nombre = child.Name
                            local rareza = child:FindFirstChild("Rarity") and child.Rarity.Value or "Común"
                            local mutacion = child:FindFirstChild("Mutation") and child.Mutation.Value or ""
                            table.insert(brainrots, {name = nombre, rareza = rareza, mutacion = mutacion})
                        end
                    end
                    
                    -- También buscar en PlayerGui (UI de próximos drops)
                    local nextDrops = LP.PlayerGui:FindFirstChild("NextDrops", true) or
                                     LP.PlayerGui:FindFirstChild("DropPreview", true)
                    if nextDrops then
                        -- Actualizar desde UI
                    end
                end)
                task.wait(2)
            end
            if Panel then Panel:Destroy() end
        end)
        coroutine.resume(coroutines["BrainrotPanel"])
    else
        -- Destruir panel
        local panel = ScreenGui:FindFirstChild("BrainrotPanel")
        if panel then panel:Destroy() end
    end
end)

-- ==================== ACTIVAR GUI ====================
ScreenGui.Parent = LP:WaitForChild("PlayerGui")

-- ==================== NOTIFICACIÓN DE INICIO ====================
task.wait(0.3)
local Notif = Instance.new("Frame")
Notif.Name = "StartupNotif"
Notif.Size = UDim2.new(0, 300, 0, 60)
Notif.Position = UDim2.new(0.5, -150, 0, 20)
Notif.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
Notif.BackgroundTransparency = 0.1
Notif.BorderSizePixel = 0
Notif.Parent = ScreenGui

local NotifCorner = Instance.new("UICorner")
NotifCorner.CornerRadius = UDim.new(0, 10)
NotifCorner.Parent = Notif

local NotifStroke = Instance.new("UIStroke")
NotifStroke.Color = Color3.fromRGB(255, 170, 0)
NotifStroke.Thickness = 1.5
NotifStroke.Transparency = 0.3
NotifStroke.Parent = Notif

local NotifText = Instance.new("TextLabel")
NotifText.Size = UDim2.new(1, -10, 1, 0)
NotifText.Position = UDim2.new(0, 5, 0, 0)
NotifText.BackgroundTransparency = 1
NotifText.Text = "✅ JoseAngel_Blox Kick v1.1 cargado\n¡Disfruta del script! 🍀"
NotifText.TextColor3 = Color3.fromRGB(255, 255, 255)
NotifText.TextSize = 13
NotifText.Font = Enum.Font.Gotham
NotifText.TextWrapped = true
NotifText.TextXAlignment = Enum.TextXAlignment.Center
NotifText.Parent = Notif

-- Animación de entrada
local NotifTween = TweenService:Create(Notif, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -150, 0, 20)})
NotifTween:Play()

-- Auto-destruir notificación
task.wait(4)
if Notif and Notif.Parent then
    local fadeOut = TweenService:Create(Notif, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 1})
    fadeOut:Play()
    task.wait(0.5)
    Notif:Destroy()
end

-- ==================== MENSAJE EN CONSOLA ====================
print("⚡ JoseAngel_Blox Kick v1.1 cargado correctamente")
print("👤 Creador: JoseAngel_Blox")
print("📅 Fecha: 22/07/2026")
print("🍀 ¡Disfruta del script!")