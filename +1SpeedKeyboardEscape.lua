-- Servicios
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

-- Variables
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local leaderstats = player:WaitForChild("leaderstats")
local stats = player:WaitForChild("Stats")

-- === CREAR GUI ===
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local UnlockAllBtn = Instance.new("TextButton")
local CloseBtn = Instance.new("TextButton")

ScreenGui.Name = "UltraHub"
ScreenGui.Parent = game.CoreGui

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
MainFrame.BorderColor3 = Color3.new(1, 0.5, 0)
MainFrame.BorderSizePixel = 3
MainFrame.Position = UDim2.new(0.35, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 320, 0, 220)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.new(1, 0.5, 0)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Font = Enum.Font.GothamBold
Title.Text = "💎 ULTRA HUB - TODO DESBLOQUEADO 💎"
Title.TextColor3 = Color3.new(0, 0, 0)
Title.TextSize = 16

UnlockAllBtn.Name = "UnlockAllBtn"
UnlockAllBtn.Parent = MainFrame
UnlockAllBtn.BackgroundColor3 = Color3.new(0, 0.7, 0.2)
UnlockAllBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
UnlockAllBtn.Size = UDim2.new(0.8, 0, 50, 0)
UnlockAllBtn.Font = Enum.Font.GothamBold
UnlockAllBtn.Text = "🔥 ACTIVAR TODO (Incl. Treadmills)"
UnlockAllBtn.TextColor3 = Color3.new(1, 1, 1)
UnlockAllBtn.TextSize = 15

CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundColor3 = Color3.new(0.8, 0.1, 0.1)
CloseBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
CloseBtn.Size = UDim2.new(0.8, 0, 40, 0)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "❌ CERRAR"
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.TextSize = 16

-- === FUNCIONES PRINCIPALES ===
local function unlockEverything()
    -- 1. DINERO Y STATS INFINITOS
    if leaderstats:FindFirstChild("Wins") then leaderstats.Wins.Value = 999999999 end
    if stats:FindFirstChild("Speed") then stats.Speed.Value = 999999 end
    if stats:FindFirstChild("Multiplier") then stats.Multiplier.Value = 99999 end
    if stats:FindFirstChild("Money") or stats:FindFirstChild("Coins") then 
        stats.Money.Value = 999999999 
    end

    -- 2. DESBLOQUEAR MUNDOS, TRAILS Y GAMEPASSES
    for _, folder in pairs(player:GetChildren()) do
        for _, item in pairs(folder:GetChildren()) do
            if item:IsA("BoolValue") then
                item.Value = true
            elseif item:IsA("IntValue") or item:IsA("NumberValue") then
                item.Value = item:GetAttribute("MaxValue") or 99999
            end
        end
    end

    -- 3. 💪 MEJORAR Y COMPRAR TODAS LAS TREADMILLS
    local workspace = game:GetService("Workspace")
    local machinesFolder = workspace:FindFirstChild("Machines") or workspace:FindFirstChild("Treadmills") or workspace

    for _, obj in pairs(machinesFolder:GetChildren()) do
        -- Buscar partes que parezcan máquinas o botones de compra
        if obj:FindFirstChild("ClickDetector") or obj.Name:lower():find("treadmill") or obj.Name:lower():find("machine") then
            
            -- Comprar/Desbloquear
            if obj:FindFirstChild("ClickDetector") then
                fireclickdetector(obj.ClickDetector)
            end

            -- Subir nivel al máximo
            if obj:FindFirstChild("Level") or obj:FindFirstChild("Upgrade") then
                for _, v in pairs(obj:GetChildren()) do
                    if v:IsA("IntValue") and v.Name ~= "Price" then
                        v.Value = 9999 -- Nivel Maximo
                    end
                end
            end
            
            -- Activar la cinta
            if obj:FindFirstChild("Enabled") or obj:FindFirstChild("Active") then
                obj.Enabled.Value = true
            end
        end
    end

    -- VELOCIDAD MAXIMA
    humanoid.WalkSpeed = 1000
    humanoid.JumpPower = 600

    -- MENSAJE FINAL
    StarterGui:SetCore("SendNotification", {
        Title = "✅ ¡LISTO!",
        Text = "Todo desbloqueado, Treadmills al maximo y dinero infinito!",
        Duration = 7
    })
end

-- AUTO CORRER
local autoRun = true
local function moveForward()
    if autoRun and humanoid then
        humanoid:Move(Vector3.new(0,0,-1), true)
    end
end
RunService.Heartbeat:Connect(moveForward)

-- EVENTOS
UnlockAllBtn.MouseButton1Click:Connect(unlockEverything)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

print("Hub Cargado!")
