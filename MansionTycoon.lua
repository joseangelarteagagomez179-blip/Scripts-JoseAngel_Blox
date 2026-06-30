--[[
    SCRIPT FINAL PARA MANSION TYCOON
    Con Teletransporte Automático a Botones y Buzón
]]

local Services = setmetatable({}, {__index = function(s, i) return game:GetService(i) end})
local Workspace, Players, TweenService = Services.Workspace, Services.Players, Services.TweenService
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

-- ===== CONFIGURACIÓN =====
local Config = {
    AutoCollect = false,
    AutoBuy = false,
    Delay = 0.1
}

-- ===== FUNCIÓN PRINCIPAL =====
spawn(function()
    while wait(Config.Delay) do
        -- 1. AUTO RECOLECTAR (IR AL BUZÓN)
        if Config.AutoCollect then
            for _, objeto in pairs(Workspace:GetDescendants()) do
                -- Busca el buzón o zona de recolección
                if objeto:IsA("Part") then
                    local nombre = string.lower(objeto.Name)
                    if nombre:find("buzon") or nombre:find("collect") or nombre:find("recolect") or nombre:find("mail") then
                        -- Teletransportar personaje al buzón
                        HumanoidRootPart.CFrame = objeto.CFrame + Vector3.new(0, 2, 0)
                        wait(0.1)
                        -- Simular toque
                        firetouchinterest(HumanoidRootPart, objeto, 0)
                        firetouchinterest(HumanoidRootPart, objeto, 1)
                        break
                    end
                end
            end
        end

        -- 2. AUTO COMPRAR (IR A LOS BOTONES VERDES)
        if Config.AutoBuy then
            for _, objeto in pairs(Workspace:GetDescendants()) do
                -- Busca botones verdes o con precio
                if objeto:IsA("Part") and objeto.BrickColor.Name == "Bright green" or objeto.BrickColor.Name == "Forest green" then
                    if objeto:FindFirstChild("ClickDetector") then
                        -- Teletransportar personaje al botón
                        HumanoidRootPart.CFrame = objeto.CFrame + Vector3.new(0, 3, 0)
                        wait(0.1)
                        -- Hacer clic
                        objeto.ClickDetector:MouseClick()
                        wait(0.2)
                    end
                end
                -- También busca por nombre "Buy" o "Comprar"
                local nombre = string.lower(objeto.Name)
                if objeto:IsA("Part") and (nombre:find("buy") or nombre:find("comprar")) then
                     if objeto:FindFirstChild("ClickDetector") then
                        HumanoidRootPart.CFrame = objeto.CFrame + Vector3.new(0, 3, 0)
                        wait(0.1)
                        objeto.ClickDetector:MouseClick()
                        wait(0.2)
                    end
                end
            end
        end
    end
end)

-- ===== MENÚ =====
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local BtnCollect = Instance.new("TextButton")
local BtnBuy = Instance.new("TextButton")

ScreenGui.Parent = LocalPlayer.PlayerGui

-- Marco
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.new(0.1, 0, 0.1)
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 150)
MainFrame.Active = true
MainFrame.Draggable = true

-- Título
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(0, 220, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "🏰 MANSION TYCOON"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 16

-- BOTÓN RECOLECTAR
BtnCollect.Parent = MainFrame
BtnCollect.BackgroundColor3 = Config.AutoCollect and Color3.new(0, 0.6, 0) or Color3.new(0.6, 0, 0)
BtnCollect.Size = UDim2.new(0, 200, 0, 40)
BtnCollect.Position = UDim2.new(0, 10, 0, 40)
BtnCollect.Font = Enum.Font.GothamBold
BtnCollect.Text = "📬 IR AL BUZÓN: OFF"
BtnCollect.TextColor3 = Color3.new(1, 1, 1)
BtnCollect.TextSize = 14

BtnCollect.MouseButton1Click:Connect(function()
    Config.AutoCollect = not Config.AutoCollect
    if Config.AutoCollect then
        BtnCollect.BackgroundColor3 = Color3.new(0, 0.6, 0)
        BtnCollect.Text = "📬 IR AL BUZÓN: ON"
    else
        BtnCollect.BackgroundColor3 = Color3.new(0.6, 0, 0)
        BtnCollect.Text = "📬 IR AL BUZÓN: OFF"
    end
end)

-- BOTÓN COMPRAR
BtnBuy.Parent = MainFrame
BtnBuy.BackgroundColor3 = Config.AutoBuy and Color3.new(0, 0.6, 0) or Color3.new(0.6, 0, 0)
BtnBuy.Size = UDim2.new(0, 200, 0, 40)
BtnBuy.Position = UDim2.new(0, 10, 0, 90)
BtnBuy.Font = Enum.Font.GothamBold
BtnBuy.Text = "🛒 IR A BOTONES: OFF"
BtnBuy.TextColor3 = Color3.new(1, 1, 1)
BtnBuy.TextSize = 14

BtnBuy.MouseButton1Click:Connect(function()
    Config.AutoBuy = not Config.AutoBuy
    if Config.AutoBuy then
        BtnBuy.BackgroundColor3 = Color3.new(0, 0.6, 0)
        BtnBuy.Text = "🛒 IR A BOTONES: ON"
    else
        BtnBuy.BackgroundColor3 = Color3.new(0.6, 0, 0)
        BtnBuy.Text = "🛒 IR A BOTONES: OFF"
    end
end)

print("✅ Script listo! Ahora se mueve solo.")
