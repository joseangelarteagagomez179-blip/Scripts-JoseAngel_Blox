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

-- ===================== GUI =====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MansionTycoonGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = gethui and gethui() or player.PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 380, 0, 480)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -240)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(120, 80, 255)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 15, 50)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 16)
TitleCorner.Parent = TitleBar

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

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 8)
MinCorner.Parent = MinBtn

-- ===================== TABS =====================
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, -20, 0, 38)
TabBar.Position = UDim2.new(0, 10, 0, 50)
TabBar.BackgroundColor3 = Color3.fromRGB(20, 10, 40)
TabBar.BorderSizePixel = 0
TabBar.Parent = MainFrame

local TabCorner = Instance.new("UICorner")
TabCorner.CornerRadius = UDim.new(0, 10)
TabCorner.Parent = TabBar

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
local tabNames = {"Info", "Main", "Player"}

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

    local bc = Instance.new("UICorner")
    bc.CornerRadius = UDim.new(0, 8)
    bc.Parent = btn

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

for _, name in ipairs(tabNames) do
    local btn, page = createTabPage(name)
    tabButtons[name] = btn
    tabContents[name] = page
end

local function switchTab(name)
    for n, page in pairs(tabContents) do
        page.Visible = (n == name)
    end
    for n, btn in pairs(tabButtons) do
        if n == name then
            btn.BackgroundColor3 = Color3.fromRGB(100, 50, 220)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            btn.BackgroundColor3 = Color3.fromRGB(40, 20, 80)
            btn.TextColor3 = Color3.fromRGB(180, 140, 255)
        end
    end
end

for name, btn in pairs(tabButtons) do
    btn.MouseButton1Click:Connect(function()
        switchTab(name)
    end)
end

switchTab("Info")

-- ===================== HELPERS =====================
local function createLabel(parent, txt, color)
    color = color or Color3.fromRGB(200, 160, 255)
    local lbl = Instance.new("TextLabel")
    lbl.Text = txt
    lbl.Size = UDim2.new(1, -10, 0, 28)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = color
    lbl.Font = Enum.Font.Gotham
    lbl.TextScaled = true
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = parent
    return lbl
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
    return lbl
end

local function createToggle(parent, labelText, callback)
    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1, -10, 0, 38)
    holder.BackgroundColor3 = Color3.fromRGB(25, 15, 45)
    holder.BorderSizePixel = 0
    holder.Parent = parent

    local hc = Instance.new("UICorner")
    hc.CornerRadius = UDim.new(0, 10)
    hc.Parent = holder

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
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Parent = holder

    local tc = Instance.new("UICorner")
    tc.CornerRadius = UDim.new(1, 0)
    tc.Parent = toggleBtn

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 18, 0, 18)
    knob.Position = UDim2.new(0, 3, 0.5, -9)
    knob.BackgroundColor3 = Color3.fromRGB(180, 180, 200)
    knob.BorderSizePixel = 0
    knob.Parent = toggleBtn

    local kc = Instance.new("UICorner")
    kc.CornerRadius = UDim.new(1, 0)
    kc.Parent = knob

    local state = false
    toggleBtn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100, 50, 220)}):Play()
            TweenService:Create(knob, TweenInfo.new(0.2), {Position = UDim2.new(0, 23, 0.5, -9), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        else
            TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 80)}):Play()
            TweenService:Create(knob, TweenInfo.new(0.2), {Position = UDim2.new(0, 3, 0.5, -9), BackgroundColor3 = Color3.fromRGB(180, 180, 200)}):Play()
        end
        callback(state)
    end)
end

-- ===================== TAB: INFO =====================
local infoPage = tabContents["Info"]
createSectionLabel(infoPage, "Información")
createLabel(infoPage, "👤 Creador: JoseAngel_Blox")
createLabel(infoPage, "📅 Fecha: 01/07/2026")
createLabel(infoPage, "🎮 Juego: Mansion Tycoon")
createLabel(infoPage, "⚡ Versión: v1.1")
createLabel(infoPage, "📱 Executor: Delta (Android)")
createLabel(infoPage, "✨ Disfruta el script!", Color3.fromRGB(160, 255, 160))

-- ===================== TAB: MAIN =====================
local mainPage = tabContents["Main"]
createSectionLabel(mainPage, "Auto Farm")

local autoBuildEnabled = false
local autoCollectEnabled = false

