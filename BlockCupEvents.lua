 -- JoseAngel_Blox Block Cup

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- Configuracion
_G.AutoFarm = true
local Rango = 150
local FuerzaImant = 80

-- == INTERFAZ ==
local Gui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Fondo = Instance.new("ImageLabel")
local Titulo = Instance.new("TextLabel")
local Info = Instance.new("TextLabel")
local Boton = Instance.new("TextButton")

Gui.Name = "JoseAngel_Blox"
Gui.Parent = game:GetService("CoreGui")

-- Marco Cuadrado
Main.Name = "MainFrame"
Main.Size = UDim2.new(0, 320, 0, 320)
Main.Position = UDim2.new(0.2, 0, 0.3, 0)
Main.BackgroundColor3 = Color3.new(0.08, 0.08, 0.08)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = Gui

-- Bordes Redondeados
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Main

-- Imagen Fondo
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
Titulo.Position = UDim2.new(0, 0, 0, 10)
Titulo.BackgroundTransparency = 1
Titulo.Text = "JoseAngel_Blox"
Titulo.TextColor3 = Color3.new(1,1,1)
Titulo.Font = Enum.Font.GothamBold
Titulo.TextSize = 22
Titulo.Parent = Main

-- Info
Info.Name = "Info"
Info.Size = UDim2.new(1, 0, 0, 30)
Info.Position = UDim2.new(0, 0, 0, 50)
Info.BackgroundTransparency = 1
Info.Text = "🧲 TODAS LAS BOLAS | Normales y Raras"
Info.TextColor3 = Color3.new(0.9,0.9,0.9)
Info.Font = Enum.Font.Gotham
Info.TextSize = 13
Info.Parent = Main

-- Boton
Boton.Name = "BotonFarm"
Boton.Size = UDim2.new(0, 220, 0, 45)
Boton.Position = UDim2.new(0.5, -110, 0.8, -20)
Boton.BackgroundColor3 = Color3.new(0,0.5,0)
Boton.Text = "Auto Farm: ON"
Boton.TextColor3 = Color3.new(1,1,1)
Boton.Font = Enum.Font.GothamBold
Boton.TextSize = 16
Boton.Parent = Main

local UICornerBtn = Instance.new("UICorner")
UICornerBtn.CornerRadius = UDim.new(0, 8)
UICornerBtn.Parent = Boton

-- Funcion Boton
Boton.MouseButton1Click:Connect(function()
    _G.AutoFarm = not _G.AutoFarm
    if _G.AutoFarm then
        Boton.Text = "Auto Farm: ON"
        Boton.BackgroundColor3 = Color3.new(0,0.5,0)
    else
        Boton.Text = "Auto Farm: OFF"
        Boton.BackgroundColor3 = Color3.new(0.5,0,0)
    end
end)

-- == SCRIPT DE FARME0 ==
spawn(function()
    while task.wait(0.01) do
        if Humanoid.Health > 0 and _G.AutoFarm then
            local HumRoot = Character.HumanoidRootPart
            
            -- Patear Bloques
            for _, Parte in pairs(Workspace:GetDescendants()) do
                if Parte:IsA("Part") and Parte:FindFirstChildOfClass("ClickDetector") then
                    if (HumRoot.Position - Parte.Position).Magnitude <= Rango then
                        fireclickdetector(Parte.ClickDetector)
                    end
                end
            end
            
            -- ATRAE TODAS LAS BOLAS
            for _, Objeto in pairs(Workspace:GetDescendants()) do
                if Objeto:IsA("Part") or Objeto:IsA("MeshPart") or Objeto:IsA("Model") then
                    local Nombre = string.lower(Objeto.Name)
                    -- Busca cualquier cosa que sea bola o tenga "ball"
                    if string.find(Nombre, "ball") or string.find(Nombre, "bola") or string.find(Nombre, "rare") or string.find(Nombre, "epic") or string.find(Nombre, "legendary") or string.find(Nombre, "mut") then
                        if (HumRoot.Position - Objeto.Position).Magnitude <= Rango then
                            -- MODO IMAN
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
    Text = "Farmeando TODAS las bolas 🧲",
    Duration = 3
})
