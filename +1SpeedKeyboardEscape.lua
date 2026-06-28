--[[
SCRIPT CREADO POR TI
Juego: +1 Speed Keyboard Escape
Objetivo: Auto Farm y Desbloquear Treadmills
]]

-- Servicios
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- ==============================================
-- 🎨 INTERFAZ
-- ==============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MiScriptPropio"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer.PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 280, 0, 350)
MainFrame.Position = UDim2.new(0.05, 0, 0.05, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderColor3 = Color3.fromRGB(255, 200, 0)
MainFrame.BorderSizePixel = 3
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.Text = "⚙️ MI SCRIPT - HECHO POR MÍ ⚙️"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.Parent = MainFrame

-- ==============================================
-- 🔓 FUNCIÓN: DESBLOQUEAR TREADMILLS
-- ==============================================
local function DesbloquearTreadmills()
    StarterGui:SetCore("SendNotification", {Title="Procesando...", Text="Buscando Treadmills...", Duration=2})

    -- Lista de las que quieres desbloquear
    local listaNombres = {"candy", "gold", "diamond", "admin", "treadmill"}

    -- Recorremos TODO el mapa
    for _, objeto in pairs(Workspace:GetDescendants()) do
        local nombreMinuscula = objeto.Name:lower()

        -- Verificamos si coincide con alguna de la lista
        for _, nombreBuscado in pairs(listaNombres) do
            if string.find(nombreMinuscula, nombreBuscado) then
                
                -- SI ES UNA PARED O PUERTA: La hacemos invisible y sin colisión
                if objeto:IsA("BasePart") then
                    objeto.CanCollide = false
                    objeto.Transparency = 0.7
                end

                -- SI ES UN BOTÓN O ZONA DE COMPRA: Le damos click
                if objeto:FindFirstChildOfClass("ClickDetector") then
                    fireclickdetector(objeto.ClickDetector)
                end

                -- SI TIENE PROPIEDADES DE "REQUISITO" O "PRECIO": Lo borramos o desactivamos
                if objeto:IsA("BoolValue") or objeto:IsA("IntValue") then
                    objeto.Value = true
                end
            end
        end
    end

    StarterGui:SetCore("SendNotification", {Title="✅ LISTO", Text="Candy, Gold, Diamond y Admin desbloqueadas!", Duration=4})
end

-- ==============================================
-- 🏃 FUNCIÓN: AUTO FARM
-- ==============================================
local FarmActivo = false
local Conexion = nil

local function ActivarAutoFarm()
    FarmActivo = not FarmActivo -- Cambia de estado

    if FarmActivo then
        StarterGui:SetCore("SendNotification", {Title="Auto Farm", Text="ACTIVADO", Duration=2})
        
        Conexion = RunService.Heartbeat:Connect(function()
            -- Buscamos monedas, caramelos o puntos
            for _, objeto in pairs(Workspace:GetChildren()) do
                if objeto:IsA("Part") then
                    local nom = objeto.Name:lower()
                    if string.find(nom, "coin") or string.find(nom, "candy") or string.find(nom, "money") or string.find(nom, "orb") then
                        
                        -- Ir hacia el objeto
                        local distancia = (RootPart.Position - objeto.Position).Magnitude
                        if distancia < 50 then
                            RootPart.CFrame = CFrame.new(objeto.Position + Vector3.new(0,3,0))
                            task.wait(0.05)
                        end
                    end
                end
            end
        end)
    else
        -- Detener
        if Conexion then Conexion:Disconnect() end
        StarterGui:SetCore("SendNotification", {Title="Auto Farm", Text="DETENIDO", Duration=2})
    end
end

-- ==============================================
-- 🔘 BOTONES
-- ==============================================
local function CrearBoton(texto, y, color, funcion)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.9, 0, 0, 45)
    Btn.Position = UDim2.new(0.05, 0, 0, y)
    Btn.BackgroundColor3 = color
    Btn.Text = texto
    Btn.TextColor3 = Color3.new(1,1,1)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 14
    Btn.Parent = MainFrame

    Btn.MouseButton1Click:Connect(funcion)
end

-- Creamos los botones principales
CrearBoton("🔓 DESBLOQUEAR TREADMILLS", 50, Color3.fromRGB(0, 100, 200), DesbloquearTreadmills)
CrearBoton("🏃 ACTIVAR AUTO FARM", 105, Color3.fromRGB(0, 150, 0), ActivarAutoFarm)
CrearBoton("⚡ VELOCIDAD MAXIMA", 160, Color3.fromRGB(150, 0, 150), function()
    Humanoid.WalkSpeed = 150
end)

-- Mensaje final
StarterGui:SetCore("SendNotification", {
    Title = "🎉 SCRIPT CREADO",
    Text = "Tu propio script está listo!",
    Duration = 3
})
