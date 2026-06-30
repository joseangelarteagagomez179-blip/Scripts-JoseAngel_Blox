-- MOSTRAR TODOS LOS OBJETOS EN WORKSPACE
print("=== LISTA DE OBJETOS EN WORKSPACE ===")
for _, objeto in pairs(game.Workspace:GetChildren()) do
    print("📦 " .. objeto.Name)
end
print("======================================")
