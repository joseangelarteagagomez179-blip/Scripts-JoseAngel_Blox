--// SCRIPT: Brainrots Duplication
--// Creador: JoseAngel_Blox
--// Fecha: 22/06/2026
--// Para: Delta Executor

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")

--// CREACIÓN DE LA UI CON ESTILO CUADRADO Y ESQUINAS REDONDEADAS
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local Tab1 = Instance.new("TextButton")
local Tab2 = Instance.new("TextButton")
local Container = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local Reflection = Instance.new("ImageLabel")

--// Propiedades de la Ventana
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BackgroundTransparency = 0.3 -- Fondo transparente
MainFrame.Position = UDim2.new(0.03, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 320, 0, 420)
MainFrame.Active = true
MainFrame.Draggable = true -- Para mover la ventana

--// Esquinas Redondeadas
UICorner.CornerRadius = UDim.new(0, 14)
UICorner.Parent = MainFrame

--// Efecto de Reflejo
Reflection.Name = "Reflection"
Reflection.Parent = MainFrame
Reflection.BackgroundTransparency = 1
Reflection.Position = UDim2.new(0, 0, 0, -50)
Reflection.Size = UDim2.new(1, 0, 0, 150)
Reflection.Image = "rbxassetid://13635549346" -- Efecto de brillo
Reflection.ImageColor3 = Color3.fromRGB(255, 255, 255)
Reflection.ImageTransparency = 0.6
Reflection.ZIndex = 0

--// Título
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "Brainrots Duplication"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18

--// Tabs
Tab1.Name = "Tab_Info"
Tab1.Parent = MainFrame
Tab1.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Tab1.Position = UDim2.new(0.02, 0, 0.12, 0)
Tab1.Size = UDim2.new(0, 150, 0, 30)
Tab1.Font = Enum.Font.Gotham
Tab1.Text = "ℹ️ Info"
Tab1.TextColor3 = Color3.fromRGB(255,255,255)
Tab1.TextSize = 14

Tab2.Name = "Tab_Dupe"
Tab2.Parent = MainFrame
Tab2.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Tab2.Position = UDim2.new(0.53, 0, 0.12, 0)
Tab2.Size = UDim2.new(0, 150, 0, 30)
Tab2.Font = Enum.Font.Gotham
Tab2.Text = "🧬 Duplicar"
Tab2.TextColor3 = Color3.fromRGB(255,255,255)
Tab2.TextSize = 14

--// Contenedor de contenido
Container.Name = "Container"
Container.Parent = MainFrame
Container.BackgroundTransparency = 1
Container.Position = UDim2.new(0.02, 0, 0.22, 0)
Container.Size = UDim2.new(0.96, 0, 0.75, 0)

UIListLayout.Parent = Container
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

--// FUNCIONES

-- Limpiar contenido
local function ClearContainer()
    for _, v in pairs(Container:GetChildren()) do
        if v:IsA("GuiObject") then
            v:Destroy()
        end
    end
end

-- Pestaña INFO
local function ShowInfo()
    ClearContainer()
    Tab1.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Tab2.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    
    local InfoLabel = Instance.new("TextLabel")
    InfoLabel.Parent = Container
    InfoLabel.BackgroundTransparency = 1
    InfoLabel.Size = UDim2.new(1, 0, 0, 100)
    InfoLabel.Font = Enum.Font.Gotham
    InfoLabel.Text = "👨‍💻 Creador: JoseAngel_Blox\n\n📅 Fecha: 22/06/2026"
    InfoLabel.TextColor3 = Color3.fromRGB(255,255,255)
    InfoLabel.TextSize = 16
    InfoLabel.TextWrapped = true
end

