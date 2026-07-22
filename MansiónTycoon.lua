-- ⚡ SCRIPT MANSIÓN TYCOON | joseangel_blox ⚡
-- ✅ Compatible con Delta Executor | ✅ Funciona en todos los niveles
-- 📌 Usa Dex Explorer para verificar rutas si hay actualizaciones

-- ⚙️ CONFIGURACIÓN
getgenv().Config = {
    AutoCollect = true,       -- Recolectar dinero automáticamente
    AutoBuild = true,         -- Comprar todas las mejoras
    AutoVehicles = true,     -- Desbloquear coches/vehículos
    AutoClaimRewards = true, -- Reclamar $10k grupo y bonos
    AntiAFK = true,           -- No te expulsa por inactividad
    SpeedBoost = false,      -- Velocidad extra
    LoopDelay = 0.3           -- Tiempo entre cada acción
}

-- 🧰 SERVICIOS
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Workspace = game:GetService("Workspace")

-- 🔍 DETECTAR TU MANSIÓN
local function GetMyTycoon()
    for _, Tycoon in pairs(Workspace:FindFirstChild("Tycoons", true) or Workspace:GetChildren()) do
        if Tycoon:FindFirstChild("Owner") and Tycoon.Owner.Value == LocalPlayer.Name then
            return Tycoon
        end
    end
    return nil
end

-- 💰 AUTO RECOLECTAR DINERO
local function AutoCollectMoney(Tycoon)
    if not Config.AutoCollect then return end
    local Collectors = Tycoon:FindFirstChild("Collectors", true) or Tycoon:FindFirstChild("Money", true)
    if Collectors then
        for _, Collector in pairs(Collectors:GetDescendants()) do
            if Collector:IsA("BasePart") and Collector:FindFirstChild("Collect") then
                fireclickdetector(Collector.Collect)
            elseif Collector:IsA("GuiButton") then
                pcall(function() Collector:Activate() end)
            end
        end
    end
    -- 📌 Con Dex Explorer: busca rutas como Workspace.Tycoons.TuMansion.Collectors
end

-- 🏗️ AUTO CONSTRUIR / COMPRAR
local function AutoBuildAll(Tycoon)
    if not Config.AutoBuild then return end
    local Buttons = Tycoon:FindFirstChild("Buttons", true) or Tycoon:FindFirstChild("Upgrades", true)
    if Buttons then
        for _, Button in pairs(Buttons:GetDescendants()) do
            if Button:IsA("BasePart") and Button:FindFirstChild("ClickDetector") then
                fireclickdetector(Button.ClickDetector)
            elseif Button:IsA("GuiButton") then
                pcall(function() Button:Activate() end)
            end
        end
    end
    -- 🚗 Vehículos y mejoras generales
    local Shops = Tycoon:FindFirstChild("Shop", true) or Workspace:FindFirstChild("VehicleShop", true)
    if Shops and Config.AutoVehicles then
        for _, Item in pairs(Shops:GetDescendants()) do
            if Item:IsA("GuiButton") or Item:FindFirstChild("ClickDetector") then
                fireclickdetector(Item.ClickDetector or nil)
            end
        end
    end
end

-- 🎁 RECLAMAR RECOMPENSAS
local function ClaimRewards()
    if not Config.AutoClaimRewards then return end
    pcall(function()
        if PlayerGui:FindFirstChild("RewardGui", true) then
            PlayerGui.RewardGui.Claim:Activate()
        end
        -- Verificación del grupo $10k
        if PlayerGui:FindFirstChild("VerifyGui", true) then
            PlayerGui.VerifyGui.Verify:Activate()
        end
    end)
end

-- 🛡️ ANTI AFK
if Config.AntiAFK then
    task.spawn(function()
        while task.wait(58) do
            pcall(function()
                LocalPlayer.Character.Humanoid:Move(Vector3.new(0, 0, 0))
            end)
        end
    end)
end

-- 🚀 BUCLE PRINCIPAL
task.spawn(function()
    while task.wait(Config.LoopDelay) do
        local MyTycoon = GetMyTycoon()
        if MyTycoon then
            AutoCollectMoney(MyTycoon)
            AutoBuildAll(MyTycoon)
            ClaimRewards()
        end
    end
end)

-- 📢 MENSAJE INICIO
game:GetService("StarterGui"):SetCore("SendNotification",{
    Title = "✅ SCRIPT CARGADO",
    Text = "Mansión Tycoon | joseangel_blox 🚀",
    Duration = 5
})

print("✅ Script activado correct
amente!")
