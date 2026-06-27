-- ⚡ SCRIPT HOSHI HUB - VERSION FINAL ⚡
-- Interfaz Cuadrada | Esquinas Redondas | Funciones Originales

-- Cargar el sistema original para que funcionen los botones
loadstring(game:HttpGet("https://hoshihub.site/loader.lua"))()

-- Servicios
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- =============================================
-- CREAR INTERFAZ
-- =============================================
local Gui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Esquinas = Instance.new("UICorner")
local Titulo = Instance.new("TextLabel")

-- Propiedades
Gui.Name = "HoshiHubGui"
Gui.Parent = game:GetService("CoreGui")

Main.Name = "MainFrame"
Main.Parent = Gui
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.05, 0, 0.2, 0)
Main.Size = UDim2.new(0, 250, 0, 300) -- Cuadrado
Main.Active = true
Main.Draggable = true -- Se puede mover

Esquinas.Parent = Main
Esquinas.CornerRadius = UDim.new(0, 16) -- Esquinas bien redondas

Titulo.Parent = Main
Titulo.BackgroundTransparency = 1
Titulo.Size = UDim2.new(1, 0, 0, 40)
Titulo.Font = Enum.Font.GothamBold
Titulo.Text = "⭐ HOSHI HUB ⭐"
Titulo.TextColor3 = Color3.new(1,1,1)
Titulo.TextSize = 18

-- =============================================
-- BOTONES
-- =============================================

-- 🟢 AUTO FARM
local BtnFarm = Instance.new("TextButton")
BtnFarm.Parent = Main
BtnFarm.BackgroundColor3 = Color3.fromRGB(40, 60, 90)
BtnFarm.BorderSizePixel = 0
BtnFarm.Position = UDim2.new(0.08, 0, 0.20, 0)
BtnFarm.Size = UDim2.new(0.84, 0, 0, 45)
BtnFarm.Text = "⚡ AUTO FARM"
BtnFarm.TextColor3 = Color3.new(1,1,1)
BtnFarm.TextSize = 15
local c1 = Instance.new("UICorner", BtnFarm)
c1.CornerRadius = UDim.new(0,8)

-- 🔵 AUTO WIN
local BtnWin = Instance.new("TextButton")
BtnWin.Parent = Main
BtnWin.BackgroundColor3 = Color3.fromRGB(40, 60, 90)
BtnWin.BorderSizePixel = 0
BtnWin.Position = UDim2.new(0.08, 0, 0.40, 0)
BtnWin.Size = UDim2.new(0.84, 0, 0, 45)
BtnWin.Text = "🏁 AUTO WIN"
BtnWin.TextColor3 = Color3.new(1,1,1)
BtnWin.TextSize = 15
local c2 = Instance.new("UICorner", BtnWin)
c2.CornerRadius = UDim.new(0,8)

-- 🟣 CINTAS GRATIS
local BtnTreads = Instance.new("TextButton")
BtnTreads.Parent = Main
BtnTreads.BackgroundColor3 = Color3.fromRGB(80, 40, 120)
BtnTreads.BorderSizePixel = 0
BtnTreads.Position = UDim2.new(0.08, 0, 0.60, 0)
BtnTreads.Size = UDim2.new(0.84, 0, 0, 45)
BtnTreads.Text = "💎 CINTAS GRATIS"
BtnTreads.TextColor3 = Color3.new(1,1,1)
BtnTreads.TextSize = 15
local c3 = Instance.new("UICorner", BtnTreads)
c3.CornerRadius = UDim.new(0,8)

-- =============================================
-- FUNCIONES (Conectadas al script original)
-- =============================================

-- Estados
local FarmOn = false
local WinOn = false
local TreadsOn = false

BtnFarm.MouseButton1Click:Connect(function()
    FarmOn = not FarmOn
    if FarmOn then
        BtnFarm.Text = "⏸️ AUTO FARM ON"
        BtnFarm.BackgroundColor3 = Color3.fromRGB(120, 30, 30)
        -- Aquí activamos la función del Hoshi Hub original
        fireclickdetector(workspace.HoshiHub.Buttons.AutoFarm.ClickDetector)
    else
        BtnFarm.Text = "⚡ AUTO FARM"
        BtnFarm.BackgroundColor3 = Color3.fromRGB(40, 60, 90)
        fireclickdetector(workspace.HoshiHub.Buttons.AutoFarm.ClickDetector)
    end
end)

BtnWin.MouseButton1Click:Connect(function()
    WinOn = not WinOn
    if WinOn then
        BtnWin.Text = "⏸️ AUTO WIN ON"
        BtnWin.BackgroundColor3 = Color3.fromRGB(120, 30, 30)
        fireclickdetector(workspace.HoshiHub.Buttons.AutoWin.ClickDetector)
    else
        BtnWin.Text = "🏁 AUTO WIN"
        BtnWin.BackgroundColor3 = Color3.fromRGB(40, 60, 90)
        fireclickdetector(workspace.HoshiHub.Buttons.AutoWin.ClickDetector)
    end
end)

BtnTreads.MouseButton1Click:Connect(function()
    BtnTreads.Text = "✅ DESBLOQUEADO!"
    BtnTreads.BackgroundColor3 = Color3.fromRGB(30, 130, 50)
    -- Activar cintas gratis
    fireclickdetector(workspace.HoshiHub.Buttons.FreeTreadmills.ClickDetector)
    wait(1.5)
    BtnTreads.Text = "💎 CINTAS GRATIS"
    BtnTreads.BackgroundColor3 = Color3.fromRGB(80, 40, 120)
end)

print("✅ Hoshi Hub cargado con interfaz personalizada!")
