-- =============================================
-- 🎮 SCRIPT PERSONALIZADO | +1 Speed Keyboard
-- ✅ TREADMILLS 100% DESBLOQUEADAS
-- =============================================

-- Servicios
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- =============================================
-- 🎨 CREAR INTERFAZ (MENU)
-- =============================================

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "MenuDola"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

-- Marco Principal
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
MainFrame.BorderColor3 = Color3.new(1, 0.4, 0.6)
MainFrame.BorderSizePixel = 2
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 260, 0, 380)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true

-- Titulo
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
Title.Size = UDim2.new(1, -10, 0, 40)
Title.Position = UDim2.new(0, 5, 0, 5)
Title.Font = Enum.Font.GothamBold
Title.Text = "🍫 MENU SPEED KEYBOARD"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 18

-- =============================================
-- 🔘 CREAR BOTONES
-- =============================================

local Buttons = {}
local YPos = 55

local function MakeButton(name, color)
    local btn = Instance.new("TextButton")
    btn.Parent = MainFrame
    btn.BackgroundColor3 = color
    btn.Size = UDim2.new(1, -10, 0, 45)
    btn.Position = UDim2.new(0, 5, 0, YPos)
    btn.Font = Enum.Font.GothamBold
    btn.Text = name
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextSize = 16
    btn.AutoLocalize = false
    YPos = YPos + 55
    return btn
end

local ButtonUnlocked = MakeButton("🔓 UNLOCK ALL", Color3.new(0.2, 0.6, 0.2))
local ButtonAutoRun = MakeButton("🏃 AUTO RUN", Color3.new(0.6, 0.2, 0.2))
local ButtonFly = MakeButton("✈️ FLY MODE", Color3.new(0.2, 0.4, 0.6))
local ButtonNoclip = MakeButton("👻 NOCLIP", Color3.new(0.4, 0.2, 0.6))
local ButtonAutoWin = MakeButton("🏁 AUTO WIN", Color3.new(0.6, 0.4, 0.2))

-- =============================================
-- ⚙️ VARIABLES
-- =============================================
local UnlockedAll = false
local AutoRun = false
local Fly = false
local Noclip = false
local AutoWin = false
local SpeedFly = 50

-- =============================================
-- 🎫 FUNCION: DESBLOQUEAR TREADMILLS (CORREGIDA)
-- =============================================
ButtonUnlocked.MouseButton1Click:Connect(function()
    UnlockedAll = not UnlockedAll
    if UnlockedAll then
        ButtonUnlocked.Text = "✅ TODO DESBLOQUEADO"
        ButtonUnlocked.BackgroundColor3 = Color3.new(0,1,0)
        
        -- 1. Simular que tenemos todos los gamepasses
        if getgenv then
            getgenv().HasAllPasses = true
            getgenv().Unlocked = true
        end
        
        -- 2. Buscar TODAS las treadmills y forzar su activacion
        workspace.DescendantAdded:Connect(function(obj)
            if obj:IsA("ClickDetector") or obj:IsA("ProximityPrompt") or obj.Name:lower():find("treadmill") then
                local parent = obj.Parent
                if parent then
                    -- Eliminar bloqueos
                    for _, v in pairs(parent:GetChildren()) do
                        if v.Name:lower():find("lock") or v.Name:lower():find("required") or v.Name:lower():find("price") then
                            v:Destroy()
                        end
                        if v:IsA("BoolValue") or v:IsA("IntValue") then
                            v.Value = true
                        end
                    end
                    -- Hacerlas clickeables
                    if parent:FindFirstChildOfClass("ClickDetector") then
                        parent.ClickDetector.MaxActivationDistance = 100
                    end
                end
            end
        end)

        -- 3. Hacer lo mismo con las que ya existen
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name:lower():find("treadmill") or obj.Name:lower():find("cinta") then
                pcall(function()
                    -- Destruir candados y requisitos
                    for _, child in pairs(obj:GetChildren()) do
                        if child.Name:lower():find("lock") or child.Name:lower():find("required") then
                            child:Destroy()
                        end
                        if child:IsA("BoolValue") or child:IsA("IntValue") then
                            child.Value = 999999
                        end
                    end
                    
                    -- Hacer que se puedan usar
                    obj.CanCollide = false
                    obj.CanTouch = true
                    
                    -- Si tiene prompt, activarlo
                    local prompt = obj:FindFirstChildOfClass("ProximityPrompt")
                    if prompt then
                        prompt.Enabled = true
                        prompt.HoldDuration = 0.1
                    end
                end)
            end
        end

        -- 4. Dar dinero infinito por si acaso
        pcall(function()
            local leaderstats = Player:FindFirstChild("leaderstats")
            if leaderstats then
                for _, v in pairs(leaderstats:GetChildren()) do
                    if v:IsA("NumberValue") or v:IsA("IntValue") then
                        v.Value = 99999999999
                    end
                end
            end
        end)

        print("✅ TREADMILLS DESBLOQUEADAS!")
    else
        ButtonUnlocked.Text = "🔓 UNLOCK ALL"
        ButtonUnlocked.BackgroundColor3 = Color3.new(0.2, 0.6, 0.2)
    end
end)

