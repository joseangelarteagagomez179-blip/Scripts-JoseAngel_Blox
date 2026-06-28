-- Servicios
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

-- Variables
local Player = game.Players.LocalPlayer
local PlayerGui = Player.PlayerGui

-- Crear ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PremiumUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.Parent = game:GetService("CoreGui")

-- Protección
if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
end

-- ==============================================
-- 🔲 Marco Principal
-- ==============================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 260, 0, 650)
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 16)
UICorner.Parent = MainFrame

local UIShadow = Instance.new("UIShadow")
UIShadow.BlurRadius = 15
UIShadow.Color = Color3.new(0, 0, 0)
UIShadow.Transparency = 0.3
UIShadow.Offset = Vector2.new(0, 5)
UIShadow.Parent = MainFrame

-- ==============================================
-- 📂 Botones Superiores
-- ==============================================
-- Main
local MainButton = Instance.new("TextButton")
MainButton.Name = "MainButton"
MainButton.Size = UDim2.new(0.30, 0, 0, 45)
MainButton.Position = UDim2.new(0.02, 0, 0, 10)
MainButton.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
MainButton.Text = "Main↓"
MainButton.TextSize = 16
MainButton.Font = Enum.Font.GothamBold
MainButton.TextColor3 = Color3.new(1, 1, 1)
MainButton.BorderSizePixel = 0
MainButton.Parent = MainFrame

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainButton

-- Player
local PlayerButton = Instance.new("TextButton")
PlayerButton.Name = "PlayerButton"
PlayerButton.Size = UDim2.new(0.30, 0, 0, 45)
PlayerButton.Position = UDim2.new(0.35, 0, 0, 10)
PlayerButton.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
PlayerButton.Text = "Player↓"
PlayerButton.TextSize = 16
PlayerButton.Font = Enum.Font.GothamBold
PlayerButton.TextColor3 = Color3.new(1, 1, 1)
PlayerButton.BorderSizePixel = 0
PlayerButton.Parent = MainFrame

local PlayerCorner = Instance.new("UICorner")
PlayerCorner.CornerRadius = UDim.new(0, 10)
PlayerCorner.Parent = PlayerButton

-- Shop
local ShopButton = Instance.new("TextButton")
ShopButton.Name = "ShopButton"
ShopButton.Size = UDim2.new(0.30, 0, 0, 45)
ShopButton.Position = UDim2.new(0.68, 0, 0, 10)
ShopButton.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
ShopButton.Text = "Shop↓"
ShopButton.TextSize = 16
ShopButton.Font = Enum.Font.GothamBold
ShopButton.TextColor3 = Color3.new(1, 1, 1)
ShopButton.BorderSizePixel = 0
ShopButton.Parent = MainFrame

local ShopCorner = Instance.new("UICorner")
ShopCorner.CornerRadius = UDim.new(0, 10)
ShopCorner.Parent = ShopButton

-- ==============================================
-- 📋 Paneles
-- ==============================================
-- Panel Main
local MainPanel = Instance.new("Frame")
MainPanel.Name = "MainPanel"
MainPanel.Size = UDim2.new(0, 240, 0, 570)
MainPanel.Position = UDim2.new(0, 10, 0, 70)
MainPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
MainPanel.BorderSizePixel = 0
MainPanel.Visible = false
MainPanel.Parent = MainFrame

local MainPanelCorner = Instance.new("UICorner")
MainPanelCorner.CornerRadius = UDim.new(0, 12)
MainPanelCorner.Parent = MainPanel

local MainList = Instance.new("UIListLayout")
MainList.Padding = UDim.new(0, 10)
MainList.HorizontalAlignment = Enum.HorizontalAlignment.Center
MainList.VerticalAlignment = Enum.VerticalAlignment.Top
MainList.Parent = MainPanel

