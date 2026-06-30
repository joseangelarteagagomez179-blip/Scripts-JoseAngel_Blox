-- =============================================
-- SCRIPT MANSION TYCOON
-- FUNCIONES: AUTO COLLECT Y AUTO COMPRAR MEJORAS
-- =============================================

print("✅ SCRIPT CARGADO - AUTO FARM ACTIVO")

-- SERVICIOS
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- 📍 RUTA BASE (AJUSTA LOS NÚMEROS SI TE CAMBIAS DE PLOT)
local RutaBase = game.Workspace.Tycoons.Plot1.Tycoon3.Mansion

-- 1. BOTÓN DE AUTO COLLECT
local AutoCollectButton = RutaBase.GlobalButtons:FindFirstChild("AutoCollect")

-- 2. BOTONES DE MEJORAS (MoneyTier1 al 8)
local Mejoras = {
    "MoneyTier1",
    "MoneyTier2",
    "MoneyTier3",
    "MoneyTier4",
    "MoneyTier5",
    "MoneyTier6",
    "MoneyTier7",
    "MoneyTier8"
}

-- FUNCIÓN PARA HACER CLIC
local function click(button)
    if button then
        fireclickdetector(button)
        print("🖱️  Comprado: " .. button.Name)
    end
end

-- == TAREA 1: MANTENER AUTO COLLECT ACTIVO ==
spawn(function()
    while wait(1) do
        if AutoCollectButton then
            click(AutoCollectButton)
        end
    end
end)

-- == TAREA 2: COMPRAR MEJORAS AUTOMÁTICAMENTE ==
spawn(function()
    while wait(0.5) do -- Revisa cada medio segundo
        for _, nombreMejora in pairs(Mejoras) do
            -- Buscamos el botón dentro de GlobalMoneyButtons
            local boton = RutaBase.GlobalMoneyButtons:FindFirstChild(nombreMejora)
            if boton then
                click(boton)
            end
        end
    end
end)

print("🚀 TODO ACTIVO: Recolectando y Comprando!")
