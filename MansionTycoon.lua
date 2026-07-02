-- PANEL DE CONTROL ZAPIA PARA MANSION TYCOON
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local AutoCollectBtn = Instance.new("TextButton")
local AutoBuyBtn = Instance.new("TextButton")

-- Configuración visual del panel
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
MainFrame.Name = "ZapiaPanel"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 250)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Text = "ZAPIA TYCOON"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

-- Botón Auto-Recoger
AutoCollectBtn.Parent = MainFrame
AutoCollectBtn.Text = "Auto Recoger: OFF"
AutoCollectBtn.Position = UDim2.new(0, 10, 0, 60)
AutoCollectBtn.Size = UDim2.new(0, 180, 0, 40)
AutoCollectBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)

-- Botón Auto-Comprar
AutoBuyBtn.Parent = MainFrame
AutoBuyBtn.Text = "Auto Comprar: OFF"
AutoBuyBtn.Position = UDim2.new(0, 10, 0, 110)
AutoBuyBtn.Size = UDim2.new(0, 180, 0, 40)
AutoBuyBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)

-- Lógica de funcionamiento
local autoCollectActive = false
local autoBuyActive = false

AutoCollectBtn.MouseButton1Click:Connect(function()
    autoCollectActive = not autoCollectActive
    AutoCollectBtn.Text = "Auto Recoger: " .. (autoCollectActive and "ON" or "OFF")
    AutoCollectBtn.BackgroundColor3 = autoCollectActive and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(100, 0, 0)
end)

AutoBuyBtn.MouseButton1Click:Connect(function()
    autoBuyActive = not autoBuyActive
    AutoBuyBtn.Text = "Auto Comprar: " .. (autoBuyActive and "ON" or "OFF")
    AutoBuyBtn.BackgroundColor3 = autoBuyActive and Color3.fromRGB(0, 100, 0) or Color3.fromRGB(100, 0, 0)
end)

-- Bucle principal del script
spawn(function()
    while true do
        wait(1)
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            -- Lógica para recoger dinero
            if autoCollectActive then
                for _, obj in pairs(game.Workspace:GetDescendants()) do
                    if obj.Name == "Collect" or obj.Name == "Giver" then
                        firetouchinterest(character.HumanoidRootPart, obj, 0)
                        firetouchinterest(character.HumanoidRootPart, obj, 1)
                    end
                end
            end
            -- Lógica para comprar botones
            if autoBuyActive then
                for _, btn in pairs(game.Workspace:GetDescendants()) do
                    if btn.Name == "Button" and btn:FindFirstChild("TouchInterest") then
                        firetouchinterest(character.HumanoidRootPart, btn, 0)
                        firetouchinterest(character.HumanoidRootPart, btn, 1)
                    end
                end
            end
        end
    end
end)
