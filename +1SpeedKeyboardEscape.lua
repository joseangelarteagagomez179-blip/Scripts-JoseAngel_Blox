--// SERVICES
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

--// VARIABLES
local Enabled = false
local AutoWin = false
local OriginalWalkSpeed, OriginalJumpPower

--// GUI CREATION
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DolaHub_V2"
ScreenGui.Parent = Player.PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

--// MAIN FRAME
local Main = Instance.new("Frame")
Main.Name = "MainFrame"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(18, 19, 32)
Main.Size = UDim2.new(0, 420, 0, 550)
Main.Position = UDim2.new(0.32, 0, 0.15, 0)
Main.Active = true
Main.Draggable = true
Main.ClipsDescendants = true

local MainCorner = Instance.new("UICorner", Main)
MainCorner.CornerRadius = UDim.new(0,16)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(255, 120, 200)
MainStroke.Thickness = 2
MainStroke.Transparency = 0.2

--// TOP BAR
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = Main
TopBar.BackgroundColor3 = Color3.fromRGB(25, 26, 44)
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.Position = UDim2.new(0,0,0,0)

local TopCorner = Instance.new("UICorner", TopBar)
TopCorner.CornerRadius = UDim.new(0,16)

local Title = Instance.new("TextLabel")
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(0.8,0,1,0)
Title.Position = UDim2.new(0.05,0,0,0)
Title.Font = Enum.Font.GothamBold
Title.Text = "✨ DOLA HUB | SPEED KEYBOARD"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextSize = 16
Title.XAlignment = Enum.TextXAlignment.Left

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Name = "Minimize"
MinimizeBtn.Parent = TopBar
MinimizeBtn.Size = UDim2.new(0,32,0,32)
MinimizeBtn.Position = UDim2.new(0.92,0,0,6)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(255,70,70)
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.new(1,1,1)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 14

local MinCorner = Instance.new("UICorner", MinimizeBtn)
MinCorner.CornerRadius = UDim.new(1,0)

--// CONTAINER
local Container = Instance.new("ScrollingFrame")
Container.Name = "Container"
Container.Parent = Main
Container.BackgroundTransparency = 1
Container.Size = UDim2.new(1, -20, 1, -60)
Container.Position = UDim2.new(0, 10, 0, 50)
Container.CanvasSize = UDim2.new(0,0, 0, 1000)
Container.ScrollBarThickness = 4
Container.ScrollBarImageColor3 = Color3.fromRGB(255, 120, 200)

local UIGrid = Instance.new("UIGridLayout")
UIGrid.Parent = Container
UIGrid.CellSize = UDim2.new(0.47, 0, 0, 120)
UIGrid.Padding = UDim.new(0, 8)
UIGrid.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIGrid.SortOrder = Enum.SortOrder.LayoutOrder

--// FUNCTION TO CREATE BUTTONS (STYLE PREMIUM)
local function CreateButton(name, desc, color, callback)
    local BtnFrame = Instance.new("Frame")
    BtnFrame.BackgroundColor3 = Color3.fromRGB(25, 26, 44)
    BtnFrame.Size = UDim2.new(0.47,0,0,120)
    BtnFrame.Parent = Container
    
    local frameCorner = Instance.new("UICorner", BtnFrame)
    frameCorner.CornerRadius = UDim.new(0,12)
    
    local frameStroke = Instance.new("UIStroke", BtnFrame)
    frameStroke.Color = color
    frameStroke.Thickness = 1.5
    frameStroke.Transparency = 0.3

    local Btn = Instance.new("TextButton")
    Btn.Parent = BtnFrame
    Btn.Size = UDim2.new(1, -12, 1, -12)
    Btn.Position = UDim2.new(0,6,0,6)
    Btn.BackgroundColor3 = color
    Btn.AutoLocalize = false
    Btn.Font = Enum.Font.GothamBold
    Btn.Text = name
    Btn.TextColor3 = Color3.new(1,1,1)
    Btn.TextSize = 14
    
    local btnCorner = Instance.new("UICorner", Btn)
    btnCorner.CornerRadius = UDim.new(0,8)

    local DescLabel = Instance.new("TextLabel")
    DescLabel.Parent = BtnFrame
    DescLabel.BackgroundTransparency = 1
    DescLabel.Size = UDim2.new(1, -10, 0, 20)
    DescLabel.Position = UDim2.new(0,5,0.75,0)
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.Text = desc
    DescLabel.TextColor3 = Color3.fromRGB(200,200,200)
    DescLabel.TextSize = 11

    Btn.MouseButton1Click:Connect(callback)
    return BtnFrame