-- Panel Player
local PlayerPanel = Instance.new("Frame")
PlayerPanel.Name = "PlayerPanel"
PlayerPanel.Size = UDim2.new(0, 240, 0, 570)
PlayerPanel.Position = UDim2.new(0, 10, 0, 70)
PlayerPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
PlayerPanel.BorderSizePixel = 0
PlayerPanel.Visible = false
PlayerPanel.Parent = MainFrame

local PlayerPanelCorner = Instance.new("UICorner")
PlayerPanelCorner.CornerRadius = UDim.new(0, 12)
PlayerPanelCorner.Parent = PlayerPanel

local PlayerList = Instance.new("UIListLayout")
PlayerList.Padding = UDim.new(0, 10)
PlayerList.HorizontalAlignment = Enum.HorizontalAlignment.Center
PlayerList.VerticalAlignment = Enum.VerticalAlignment.Top
PlayerList.Parent = PlayerPanel

-- Panel Shop
local ShopPanel = Instance.new("Frame")
ShopPanel.Name = "ShopPanel"
ShopPanel.Size = UDim2.new(0, 240, 0, 570)
ShopPanel.Position = UDim2.new(0, 10, 0, 70)
ShopPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
ShopPanel.BorderSizePixel = 0
ShopPanel.Visible = false
ShopPanel.Parent = MainFrame

local ShopPanelCorner = Instance.new("UICorner")
ShopPanelCorner.CornerRadius = UDim.new(0, 12)
ShopPanelCorner.Parent = ShopPanel

local ShopList = Instance.new("UIListLayout")
ShopList.Padding = UDim.new(0, 6)
ShopList.HorizontalAlignment = Enum.HorizontalAlignment.Center
ShopList.VerticalAlignment = Enum.VerticalAlignment.Top
ShopList.Parent = ShopPanel

-- ==============================================
-- 🎵 Panel de Selección de Sonidos
-- ==============================================
local SoundsPanel = Instance.new("Frame")
SoundsPanel.Name = "SoundsPanel"
SoundsPanel.Size = UDim2.new(0, 200, 0, 150)
SoundsPanel.Position = UDim2.new(1, 10, 0, 100)
SoundsPanel.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
SoundsPanel.BorderSizePixel = 0
SoundsPanel.Visible = false
SoundsPanel.Parent = ShopPanel

local SoundsCorner = Instance.new("UICorner")
SoundsCorner.CornerRadius = UDim.new(0, 10)
SoundsCorner.Parent = SoundsPanel

local SoundsList = Instance.new("UIListLayout")
SoundsList.Padding = UDim.new(0, 5)
SoundsList.HorizontalAlignment = Enum.HorizontalAlignment.Center
SoundsList.VerticalAlignment = Enum.VerticalAlignment.Top
SoundsList.Parent = SoundsPanel

-- ==============================================
-- 🎛️ Función Crear Botones
-- ==============================================
local function CreateButton(Name, Function, Parent)
    local Button = Instance.new("TextButton")
    Button.Name = Name.."Button"
    Button.Size = UDim2.new(0, 220, 0, 45)
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    Button.Text = Name
    Button.TextSize = 15
    Button.Font = Enum.Font.GothamSemibold
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.BorderSizePixel = 0
    Button.Parent = Parent

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 8)
    BtnCorner.Parent = Button

    Button.MouseButton1Click:Connect(function()
        Function()
        local Tween = TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(70, 70, 95)})
        Tween:Play()
        task.wait(0.1)
        local Tween2 = TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(50, 50, 70)})
        Tween2:Play()
    end)

    return Button
end