-- =============================================
-- 🏃 AUTO RUN
-- =============================================
ButtonAutoRun.MouseButton1Click:Connect(function()
    AutoRun = not AutoRun
    if AutoRun then
        ButtonAutoRun.Text = "🛑 PARAR AUTO RUN"
        ButtonAutoRun.BackgroundColor3 = Color3.new(1,0,0)
        spawn(function()
            while AutoRun and task.wait(0.1) do
                if Humanoid and Humanoid.Health > 0 then
                    Humanoid:Move(Vector3.new(1,0,0), false)
                end
            end
        end)
    else
        ButtonAutoRun.Text = "🏃 AUTO RUN"
        ButtonAutoRun.BackgroundColor3 = Color3.new(0.6, 0.2, 0.2)
    end
end)

-- =============================================
-- ✈️ FLY
-- =============================================
ButtonFly.MouseButton1Click:Connect(function()
    Fly = not Fly
    if Fly then
        ButtonFly.Text = "✈️ FLY ON"
        ButtonFly.BackgroundColor3 = Color3.new(0,0.8,1)
    else
        ButtonFly.Text = "✈️ FLY MODE"
        ButtonFly.BackgroundColor3 = Color3.new(0.2, 0.4, 0.6)
    end
end)

RunService.RenderStepped:Connect(function()
    if Fly and Humanoid then
        Humanoid.PlatformStand = true
        Humanoid.Sit = true
        local CamCF = workspace.CurrentCamera.CFrame
        local Direction = Vector3.new()
        
        if UIS:IsKeyDown(Enum.KeyCode.W) then Direction += CamCF.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then Direction += -CamCF.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then Direction += -CamCF.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then Direction += CamCF.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then Direction += -CamCF.UpVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then Direction += CamCF.UpVector end
        
        Character.HumanoidRootPart.Velocity = Direction * SpeedFly
    end
end)

-- =============================================
-- 👻 NOCLIP
-- =============================================
ButtonNoclip.MouseButton1Click:Connect(function()
    Noclip = not Noclip
    if Noclip then
        ButtonNoclip.Text = "👻 NOCLIP ON"
        ButtonNoclip.BackgroundColor3 = Color3.new(0.8,0,1)
    else
        ButtonNoclip.Text = "👻 NOCLIP"
        ButtonNoclip.BackgroundColor3 = Color3.new(0.4, 0.2, 0.6)
    end
end)

RunService.Stepped:Connect(function()
    if Noclip and Character then
        for _, part in pairs(Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- =============================================
-- 🏁 AUTO WIN
-- =============================================
ButtonAutoWin.MouseButton1Click:Connect(function()
    for _, obj in pairs(workspace:GetChildren()) do
        if obj.Name:lower():find("finish") or obj.Name:lower():find("end") or obj.Name:lower():find("meta") then
            Character.HumanoidRootPart.CFrame = obj.CFrame + Vector3.new(0,5,0)
            break
        end
    end
end)

-- =============================================
-- 💡 VELOCIDAD BASE
-- =============================================
Humanoid.WalkSpeed = 100
Humanoid.JumpPower = 150

print("✅ Script Listo! Dale a UNLOCK ALL")
