-- Script para Mansion Tycoon | Funcional y actualizado
-- Características: Auto Recolectar Dinero, Auto Comprar Mejoras, Teletransportes

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- Crear GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local AutoCollect = Instance.new("TextButton")
local AutoBuy = Instance.new("TextButton")
local TeleportMoney = Instance.new("TextButton")
local TeleportBuild = Instance.new("TextButton")

ScreenGui.Name = "MansionTycoonHub"
ScreenGui.Parent = Player.PlayerGui

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 250)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "🏰 Mansion Tycoon Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16

-- Auto Recolectar Dinero
AutoCollect.Name = "AutoCollect"
AutoCollect.Parent = MainFrame
AutoCollect.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
AutoCollect.BorderColor3 = Color3.fromRGB(0, 0, 0)
AutoCollect.Position = UDim2.new(0.05, 0, 0.15, 0)
AutoCollect.Size = UDim2.new(0.9, 0, 0, 30)
AutoCollect.Font = Enum.Font.Gotham
AutoCollect.Text = "💰 Auto Recolectar: OFF"
AutoCollect.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoCollect.TextSize = 14

local CollectEnabled = false
AutoCollect.MouseButton1Click:Connect(function()
    CollectEnabled = not CollectEnabled
    if CollectEnabled then
        AutoCollect.Text = "💰 Auto Recolectar: ON"
        AutoCollect.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    else
        AutoCollect.Text = "💰 Auto Recolectar: OFF"
        AutoCollect.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end
end)

-- Auto Comprar Mejoras
AutoBuy.Name = "AutoBuy"
AutoBuy.Parent = MainFrame
AutoBuy.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
AutoBuy.BorderColor3 = Color3.fromRGB(0, 0, 0)
AutoBuy.Position = UDim2.new(0.05, 0, 0.32, 0)
AutoBuy.Size = UDim2.new(0.9, 0, 0, 30)
AutoBuy.Font = Enum.Font.Gotham
AutoBuy.Text = "🛒 Auto Comprar: OFF"
AutoBuy.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoBuy.TextSize = 14

local BuyEnabled = false
AutoBuy.MouseButton1Click:Connect(function()
    BuyEnabled = not BuyEnabled
    if BuyEnabled then
        AutoBuy.Text = "🛒 Auto Comprar: ON"
        AutoBuy.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    else
        AutoBuy.Text = "🛒 Auto Comprar: OFF"
        AutoBuy.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end
end)

-- Teletransportes
TeleportMoney.Name = "TeleportMoney"
TeleportMoney.Parent = MainFrame
TeleportMoney.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
TeleportMoney.BorderColor3 = Color3.fromRGB(0, 0, 0)
TeleportMoney.Position = UDim2.new(0.05, 0, 0.49, 0)
TeleportMoney.Size = UDim2.new(0.9, 0, 0, 30)
TeleportMoney.Font = Enum.Font.Gotham
TeleportMoney.Text = "📍 Ir a Dinero"
TeleportMoney.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportMoney.TextSize = 14

TeleportMoney.MouseButton1Click:Connect(function()
    -- Busca la zona de dinero y teletransporta
    for _, v in pairs(workspace:GetChildren()) do
        if v.Name:lower():find("money") or v.Name:lower():find("cash") then
            HumanoidRootPart.CFrame = v.CFrame + Vector3.new(0, 3, 0)
            break
        end
    end
end)

TeleportBuild.Name = "TeleportBuild"
TeleportBuild.Parent = MainFrame
TeleportBuild.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
TeleportBuild.BorderColor3 = Color3.fromRGB(0, 0, 0)
TeleportBuild.Position = UDim2.new(0.05, 0, 0.66, 0)
TeleportBuild.Size = UDim2.new(0.9, 0, 0, 30)
TeleportBuild.Font = Enum.Font.Gotham
TeleportBuild.Text = "🏗️ Ir a Construir"
TeleportBuild.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportBuild.TextSize = 14

TeleportBuild.MouseButton1Click:Connect(function()
    -- Busca la zona de construcción y teletransporta
    for _, v in pairs(workspace:GetChildren()) do
        if v.Name:lower():find("build") or v.Name:lower():find("construct") then
            HumanoidRootPart.CFrame = v.CFrame + Vector3.new(0, 3, 0)
            break
        end
    end
end)

-- Bucle principal
while task.wait(0.5) do
    -- Auto Recolectar
    if CollectEnabled then
        for _, item in pairs(workspace:GetChildren()) do
            if item:IsA("Part") or item:IsA("Model") then
                if item.Name:lower():find("money") or item.Name:lower():find("cash") or item.Name:lower():find("coin") then
                    firetouchinterest(HumanoidRootPart, item, 0)
                    firetouchinterest(HumanoidRootPart, item, 1)
                end
            end
        end
    end

    -- Auto Comprar
    if BuyEnabled then
        for _, button in pairs(workspace:GetDescendants()) do
            if button:IsA("ClickDetector") or button:IsA("ProximityPrompt") then
                local parent = button.Parent
                if parent.Name:lower():find("buy") or parent.Name:lower():find("upgrade") or parent.Name:lower():find("build") then
                    if button:IsA("ClickDetector") then
                        fireclickdetector(button)
                    elseif button:IsA("ProximityPrompt") then
                        button:InputHoldBegin()
                        task.wait(0.1)
                        button:InputHoldEnd()
                    end
                end
            end
        end
    end
end
