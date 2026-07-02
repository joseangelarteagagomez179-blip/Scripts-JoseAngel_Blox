-- VERSIÓN MEJORADA (BÚSQUEDA AUTOMÁTICA)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local AutoCollectBtn = Instance.new("TextButton")
local AutoBuyBtn = Instance.new("TextButton")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 200)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Text = "ZAPIA REPARADO"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(70, 70, 70)

AutoCollectBtn.Parent = MainFrame
AutoCollectBtn.Text = "AUTO-DINERO: OFF"
AutoCollectBtn.Position = UDim2.new(0, 10, 0, 60)
AutoCollectBtn.Size = UDim2.new(0, 180, 0, 50)
AutoCollectBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)

AutoBuyBtn.Parent = MainFrame
AutoBuyBtn.Text = "AUTO-COMPRAR: OFF"
AutoBuyBtn.Position = UDim2.new(0, 10, 0, 120)
AutoBuyBtn.Size = UDim2.new(0, 180, 0, 50)
AutoBuyBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)

local autoCollect = false
local autoBuy = false

AutoCollectBtn.MouseButton1Click:Connect(function()
    autoCollect = not autoCollect
    AutoCollectBtn.Text = "AUTO-DINERO: " .. (autoCollect and "ON" or "OFF")
    AutoCollectBtn.BackgroundColor3 = autoCollect and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(150, 50, 50)
end)

AutoBuyBtn.MouseButton1Click:Connect(function()
    autoBuy = not autoBuy
    AutoBuyBtn.Text = "AUTO-COMPRAR: " .. (autoBuy and "ON" or "OFF")
    AutoBuyBtn.BackgroundColor3 = autoBuy and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(150, 50, 50)
end)

-- Bucle de ejecución
spawn(function()
    while wait(0.5) do
        local p = game.Players.LocalPlayer
        local char = p.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            -- Búsqueda de Dinero
            if autoCollect then
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    -- Busca partes que tengan "Collect" o "Giver" en el nombre
                    if (v.Name:find("Collect") or v.Name:find("Giver") or v.Name:find("Cash")) and v:IsA("BasePart") then
                        firetouchinterest(char.HumanoidRootPart, v, 0)
                        firetouchinterest(char.HumanoidRootPart, v, 1)
                    end
                end
            end
            -- Búsqueda de Botones de Compra
            if autoBuy then
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    -- Busca botones que tengan un detector de toque (TouchInterest)
                    if (v.Name:find("Button") or v.Name:find("Buy")) and v:FindFirstChild("TouchInterest") then
                        firetouchinterest(char.HumanoidRootPart, v, 0)
                        firetouchinterest(char.HumanoidRootPart, v, 1)
                    end
                end
            end
        end
    end
end)