createToggle(mainPage, "🏗️ Auto Build", function(state)
    autoBuildEnabled = state
    if state then
        task.spawn(function()
            while autoBuildEnabled do
                local tycoons = workspace:FindFirstChild("Tycoons")
                if tycoons then
                    for _, obj in pairs(tycoons:GetDescendants()) do
                        if obj:IsA("BasePart") and (obj.Name == "Button" or obj.Name == "BuyButton" or obj.Name == "PurchaseButton") then
                            local remote = game:GetService("ReplicatedStorage"):FindFirstChild("BuyPlot", true)
                                or game:GetService("ReplicatedStorage"):FindFirstChild("Purchase", true)
                                or game:GetService("ReplicatedStorage"):FindFirstChild("BuyItem", true)
                            if remote then
                                if remote:IsA("RemoteEvent") then
                                    remote:FireServer(obj)
                                elseif remote:IsA("RemoteFunction") then
                                    remote:InvokeServer(obj)
                                end
                            end
                            task.wait(0.3)
                        end
                    end
                end
                task.wait(1)
            end
        end)
    end
end)

createToggle(mainPage, "💰 Auto Collect Money", function(state)
    autoCollectEnabled = state
    if state then
        task.spawn(function()
            while autoCollectEnabled do
                local tycoons = workspace:FindFirstChild("Tycoons")
                if tycoons then
                    for _, obj in pairs(tycoons:GetDescendants()) do
                        if obj:IsA("BasePart") and (obj.Name == "Collector" or obj.Name == "MoneyBag" or obj.Name == "Cash" or obj.Name == "Coin") then
                            if (obj.Position - rootPart.Position).Magnitude < 200 then
                                rootPart.CFrame = CFrame.new(obj.Position)
                                task.wait(0.1)
                            end
                        end
                    end
                    local collectRemote = game:GetService("ReplicatedStorage"):FindFirstChild("Collect", true)
                        or game:GetService("ReplicatedStorage"):FindFirstChild("CollectMoney", true)
                    if collectRemote and collectRemote:IsA("RemoteEvent") then
                        collectRemote:FireServer()
                    end
                end
                task.wait(0.5)
            end
        end)
    end
end)

-- ===================== TAB: PLAYER =====================
local playerPage = tabContents["Player"]
createSectionLabel(playerPage, "Player Options")

local speedEnabled = false
local jumpEnabled = false
local noclipEnabled = false
local espEnabled = false
local espObjects = {}

createToggle(playerPage, "⚡ Speed Hack", function(state)
    speedEnabled = state
    if humanoid then
        humanoid.WalkSpeed = state and 60 or 16
    end
end)

createToggle(playerPage, "🦘 Salto Alto", function(state)
    jumpEnabled = state
    if humanoid then
        humanoid.JumpPower = state and 120 or 50
    end
end)

createToggle(playerPage, "👻 Noclip", function(state)
    noclipEnabled = state
end)

RunService.Stepped:Connect(function()
    if noclipEnabled and character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
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
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local bb = Instance.new("BillboardGui")
                bb.Size = UDim2.new(0, 80, 0, 30)
                bb.StudsOffset = Vector3.new(0, 3, 0)
                bb.AlwaysOnTop = true
                bb.Parent = root

                local lbl = Instance.new("TextLabel")
                lbl.Size = UDim2.new(1, 0, 1, 0)
                lbl.BackgroundTransparency = 1
                lbl.Text = plr.Name
                lbl.TextColor3 = Color3.fromRGB(255, 80, 80)
                lbl.Font = Enum.Font.GothamBold
                lbl.TextScaled = true
                lbl.Parent = bb

                table.insert(espObjects, bb)
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
                task.wait(2)
                if espEnabled then createESP() end
            end
        end)
    else
        clearESP()
    end
end)

-- ===================== MINIMIZAR =====================
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    PageHolder.Visible = not minimized
    TabBar.Visible = not minimized
    MainFrame.Size = minimized and UDim2.new(0, 380, 0, 50) or UDim2.new(0, 380, 0, 480)
    MinBtn.Text = minimized and "+" or "—"
end)

player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = newChar:WaitForChild("Humanoid")
    rootPart = newChar:WaitForChild("HumanoidRootPart")
    if speedEnabled then humanoid.WalkSpeed = 60 end
    if jumpEnabled then humanoid.JumpPower = 120 end
end)

print("✅ Mansion Tycoon v1.1 cargado | by JoseAngel_Blox")
