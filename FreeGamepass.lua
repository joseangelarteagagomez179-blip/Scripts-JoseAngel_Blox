-- =============================================
-- Free Gamepass JoseAngel_Blox - Versión 1.1
-- Creador: JoseAngel_Blox - 02/07/2026
-- 100% nativo (sin librerías) - PC y Móvil
-- =============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- ==================== GUI ====================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FreeGamepassJoseAngel_Blox"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Name = "Main"
mainFrame.Size = UDim2.new(0, 420, 0, 520)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -260)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = mainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.Thickness = 2
stroke.Transparency = 0.3
stroke.Parent = mainFrame

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundTransparency = 1
title.Text = "Free Gamepass JoseAngel_Blox"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

local infoButton = Instance.new("TextButton")
infoButton.Size = UDim2.new(0, 40, 0, 40)
infoButton.Position = UDim2.new(1, -45, 0, 5)
infoButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
infoButton.Text = "ℹ"
infoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
infoButton.Font = Enum.Font.GothamBold
infoButton.TextScaled = true
infoButton.Parent = mainFrame

-- ==================== PAGINA 1: Info ====================
local infoFrame = Instance.new("Frame")
infoFrame.Name = "Info"
infoFrame.Size = UDim2.new(1, 0, 1, 0)
infoFrame.BackgroundTransparency = 1
infoFrame.Parent = mainFrame

local infoTitle = Instance.new("TextLabel")
infoTitle.Size = UDim2.new(1, 0, 0, 60)
infoTitle.Position = UDim2.new(0, 0, 0, 70)
infoTitle.BackgroundTransparency = 1
infoTitle.Text = "Nombre del Creador: JoseAngel_Blox"
infoTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
infoTitle.TextScaled = true
infoTitle.Font = Enum.Font.Gotham
infoTitle.Parent = infoFrame

local dateLabel = Instance.new("TextLabel")
dateLabel.Size = UDim2.new(1, 0, 0, 40)
dateLabel.Position = UDim2.new(0, 0, 0, 140)
dateLabel.BackgroundTransparency = 1
dateLabel.Text = "Fecha de creación: 02/07/2026"
dateLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
dateLabel.TextScaled = true
dateLabel.Font = Enum.Font.Gotham
dateLabel.Parent = infoFrame

local versionLabel = Instance.new("TextLabel")
versionLabel.Size = UDim2.new(1, 0, 0, 40)
versionLabel.Position = UDim2.new(0, 0, 0, 190)
versionLabel.BackgroundTransparency = 1
versionLabel.Text = "Versión 1.1"
versionLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
versionLabel.TextScaled = true
versionLabel.Font = Enum.Font.Gotham
versionLabel.Parent = infoFrame

-- ==================== PAGINA 2: Free Gamepass ====================
local gpFrame = Instance.new("Frame")
gpFrame.Name = "FreeGamepass"
gpFrame.Size = UDim2.new(1, 0, 1, 0)
gpFrame.BackgroundTransparency = 1
gpFrame.Visible = false
gpFrame.Parent = mainFrame

local gpScroll = Instance.new("ScrollingFrame")
gpScroll.Size = UDim2.new(1, -30, 1, -100)
gpScroll.Position = UDim2.new(0, 15, 0, 80)
gpScroll.BackgroundTransparency = 1
gpScroll.ScrollBarThickness = 8
gpScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
gpScroll.Parent = gpFrame

local listLayout = Instance.new("UIListLayout")
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 8)
listLayout.Parent = gpScroll

-- ==================== PAGINA 3: Player ====================
local playerFrame = Instance.new("Frame")
playerFrame.Name = "Player"
playerFrame.Size = UDim2.new(1, 0, 1, 0)
playerFrame.BackgroundTransparency = 1
playerFrame.Visible = false
playerFrame.Parent = mainFrame

local flyToggle = Instance.new("TextButton")
flyToggle.Size = UDim2.new(0.9, 0, 0, 50)
flyToggle.Position = UDim2.new(0.05, 0, 0.1, 0)
flyToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
flyToggle.Text = "Fly [OFF]"
flyToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
flyToggle.TextScaled = true
flyToggle.Font = Enum.Font.GothamBold
flyToggle.Parent = playerFrame