local function CreateToggle(Name, Id, ToolName, Parent)
    local Enabled = false
    local Button = Instance.new("TextButton")
    Button.Name = Name.."Button"
    Button.Size = UDim2.new(0, 220, 0, 38)
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    Button.Text = Name .. "\n[OFF]"
    Button.TextSize = 13
    Button.Font = Enum.Font.GothamSemibold
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.BorderSizePixel = 0
    Button.Parent = Parent

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 6)
    BtnCorner.Parent = Button

    Button.MouseButton1Click:Connect(function()
        Enabled = not Enabled
        if Enabled then
            Button.Text = Name .. "\n[ON]"
            Button.BackgroundColor3 = Color3.fromRGB(60, 120, 70)
            print("Unlocked: " .. ToolName .. " ["..Id.."]")
        else
            Button.Text = Name .. "\n[OFF]"
            Button.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
            print("Locked: " .. ToolName .. " ["..Id.."]")
        end
        local Tween = TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundColor3 = Enabled and Color3.fromRGB(70, 140, 80) or Color3.fromRGB(50, 50, 70)})
        Tween:Play()
    end)

    return Button
end

local function CreateSoundToggle(Name, Id, Parent)
    local Button = Instance.new("TextButton")
    Button.Name = Name.."Button"
    Button.Size = UDim2.new(0, 180, 0, 35)
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    Button.Text = "▶ " .. Name
    Button.TextSize = 13
    Button.Font = Enum.Font.GothamSemibold
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.BorderSizePixel = 0
    Button.Parent = Parent

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 6)
    BtnCorner.Parent = Button

    Button.MouseButton1Click:Connect(function()
        print("Seleccionado: " .. Name .. " ["..Id.."]")
    end)
end

-- ==============================================
-- ⚙️ ESTADOS Y CONEXIONES
-- ==============================================
local Enabled = {
    AutoFarm = false,
    AutoWin = false,
    Fly = false,
    Noclip = false,
    InfiniteJump = false,
    GodMode = false
}

local Connections = {}

-- ==============================================
-- 🚜 FUNCIONES MAIN
-- ==============================================
local function AutoFarm()
    Enabled.AutoFarm = not Enabled.AutoFarm
    if Enabled.AutoFarm then
        print("Auto Farm: ON")
        Connections.AutoFarm = RunService.Heartbeat:Connect(function()
            local Character = Player.Character
            if not Character then return end
            local HRP = Character:FindFirstChild("HumanoidRootPart")
            if not HRP then return end

            for _, Obj in pairs(Workspace:GetChildren()) do
                if Obj:IsA("Part") or Obj:IsA("MeshPart") then
                    if string.find(Obj.Name:lower(), "candy") or string.find(Obj.Name:lower(), "coin") then
                        if (HRP.Position - Obj.Position).Magnitude < 15 then
                            Obj.CFrame = HRP.CFrame
                        end
                    end
                end
            end
        end)
    else
        print("Auto Farm: OFF")
        if Connections.AutoFarm then Connections.AutoFarm:Disconnect() end
    end
end

local function AutoWin()
    Enabled.AutoWin = not Enabled.AutoWin
    if Enabled.AutoWin then
        print("Auto Win: ON")
        Connections.AutoWin = RunService.Heartbeat:Connect(function()
            local Character = Player.Character
            if not Character then return end
            local HRP = Character:FindFirstChild("HumanoidRootPart")
            if not HRP then return end

            for _, Part in pairs(Workspace:GetChildren()) do
                if string.find(Part.Name:lower(), "finish") or string.find(Part.Name:lower(), "win") then
                    HRP.CFrame = Part.CFrame + Vector3.new(0, 3, 0)
                    break
                end
            end
        end)
    else
        print("Auto Win: OFF")
        if Connections.AutoWin then Connections.AutoWin:Disconnect() end
    end
end

local function Speed()
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    if Humanoid then Humanoid.WalkSpeed = 150 end
end

local function JumpPower()
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    if Humanoid then Humanoid.JumpPower = 200 end
end

