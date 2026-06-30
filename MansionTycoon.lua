--[[
🏰 MANSION TYCOON - SCRIPT PERSONALIZADO
Basado en las rutas encontradas en tu juego
]]

-- Servicios
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

-- Variables
local LocalPlayer = Players.LocalPlayer
local Character = nil
local HumanoidRootPart = nil

-- Actualizar personaje
local function UpdateCharacter()
    Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
end
UpdateCharacter()
LocalPlayer.CharacterAdded:Connect(UpdateCharacter)

-- =============================================
-- 🟢 CONFIGURACIÓN
-- =============================================
local AutoCollect = true   -- Recolectar dinero
local AutoBuy = true       -- Comprar mejoras de dinero
local AutoClaim = true     -- Reclamar recompensas
local SpeedBoost = true    -- Velocidad extra

-- =============================================
-- 💰 AUTO RECOLECTAR DINERO (Collectors)
-- =============================================
task.spawn(function()
    while task.wait(0.1) do
        if AutoCollect and HumanoidRootPart then
            -- Busca en la ruta de recolectores
            local Collectors = Workspace:FindFirstChild("Collectors")
            if Collectors then
                for _, collector in pairs(Collectors:GetDescendants()) do
                    -- Busca las partes que dicen "CashToCollect" o similares
                    if collector.Name:find("Cash") or collector.Name:find("Money") then
                        if collector:IsA("Part") or collector:IsA("Model") then
                            -- Teletransporta el dinero hacia ti
                            collector.CFrame = HumanoidRootPart.CFrame
                        end
                    end
                end
            end
        end
    end
end)

-- =============================================
-- 🛒 AUTO COMPRAR MEJORAS (MoneyButtons)
-- =============================================
task.spawn(function()
    while task.wait(0.5) do
        if AutoBuy then
            -- Busca en la ruta exacta que viste: Tycoons > Plot > ... > GlobalMoneyButtons
            local Tycoons = Workspace:FindFirstChild("Tycoons")
            if Tycoons then
                for _, plot in pairs(Tycoons:GetChildren()) do
                    local MoneyButtons = plot:FindFirstChild("Mansion") and plot.Mansion:FindFirstChild("GlobalMoneyButtons")
                    if MoneyButtons then
                        for _, button in pairs(MoneyButtons:GetChildren()) do
                            -- Si tiene ClickDetector, lo clickeamos
                            if button:FindFirstChildOfClass("ClickDetector") then
                                fireclickdetector(button.ClickDetector)
                            end
                            -- Si es un botón GUI dentro del objeto
                            if button:FindFirstChildOfClass("ProximityPrompt") then
                                fireproximityprompt(button.ProximityPrompt)
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- =============================================
-- 🎁 AUTO RECLAMAR BOTONES GUI
-- =============================================
task.spawn(function()
    while task.wait(1) do
        if AutoClaim then
            local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
            if PlayerGui then
                -- Busca botones que digan "Claim", "Collect", "Ok", "Buy"
                for _, gui in pairs(PlayerGui:GetDescendants()) do
                    if gui:IsA("TextButton") or gui:IsA("ImageButton") then
                        local text = gui.Text:upper() or gui.Name:upper()
                        if text:find("CLAIM") or text:find("COLLECT") or text:find("OK") or text:find("BUY") then
                            -- Simular click
                            fireclickdetector(gui)
                        end
                    end
                end
            end
        end
    end
end)

-- =============================================
-- ⚡ VELOCIDAD Y SALTO
-- =============================================
task.spawn(function()
    while task.wait() do
        if SpeedBoost and Character then
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")
            if Humanoid then
                Humanoid.WalkSpeed = 60
                Humanoid.JumpHeight = 15
            end
        end
    end
end)

print("✅ SCRIPT CARGADO Y LISTO!")
print("🔹 Rutas detectadas: Collectors y GlobalMoneyButtons")
