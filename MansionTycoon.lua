-- Cargar interfaz gráfica
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Crear ventana principal
local Window = Rayfield:CreateWindow({
    Name = "🏰 Mansion Tycoon Script 🏰",
    LoadingTitle = "Cargando...",
    LoadingSubtitle = "Para el juego oficial",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "MansionTycoon",
        FileName = "Config"
    },
    KeySystem = false
})

-- Variables
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Tycoon = nil

-- Encontrar tu mansión/tycoon
local function FindMyTycoon()
    for _, obj in pairs(game.Workspace:GetChildren()) do
        if obj:FindFirstChild("Owner") and obj.Owner.Value == Player then
            Tycoon = obj
            break
        end
    end
    return Tycoon
end

FindMyTycoon()
if not Tycoon then
    Rayfield:Notify({
        Title = "⚠️ Aviso",
        Content = "No se encontró tu mansión. Asegúrate de haber empezado el juego.",
        Duration = 5
    })
    return
end

-- Pestaña Principal
local MainTab = Window:CreateTab("⚡ Funciones", 4483362458)

-- 🔄 Anti AFK
MainTab:CreateToggle({
    Name = "Anti AFK",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            Rayfield:Notify({Title = "Activado", Content = "No te expulsarán por inactividad", Duration = 3})
            while Value and task.wait(30) do
                game:GetService("VirtualUser"):CaptureController()
                game:GetService("VirtualUser"):ClickButton2(Vector2.new())
            end
        end
    end
})

-- 💰 Auto Recolectar Dinero
MainTab:CreateToggle({
    Name = "Auto Recolectar Dinero",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            Rayfield:Notify({Title = "Activado", Content = "Recolectando dinero automáticamente", Duration = 3})
            while Value and task.wait(0.3) do
                for _, item in pairs(Tycoon:GetDescendants()) do
                    if item:IsA("Part") and (item.Name:find("Money") or item.Name:find("Cash")) then
                        firetouchinterest(Character.HumanoidRootPart, item, 0)
                        firetouchinterest(Character.HumanoidRootPart, item, 1)
                        task.wait(0.05)
                    end
                end
            end
        end
    end
})

-- 🛒 Auto Comprar Mejoras
MainTab:CreateToggle({
    Name = "Auto Comprar Mejoras",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            Rayfield:Notify({Title = "Activado", Content = "Comprando mejoras automáticamente", Duration = 3})
            while Value and task.wait(0.5) do
                for _, button in pairs(Tycoon:GetDescendants()) do
                    if button:IsA("ClickDetector") and button.Parent:FindFirstChild("Price") then
                        local precio = button.Parent.Price.Value
                        if Player.leaderstats and Player.leaderstats:FindFirstChild("Cash") and Player.leaderstats.Cash.Value >= precio then
                            button:FireServer()
                            task.wait(0.1)
                        end
                    end
                end
            end
        end
    end
})

-- 🏎️ Velocidad y Salto
MainTab:CreateSlider({
    Name = "Velocidad",
    Range = {16, 100},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(Value)
        Character.Humanoid.WalkSpeed = Value
    end
})

MainTab:CreateSlider({
    Name = "Altura de Salto",
    Range = {50, 200},
    Increment = 5,
    CurrentValue = 50,
    Callback = function(Value)
        Character.Humanoid.JumpPower = Value
    end
})

-- 🚗 Teletransportes
local TeleportTab = Window:CreateTab("🚀 Teletransportes", 10734896474)

TeleportTab:CreateButton({
    Name = "Ir a Pista de Carreras",
    Callback = function()
        local pista = game.Workspace:FindFirstChild("RaceTrack") or game.Workspace:FindFirstChild("Racetrack")
        if pista then
            Character.HumanoidRootPart.CFrame = pista.CFrame + Vector3.new(0, 5, 0)
        end
    end
})

TeleportTab:CreateButton({
    Name = "Ir a Tienda",
    Callback = function()
        local tienda = game.Workspace:FindFirstChild("Shop") or game.Workspace:FindFirstChild("Store")
        if tienda then
            Character.HumanoidRootPart.CFrame = tienda.CFrame + Vector3.new(0, 5, 0)
        end
    end
})

-- Notificación final
Rayfield:Notify({
    Title = "✅ Listo!",
    Content = "Script cargado correctamente para Mansion Tycoon",
    Duration = 5,
    Image = 13047715178
})
