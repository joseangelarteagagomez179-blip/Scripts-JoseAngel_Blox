--// SERVICES
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local WS = game:GetService("Workspace")
local RS = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HRP = Character:WaitForChild("HumanoidRootPart")

--// VARIABLES (OPTIMIZADAS)
local Enabled = false
local AutoWin = false
local AutoRebirth = false
local GodMode = false
local OldSpeed = Humanoid.WalkSpeed
local OldJump = Humanoid.JumpPower

-- =============================================
--              FUNCIONES REALES
-- =============================================

-- AUTO WIN (Presiona teclas rápido y sin lag)
spawn(function()
    while wait() do
        if AutoWin then
            UIS:SendKeyDownPressed(Enum.KeyCode.W, false, false)
            UIS:SendKeyUpReleased(Enum.KeyCode.W, false, false)
            UIS:SendKeyDownPressed(Enum.KeyCode.A, false, false)
            UIS:SendKeyUpReleased(Enum.KeyCode.A, false, false)
            UIS:SendKeyDownPressed(Enum.KeyCode.S, false, false)
            UIS:SendKeyUpReleased(Enum.KeyCode.S, false, false)
            UIS:SendKeyDownPressed(Enum.KeyCode.D, false, false)
            UIS:SendKeyUpReleased(Enum.KeyCode.D, false, false)
            wait(0.05)
        end
    end
end)

-- AUTO REBIRTH
spawn(function()
    while wait(3) do
        if AutoRebirth then
            pcall(function()
                for _, v in pairs(WS:GetDescendants()) do
                    if v:IsA("ClickDetector") and v.Parent.Name:lower():find("rebirth") then
                        fireclickdetector(v)
                    end
                end
            end)
        end
    end
end)

-- GOD MODE
spawn(function()
    while wait(1) do -- Solo revisa cada segundo, NO da lag
        if GodMode then
            Humanoid.Health = Humanoid.MaxHealth
        end
    end
end)

-- REMOVER OBSTACULOS (Una sola vez)
local function ClearObs()
    for _, v in pairs(WS:GetDescendants()) do
        if v:IsA("Part") and (v.Name:lower():find("wall") or v.Name:lower():find("obstacle")) then
            v.CanCollide = false
            v.Transparency = 1
        end
    end
end

-- AUTO SPEED (TP a maquina)
local function SpeedUp()
    Humanoid.WalkSpeed = 1000
    Humanoid.JumpPower = 200
    pcall(function()
        local Tm = WS.Treadmills:GetChildren()
        HRP.CFrame = Tm[#Tm].CFrame + Vector3.new(0,5,0)
    end)
end

-- =============================================
--              MENU MOVIL Y PC
-- =============================================
local Gui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Title = Instance.new("TextLabel")

Gui.Parent = game:GetService("CoreGui")
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Global

Main.Parent = Gui
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.Position = UDim2.new(0.02, 0, 0.2, 0)
Main.Size = UDim2.new(0, 300, 0, 420)
Main.Active = true
Main.Draggable = true -- SE PUEDE MOVER CON EL DEDO O MOUSE
Main.BorderSizePixel = 2

Title.Parent = Main
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "⚡ HOSHI HUB | OPTIMIZED"
Title.TextColor3 = Color3.new(1,1,1)
Title.TextSize = 16

-- =============================================
--              BOTONES GRANDES
-- =============================================
local Y = 50
local function Btn(Name, Color, Func)
    local Button = Instance.new("TextButton")
    Button.Parent = Main
    Button.BackgroundColor3 = Color
    Button.Position = UDim2.new(0, 10, 0, Y)
    Button.Size = UDim2.new(0, 280, 0, 45) -- BOTONES GRANDES PARA CELULAR
    Button.Font = Enum.Font.GothamBold
    Button.Text = Name
    Button.TextColor3 = Color3.new(1,1,1)
    Button.TextSize = 14
    Button.MouseButton1Click:Connect(Func)
    Y = Y + 52
end

-- LISTA DE BOTONES
Btn("🎹 AUTO WIN", Color3.fromRGB(200, 50, 50), function()
    AutoWin = not AutoWin
end)

Btn("⚡ VELOCIDAD MAX", Color3.fromRGB(50, 150, 200), SpeedUp)

Btn("🔄 AUTO REBIRTH", Color3.fromRGB(100, 50, 200), function()
    AutoRebirth = not AutoRebirth
end)

Btn("🧱 QUITAR PAREDES", Color3.fromRGB(80, 80, 80), ClearObs)

Btn("🛡️ GOD MODE", Color3.fromRGB(255, 200, 0), function()
    GodMode = not GodMode
end)

Btn("🛒 COMPRAR TODO", Color3.fromRGB(0, 180, 0), function()
    for _, v in pairs(Player.PlayerGui:GetDescendants()) do
        if v:IsA("ClickDetector") and v.Parent.Name:lower():find("buy") then
            fireclickdetector(v)
        end
    end
end)

Btn("🔙 RESTAURAR", Color3.fromRGB(50, 50, 50), function()
    Humanoid.WalkSpeed = OldSpeed
    Humanoid.JumpPower = OldJump
    AutoWin = false
    AutoRebirth = false
    GodMode = false
end)

-- =============================================
--              TECLAS RAPIDAS (PC)
-- =============================================
UIS.InputBegan:Connect(function(k)
    if k.KeyCode == Enum.KeyCode.LeftControl then SpeedUp() end
    if k.KeyCode == Enum.KeyCode.Delete then
        Humanoid.WalkSpeed = OldSpeed
        Humanoid.JumpPower = OldJump
    end
end)

print("✅ SCRIPT CARGADO | OPTIMIZADO | SIN LAG")
