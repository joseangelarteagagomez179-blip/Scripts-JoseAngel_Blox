--[[
    Mansion Tycoon v1.1
    Creador: JoseAngel_Blox
    Fecha: 01/07/2026
]]

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local RunService = game:GetService("RunService")

-- Crear la Interfaz (Forma cuadrada con esquinas redondeadas)
local ScreenGui = Instance.new("ScreenGui", Player.PlayerGui)
ScreenGui.Name = "MansionTycoonV1"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 350, 0, 450) -- Tamaño compacto
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -225)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 15) -- Esquinas redondeadas

-- Título
local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "Mansión Tycoon v1.1"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20

-- NOTA: Bienvenida
print("¡Bienvenido al script de Mansion Tycoon v1.1 - Creado por JoseAngel_Blox!")

-- Lógica de Funciones
-- (Aquí irían los botones que activan las funciones que armamos antes)

-- Player Functions
local function toggleSpeed(state)
    Character.Humanoid.WalkSpeed = state and 100 or 16
end

-- Despedida al cerrar (simulación)
local function onClosing()
    print("Saliendo... Gracias por usar el script de JoseAngel_Blox. ¡Hasta luego!")
    ScreenGui:Destroy()
end
