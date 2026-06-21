-- Duplicador Brainrot - Versión "El que tengas agarrado"
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local backpack = player.Backpack

-- ========== CONFIGURACIÓN ==========
local CANTIDAD_DUPLICADOS = 10  -- Número de copias a crear
local INTERVALO = 0.15          -- Pausa entre duplicaciones

-- ========== FUNCIONES ==========

-- Función para obtener el Brainrot que tienes EQUIPADO (agarrado)
local function obtenerBrainrotEquipado()
    -- Buscar en el personaje (lo que tienes en la mano)
    for _, item in pairs(character:GetChildren()) do
        if item:IsA("Tool") and string.lower(item.Name):find("brainrot") then
            return item
        end
    end
    return nil
end

-- Función para obtener TODOS los Brainrots en tu inventario (para mostrar)
local function obtenerTodosBrainrots()
    local brainrots = {}
    for _, item in pairs(backpack:GetChildren()) do
        if item:IsA("Tool") and string.lower(item.Name):find("brainrot") then
            table.insert(brainrots, item)
        end
    end
    -- También revisar los equipados
    for _, item in pairs(character:GetChildren()) do
        if item:IsA("Tool") and string.lower(item.Name):find("brainrot") then
            table.insert(brainrots, item)
        end
    end
    return brainrots
end

-- Función PRINCIPAL: Duplicar el Brainrot que tienes agarrado
local function duplicarBrainrotEquipado()
    -- 1. Obtener el Brainrot que tienes en la mano
    local brainrot = obtenerBrainrotEquipado()
    
    if not brainrot then
        print("❌ No tienes ningún Brainrot equipado/agarrado")
        print("💡 Agarrá un Brainrot de tu inventario primero")
        return false
    end
    
    print("✅ Brainrot encontrado: " .. brainrot.Name)
    print("🔍 Este es el que vas a duplicar")
    
    -- 2. Contar cuántos hay antes
    local antes = #obtenerTodosBrainrots()
    print("📊 Brainrots totales antes: " .. antes)
    
    -- 3. Duplicar
    for i = 1, CANTIDAD_DUPLICADOS do
        -- Crear copia exacta
        local clone = brainrot:Clone()
        
        -- IMPORTANTE: La copia va a la mochila
        clone.Parent = backpack
        
        print("🔄 Copia #" .. i .. " creada: " .. clone.Name)
        task.wait(INTERVALO)
    end
    
    -- 4. Mostrar resultado
    local despues = #obtenerTodosBrainrots()
    print("✅ Duplicación completada!")
    print("📊 Brainrots totales ahora: " .. despues)
    print("➕ Se crearon: " .. (despues - antes) .. " copias")
    
    return true
end

-- ========== FUNCIÓN PARA VER BRAINROTS DISPONIBLES ==========

local function mostrarBrainrotsDisponibles()
    local brainrots = obtenerTodosBrainrots()
    if #brainrots == 0 then
        print("❌ No tienes Brainrots en tu inventario")
        return
    end
    
    print("🧠 Tus Brainrots:")
    for i, item in pairs(brainrots) do
        local ubicacion = (item.Parent == character and "✅ EQUIPADO" or "📦 Mochila")
        print("  " .. i .. ". " .. item.Name .. " - " .. ubicacion)
    end
end

-- ========== MÉTODO ALTERNATIVO: Por si el Clone no funciona ==========

local function duplicarMetodoAlternativo()
    local brainrot = obtenerBrainrotEquipado()
    if not brainrot then return false end
    
    print("🔄 Usando método alternativo...")
    
    -- Intentar diferentes métodos de duplicación
    local metodos = {
        function()
            -- Método 1: Crear copia y mover
            local clone = brainrot:Clone()
            clone.Parent = backpack
            return true
        end,
        function()
            -- Método 2: Desequipar y re-equipar
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:UnequipTools()
                task.wait(0.1)
                local clone = brainrot:Clone()
                clone.Parent = backpack
                humanoid:EquipTool(brainrot)
                return true
            end
            return false
        end,
        function()
            -- Método 3: Remote Event
            for _, event in pairs(game.ReplicatedStorage:GetChildren()) do
                if event:IsA("RemoteEvent") and 
                   (string.lower(event.Name):find("equip") or 
                    string.lower(event.Name):find("collect") or
                    string.lower(event.Name):find("pick")) then
                    event:FireServer(brainrot)
                    return true
                end
            end
            return false
        end
    }
    
    for _, metodo in pairs(metodos) do
        local exito = metodo()
        if exito then
            print("✅ Método alternativo funcionó")
            return true
        end
    end
    
    return false
end

-- ========== FUNCIÓN MEJORADA QUE INTENTA VARIOS MÉTODOS ==========

local function duplicarInteligente()
    local brainrot = obtenerBrainrotEquipado()
    if not brainrot then
        print("❌ Agarrá un Brainrot primero!")
        return
    end
    
    print("🧠 Brainrot seleccionado: " .. brainrot.Name)
    print("🔄 Intentando duplicar...")
    
    -- Intentar método principal
    local exito = duplicarBrainrotEquipado()
    
    -- Si falla, intentar alternativo
    if not exito then
        print("⚠️ Método principal falló, probando alternativa...")
        exito = duplicarMetodoAlternativo()
    end
    
    if exito then
        print("✅ ¡Duplicación exitosa!")
    else
        print("❌ Todos los métodos fallaron")
        print("💡 Probá manualmente: Desequipá y equipá el Brainrot")
    end
