-- BUSCAR DINERO EN TODOS LOS TYCOONS
print("=== BUSCANDO DINERO... ===")
local Tycoons = game.Workspace:FindFirstChild("Tycoons")
if Tycoons then
    for _, tycoon in pairs(Tycoons:GetChildren()) do
        -- Buscamos dentro de cada Tycoon
        for _, objeto in pairs(tycoon:GetDescendants()) do
            -- Buscamos palabras clave en el nombre
            if string.find(objeto.Name:lower(), "money") or string.find(objeto.Name:lower(), "cash") or string.find(objeto.Name:lower(), "collect") or string.find(objeto.Name:lower(), "drop") or string.find(objeto.Name:lower(), "coin") then
                print("✅ ENCONTRADO: " .. objeto.Name)
                print("📍 RUTA: " .. objeto:GetFullName())
            end
        end
    end
    print("=== BUSQUEDA FINALIZADA ===")
else
    print("❌ No se encontró la carpeta Tycoons")
end
