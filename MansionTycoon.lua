-- 1. Crear la interfaz visual en tu pantalla de celular
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local AutoCollectBtn = Instance.new("TextButton")
local SpeedBtn = Instance.new("TextButton")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MansionMenu"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 180, 0, 130)
MainFrame.Active = true
MainFrame.Draggable = true -- Te permite mover el menú con el dedo

-- Botón 1: Recolectar de la Caja Fuerte automáticamente
AutoCollectBtn.Parent = MainFrame
AutoCollectBtn.Size = UDim2.new(0, 160, 0, 40)
AutoCollectBtn.Position = UDim2.new(0, 10, 0, 15)
AutoCollectBtn.Text = "Auto-Recolectar"
AutoCollectBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
AutoCollectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local autoCollecting = false
AutoCollectBtn.MouseButton1Click:Connect(function()
    autoCollecting = not autoCollecting
    if autoCollecting then
        AutoCollectBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        AutoCollectBtn.Text = "Recolectando..."
        task.spawn(function()
            while autoCollecting do
                -- Busca el recolector de dinero en el mapa y simula el toque
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    if v.Name == "Giver" or v.Name == "Collector" and v:IsA("TouchTransmitter") then
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 0)
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 1)
                    end
                end
                task.wait(1) -- Intervalo de recolección para evitar cierres del juego
            end
        end)
    else
        AutoCollectBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        AutoCollectBtn.Text = "Auto-Recolectar"
    end
end)

-- Botón 2: Súper Velocidad para recorrer la Mansión rápido
SpeedBtn.Parent = MainFrame
SpeedBtn.Size = UDim2.new(0, 160, 0, 40)
SpeedBtn.Position = UDim2.new(0, 10, 0, 70)
SpeedBtn.Text = "Velocidad x2"
SpeedBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local fastSpeed = false
SpeedBtn.MouseButton1Click:Connect(function()
    fastSpeed = not fastSpeed
    local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        if fastSpeed then
            hum.WalkSpeed = 50 -- Velocidad aumentada
            SpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
        else
            hum.WalkSpeed = 16 -- Velocidad normal de Roblox
            SpeedBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        end
    end
end)
