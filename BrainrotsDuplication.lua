--// SERVICES
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui
local UIS = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

--// VARIABLES
local GuiName = "DuplicarBrainrotsPro"
local SelectedItem = nil
local SelectedName = nil
local SelectedMutation = nil
local SelectedColor = nil

--// ELIMINAR GUI ANTERIOR
if PlayerGui:FindFirstChild(GuiName) then PlayerGui[GuiName]:Destroy() end

--// CREAR SCREENGUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = GuiName
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

--// MAIN FRAME
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderColor3 = Color3.fromRGB(0, 170, 255)
MainFrame.BorderSizePixel = 2
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 340, 0, 420)
MainFrame.ClipsDescendants = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

--// TITULO
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "⭐ DUPLICAR BRAINROTS PRO ⭐"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16

--// SUBTITULO
local VIPText = Instance.new("TextLabel")
VIPText.Name = "VIPText"
VIPText.Parent = MainFrame
VIPText.BackgroundTransparency = 1
VIPText.Position = UDim2.new(0, 0, 0, 40)
VIPText.Size = UDim2.new(1, 0, 0, 20)
VIPText.Font = Enum.Font.Gotham
VIPText.Text = "💎 SOLO BRAINROTS - MUTACIONES REALES 💎"
VIPText.TextColor3 = Color3.fromRGB(255, 215, 0)
VIPText.TextSize = 11

--// 📦 CUADRO DESTINO
local DropBox = Instance.new("Frame")
DropBox.Name = "DropBox"
DropBox.Parent = MainFrame
DropBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
DropBox.BorderColor3 = Color3.fromRGB(255, 255, 255)
DropBox.BorderSizePixel = 2
DropBox.Position = UDim2.new(0.15, 0, 0.20, 0)
DropBox.Size = UDim2.new(0, 70, 0, 70)

local DropCorner = Instance.new("UICorner")
DropCorner.CornerRadius = UDim.new(0, 8)
DropCorner.Parent = DropBox

local DropText = Instance.new("TextLabel")
DropText.Name = "DropText"
DropText.Parent = DropBox
DropText.BackgroundTransparency = 1
DropText.Size = UDim2.new(1, -10, 0.6, 0)
DropText.Font = Enum.Font.GothamBold
DropText.Text = "📥"
DropText.TextColor3 = Color3.fromRGB(200, 200, 200)
DropText.TextSize = 18

local DropSubText = Instance.new("TextLabel")
DropSubText.Name = "DropSubText"
DropSubText.Parent = DropBox
DropSubText.BackgroundTransparency = 1
DropSubText.Size = UDim2.new(1, -10, 0.4, -5)
DropSubText.Position = UDim2.new(0, 0, 0.6, 5)
DropSubText.Font = Enum.Font.GothamBold
DropSubText.Text = ""
DropSubText.TextColor3 = Color3.fromRGB(0, 255, 0)
DropSubText.TextSize = 10

--// TEXTO INVENTARIO
local InvText = Instance.new("TextLabel")
InvText.Name = "InvText"
InvText.Parent = MainFrame
InvText.BackgroundTransparency = 1
InvText.Position = UDim2.new(0.05, 0, 0.45, 0)
InvText.Size = UDim2.new(0.9, 0, 0, 20)
InvText.Font = Enum.Font.Gotham
InvText.Text = "📜 TUS BRAINROTS:"
InvText.TextColor3 = Color3.fromRGB(255, 255, 255)
InvText.TextSize = 13

--// 📜 LISTA DESLIZABLE
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Name = "ScrollingFrame"
ScrollingFrame.Parent = MainFrame
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 170, 255)
ScrollingFrame.Position = UDim2.new(0.05, 0, 0.52, 0)
ScrollingFrame.Size = UDim2.new(0.9, 0, 110, 0)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.ScrollBarThickness = 6

local ScrollCorner = Instance.new("UICorner")
ScrollCorner.CornerRadius = UDim.new(0, 8)
ScrollCorner.Parent = ScrollingFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ScrollingFrame
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)

