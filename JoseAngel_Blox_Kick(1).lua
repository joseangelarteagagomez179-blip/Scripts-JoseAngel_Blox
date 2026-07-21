-- ==============================================
-- 🎭 TODAS LAS SKINS DE LA TIENDA | SOLO VISUAL
-- Creado por: JoseAngel_Blox 🇻🇪
-- ⚠️ AVISO: Solo tú verás los cambios, es local
-- ==============================================

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local OriginalCaracteristicas = {}

-- Guardamos tu apariencia original para restaurarla
for _, Objeto in pairs(Character:GetChildren()) do
    if Objeto:IsA("Shirt") or Objeto:IsA("Pants") or Objeto:IsA("Accessory") or Objeto:IsA("BodyColors") then
        table.insert(OriginalCaracteristicas, {Objeto = Objeto, Padre = Objeto.Parent})
    end
end

-- Interfaz bonita y lista para usar
local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/SimpleUI/main/Source.lua"))()
local Ventana = UI:CreateWindow("🎭 Tienda Completa | JoseAngel_Blox")

-- Secciones igual que en la tienda
local SeccionAvatares = Ventana:AddFolder("👤 Avatares Completos")
local SeccionRopa = Ventana:AddFolder("👕 Ropa y Accesorios")
local SeccionUtilidades = Ventana:AddFolder("⚙️ Opciones")

-- Función para equipar cualquier ID del catálogo
local function EquiparID(IdAsset)
    task.spawn(function()
        local exito, asset = pcall(function()
            return game:GetService("InsertService"):LoadAsset(IdAsset):GetChildren()
        end)
        if exito and asset then
            for _, parte in pairs(asset) do
                if parte:IsA("Model") then parte = parte:FindFirstChildWhichIsA("Model") or parte end
                if parte:IsA("Accessory") or parte:IsA("Shirt") or parte:IsA("Pants") or parte:IsA("Character") then
                    parte.Parent = Character
                end
            end
            game:GetService("StarterGui"):SetCore("SendNotification",{
                Title = "✅ PUESTO",
                Text = "¡Ahora lo ves puesto!",
                Duration = 2.5
            })
        end
    end)
end

-- 📋 Ejemplos de los estilos que salían en tu foto
SeccionAvatares:AddButton("😈 Vamp Y2K", function() EquiparID(1234567890) end) -- Cambia el ID por el real
SeccionAvatares:AddButton("🖤 Emo Vkei", function() EquiparID(1234567891) end)
SeccionAvatares:AddButton("⚡ Rey Ecliptix", function() EquiparID(1234567892) end)
SeccionAvatares:AddButton("🤍 Foltyn Blanco", function() EquiparID(1234567893) end)
SeccionAvatares:AddButton("🥷 Chico Emo Anime", function() EquiparID(1234567894) end)

-- 📝 Campo para poner CUALQUIER ID de la tienda
SeccionUtilidades:AddTextbox("Pega ID de cualquier objeto:", function(texto)
    local id = tonumber(texto)
    if id then EquiparID(id) end
end)

-- Restaurar tu apariencia
SeccionUtilidades:AddButton("↩️ Volver a mi Avatar", function()
    Player:LoadCharacter()
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "✅ RESTAURADO",
        Text = "Volviste a tu apariencia normal",
        Duration = 2
    })
end)

Ventana:AddLabel("© JoseAngel_Blox | Solo visual 🎨")

UI:Init()
