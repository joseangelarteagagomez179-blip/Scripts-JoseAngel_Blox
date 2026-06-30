-- VER LO QUE HAY DENTRO DE PLOT1
print("=== CONTENIDO DE PLOT1 ===")
local Plot = game.Workspace.Tycoons:FindFirstChild("Plot1") -- Cambia a Plot2 o Plot3 si no estás en el 1
if Plot then
    for _, objeto in pairs(Plot:GetChildren()) do
        print("📦 " .. objeto.Name)
    end
else
    print("❌ No se encontró el Plot")
end