-- ==============================================
-- 👤 FUNCIONES PLAYER
-- ==============================================
local function Fly()
    Enabled.Fly = not Enabled.Fly
    if Enabled.Fly then
        print("Fly: ON")
        local Character = Player.Character
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        Humanoid.PlatformStand = true
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)

        Connections.Fly = RunService.RenderStepped:Connect(function()
            local Camera = Workspace.CurrentCamera
            local MoveDir = Vector3.new()
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then MoveDir += Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then MoveDir -= Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then MoveDir -= Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then MoveDir += Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then MoveDir += Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then MoveDir -= Vector3.new(0,1,0) end

            Character.HumanoidRootPart.Velocity = MoveDir * 50
        end)
    else
        print("Fly: OFF")
        if Connections.Fly then Connections.Fly:Disconnect() end
        local Character = Player.Character
        if Character then
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")
            if Humanoid then Humanoid.PlatformStand = false end
        end
    end
end

local function Noclip()
    Enabled.Noclip = not Enabled.Noclip
    if Enabled.Noclip then
        print("Noclip: ON")
        Connections.Noclip = RunService.Heartbeat:Connect(function()
            local Character = Player.Character
            if not Character then return end
            for _, Part in pairs(Character:GetChildren()) do
                if Part:IsA("BasePart") then
                    Part.CanCollide = false
                end
            end
        end)
    else
        print("Noclip: OFF")
        if Connections.Noclip then Connections.Noclip:Disconnect() end
    end
end

local function InfiniteJump()
    Enabled.InfiniteJump = not Enabled.InfiniteJump
    if Enabled.InfiniteJump then
        print("Infinite Jump: ON")
        Connections.InfiniteJump = UserInputService.JumpRequest:Connect(function()
            local Character = Player.Character
            if Character then
                local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                if Humanoid then Humanoid.Jump = true end
            end
        end)
    else
        print("Infinite Jump: OFF")
        if Connections.InfiniteJump then Connections.InfiniteJump:Disconnect() end
    end
end

local function GodMode()
    Enabled.GodMode = not Enabled.GodMode
    if Enabled.GodMode then
        print("God Mode: ON")
        Connections.GodMode = RunService.Heartbeat:Connect(function()
            local Character = Player.Character
            if Character then
                local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                if Humanoid then Humanoid.Health = Humanoid.MaxHealth end
            end
        end)
    else
        print("God Mode: OFF")
        if Connections.GodMode then Connections.GodMode:Disconnect() end
    end
end

local function RemoveObstacles()
    print("Removing Obstacles...")
    for _, Part in pairs(Workspace:GetDescendants()) do
        if Part:IsA("BasePart") and not Part:IsDescendantOf(Player.Character) then
            if string.find(Part.Name:lower(), "obstacle") or string.find(Part.Name:lower(), "wall") or string.find(Part.Name:lower(), "block") then
                Part:Destroy()
            end
        end
    end
end

local function SetWalkSpeed()
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    if Humanoid then
        Humanoid.WalkSpeed = 100
    end
end

local function CloseUI()
    for _, con in pairs(Connections) do
        if con then con:Disconnect() end
    end
    ScreenGui:Destroy()
end

-- ==============================================
-- 🎵 FUNCIÓN MOSTRAR/OCULTAR SELECCIÓN DE SONIDOS
-- ==============================================
local SoundsOpen = false
local function ToggleSoundsMenu()
    SoundsOpen = not SoundsOpen
    SoundsPanel.Visible = SoundsOpen
    if SoundsOpen then
        SoundsButton.Text = "Unlock Sounds 1724877043 →"
    else
        SoundsButton.Text = "Unlock Sounds 1724877043"
    end
end

-- ==============================================
-- 📋 AGREGAR BOTONES
-- ==============================================
-- Main
CreateButton("Auto Farm", AutoFarm, MainPanel)
CreateButton("Auto Win", AutoWin, MainPanel)
CreateButton("Velocidad", Speed, MainPanel)
CreateButton("Salto Alto", JumpPower, MainPanel)
CreateButton("Cerrar UI", CloseUI, MainPanel)

