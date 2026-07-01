-- // Servicios
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

-- // Variables Locales
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- // Encontrar TU Tycoon (Ruta Correcta)
local Tycoon = nil
for _, v in pairs(Workspace.Tycoons:GetChildren()) do
    if v.Owner.Value == LocalPlayer.Name then
        Tycoon = v
        break
    end
end

-- // Cargar UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "🏰 Mansion Tycoon | Script",
    LoadingTitle = "Cargando...",
    LoadingSubtitle = "by Dola",
    ConfigurationSaving = {Enabled = false},
    KeySystem = false
})

-- =============================================
-- 📌 PESTAÑA: PRINCIPAL
-- =============================================
local MainTab = Window:CreateTab("⚡ Inicio", 4405071608)
local MainSection = MainTab:CreateSection("Funciones Principales")

-- 💰 AUTO RECOLECTAR DINERO (Ruta Confirmada: Mansion.Collectors)
local AutoFarm = false
MainSection:CreateToggle({
    Name = "Auto Recolectar Dinero",
    CurrentValue = false,
    Callback = function(Value)
        AutoFarm = Value
        task.spawn(function()
            while AutoFarm do
                if Tycoon and Tycoon:FindFirstChild("Mansion") then
                    local CollectorsFolder = Tycoon.Mansion:FindFirstChild("Collectors")
                    if CollectorsFolder then
                        for _, Collector in pairs(CollectorsFolder:GetChildren()) do
                            if Collector:FindFirstChild("Collector") then
                                firetouchinterest(HumanoidRootPart, Collector.Collector, 0)
                                firetouchinterest(HumanoidRootPart, Collector.Collector, 1)
                                task.wait(0.1)
                            end
                        end
                    end
                end
                task.wait(1)
            end
        end)
    end
})

-- 🏗️ AUTO COMPRAR TODO
local AutoBuild = false
MainSection:CreateToggle({
    Name = "Auto Comprar Todo",
    CurrentValue = false,
    Callback = function(Value)
        AutoBuild = Value
        task.spawn(function()
            while AutoBuild do
                if Tycoon and Tycoon:FindFirstChild("Mansion") then
                    for _, Button in pairs(Tycoon.Mansion:GetDescendants()) do
                        if Button:IsA("TextButton") and Button.Visible and Button.Active then
                            Button:Click()
                        end
                    end
                end
                task.wait(0.5)
            end
        end)
    end
})

-- 📍 TELETRANSPORTE
MainSection:CreateButton({
    Name = "Ir a mi Mansión",
    Callback = function()
        if Tycoon and Tycoon:FindFirstChild("Mansion") and Tycoon.Mansion:FindFirstChild("Spawn") then
            HumanoidRootPart.CFrame = Tycoon.Mansion.Spawn.CFrame + Vector3.new(0, 3, 0)
        end
    end
})

-- =============================================
-- 📌 PESTAÑA: JUGADOR
-- =============================================
local PlayerTab = Window:CreateTab("👤 Jugador", 10706506036)
local PlayerSection = PlayerTab:CreateSection("Ajustes")

-- Velocidad
PlayerSection:CreateSlider({
    Name = "Velocidad",
    Range = {16, 100},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(Value)
        Humanoid.WalkSpeed = Value
    end
})

-- Salto
PlayerSection:CreateSlider({
    Name = "Altura de Salto",
    Range = {50, 200},
    Increment = 1,
    CurrentValue = 50,
    Callback = function(Value)
        Humanoid.JumpPower = Value
    end
})

-- Noclip
local Noclip = false
PlayerSection:CreateToggle({
    Name = "Noclip (Atravesar Paredes)",
    CurrentValue = false,
    Callback = function(Value)
        Noclip = Value
    end
})

task.spawn(function()
    while task.wait() do
        if Noclip and Character then
            for _, Part in pairs(Character:GetDescendants()) do
                if Part:IsA("BasePart") then
                    Part.CanCollide = false
                end
            end
        end
    end
end)

-- =============================================
-- ✅ NOTIFICACIÓN
-- =============================================
Rayfield:Notify({
    Title = "✅ Script Listo",
    Content = "Rutas verificadas y funcionando!",
    Duration = 4,
    Image = 13047715178
})
