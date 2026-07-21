-- =============================================
-- 🧠 Nombre: Brainrots Duplications
-- 👤 Creador: JoseAngel_Blox
-- 📅 Fecha: 20/07/2026
-- 🔖 Versión: 1.1
-- 📱 Compatible: Móvil ✅ | PC ✅
-- 🎮 Juego: Kick a Lucky Block
-- =============================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

-- ✅ INTERFAZ CUADRADA CON ESQUINAS REDONDEADAS
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BrainrotsDuplications"
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
if gethui then ScreenGui.Parent = gethui() end

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
MainFrame.Position = UDim2.new(0.02, 0, 0.02, 0)
MainFrame.Size = UDim2.new(0, 300, 0, 480) -- Formato cuadrado/rectangular
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 18) -- Esquinas redondeadas

-- SECCIÓN INFO
local InfoLabel = Instance.new("TextLabel")
InfoLabel.Parent = MainFrame
InfoLabel.BackgroundTransparency = 1
InfoLabel.Position = UDim2.new(0, 15, 0, 12)
InfoLabel.Size = UDim2.new(1, -30, 0, 70)
InfoLabel.Font = Enum.Font.GothamSemibold
InfoLabel.Text = "🧠 Brainrots Duplications\n👤 Creador: JoseAngel_Blox\n📅 Lanzamiento: 20/07/2026\n🔖 Versión: 1.1"
InfoLabel.TextColor3 = Color3.fromRGB(255, 215, 60)
InfoLabel.TextScaled = true
InfoLabel.TextWrapped = true

-- SECCIÓN MAIN
local MainTitle = Instance.new("TextLabel")
MainTitle.Parent = MainFrame
MainTitle.BackgroundTransparency = 1
MainTitle.Position = UDim2.new(0, 15, 0, 90)
MainTitle.Size = UDim2.new(1, -30, 0, 28)
MainTitle.Font = Enum.Font.GothamBold
MainTitle.Text = "⚙️ MAIN"
MainTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
MainTitle.TextScaled = true

local BtnActivar = Instance.new("TextButton")
BtnActivar.Parent = MainFrame
BtnActivar.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
BtnActivar.Position = UDim2.new(0, 15, 0, 122)
BtnActivar.Size = UDim2.new(1, -30, 0, 42)
BtnActivar.Font = Enum.Font.GothamSemibold
BtnActivar.Text = "🔘 Duplicar: DESACTIVADO"
BtnActivar.TextColor3 = Color3.fromRGB(230, 230, 230)
BtnActivar.TextScaled = true
Instance.new("UICorner", BtnActivar).CornerRadius = UDim.new(0, 12)

-- SECCIÓN LISTA
local ListTitle = Instance.new("TextLabel")
ListTitle.Parent = MainFrame
ListTitle.BackgroundTransparency = 1
ListTitle.Position = UDim2.new(0, 15, 0, 175)
ListTitle.Size = UDim2.new(1, -30, 0, 28)
ListTitle.Font = Enum.Font.GothamBold
ListTitle.Text = "📋 LISTA DE BRAINROTS"
ListTitle.TextColor3 = Color3.fromRGB(220, 220, 220)
ListTitle.TextScaled = true

local ListaContainer = Instance.new("Frame")
ListaContainer.Parent = MainFrame
ListaContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
ListaContainer.Position = UDim2.new(0, 15, 0, 210)
ListaContainer.Size = UDim2.new(1, -30, 0, 200)
Instance.new("UICorner", ListaContainer).CornerRadius = UDim.new(0, 12)

local ScrollLista = Instance.new("ScrollingFrame")
ScrollLista.Parent = ListaContainer
ScrollLista.BackgroundTransparency = 1
ScrollLista.Size = UDim2.new(1, -10, 1, -10)
ScrollLista.Position = UDim2.new(0, 5, 0, 5)
ScrollLista.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollLista.ScrollBarThickness = 6

local BtnDuplicarSeleccion = Instance.new("TextButton")
BtnDuplicarSeleccion.Parent = MainFrame
BtnDuplicarSeleccion.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
BtnDuplicarSeleccion.Position = UDim2.new(0, 15, 0, 425)
BtnDuplicarSeleccion.Size = UDim2.new(1, -30, 0, 40)
BtnDuplicarSeleccion.Font = Enum.Font.GothamSemibold
BtnDuplicarSeleccion.Text = "🔘 Duplicar Seleccionado"
BtnDuplicarSeleccion.TextColor3 = Color3.fromRGB(230, 230, 230)
BtnDuplicarSeleccion.TextScaled = true
Instance.new("UICorner", BtnDuplicarSeleccion).CornerRadius = UDim.new(0, 12)

