-- == SCRIPT COMPLETO - MANSION TYCOON ==
-- Creado con los datos encontrados en tu juego

-- Servicios
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

-- Variables
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local PlayerGui = LocalPlayer.PlayerGui

-- ==============================================
-- 🔥 CONFIGURACIÓN (Activa lo que quieras)
-- ==============================================
local AutoFarm = true       -- Recoge dinero automáticamente
local AutoClickButtons = true -- Clickea los botones de dinero
local SpeedBoost = true     -- Velocidad y salto alto

-- ==============================================
-- 1. AUTO FARM (IR HASTA EL DINERO)
-- ==============================================
if AutoFarm then
    spawn(function()
        while task.wait(0.3) do
            for _, obj in pairs(Workspace:GetDescendants()) do
                -- Buscamos por los nombres que encontraste: MoneyTier, CashToCollect, etc.
                local nombre = obj.Name:lower()
                if string.find(nombre, "money") or string.find(nombre, "cash") or string.find(nombre, "collect") then
                    if obj:IsA("Part") or obj:IsA("MeshPart") then
                        -- Teletransportarse al objeto
                        Character.HumanoidRootPart.CFrame = obj.CFrame + Vector3.new(0, 2, 0)
                        task.wait(0.1)
                    end
                end
            end
        end
    end)
end

-- ==============================================
-- 2. AUTO CLICK EN BOTONES DE DINERO
-- ==============================================
if AutoClickButtons then
    spawn(function()
        while task.wait(0.5) do
            -- Ruta encontrada: Workspace.Tycoons.Plot1.Tycoon8.Mansion.GlobalMoneyButtons.MoneyTierX
            local BotonesDinero = Workspace:FindFirstChild("Tycoons")
            if BotonesDinero then
                for _, boton in pairs(BotonesDinero:GetDescendants()) do
                    if boton:FindFirstChildOfClass("ClickDetector") then
                        -- Hacer clic
                        fireclickdetector(boton.ClickDetector)
                        task.wait(0.05)
                    end
                end
            end
        end
    end)
end

-- ==============================================
-- 3. VELOCIDAD Y SALTO
-- ==============================================
if SpeedBoost then
    Humanoid.WalkSpeed = 70
    Humanoid.JumpPower = 150
end

-- ==============================================
-- 4. AUTO COMPRAR / MEJORAR (Opcional)
-- ==============================================
-- Si quieres que clickee los botones de la tienda (BuyButton, PurchaseButton, etc.)
spawn(function()
    while task.wait(1) do
        -- Busca cualquier botón que diga "Buy" o "Purchase" en la GUI
        for _, guiObj in pairs(PlayerGui:GetDescendants()) do
            if guiObj:IsA("TextButton") or guiObj:IsA("ImageButton") then
                local nombre = guiObj.Name:lower()
                if string.find(nombre, "buy") or string.find(nombre, "purchase") then
                    -- Simular clic
                    guiObj.MouseButton1Click:Fire()
                end
            end
        end
    end
end)

print("✅ SCRIPT ACTIVO - TODO FUNCIONANDO!")
