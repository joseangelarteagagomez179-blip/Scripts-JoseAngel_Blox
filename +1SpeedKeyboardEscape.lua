-- ⚡ HOSHI HUB - VERSIÓN FINAL CON EFECTOS ⚡
-- FONDO MORADO LED BRILLANDO Y EN MOVIMIENTO

loadstring(game:HttpGet("https://hoshihub.site/loader.lua"))()

-- Servicios
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

-- =============================================
-- INTERFAZ CON FONDO ANIMADO
-- =============================================
local Gui = Instance.new("ScreenGui")
Gui.Name = "HoshiHubGui"
Gui.Parent = game:GetService("CoreGui")

-- Marco Principal
local Main = Instance.new("Frame")
Main.Name = "MainFrame"
Main.Parent = Gui
Main.BackgroundColor3 = Color3.fromRGB(25, 15, 40)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.05, 0, 0.10, 0)
Main.Size = UDim2.new(0, 240, 0, 620)
Main.Active = true
Main.Draggable = true
Main.ClipsDescendants = true

-- Esquinas Redondas
local Esquinas = Instance.new("UICorner")
Esquinas.Parent = Main
Esquinas.CornerRadius = UDim.new(0, 16)

-- 🟣 FONDO CON EFECTO LED MORADO
local BackgroundEffect = Instance.new("Frame")
BackgroundEffect.Name = "BackgroundEffect"
BackgroundEffect.Parent = Main
BackgroundEffect.BackgroundColor3 = Color3.fromRGB(80, 20, 120)
BackgroundEffect.BorderSizePixel = 0
BackgroundEffect.Size = UDim2.new(1, 0, 1, 0)
BackgroundEffect.ZIndex = 0

local CornerBg = Instance.new("UICorner", BackgroundEffect)
CornerBg.CornerRadius = UDim.new(0, 16)

-- Borde Brillante
local GlowBorder = Instance.new("UIStroke")
GlowBorder.Parent = Main
GlowBorder.Thickness = 2
GlowBorder.Color = Color3.fromRGB(180, 80, 255)
GlowBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- =============================================
-- ANIMACIÓN DE LUCES Y BRILLO
-- =============================================
local brightness = 0
local direction = 1

RunService.Heartbeat:Connect(function()
    brightness = brightness + (0.02 * direction)
    if brightness >= 1 then direction = -1 end
    if brightness <= 0 then direction = 1 end
    
    -- Cambiar transparencia y brillo
    GlowBorder.Transparency = 0.7 - (brightness * 0.5)
    BackgroundEffect.BackgroundTransparency = 0.3 - (brightness * 0.2)
    
    -- Cambiar color suavemente
    local r = 80 + math.sin(brightness * math.pi * 2) * 20
    local g = 20 + math.cos(brightness * math.pi * 2) * 10
    local b = 120 + math.sin(brightness * math.pi * 3) * 30
    BackgroundEffect.BackgroundColor3 = Color3.new(r/255, g/255, b/255)
end)

-- =============================================
-- TITULO
-- =============================================
local Titulo = Instance.new("TextLabel")
Titulo.Parent = Main
Titulo.BackgroundTransparency = 1
Titulo.Size = UDim2.new(1, 0, 0, 40)
Titulo.Font = Enum.Font.GothamBold
Titulo.Text = "⭐ HOSHI HUB ⭐"
Titulo.TextColor3 = Color3.new(1, 1, 1)
Titulo.TextSize = 18
Titulo.ZIndex = 2

-- =============================================
-- FUNCIÓN PARA CREAR BOTONES SEMI-TRANSPARENTES
-- =============================================
local function CrearBoton(nombre, posicion, color)
    local btn = Instance.new("TextButton")
    btn.Parent = Main
    btn.BackgroundColor3 = color or Color3.fromRGB(60, 30, 90)
    btn.BackgroundTransparency = 0.3
    btn.BorderSizePixel = 0
    btn.Position = posicion
    btn.Size = UDim2.new(0.84, 0, 0, 32)
    btn.Text = nombre
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextSize = 11
    btn.ZIndex = 2
    
    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0,8)
    
    -- Efecto al pasar el mouse
    btn.MouseEnter:Connect(function()
        btn.BackgroundTransparency = 0.1
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundTransparency = 0.3
    end)
    
    return btn
end

-- =============================================
-- TODOS LOS BOTONES
-- =============================================

-- PRINCIPALES
local BtnSpeed = CrearBoton("⚡ AUTO SPEED", UDim2.new(0.08, 0, 0.10, 0))
local BtnWin = CrearBoton("🏁 AUTO WIN", UDim2.new(0.08, 0, 0.16, 0))
local BtnWorld = CrearBoton("🌍 WORLD", UDim2.new(0.08, 0, 0.22, 0))
local BtnGod = CrearBoton("🛡️ GOD MODE", UDim2.new(0.08, 0, 0.28, 0))
local BtnObstacle = CrearBoton("🧱 OBSTACLE & SAFETY", UDim2.new(0.08, 0, 0.34, 0))
local BtnRebirth = CrearBoton("🔄 AUTO REBIRTH", UDim2.new(0.08, 0, 0.40, 0))

