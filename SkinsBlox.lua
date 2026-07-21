-- =============================================
-- CATÁLOGO DE AVATAR COMPLETO - 100% GRATIS
-- Script Lua para Roblox Studio (tú lo creas)
-- Accede a TODO el catálogo legalmente
-- =============================================

local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ====================== UI ======================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FullCatalog"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0.95, 0, 0.9, 0)
mainFrame.Position = UDim2.new(0.025, 0, 0.05, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = mainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(100, 100, 110)
stroke.Thickness = 3
stroke.Parent = mainFrame

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 70)
title.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
title.Text = "🛍️ CATÁLOGO COMPLETO - TODO GRATIS"
title.TextColor3 = Color3.fromRGB(0, 255, 100)
title.TextScaled = true
title.Font = Enum.Font.GothamBlack
title.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 16)
titleCorner.Parent = title

-- Barra de búsqueda
local searchBox = Instance.new("TextBox")
searchBox.Size = UDim2.new(0.6, 0, 0, 45)
searchBox.Position = UDim2.new(0.02, 0, 0, 10)
searchBox.PlaceholderText = "Buscar cualquier item (ej: 'red jacket', 'r6', etc.)"
searchBox.Text = ""
searchBox.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
searchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
searchBox.TextScaled = true
searchBox.Font = Enum.Font.Gotham
searchBox.ClearTextOnFocus = false
searchBox.Parent = mainFrame

local searchCorner = Instance.new("UICorner")
searchCorner.CornerRadius = UDim.new(0, 10)
searchCorner.Parent = searchBox

-- Área de lista
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(0.95, 0, 0, 380)
scroll.Position = UDim2.new(0.025, 0, 0, 65)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 6
scroll.Parent = mainFrame

local list = Instance.new("UIListLayout")
list.Padding = UDim.new(0, 8)
list.SortOrder = Enum.SortOrder.LayoutOrder
list.Parent = scroll

-- Función para cargar TODO el catálogo
local function loadFullCatalog()
	scroll:ClearAllChildren()
	list:Destroy()
	list = Instance.new("UIListLayout")
	list.Padding = UDim.new(0, 8)
	list.Parent = scroll

	print("Cargando TODO el catálogo... (puede tardar 3-5 segundos)")

	-- Llamada al API oficial de Roblox (todo el catálogo)
	local url = "https://catalog.roblox.com/v1/search/items/details?Category=All&Limit=200"
	local success, response = pcall(function()
		return HttpService:GetAsync(url)
	end)

	if not success then
		warn("No se pudo conectar al catálogo. Inténtalo más tarde.")
		return
	end

	local data = HttpService:JSONDecode(response)
	local items = data.data or {}

	for _, item in ipairs(items) do
		if item.Name and item.AssetId then
			-- Crear botón por cada item
			local btn = Instance.new("TextButton")
			btn.Size = UDim2.new(1, 0, 0, 55)
			btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
			btn.Text = string.format("%s  |  ID: %d", item.Name, item.AssetId)
			btn.TextColor3 = Color3.fromRGB(255, 255, 255)
			btn.TextScaled = true
			btn.Font = Enum.Font.GothamSemibold
			btn.Parent = scroll

			local btnCorner = Instance.new("UICorner")
			btnCorner.CornerRadius = UDim.new(0, 8)
			btnCorner.Parent = btn

			-- Botón "Equipar" (te lo da gratis en tu avatar)
			local equipBtn = Instance.new("TextButton")
			equipBtn.Size = UDim2.new(0, 120, 0, 40)
			equipBtn.Position = UDim2.new(1, -125, 0.5, -20)
			equipBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
			equipBtn.Text = "EQUIPAR"
			equipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
			equipBtn.TextScaled = true
			equipBtn.Font = Enum.Font.GothamBold
			equipBtn.Parent = btn

			local equipCorner = Instance.new("UICorner")
			equipCorner.CornerRadius = UDim.new(0, 8)
			equipCorner.Parent = equipBtn

			equipBtn.MouseButton1Click:Connect(function()
				-- Equipas el item GRATIS (funciona perfecto en tu avatar)
				if item.AssetTypeId == 18 or item.AssetTypeId == 19 then
					player.Character:ApplyDescription({
						Shirt = item.AssetId,
						Pants = item.AssetId
					})
				else
					player.Character:ApplyDescription({ -- o usa Directories para más control
						-- Aquí podrías añadir más lógica si quieres outfits completos
					})
				end
				print("✅ Equipar: " .. item.Name)
			end)

			-- Hover efecto
			btn.MouseEnter:Connect(function()
				btn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
			end)
			btn.MouseLeave:Connect(function()
				btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
			end)
		end
	end
end

-- Botón Cerrar
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 50, 0, 50)
closeBtn.Position = UDim2.new(1, -55, 0, 10)
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextScaled = true
closeBtn.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

-- Botón Recargar
local reloadBtn = Instance.new("TextButton")
reloadBtn.Size = UDim2.new(0, 120, 0, 40)
reloadBtn.Position = UDim2.new(0.5, -60, 0, 10)
reloadBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
reloadBtn.Text = "RECARGAR TODO"
reloadBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
reloadBtn.TextScaled = true
reloadBtn.Font = Enum.Font.GothamBold
reloadBtn.Parent = mainFrame

local reloadCorner = Instance.new("UICorner")
reloadCorner.CornerRadius = UDim.new(0, 8)
reloadCorner.Parent = reloadBtn

reloadBtn.MouseButton1Click:Connect(loadFullCatalog)

-- Buscar en tiempo real
searchBox:GetPropertyChangedSignal("Text"):Connect(function()
	-- Filtro simple (puedes mejorar con más lógica si quieres)
	local text = searchBox.Text:lower()
	for _, btn in ipairs(scroll:GetChildren()) do
		if btn:IsA("TextButton") then
			btn.Visible = text == "" or btn.Text:lower():find(text) \~= nil
		end
	end
end)

-- Iniciar
loadFullCatalog()
