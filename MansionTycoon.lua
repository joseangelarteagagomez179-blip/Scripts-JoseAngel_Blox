-- Mansion Tycoon v1.1
-- Creador: JoseAngel_Blox
-- Fecha: 01/07/2026

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- ===================== PANTALLA DE CARGA =====================
local LoadGui = Instance.new("ScreenGui")
LoadGui.Name = "LoadScreen"
LoadGui.ResetOnSpawn = false
LoadGui.DisplayOrder = 999
LoadGui.Parent = gethui and gethui() or player.PlayerGui

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
TopLine.BorderSizePixel = 0
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
BarBG.BorderSizePixel = 0
BarBG.ZIndex = 101
BarBG.Parent = LoadBG
Instance.new("UICorner", BarBG).CornerRadius = UDim.new(1, 0)
local BarStroke = Instance.new("UIStroke")
BarStroke.Color = Color3.fromRGB(80, 50, 150)
BarStroke.Thickness = 1
BarStroke.Parent = BarBG

local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(120, 60, 255)
BarFill.BorderSizePixel = 0
BarFill.ZIndex = 102
BarFill.Parent = BarBG
Instance.new("UICorner", BarFill).CornerRadius = UDim.new(1, 0)

local BarGlow = Instance.new("UIGradient")
BarGlow.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 50, 220)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(220, 150, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 50, 220)),
})
BarGlow.Parent = BarFill

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
BotLine.BorderSizePixel = 0
BotLine.ZIndex = 101
BotLine.Parent = LoadBG

-- ===================== GUI PRINCIPAL (invisible al inicio) =====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MansionTycoonGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 1
ScreenGui.Parent = gethui and gethui() or player.PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 380, 0, 480)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -240)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 16)
local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(120, 80, 255)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 15, 50)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 16)

local TitleFix = Instance.new("Frame")
TitleFix.Size = UDim2.new(1, 0, 0.5, 0)
TitleFix.Position = UDim2.new(0, 0, 0.5, 0)
TitleFix.BackgroundColor3 = Color3.fromRGB(25, 15, 50)
TitleFix.BorderSizePixel = 0
TitleFix.Parent = TitleBar

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
MinBtn.BorderSizePixel = 0
MinBtn.Parent = TitleBar
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 8)

local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, -20, 0, 38)
TabBar.Position = UDim2.new(0, 10, 0, 50)
TabBar.BackgroundColor3 = Color3.fromRGB(20, 10, 40)
TabBar.BorderSizePixel = 0
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
    btn.BorderSizePixel = 0
    btn.Parent = TabBar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = Color3.fromRGB(120, 80, 255)
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
end

local function switchTab(name)
    for n, page in pairs(tabContents) do page.Visible = (n == name) end
    for n, btn in pairs(tabButtons) do
        btn.BackgroundColor3 = (n==name) and Color3.fromRGB(100,50,220) or Color3.fromRGB(40,20,80)
        btn.TextColor3 = (n==name) and Color3.fromRGB(255,255,255) or Color3.fromRGB(180,140,255)
    end
end
for name, btn in pairs(tabButtons) do
    btn.MouseButton1Click:Connect(function() switchTab(name) end)
end
switchTab("Info")

local function createLabel(parent, txt, color)
    local lbl = Instance.new("TextLabel")
    lbl.Text = txt
    lbl.Size = UDim2.new(1, -10, 0, 28)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = color or Color3.fromRGB(200,160,255)
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
    lbl.TextColor3 = Color3.fromRGB(140,100,255)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextScaled = true
    lbl.Parent = parent
end