end

-- ========== GUI COMPLETA ==========

local function crearGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "DuplicadorGUI"
    screenGui.Parent = player.PlayerGui
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 320, 0, 250)
    frame.Position = UDim2.new(0.5, -160, 0.5, -125)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    frame.BackgroundTransparency = 0.05
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.fromRGB(150, 100, 255)
    frame.Active = true
    frame.Draggable = true
    frame.Parent = screenGui
    
    -- Título
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 45)
    title.Position = UDim2.new(0, 0, 0, 5)
    title.Text = "🧠 DUPLICADOR BRAINROT"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.Parent = frame
    
    -- Subtítulo
    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(1, 0, 0, 20)
    subtitle.Position = UDim2.new(0, 0, 0, 45)
    subtitle.Text = "Duplica el Brainrot que tengas AGARRADO"
    subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
    subtitle.BackgroundTransparency = 1
    subtitle.Font = Enum.Font.Gotham
    subtitle.TextSize = 11
    subtitle.Parent = frame
    
    -- Botón DUPLICAR
    local dupeBtn = Instance.new("TextButton")
    dupeBtn.Size = UDim2.new(0, 200, 0, 50)
    dupeBtn.Position = UDim2.new(0.5, -100, 0.35, 0)
    dupeBtn.Text = "🔄 DUPLICAR BRAINROT EQUIPADO"
    dupeBtn.BackgroundColor3 = Color3.fromRGB(100, 50, 200)
    dupeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    dupeBtn.Font = Enum.Font.GothamBold
    dupeBtn.TextSize = 14
    dupeBtn.BorderSizePixel = 0
    dupeBtn.Parent = frame
    
    -- Botón VER BRAINROTS
    local listBtn = Instance.new("TextButton")
    listBtn.Size = UDim2.new(0, 150, 0, 30)
    listBtn.Position = UDim2.new(0.5, -75, 0.65, 0)
    listBtn.Text = "📋 Ver mis Brainrots"
    listBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
    listBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    listBtn.Font = Enum.Font.Gotham
    listBtn.TextSize = 12
    listBtn.BorderSizePixel = 0
    listBtn.Parent = frame
    
    -- Estado
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1, 0, 0, 25)
    status.Position = UDim2.new(0, 0, 0.8, 0)
    status.Text = "🟢 Listo - Agarrá un Brainrot"
    status.TextColor3 = Color3.fromRGB(100, 255, 100)
    status.BackgroundTransparency = 1
    status.Font = Enum.Font.Gotham
    status.TextSize = 12
    status.Parent = frame
    
    -- Botón DUPLICAR - Evento
    dupeBtn.MouseButton1Click:Connect(function()
        -- Desactivar botón temporalmente
        dupeBtn.Text = "⏳ DUPLICANDO..."
        dupeBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
        status.Text = "⏳ Duplicando..."
        status.TextColor3 = Color3.fromRGB(255, 200, 0)
        
        -- Verificar que haya un Brainrot equipado
        local check = obtenerBrainrotEquipado()
        if not check then
            status.Text = "❌ Agarrá un Brainrot primero!"
            status.TextColor3 = Color3.fromRGB(255, 50, 50)
            dupeBtn.Text = "🔄 DUPLICAR BRAINROT EQUIPADO"
            dupeBtn.BackgroundColor3 = Color3.fromRGB(100, 50, 200)
            task.wait(2)
            status.Text = "🟢 Listo - Agarrá un Brainrot"
            status.TextColor3 = Color3.fromRGB(100, 255, 100)
            return
        end
        
        -- Ejecutar duplicación
        duplicarInteligente()
        
        -- Restaurar botón
        dupeBtn.Text = "✅ DUPLICADO!"
        dupeBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        status.Text = "✅ Brainrot duplicado!"
        status.TextColor3 = Color3.fromRGB(100, 255, 100)
        
        task.wait(2)
        dupeBtn.Text = "🔄 DUPLICAR BRAINROT EQUIPADO"
        dupeBtn.BackgroundColor3 = Color3.fromRGB(100, 50, 200)
        status.Text = "🟢 Listo - Agarrá un Brainrot"
        status.TextColor3 = Color3.fromRGB(100, 255, 100)
    end)
    
    -- Botón VER BRAINROTS - Evento
    listBtn.MouseButton1Click:Connect(function()
        mostrarBrainrotsDisponibles()
        status.Text = "📋 Revisá la consola (F9)"
        status.TextColor3 = Color3.fromRGB(255, 200, 0)
        task.wait(2)
        status.Text = "🟢 Listo - Agarrá un Brainrot"
        status.TextColor3 = Color3.fromRGB(100, 255, 100)
    end)
end

-- ========== INICIALIZAR ==========

print("🧠 Cargando Duplicador Brainrot v2...")
print("📋 INSTRUCCIONES:")
print("1. Abrí tu inventario y AGARRÁ un Brainrot")
print("2. Presioná 'DUPLICAR BRAINROT EQUIPADO'")
print("3. Se duplicará EXACTAMENTE el que tengas en la mano")

-- Esperar a que el personaje cargue
if not character then
    player.CharacterAdded:Wait()
    character = player.Character
end

-- Crear GUI
crearGUI()

print("✅ Script listo!")
print("💡 Recordá: Tenés que tener el Brainrot AGARRADO (en la mano)")
