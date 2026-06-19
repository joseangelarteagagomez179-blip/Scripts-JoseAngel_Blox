-- JoseAngel_Blox Block Cup

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- Configuracion
_G.AutoFarmBalls = true
local Rango = 150
local FuerzaImant = 50 -- Que tan rapido atrae las balls

-- == CREAR INTERFAZ ==
local Gui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Fondo = Instance.new("ImageLabel")
local Titulo = Instance.new("TextLabel")
local Info = Instance.new("TextLabel")
local Boton = Instance.new("TextButton")

Gui.Name = "JoseAngel_Blox"
Gui.Parent = game:GetService("CoreGui")

Main.Name = "MainFrame"
Main.Size = UDim2.new(0, 350, 0, 250)
Main.Position = UDim2.new(0.2, 0, 0.3, 0)
Main.BackgroundTransparency = 1
Main.Parent = Gui

-- IMAGEN DE FONDO
Fondo.Name = "Fondo"
Fondo.Size = UDim2.new(1, 0, 1, 0)
Fondo.Position = UDim2.new(0,0,0,0)
Fondo.Image = "http://www.roblox.com/asset/?id=13559396885"
Fondo.BackgroundTransparency = 1
Fondo.ScaleType = Enum.ScaleType.Stretch
Fondo.Parent = Main

-- Titulo
Titulo.Name = "Titulo"
Titulo.Size = UDim2.new(1, 0, 0, 40)
Titulo.Position = UDim2.new(0, 0, 0, 5)
Titulo.BackgroundTransparency = 1
Titulo.Text = "JoseAngel_Blox"
Titulo.TextColor3 = Color3.new(1,1,1)
Titulo.Font = Enum.Font.GothamBold
Titulo.TextSize = 22
Titulo.Parent = Main

-- Texto Informativo
Info.Name = "Info"
Info.Size = UDim2.new(1, 0, 0, 30)
Info.Position = UDim2.new(0, 0, 0, 45)
Info.BackgroundTransparency = 1
Info.Text = "MODO IMAN | Las balls vienen hacia ti"
Info.TextColor3 = Color3.new(0.9,0.9,0.9)
Info.Font = Enum.Font.Gotham
Info.TextSize = 14
Info.Parent = Main

-- Boton
Boton.Name = "BotonFarm"
Boton.Size = UDim2.new(0, 220, 0, 45)
Boton.Position = UDim2.new(0.5, -110, 0.8, -20)
Boton.BackgroundColor3 = Color3.new(0,0.5,0)
Boton.Text = "Auto Farm Balls: ON"
Boton.TextColor3 = Color3.new(1,1,1)
Boton.Font = Enum.Font.GothamBold
Boton.TextSize = 16
Boton.Parent = Main

-- Funcion del Boton
Boton.MouseButton1Click:Connect(function()
    _G.AutoFarmBalls = not _G.AutoFarmBalls
    if _G.AutoFarmBalls then
        Boton.Text = "Auto Farm Balls: ON"
        Boton.BackgroundColor3 = Color3.new(0,0.5,0)
    else
        Boton.Text = "Auto Farm Balls: OFF"
        Boton.BackgroundColor3 = Color3.new(0.5,0,0)
    end
end)

-- == SCRIPT OPTIMIZADO MODO IMAN ==
spawn(function()
    while task.wait(0.01) do
        if Humanoid.Health > 0 and _G.AutoFarmBalls then
            local HumRoot = Character.HumanoidRootPart
            
            -- 1. Patear Bloques
            for _, Parte in pairs(Workspace:GetDescendants()) do
                if Parte:IsA("Part") and Parte:FindFirstChildOfClass("ClickDetector") then
                    if (HumRoot.Position - Parte.Position).Magnitude <= Rango then
                        fireclickdetector(Parte.ClickDetector)
                    end
                end
            end
            
            -- 2. MODO IMAN (Jalar Balls)
            for _, Objeto in pairs(Workspace:GetDescendants()) do
                if Objeto:IsA("Part") or Objeto:IsA("MeshPart") then
                    local Nombre = string.lower(Objeto.Name)
                    if string.find(Nombre, "ball") or string.find(Nombre, "soccer") or string.find(Nombre, "cup") then
                        if (HumRoot.Position - Objeto.Position).Magnitude <= Rango then
                            -- Mover la ball hacia el jugador
                            Objeto.CFrame = Objeto.CFrame:Lerp(HumRoot.CFrame, FuerzaImant / 100)
                        end
                    end
                end
            end
        end
    end
end)

-- Notificacion
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "JoseAngel_Blox",
    Text = "Modo Iman Activado 🧲",
    Duration = 3
})