end

--// ==================== FUNCIONES ====================

-- 1. ACTIVAR HACKS
CreateButton("⚡ ACTIVAR TODO", "Velocidad + Salto + Noclip", Color3.fromRGB(72, 219, 255), function()
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")
    
    if not OriginalWalkSpeed then
        OriginalWalkSpeed = Humanoid.WalkSpeed
        OriginalJumpPower = Humanoid.JumpPower
    end

    Enabled = not Enabled
    if Enabled then
        Humanoid.WalkSpeed = 9999
        Humanoid.JumpPower = 250
        spawn(function()
            while Enabled and Humanoid.Health > 0 do
                for _, part in pairs(Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
                task.wait(0.1)
            end
        end)
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
CreateButton("🏆 AUTO WIN", "Corre automáticamente", Color3.fromRGB(255, 159, 67), function()
    AutoWin = not AutoWin
    spawn(function()
        while AutoWin do
            task.wait(0.1)
            local hrp = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = hrp.CFrame * CFrame.new(0, 0, -8)
            end
        end
    end)
end)

-- 3. IR A LA META
CreateButton("🚀 TELETRANSPORTE", "Ir directo al final", Color3.fromRGB(139, 128, 255), function()
    local hrp = Player.Character.HumanoidRootPart
    -- Coordenadas ajustadas al mapa actual
    hrp.CFrame = CFrame.new(hrp.Position.X, hrp.Position.Y + 10, hrp.Position.Z - 9999)
end)

-- 4. VELOCIDAD INFINITA
CreateButton("💨 VELOCIDAD MAX", "Velocidad al máximo", Color3.fromRGB(67, 255, 152), function()
    local Humanoid = Player.Character.Humanoid
    Humanoid.WalkSpeed = 9999
    Humanoid.JumpPower = 500
end)

-- 5. 💎 COMPRAR TODO GRATIS
CreateButton("💎 DESBLOQUEAR TODO", "Tienda gratis sin Robux", Color3.fromRGB(255, 82, 150), function()
    -- Dar dinero y stats infinitos
    pcall(function()
        local leaderstats = Player:FindFirstChild("leaderstats")
        if leaderstats then
            for _, stat in pairs(leaderstats:GetChildren()) do
                if stat:IsA("NumberValue") or stat:IsA("IntValue") then
                    stat.Value = math.huge
                end
            end
        end
        
        -- Comprar todo lo visible
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("ClickDetector") and v.Parent.Name:lower():find("buy") or v.Parent.Name:lower():find("shop") then
                fireclickdetector(v)
                task.wait(0.1)
            end
        end
        
        -- Intentar bypass de remotos
        local RS = game:GetService("ReplicatedStorage")
        for _, rem in pairs(RS:GetChildren()) do
            if rem.Name:lower():find("buy") or rem.Name:lower():find("purchase") then
                rem:FireServer("All", true)
            end
        end
    end)
    game.StarterGui:SetCore("SendNotification", {Title="Éxito!", Text="Tienda desbloqueada!", Duration=3})
end)

-- 6. AUTO REBIRTH
CreateButton("♻️ AUTO REBIRTH", "Renacer automático", Color3.fromRGB(195, 82, 255), function()
    spawn(function()
        while true do
            task.wait(2)
            pcall(function()
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("ClickDetector") and v.Parent.Name:lower():find("rebirth") then
                        fireclickdetector(v)
                    end
                end
            end)
        end
    end)
end)

--// MINIMIZAR
MinimizeBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

--// ANIMACION DE ENTRADA
Main:TweenSizeAndPosition(
    UDim2.new(0, 420, 0, 550),
    UDim2.new(0.32, 0, 0.15, 0),
    Enum.EasingDirection.Out,
    Enum.EasingStyle.Elastic,
    0.8,
    true
)

print("✅ Dola Hub V2 Cargado Perfectamente!")
