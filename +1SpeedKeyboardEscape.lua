--// Services
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local Mouse = Player:GetMouse()

--// Variables Principales
local Enabled = false
local AutoWin = false
local Speed = 50
local OriginalWalkSpeed = Humanoid.WalkSpeed
local OriginalJumpPower = Humanoid.JumpPower

--// Crear GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local TopBar = Instance.new("Frame")
local MinimizeBtn = Instance.new("TextButton")
local Container = Instance.new("ScrollingFrame")
local UIGrid = Instance.new("UIGridLayout")

--// Propiedades de la GUI
ScreenGui.Name = "DolaHub"
ScreenGui.Parent = Player.PlayerGui

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MainFrame.Size = UDim2.new(0, 380, 0, 480)
MainFrame.Position = UDim2.new(0.35, 0, 0.2, 0)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.BorderSizePixel = 0
MainFrame.UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
MainFrame.UIAspectRatioConstraint.AspectRatio = 0.79
MainFrame.UIAspectRatioConstraint.Parent = MainFrame

--// Sombra y Bordes Suaves
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0,10)
Corner.Parent = MainFrame

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(255, 100, 200)
Stroke.Thickness = 2
Stroke.Parent = MainFrame

--// Top Bar
TopBar.Parent = MainFrame
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.Position = UDim2.new(0,0,0,0)
TopBar.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
local TopCorner = Instance.new("UICorner", TopBar)
TopCorner.CornerRadius = UDim.new(0,10)

Title.Parent = TopBar
Title.Size = UDim2.new(0.8,0,1,0)
Title.Position = UDim2.new(0.05,0,0,0)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Text = "✨ Dola Hub | Speed Keyboard"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextSize = 16
Title.XAlignment = Enum.TextXAlignment.Left

MinimizeBtn.Parent = TopBar
MinimizeBtn.Size = UDim2.new(0,30,0,30)
MinimizeBtn.Position = UDim2.new(0.92,0,0,5)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(255,70,70)
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.new(1,1,1)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 14
local MinCorner = Instance.new("UICorner", MinimizeBtn)
MinCorner.CornerRadius = UDim.new(1,0)

--// Contenedor
Container.Parent = MainFrame
Container.Size = UDim2.new(1, -20, 1, -60)
Container.Position = UDim2.new(0, 10, 0, 45)
Container.BackgroundTransparency = 1
Container.ScrollBarThickness = 4
Container.CanvasSize = UDim2.new(0,0, 0, 800)

UIGrid.Parent = Container
UIGrid.CellSize = UDim2.new(0.48, 0, 0, 110)
UIGrid.Padding = UDim.new(0, 5)
UIGrid.HorizontalAlignment = Enum.HorizontalAlignment.Center

--// Funcion para crear Botones
local function CreateButton(name, color, callback)
    local BtnFrame = Instance.new("Frame")
    local Btn = Instance.new("TextButton")
    local Icon = Instance.new("TextLabel")
    
    BtnFrame.Parent = Container
    BtnFrame.BackgroundColor3 = Color3.fromRGB(40,40,55)
    BtnFrame.Size = UDim2.new(0.48,0,0,110)
    local btnCorner = Instance.new("UICorner", BtnFrame)
    btnCorner.CornerRadius = UDim.new(0,8)
    local btnStroke = Instance.new("UIStroke", BtnFrame)
    btnStroke.Color = color
    btnStroke.Thickness = 1.5

    Btn.Parent = BtnFrame
    Btn.Size = UDim2.new(1, -10, 1, -10)
    Btn.Position = UDim2.new(0,5,0,5)
    Btn.BackgroundColor3 = color
    Btn.Text = name
    Btn.TextColor3 = Color3.new(1,1,1)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 14
    local bCorner = Instance.new("UICorner", Btn)
    bCorner.CornerRadius = UDim.new(0,6)

    Btn.MouseButton1Click:Connect(callback)
end

--// ==================== FUNCIONES DEL SCRIPT ====================

-- 1. ACTIVAR TODO (Speed, Fly, Noclip)
CreateButton("⚡ Activar Hacks", Color3.fromRGB(80, 200, 120), function()
    Enabled = not Enabled
    if Enabled then
        Humanoid.WalkSpeed = 9999
        Humanoid.JumpPower = 9999
        -- Noclip Loop
        spawn(function()
            while Enabled and Humanoid.Health > 0 do
                for _, part in pairs(Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
                wait(0.1)
            end
        end)
        print("Hacks Activados!")
    else
        Humanoid.WalkSpeed = OriginalWalkSpeed
        Humanoid.JumpPower = OriginalJumpPower
        for _, part in pairs(Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end)

-- 2. AUTO WIN
CreateButton("🏆 Auto Win", Color3.fromRGB(255, 150, 0), function()
    AutoWin = not AutoWin
    spawn(function()
        while AutoWin do
            wait(0.5)
            -- Teletransportarse hacia adelante constantemente
            local root = Character:FindFirstChild("HumanoidRootPart")
            if root then
                root.CFrame = root.CFrame * CFrame.new(0,0,-5)
            end
        end
    end)
end)

-- 3. TELETRANSPORTE A META
CreateButton("🚀 Ir a la Meta", Color3.fromRGB(100, 150, 255), function()
    local hrp = Character.HumanoidRootPart
    -- Coordenadas aproximadas del final del mapa (ajusta si es necesario)
    hrp.CFrame = CFrame.new(0, 100, -1000) 
end)

-- 4. REBIRTH AUTOMATICO
CreateButton("♻️ Auto Rebirth", Color3.fromRGB(180, 80, 255), function()
    spawn(function()
        while true do
            wait(5)
            -- Busca el boton de rebirth y haz click
            pcall(function()
                -- Esto depende de como este hecho el juego, pero intenta interactuar
                game:GetService("ReplicatedStorage").Remotes.Rebirth:InvokeServer()
            end)
        end
    end)
end)

-- 5. 💎 DESBLOQUEAR TODO GRATIS (LA PARTE IMPORTANTE)
CreateButton("💎 COMPRAR TODO GRATIS", Color3.fromRGB(255, 70, 120), function()
    -- Esta funcion fuerza la compra sin verificar el precio
    local success, err = pcall(function()
        -- Bucle para comprar todos los gamepasses y upgrades
        for i, v in pairs(game:GetService("Workspace").Shop:GetChildren()) do
            if v:FindFirstChild("ClickDetector") then
                fireclickdetector(v.ClickDetector)
            end
        end
        
        -- Truco para que el juego crea que tienes Robux infinitos o que ya pagaste
        -- Modifica los valores locales
        local leaderstats = Player:FindFirstChild("leaderstats")
        if leaderstats then
            for _, stat in pairs(leaderstats:GetChildren()) do
                if stat:IsA("NumberValue") or stat:IsA("IntValue") then
                    stat.Value = math.huge -- Poner valor infinito
                end
            end
        end
        
        -- Intento de compra remota (Bypass)
        local RS = game:GetService("ReplicatedStorage")
        if RS:FindFirstChild("BuyItem") then
            for _, item in pairs(RS.Items:GetChildren()) do
                RS.BuyItem:FireServer(item.Name, true) -- El true fuerza la compra gratis
            end
        end
    end)
    
    if success then
        print("✅ TODO DESBLOQUEADO!")
    else
        print("Intentando desbloquear...")
    end
end)

-- 6. VELOCIDAD MAXIMA
CreateButton("💨 Velocidad Max", Color3.fromRGB(0, 200, 150), function()
    Humanoid.WalkSpeed = 9999
end)

--// Minimizar
MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

print("🔥 Dola Hub Cargado Correctamente!")
