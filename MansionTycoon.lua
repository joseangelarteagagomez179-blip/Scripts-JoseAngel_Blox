-- Mansion Tycoon v1.1
-- Creador: JoseAngel_Blox
-- Fecha: 01/07/2026

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid", 15)
local rootPart = character:WaitForChild("HumanoidRootPart", 15)

-- Función de seguridad para Delta (evita el cuadro negro o errores nil)
local function getSafeParent()
    local success, res = pcall(function()
        if typeof(gethui) == "function" then return gethui() end
        return player:WaitForChild("PlayerGui")
    end)
    return success and res or player:WaitForChild("PlayerGui")
end

-- ===================== PANTALLA DE CARGA (PREMIUM) =====================
local LoadGui = Instance.new("ScreenGui")
LoadGui.Name = "LoadScreen"
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
TopLine.ZIndex = 101
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
WelcomeLabel.ZIndex = 101
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
TitleLoadLabel.ZIndex = 101
TitleLoadLabel.Parent = LoadBG

local TitleGradient = Instance.new("UIGradient")
TitleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 100, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 180, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 80, 255)),
})
TitleGradient.Rotation = 45
TitleGradient.Parent = TitleLoadLabel

local SubLabel = Instance.new("TextLabel")
SubLabel.Text = ""
SubLabel.Size = UDim2.new(0.75, 0, 0, 28)
SubLabel.Position = UDim2.new(0.5, 0, 0.55, 0)
SubLabel.AnchorPoint = Vector2.new(0.5, 0.5)
SubLabel.BackgroundTransparency = 1
SubLabel.TextColor3 = Color3.fromRGB(140, 100, 200)
SubLabel.Font = Enum.Font.GothamItalic
SubLabel.TextScaled = true
SubLabel.ZIndex = 101
SubLabel.Parent = LoadBG

local BarBG = Instance.new("Frame")
BarBG.Size = UDim2.new(0.6, 0, 0, 14)
BarBG.Position = UDim2.new(0.5, 0, 0.70, 0)
BarBG.AnchorPoint = Vector2.new(0.5, 0.5)
BarBG.BackgroundColor3 = Color3.fromRGB(25, 20, 40)
BarBG.ZIndex = 101
BarBG.Parent = LoadBG
Instance.new("UICorner", BarBG).CornerRadius = UDim.new(1, 0)

local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(120, 60, 255)
BarFill.ZIndex = 102
BarFill.Parent = BarBG
Instance.new("UICorner", BarFill).CornerRadius = UDim.new(1, 0)

local PctLabel = Instance.new("TextLabel")
PctLabel.Text = "0%"
PctLabel.Size = UDim2.new(0.5, 0, 0, 24)
PctLabel.Position = UDim2.new(0.5, 0, 0.78, 0)
PctLabel.AnchorPoint = Vector2.new(0.5, 0.5)
PctLabel.BackgroundTransparency = 1
PctLabel.TextColor3 = Color3.fromRGB(160, 120, 255)
PctLabel.Font = Enum.Font.GothamBold
PctLabel.TextScaled = true
PctLabel.ZIndex = 101
PctLabel.Parent = LoadBG

local BotLine = Instance.new("Frame")
BotLine.Size = UDim2.new(0, 0, 0, 2)
BotLine.Position = UDim2.new(0.5, 0, 0.90, 0)
BotLine.AnchorPoint = Vector2.new(0.5, 0)
BotLine.BackgroundColor3 = Color3.fromRGB(120, 80, 255)
BotLine.ZIndex = 101
BotLine.Parent = LoadBG

-- ===================== GUI PRINCIPAL =====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MansionTycoonGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = getSafeParent()

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 380, 0, 480)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -240)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 16)

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 15, 50)
TitleBar.Parent = MainFrame
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 16)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Text = "🏰 Mansion Tycoon v1.1"
TitleLabel.Size = UDim2.new(1, -50, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextColor3 = Color3.fromRGB(200, 160, 255)
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

local MinBtn = Instance.new("TextButton")
MinBtn.Text = "—"
MinBtn.Size = UDim2.new(0, 35, 0, 28)
MinBtn.Position = UDim2.new(1, -42, 0, 8)
MinBtn.BackgroundColor3 = Color3.fromRGB(80, 40, 180)
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextScaled = true
MinBtn.Parent = TitleBar
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 8)

local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, -20, 0, 38)
TabBar.Position = UDim2.new(0, 10, 0, 50)
TabBar.BackgroundColor3 = Color3.fromRGB(20, 10, 40)
TabBar.Parent = MainFrame
Instance.new("UICorner", TabBar).CornerRadius = UDim.new(0, 10)

local TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
TabLayout.Padding = UDim.new(0, 6)
TabLayout.Parent = TabBar

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
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.Parent = TabBar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.Visible = false
    page.Parent = PageHolder
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.Parent = page
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        page.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    end)
    return btn, page
end

for _, name in ipairs({"Info", "Main", "Player"}) do
    local btn, page = createTabPage(name)
    tabButtons[name] = btn
    tabContents[name] = page
    btn.MouseButton1Click:Connect(function()
        for n, p in pairs(tabContents) do p.Visible = (n == name) end
        for n, b in pairs(tabButtons) do b.BackgroundColor3 = (n == name) and Color3.fromRGB(100, 50, 220) or Color3.fromRGB(40, 20, 80) end
    end)
end
tabContents["Info"].Visible = true
tabButtons["Info"].BackgroundColor3 = Color3.fromRGB(100, 50, 220)