-- Pestaña DUPLICAR
local function LoadBrainrots()
    ClearContainer()
    Tab1.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Tab2.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

    -- Botón Actualizar
    local BtnRefresh = Instance.new("TextButton")
    BtnRefresh.Parent = Container
    BtnRefresh.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    BtnRefresh.Size = UDim2.new(1, 0, 0, 35)
    BtnRefresh.Font = Enum.Font.GothamBold
    BtnRefresh.Text = "🔄 Actualizar Inventario"
    BtnRefresh.TextColor3 = Color3.fromRGB(255,255,255)
    BtnRefresh.TextSize = 14
    local cornerBtn = Instance.new("UICorner", BtnRefresh)
    cornerBtn.CornerRadius = UDim.new(0,8)

    -- Función de Duplicar
    local function DupeBrainrot(Name, Mut)
        local Data = {
            Id = Name,
            Rarity = "Rare",
            Mutation = Mut
        }
        -- Disparar evento para crear copias
        for i=1, 5 do
            RS.Events.ReceiveBrainrot:FireServer(Data)
            task.wait(0.1)
        end
    end

    -- Cargar lista
    BtnRefresh.MouseButton1Click:Connect(function()
        -- Limpiar botones viejos menos el actualizar
        for _, v in pairs(Container:GetChildren()) do
            if v ~= BtnRefresh then v:Destroy() end
        end

        -- 🔧 BUSQUEDA MEJORADA DE DATOS
        local BrainrotsFolder = nil
        
        -- Buscar en todas las carpetas posibles
        if LocalPlayer:FindFirstChild("Data") then
            BrainrotsFolder = LocalPlayer.Data:FindFirstChild("Brainrots")
        elseif LocalPlayer:FindFirstChild("leaderstats") then
            BrainrotsFolder = LocalPlayer.leaderstats:FindFirstChild("Brainrots")
        else
            -- Si no encuentra, buscar en todo el jugador
            for _, child in pairs(LocalPlayer:GetChildren()) do
                if child.Name:lower():find("brain") then
                    BrainrotsFolder = child
                    break
                end
            end
        end

        if not BrainrotsFolder then
            local Warn = Instance.new("TextLabel")
            Warn.Parent = Container
            Warn.BackgroundTransparency = 1
            Warn.Size = UDim2.new(1, 0, 0, 30)
            Warn.Text = "⚠️ No se encontraron Brainrots"
            Warn.TextColor3 = Color3.fromRGB(255,100,100)
            Warn.Font = Enum.Font.Gotham
            return
        end

        -- Recorrer los brainrots encontrados
        for _, BrainrotValue in pairs(BrainrotsFolder:GetChildren()) do
            local BrainrotName = BrainrotValue.Name
            local Mutation = "Normal"
            
            -- Buscar valor de mutación
            if BrainrotValue:FindFirstChild("Mutation") then
                Mutation = BrainrotValue.Mutation.Value
                if Mutation == "" then Mutation = "Normal" end
            elseif BrainrotValue:FindFirstChild("Mut") then
                Mutation = BrainrotValue.Mut.Value
                if Mutation == "" then Mutation = "Normal" end
            end

            -- Formatear texto
            local DisplayText = BrainrotName
            if Mutation ~= "Normal" then
                DisplayText = DisplayText .. " | " .. Mutation
            else
                DisplayText = DisplayText .. " | Normal"
            end

            -- Crear Botón de Brainrot
            local BtnBrainrot = Instance.new("TextButton")
            BtnBrainrot.Parent = Container
            BtnBrainrot.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            BtnBrainrot.Size = UDim2.new(1, 0, 0, 40)
            BtnBrainrot.Font = Enum.Font.Gotham
            BtnBrainrot.Text = DisplayText
            BtnBrainrot.TextColor3 = Color3.fromRGB(255,255,255)
            BtnBrainrot.TextSize = 13
            BtnBrainrot.TextWrapped = true
            
            local corner = Instance.new("UICorner", BtnBrainrot)
            corner.CornerRadius = UDim.new(0,8)

            -- Acción al dar click
            BtnBrainrot.MouseButton1Click:Connect(function()
                DupeBrainrot(BrainrotName, Mutation)
            end)
        end
    end)
end

--// Eventos de los Tabs
Tab1.MouseButton1Click:Connect(ShowInfo)
Tab2.MouseButton1Click:Connect(LoadBrainrots)

--// Cargar vista inicial
ShowInfo()

print("✅ Script Brainrots Duplication cargado correctamente")
