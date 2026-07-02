-- Mansion Tycoon v1.1 FINAL FIX
-- Creador: JoseAngel_Blox
-- Fecha: 01/07/2026

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Limpiar GUIs viejas
for _, child in pairs(player:WaitForChild("PlayerGui"):GetChildren()) do
    if child.Name == "MansionTycoonGUI" or child.Name == "Load_JA" then child:Destroy() end
end

-- ===================== PANTALLA DE CARGA =====================
local LoadGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
LoadGui.Name = "Load_JA"
local Container = Instance.new("Frame", LoadGui)
Container.Size = UDim2.new(1, 0, 1, 0)
Container.BackgroundTransparency = 1

local WelcomeLabel = Instance.new("TextLabel", Container)
WelcomeLabel.Text = ""
WelcomeLabel.Size = UDim2.new(1, 0, 0, 50)
WelcomeLabel.Position = UDim2.new(0, 0, 0.4, 0)
WelcomeLabel.BackgroundTransparency = 1
WelcomeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
WelcomeLabel.Font = Enum.Font.GothamBold
WelcomeLabel.TextScaled = true

local NameLabel = Instance.new("TextLabel", Container)
NameLabel.Text = ""
NameLabel.Size = UDim2.new(1, 0, 0, 70)
NameLabel.Position = UDim2.new(0, 0, 0.5, 0)
NameLabel.BackgroundTransparency = 1
NameLabel.TextColor3 = Color3.fromRGB(180, 100, 255)
NameLabel.Font = Enum.Font.GothamBold
NameLabel.TextScaled = true

-- ===================== GUI PRINCIPAL =====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MansionTycoonGUI"
ScreenGui.ResetOnSpawn = false
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
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(120, 80, 255)
MainStroke.Thickness = 2

local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 15, 50)
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 16)

local TitleLabel = Instance.new("TextLabel", TitleBar)
TitleLabel.Text = "🏰 Mansion Tycoon v1.1"
TitleLabel.Size = UDim2.new(1, -50, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextColor3 = Color3.fromRGB(200, 160, 255)
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

local MinBtn = Instance.new("TextButton", TitleBar)
MinBtn.Text = "—"
MinBtn.Size = UDim2.new(0, 35, 0, 28)
MinBtn.Position = UDim2.new(1, -42, 0, 8)
MinBtn.BackgroundColor3 = Color3.fromRGB(80, 40, 180)
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextScaled = true
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 8)

-- TABS
local TabBar = Instance.new("Frame", MainFrame)
TabBar.Size = UDim2.new(1, -20, 0, 38)
TabBar.Position = UDim2.new(0, 10, 0, 50)
TabBar.BackgroundColor3 = Color3.fromRGB(20, 10, 40)
Instance.new("UICorner", TabBar).CornerRadius = UDim.new(0, 10)

local TabLayout = Instance.new("UIListLayout", TabBar)
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
TabLayout.Padding = UDim.new(0, 6)

local PageHolder = Instance.new("Frame", MainFrame)
PageHolder.Size = UDim2.new(1, -20, 1, -100)
PageHolder.Position = UDim2.new(0, 10, 0, 95)
PageHolder.BackgroundTransparency = 1

local tabButtons = {}
local tabContents = {}

local function createTabPage(name)
    local btn = Instance.new("TextButton", TabBar)
    btn.Text = name
    btn.Size = UDim2.new(0, 100, 0, 28)
    btn.BackgroundColor3 = Color3.fromRGB(40, 20, 80)
    btn.TextColor3 = Color3.fromRGB(180, 140, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    local page = Instance.new("ScrollingFrame", PageHolder)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = Color3.fromRGB(120, 80, 255)
    page.Visible = false

    local layout = Instance.new("UIListLayout", page)
    layout.Padding = UDim.new(0, 8)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
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
        btn.BackgroundColor3 = (n == name) and Color3.fromRGB(100, 50, 220) or Color3.fromRGB(40, 20, 80)
        btn.TextColor3 = (n == name) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 140, 255)
    end
end

for name, btn in pairs(tabButtons) do btn.MouseButton1Click:Connect(function() switchTab(name) end) end
switchTab("Info")

-- HELPERS
local function createSectionLabel(parent, txt)
    local lbl = Instance.new("TextLabel", parent)
    lbl.Text = "— " .. txt .. " —"
    lbl.Size = UDim2.new(1, -10, 0, 24)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(140, 100, 255)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextScaled = true
end

