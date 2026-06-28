-- CARGAR ARASAKA HUB ORIGINAL
loadstring(game:HttpGet("https://gist.githubusercontent.com/nex-no1/ce10c68544ec307586f36cf1e6d15e98/raw"))()

-- ESPERAR A QUE CARGUE LA INTERFAZ
task.wait(2)

-- =============================================
--      MODIFICAR NOMBRE Y AGREGAR FONDO
-- =============================================

-- CAMBIAR NOMBRE DE LA VENTANA
pcall(function()
    local Window = game:GetService("CoreGui"):FindFirstChild("Arasaka Hub")
    if Window then
        Window.TopBar.Title.Text = "+1 Speed-Keyboard-Escape-Candy-Chocolate"
    end
end)

-- CREAR FONDO MORADO LÍQUIDO ANIMADO
local BG = Instance.new("Frame")
local BG2 = Instance.new("Frame")
local UIGradient = Instance.new("UIGradient")
local UIGradient2 = Instance.new("UIGradient")

BG.Name = "LiquidBackground"
BG.Parent = game:GetService("CoreGui")
BG.Size = UDim2.new(2, 0, 2, 0)
BG.Position = UDim2.new(-0.5, 0, -0.5, 0)
BG.BackgroundTransparency = 1
BG.ZIndexBehavior = Enum.ZIndexBehavior.Global
BG.ZIndex = -1 -- Poner detrás de todo

BG2.Name = "LiquidBackground2"
BG2.Parent = BG
BG2.Size = UDim2.new(1, 0, 1, 0)
BG2.Position = UDim2.new(1, 0, 0, 0)
BG2.BackgroundTransparency = 1

-- COLORES MORADOS BRILLOSOS
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 0, 150)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150, 0, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 0, 150))
})
UIGradient.Rotation = 45
UIGradient.Parent = BG

UIGradient2.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 0, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(80, 0, 150)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 0, 255))
})
UIGradient2.Rotation = -45
UIGradient2.Parent = BG2

-- ANIMACIÓN DE FLUJO LÍQUIDO
game:GetService("RunService").RenderStepped:Connect(function()
    BG.Position = BG.Position + UDim2.new(0.001, 0, 0.0005, 0)
    BG2.Position = BG2.Position + UDim2.new(0.001, 0, 0.0005, 0)
    
    if BG.Position.X.Scale >= 0.5 then
        BG.Position = UDim2.new(-0.5, 0, -0.5, 0)
        BG2.Position = UDim2.new(1, 0, 0, 0)
    end
end)

print("✅ Script cargado con éxito!")
print("🟣 Fondo morado líquido activado")
