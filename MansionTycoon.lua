-- Script para Mansion Tycoon | Auto Collect & Auto Buy
-- Creado para ti ❤️

-- Cargar la interfaz bonita
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Crear ventana principal
local Window = Rayfield:CreateWindow({
    Name = "🏰 Mansion Tycoon | Script",
    LoadingTitle = "Cargando...",
    LoadingSubtitle = "Hecho con amor para ti ❤️",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "MansionTycoon",
        FileName = "Settings"
    }
})

-- Crear pestañas
local MainTab = Window:CreateTab("🏠 Principal", 4483362458)
local MiscTab = Window:CreateTab("⚙️ Extras", 4483362458)

-- Variables principales
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- 🔹 Auto Collect Money
MainTab:CreateToggle({
    Name = "💰 Recoger Dinero Automático",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().AutoCollect = Value
        if Value then
            spawn(function()
                while getgenv().AutoCollect do
                    for _, v in pairs(workspace:GetChildren()) do
                        if v:FindFirstChild("Money") then
                            firetouchinterest(Character.HumanoidRootPart, v.Money, 0)
                        end
                    end
                    wait(0.5)
                end
            end)
        end
    end
})

-- 🔹 Auto Buy Upgrades
MainTab:CreateToggle({
    Name = "🛒 Comprar Mejoras Automático",
    CurrentValue = false,
    Callback = function(Value)
        getgenv().AutoBuy = Value
        if Value then
            spawn(function()
                while getgenv().AutoBuy do
                    for _, v in pairs(workspace:GetChildren()) do
                        if v:FindFirstChild("Button") then
                            fireclickdetector(v.Button.ClickDetector)
                        end
                    end
                    wait(1)
                end
            end)
        end
    end
})

-- 🔹 Velocidad Extra
MiscTab:CreateSlider({
    Name = "⚡ Velocidad",
    Range = {16, 100},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(Value)
        Humanoid.WalkSpeed = Value
    end
})

-- 🔹 Salto Alto
MiscTab:CreateToggle({
    Name = "🦘 Salto Alto",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            Humanoid.JumpPower = 100
        else
            Humanoid.JumpPower = 50
        end
    end
})

-- Notificación de inicio
Rayfield:Notify({
    Title = "¡Script Listo!",
    Content = "Disfruta construyendo tu mansión ❤️",
    Duration = 5,
    Image = 4483362458
})
