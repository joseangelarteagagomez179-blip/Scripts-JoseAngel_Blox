-- // Brainrots Duplications //
-- Creado por: JoseAngel_Blox
-- Fecha: 22/06/2026

-- Usamos una librería más estable
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()

-- Configuración de la ventana
local Window = Library:CreateWindow({
    Name = "Brainrots Duplications",
    Size = UDim2.new(0, 350, 0, 400), -- Tamaño cuadrado
    Theme = "Dark",
    ColorScheme = Color3.fromRGB(74, 99, 135),
    ShowCustomCursor = false
})

-- Hacerla MOVIBLE y ESQUINAS REDONDEADAS
Window.Frame.Draggable = true
Window.Frame.Active = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Window.Frame

-- 🖼️ IMAGEN DE FONDO
spawn(function()
    wait(0.5)
    local BackgroundImage = Instance.new("ImageLabel")
    BackgroundImage.Name = "BackgroundImage"
    BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
    BackgroundImage.Position = UDim2.new(0, 0, 0, 0)
    BackgroundImage.AnchorPoint = Vector2.new(0, 0)
    BackgroundImage.BackgroundTransparency = 1
    BackgroundImage.Image = "rbxassetid://120999595778887"
    BackgroundImage.ScaleType = Enum.ScaleType.Stretch
    BackgroundImage.ZIndex = -1
    BackgroundImage.Parent = Window.Frame
end)

-- Servicios
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

-- ==============================================
-- 📢 PESTAÑA DE INFORMACIÓN
-- ==============================================
local TabInfo = Window:CreateTab("Info")

TabInfo:CreateLabel({
    Text = "👑 Creador: JoseAngel_Blox",
    Color = Color3.new(1,1,1)
})

TabInfo:CreateLabel({
    Text = "📅 Lanzamiento: 22/06/2026",
    Color = Color3.new(1,1,1)
})

TabInfo:CreateLabel({
    Text = "",
    Color = Color3.new(1,1,1)
})

TabInfo:CreateLabel({
    Text = "✅ Script cargado correctamente!",
    Color = Color3.new(0,1,0)
})

-- ==============================================
// 🌀 PESTAÑA DUPLICAR
-- ==============================================
local TabDupe = Window:CreateTab("Duplicar")

-- Variable para guardar el seleccionado
_G.BrainrotSeleccionado = nil

-- Función para actualizar lista
local function ActualizarLista()
    -- Limpiar botones viejos (si es necesario)
    for _, v in pairs(TabDupe:GetChildren()) do
        if v.Name == "Button" then
            v:Destroy()
        end
    end
    
    local encontrados = {}
    for _, objeto in pairs(Workspace:GetChildren()) do
        if objeto.Name:find("Brainrot") or objeto:FindFirstChild("Humanoid") then
            table.insert(encontrados, objeto)
        end
    end
    
    if #encontrados == 0 then
        TabDupe:CreateLabel({Text = "❌ No hay Brainrots cerca", Color = Color3.new(1,0,0)})
    else
        TabDupe:CreateLabel({Text = "✅ Brainrots encontrados: "..#encontrados, Color = Color3.new(0,1,0)})
        TabDupe:CreateLabel({Text = "Selecciona uno:", Color = Color3.new(1,1,1)})
        
        for _, objeto in pairs(encontrados) do
            TabDupe:CreateButton({
                Name = objeto.Name,
                Callback = function()
                    _G.BrainrotSeleccionado = objeto
                    print("✅ Seleccionado: " .. objeto.Name)
                end
            })
        end
    end
end

-- Botón refrescar
TabDupe:CreateButton({
    Name = "🔄 Refrescar Lista",
    Callback = function()
        ActualizarLista()
    end
})

-- ==============================================
// 🚀 ACCIÓN DE DUPLICAR
-- ==============================================
_G.Duplicar = false

local function DuplicarLoop()
    while _G.Duplicar do
        pcall(function()
            if _G.BrainrotSeleccionado and _G.BrainrotSeleccionado.Parent then
                local clon = _G.BrainrotSeleccionado:Clone()
                clon.Parent = Workspace
                clon.Position = _G.BrainrotSeleccionado.Position + Vector3.new(math.random(-2,2), 0.5, math.random(-2,2))
                
                if clon:FindFirstChild("Owner") then
                    clon.Owner.Value = Player.Name
                end
            end
        end)
        task.wait(0.3)
    end
end

TabDupe:CreateToggle({
    Name = "🚀 Iniciar Duplicado",
    CurrentValue = false,
    Callback = function(state)
        _G.Duplicar = state
        if state then
            spawn(DuplicarLoop)
        end
    end
})

-- ==============================================
// 🧹 EXTRAS
-- ==============================================
local TabExtras = Window:CreateTab("Extras")

TabExtras:CreateButton({
    Name = "🧹 Limpiar Clones",
    Callback = function()
        for _, v in pairs(Workspace:GetChildren()) do
            if v.Name:find("Clone") or v.Name:find("Copy") then
                v:Destroy()
            end
        end
        print("🧹 Limpieza completada!")
    end
})

TabExtras:CreateLabel({
    Text = "⚠️ Usa con moderación",
    Color = Color3.new(1,1,0)
})

-- Cargar lista al inicio
spawn(function()
    wait(1)
    ActualizarLista()
end)

-- 💬 MENSAJE EN CONSOLA
print("====================================")
print("       Brainrots Duplications       ")
print("   Creado por: JoseAngel_Blox       ")
print("   Fecha: 22/06/2026               ")
print("====================================")
print("✅ Script cargado y listo para usar!")
