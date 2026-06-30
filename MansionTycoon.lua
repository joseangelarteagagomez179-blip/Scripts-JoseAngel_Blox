--[[
    Script Completo para Mansion Tycoon
    Creado por Dola
]]

local Services = setmetatable({}, {__index = function(s, i) return game:GetService(i) end})
local Workspace, Players, TweenService, RunService = Services.Workspace, Services.Players, Services.TweenService, Services.RunService
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- ===== CONFIGURACIÓN =====
local Config = {
    AutoCollect = true,
    AutoBuy = true,
    AutoOpen = true,
    Delay = 0.05 -- Velocidad (menos = más rápido)
}

-- ===== FUNCIÓN PRINCIPAL =====
spawn(function()
    while wait(Config.Delay) do
        -- 1. AUTO RECOLECTAR DINERO
        if Config.AutoCollect then
            for _, Money in pairs(Workspace:GetChildren()) do
                if Money:IsA("Part") or Money:IsA("MeshPart") then
                    if string.find(string.lower(Money.Name), "money") or string.find(string.lower(Money.Name), "cash") then
                        -- Simular toque
                        firetouchinterest(HumanoidRootPart, Money, 0)
                        firetouchinterest(HumanoidRootPart, Money, 1)
                    end
                end
            end
        end

        -- 2. AUTO COMPRAR / MEJORAR DROPPERS
        if Config.AutoBuy then
            for _, Dropper in pairs(Workspace:GetChildren()) do
                if Dropper:FindFirstChildOfClass("ClickDetector") then
                    if string.find(string.lower(Dropper.Name), "dropper") or string.find(string.lower(Dropper.Name), "collector") or string.find(string.lower(Dropper.Name), "button") then
                        Dropper.ClickDetector:MouseClick()
                    end
                end
            end
        end
        
        -- 3. AUTO ABRIR CAJAS / OBJETOS
        if Config.AutoOpen then
            for _, Item in pairs(Workspace:GetChildren()) do
                if Item:FindFirstChildOfClass("ClickDetector") then
                    if string.find(string.lower(Item.Name), "crate") or string.find(string.lower(Item.Name), "chest") or string.find(string.lower(Item.Name), "box") then
                        Item.ClickDetector:MouseClick()
                    end
                end
            end
        end
        
    end
end)

-- ===== MENÚ / INTERFAZ =====
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local TextButton = Instance.new("TextButton")

ScreenGui.Parent = LocalPlayer.PlayerGui

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 100)
MainFrame.Active = true
MainFrame.Draggable = true -- Puedes mover la ventana

Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(0, 200, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "Mansion Tycoon Script"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 14

TextButton.Parent = MainFrame
TextButton.BackgroundColor3 = Color3.new(0, 0.5, 0)
TextButton.Size = UDim2.new(0, 180, 0, 40)
TextButton.Position = UDim2.new(0, 10, 0, 40)
TextButton.Font = Enum.Font.GothamBold
TextButton.Text = "ACTIVADO ✅"
TextButton.TextColor3 = Color3.new(1, 1, 1)
TextButton.TextSize = 14

-- Función del botón
local Enabled = true
TextButton.MouseButton1Click:Connect(function()
    Enabled = not Enabled
    Config.AutoCollect = Enabled
    Config.AutoBuy = Enabled
    Config.AutoOpen = Enabled
    if Enabled then
        TextButton.Text = "ACTIVADO ✅"
        TextButton.BackgroundColor3 = Color3.new(0, 0.5, 0)
    else
        TextButton.Text = "PAUSADO ⏸️"
        TextButton.BackgroundColor3 = Color3.new(0.5, 0.5, 0)
    end
end)

print("✅ Script cargado completamente!")
