-- SCRIPT MANSION TYCOON V3 (BOTONES VERDES + BUZÓN)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local AutoCollectBtn = Instance.new("TextButton")
local AutoBuyBtn = Instance.new("TextButton")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.05, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 180)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Text = "ZAPIA: AUTO-BUILDER"
Title.Size = UDim2.new(1, 0, 0, 35)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(0, 200, 100)

AutoCollectBtn.Parent = MainFrame
AutoCollectBtn.Text = "RECOGER DINERO: OFF"
AutoCollectBtn.Position = UDim2.new(0, 10, 0, 50)
AutoCollectBtn.Size = UDim2.new(0, 200, 0, 50)
AutoCollectBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)

AutoBuyBtn.Parent = MainFrame
AutoBuyBtn.Text = "COMPRAR BOTONES: OFF"
AutoBuyBtn.Position = UDim2.new(0, 10, 0, 110)
AutoBuyBtn.Size = UDim2.new(0, 200, 0, 50)
AutoBuyBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)

local collectOn = false
local buyOn = false

AutoCollectBtn.MouseButton1Click:Connect(function()
    collectOn = not collectOn
    AutoCollectBtn.Text = "RECOGER DINERO: " .. (collectOn and "ON" or "OFF")
    AutoCollectBtn.BackgroundColor3 = collectOn and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(150, 50, 50)
end)

AutoBuyBtn.MouseButton1Click:Connect(function()
    buyOn = not buyOn
    AutoBuyBtn.Text = "COMPRAR BOTONES: " .. (buyOn and "ON" or "OFF")
    AutoBuyBtn.BackgroundColor3 = buyOn and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(150, 50, 50)
end)

-- Función para tocar botones
local function touch(part)
    local root = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if root and part then
        firetouchinterest(root, part, 0)
        firetouchinterest(root, part, 1)
    end
end

-- Bucle infinito de escaneo
spawn(function()
    while wait(0.3) do -- Más rápido para no perder botones
        if collectOn or buyOn then
            for _, v in pairs(game.Workspace:GetDescendants()) do
                -- RECOGER DEL BUZÓN
                if collectOn and (v.Name == "Mailbox" or v.Name == "Collector" or v.Name == "Giver") then
                    if v:IsA("BasePart") then touch(v) end
                end
                
                -- COMPRAR BOTONES VERDES (Como el de tu foto)
                if buyOn then
                    -- Detecta botones por su forma circular/cilíndrica y color verde
                    if v:IsA("BasePart") and v.Transparency < 1 then
                        -- Si el botón es verde y tiene un detector de toque
                        if (v.Color == Color3.fromRGB(0, 255, 0) or v.Name:lower():find("button")) and v:FindFirstChildWhichIsA("TouchInterest") then
                            -- Solo lo toca si no es un botón de Robux (evita gastos reales)
                            if not v.Parent:FindFirstChild("Robux") then
                                touch(v)
                            end
                        end
                    end
                end
            end
        end
    end
end)
