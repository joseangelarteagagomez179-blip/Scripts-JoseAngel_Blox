-- // Brainrots Duplications //
-- Creado por: JoseAngel_Blox
-- Fecha: 22/06/2026

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/Source.lua"))()

-- Tema personalizado
local Colors = {
    SchemeColor = Color3.fromRGB(74, 99, 135),
    Background = Color3.fromRGB(36, 37, 43),
    Header = Color3.fromRGB(28, 29, 34),
    TextColor = Color3.fromRGB(255,255,255),
    ElementColor = Color3.fromRGB(32, 32, 38)
}

-- Crear ventana CUADRADA y MOVIBLE
local Window = Library.CreateLib("Brainrots Duplications", Colors)
Window.Frame.Size = UDim2.new(0, 350, 0, 400) -- Tamaño cuadrado
Window.Frame.ClipsDescendants = true
Window.Frame.Active = true
Window.Frame.Draggable = true -- AQUÍ SE PUEDE MOVER
Window.Frame:TweenSizeAndPosition(UDim2.new(0, 350, 0, 400), UDim2.new(0.5, -175, 0.5, -200), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)

-- Hacer ESQUINAS REDONDEADAS
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Window.Frame

-- 🖼️ IMAGEN DE FONDO
spawn(function()
    wait(0.5)
    local MainFrame = Window.Frame
    if MainFrame then
        local BackgroundImage = Instance.new("ImageLabel")
        BackgroundImage.Name = "BackgroundImage"
        BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
        BackgroundImage.Position = UDim2.new(0, 0, 0, 0)
        BackgroundImage.AnchorPoint = Vector2.new(0, 0)
        BackgroundImage.BackgroundTransparency = 1
        BackgroundImage.Image = "rbxassetid://120999595778887"
        BackgroundImage.ScaleType = Enum.ScaleType.Stretch
        BackgroundImage.ZIndex = -1
        BackgroundImage.Parent = MainFrame
    end
end)

-- Servicios
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

-- ==============================================
-- 📢 MENSAJE DE INICIO
-- ==============================================
local TabInfo = Window:NewTab("Info")
local SectionInfo = TabInfo:NewSection("Datos del Script")

SectionInfo:NewLabel("👑 Creador: JoseAngel_Blox")
SectionInfo:NewLabel("📅 Lanzamiento: 22/06/2026")
SectionInfo:NewLabel("")
SectionInfo:NewLabel("✅ Script cargado correctamente!")
SectionInfo:NewLabel("🔧 Ve a la pestaña Duplicar para usar.")

-- ==============================================
// 🌀 SECCIÓN: DUPLICAR (SELECCIÓN)
-- ==============================================
local TabDupe = Window:NewTab("Duplicar")
local SectionSelect = TabDupe:NewSection("Selecciona el Brainrot")

-- Variable para guardar la selección
_G.BrainrotSeleccionado = nil

-- Lista de Brainrots encontrados
local function ActualizarLista()
    SectionSelect:Clear() -- Limpiar la lista
    
    -- Buscar brainrots
    local encontrados = {}
    for _, objeto in pairs(Workspace:GetChildren()) do
        if objeto.Name:find("Brainrot") or objeto:FindFirstChild("Humanoid") then
            table.insert(encontrados, objeto)
        end
    end
    
    if #encontrados == 0 then
        SectionSelect:NewLabel("❌ No hay Brainrots cerca")
    else
        SectionSelect:NewLabel("✅ Brainrots encontrados: "..#encontrados)
        SectionSelect:NewLabel("Selecciona uno para duplicar:")
        
        -- Crear botones para cada uno
        for _, objeto in pairs(encontrados) do
            SectionSelect:NewButton(objeto.Name, "Click para seleccionar", function()
                _G.BrainrotSeleccionado = objeto
                print("✅ Seleccionado: " .. objeto.Name)
            end)
        end
    end
end

-- Botón para actualizar lista
SectionSelect:NewButton("🔄 Refrescar Lista", "Buscar de nuevo", function()
    ActualizarLista()
end)

-- ==============================================
// 🚀 INICIAR DUPLICADO
-- ==============================================
local SectionAction = TabDupe:NewSection("Acción")

_G.Duplicar = false

local function DuplicarSeleccionado()
    while _G.Duplicar do
        pcall(function()
            if _G.BrainrotSeleccionado and _G.BrainrotSeleccionado.Parent then
                local clon = _G.BrainrotSeleccionado:Clone()
                clon.Parent = Workspace
                clon.Position = _G.BrainrotSeleccionado.Position + Vector3.new(math.random(-2,2), 0.5, math.random(-2,2))
                
                if clon:FindFirstChild("Owner") then
                    clon.Owner.Value = Player.Name
                end
                
                print("✅ Duplicado: " .. _G.BrainrotSeleccionado.Name)
            else
                print("⚠️ Selecciona un Brainrot primero")
            end
        end)
        task.wait(0.3)
    end
end

SectionAction:NewToggle("🚀 Iniciar Duplicado", "Duplica el que elegiste", function(state)
    _G.Duplicar = state
    if state then
        spawn(DuplicarSeleccionado)
    end
end)

-- ==============================================
// 🧹 EXTRAS
-- ==============================================
local TabExtras = Window:NewTab("Extras")
local SectionOtros = TabExtras:NewSection("Opciones")

SectionOtros:NewButton("🧹 Limpiar Clones", "Eliminar copias", function()
    for _, v in pairs(Workspace:GetChildren()) do
        if v.Name:find("Clone") or v.Name:find("Copy") then
            v:Destroy()
        end
    end
    print("🧹 Limpieza completada!")
end)

SectionOtros:NewLabel("⚠️ Usa con moderación")

-- Cargar lista al inicio
spawn(function()
    wait(1)
    ActualizarLista()
end)

-- 💬 MENSAJE EN CONSOLA AL EJECUTAR
print("====================================")
print("       Brainrots Duplications       ")
print("   Creado por: JoseAngel_Blox       ")
print("   Fecha: 22/06/2026               ")
print("====================================")
print("✅ Script cargado y listo para usar!")
