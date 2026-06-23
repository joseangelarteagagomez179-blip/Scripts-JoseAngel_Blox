-- Servicios
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- ===== VARIABLES =====
local autoSpeedActivado = true
local cantidadAumentar = 10
local godModeActivado = true
local autoWinActivado = false
local unlockAllActivado = false
local unlockItemsActivado = false -- Nueva variable

-- ===== AUTO SPEED / AUTO RUN =====
spawn(function()
    while task.wait(0.1) do
        if autoSpeedActivado and humanoid then
            humanoid.WalkSpeed = humanoid.WalkSpeed + cantidadAumentar
        end
    end
end)

-- ===== GOD MODE =====
spawn(function()
    while task.wait(0.1) do
        if godModeActivado and humanoid then
            humanoid.Health = humanoid.MaxHealth
        end
    end
end)

-- ===== AUTO WIN =====
spawn(function()
    while task.wait(0.5) do
        if autoWinActivado then
            for _, objeto in pairs(Workspace:GetChildren()) do
                if string.find(string.lower(objeto.Name), "win") or string.find(string.lower(objeto.Name), "finish") or string.find(string.lower(objeto.Name), "complete") or string.find(string.lower(objeto.Name), "next") then
                    if objeto:IsA("ClickDetector") then
                        fireclickdetector(objeto)
                    elseif objeto:IsA("Part") or objeto:IsA("Model") then
                        pcall(function()
                            character.HumanoidRootPart.CFrame = objeto.CFrame + Vector3.new(0,2,0)
                        end)
                    end
                end
            end
        end
        task.wait(1)
    end
end)

-- ===== UNLOCK ALL / DESBLOQUEAR CAMINADORAS =====
spawn(function()
    while task.wait(1) do
        if unlockAllActivado then
            for _, objeto in pairs(Workspace:GetDescendants()) do
                if string.find(string.lower(objeto.Name), "treadmill") or string.find(string.lower(objeto.Name), "walk") or string.find(string.lower(objeto.Name), "tread") or string.find(string.lower(objeto.Name), "machine") or string.find(string.lower(objeto.Name), "locked") or string.find(string.lower(objeto.Name), "blocked") then
                    pcall(function()
                        if objeto:IsA("Part") or objeto:IsA("Model") then
                            objeto.CanCollide = false
                            objeto.Transparency = 0.5
                        end
                        if objeto:FindFirstChild("RequiredLevel") then objeto.RequiredLevel.Value = 1 end
                        if objeto:FindFirstChild("Price") then objeto.Price.Value = 0 end
                        if objeto:FindFirstChildOfClass("ClickDetector") then fireclickdetector(objeto.ClickDetector) end
                    end)
                end
            end
        end
    end
end)

-- ===== DESBLOQUEAR AURAS Y RASTROS =====
spawn(function()
    while task.wait(1) do
        if unlockItemsActivado then
            -- Busca en todo el juego objetos que sean Auras, Trails, Effects
            for _, objeto in pairs(Workspace:GetDescendants()) do
                if string.find(string.lower(objeto.Name), "aura") or string.find(string.lower(objeto.Name), "trail") or string.find(string.lower(objeto.Name), "effect") or string.find(string.lower(objeto.Name), "rastro") then
                    pcall(function()
                        -- Quita requisitos
                        if objeto:FindFirstChild("RequiredLevel") then objeto.RequiredLevel.Value = 1 end
                        if objeto:FindFirstChild("Price") then objeto.Price.Value = 0 end
                        -- Si se pueden equipar automáticamente
                        if objeto:FindFirstChildOfClass("ClickDetector") then
                            fireclickdetector(objeto.ClickDetector)
                        end
                    end)
                end
            end
            
            -- También busca en la GUI de la tienda y compra todo
            pcall(function()
                for _, gui in pairs(player.PlayerGui:GetDescendants()) do
                    if gui:IsA("TextButton") or gui:IsA("ImageButton") then
                        if string.find(string.lower(gui.Name), "buy") or string.find(string.lower(gui.Name), "equip") or string.find(string.lower(gui.Name), "aura") or string.find(string.lower(gui.Name), "trail") then
                            fireclickdetector(gui)
                        end
                    end
                end
            end)
        end
    end
end)

-- ===== MENU PARA ANDROID Y PC (GUI) =====
local PlayerGui = player:WaitForChild("PlayerGui")

-- Crear pantalla
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local BtnSpeed = Instance.new("TextButton")
local BtnGod = Instance.new("TextButton")
local BtnAutoWin = Instance.new("TextButton")
local BtnUnlockAll = Instance.new("TextButton")
local BtnUnlockItems = Instance.new("TextButton") -- Nuevo botón

-- Propiedades de la ventana
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 330) -- Más grande
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "MI SCRIPT"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16

