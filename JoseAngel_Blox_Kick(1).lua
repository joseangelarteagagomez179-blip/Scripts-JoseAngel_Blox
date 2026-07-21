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
local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()

-- ==================== VARIABLES GLOBALES ====================
local coroutines = {}
local tsunamiAltura = 50

-- ==================== UI BASE ====================
local function crearMainFrame()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "JoseAngel_Blox_Kick"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Manejo de duplicados
    local old = game.CoreGui:FindFirstChild("JoseAngel_Blox_Kick")
    if old then old:Destroy() end
    ScreenGui.Parent = game.CoreGui

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

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 12)
    MainCorner.Parent = Main

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Color3.fromRGB(255, 170, 0)
    MainStroke.Thickness = 2
    MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    MainStroke.Parent = Main

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

    local Cerrar = Instance.new("TextButton")
    Cerrar.Name = "Cerrar"
    Cerrar.Size = UDim2.new(0, 28, 0, 28)
    Cerrar.Position = UDim2.new(1, -34, 0, 6)
    Cerrar.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    Cerrar.Text = "✕"
    Cerrar.TextColor3 = Color3.fromRGB(255, 255, 255)
    Cerrar.Font = Enum.Font.GothamBold
    Cerrar.Parent = TopBar

    local CerrarCorner = Instance.new("UICorner")
    CerrarCorner.CornerRadius = UDim.new(0, 6)
    CerrarCorner.Parent = Cerrar

    Cerrar.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    local ScrollingFrame = Instance.new("ScrollingFrame")
    ScrollingFrame.Name = "ScrollingFrame"
    ScrollingFrame.Size = UDim2.new(1, -10, 1, -50)
    ScrollingFrame.Position = UDim2.new(0, 5, 0, 42)
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.BorderSizePixel = 0
    ScrollingFrame.ScrollBarThickness = 4
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ScrollingFrame.Parent = Main

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0, 6)
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.Parent = ScrollingFrame

    return Main, ScrollingFrame
end

local MainFrame, ScrollFrame = crearMainFrame()

-- ==================== FUNCIONES DE UI ====================
local function crearSeccion(padre, titulo, orden)
    local Contenedor = Instance.new("Frame")
    Contenedor.Size = UDim2.new(1, -10, 0, 40)
    Contenedor.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    Contenedor.Parent = padre
    Contenedor.ClipsDescendants = true

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = Contenedor

    local Header = Instance.new("TextButton")
    Header.Size = UDim2.new(1, 0, 0, 40)
    Header.BackgroundTransparency = 1
    Header.Text = "  " .. titulo
    Header.TextColor3 = Color3.fromRGB(255, 210, 100)
    Header.TextSize = 16
    Header.Font = Enum.Font.GothamBold
    Header.TextXAlignment = Enum.TextXAlignment.Left
    Header.Parent = Contenedor

    local Flecha = Instance.new("TextLabel")
    Flecha.Size = UDim2.new(0, 30, 1, 0)
    Flecha.Position = UDim2.new(1, -30, 0, 0)
    Flecha.BackgroundTransparency = 1
    Flecha.Text = "↓"
    Flecha.TextColor3 = Color3.fromRGB(255, 210, 100)
    Flecha.TextSize = 18
    Flecha.Parent = Header

    local Contenido = Instance.new("Frame")
    Contenido.Size = UDim2.new(1, 0, 0, 0)
    Contenido.Position = UDim2.new(0, 0, 0, 40)
    Contenido.BackgroundTransparency = 1
    Contenido.AutomaticSize = Enum.AutomaticSize.Y
    Contenido.Visible = false
    Contenido.Parent = Contenedor

    local List = Instance.new("UIListLayout")
    List.Padding = UDim.new(0, 5)
    List.Parent = Contenido

    local expandido = false
    Header.MouseButton1Click:Connect(function()
        expandido = not expandido
        Contenido.Visible = expandido
        Flecha.Text = expandido and "↑" or "↓"
        Contenedor.Size = expandido and UDim2.new(1, -10, 0, 40 + Contenido.AbsoluteSize.Y) or UDim2.new(1, -10, 0, 40)
    end)
    
    Contenido.Changed:Connect(function()
        if expandido then
            Contenedor.Size = UDim2.new(1, -10, 0, 40 + Contenido.AbsoluteSize.Y)
        end
    end)

    return Contenido
end

