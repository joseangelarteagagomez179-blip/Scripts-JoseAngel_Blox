-- Script Creado por Ti: Desbloquear Todas las Caminadoras
-- Juego: +1 Speed Keyboard Escape

-- Obtenemos la carpeta donde están todas las caminadoras
local Walkers = game:GetService("Workspace").Walkers

-- Recorremos cada caminadora que existe
for _, Walker in pairs(Walkers:GetChildren()) do
    
    -- Buscamos el botón o prompt que permite comprarla
    local BuyButton = Walker:FindFirstChild("BuyPrompt") or Walker:FindFirstChild("PurchasePrompt")

    -- Si encontramos el botón...
    if BuyButton then
        -- Disparamos la señal al servidor para comprarla
        BuyButton:FireServer()
        print("Caminadora desbloqueada: " .. Walker.Name)
    end
end

print("✅ Proceso terminado!")
