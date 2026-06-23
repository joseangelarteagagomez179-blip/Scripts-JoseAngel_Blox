-- // SERVICES
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

-- // VARIABLES
local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

local ScriptEnabled = true
local AutoFarmEnabled = false
local SpeedValue = 100

-- // CREAR INTERFAZ
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SpeedHubUI"
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.new(0,0,0)
MainFrame.BorderColor3 = Color3.new(0.6,0,1)
MainFrame.BorderSizePixel = 2
MainFrame.Size = UDim2.new(0, 600, 0, 420)
MainFrame.Position = UDim2.new(0.5,-300,0.5,-210)
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0,10)
UICorner.Parent = MainFrame

-- // EFECTO LED
local LEDFrame = Instance.new("Frame")
LEDFrame.Parent = MainFrame
LEDFrame.BackgroundTransparency = 1
LEDFrame.Size = UDim2.new(1,10,1,10)
LEDFrame.Position = UDim2.new(0,-5,0,-5)
LEDFrame.ZIndex = -1

local LEDGradient = Instance.new("UIGradient")
LEDGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.new(1,0.2,1)),
    ColorSequenceKeypoint.new(0.5, Color3.new(0.4,0,0.8)),
    ColorSequenceKeypoint.new(1, Color3.new(1,0.2,1))
}
LEDGradient.Rotation = 90
LEDGradient.Parent = LEDFrame

spawn(function()
    while wait(2) do
        TweenService:Create(LEDGradient, TweenInfo.new(2), {Rotation=450}):Play()
        wait(2)
        LEDGradient.Rotation = 90
    end
end)

-- // TITULO
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1,-20,0,40)
Title.Position = UDim2.new(0,10,0,10)
Title.Font = Enum.Font.GothamBold
Title.Text = "+1 Speed-Keyboard-Escape-Candy-Chocolate"
Title.TextColor3 = Color3.new(1,0.5,1)
Title.TextSize = 18

-- // BOTON REDONDO ON/OFF
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Parent = MainFrame
ToggleBtn.BackgroundColor3 = Color3.new(0,0.8,0)
ToggleBtn.Size = UDim2.new(0,50,0,50)
ToggleBtn.Position = UDim2.new(0.92,0,0.02,0)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Text = "ON"
ToggleBtn.TextColor3 = Color3.new(1,1,1)
ToggleBtn.TextSize = 14

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(1,0)
BtnCorner.Parent = ToggleBtn

-- // SECCIONES
local Options = Instance.new("Frame")
Options.Parent = MainFrame
Options.BackgroundTransparency = 1
Options.Size = UDim2.new(1,-40,0,300)
Options.Position = UDim2.new(0,20,0,70)

-- INFO
local Info = Instance.new("TextLabel")
Info.Parent = Options
Info.BackgroundTransparency = 1
Info.Size = UDim2.new(1,0,0,50)
Info.Position = UDim2.new(0,0,0,0)
Info.Font = Enum.Font.GothamBold
Info.Text = "📄 INFO\nCreador: JoseAngel_Blox | 23/06/2026"
Info.TextColor3 = Color3.new(1,0.7,1)
Info.TextSize = 13

-- MAIN
local MainTitle = Instance.new("TextLabel")
MainTitle.Parent = Options
MainTitle.BackgroundTransparency = 1
MainTitle.Size = UDim2.new(1,0,0,25)
MainTitle.Position = UDim2.new(0,0,0,55)
MainTitle.Font = Enum.Font.GothamBold
MainTitle.Text = "⚙️ MAIN"
MainTitle.TextColor3 = Color3.new(1,0.5,1)

-- Auto Farm
local AutoFarmBtn = Instance.new("TextButton")
AutoFarmBtn.Parent = Options
AutoFarmBtn.Size = UDim2.new(0.47,0,0,50)
AutoFarmBtn.Position = UDim2.new(0.01,0,0,85)
AutoFarmBtn.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
AutoFarmBtn.Text = "❌ AUTO FARM"
AutoFarmBtn.TextColor3 = Color3.new(1,1,1)
AutoFarmBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", AutoFarmBtn)

-- Velocidad
local SpeedText = Instance.new("TextLabel")
SpeedText.Parent = Options
SpeedText.BackgroundTransparency = 1
SpeedText.Size = UDim2.new(0.47,0,0,25)
SpeedText.Position = UDim2.new(0.52,0,0,85)
SpeedText.Font = Enum.Font.GothamBold
SpeedText.Text = "VELOCIDAD: "..SpeedValue
SpeedText.TextColor3 = Color3.new(1,0.8,1)

local PlusBtn = Instance.new("TextButton")
PlusBtn.Parent = Options
PlusBtn.Size = UDim2.new(0.22,0,0,22)
PlusBtn.Position = UDim2.new(0.52,0,0,112)
PlusBtn.Text = "+"
PlusBtn.BackgroundColor3 = Color3.new(0.3,0,0.5)
Instance.new("UICorner", PlusBtn)

