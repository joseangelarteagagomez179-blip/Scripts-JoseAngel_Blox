-- JoseAngel_Blox Block Cup

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- Configuracion
_G.AutoFarm = false -- Empieza apagado
local Rango = 150
local FuerzaImant = 80

-- == INTERFAZ PEQUEÑA Y DESLIZABLE ==
local Gui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Fondo = Instance.new("ImageLabel")
local Titulo = Instance.new("TextLabel")
local Boton = Instance.new("TextButton")

Gui.Name = "JoseAngel_Blox"
Gui.Parent = game:GetService("CoreGui")
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Global

-- Marco Cuadrado Pequeño
Main.Name = "MainFrame"
Main.Size = UDim2.new(0, 200, 0, 200)
Main.Position = UDim2.new(0.1, 0, 0.3, 0)
Main.BackgroundColor3 = Color3.new(0.08, 0.08, 0.08)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Active = true
Main.Draggable = true -- DESLIZABLE
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
Titulo.Size = UDim2.new(1, 0, 0, 30)
Titulo.Position = UDim2.new(0, 0, 0, 5)
Titulo.BackgroundTransparency = 1
Titulo.Text = "JoseAngel_Blox"
Titulo.TextColor3 = Color3.new(1,1,1)
Titulo.Font = Enum.Font.GothamBold
Titulo.TextSize = 16
Titulo.Parent = Main

-- Boton
Boton.Name = "BotonFarm"
Boton.Size = UDim2.new(0, 160, 0, 40)
Boton.Position = UDim2.new(0.5, -80, 0.7, 0)
Boton.BackgroundColor3 = Color3.new(0.5,0,0) -- ROJO = OFF
Boton.Text = "Auto Farm: OFF"
Boton.TextColor3 = Color3.new(1,1,1)
Boton.Font = Enum.Font.GothamBold
Boton.TextSize = 14
Boton.Parent = Main

local UICornerBtn = Instance.new("UICorner")
UICornerBtn.CornerRadius = UDim.new(0, 8)
UICornerBtn.Parent = Boton

-- Funcion Boton
Boton.MouseButton1Click:Connect(function()
    _G.AutoFarm = not _G.AutoFarm
    if _G.AutoFarm then
        Boton.Text = "Auto Farm: ON"
        Boton.BackgroundColor3 = Color3.new(0,0.5,0) -- VERDE = ON
    else
        Boton.Text = "Auto Farm: OFF"
        Boton.BackgroundColor3 = Color3.new(0.5,0,0)
    end
end)

-- == SCRIPT ATRAE TODAS LAS BOLAS ==
spawn(function()
    while task.wait(0.01) do
        if Humanoid.Health > 0 and _G.AutoFarm == true then
            local HumRoot = Character.HumanoidRootPart
            
            -- Patear Bloques
            for _, Parte in pairs(Workspace:GetDescendants()) do
                if Parte:IsA("Part") and Parte:FindFirstChildOfClass("ClickDetector") then
                    if (HumRoot.Position - Parte.Position).Magnitude <= Rango then
                        fireclickdetector(Parte.ClickDetector)
                    end
                end
            end
            
            -- ATRAE TODAS LAS BOLAS (TODOS LOS COLORES)
            for _, Objeto in pairs(Workspace:GetDescendants()) do
                if Objeto:IsA("Part") or Objeto:IsA("MeshPart") then
                    local Nombre = string.lower(Objeto.Name)
                    -- Busca cualquier cosa que sea bola
                    if string.find(Nombre, "ball") or string.find(Nombre, "bola") then
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
    Text = "Listo | Todas las bolas 🧲",
    Duration = 3
})
