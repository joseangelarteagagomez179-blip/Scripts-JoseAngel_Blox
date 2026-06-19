-- JoseAngel_Blox Block Cup | Luxvs System

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- CONFIGURACION DEL EVENTO (IGUAL QUE LUXVS)
_G.AutoFarmEvent = false
local Range = 200
local Speed = 100

-- == INTERFAZ ==
local Gui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Fondo = Instance.new("ImageLabel")
local Titulo = Instance.new("TextLabel")
local Boton = Instance.new("TextButton")

Gui.Name = "JoseAngel_Blox"
Gui.Parent = game:GetService("CoreGui")
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Global

Main.Name = "MainFrame"
Main.Size = UDim2.new(0, 200, 0, 200)
Main.Position = UDim2.new(0.1, 0, 0.3, 0)
Main.BackgroundColor3 = Color3.new(0.08, 0.08, 0.08)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Active = true
Main.Draggable = true
Main.Parent = Gui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Main

Fondo.Name = "Fondo"
Fondo.Size = UDim2.new(1, 0, 1, 0)
Fondo.Position = UDim2.new(0,0,0,0)
Fondo.Image = "http://www.roblox.com/asset/?id=13559396885"
Fondo.BackgroundTransparency = 1
Fondo.ScaleType = Enum.ScaleType.Stretch
Fondo.Parent = Main

Titulo.Name = "Titulo"
Titulo.Size = UDim2.new(1, 0, 0, 30)
Titulo.Position = UDim2.new(0, 0, 0, 5)
Titulo.BackgroundTransparency = 1
Titulo.Text = "JoseAngel_Blox"
Titulo.TextColor3 = Color3.new(1,1,1)
Titulo.Font = Enum.Font.GothamBold
Titulo.TextSize = 16
Titulo.Parent = Main

Boton.Name = "BotonFarm"
Boton.Size = UDim2.new(0, 160, 0, 40)
Boton.Position = UDim2.new(0.5, -80, 0.7, 0)
Boton.BackgroundColor3 = Color3.new(0.5,0,0)
Boton.Text = "Event: OFF"
Boton.TextColor3 = Color3.new(1,1,1)
Boton.Font = Enum.Font.GothamBold
Boton.TextSize = 14
Boton.Parent = Main

local UICornerBtn = Instance.new("UICorner")
UICornerBtn.CornerRadius = UDim.new(0, 8)
UICornerBtn.Parent = Boton

Boton.MouseButton1Click:Connect(function()
    _G.AutoFarmEvent = not _G.AutoFarmEvent
    if _G.AutoFarmEvent then
        Boton.Text = "Event: ON"
        Boton.BackgroundColor3 = Color3.new(0,0.5,0)
    else
        Boton.Text = "Event: OFF"
        Boton.BackgroundColor3 = Color3.new(0.5,0,0)
    end
end)

-- == SISTEMA DEL EVENTO INTEGRADO (ESTILO LUXVS) ==
spawn(function()
    while task.wait() do
        if _G.AutoFarmEvent and Humanoid.Health > 0 then
            local HumRoot = Character.HumanoidRootPart

            -- AUTO KICK BLOQUES DEL EVENTO
            for _, v in pairs(Workspace:GetDescendants()) do
                if v:IsA("Part") and v:FindFirstChildOfClass("ClickDetector") then
                    if (HumRoot.Position - v.Position).Magnitude <= Range then
                        fireclickdetector(v.ClickDetector)
                    end
                end
            end

            -- IMAN PARA TODAS LAS BOLAS DEL EVENTO
            for _, v in pairs(Workspace:GetDescendants()) do
                if v:IsA("Part") or v:IsA("MeshPart") then
                    local name = string.lower(v.Name)
                    if name:find("ball") or name:find("chance") or name:find("dobles") or name:find("brainrot") or name:find("mut") then
                        if (HumRoot.Position - v.Position).Magnitude <= Range then
                            -- METODO LUXVS (SUAVE Y EFECTIVO)
                            v.CFrame = v.CFrame:Lerp(HumRoot.CFrame, 0.2)
                        end
                    end
                end
            end
        end
    end
end)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "JoseAngel_Blox",
    Text = "Luxvs Event System Loaded 🧲",
    Duration = 3
})
