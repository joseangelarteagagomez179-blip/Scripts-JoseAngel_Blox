-- || SCRIPT CREADO PARA TI - MANSION TYCOON v1.0 ||
-- || Creador: JoseAngel_Blox || Fecha: 30/06/2026 ||
-- || Diseño: Cuadrado ancho, esquinas redondeadas, fondo animado ||

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Crear la pantalla principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MansionTycoonScript"
ScreenGui.Parent = game.CoreGui

-- == MARCO PRINCIPAL ==
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundTransparency = 0
MainFrame.Size = UDim2.new(0, 450, 0, 480) -- Más espacio para el nuevo botón
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -240)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.ClipsDescendants = true

-- == ESQUINAS REDONDEADAS ==
local UICorner = Instance.new("UICorner")
UICorner.Parent = MainFrame
UICorner.CornerRadius = UDim.new(0, 18)

-- == FONDO CON RAYOS EN MOVIMIENTO ==
local Background = Instance.new("ImageLabel")
Background.Parent = MainFrame
Background.Size = UDim2.new(1, 0, 1, 0)
Background.Position = UDim2.new(0, 0, 0, 0)
Background.Image = "rbxassetid://10589436247"
Background.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Background.ScaleType = Enum.ScaleType.Crop
Background.ZIndex = 0

-- == EFECTO DE MOVIMIENTO ==
spawn(function()
    while wait(0.01) do
        Background.Position = UDim2.new(0, math.sin(os.clock()*0.3)*10, 0, math.cos(os.clock()*0.2)*10)
    end
end)

-- == TÍTULO ==
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 10)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Text = "🏠 MANSION TYCOON v1.0 🏠"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 22

-- ==============================================
-- 🔽 BOTÓN INFO
-- ==============================================
local InfoButton = Instance.new("TextButton")
InfoButton.Parent = MainFrame
InfoButton.Size = UDim2.new(0, 100, 0, 30)
InfoButton.Position = UDim2.new(0, 10, 0, 55)
InfoButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
InfoButton.Text = "info ↓"
InfoButton.TextColor3 = Color3.new(1,1,1)
InfoButton.Font = Enum.Font.GothamBold
InfoButton.TextSize = 14

local InfoCorner = Instance.new("UICorner")
InfoCorner.Parent = InfoButton
InfoCorner.CornerRadius = UDim.new(0, 8)

-- == CAJA DE INFORMACIÓN ==
local InfoFrame = Instance.new("Frame")
InfoFrame.Parent = MainFrame
InfoFrame.Size = UDim2.new(0, 200, 0, 80)
InfoFrame.Position = UDim2.new(0, 10, 0, 90)
InfoFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
InfoFrame.Visible = false

local InfoCorner2 = Instance.new("UICorner")
InfoCorner2.Parent = InfoFrame
InfoCorner2.CornerRadius = UDim.new(0, 8)

local InfoText = Instance.new("TextLabel")
InfoText.Parent = InfoFrame
InfoText.Size = UDim2.new(1, -10, 1, -10)
InfoText.Position = UDim2.new(0, 5, 0, 5)
InfoText.BackgroundTransparency = 1
InfoText.Font = Enum.Font.Gotham
InfoText.Text = "Creador: JoseAngel_Blox\nFecha: 30/06/2026"
InfoText.TextColor3 = Color3.new(1,1,1)
InfoText.TextSize = 13
InfoText.TextWrapped = true

-- == ABRIR/CERRAR INFO ==
local InfoAbierto = false
InfoButton.MouseButton1Click:Connect(function()
    InfoAbierto = not InfoAbierto
    InfoFrame.Visible = InfoAbierto
    InfoButton.Text = InfoAbierto and "info ↑" or "info ↓"
end)

-- ==============================================
-- 🚀 BOTÓN AUTO FARM
-- ==============================================
local FarmButton = Instance.new("TextButton")
FarmButton.Parent = MainFrame
FarmButton.Size = UDim2.new(0, 200, 0, 50)
FarmButton.Position = UDim2.new(0.5, -100, 0, 100)
FarmButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
FarmButton.Text = "Auto Farm: OFF"
FarmButton.TextColor3 = Color3.new(1,1,1)
FarmButton.Font = Enum.Font.GothamBold
FarmButton.TextSize = 16

local FarmCorner = Instance.new("UICorner")
FarmCorner.Parent = FarmButton
FarmCorner.CornerRadius = UDim.new(0, 10)

-- ==============================================
-- 💰 BOTÓN AUTO COLLECT CASH
-- ==============================================
local CollectButton = Instance.new("TextButton")
CollectButton.Parent = MainFrame
CollectButton.Size = UDim2.new(0, 200, 0, 50)
CollectButton.Position = UDim2.new(0.5, -100, 0, 160)
CollectButton.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
CollectButton.Text = "Auto Collect Cash: OFF"
CollectButton.TextColor3 = Color3.new(0,0,0)
CollectButton.Font = Enum.Font.GothamBold
CollectButton.TextSize = 16