local function crearToggle(padre, nombre, descripcion, color, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -10, 0, 40)
    Frame.BackgroundTransparency = 1
    Frame.Parent = padre

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = nombre
    Label.TextColor3 = Color3.fromRGB(220, 220, 220)
    Label.TextSize = 14
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame

    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0, 40, 0, 20)
    Btn.Position = UDim2.new(1, -50, 0.5, -10)
    Btn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    Btn.Text = ""
    Btn.Parent = Frame

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = Btn

    local Dot = Instance.new("Frame")
    Dot.Size = UDim2.new(0, 16, 0, 16)
    Dot.Position = UDim2.new(0, 2, 0, 2)
    Dot.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
    Dot.Parent = Btn

    local DotCorner = Instance.new("UICorner")
    DotCorner.CornerRadius = UDim.new(1, 0)
    DotCorner.Parent = Dot

    local activo = false
    Btn.MouseButton1Click:Connect(function()
        activo = not activo
        Btn.BackgroundColor3 = activo and (color or Color3.fromRGB(255, 170, 0)) or Color3.fromRGB(60, 60, 70)
        Dot:TweenPosition(activo and UDim2.new(0, 22, 0, 2) or UDim2.new(0, 2, 0, 2), "Out", "Sine", 0.1)
        callback(activo)
    end)
end

-- ==================== SECCIONES ====================
local InfoCont = crearSeccion(ScrollFrame, "📋 Info")
local MainCont = crearSeccion(ScrollFrame, "⚙️ Main")

-- Info
local l1 = Instance.new("TextLabel")
l1.Size = UDim2.new(1, 0, 0, 20)
l1.BackgroundTransparency = 1
l1.Text = "Creador: JoseAngel_Blox"
l1.TextColor3 = Color3.fromRGB(200, 200, 200)
l1.Parent = InfoCont

local l2 = Instance.new("TextLabel")
l2.Size = UDim2.new(1, 0, 0, 40)
l2.BackgroundTransparency = 1
l2.Text = "¡Bienvenido! Disfruta del script v1.1"
l2.TextColor3 = Color3.fromRGB(255, 255, 255)
l2.TextWrapped = true
l2.Parent = InfoCont

-- ==================== FUNCIONALIDADES ====================

-- Auto Kick
crearToggle(MainCont, "🦶 Auto-Kick", nil, Color3.fromRGB(255, 100, 0), function(estado)
    Config.AutoKick = estado
    task.spawn(function()
        while Config.AutoKick do
            pcall(function()
                local char = LP.Character
                local block = workspace:FindFirstChild("LuckyBlock") or workspace:FindFirstChild("MainBlock")
                if block and char and char:FindFirstChild("HumanoidRootPart") then
                    if (char.HumanoidRootPart.Position - block.Position).Magnitude < 15 then
                        -- Simular patada (esto depende del juego, usualmente es un Remote)
                        local remote = game:GetService("ReplicatedStorage"):FindFirstChild("KickRemote") or 
                                       game:GetService("ReplicatedStorage"):FindFirstChild("Events"):FindFirstChild("Kick")
                        if remote then remote:FireServer() end
                    end
                end
            end)
            task.wait(1)
        end
    end)
end)

-- Auto Tsunami
crearToggle(MainCont, "🌊 Auto-Esquivar Tsunami", nil, Color3.fromRGB(0, 150, 255), function(estado)
    Config.AutoTsunami = estado
    task.spawn(function()
        while Config.AutoTsunami do
            pcall(function()
                local tsunami = workspace:FindFirstChild("Tsunami")
                if tsunami and tsunami.Position.Y > (LP.Character.HumanoidRootPart.Position.Y - 5) then
                    LP.Character.HumanoidRootPart.CFrame = CFrame.new(LP.Character.HumanoidRootPart.Position.X, 100, LP.Character.HumanoidRootPart.Position.Z)
                    task.wait(5)
                end
            end)
            task.wait(0.5)
        end
    end)
end)

-- Auto Weight
crearToggle(MainCont, "🏋️ Auto Weight", nil, Color3.fromRGB(50, 255, 100), function(estado)
    Config.AutoWeight = estado
    task.spawn(function()
        while Config.AutoWeight do
            pcall(function()
                local weight = LP.Backpack:FindFirstChild("Weight") or LP.Character:FindFirstChild("Weight")
                if weight then
                    LP.Character.Humanoid:EquipTool(weight)
                    weight:Activate()
                end
            end)
            task.wait(0.2)
        end
    end)
end)

-- Anti-Afk
crearToggle(MainCont, "💤 Anti-Afk", nil, Color3.fromRGB(200, 200, 200), function(estado)
    Config.AntiAfk = estado
    if estado then
        LP.Idled:Connect(function()
            if Config.AntiAfk then
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new(0,0))
            end
        end)
    end
end)

print("Script JoseAngel_Blox Kick cargado.")
