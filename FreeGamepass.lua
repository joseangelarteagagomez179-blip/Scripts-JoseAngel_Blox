--// SERVICES
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

--// VARIABLES
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/Source.lua"))() -- UI Bonita
local Window = Library.CreateLib("Cartola V2 | Brookhaven", "Ocean")

--// TAB PRINCIPAL
local Tab = Window:NewTab("Gamepass Gratis")
local Section = Tab:NewSection("Desbloquear Todo")

--// FUNCION PRINCIPAL
Section:NewButton("Desbloquear Todo", "Obtener casas, coches y objetos premium", function()
    -- Esta es la magia que engaña al juego
    if PlayerGui:FindFirstChild("BrookhavenGUI") then
        -- Simulamos que tenemos todos los gamepass
        local args = {
            [1] = "Gamepasses",
            [2] = "OwnsAll",
            [3] = true
        }
        
        game:GetService("ReplicatedStorage"):WaitForChild("Brookhaven"):FireServer(unpack(args))
        
        -- Alternativa: Forzar valores locales
        pcall(function()
            for i, v in pairs(PlayerGui:GetChildren()) do
                if v:FindFirstChild("Gamepasses") then
                    for _, pass in pairs(v.Gamepasses:GetChildren()) do
                        pass.Value = true
                    end
                end
            end
        end)
        
        game.StarterGui:SetCore("SendNotification", {
            Title = "¡Listo!",
            Text = "Gamepass desbloqueados exitosamente ✅",
            Duration = 3
        })
    else
        game.StarterGui:SetCore("SendNotification", {
            Title = "Error",
            Text = "Espera a que cargue el juego completo",
            Duration = 3
        })
    end
end)

--// BOTON EXTRA: Cerrar GUI
Section:NewButton("Cerrar Menu", "Oculta la interfaz", function()
    Library:Destroy()
end)

print("✅ Script Cargado - Listo para usar!")