local CollectCorner = Instance.new("UICorner")
CollectCorner.Parent = CollectButton
CollectCorner.CornerRadius = UDim.new(0, 10)

-- ==============================================
-- 🏗️ BOTÓN AUTO BUILD
-- ==============================================
local BuildButton = Instance.new("TextButton")
BuildButton.Parent = MainFrame
BuildButton.Size = UDim2.new(0, 200, 0, 50)
BuildButton.Position = UDim2.new(0.5, -100, 0, 220)
BuildButton.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
BuildButton.Text = "Auto Build: OFF"
BuildButton.TextColor3 = Color3.new(1,1,1)
BuildButton.Font = Enum.Font.GothamBold
BuildButton.TextSize = 16

local BuildCorner = Instance.new("UICorner")
BuildCorner.Parent = BuildButton
BuildCorner.CornerRadius = UDim.new(0, 10)

-- ==============================================
-- ⚡ BOTÓN SPEED
-- ==============================================
local SpeedButton = Instance.new("TextButton")
SpeedButton.Parent = MainFrame
SpeedButton.Size = UDim2.new(0, 200, 0, 50)
SpeedButton.Position = UDim2.new(0.5, -100, 0, 280)
SpeedButton.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
SpeedButton.Text = "Speed: OFF"
SpeedButton.TextColor3 = Color3.new(1,1,1)
SpeedButton.Font = Enum.Font.GothamBold
SpeedButton.TextSize = 16

local SpeedCorner = Instance.new("UICorner")
SpeedCorner.Parent = SpeedButton
SpeedCorner.CornerRadius = UDim.new(0, 10)

-- ==============================================
-- ⚙️ FUNCIONAMIENTO DEL SCRIPT
-- ==============================================
local AutoFarmActivado = false
local AutoCollectActivado = false
local AutoBuildActivado = false
local SpeedActivado = false

-- CONFIGURACIÓN DE VELOCIDAD
local VelocidadDeseada = 80  -- ⬅️ Cambia este número para más o menos velocidad
local VelocidadOriginal = 16  -- Valor por defecto de Roblox

-- Función para obtener el personaje
local function ObtenerPersonaje()
    return Player.Character or Player.CharacterAdded:Wait()
end

-- 🛡️ FUNCIÓN ANTI-AFK
spawn(function()
    while true do
        wait(300) -- 5 minutos
        if AutoFarmActivado or AutoCollectActivado or AutoBuildActivado or SpeedActivado then
            local personaje = ObtenerPersonaje()
            if personaje and personaje:FindFirstChild("Humanoid") then
                personaje.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                print("[Anti-AFK] Movimiento realizado")
            end
        end
    end
end)

-- 🔘 AUTO FARM
local function IniciarAutoFarm()
    spawn(function()
        while AutoFarmActivado do
            local personaje = ObtenerPersonaje()
            if not personaje then wait(1) continue end
            local rootPart = personaje:FindFirstChild("HumanoidRootPart")
            if not rootPart then wait(1) continue end

            for _, objeto in pairs(Workspace:GetDescendants()) do
                if not AutoFarmActivado then break end
                
                if objeto:IsA("ClickDetector") or objeto.Name:lower():find("button") or objeto.Name:lower():find("drop") then
                    local success, err = pcall(function()
                        firetouchinterest(rootPart, objeto.Parent, 0)
                        firetouchinterest(rootPart, objeto.Parent, 1)
                        
                        local valor = objeto.Parent:FindFirstChild("MoneyValue") or objeto.Parent:FindFirstChild("Value")
                        if valor and valor.Value then
                            print("[Auto Farm] +"..valor.Value.." dinero")
                        end
                    end)
                    wait(0.1)
                end
            end
            wait(0.5)
        end
    end)
end

FarmButton.MouseButton1Click:Connect(function()
    AutoFarmActivado = not AutoFarmActivado
    if AutoFarmActivado then
        FarmButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        FarmButton.Text = "Auto Farm: ON"
        IniciarAutoFarm()
        print("✅ Auto Farm ACTIVADO")
    else
        FarmButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        FarmButton.Text = "Auto Farm: OFF"
        print("❌ Auto Farm DESACTIVADO")
    end
end)

-- 🔘 AUTO COLLECT CASH
local function IniciarAutoCollect()
    spawn(function()
        while AutoCollectActivado do
            local personaje = ObtenerPersonaje()
            if not personaje then wait(1) continue end
            local rootPart = personaje:FindFirstChild("HumanoidRootPart")
            if not rootPart then wait(1) continue end

            for _, objeto in pairs(Workspace:GetChildren()) do
                if not AutoCollectActivado then break end

                if objeto.Name:lower():find("money") or objeto.Name:lower():find("cash") or objeto.Name:lower():find("bill") then
                    
                    local success, err = pcall(function()
                        firetouchinterest(rootPart, objeto, 0)
                        firetouchinterest(rootPart, objeto, 1)
                        
                        local valor = objeto:FindFirstChild("Value") or objeto:FindFirstChild("CashValue")
                        if valor then
                            print("[Auto Collect] +"..valor.Value.." recogido!")
                        end
                    end)
                    wait(0.1)
                end
            end
            wait(0.2)
        end
    end)