local MinusBtn = Instance.new("TextButton")
MinusBtn.Parent = Options
MinusBtn.Size = UDim2.new(0.22,0,0,22)
MinusBtn.Position = UDim2.new(0.76,0,0,112)
MinusBtn.Text = "-"
MinusBtn.BackgroundColor3 = Color3.new(0.3,0,0.5)
Instance.new("UICorner", MinusBtn)

-- SHOP
local ShopTitle = Instance.new("TextLabel")
ShopTitle.Parent = Options
ShopTitle.BackgroundTransparency = 1
ShopTitle.Size = UDim2.new(1,0,0,25)
ShopTitle.Position = UDim2.new(0,0,0,145)
ShopTitle.Font = Enum.Font.GothamBold
ShopTitle.Text = "🛒 FREE SHOP"
ShopTitle.TextColor3 = Color3.new(1,0.5,1)

local TreadBtn = Instance.new("TextButton")
TreadBtn.Parent = Options
TreadBtn.Size = UDim2.new(0.31,0,0,50)
TreadBtn.Position = UDim2.new(0.01,0,0,175)
TreadBtn.Text = "✅ CAMINADORAS"
TreadBtn.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
Instance.new("UICorner", TreadBtn)

local AuraBtn = Instance.new("TextButton")
AuraBtn.Parent = Options
AuraBtn.Size = UDim2.new(0.31,0,0,50)
AuraBtn.Position = UDim2.new(0.34,0,0,175)
AuraBtn.Text = "✅ AURAS"
AuraBtn.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
Instance.new("UICorner", AuraBtn)

local TrailBtn = Instance.new("TextButton")
TrailBtn.Parent = Options
TrailBtn.Size = UDim2.new(0.31,0,0,50)
TrailBtn.Position = UDim2.new(0.67,0,0,175)
TrailBtn.Text = "✅ RASTROS"
TrailBtn.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
Instance.new("UICorner", TrailBtn)

-- ==================================================
--  FUNCIONES
-- ==================================================

-- BOTON REDONDO ON/OFF
ToggleBtn.MouseButton1Click:Connect(function()
    ScriptEnabled = not ScriptEnabled
    if ScriptEnabled then
        ToggleBtn.BackgroundColor3 = Color3.new(0,0.8,0)
        ToggleBtn.Text = "ON"
        Humanoid.WalkSpeed = SpeedValue
    else
        ToggleBtn.BackgroundColor3 = Color3.new(0.8,0,0)
        ToggleBtn.Text = "OFF"
        Humanoid.WalkSpeed = 16
    end
end)

-- AUTO FARM
AutoFarmBtn.MouseButton1Click:Connect(function()
    AutoFarmEnabled = not AutoFarmEnabled
    AutoFarmBtn.Text = AutoFarmEnabled and "✅ AUTO FARM" or "❌ AUTO FARM"
    AutoFarmBtn.BackgroundColor3 = AutoFarmEnabled and Color3.new(0,0.6,0) or Color3.new(0.1,0.1,0.1)
end)

-- VELOCIDAD
PlusBtn.MouseButton1Click:Connect(function()
    SpeedValue += 50
    SpeedText.Text = "VELOCIDAD: "..SpeedValue
end)

MinusBtn.MouseButton1Click:Connect(function()
    SpeedValue = SpeedValue > 16 and SpeedValue - 50 or 16
    SpeedText.Text = "VELOCIDAD: "..SpeedValue
end)

RunService.Heartbeat:Connect(function()
    if ScriptEnabled and Humanoid then
        Humanoid.WalkSpeed = SpeedValue
    end
end)

-- DESBLOQUEAR TODO
local function UnlockAll()
    pcall(function()
        -- Dar dinero y stats
        for _,v in pairs(Player:GetChildren()) do
            if v:IsA("NumberValue") or v:IsA("IntValue") then v.Value = 9e9 end
        end
        -- Activar eventos
        for _,v in pairs(ReplicatedStorage:GetDescendants()) do
            if v:IsA("RemoteEvent") or v:IsA("BindableFunction") then
                if string.find(string.lower(v.Name), "buy") or string.find(string.lower(v.Name), "unlock") or string.find(string.lower(v.Name), "equip") then
                    v:FireServer()
                end
            end
        end
    end)
end

TreadBtn.MouseButton1Click:Connect(function()
    UnlockAll()
    TreadBtn.Text = "✅ LISTO"
    wait(1)
    TreadBtn.Text = "✅ CAMINADORAS"
end)

AuraBtn.MouseButton1Click:Connect(function()
    UnlockAll()
    AuraBtn.Text = "✅ LISTO"
    wait(1)
    AuraBtn.Text = "✅ AURAS"
end)

TrailBtn.MouseButton1Click:Connect(function()
    UnlockAll()
    TrailBtn.Text = "✅ LISTO"
    wait(1)
    TrailBtn.Text = "✅ RASTROS"
end)

print("✅ Script Listo - JoseAngel_Blox")
