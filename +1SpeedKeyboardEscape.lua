-- Servicios
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

-- Crear Interfaz Simple
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BypassTreadmills"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer.PlayerGui

local Boton = Instance.new("TextButton")
Boton.Size = UDim2.new(0, 220, 0, 50)
Boton.Position = UDim2.new(0.05, 0, 0.1, 0)
Boton.BackgroundColor3 = Color3.new(0.1, 0.3, 0.8)
Boton.Text = "🔓 SALTAR REQUISITOS (ROBUX)"
Boton.TextColor3 = Color3.new(1,1,1)
Boton.Font = Enum.Font.GothamBold
Boton.TextSize = 13
Boton.Parent = ScreenGui
Boton.Draggable = true
Boton.Active = true

-- Función Principal
local function ActivarBypass()
    print("🔄 Buscando y desbloqueando...")

    -- MÉTODO 1: Buscar en el Workspace y eliminar requisitos
    for _, obj in pairs(Workspace:GetDescendants()) do
        
        -- Buscar cualquier cosa que diga "Price", "Cost", "Required" o "Robux"
        if obj.Name:find("Price") or obj.Name:find("Cost") or obj.Name:find("Required") then
            if obj:IsA("NumberValue") or obj:IsA("IntValue") then
                obj.Value = 0 -- Lo ponemos en GRATIS
                print("✅ Precio eliminado en: " .. obj.Parent.Name)
            end
        end

        -- Buscar si están bloqueadas (Locked o Enabled)
        if obj.Name:find("Locked") or obj.Name:find("Unlocked") then
            if obj:IsA("BoolValue") then
                obj.Value = true -- Las desbloqueamos
                print("✅ Desbloqueado: " .. obj.Parent.Name)
            end
        end
        
        -- Si la caminadora tiene un "ProximityPrompt" que pide pago
        if obj:IsA("ProximityPrompt") then
            obj.Enabled = true
            obj.ActionText = "Usar Gratis"
            obj.ObjectText = ""
        end
    end

    -- MÉTODO 2: Simular que ya compraste (Disparar eventos)
    pcall(function()
        -- Intentar encontrar el evento de compra
        local EventoCompra = ReplicatedStorage:FindFirstChildWhichIsA("RemoteEvent") or ReplicatedStorage:FindFirstChildWhichIsA("BindableFunction")
        
        if EventoCompra then
            -- Enviamos señal de "compra exitosa"
            EventoCompra:FireServer("UnlockAll", "Admin", true)
            print("📤 Señal de desbloqueo enviada al servidor")
        end
    end)

    -- MÉTODO 3: Hacerte dueño de la caminadora al tocarla
    LocalPlayer.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid")
        
        humanoid.Touched:Connect(function(hit)
            local padre = hit.Parent
            if padre and padre.Name:lower():find("treadmill") or padre.Name:lower():find("caminadora") then
                pcall(function()
                    -- Forzar propiedad de dueño
                    if padre:FindFirstChild("Owner") then
                        padre.Owner.Value = LocalPlayer.Name
                    end
                    if padre:FindFirstChild("Speed") then
                        padre.Speed.Value = 999
                    end
                end)
            end
        end)
    end)

    Boton.Text = "✅ ACTIVADO! INTENTA USARLA"
    Boton.BackgroundColor3 = Color3.new(0,1,0)
    wait(2)
    Boton.Text = "🔓 SALTAR REQUISITOS"
end

Boton.MouseButton1Click:Connect(ActivarBypass)

print("✅ Script listo. Dale al botón azul y luego intenta pararte en la caminadora.")
