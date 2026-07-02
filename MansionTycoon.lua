--[[
    Mansion Tycoon v1.1
    Creador: JoseAngel_Blox
    Fecha: 01/07/2026
]]

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local UIS = game:GetService("UserInputService")

-- 1. Crear la Interfaz Principal
local ScreenGui = Instance.new("ScreenGui", Player.PlayerGui)
ScreenGui.Name = "MansionTycoonV1"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 300, 0, 400) -- Tamaño compacto
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Active = true
MainFrame.Draggable = true -- Para que puedas moverlo con el mouse

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 15)

-- Título
local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "Mansión Tycoon v1.1"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

-- Contenedor de Botones (Scrolling para que quepan todos)
local ScrollingFrame = Instance.new("ScrollingFrame", MainFrame)
ScrollingFrame.Size = UDim2.new(1, -20, 1, -60)
ScrollingFrame.Position = UDim2.new(0, 10, 0, 50)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1.5, 0) -- Espacio para scroll
ScrollingFrame.ScrollBarThickness = 4

local UIListLayout = Instance.new("UIListLayout", ScrollingFrame)
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Función para crear Botones/Interruptores
local function CreateButton(text, callback)
    local Button = Instance.new("TextButton", ScrollingFrame)
    Button.Text = text
    Button.Size = UDim2.new(0, 260, 0, 35)
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 14
    
    local btnCorner = Instance.new("UICorner", Button)
    btnCorner.CornerRadius = UDim.new(0, 8)

    local enabled = false
    Button.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            Button.BackgroundColor3 = Color3.fromRGB(0, 170, 0) -- Verde (ON)
        else
            Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50) -- Gris (OFF)
        end
        callback(enabled)
    end)
end

-- --- 1) INFO ---
print("¡Bienvenido! Creador: JoseAngel_Blox | Versión: 1.1")

-- --- 2) MAIN ---
CreateButton("Auto Collect [OFF]", function(state)
    _G.AutoCollect = state
    while _G.AutoCollect do
        print("Recolectando...") -- Aquí va la lógica de fuego
        task.wait(1)
    end
end)

CreateButton("Auto Build [OFF]", function(state)
    _G.AutoBuild = state
    print("Auto Build: " .. tostring(state))
end)

-- --- 3) PLAYER ---
CreateButton("Speed (100) [OFF]", function(state)
    Character.Humanoid.WalkSpeed = state and 100 or 16
end)

CreateButton("Jump 🦘 [OFF]", function(state)
    Character.Humanoid.JumpPower = state and 100 or 50
end)

CreateButton("Infinite Jump [OFF]", function(state)
    _G.InfJump = state
end)

-- Lógica Infinite Jump
UIS.JumpRequest:Connect(function()
    if _G.InfJump then
        Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

-- --- 4) OPTIMIZACIÓN ---
CreateButton("Optimizar Juego [OFF]", function(state)
    if state then
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("PostProcessEffect") then v.Enabled = false end
        end
    end
end)

-- Botón de Despedida/Cerrar
CreateButton("Cerrar Script", function()
    print("Gracias por usar el script de JoseAngel_Blox. ¡Hasta luego!")
    ScreenGui:Destroy()
end)