-- Botón Auto Speed
BtnSpeed.Parent = MainFrame
BtnSpeed.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
BtnSpeed.Position = UDim2.new(0.05, 0, 0.15, 0)
BtnSpeed.Size = UDim2.new(0.9, 0, 0, 35)
BtnSpeed.Font = Enum.Font.GothamBold
BtnSpeed.Text = "AUTO SPEED: ON"
BtnSpeed.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnSpeed.TextSize = 13

-- Botón God Mode
BtnGod.Parent = MainFrame
BtnGod.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
BtnGod.Position = UDim2.new(0.05, 0, 0.28, 0)
BtnGod.Size = UDim2.new(0.9, 0, 0, 35)
BtnGod.Font = Enum.Font.GothamBold
BtnGod.Text = "GOD MODE: ON"
BtnGod.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnGod.TextSize = 13

-- Botón Auto Win
BtnAutoWin.Parent = MainFrame
BtnAutoWin.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
BtnAutoWin.Position = UDim2.new(0.05, 0, 0.41, 0)
BtnAutoWin.Size = UDim2.new(0.9, 0, 0, 35)
BtnAutoWin.Font = Enum.Font.GothamBold
BtnAutoWin.Text = "AUTO WIN: OFF"
BtnAutoWin.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnAutoWin.TextSize = 13

-- Botón Desbloquear Caminadoras
BtnUnlockAll.Parent = MainFrame
BtnUnlockAll.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
BtnUnlockAll.Position = UDim2.new(0.05, 0, 0.54, 0)
BtnUnlockAll.Size = UDim2.new(0.9, 0, 0, 35)
BtnUnlockAll.Font = Enum.Font.GothamBold
BtnUnlockAll.Text = "DESBLOQ. MAQUINAS: OFF"
BtnUnlockAll.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnUnlockAll.TextSize = 12

-- Botón Desbloquear Auras y Rastros (NUEVO)
BtnUnlockItems.Parent = MainFrame
BtnUnlockItems.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
BtnUnlockItems.Position = UDim2.new(0.05, 0, 0.67, 0)
BtnUnlockItems.Size = UDim2.new(0.9, 0, 0, 35)
BtnUnlockItems.Font = Enum.Font.GothamBold
BtnUnlockItems.Text = "AURAS Y RASTROS: OFF"
BtnUnlockItems.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnUnlockItems.TextSize = 12

-- ===== FUNCIONES DE LOS BOTONES =====
BtnSpeed.MouseButton1Click:Connect(function()
    autoSpeedActivado = not autoSpeedActivado
    BtnSpeed.BackgroundColor3 = autoSpeedActivado and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
    BtnSpeed.Text = "AUTO SPEED: " .. (autoSpeedActivado and "ON" or "OFF")
end)

BtnGod.MouseButton1Click:Connect(function()
    godModeActivado = not godModeActivado
    BtnGod.BackgroundColor3 = godModeActivado and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
    BtnGod.Text = "GOD MODE: " .. (godModeActivado and "ON" or "OFF")
end)

BtnAutoWin.MouseButton1Click:Connect(function()
    autoWinActivado = not autoWinActivado
    BtnAutoWin.BackgroundColor3 = autoWinActivado and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
    BtnAutoWin.Text = "AUTO WIN: " .. (autoWinActivado and "ON" or "OFF")
end)

BtnUnlockAll.MouseButton1Click:Connect(function()
    unlockAllActivado = not unlockAllActivado
    BtnUnlockAll.BackgroundColor3 = unlockAllActivado and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
    BtnUnlockAll.Text = "DESBLOQ. MAQUINAS: " .. (unlockAllActivado and "ON" or "OFF")
end)

BtnUnlockItems.MouseButton1Click:Connect(function()
    unlockItemsActivado = not unlockItemsActivado
    BtnUnlockItems.BackgroundColor3 = unlockItemsActivado and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
    BtnUnlockItems.Text = "AURAS Y RASTROS: " .. (unlockItemsActivado and "ON" or "OFF")
end)

-- ===== TECLAS PARA PC =====
UIS.InputBegan:Connect(function(input, gameProcesado)
    if not gameProcesado then
        if input.KeyCode == Enum.KeyCode.A then
            BtnSpeed.MouseButton1Click:Fire()
        elseif input.KeyCode == Enum.KeyCode.G then
            BtnGod.MouseButton1Click:Fire()
        elseif input.KeyCode == Enum.KeyCode.W then
            BtnAutoWin.MouseButton1Click:Fire()
        elseif input.KeyCode == Enum.KeyCode.U then
            BtnUnlockAll.MouseButton1Click:Fire()
        elseif input.KeyCode == Enum.KeyCode.I then -- Tecla I para Auras y Rastros
            BtnUnlockItems.MouseButton1Click:Fire()
        end
    end
end)
