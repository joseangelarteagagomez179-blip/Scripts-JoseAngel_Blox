-- [[ Mansión Tycoon v1.1 ]] --
-- Creador: JoseAngel_Blox
-- Fecha de lanzamiento: 01/07/2026

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local TabContainer = Instance.new("Frame")
local ContentContainer = Instance.new("Frame")

-- Configuración de la Ventana Principal (Ancha y Redondeada)
ScreenGui.Parent = game.CoreGui
MainFrame.Name = "MansionTycoonGui"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 500, 0, 320) -- Ancha y no tan alta
MainFrame.Active = true
MainFrame.Draggable = true

UICorner.CornerRadius = UDim.new(0, 15) -- Esquinas redondeadas
UICorner.Parent = MainFrame

Title.Parent = MainFrame
Title.Text = "Mansión Tycoon v1.1"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20

-- Variables de funciones
local Flags = {AutoCollect = false, AutoBuild = false, Speed = false, Noclip = false, Jump = false, InfJump = false, ESP = false}

-- Función para crear botones/interruptores
local function CreateToggle(name, parent, pos, callback)
    local Button = Instance.new("TextButton")
    Button.Name = name
    Button.Parent = parent
    Button.Size = UDim2.new(0, 180, 0, 35)
    Button.Position = pos
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Button.Text = name .. ": OFF"
    Button.TextColor3 = Color3.new(1, 1, 1)
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = Button

    local state = false
    Button.MouseButton1Click:Connect(function()
        state = not state
        Button.Text = name .. (state and ": ON" or ": OFF")
        Button.BackgroundColor3 = state and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(50, 50, 50)
        callback(state)
    end)
end

-- --- 1) INFO ---
local InfoFrame = Instance.new("Frame", MainFrame)
InfoFrame.Size = UDim2.new(1, -20, 1, -60)
InfoFrame.Position = UDim2.new(0, 10, 0, 50)
InfoFrame.BackgroundTransparency = 1

local InfoLabel = Instance.new("TextLabel", InfoFrame)
InfoLabel.Size = UDim2.new(1, 0, 1, 0)
InfoLabel.BackgroundTransparency = 1
InfoLabel.TextColor3 = Color3.new(0.8, 0.8, 0.8)
InfoLabel.Text = "Creador: JoseAngel_Blox\nLanzamiento: 01/07/2026\nVersión: 1.1\n\n¡Hola! Bienvenido al script.\nEspero que disfrutes estas funciones.\n\nGracias por usarlo. ¡Vuelve pronto!"
InfoLabel.TextSize = 16
InfoLabel.Font = Enum.Font.SourceSans

-- --- 2) MAIN (Auto Collect & Build) ---
-- (Aquí podrías crear más pestañas, pero he puesto las funciones principales para que sea funcional ya mismo)
CreateToggle("Auto Collect", InfoFrame, UDim2.new(0, 280, 0, 10), function(s)
    Flags.AutoCollect = s
    while Flags.AutoCollect do
        -- Lógica de recolección
        pcall(function()
            local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name == "Collect" and v:IsA("TouchTransmitter") then
                    firetouchinterest(hrp, v.Parent, 0)
                    firetouchinterest(hrp, v.Parent, 1)
                end
            end
        end)
        task.wait(1)
    end
end)

-- --- 3) PLAYER ---
CreateToggle("Speed", InfoFrame, UDim2.new(0, 280, 0, 55), function(s)
    Flags.Speed = s
    game:GetService("RunService").RenderStepped:Connect(function()
        if Flags.Speed then game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 60
        else game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16 end
    end)
end)

CreateToggle("Jump 🦘", InfoFrame, UDim2.new(0, 280, 0, 100), function(s)
    if s then game.Players.LocalPlayer.Character.Humanoid.JumpPower = 100
    else game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50 end
end)

CreateToggle("Noclip", InfoFrame, UDim2.new(0, 280, 0, 145), function(s)
    Flags.Noclip = s
    game:GetService("RunService").Stepped:Connect(function()
        if Flags.Noclip then
            for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)
end)

-- --- 4) OPTIMIZACIÓN ---
CreateToggle("Optimizar", InfoFrame, UDim2.new(0, 280, 0, 190), function(s)
    if s then
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
            if v:IsA("Decal") then v:Destroy() end
        end
    end
end)

print("Mansión Tycoon v1.1 cargado. Creado por JoseAngel_Blox")