--// BOTON DUPLICAR
local DuplicateBtn = Instance.new("TextButton")
DuplicateBtn.Name = "DuplicateBtn"
DuplicateBtn.Parent = MainFrame
DuplicateBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
DuplicateBtn.Position = UDim2.new(0.15, 0, 0.85, 0)
DuplicateBtn.Size = UDim2.new(0.7, 0, 0, 45)
DuplicateBtn.Font = Enum.Font.GothamBold
DuplicateBtn.Text = "🚀 DUPLICAR Y COLOCAR"
DuplicateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DuplicateBtn.TextSize = 14

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 10)
BtnCorner.Parent = DuplicateBtn

--// 💥 DETECTAR MUTACIÓN REAL 💥
local function DetectarMutacion(nombreObjeto)
    local nombre = string.lower(nombreObjeto)
    local mutacion = "Normal"
    local color = Color3.fromRGB(255,255,255)

    if string.find(nombre, "oro") or string.find(nombre, "gold") then
        mutacion = "Oro"
        color = Color3.fromRGB(255, 215, 0)
    elseif string.find(nombre, "diamante") or string.find(nombre, "diamond") then
        mutacion = "Diamante"
        color = Color3.fromRGB(0, 191, 255)
    elseif string.find(nombre, "fantasma") or string.find(nombre, "ghost") then
        mutacion = "Fantasma"
        color = Color3.fromRGB(200, 200, 255)
    elseif string.find(nombre, "celestial") then
        mutacion = "Celestial"
        color = Color3.fromRGB(255, 20, 147)
    elseif string.find(nombre, "fresa") or string.find(nombre, "strawberry") then
        mutacion = "Fresa"
        color = Color3.fromRGB(255, 105, 180)
    end

    return mutacion, color
end

--// 💥 CREAR BOTÓN DE ITEM 💥
local function CrearBoton(nombre, objeto)
    local mutacion, color = DetectarMutacion(nombre)

    local ItemBtn = Instance.new("TextButton")
    ItemBtn.Size = UDim2.new(0, 70, 0, 70)
    ItemBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    ItemBtn.BorderColor3 = Color3.fromRGB(0, 170, 255)
    ItemBtn.BorderSizePixel = 2
    ItemBtn.Text = ""
    ItemBtn.Parent = ScrollingFrame

    local BtnCorner2 = Instance.new("UICorner")
    BtnCorner2.CornerRadius = UDim.new(0, 8)
    BtnCorner2.Parent = ItemBtn

    -- NOMBRE
    local NameText = Instance.new("TextLabel")
    NameText.Size = UDim2.new(1, -5, 0.5, 0)
    NameText.Position = UDim2.new(0, 5, 0, 0)
    NameText.BackgroundTransparency = 1
    NameText.Font = Enum.Font.GothamBold
    NameText.Text = nombre
    NameText.TextColor3 = Color3.fromRGB(255,255,255)
    NameText.TextSize = 9
    NameText.Parent = ItemBtn

    -- MUTACION
    local MutText = Instance.new("TextLabel")
    MutText.Size = UDim2.new(1, -5, 0.4, 0)
    MutText.Position = UDim2.new(0, 5, 0.6, 0)
    MutText.BackgroundTransparency = 1
    MutText.Font = Enum.Font.GothamBold
    MutText.Text = mutacion
    MutText.TextColor3 = color
    MutText.TextSize = 8
    MutText.Parent = ItemBtn

    -- EVENTO CLICK
    ItemBtn.MouseButton1Click:Connect(function()
        SelectedItem = objeto
        SelectedName = nombre
        SelectedMutation = mutacion
        SelectedColor = color

        -- MOSTRAR EN CAJA
        DropText.Text = nombre
        DropSubText.Text = mutacion
        DropSubText.TextColor3 = color
        DropText.TextColor3 = Color3.fromRGB(255,255,255)

        -- EFECTO
        ItemBtn.BorderColor3 = Color3.fromRGB(0,255,0)
        wait(0.15)
        ItemBtn.BorderColor3 = Color3.fromRGB(0,170,255)
    end)
end