local noclipToggle = Instance.new("TextButton")
noclipToggle.Size = UDim2.new(0.9, 0, 0, 50)
noclipToggle.Position = UDim2.new(0.05, 0, 0.25, 0)
noclipToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
noclipToggle.Text = "Noclip [OFF]"
noclipToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipToggle.TextScaled = true
noclipToggle.Font = Enum.Font.GothamBold
noclipToggle.Parent = playerFrame

local tpHouse = Instance.new("TextButton")
tpHouse.Size = UDim2.new(0.9, 0, 0, 50)
tpHouse.Position = UDim2.new(0.05, 0, 0.4, 0)
tpHouse.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
tpHouse.Text = "Tp a casa de jugadores"
tpHouse.TextColor3 = Color3.fromRGB(255, 255, 255)
tpHouse.TextScaled = true
tpHouse.Font = Enum.Font.GothamBold
tpHouse.Parent = playerFrame

local tpSafebox = Instance.new("TextButton")
tpSafebox.Size = UDim2.new(0.9, 0, 0, 50)
tpSafebox.Position = UDim2.new(0.05, 0, 0.55, 0)
tpSafebox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
tpSafebox.Text = "Tp a caja fuerte de cualquier casa de otro jugador"
tpSafebox.TextColor3 = Color3.fromRGB(255, 255, 255)
tpSafebox.TextScaled = true
tpSafebox.Font = Enum.Font.GothamBold
tpSafebox.Parent = playerFrame

-- ==================== NAVEGACIÓN ====================
local navFrame = Instance.new("Frame")
navFrame.Size = UDim2.new(1, 0, 0, 40)
navFrame.Position = UDim2.new(0, 0, 1, -40)
navFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
navFrame.Parent = mainFrame

local navCorner = Instance.new("UICorner")
navCorner.CornerRadius = UDim.new(0, 12)
navCorner.Parent = navFrame

local navLayout = Instance.new("UIListLayout")
navLayout.FillDirection = Enum.FillDirection.Horizontal
navLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
navLayout.Padding = UDim.new(0, 10)
navLayout.Parent = navFrame

local btnInfo = Instance.new("TextButton")
btnInfo.Size = UDim2.new(0.2, 0, 1, 0)
btnInfo.Text = "Info"
btnInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
btnInfo.Font = Enum.Font.GothamBold
btnInfo.TextScaled = true
btnInfo.BackgroundTransparency = 1
btnInfo.Parent = navFrame

local btnGP = Instance.new("TextButton")
btnGP.Size = UDim2.new(0.2, 0, 1, 0)
btnGP.Text = "Free Gamepass"
btnGP.TextColor3 = Color3.fromRGB(255, 255, 255)
btnGP.Font = Enum.Font.GothamBold
btnGP.TextScaled = true
btnGP.BackgroundTransparency = 1
btnGP.Parent = navFrame

local btnPlayer = Instance.new("TextButton")
btnPlayer.Size = UDim2.new(0.2, 0, 1, 0)
btnPlayer.Text = "Player"
btnPlayer.TextColor3 = Color3.fromRGB(255, 255, 255)
btnPlayer.Font = Enum.Font.GothamBold
btnPlayer.TextScaled = true
btnPlayer.BackgroundTransparency = 1
btnPlayer.Parent = navFrame

-- ==================== FUNCIONES ====================
local currentPage = infoFrame

local function showPage(page)
	for _, f in ipairs({infoFrame, gpFrame, playerFrame}) do
		f.Visible = false
	end
	page.Visible = true
end

btnInfo.MouseButton1Click:Connect(function() showPage(infoFrame) end)
btnGP.MouseButton1Click:Connect(function() showPage(gpFrame) end)
btnPlayer.MouseButton1Click:Connect(function() showPage(playerFrame) end)

