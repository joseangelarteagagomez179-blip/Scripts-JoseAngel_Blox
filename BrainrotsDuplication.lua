-- Servicios necesarios
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Función principal
local function DuplicarTodo()
    -- 1. Buscar donde están guardados los Brainrots
    -- (Usualmente está en leaderstats o en una carpeta llamada Inventory)
    local leaderstats = player:FindFirstChild("leaderstats")
    
    if leaderstats then
        -- 2. Recorrer todos los valores dentro
        for _, v in pairs(leaderstats:GetChildren()) do
            -- 3. Verificar si es un valor numérico (IntValue o NumberValue)
            if v:IsA("IntValue") or v:IsA("NumberValue") then
                -- 4. Duplicar o poner cantidad infinita
                v.Value = 999999999 -- Cambia el número por el que quieras
                print("Duplicado: " .. v.Name .. " -> " .. v.Value)
            end
        end
    end
end

-- Ejecutar la función
DuplicarTodo()

print("✅ Tus Brainrots han sido duplicados!")