local function createToggle(parent, labelText, callback)
    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1, -10, 0, 38)
    holder.BackgroundColor3 = Color3.fromRGB(25,15,45)
    holder.BorderSizePixel = 0
    holder.Parent = parent
    Instance.new("UICorner", holder).CornerRadius = UDim.new(0, 10)
    local lbl = Instance.new("TextLabel")
    lbl.Text = labelText
    lbl.Size = UDim2.new(1,-60,1,0)
    lbl.Position = UDim2.new(0,10,0,0)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(220,200,255)
    lbl.Font = Enum.Font.Gotham
    lbl.TextScaled = true
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = holder
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0,44,0,24)
    toggleBtn.Position = UDim2.new(1,-52,0.5,-12)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(60,60,80)
    toggleBtn.Text = ""
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Parent = holder
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1,0)
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0,18,0,18)
    knob.Position = UDim2.new(0,3,0.5,-9)
    knob.BackgroundColor3 = Color3.fromRGB(180,180,200)
    knob.BorderSizePixel = 0
    knob.Parent = toggleBtn
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)
    local state = false
    toggleBtn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            TweenService:Create(toggleBtn,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(100,50,220)}):Play()
            TweenService:Create(knob,TweenInfo.new(0.2),{Position=UDim2.new(0,23,0.5,-9),BackgroundColor3=Color3.fromRGB(255,255,255)}):Play()
        else
            TweenService:Create(toggleBtn,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(60,60,80)}):Play()
            TweenService:Create(knob,TweenInfo.new(0.2),{Position=UDim2.new(0,3,0.5,-9),BackgroundColor3=Color3.fromRGB(180,180,200)}):Play()
        end
        callback(state)
    end)
end

-- INFO
local infoPage = tabContents["Info"]
createSectionLabel(infoPage, "Información")
createLabel(infoPage, "👤 Creador: JoseAngel_Blox")
createLabel(infoPage, "📅 Fecha: 01/07/2026")
createLabel(infoPage, "🎮 Juego: Mansion Tycoon")
createLabel(infoPage, "⚡ Versión: v1.1")
createLabel(infoPage, "📱 Executor: Delta (Android)")
createLabel(infoPage, "✨ Disfruta el script!", Color3.fromRGB(160,255,160))

-- MAIN
local mainPage = tabContents["Main"]
createSectionLabel(mainPage, "Auto Farm")
local autoBuildEnabled = false
local autoCollectEnabled = false
local touchParts = {}
local collectorTouchParts = {}
local ROBUX_PARENTS = {"DoubleCash","AutoCollect","VIP","StarterPack","SpeedBoost","VelocidadAdicional","ExtraSpeed","MochilaCohete","PaqueteCochesExoticos","GoldifyButton","Goldify","Gold","Robux","Premium","Gamepass","MoneyTier"}

local function isRobuxButton(part)
    local parent = part.Parent
    if not parent then return false end
    local gui = parent:FindFirstChild("ButtonGui")
    if gui and gui.ClassName=="ObjectValue" then
        local n = gui.Value and gui.Value.Name or ""
        if n:find("Gold") or n:find("Goldify") then return true end
    end
    for _, kw in ipairs(ROBUX_PARENTS) do
        if parent.Name:find(kw) then return true end
    end
    local anc = parent.Parent
    while anc and anc ~= workspace do
        local n = anc.Name
        if n=="Shop" or n=="Store" or n=="Gamepasses" or n=="GamepassShop" or n=="RobuxShop" then return true end
        anc = anc.Parent
    end
    return false
end

local function isCollectorTouch(part)
    local p = part.Parent
    while p and p ~= workspace do
        if p.Name=="Collector" then return true end
        p = p.Parent
    end
    return false
end

local function refreshParts()
    touchParts = {}
    collectorTouchParts = {}
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Name=="Touch" then
            if isCollectorTouch(v) then table.insert(collectorTouchParts, v)
            elseif not isRobuxButton(v) then table.insert(touchParts, v) end
        end
    end
end

workspace.DescendantAdded:Connect(function(v)
    task.wait()
    if v:IsA("BasePart") and v.Name=="Touch" then
        if isCollectorTouch(v) then table.insert(collectorTouchParts, v)
        elseif not isRobuxButton(v) then table.insert(touchParts, v) end
    end
end)
workspace.DescendantRemoving:Connect(function(v)
    if v:IsA("BasePart") and v.Name=="Touch" then refreshParts() end
end)
refreshParts()

createToggle(mainPage, "🏗️ Auto Build", function(state)
    autoBuildEnabled = state
    if state then
        task.spawn(function()
            while autoBuildEnabled do
                for _, v in pairs(touchParts) do
                    if not autoBuildEnabled then break end
                    if v and v.Parent then
                        firetouchinterest(rootPart, v, 0)
                        firetouchinterest(rootPart, v, 1)
                    end
                end
                task.wait(0.3)
            end
        end)
    end
end)

