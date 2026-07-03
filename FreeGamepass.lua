--[[
██████╗ ███████╗███████╗███████╗    ██████╗  ██████╗ ████████╗
██╔══██╗██╔════╝██╔════╝██╔════╝    ██╔══██╗██╔═══██╗╚══██╔══╝
██║  ██║█████╗  ███████╗█████╗      ██████╔╝██║   ██║   ██║   
██║  ██║██╔══╝  ╚════██║██╔══╝      ██╔══██╗██║   ██║   ██║   
██║╚██████╔╝███████║███████║███████╗    ██████╔╝╚██████╔╝   ██║   
╚═╝ ╚═════╝ ╚══════╝╚══════╝╚══════╝    ╚═════╝  ╚═════╝    ╚═╝   
Free Gamepass JoseAngel_Blox PRO
Versión: 1.1 | Fecha: 02/07/2026
Creado por: JoseAngel_Blox
⚠️ ESTE SCRIPT ES DE CREACIÓN PROPIA
]]--

-- SERVICIOS
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")

-- VARIABLES LOCALES
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local Mouse = LocalPlayer:GetMouse()

-- ==============================================
-- 🎨 CREACIÓN DE LA INTERFAZ (HECHA POR TI)
-- ==============================================

-- Pantalla Principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngelBloxUI"
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Ventana Principal
local MainWindow = Instance.new("Frame")
MainWindow.Name = "MainWindow"
MainWindow.Parent = ScreenGui
MainWindow.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainWindow.Size = UDim2.new(0, 400, 0, 450)
MainWindow.Position = UDim2.new(0.5, -200, 0.5, -225)
MainWindow.ClipsDescendants = true

-- Esquinas Redondeadas
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainWindow

-- Barra Superior Azul
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = MainWindow
TopBar.BackgroundColor3 = Color3.fromRGB(30, 120, 255) -- COLOR AZUL
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.Position = UDim2.new(0,0,0,0)
local TopCorner = UICorner:Clone()
TopCorner.Parent = TopBar

-- Título
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, -10, 1, 0)
Title.Position = UDim2.new(0, 5, 0, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Free Gamepass JoseAngel_Blox PRO"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Contenedor de Pestañas
local Container = Instance.new("Frame")
Container.Name = "Container"
Container.Parent = MainWindow
Container.BackgroundTransparency = 1
Container.Size = UDim2.new(1, -20, 1, -60)
Container.Position = UDim2.new(0, 10, 0, 50)

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = Container
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)

-- ==============================================
-- 📄 FUNCIÓN PARA CREAR BOTONES Y SECCIONES
-- ==============================================

local function CrearSeccion(nombre)
    local Section = Instance.new("TextLabel")
    Section.Name = "Section"
    Section.Parent = Container
    Section.BackgroundTransparency = 1
    Section.Size = UDim2.new(1, 0, 0, 20)
    Section.Font = Enum.Font.GothamBold
    Section.Text = "📂 "..nombre:upper()
    Section.TextColor3 = Color3.fromRGB(30, 120, 255)
    Section.TextSize = 14
    Section.TextXAlignment = Enum.TextXAlignment.Left
end

local function CrearBoton(nombre, callback)
    local Btn = Instance.new("TextButton")
    Btn.Name = "Button"
    Btn.Parent = Container
    Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    Btn.Size = UDim2.new(1, 0, 0, 35)
    Btn.Font = Enum.Font.Gotham
    Btn.Text = nombre
    Btn.TextColor3 = Color3.fromRGB(255,255,255)
    Btn.TextSize = 14
    
    local BtnCorner = UICorner:Clone()
    BtnCorner.Parent = Btn
    
    Btn.MouseButton1Click:Connect(callback)
end