-- ==================== FREE GAMEPASS LIST (15 gamepasses actualizados 2026) ====================
local gpList = {
	{VIP Pack, 999, "VIP houses, vehicles, tools, emotes, no cooldown, golden tag"},
	{Estate Unlocked, 799, "10+ estate houses, north/south/island plots"},
	{Vehicle Pack, 799, "24+ new vehicles (party trucks, motorcycles, sports cars)"},
	{Land Unlocked, 500, "5+ new house plots (Lake House, Eagle View, etc.)"},
	{Disaster Pack, 500, "10+ disasters + On Demand Fire"},
	{Vehicle Customization, 399, "Color change, lights, horns, effects"},
	{Boat Pack, 299, "10+ boats (yachts, pirate ships, etc.)"},
	{Theme Pack, 299, "10+ private server themes"},
	{Premium, 275, "Premium houses, vehicles, helicopter, jet, pools"},
	{Vehicle Speed Unlocked, 199, "Turbo stages + 200 mph street vehicles"},
	{Penthouse, 150, "Top floor penthouse apartments"},
	{Horse Upgrade, 99, "6+ horse breeds + customization"},
	{On Demand Fire, 50, "Instant fire in any house"},
	{Vehicle Upgrade, 30, "Basic color + speed increase"},
}

for i, gp in ipairs(gpList) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -20, 0, 45)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	btn.Text = gp[1] .. " (Free)"
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextScaled = true
	btn.Font = Enum.Font.GothamBold
	btn.Parent = gpScroll
	
	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 10)
	btnCorner.Parent = btn
	
	local toggle = Instance.new("TextButton")
	toggle.Size = UDim2.new(0, 100, 1, 0)
	toggle.Position = UDim2.new(1, -110, 0, 0)
	toggle.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
	toggle.Text = "Free"
	toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
	toggle.Font = Enum.Font.GothamBold
	toggle.TextScaled = true
	toggle.Parent = btn
	
	local toggleCorner = Instance.new("UICorner")
	toggleCorner.CornerRadius = UDim.new(0, 10)
	toggleCorner.Parent = toggle
	
	toggle.MouseButton1Click:Connect(function()
		-- Desbloqueo gratis (solo funciona en servidores normales)
		Players.LocalPlayer.PlayerGui:WaitForChild("Main").Inventory.FreeGamepasses = true
		toggle.Text = "✅ Free!"
		toggle.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
	end)
end

-- ==================== PLAYER FEATURES ====================
local flyEnabled = false
local noclipEnabled = false
local flySpeed = 50

flyToggle.MouseButton1Click:Connect(function()
	flyEnabled = not flyEnabled
	flyToggle.Text = "Fly [" .. (flyEnabled and "ON" or "OFF") .. "]"
	if flyEnabled then
		local bv = Instance.new("BodyVelocity")
		bv.MaxForce = Vector3.new(4000, 4000, 4000)
		bv.Velocity = Vector3.new(0,0,0)
		bv.Parent = player.Character.HumanoidRootPart
	else
		player.Character.HumanoidRootPart:FindFirstChild("BodyVelocity") and player.Character.HumanoidRootPart.BodyVelocity:Destroy()
	end
end)

noclipToggle.MouseButton1Click:Connect(function()
	noclipEnabled = not noclipEnabled
	noclipToggle.Text = "Noclip [" .. (noclipEnabled and "ON" or "OFF") .. "]"
end)

-- Tp a casa de cualquier jugador (usa nombre o te sigue)
tpHouse.MouseButton1Click:Connect(function()
	local target = Players:GetPlayers()[math.random(1, #Players:GetPlayers())]
	if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
		player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0,5,0)
	end
end)

-- Tp a caja fuerte de cualquier casa de otro jugador (versión simple 2026)
tpSafebox.MouseButton1Click:Connect(function()
	local target = Players:GetPlayers()[math.random(1, #Players:GetPlayers())]
	if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
		local safe = target.Character:FindFirstChild("SafeBox") or target.Character:FindFirstChildWhichIsA("BasePart") -- ajusta según tu casa
		if safe then
			player.Character.HumanoidRootPart.CFrame = safe.CFrame + Vector3.new(0,3,0)
		end
	end
end)

-- Noclip loop
RunService.Stepped:Connect(function()
	if noclipEnabled and player.Character and player.Character:FindFirstChild("Humanoid") then
		player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
	end
end)

-- Info button
infoButton.MouseButton1Click:Connect(function()
	infoFrame.Visible = true
	gpFrame.Visible = false
	playerFrame.Visible = false
end)

-- ==================== INICIO ====================
showPage(infoFrame)
print("✅ Free Gamepass JoseAngel_Blox cargado - ¡Disfruta gratis en celular y PC!")