end

CollectButton.MouseButton1Click:Connect(function()
    AutoCollectActivado = not AutoCollectActivado
    if AutoCollectActivado then
        CollectButton.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
        CollectButton.Text = "Auto Collect Cash: ON"
        IniciarAutoCollect()
        print("✅ Auto Collect Cash ACTIVADO")
    else
        CollectButton.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
        CollectButton.Text = "Auto Collect Cash: OFF"
        print("❌ Auto Collect Cash DESACTIVADO")
    end
end)

-- 🔘 AUTO BUILD
local function IniciarAutoBuild()
    spawn(function()
        while AutoBuildActivado do
            local personaje = ObtenerPersonaje()
            if not personaje then wait(1) continue end
            local rootPart = personaje:FindFirstChild("HumanoidRootPart")
            if not rootPart then wait(1) continue end

            -- Obtener dinero actual
            local leaderstats = Player:FindFirstChild("leaderstats")
            local dinero = 0
            if leaderstats then
                local cashObj = leaderstats:FindFirstChild("Cash") or leaderstats:FindFirstChild("Money")
                if cashObj then dinero = cashObj.Value end
            end

            -- Buscar todos los botones de compra
            local botonesDisponibles = {}
            for _, objeto in pairs(Workspace:GetDescendants()) do
                if objeto:IsA("ClickDetector") and objeto.Parent:FindFirstChild("Price") then
                    table.insert(botonesDisponibles, objeto)
                end
            end

            -- Ordenar por precio (más barato primero)
            table.sort(botonesDisponibles, function(a, b)
                local precioA = a.Parent:FindFirstChild("Price") and a.Parent.Price.Value or 999999
                local precioB = b.Parent:FindFirstChild("Price") and b.Parent.Price.Value or 999999
                return precioA < precioB
            end)

            -- Intentar comprar
            for _, boton in pairs(botonesDisponibles) do
                if not AutoBuildActivado then break end
                
                local precio = boton.Parent.Price.Value
                if dinero >= precio then
                    local success, err = pcall(function()
                        firetouchinterest(rootPart, boton.Parent, 0)
                        firetouchinterest(rootPart, boton.Parent, 1)
                        print("[Auto Build] Comprado: "..boton.Parent.Name.." - Precio: $"..precio)
                    end)
                    wait(0.3)
                end
            end
            wait(1)
        end
    end)
end

BuildButton.MouseButton1Click:Connect(function()
    AutoBuildActivado = not AutoBuildActivado
    if AutoBuildActivado then
        BuildButton.BackgroundColor3 = Color3.fromRGB(0, 50, 150)
        BuildButton.Text = "Auto Build: ON"
        IniciarAutoBuild()
        print("✅ Auto Build ACTIVADO")
    else
        BuildButton.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
        BuildButton.Text = "Auto Build: OFF"
        print("❌ Auto Build DESACTIVADO")
    end
end)

-- 🔘 SPEED
local function AplicarVelocidad(velocidad)
    local success, err = pcall(function()
        local personaje = ObtenerPersonaje()
        if personaje then
            local humanoid = personaje:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = velocidad
            end
        end
    end)
end

-- Cuando aparece un nuevo personaje
Player.CharacterAdded:Connect(function()
    wait(0.5)
    if SpeedActivado then
        AplicarVelocidad(VelocidadDeseada)
    end
end)

SpeedButton.MouseButton1Click:Connect(function()
    SpeedActivado = not SpeedActivado
    if SpeedActivado then
        SpeedButton.BackgroundColor3 = Color3.fromRGB(200, 50, 0)
        SpeedButton.Text = "Speed: ON"
        AplicarVelocidad(VelocidadDeseada)
        print("✅ Speed ACTIVADO - Velocidad: "..VelocidadDeseada)
    else
        SpeedButton.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
        SpeedButton.Text = "Speed: OFF"
        AplicarVelocidad(VelocidadOriginal)
        print("❌ Speed DESACTIVADO - Velocidad normal")
    end
end)

-- ==============================================
-- 🖱️ MOVER EL MENÚ
-- ==============================================
local Dragging = nil
local DragInput = nil
local DragStart = nil
local StartPos = nil

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = true
        DragStart = input.Position
        StartPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                Dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        DragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if Dragging and input == DragInput then
        local Delta = input.Position - DragStart
        MainFrame.Position = UDim2.new(
            StartPos.X.Scale,
            StartPos.X.Offset + Delta.X,
            StartPos.Y.Scale,
            StartPos.Y.Offset + Delta.Y
        )
    end
end)

print("✅ Mansion Tycoon v1.0 cargado con éxito!")
print("👨‍💻 Creado por: JoseAngel_Blox")
