-- Servicios
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

-- Variables de control
local activado = false

-- Función principal
local function desbloquearCaminadoras()
    activado = not activado
    
    if activado then
        print("🔓 Desbloqueando todas las caminadoras...")
        
        -- Buscar todas las caminadoras en el mapa
        for _, objeto in pairs(Workspace:GetDescendants()) do
            -- Buscamos por nombres comunes
            if objeto:IsA("Part") or objeto:IsA("UnionOperation") then
                if string.find(objeto.Name:lower(), "treadmill") or string.find(objeto.Name:lower(), "caminadora") then
                    
                    -- Intentar activar velocidades
                    pcall(function()
                        -- Si tiene un valor de velocidad, lo subimos
                        if objeto:FindFirstChild("Speed") then
                            objeto.Speed.Value = 100 -- Velocidad máxima
                        end
                        
                        -- Si tiene un script o controlador, lo habilitamos
                        local hijo = objeto:FindFirstChildWhichIsA("BoolValue") or objeto:FindFirstChildWhichIsA("NumberValue")
                        if hijo then
                            hijo.Value = true
                        end
                        
                        -- Si es una parte que se mueve
                        if objeto.Parent and objeto.Parent:FindFirstChild("Velocity") then
                            objeto.Parent.Velocity = Vector3.new(0,0,50)
                        end
                    end)
                end
            end
        end
        print("✅ Todas las caminadoras activadas")
    else
        print("🔒 Modo normal restablecido")
        -- Aquí podrías agregar código para devolver todo a la normalidad si quieres
    end
end

-- Crear botón simple
local StarterGui = game:GetService("StarterGui")
local Player = game.Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Desbloqueador"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player.PlayerGui

local Boton = Instance.new("TextButton")
Boton.Size = UDim2.new(0, 200, 0, 50)
Boton.Position = UDim2.new(0.05, 0, 0.1, 0)
Boton.BackgroundColor3 = Color3.new(0.2, 0.8, 0.2)
Boton.Text = "ACTIVAR TODAS LAS CAMINADORAS"
Boton.TextColor3 = Color3.new(1,1,1)
Boton.Font = Enum.Font.GothamBold
Boton.TextSize = 14
Boton.Parent = ScreenGui
Boton.Draggable = true -- Para mover el botón
Boton.Active = true

-- Al hacer clic
Boton.MouseButton1Click:Connect(desbloquearCaminadoras)

print("✅ Script listo. Presiona el botón verde.")
