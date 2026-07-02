-- SCRIPT MANSION TYCOON DEFINITIVO (ZAPIA V4)
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")

-- Crear Interfaz
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CollectBtn = Instance.new("TextButton")
local BuyBtn = Instance.new("TextButton")

ScreenGui.Parent = player:WaitForChild("PlayerGui")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 2
MainFrame.Position = UDim2.new(0.05, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 160)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.Text = "ZAPIA: MANSION TYCOON"
Title.Size = UDim2.new(1, 0, 0, 35)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(100, 0, 255)

-- Botón de Recoger
CollectBtn.Parent = MainFrame
CollectBtn.Text = "RECOGER BUZÓN: OFF"
CollectBtn.Position = UDim2.new(0, 10, 0, 45)
CollectBtn.Size = UDim2.new(0, 200, 0, 45)
CollectBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 0)

-- Botón de Comprar
BuyBtn.Parent = MainFrame
BuyBtn.Text = "AUTO COMPRA: OFF"
BuyBtn.Position = UDim2.new(0, 10, 0, 100)
BuyBtn.Size = UDim2.new(0, 200, 0, 45)
BuyBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 0)

local collectOn = false
local buyOn = false

CollectBtn.MouseButton1Click:Connect(function()
    collectOn = not collectOn
    CollectBtn.Text = "RECOGER BUZÓN: " .. (collectOn and "ON" or "OFF")
    CollectBtn.BackgroundColor3 = collectOn and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(120, 0, 0)
end)

BuyBtn.MouseButton1Click:Connect(function()
    buyOn = not buyOn
    BuyBtn.Text = "AUTO COMPRA: " .. (buyOn and "ON" or "OFF")
    BuyBtn.BackgroundColor3 = buyOn and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(120, 0, 0)
end)

-- Bucle de funcionamiento (Escanea cada 0.3 segundos)
spawn(function()
    while wait(0.3) do
        -- 1. RECOGER DINERO (Usando tus datos: Collector -> Mailbox -> MeshPart)
        if collectOn then
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name == "MeshPart" and v.Parent and v.Parent.Name == "Mailbox" then
                    firetouchinterest(root, v, 0)
                    firetouchinterest(root, v, 1)
                end
            end
        end

        -- 2. COMPRAR BOTONES (Usando tus datos: Purchases -> Carpeta -> Part)
        if buyOn then
            for _, v in pairs(game.Workspace:GetDescendants()) do
                -- Si el objeto está dentro del grupo 'Purchases' y es un botón verde
                if v.Parent and v.Parent.Parent and v.Parent.Parent.Name == "Purchases" then
                    if v:IsA("BasePart") and v.Transparency < 1 and (v.Color == Color3.fromRGB(0, 255, 0) or v.Name == "Part") then
                        -- Solo lo toca si tiene detector de toque y no es de Robux
                        if v:FindFirstChildWhichIsA("TouchInterest") and not v.Parent:FindFirstChild("Robux") then
                            firetouchinterest(root, v, 0)
                            firetouchinterest(root, v, 1)
                        end
                    end
                end
            end
        end
    end
end)

print("¡Script Zapia V4 configurado y listo!")
