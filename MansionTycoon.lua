-- ==============================================
-- SCRIPT BUSCADOR DE OBJETOS
-- ==============================================

-- 1. BUSCAR DINERO / ITEMS
print("=== BUSCANDO OBJETOS DE DINERO ===")
for _, obj in pairs(workspace:GetDescendants()) do
    -- Busca por nombres comunes
    if string.find(obj.Name:lower(), "money") or 
       string.find(obj.Name:lower(), "cash") or 
       string.find(obj.Name:lower(), "drop") or
       string.find(obj.Name:lower(), "coin") then
        
        print("✅ Encontrado: " .. obj.Name .. " | Ruta: " .. obj:GetFullName())
    end
end

-- 2. BUSCAR BOTONES (ClickDetector)
print("\n=== BUSCANDO BOTONES CON CLICKDETECTOR ===")
for _, obj in pairs(workspace:GetDescendants()) do
    if obj:FindFirstChildOfClass("ClickDetector") then
        print("🔘 Botón encontrado: " .. obj.Name .. " | Ruta: " .. obj:GetFullName())
    end
end

-- 3. BUSCAR ELEMENTOS EN LA INTERFAZ (GUI)
print("\n=== BUSCANDO ELEMENTOS EN LA INTERFAZ ===")
local PlayerGui = game.Players.LocalPlayer.PlayerGui
for _, gui in pairs(PlayerGui:GetDescendants()) do
    if gui:IsA("TextButton") or gui:IsA("ImageButton") then
        print("🖱️ Botón GUI: " .. gui.Name .. " | Ruta: " .. gui:GetFullName())
    end
end

print("\n✅ Busqueda terminada! Copia las rutas que te sirvan.")
