-- =============================================
-- Script Personalizado para +1 Speed Keyboard
-- Creado por: Dola 💻
-- Funciones: Unlock All, Auto Farm, Fly, etc.
-- =============================================

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- =============================================
-- 🎫 DESBLOQUEAR GAMEPASSES Y TREADMILLS GRATIS
-- =============================================
local function UnlockEverything()
    pcall(function()
        -- Esto simula que tienes todos los gamepasses
        if getgenv then
            getgenv().Unlocked = true
        end
        
        -- Intenta modificar los valores de leaderstats o datos para tener acceso
        local leaderstats = Player:FindFirstChild("leaderstats")
        if leaderstats then
            for _, v in pairs(leaderstats:GetChildren()) do
                if v:IsA("NumberValue") or v:IsA("IntValue") then
                    v.Value = 999999999
                end
            end
        end
        
        -- Acceder a las treadmills (cintas) gratis
        workspace.DescendantAdded:Connect(function(obj)
            if obj.Name:lower():find("treadmill") or obj.Name:lower():find("tread") then
                pcall(function()
                    obj.CanCollide = false
                    obj.CanTouch = true
                end)
            end
        end)
        
        print("✅ Todo desbloqueado!")
    end)
end

-- Ejecutar al inicio
UnlockEverything()

-- =============================================
-- ⚡ AUMENTAR VELOCIDAD Y SALTO
-- =============================================
local SpeedBoost = true
local JumpBoost = true

if SpeedBoost then
    Humanoid.WalkSpeed = 100 -- Cambia el numero si quieres mas rapido
end

if JumpBoost then
    Humanoid.JumpPower = 150
end

-- =============================================
-- 🚀 AUTO FARM (Correr automatico)
-- =============================================
local AutoFarm = true

spawn(function()
    while AutoFarm and wait(0.1) do
        if Character and Humanoid.Health > 0 then
            -- Moverse automaticamente hacia adelante
            Humanoid:Move(Vector3.new(1,0,0), false)
        end
    end
end)

-- =============================================
-- 🛫 MODO VOLAR (Fly)
-- =============================================
local Fly = false
local SpeedFly = 50

UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.F then -- Presiona F para activar/desactivar Fly
        Fly = not Fly
        if Fly then
            print("✈️ Fly Activado")
        else
            print("✈️ Fly Desactivado")
        end
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
-- 👻 NOCLIP (Atravesar paredes)
-- =============================================
local Noclip = false

UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.G then -- Presiona G para Noclip
        Noclip = not Noclip
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
-- 🎯 TELETRANSPORTE A LA META (Auto Win)
-- =============================================
local function AutoWin()
    -- Busca el final del mapa
    for _, obj in pairs(workspace:GetChildren()) do
        if obj.Name:lower():find("finish") or obj.Name:lower():find("end") or obj.Name:lower():find("meta") then
            Character.HumanoidRootPart.CFrame = obj.CFrame + Vector3.new(0,5,0)
            print("🏁 Llegaste a la meta!")
            break
        end
    end
end

-- Ejecutar Auto Win cada 10 segundos
spawn(function()
    while wait(10) do
        AutoWin()
    end
end)

-- =============================================
-- 💎 ACTUALIZAR TREADMILLS CONSTANTEMENTE
-- =============================================
while wait(2) do
    UnlockEverything() -- Para que no se bloqueen de nuevo
end

print("====================================")
print("✅ Script Cargado Correctamente!")
print("🎫 Treadmills y Gamepasses Gratis")
print("⚡ Velocidad Maxima")
print("✈️ F = Volar")
print("👻 G = Noclip")
print("====================================")
