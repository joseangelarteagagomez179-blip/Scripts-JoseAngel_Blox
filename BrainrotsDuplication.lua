-- // Brainrots Duplications //
-- Creado por: JoseAngel_Blox
-- Fecha: 22/06/2026

-- SERVICIOS
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

-- ==============================================
-- 🖼️ CREAR VENTANA PRINCIPAL
-- ==============================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "BrainrotsDuplicator"
Gui.Parent = game:GetService("CoreGui")

local Main = Instance.new("Frame")
Main.Name = "MainFrame"
Main.Size = UDim2.new(0, 350, 0, 450) -- Tamaño cuadrado
Main.Position = UDim2.new(0.5, -175, 0.5, -225)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.Active = true
Main.Draggable = true -- SE PUEDE MOVER
Main.Parent = Gui

-- ESQUINAS REDONDEADAS
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0,15)
Corner.Parent = Main

-- IMAGEN DE FONDO
local Background = Instance.new("ImageLabel")
Background.Size = UDim2.new(1,0,1,0)
Background.Position = UDim2.new(0,0,0,0)
Background.Image = "rbxassetid://120999595778887"
Background.BackgroundTransparency = 1
Background.ScaleType = Enum.ScaleType.Stretch
Background.ZIndex = 0
Background.Parent = Main

-- TEXTO TITULO
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "Brainrots Duplications"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = Main

-- TEXTO INFO
local InfoText = Instance.new("TextLabel")
InfoText.Size = UDim2.new(1, -20, 0, 60)
InfoText.Position = UDim2.new(0, 10, 0, 40)
InfoText.BackgroundTransparency = 1
InfoText.Text = "Creador: JoseAngel_Blox\nFecha: 22/06/2026"
InfoText.TextColor3 = Color3.new(0.8, 0.8, 0.8)
InfoText.Font = Enum.Font.Gotham
InfoText.TextSize = 14
InfoText.Parent = Main

-- ==============================================
-- 🔘 BOTONES Y FUNCIONES
-- ==============================================

-- Variable para guardar el brainrot elegido
_G.SelectedBrainrot = nil

-- LISTA DONDE SALEN LOS BOTONES
local List = Instance.new("ScrollingFrame")
List.Size = UDim2.new(1, -20, 0, 220)
List.Position = UDim2.new(0, 10, 0, 110)
List.BackgroundTransparency = 1
List.BorderSizePixel = 0
List.ScrollBarThickness = 4
List.Parent = Main

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0,5)
Layout.Parent = List

-- FUNCIÓN REFRESCAR
local function RefreshList()
    List:ClearAllChildren()
    _G.SelectedBrainrot = nil
    
    local found = {}
    for _,v in pairs(Workspace:GetChildren()) do
        if v.Name:find("Brainrot") or v:FindFirstChild("Humanoid") then
            table.insert(found, v)
        end
    end
    
    if #found == 0 then
        local txt = Instance.new("TextLabel")
        txt.Size = UDim2.new(1, 0, 0, 30)
        txt.BackgroundTransparency = 1
        txt.Text = "❌ No se encontraron Brainrots"
        txt.TextColor3 = Color3.new(1,0,0)
        txt.Parent = List
    else
        for _,v in pairs(found) do
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 35)
            btn.BackgroundColor3 = Color3.fromRGB(45,45,45)
            btn.Text = "✅ "..v.Name
            btn.TextColor3 = Color3.new(1,1,1)
            btn.Font = Enum.Font.Gotham
            btn.Parent = List
            
            local c = Instance.new("UICorner")
            c.CornerRadius = UDim.new(0,6)
            c.Parent = btn
            
            btn.MouseButton1Click:Connect(function()
                _G.SelectedBrainrot = v
                btn.Text = "👉 "..v.Name
                print("Seleccionado: "..v.Name)
            end)
        end
    end
end

-- BOTON REFRESCAR
local BtnRefresh = Instance.new("TextButton")
BtnRefresh.Size = UDim2.new(1, -20, 0, 35)
BtnRefresh.Position = UDim2.new(0, 10, 0, 340)
BtnRefresh.BackgroundColor3 = Color3.fromRGB(60, 120, 200)
BtnRefresh.Text = "🔄 Refrescar Lista"
BtnRefresh.TextColor3 = Color3.new(1,1,1)
BtnRefresh.Parent = Main
local c1 = Instance.new("UICorner")
c1.CornerRadius = UDim.new(0,8)
c1.Parent = BtnRefresh

BtnRefresh.MouseButton1Click:Connect(RefreshList)

-- BOTON DUPLICAR
local BtnDupe = Instance.new("TextButton")
BtnDupe.Size = UDim2.new(1, -20, 0, 40)
BtnDupe.Position = UDim2.new(0, 10, 0, 385)
BtnDupe.BackgroundColor3 = Color3.fromRGB(80, 180, 80)
BtnDupe.Text = "🚀 INICIAR DUPLICADO"
BtnDupe.TextColor3 = Color3.new(1,1,1)
BtnDupe.Font = Enum.Font.GothamBold
BtnDupe.TextSize = 16
BtnDupe.Parent = Main
local c2 = Instance.new("UICorner")
c2.CornerRadius = UDim.new(0,10)
c2.Parent = BtnDupe

-- ESTADO DEL SCRIPT
local Running = false

BtnDupe.MouseButton1Click:Connect(function()
    Running = not Running
    if Running then
        BtnDupe.Text = "⏹️ DETENER"
        BtnDupe.BackgroundColor3 = Color3.fromRGB(180, 80, 80)
        spawn(function()
            while Running do
                if _G.SelectedBrainrot and _G.SelectedBrainrot.Parent then
                    local clone = _G.SelectedBrainrot:Clone()
                    clone.Parent = Workspace
                    clone.Position = _G.SelectedBrainrot.Position + Vector3.new(math.random(-2,2), 0.5, math.random(-2,2))
                    if clone:FindFirstChild("Owner") then
                        clone.Owner.Value = Player.Name
                    end
                end
                task.wait(0.2)
            end
        end)
    else
        BtnDupe.Text = "🚀 INICIAR DUPLICADO"
        BtnDupe.BackgroundColor3 = Color3.fromRGB(80, 180, 80)
    end
end)

-- MENSAJE INICIO
print("====================================")
print("       Brainrots Duplications       ")
print("   Creado por: JoseAngel_Blox       ")
print("   Fecha: 22/06/2026               ")
print("====================================")

-- Cargar lista al abrir
spawn(function()
    wait(0.5)
    RefreshList()
end)