local function createLabel(parent, txt, color)
    local lbl = Instance.new("TextLabel")
    lbl.Text = txt
    lbl.Size = UDim2.new(1, -10, 0, 28)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = color or Color3.fromRGB(200, 160, 255)
    lbl.Font = Enum.Font.Gotham
    lbl.TextScaled = true
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = parent
end

local function createSectionLabel(parent, txt)
    local lbl = Instance.new("TextLabel")
    lbl.Text = "— " .. txt .. " —"
    lbl.Size = UDim2.new(1, -10, 0, 24)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(140, 100, 255)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextScaled = true
    lbl.Parent = parent
end

local function createToggle(parent, labelText, callback)
    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1, -10, 0, 38)
    holder.BackgroundColor3 = Color3.fromRGB(25, 15, 45)
    holder.Parent = parent
    Instance.new("UICorner", holder).CornerRadius = UDim.new(0, 10)
    local lbl = Instance.new("TextLabel")
    lbl.Text = labelText
    lbl.Size = UDim2.new(1, -60, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(220, 200, 255)
    lbl.Font = Enum.Font.Gotham
    lbl.TextScaled = true
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = holder
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 44, 0, 24)
    toggleBtn.Position = UDim2.new(1, -52, 0.5, -12)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    toggleBtn.Text = ""
    toggleBtn.Parent = holder
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1, 0)
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 18, 0, 18)
    knob.Position = UDim2.new(0, 3, 0.5, -9)
    knob.BackgroundColor3 = Color3.fromRGB(180, 180, 200)
    knob.Parent = toggleBtn
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
    local state = false
    toggleBtn.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = state and Color3.fromRGB(100, 50, 220) or Color3.fromRGB(60, 60, 80)}):Play()
        TweenService:Create(knob, TweenInfo.new(0.2), {Position = state and UDim2.new(0, 23, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)}):Play()
        callback(state)
    end)
end

-- ===== CONTENIDO INFO =====
createSectionLabel(tabContents["Info"], "Información")
createLabel(tabContents["Info"], "👤 Creador: JoseAngel_Blox")
createLabel(tabContents["Info"], "📅 Fecha: 01/07/2026")
createLabel(tabContents["Info"], "🎮 Juego: Mansion Tycoon")
createLabel(tabContents["Info"], "⚡ Versión: v1.1")
createLabel(tabContents["Info"], "📱 Executor: Delta (Android)")
createLabel(tabContents["Info"], "✨ Disfruta el script!", Color3.fromRGB(160, 255, 160))

-- ===== CONTENIDO MAIN (AUTO FARM) =====
local autoBuild = false
local autoCollect = false
local ROBUX_PARENTS = {"DoubleCash","AutoCollect","VIP","StarterPack","Goldify"}

createSectionLabel(tabContents["Main"], "Auto Farm")
createToggle(tabContents["Main"], "🏗️ Auto Build", function(state)
    autoBuild = state
    task.spawn(function()
        while autoBuild do
            for _, v in pairs(workspace:GetDescendants()) do
                if not autoBuild then break end
                if v.Name == "Touch" and v:IsA("BasePart") then
                    local isRobux = false
                    for _, kw in ipairs(ROBUX_PARENTS) do if v.Parent.Name:find(kw) then isRobux = true end end
                    if not isRobux then
                        firetouchinterest(rootPart, v, 0)
                        firetouchinterest(rootPart, v, 1)
                    end
                end
            end
            task.wait(0.3)
        end
    end)
end)

createToggle(tabContents["Main"], "💰 Auto Collect", function(state)
    autoCollect = state
    task.spawn(function()
        while autoCollect do
            pcall(function()
                local collector = workspace.Tycoons:FindFirstChild("Plot1").Tycoon2.Mansion.Collectors.Collector.Touch
                firetouchinterest(rootPart, collector, 0)
                firetouchinterest(rootPart, collector, 1)
            end)
            task.wait(0.5)
        end
    end)
end)

-- ===== CONTENIDO PLAYER =====
createSectionLabel(tabContents["Player"], "Mejoras de Jugador")
createToggle(tabContents["Player"], "⚡ Velocidad Hack", function(state) humanoid.WalkSpeed = state and 60 or 16 end)
createToggle(tabContents["Player"], "🦘 Súper Salto", function(state) humanoid.JumpPower = state and 120 or 50 end)

-- ===================== ANIMACIÓN DE CARGA CORREGIDA =====================
task.spawn(function()
    TweenService:Create(TopLine, TweenInfo.new(0.6), {Size = UDim2.new(0.5, 0, 0, 2)}):Play()
    TweenService:Create(BotLine, TweenInfo.new(0.6), {Size = UDim2.new(0.5, 0, 0, 2)}):Play()
    task.wait(0.7)

    local l1 = "✨ Bienvenidos a"
    for i = 1, #l1 do WelcomeLabel.Text = l1:sub(1, i) task.wait(0.05) end
    local l2 = "Scripts JoseAngel_Blox"
    for i = 1, #l2 do TitleLoadLabel.Text = l2:sub(1, i) task.wait(0.06) end
    local l3 = "🏰 Mansion Tycoon v1.1"
    for i = 1, #l3 do SubLabel.Text = l3:sub(1, i) task.wait(0.04) end

    for i = 1, 100 do
        BarFill.Size = UDim2.new(i/100, 0, 1, 0)
        PctLabel.Text = i .. "%"
        task.wait(0.02)
    end

    task.wait(0.5)
    LoadGui:Destroy()
    MainFrame.Visible = true
end)

print("✅ Mansion Tycoon v1.1 - Cargado con éxito por JoseAngel_Blox")