--// 💥 CARGAR INVENTARIO 💥
local function CargarTodo()
    -- LIMPIAR
    for _, child in pairs(ScrollingFrame:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end

    local encontrados = {}

    -- 🔍 FILTRO: SOLO BRAINROTS
    -- Palabras que NO queremos ver
    local palabrasMalas = {"slot", "product", "money", "dinero", "weight", "effect", "camera", "humanoid", "bind", "key", "class", "tool"}

    -- Buscar en Backpack
    if Player:FindFirstChild("Backpack") then
        for _, obj in pairs(Player.Backpack:GetChildren()) do
            local nombre = string.lower(obj.Name)
            local valido = true

            -- Verificar que no sea basura
            for _, mala in pairs(palabrasMalas) do
                if string.find(nombre, mala) then
                    valido = false
                    break
                end
            end

            if valido and obj.Name ~= "" then
                encontrados[obj.Name] = obj
            end
        end
    end

    -- Buscar en Character (Equipados)
    if Player.Character then
        for _, obj in pairs(Player.Character:GetChildren()) do
            if obj:IsA("Tool") then
                local nombre = string.lower(obj.Name)
                local valido = true

                for _, mala in pairs(palabrasMalas) do
                    if string.find(nombre, mala) then
                        valido = false
                        break
                    end
                end

                if valido and obj.Name ~= "" then
                    encontrados[obj.Name] = obj
                end
            end
        end
    end

    -- Buscar en la Base (Mundo)
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name ~= "" and obj.Parent and obj.Parent.Name ~= "Debris" then
            local nombre = string.lower(obj.Name)
            local valido = true

            for _, mala in pairs(palabrasMalas) do
                if string.find(nombre, mala) then
                    valido = false
                    break
                end
            end

            if valido then
                encontrados[obj.Name] = obj
            end
        end
    end

    -- CREAR BOTONES
    for nombre, objeto in pairs(encontrados) do
        CrearBoton(nombre, objeto)
    end

    -- AJUSTAR TAMAÑO
    local cantidad = 0
    for _ in pairs(encontrados) do cantidad = cantidad + 1 end
    ScrollingFrame.CanvasSize = UDim2.new(0, (cantidad * 78), 0, 0)

    if cantidad == 0 then
        local nada = Instance.new("TextLabel")
        nada.Size = UDim2.new(0, 200, 0, 70)
        nada.BackgroundTransparency = 1
        nada.Text = "No se encontraron 😢"
        nada.TextColor3 = Color3.fromRGB(255,255,255)
        nada.Parent = ScrollingFrame
    end
end

-- CARGAR AL INICIAR
CargarTodo()

--// 💥 DUPLICAR 💥
DuplicateBtn.MouseButton1Click:Connect(function()
    if not SelectedItem then
        DropText.Text = "⚠️"
        DropSubText.Text = "SELECCIONA"
        return
    end

    DuplicateBtn.Text = "🔄..."

    local exito, error = pcall(function()
        -- 🧬 CLONAR
        local copia = SelectedItem:Clone()
        copia.Name = SelectedName

        -- 📦 PONER EN INVENTARIO PARA USAR
        copia.Parent = Player.Backpack

        -- ✅ MENSAJE
        DuplicateBtn.Text = "✅ ¡DUPLICADO!"
        wait(1)
        DuplicateBtn.Text = "🚀 DUPLICAR Y COLOCAR"

        -- 🔄 ACTUALIZAR LISTA
        CargarTodo()
    end)

    if not exito then
        warn(error)
        DuplicateBtn.Text = "❌ ERROR"
        wait(1)
        DuplicateBtn.Text = "🚀 DUPLICAR Y COLOCAR"
    end
end)

--// MOVER GUI
local arrastrando = false
local inicioPos = nil
local inicioGui = nil

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        arrastrando = true
        inicioPos = input.Position
        inicioGui = MainFrame.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if arrastrando and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - inicioPos
        MainFrame.Position = UDim2.new(inicioGui.X.Scale, inicioGui.X.Offset + delta.X, inicioGui.Y.Scale, inicioGui.Y.Offset + delta.Y)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        arrastrando = false
    end
end)

print("✅ SCRIPT LISTO AL 100%")
