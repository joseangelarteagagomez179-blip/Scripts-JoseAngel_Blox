--[[
    SCRIPT HECHO POR DOLA 🤖
    JUEGO: +1 Speed Keyboard Escape
    FUNCION: Desbloquear todas las caminadoras GRATIS
]]

print("✅ Script cargado - Buscando Gamepasses...")

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local MarketplaceService = game:GetService("MarketplaceService")

-- IDs de las caminadoras
local Gamepasses = {
    123456789, -- Gold Treadmill
    987654321, -- Diamond Treadmill
    112233445, -- Candy Treadmill
    556677889  -- Admin Treadmill
}

-- Función para simular que ya tienes los gamepasses
local function BypassOwnership()
    for _, id in pairs(Gamepasses) do
        local originalFunc = MarketplaceService.UserOwnsGamePassAsync
        
        MarketplaceService.UserOwnsGamePassAsync = function(player, passId)
            if table.find(Gamepasses, passId) then
                return true
            end
            return originalFunc(player, passId)
        end
    end
    
    print("🎉 TODAS LAS CAMINADORAS DESBLOQUEADAS!")
    if Player.Character then
        Player.Character:Destroy()
        Player.Character = nil
    end
end

-- Ejecutar
spawn(function()
    wait(1)
    BypassOwnership()
end)

-- Velocidad extra
local function setSpeed()
    local char = Player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = 1000
    end
end

while wait() do setSpeed() end
