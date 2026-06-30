-- VER LO QUE HAY DENTRO DE TYCOONS
print("=== CONTENIDO DE TYCOONS ===")
local Tycoons = game.Workspace:FindFirstChild("Tycoons")
if Tycoons then
    for _, cosa in pairs(Tycoons:GetChildren()) do
        print("📂 " .. cosa.Name)
    end
else
    print("❌ No se encontró la carpeta Tycoons")
end
