-- Servicios
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Variables
local AutoFarm = false
local AutoWin = false
local Connections = {}

-- =============================================
-- INTERFAZ (Cuadrada con esquinas redondas)
-- =============================================
local Gui = Instance.new("ScreenGui")
Gui.Name = "MiScript"
Gui.Parent = game:GetService("CoreGui")
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Parent = Gui
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.05, 0, 0.2, 0)
Main.Size = UDim2.new(0, 260, 0, 300)
Main.Active = true
Main.Draggable = true

local Esquinas = Instance.new("UICorner")
Esquinas.Parent = Main
Esquinas.CornerRadius = UDim.new(0, 16) -- Esquinas bien redondas

local Titulo = Instance.new("TextLabel")
Titulo.Parent = Main
Titulo.BackgroundTransparency = 1
Titulo.Size = UDim2.new(1, 0, 0, 40)
Titulo.Font = Enum.Font.GothamBold
Titulo.Text = "⚡ SPEED HUB ⚡"
Titulo.TextColor3 = Color3.new(1,1,1)
Titulo.TextSize = 20

-- Botón Auto Farm
local BtnFarm = Instance.new("TextButton")
BtnFarm.Parent = Main
BtnFarm.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
BtnFarm.BorderSizePixel = 0
BtnFarm.Position = UDim2.new(0.08, 0, 0.22, 0)
BtnFarm.Size = UDim2.new(0.84, 0, 0, 45)
BtnFarm.Font = Enum.Font.Gotham
BtnFarm.Text = "▶️ AUTO FARM"
BtnFarm.TextColor3 = Color3.new(1,1,1)
BtnFarm.TextSize = 16
local c1 = Instance.new("UICorner", BtnFarm)
c1.CornerRadius = UDim.new(0,8)

-- Botón Auto Win
local BtnWin = Instance.new("TextButton")
BtnWin.Parent = Main
BtnWin.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
BtnWin.BorderSizePixel = 0
BtnWin.Position = UDim2.new(0.08, 0, 0.42, 0)
BtnWin.Size = UDim2.new(0.84, 0, 0, 45)
BtnWin.Font = Enum.Font.Gotham
BtnWin.Text = "▶️ AUTO WIN"
BtnWin.TextColor3 = Color3.new(1,1,1)
BtnWin.TextSize = 16
local c2 = Instance.new("UICorner", BtnWin)
c2.CornerRadius = UDim.new(0,8)

-- Botón Cintas Gratis
local BtnTreads = Instance.new("TextButton")
BtnTreads.Parent = Main
BtnTreads.BackgroundColor3 = Color3.fromRGB(80, 50, 130)
BtnTreads.BorderSizePixel = 0
BtnTreads.Position = UDim2.new(0.08, 0, 0.62, 0)
BtnTreads.Size = UDim2.new(0.84, 0, 0, 45)
BtnTreads.Font = Enum.Font.GothamBold
BtnTreads.Text = "💎 CINTAS GRATIS"
BtnTreads.TextColor3 = Color3.new(1,1,1)
BtnTreads.TextSize = 16
local c3 = Instance.new("UICorner", BtnTreads)
c3.CornerRadius = UDim.new(0,8)

-- =============================================
-- FUNCIONES REALES
-- =============================================

-- 🔓 DESBLOQUEAR CINTAS
local function DesbloquearCintas()
    pcall(function()
        -- Buscar en Leaderstats
        local leaderstats = Player:FindFirstChild("leaderstats")
        if leaderstats then
            for _, stat in pairs(leaderstats:GetChildren()) do
                if stat.Name:lower():find("tread") or stat.Name:lower():find("unlock") then
                    stat.Value = true
                end
            end
        end
        
        -- Buscar en Workspace las cintas
        for _, obj in pairs(workspace:GetChildren()) do
            if obj.Name:lower():find("treadmill") or obj.Name:lower():find("cinta") then
                if obj:FindFirstChild("Locked") then obj.Locked.Value = false end
                if obj:FindFirstChild("Owned") then obj.Owned.Value = true end
                if obj:FindFirstChild("Price") then obj.Price.Value = 0 end
            end
        end
        
        -- Buscar en GUI
        for _, gui in pairs(Player.PlayerGui:GetChildren()) do
            for _, item in pairs(gui:GetDescendants()) do
                if item.Name:lower():find("locked") then item.Value = false end
                if item.Name:lower():find("owned") then item.Value = true end
            end
        end
        
        BtnTreads.Text = "✅ DESBLOQUEADO!"
        BtnTreads.BackgroundColor3 = Color3.fromRGB(30, 140, 70)
        wait(2)
        BtnTreads.Text = "💎 CINTAS GRATIS"
        BtnTreads.BackgroundColor3 = Color3.fromRGB(80, 50, 130)
    end)
end

-- ⚡ AUTO FARM (Presionar teclas automático)
local function ActivarAutoFarm()
    AutoFarm = not AutoFarm
    if AutoFarm then
        BtnFarm.Text = "⏸️ AUTO FARM (ON)"
        BtnFarm.BackgroundColor3 = Color3.fromRGB(130, 30, 30)
        
        -- Simular presionar W y espacio constantemente
        spawn(function()
            while AutoFarm do
                VirtualUser:CaptureController()
                VirtualUser:PressKey(Enum.KeyCode.W, true)
                VirtualUser:PressKey(Enum.KeyCode.Space, true)
                wait(0.05)
                Humanoid.WalkSpeed = 500
                Humanoid.JumpPower = 100
                wait(0.05)
            end
        end)
    else
        BtnFarm.Text = "▶️ AUTO FARM"
        BtnFarm.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
        VirtualUser:ReleaseKey(Enum.KeyCode.W)
        VirtualUser:ReleaseKey(Enum.KeyCode.Space)
        Humanoid.WalkSpeed = 16
        Humanoid.JumpPower = 50
    end
end

-- 🏁 AUTO WIN (Teletransportarse al final)
local function ActivarAutoWin()
    AutoWin = not AutoWin
    if AutoWin then
        BtnWin.Text = "⏸️ AUTO WIN (ON)"
        BtnWin.BackgroundColor3 = Color3.fromRGB(130, 30, 30)
        
        spawn(function()
            while AutoWin do
                wait(0.5)
                -- Buscar la meta
                local Meta = workspace:FindFirstChildWhichIsA("Part", true)
                for _, parte in pairs(workspace:GetDescendants()) do
                    if parte.Name:lower():find("finish") or parte.Name:lower():find("end") or parte.Name:lower():find("win") then
                        Meta = parte
                        break
                    end
                end
                if Meta then
                    HumanoidRootPart.CFrame = CFrame.new(Meta.Position + Vector3.new(0, 5, 0))
                end
                wait(1)
            end
        end)
    else
        BtnWin.Text = "▶️ AUTO WIN"
        BtnWin.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    end
end

-- =============================================
-- CONECTAR BOTONES
-- =============================================
BtnFarm.MouseButton1Click:Connect(ActivarAutoFarm)
BtnWin.MouseButton1Click:Connect(ActivarAutoWin)
BtnTreads.MouseButton1Click:Connect(DesbloquearCintas)

print("✅ Script cargado y listo!")