local function createToggle(parent, labelText, callback)
    local holder = Instance.new("Frame", parent)
    holder.Size = UDim2.new(1, -10, 0, 38)
    holder.BackgroundColor3 = Color3.fromRGB(25, 15, 45)
    Instance.new("UICorner", holder).CornerRadius = UDim.new(0, 10)
    local lbl = Instance.new("TextLabel", holder)
    lbl.Text = labelText
    lbl.Size = UDim2.new(1, -60, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(220, 200, 255)
    lbl.Font = Enum.Font.Gotham
    lbl.TextScaled = true
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    local toggleBtn = Instance.new("TextButton", holder)
    toggleBtn.Size = UDim2.new(0, 44, 0, 24)
    toggleBtn.Position = UDim2.new(1, -52, 0.5, -12)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    toggleBtn.Text = ""
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1, 0)
    local knob = Instance.new("Frame", toggleBtn)
    knob.Size = UDim2.new(0, 18, 0, 18)
    knob.Position = UDim2.new(0, 3, 0.5, -9)
    knob.BackgroundColor3 = Color3.fromRGB(180, 180, 200)
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
    local state = false
    toggleBtn.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = state and Color3.fromRGB(100, 50, 220) or Color3.fromRGB(60, 60, 80)}):Play()
        TweenService:Create(knob, TweenInfo.new(0.2), {Position = state and UDim2.new(0, 23, 0.5, -9) or UDim2.new(0, 3, 0.5, -9), BackgroundColor3 = state and Color3.fromRGB(255,255,255) or Color3.fromRGB(180,180,200)}):Play()
        callback(state)
    end)
end

-- INFO
createSectionLabel(tabContents["Info"], "Información")
local function createLabel(parent, txt)
    local lbl = Instance.new("TextLabel", parent)
    lbl.Text = txt
    lbl.Size = UDim2.new(1, -10, 0, 28)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(200, 160, 255)
    lbl.Font = Enum.Font.Gotham
    lbl.TextScaled = true
    lbl.TextXAlignment = Enum.TextXAlignment.Left
end
createLabel(tabContents["Info"], "👤 Creador: JoseAngel_Blox")
createLabel(tabContents["Info"], "⚡ Versión: v1.1 FINAL")

-- MAIN
createSectionLabel(tabContents["Main"], "Auto Farm")

local autoBuildEnabled = false
local autoCollectEnabled = false

-- FILTRO EXTREMO ANTI-ROBUX
local function isSafeToBuild(v)
    if not (v:IsA("BasePart") and v.Name == "Touch") then return false end
    local p = v.Parent
    if not p then return false end
    
    -- Bloquear por GUIs de compra (Método más seguro)
    if p:FindFirstChild("GoldButtonGui") or p:FindFirstChild("RobuxGui") or p:FindFirstChild("ProductGui") or p:FindFirstChild("ButtonGui") then
        return false
    end
    
    -- Bloquear por Texto (Carteles)
    for _, child in pairs(p:GetChildren()) do
        if child:IsA("BillboardGui") or child:IsA("SurfaceGui") then
            for _, t in pairs(child:GetDescendants()) do
                if t:IsA("TextLabel") then
                    local txt = t.Text:lower()
                    if txt:find("robux") or txt:find("r%$") or txt:find("premium") or txt:find("vip") or txt:find("pack") or txt:find("like") or txt:find("thumb") or txt:find("goldify") then
                        return false
                    end
                end
            end
        end
    end
    
    -- Bloquear por Nombre del Botón
    local n = p.Name:lower()
    if n:find("robux") or n:find("vip") or n:find("pack") or n:find("like") or n:find("gold") or n:find("starter") or n:find("buycash") then
        return false
    end

    -- SOLO CONSTRUIR SI ES PARTE DE UN TYCOON (BOTONES NORMALES)
    if v:FindFirstAncestor("Buttons") or v:FindFirstAncestor("Unlocks") then
        return true
    end
    
    return false
end

createToggle(tabContents["Main"], "🏗️ Auto Build (SOLO CASH)", function(state)
    autoBuildEnabled = state
    task.spawn(function()
        while autoBuildEnabled do
            for _, v in pairs(workspace:GetDescendants()) do
                if not autoBuildEnabled then break end
                if isSafeToBuild(v) then
                    firetouchinterest(rootPart, v, 0)
                    firetouchinterest(rootPart, v, 1)
                end
            end
            task.wait(0.8)
        end
    end)
end)

createToggle(tabContents["Main"], "💰 Auto Collect Money", function(state)
    autoCollectEnabled = state
    task.spawn(function()
        while autoCollectEnabled do
            pcall(function()
                for _, t in pairs(workspace.Tycoons:GetChildren()) do
                    local collector = t:FindFirstChild("Collector", true)
                    if collector and collector:FindFirstChild("Touch") then
                        firetouchinterest(rootPart, collector.Touch, 0)
                        firetouchinterest(rootPart, collector.Touch, 1)
                    end
                end
            end)
            task.wait(1)
        end
    end)
end)

-- PLAYER
createSectionLabel(tabContents["Player"], "Player Options")
createToggle(tabContents["Player"], "⚡ Speed Hack", function(state) humanoid.WalkSpeed = state and 60 or 16 end)
createToggle(tabContents["Player"], "🦘 Salto Alto", function(state) humanoid.JumpPower = state and 120 or 50 end)

-- ANIMACIÓN Y CIERRE
task.spawn(function()
    local t1 = "✨ Bienvenidos a"
    for i = 1, #t1 do WelcomeLabel.Text = t1:sub(1, i) task.wait(0.05) end
    task.wait(0.2)
    local t2 = "Scripts JoseAngel_Blox"
    for i = 1, #t2 do NameLabel.Text = t2:sub(1, i) task.wait(0.06) end
    task.wait(1.5)
    LoadGui:Destroy()
    MainFrame.Visible = true
end)

MinBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)
