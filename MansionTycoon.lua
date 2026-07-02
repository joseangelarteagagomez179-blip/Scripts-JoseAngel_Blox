-- Mansion Tycoon v1.1
-- Creador: JoseAngel_Blox
-- Versión Blindada (Fix Nil Value)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart", 10)
local humanoid = character:WaitForChild("Humanoid", 10)

-- Función segura para la UI
local function getSafeParent()
    local success, res = pcall(function()
        if typeof(gethui) == "function" then return gethui() end
        return player:WaitForChild("PlayerGui")
    end)
    return success and res or player:WaitForChild("PlayerGui")
end

-- ===================== PANTALLA DE CARGA =====================
local LoadGui = Instance.new("ScreenGui")
LoadGui.Name = "LoadScreen_JA"
LoadGui.ResetOnSpawn = false
LoadGui.DisplayOrder = 999
LoadGui.Parent = getSafeParent()

local LoadBG = Instance.new("Frame")
LoadBG.Size = UDim2.new(1, 0, 1, 0)
LoadBG.BackgroundColor3 = Color3.fromRGB(5, 5, 15)
LoadBG.BorderSizePixel = 0
LoadBG.ZIndex = 100
LoadBG.Parent = LoadGui

local TopLine = Instance.new("Frame")
TopLine.Size = UDim2.new(0, 0, 0, 2)
TopLine.Position = UDim2.new(0.5, 0, 0.08, 0)
TopLine.AnchorPoint = Vector2.new(0.5, 0)
TopLine.BackgroundColor3 = Color3.fromRGB(120, 80, 255)
TopLine.Parent = LoadBG

local WelcomeLabel = Instance.new("TextLabel")
WelcomeLabel.Text = ""
WelcomeLabel.Size = UDim2.new(0.85, 0, 0, 40)
WelcomeLabel.Position = UDim2.new(0.5, 0, 0.30, 0)
WelcomeLabel.AnchorPoint = Vector2.new(0.5, 0.5)
WelcomeLabel.BackgroundTransparency = 1
WelcomeLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
WelcomeLabel.Font = Enum.Font.Gotham
WelcomeLabel.TextScaled = true
WelcomeLabel.Parent = LoadBG

local TitleLoadLabel = Instance.new("TextLabel")
TitleLoadLabel.Text = ""
TitleLoadLabel.Size = UDim2.new(0.9, 0, 0, 65)
TitleLoadLabel.Position = UDim2.new(0.5, 0, 0.44, 0)
TitleLoadLabel.AnchorPoint = Vector2.new(0.5, 0.5)
TitleLoadLabel.BackgroundTransparency = 1
TitleLoadLabel.TextColor3 = Color3.fromRGB(180, 120, 255)
TitleLoadLabel.Font = Enum.Font.GothamBold
TitleLoadLabel.TextScaled = true
TitleLoadLabel.Parent = LoadBG

local TitleGradient = Instance.new("UIGradient")
TitleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 100, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 80, 255)),
})
TitleGradient.Parent = TitleLoadLabel

local BarBG = Instance.new("Frame")
BarBG.Size = UDim2.new(0.6, 0, 0, 14)
BarBG.Position = UDim2.new(0.5, 0, 0.70, 0)
BarBG.AnchorPoint = Vector2.new(0.5, 0.5)
BarBG.BackgroundColor3 = Color3.fromRGB(25, 20, 40)
BarBG.Parent = LoadBG

local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(120, 60, 255)
BarFill.Parent = BarBG

local PctLabel = Instance.new("TextLabel")
PctLabel.Text = "0%"
PctLabel.Size = UDim2.new(0.5, 0, 0, 24)
PctLabel.Position = UDim2.new(0.5, 0, 0.78, 0)
PctLabel.AnchorPoint = Vector2.new(0.5, 0.5)
PctLabel.BackgroundTransparency = 1
PctLabel.TextColor3 = Color3.fromRGB(160, 120, 255)
PctLabel.Font = Enum.Font.GothamBold
PctLabel.TextScaled = true
PctLabel.Parent = LoadBG

-- ===================== GUI PRINCIPAL =====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MansionTycoon_JA"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = getSafeParent()

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 380, 0, 480)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -240)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame)

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 15, 50)
TitleBar.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Text = "Mansion Tycoon v1.1"
TitleLabel.Size = UDim2.new(1, -50, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextColor3 = Color3.fromRGB(200, 160, 255)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextScaled = true
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, -20, 0, 38)
TabBar.Position = UDim2.new(0, 10, 0, 50)
TabBar.BackgroundColor3 = Color3.fromRGB(20, 10, 40)
TabBar.Parent = MainFrame

local PageHolder = Instance.new("Frame")
PageHolder.Size = UDim2.new(1, -20, 1, -100)
PageHolder.Position = UDim2.new(0, 10, 0, 95)
PageHolder.BackgroundTransparency = 1
PageHolder.Parent = MainFrame

local tabButtons = {}
local tabContents = {}

local function createTabPage(name)
    local btn = Instance.new("TextButton")
    btn.Text = name
    btn.Size = UDim2.new(0, 100, 0, 28)
    btn.BackgroundColor3 = Color3.fromRGB(40, 20, 80)
    btn.TextColor3 = Color3.fromRGB(180, 140, 255)
    btn.Parent = TabBar
    
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Parent = PageHolder
    Instance.new("UIListLayout", page).Padding = UDim.new(0, 8)
    
    return btn, page
end

for _, name in ipairs({"Info", "Main", "Player"}) do
    local btn, page = createTabPage(name)
    tabButtons[name] = btn
    tabContents[name] = page
    btn.MouseButton1Click:Connect(function()
        for n, p in pairs(tabContents) do p.Visible = (n == name) end
    end)
end
tabContents["Info"].Visible = true

-- LÓGICA DE FARM (Simplificada para estabilidad)
local autoBuild = false
local function doBuild()
    while autoBuild do
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name == "Touch" and v:IsA("BasePart") then
                firetouchinterest(rootPart, v, 0)
                firetouchinterest(rootPart, v, 1)
            end
        end
        task.wait(0.5)
    end
end

-- ===================== ANIMACIÓN FINAL =====================
task.spawn(function()
    local l1 = "Bienvenidos a"
    for i=1, #l1 do WelcomeLabel.Text = l1:sub(1,i) task.wait(0.05) end
    
    local l2 = "Scripts JoseAngel_Blox"
    for i=1, #l2 do TitleLoadLabel.Text = l2:sub(1,i) task.wait(0.05) end
    
    for i=1, 100 do
        BarFill.Size = UDim2.new(i/100, 0, 1, 0)
        PctLabel.Text = i.."%"
        task.wait(0.02)
    end
    
    task.wait(0.5)
    LoadGui:Destroy()
    MainFrame.Visible = true
end)

print("Mansion Tycoon v1.1 - Cargado con éxito")
