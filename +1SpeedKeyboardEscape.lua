-- Buscar la sección de gamepasses o cintas
local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui
local Treadmills = PlayerGui:WaitForChild("TreadmillUI") -- Nombre puede variar

-- Desbloquear todas las cintas
for _, treadmill in pairs(Treadmills:GetChildren()) do
    if treadmill:FindFirstChild("Locked") then
        treadmill.Locked.Value = false -- Quitar el bloqueo
    end
    if treadmill:FindFirstChild("Owned") then
        treadmill.Owned.Value = true -- Marcar como comprada
    end
end

print("✅ Todas las cintas de correr desbloqueadas!")