-- Animación de entrada
TweenService:Create(MainFrame, TweenInfo.new(0.4), {Transparency = 0}):Play()

-- ⚙️ VARIABLES
local DuplicarActivo = false
local BrainrotSeleccionado = nil
local Remotes = ReplicatedStorage:FindFirstChild("Remotes") or ReplicatedStorage
local ListaObjetos = {}

-- 📋 CARGAR LISTA DE BRAINROTS DEL INVENTARIO
local function CargarLista()
    -- Limpiar lista anterior
    for _, v in pairs(ScrollLista:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    ListaObjetos = {}
    BrainrotSeleccionado = nil
    BtnDuplicarSeleccion.Text = "🔘 Duplicar Seleccionado"

    local Inventario = Player:FindFirstChild("Data") or Player:FindFirstChild("Inventory") or Player:FindFirstChild("leaderstats")
    if not Inventario then return end

    local PosY = 5
    for _, Item in pairs(Inventario:GetChildren()) do
        if (Item:IsA("IntValue") or Item:IsA("NumberValue")) 
        and not Item.Name:find("Money") and not Item.Name:find("Rebirth") then
            table.insert(ListaObjetos, Item.Name)
            
            local BtnItem = Instance.new("TextButton")
            BtnItem.Parent = ScrollLista
            BtnItem.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
            BtnItem.Position = UDim2.new(0, 8, 0, PosY)
            BtnItem.Size = UDim2.new(1, -16, 0, 32)
            BtnItem.Font = Enum.Font.Gotham
            BtnItem.Text = "• "..Item.Name
            BtnItem.TextColor3 = Color3.fromRGB(200, 200, 200)
            BtnItem.TextScaled = true
            BtnItem.AutoLocalize = false
            Instance.new("UICorner", BtnItem).CornerRadius = UDim.new(0, 8)

            -- Seleccionar brainrot
            BtnItem.MouseButton1Click:Connect(function()
                for _, b in pairs(ScrollLista:GetChildren()) do if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(40,40,48) end end
                BtnItem.BackgroundColor3 = Color3.fromRGB(35, 140, 70)
                BrainrotSeleccionado = Item.Name
                BtnDuplicarSeleccion.Text = "✅ Duplicar: "..BrainrotSeleccionado
            end)

            PosY += 38
        end
    end
    ScrollLista.CanvasSize = UDim2.new(0, 0, 0, PosY + 10)
end

-- 🚀 FUNCIÓN DUPLICAR COPIAS REALES
local function DuplicarBrainrot(Nombre)
    if not Nombre then return end
    local Char = Player.Character
    if not Char or not Char.PrimaryPart then return end

    -- 1️⃣ Aumentar cantidad en inventario (valor real)
    local Inventario = Player:FindFirstChild("Data") or Player:FindFirstChild("Inventory")
    if Inventario and Inventario:FindFirstChild(Nombre) then
        Inventario[Nombre].Value += 1
        if Remotes and Remotes:FindFirstChild("Duplicate") then
            Remotes.Duplicate:FireServer(Nombre, 1)
        end
    end

    -- 2️⃣ CREAR COPIA FÍSICA REAL PARA COLOCAR EN BASE
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Model") and v.Name == Nombre or v.Name:find(Nombre) then
            local CopiaReal = v:Clone()
            CopiaReal.Parent = workspace
            CopiaReal:PivotTo(Char.PrimaryPart.CFrame * CFrame.new(math.random(-6,6), 2, math.random(-6,6)))
            CopiaReal:SetAttribute("EsDuplicado", true)
            break
        end
    end
end

-- 🎮 BOTONES
BtnActivar.MouseButton1Click:Connect(function()
    DuplicarActivo = not DuplicarActivo
    BtnActivar.BackgroundColor3 = DuplicarActivo and Color3.fromRGB(32, 160, 85) or Color3.fromRGB(45, 45, 52)
    BtnActivar.Text = DuplicarActivo and "✅ Duplicar: ACTIVADO" or "🔘 Duplicar: DESACTIVADO"
    CargarLista()
end)

BtnDuplicarSeleccion.MouseButton1Click:Connect(function()
    if not BrainrotSeleccionado then return end
    DuplicarBrainrot(BrainrotSeleccionado)
end)

-- Recargar lista al reaparecer
Player.CharacterAdded:Connect(CargarLista)
task.wait(1)
CargarLista()
