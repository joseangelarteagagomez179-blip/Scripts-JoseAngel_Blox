--[[
    Script Completo para Mansion Tycoon
    Versión Mejorada
]]

local Services = setmetatable({}, {__index = function(s, i) return game:GetService(i) end})
local Workspace, Players, TweenService = Services.Workspace, Services.Players, Services.TweenService
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- ===== CONFIGURACIÓN =====
local Config = {
    AutoCollect = true,
    AutoBuy = true,
    AutoOpen = true,
    Delay = 0.01
}

-- ===== FUNCIÓN PRINCIPAL =====
spawn(function()
    while wait(Config.Delay) do
        -- 1. AUTO RECOLECTAR DINERO (Busca en TODO el mapa)
        if Config.AutoCollect then
            for _, Money in pairs(Workspace:GetDescendants()) do
                if Money:IsA("Part") or Money:IsA("MeshPart") then
                    local name = string.lower(Money.Name)
                    if name:find("money") or name:find("cash") or name:find("coin") or name:find("billete") or name:find("dollar") then
                        -- Teletransporta el dinero hacia ti
                        if Money.CFrame then
                            firetouchinterest(HumanoidRootPart, Money, 0)
                            firetouchinterest(HumanoidRootPart, Money, 1)
                        end
                    end
                end
            end
        end

        -- 2. AUTO COMPRAR / MEJORAR (Busca TODOS los botones)
        if Config.AutoBuy then
            for _, Click in pairs(Workspace:GetDescendants()) do
                if Click:IsA("ClickDetector") then
                    pcall(function()
                        Click:MouseClick()
                    end)
                end
            end
        end
        
    end
end)

-- ===== MENÚ / INTERFAZ =====
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")

-- Botones
local BtnCollect = Instance.new("TextButton")
local BtnBuy = Instance.new("TextButton")

ScreenGui.Parent = LocalPlayer.PlayerGui

-- Marco Principal
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 150)
MainFrame.Active = true
MainFrame.Draggable = true

-- Título
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(0, 220, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "🏰 Mansion Tycoon Script"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 16

-- ===== BOTÓN 1: AUTO RECOLECTAR =====
BtnCollect.Parent = MainFrame
BtnCollect.BackgroundColor3 = Config.AutoCollect and Color3.new(0, 0.5, 0) or Color3.new(0.5, 0, 0)
BtnCollect.Size = UDim2.new(0, 200, 0, 40)
BtnCollect.Position = UDim2.new(0, 10, 0, 40)
BtnCollect.Font = Enum.Font.GothamBold
BtnCollect.Text = "💰 Auto Recolectar: ON"
BtnCollect.TextColor3 = Color3.new(1, 1, 1)
BtnCollect.TextSize = 14

BtnCollect.MouseButton1Click:Connect(function()
    Config.AutoCollect = not Config.AutoCollect
    if Config.AutoCollect then
        BtnCollect.BackgroundColor3 = Color3.new(0, 0.5, 0)
        BtnCollect.Text = "💰 Auto Recolectar: ON"
    else
        BtnCollect.BackgroundColor3 = Color3.new(0.5, 0, 0)
        BtnCollect.Text = "💰 Auto Recolectar: OFF"
    end
end)

-- ===== BOTÓN 2: AUTO COMPRAR =====
BtnBuy.Parent = MainFrame
BtnBuy.BackgroundColor3 = Config.AutoBuy and Color3.new(0, 0.5, 0) or Color3.new(0.5, 0, 0)
BtnBuy.Size = UDim2.new(0, 200, 0, 40)
BtnBuy.Position = UDim2.new(0, 10, 0, 90)
BtnBuy.Font = Enum.Font.GothamBold
BtnBuy.Text = "🛒 Auto Comprar: ON"
BtnBuy.TextColor3 = Color3.new(1, 1, 1)
BtnBuy.TextSize = 14

BtnBuy.MouseButton1Click:Connect(function()
    Config.AutoBuy = not Config.AutoBuy
    if Config.AutoBuy then
        BtnBuy.BackgroundColor3 = Color3.new(0, 0.5, 0)
        BtnBuy.Text = "🛒 Auto Comprar: ON"
    else
        BtnBuy.BackgroundColor3 = Color3.new(0.5, 0, 0)
        BtnBuy.Text = "🛒 Auto Comprar: OFF"
    end
end)

print("✅ Script cargado completamente!")