-- MOVIMIENTO
local BtnWalk = CrearBoton("👟 WALK SPEED", UDim2.new(0.08, 0, 0.46, 0), Color3.fromRGB(70, 35, 105))
local BtnJump = CrearBoton("🦘 JUMP POWER", UDim2.new(0.08, 0, 0.52, 0), Color3.fromRGB(70, 35, 105))
local BtnGravity = CrearBoton("🌌 GRAVITY", UDim2.new(0.08, 0, 0.58, 0), Color3.fromRGB(70, 35, 105))
local BtnHips = CrearBoton("💃 HIPS DANCE", UDim2.new(0.08, 0, 0.64, 0), Color3.fromRGB(90, 40, 85))
local BtnSpin = CrearBoton("🌀 SPIN BOT", UDim2.new(0.08, 0, 0.70, 0), Color3.fromRGB(90, 40, 85))

-- TIENDA Y EFECTOS
local BtnTrails = CrearBoton("✨ TRAILS / ESTELAS", UDim2.new(0.08, 0, 0.76, 0), Color3.fromRGB(50, 30, 95))
local BtnAuras = CrearBoton("💫 AURAS", UDim2.new(0.08, 0, 0.81, 0), Color3.fromRGB(50, 30, 95))
local BtnAutoBuy = CrearBoton("🛒 AUTO BUY ITEMS", UDim2.new(0.08, 0, 0.86, 0), Color3.fromRGB(95, 75, 35))
local BtnUnlockTreads = CrearBoton("🔓 UNLOCK ALL TREADMILL", UDim2.new(0.08, 0, 0.91, 0), Color3.fromRGB(35, 105, 70))
local BtnUnlockSound = CrearBoton("🔊 UNLOCK ALL SOUND", UDim2.new(0.08, 0, 0.96, 0), Color3.fromRGB(35, 105, 70))

-- =============================================
-- FUNCIONES Y ESTADOS
-- =============================================
local function ToggleButton(btn, name, path)
    local on = false
    return function()
        on = not on
        if on then
            btn.Text = "⏸️ "..name.." ON"
            btn.BackgroundColor3 = Color3.fromRGB(130, 30, 60)
        else
            btn.Text = name
            btn.BackgroundColor3 = Color3.fromRGB(60, 30, 90)
        end
        fireclickdetector(workspace.HoshiHub.Buttons[path].ClickDetector)
    end
end

BtnSpeed.MouseButton1Click:Connect(ToggleButton(BtnSpeed, "AUTO SPEED", "AutoSpeed"))
BtnWin.MouseButton1Click:Connect(ToggleButton(BtnWin, "AUTO WIN", "AutoWin"))
BtnWorld.MouseButton1Click:Connect(ToggleButton(BtnWorld, "WORLD", "World"))
BtnGod.MouseButton1Click:Connect(ToggleButton(BtnGod, "GOD MODE", "GodMode"))
BtnObstacle.MouseButton1Click:Connect(ToggleButton(BtnObstacle, "OBSTACLE", "Obstacle"))
BtnRebirth.MouseButton1Click:Connect(ToggleButton(BtnRebirth, "AUTO REBIRTH", "AutoRebirth"))
BtnWalk.MouseButton1Click:Connect(ToggleButton(BtnWalk, "WALK SPEED", "WalkSpeed"))
BtnJump.MouseButton1Click:Connect(ToggleButton(BtnJump, "JUMP POWER", "JumpPower"))
BtnGravity.MouseButton1Click:Connect(ToggleButton(BtnGravity, "GRAVITY", "Gravity"))
BtnHips.MouseButton1Click:Connect(ToggleButton(BtnHips, "HIPS DANCE", "HipsDance"))
BtnSpin.MouseButton1Click:Connect(ToggleButton(BtnSpin, "SPIN BOT", "SpinBot"))
BtnTrails.MouseButton1Click:Connect(ToggleButton(BtnTrails, "TRAILS", "Trails"))
BtnAuras.MouseButton1Click:Connect(ToggleButton(BtnAuras, "AURAS", "Auras"))
BtnAutoBuy.MouseButton1Click:Connect(ToggleButton(BtnAutoBuy, "AUTO BUY", "AutoBuy"))

-- Botones de desbloquear
BtnUnlockTreads.MouseButton1Click:Connect(function()
    BtnUnlockTreads.Text = "✅ DESBLOQUEADO!"
    BtnUnlockTreads.BackgroundColor3 = Color3.fromRGB(30, 140, 60)
    fireclickdetector(workspace.HoshiHub.Buttons.UnlockTreadmills.ClickDetector)
    wait(2)
    BtnUnlockTreads.Text = "🔓 UNLOCK ALL TREADMILL"
    BtnUnlockTreads.BackgroundColor3 = Color3.fromRGB(35, 105, 70)
end)

BtnUnlockSound.MouseButton1Click:Connect(function()
    BtnUnlockSound.Text = "✅ DESBLOQUEADO!"
    BtnUnlockSound.BackgroundColor3 = Color3.fromRGB(30, 140, 60)
    fireclickdetector(workspace.HoshiHub.Buttons.UnlockSounds.ClickDetector)
    wait(2)
    BtnUnlockSound.Text = "🔊 UNLOCK ALL SOUND"
    BtnUnlockSound.BackgroundColor3 = Color3.fromRGB(35, 105, 70)
end)

print("✅ SCRIPT CARGADO CON FONDO MORADO LED ANIMADO!")