-- Player
CreateButton("Fly", Fly, PlayerPanel)
CreateButton("Noclip", Noclip, PlayerPanel)
CreateButton("Infinite Jump", InfiniteJump, PlayerPanel)
CreateButton("God Mode", GodMode, PlayerPanel)
CreateButton("Remove Obstacles", RemoveObstacles, PlayerPanel)
CreateButton("WalkSpeed", SetWalkSpeed, PlayerPanel)

-- Shop
CreateToggle("Free Shop Items", "all", "ShopItem", ShopPanel)
CreateToggle("Candy-Treadmill", "1799448573", "Candy-Treadmill", ShopPanel)
CreateToggle("ADMIN-Treadmill", "1799430547", "ADMIN-Treadmill", ShopPanel)
CreateToggle("Diamond-Treadmill", "1724758929", "Diamond-Treadmill", ShopPanel)
CreateToggle("Gold-Treadmill", "1674743386", "Gold-Treadmill", ShopPanel)
CreateToggle("Unlock gamepass Sounds", "gamepass", "GamepassSounds", ShopPanel)

-- Sonidos
SoundsButton = CreateToggle("Unlock Sounds 1724877043", "1724877043", "SoundsPack", ShopPanel)
SoundsButton.MouseButton1Click:Connect(ToggleSoundsMenu)
CreateSoundToggle("Sound 1", "1724877043_1", SoundsPanel)
CreateSoundToggle("Sound 2", "1724877043_2", SoundsPanel)
CreateSoundToggle("Sound 3", "1724877043_3", SoundsPanel)
CreateSoundToggle("Sound 4", "1724877043_4", SoundsPanel)

-- Trails
CreateToggle("GalaxyTrail", "1705684677", "GalaxyTrail", ShopPanel)
CreateToggle("RedTrail", "1705880432", "RedTrail", ShopPanel)
CreateToggle("RainbowTrail", "1705872346", "RainbowTrail", ShopPanel)
CreateToggle("PurpleTrail", "1705766445", "PurpleTrail", ShopPanel)
CreateToggle("BlueTrail", "1705790528", "BlueTrail", ShopPanel)
CreateToggle("SupernovaTrail", "1828536440", "SupernovaTrail", ShopPanel)
CreateToggle("VoidTrail", "1829431034", "VoidTrail", ShopPanel)
CreateToggle("CosmicTrail", "1826883825", "CosmicTrail", ShopPanel)
CreateToggle("GodlikeTrail", "1825327908", "GodlikeTrail", ShopPanel)
CreateToggle("InfinityTrail", "1829496998", "InfinityTrail", ShopPanel)

-- Auras
CreateToggle("GlowAura", "1841065578", "GlowAura", ShopPanel)
CreateToggle("WindAura", "1841089568", "WindAura", ShopPanel)
CreateToggle("Electric-Aura", "1883044917", "Electric-Aura", ShopPanel)
CreateToggle("WaterAura", "1840979522", "WaterAura", ShopPanel)
CreateToggle("FireAura", "1860376482", "FireAura", ShopPanel)

-- ==============================================
-- 🔽 ABRIR/CERRAR MENUS
-- ==============================================
local MainOpen = false
local PlayerOpen = false
local ShopOpen = false

MainButton.MouseButton1Click:Connect(function()
    MainOpen = not MainOpen
    PlayerOpen = false
    ShopOpen = false
    PlayerPanel.Visible = false
    ShopPanel.Visible = false
    SoundsPanel.Visible = false
    MainPanel.Visible = MainOpen
    MainButton.Text = MainOpen and "Main↑" or "Main↓"
    PlayerButton.Text = "Player↓"
    ShopButton.Text = "Shop↓"
end)

PlayerButton.MouseButton1Click:Connect(function()
    PlayerOpen = not PlayerOpen
    MainOpen = false
    ShopOpen = false
    MainPanel.Visible = false
    ShopPanel.Visible = false
    SoundsPanel.Visible = false
    PlayerPanel.Visible = PlayerOpen
    PlayerButton.Text = PlayerOpen and "Player↑" or "Player↓"
    MainBut