createToggle(mainPage, "💰 Auto Collect Money", function(state)
    autoCollectEnabled = state
    if state then
        task.spawn(function()
            while autoCollectEnabled do
                for _, v in pairs(collectorTouchParts) do
                    if v and v.Parent then
                        firetouchinterest(rootPart, v, 0)
                        firetouchinterest(rootPart, v, 1)
                    end
                end
                task.wait(0.5)
            end
        end)
    end
end)

-- PLAYER
local playerPage = tabContents["Player"]
createSectionLabel(playerPage, "Player Options")
local speedEnabled = false
local jumpEnabled = false
local noclipEnabled = false
local espEnabled = false
local espObjects = {}

createToggle(playerPage, "⚡ Speed Hack", function(state)
    speedEnabled = state
    if humanoid then humanoid.WalkSpeed = state and 60 or 16 end
end)
createToggle(playerPage, "🦘 Salto Alto", function(state)
    jumpEnabled = state
    if humanoid then humanoid.JumpPower = state and 120 or 50 end
end)
createToggle(playerPage, "👻 Noclip", function(state)
    noclipEnabled = state
end)

RunService.Stepped:Connect(function()
    if noclipEnabled and character then
        for _, p in pairs(character:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end
end)

local function clearESP()
    for _, obj in pairs(espObjects) do
        if obj and obj.Parent then obj:Destroy() end
    end
    espObjects = {}
end

local function createESP()
    clearESP()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            local char = plr.Character
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                local hl = Instance.new("SelectionBox")
                hl.Color3 = Color3.fromRGB(255,50,50)
                hl.LineThickness = 0.05
                hl.SurfaceTransparency = 0.6
                hl.SurfaceColor3 = Color3.fromRGB(255,80,80)
                hl.Adornee = char
                hl.Parent = workspace
                table.insert(espObjects, hl)
                local bb = Instance.new("BillboardGui")
                bb.Size = UDim2.new(0,120,0,50)
                bb.StudsOffsetWorldSpace = Vector3.new(0,4,0)
                bb.AlwaysOnTop = true
                bb.MaxDistance = 2000
                bb.Parent = root
                local nameLbl = Instance.new("TextLabel")
                nameLbl.Size = UDim2.new(1,0,0.5,0)
                nameLbl.BackgroundTransparency = 1
                nameLbl.Text = plr.Name
                nameLbl.TextColor3 = Color3.fromRGB(255,80,80)
                nameLbl.Font = Enum.Font.GothamBold
                nameLbl.TextScaled = true
                nameLbl.TextStrokeTransparency = 0
                nameLbl.TextStrokeColor3 = Color3.fromRGB(0,0,0)
                nameLbl.Parent = bb
                local distLbl = Instance.new("TextLabel")
                distLbl.Size = UDim2.new(1,0,0.5,0)
                distLbl.Position = UDim2.new(0,0,0.5,0)
                distLbl.BackgroundTransparency = 1
                distLbl.TextColor3 = Color3.fromRGB(255,220,80)
                distLbl.Font = Enum.Font.Gotham
                distLbl.TextScaled = true
                distLbl.TextStrokeTransparency = 0
                distLbl.TextStrokeColor3 = Color3.fromRGB(0,0,0)
                distLbl.Parent = bb
                table.insert(espObjects, bb)
                task.spawn(function()
                    while espEnabled and root and root.Parent do
                        distLbl.Text = math.floor((root.Position - rootPart.Position).Magnitude) .. " studs"
                        task.wait(0.1)
                    end
                end)
            end
        end
    end
end

createToggle(playerPage, "🔍 ESP Jugadores", function(state)
    espEnabled = state
    if state then
        createESP()
        task.spawn(function()
            while espEnabled do
                task.wait(3)
                if espEnabled then createESP() end
            end
        end)
    else
        clearESP()
    end
end)

local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    PageHolder.Visible = not minimized
    TabBar.Visible = not minimized
    MainFrame.Size = minimized and UDim2.new(0,380,0,50) or UDim2.new(0,380,0,480)
    MinBtn.Text = minimized and "+" or "—"
end)

player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = newChar:WaitForChild("Humanoid")
    rootPart = newChar:WaitForChild("HumanoidRootPart")
    if speedEnabled then humanoid.WalkSpeed = 60 end
    if jumpEnabled then humanoid.JumpPower = 120 end
end)

-- ===================== ANIMACIÓN DE CARGA (al final, desbloquea el script) =====================
task.spa
