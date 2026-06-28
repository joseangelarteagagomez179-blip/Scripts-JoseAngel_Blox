-- Servicios
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

print("🔌 Script activado: Modo Gratis ON")

-- Función principal
local function activarTreadmill(parte)
    -- 1. Eliminar o cambiar el precio para que sea gratis
    if parte:FindFirstChild("Price") or parte:FindFirstChild("Cost") then
        parte.Price.Value = 0 -- Poner precio en 0
        -- O simplemente ocultar/eliminar el valor
        -- parte.Price:Destroy()
    end

    -- 2. Eliminar los requisitos de nivel o velocidad
    if parte:FindFirstChild("RequiredSpeed") then
        parte.RequiredSpeed.Value = 0
    end

    -- 3. Bypass: Simular que ya está comprada
    if parte:FindFirstChild("Owned") then
        parte.Owned.Value = true
    end

    -- 4. Si tiene un ClickDetector, lo activamos o modificamos
    local detector = parte:FindFirstChildOfClass("ClickDetector")
    if detector then
        -- A veces basta con cambiar el texto o forzar la activación
        spawn(function()
            while wait() do
                fireclickdetector(detector)
            end
        end)
    end
end

-- Revisamos TODO lo que haya en el mapa
for _, objeto in pairs(Workspace:GetDescendants()) do
    -- Buscamos partes que sean las cintas
    if objeto.Name:lower():find("treadmill") or objeto.Name:lower():find("run") or objeto:FindFirstChild("Price") then
        activarTreadmill(objeto)
    end
end

-- 🛡️ PROTECCIÓN: Si el juego intenta poner el precio de nuevo, lo volvemos a cambiar
Workspace.DescendantAdded:Connect(function(objeto)
    if objeto:IsA("NumberValue") and (objeto.Name == "Price" or objeto.Name == "Cost") then
        objeto.Value = 0
        print("💰 Precio cambiado a $0")
    end
    if objeto:IsA("BoolValue") and objeto.Name == "Owned" then
        objeto.Value = true
    end
end)

print("✅ Listo! Ya puedes pararte y usar todas sin pagar.")