local function CrearToggle(nombre, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Name = "Toggle"
    ToggleFrame.Parent = Container
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
    
    local TCorner = UICorner:Clone()
    TCorner.Parent = ToggleFrame
    
    local Label = Instance.new("TextLabel")
    Label.Parent = ToggleFrame
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1, -50, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Font = Enum.Font.Gotham
    Label.Text = nombre
    Label.TextColor3 = Color3.fromRGB(255,255,255)
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    
    local Box = Instance.new("TextButton")
    Box.Parent = ToggleFrame
    Box.BackgroundColor3 = Color3.fromRGB(50,50,60)
    Box.Size = UDim2.new(0, 30, 0, 30)
    Box.Position = UDim2.new(1, -40, 0, 2.5)
    local BoxCorner = UICorner:Clone()
    BoxCorner.Parent = Box
    
    local Enabled = false
    
    local function Update()
        if Enabled then
            Box.BackgroundColor3 = Color3.fromRGB(30, 120, 255)
        else
            Box.BackgroundColor3 = Color3.fromRGB(50,50,60)
        end
        callback(Enabled)
    end
    
    Box.MouseButton1Click:Connect(function()
        Enabled = not Enabled
        Update()
    end)
end

-- ==============================================
-- 📄 PESTAÑA: INFO
-- ==============================================

CrearSeccion("DATOS DEL SCRIPT")
CrearBoton("Creador: JoseAngel_Blox", function() end)
CrearBoton("Fecha: 02/07/2026", function() end)
CrearBoton("Versión: 1.1", function() end)

CrearSeccion("MENSAJE")
local Mensaje = Instance.new("TextLabel")
Mensaje.Parent = Container
Mensaje.BackgroundTransparency = 1
Mensaje.Size = UDim2.new(1, 0, 0, 60)
Mensaje.Font = Enum.Font.Gotham
Mensaje.Text = "¡Hola! Bienvenido a tu script.\nGracias por usar Free Gamepass PRO.\nEspero que te sirva mucho.\n\nAtt: JoseAngel_Blox"
Mensaje.TextColor3 = Color3.fromRGB(200,200,200)
Mensaje.TextSize = 12
Mensaje.TextWrapped = true

-- ==============================================
-- 🛒 PESTAÑA: FREE SHOP
-- ==============================================

CrearSeccion("🎫 GAMEPASSES")

CrearToggle("VIP Premium", function(Value)
    if Value then
        pcall(function()
            LocalPlayer.Data.HasVIP.Value = true
            LocalPlayer.Data.HasPremium.Value = true
            LocalPlayer.Data.IsDonator.Value = true
            LocalPlayer.Data.OwnsAllGamepasses.Value = true
        end)
    end
end)

CrearToggle("Desbloquear Todo", function(Value)
    if Value then
        pcall(function()
            LocalPlayer.Data.UnlockedHouses.Value = "All"
            LocalPlayer.Data.UnlockedVehicles.Value = "All"
            LocalPlayer.Data.HasAccess.Value = true
        end)
    end
end)

CrearSeccion("👕 ROPA Y ACCESORIOS")

CrearToggle("Ropa y Accesorios VIP", function(Value)
    if Value then
        pcall(function()
            LocalPlayer.Data.MaxAccessories.Value = 999
            LocalPlayer.Data.CanWearVIPClothes.Value = true
        end)
    end
end)

CrearToggle("✨ Efectos Especiales", function(Value)
    if Value then
        pcall(function()
            LocalPlayer.Data.ShowEffects.Value = true
            LocalPlayer.Data.EffectsEnabled.Value = true
        end)
    end
end)

CrearSeccion("🎨 COLORES RGB")

CrearToggle("Nombre RGB", function(Value)
    if Value then
        spawn(function()
            while Value and wait(0.1) do
                pcall(function()
                    LocalPlayer.PlayerGui.MainUI.NameTag.TextColor3 = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))
                end)
            end
        end)
    end
end)

-- ==============================================
-- 🎮 PESTAÑA: PLAYER
-- ==============================================

CrearSeccion("🚀 MOVIMIENTO")

-- FLY
local FlyEnabled = false
CrearToggle("Fly (Volar)", function(Value)
    FlyEnabled = Value
    if Value then
        LocalPlayer.Character.Humanoid.PlatformStand = true
        LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    else
        LocalPlayer.Character.Humanoid.PlatformStand = false
        LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
    end
end)

-- Loop Fly
spawn(function()
    while wait() do
        if FlyEnabled and LocalPlayer.Character then
            local HRP = LocalPlayer.Character.HumanoidRootPart
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                HRP.Velocity = HRP.CFrame.LookVector * 50
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                HRP.Velocity = Vector3.new(0,50,0)
            end
        end
    end
end)

-- NOCLIP
local NoclipEnabled = false
CrearToggle("Noclip (Atravesar)", function(Value)
    NoclipEnabled = Value
end)

RunService.Heartbeat:Connect(function()
    if NoclipEnabled and LocalPlayer.Character then
        for _,v in pairs(LocalPlayer.Character:GetChildren()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end)

-- TP A CAJAS
CrearSeccion("🔐 TP A CAJAS FUERTES")

for _, Plr in pairs(Players:GetPlayers()) do
    if Plr ~= LocalPlayer then
        CrearBoton("Ir a caja de: "..Plr.Name, function()
            pcall(function()
                for _, Obj in pairs(workspace:GetDescendants()) do
                    if Obj:IsA("Part") and (string.find(string.lower(Obj.Name), "safe") or string.find(string.lower(Obj.Name), "vault")) then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = Obj.CFrame + Vector3.new(0,3,0)
                        break
                    end
                end
            end)
        end)
    end
end

-- HACER VENTANA ARRASTRABLE
local Dragging = nil
local DragStart = nil
local StartPos = nil

MainWindow.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = true
        DragStart = input.Position
        StartPos = MainWindow.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local Delta = input.Position - DragStart
        MainWindow.Position = UDim2.new(
            StartPos.X.Scale,
            StartPos.X.Offset + Delta.X,
            StartPos.Y.Scale,
            StartPos.Y.Offset + Delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = false
    end
end)

-- ==============================================
-- ✅ FINALIZAR
-- ==============================================

print("====================================")
print("Script creado por: JoseAngel_Blox")
print("Versión: 1.1 | Fecha: 02/07/2026")
print("✅ Interfaz creada desde cero")
print("✅ Sin cargar librerías ajenas")
print("====================================")
