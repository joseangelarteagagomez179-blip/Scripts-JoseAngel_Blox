-- Mansion Tycoon v1.1
-- Creador: JoseAngel_Blox
-- Fecha: 01/07/2026

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- 1. LIMPIAR SI YA EXISTE
for _, child in pairs(playerGui:GetChildren()) do
    if child.Name == "Load_JA" or child.Name == "Gui_JA" then child:Destroy() end
end

-- 2. PANTALLA DE CARGA (SOLO LETRAS, SIN CUADRO NEGRO)
local LoadGui = Instance.new("ScreenGui", playerGui)
LoadGui.Name = "Load_JA"

local Container = Instance.new("Frame", LoadGui)
Container.Size = UDim2.new(1, 0, 1, 0)
Container.BackgroundTransparency = 1 -- Fondo transparente

local Welcome = Instance.new("TextLabel", Container)
Welcome.Text = ""
Welcome.Size = UDim2.new(1, 0, 0, 50)
Welcome.Position = UDim2.new(0, 0, 0.4, 0)
Welcome.BackgroundTransparency = 1
Welcome.TextColor3 = Color3.fromRGB(255, 255, 255)
Welcome.Font = Enum.Font.GothamBold
Welcome.TextScaled = true
Welcome.TextStrokeTransparency = 0

local Name = Instance.new("TextLabel", Container)
Name.Text = ""
Name.Size = UDim2.new(1, 0, 0, 70)
Name.Position = UDim2.new(0, 0, 0.5, 0)
Name.BackgroundTransparency = 1
Name.TextColor3 = Color3.fromRGB(180, 100, 255)
Name.Font = Enum.Font.GothamBold
Name.TextScaled = true
Name.TextStrokeTransparency = 0

-- 3. GUI DEL SCRIPT (OCULTA HASTA QUE TERMINE EL TEXTO)
local MainGui = Instance.new("ScreenGui", playerGui)
MainGui.Name = "Gui_JA"

local MainFrame = Instance.new("Frame", MainGui)
MainFrame.Size = UDim2.new(0, 350, 0, 300)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "🏰 Mansion Tycoon v1.1"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Instance.new("UICorner", Title)

-- Botón Auto Build
local BuildBtn = Instance.new("TextButton", MainFrame)
BuildBtn.Text = "🏗️ Auto Build: OFF"
BuildBtn.Size = UDim2.new(0.9, 0, 0, 50)
BuildBtn.Position = UDim2.new(0.05, 0, 0.3, 0)
BuildBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
BuildBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
BuildBtn.Font = Enum.Font.GothamBold
BuildBtn.TextSize = 20
Instance.new("UICorner", BuildBtn)

-- Botón Auto Collect
local CollectBtn = Instance.new("TextButton", MainFrame)
CollectBtn.Text = "💰 Auto Collect: OFF"
CollectBtn.Size = UDim2.new(0.9, 0, 0, 50)
CollectBtn.Position = UDim2.new(0.05, 0, 0.6, 0)
CollectBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
CollectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CollectBtn.Font = Enum.Font.GothamBold
CollectBtn.TextSize = 20
Instance.new("UICorner", CollectBtn)

-- LÓGICA DE BOTONES
local autoBuild = false
local autoCollect = false
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")

BuildBtn.MouseButton1Click:Connect(function()
    autoBuild = not autoBuild
    BuildBtn.Text = autoBuild and "🏗️ Auto Build: ON" or "🏗️ Auto Build: OFF"
    BuildBtn.BackgroundColor3 = autoBuild and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(50, 50, 70)
    task.spawn(function()
        while autoBuild do
            for _, v in pairs(workspace:GetDescendants()) do
                if not autoBuild then break end
                if v.Name == "Touch" and v:IsA("BasePart") then
                    if not v.Parent.Name:find("VIP") and not v.Parent.Name:find("Robux") then
                        firetouchinterest(root, v, 0)
                        firetouchinterest(root, v, 1)
                    end
                end
            end
            task.wait(0.5)
        end
    end)
end)

CollectBtn.MouseButton1Click:Connect(function()
    autoCollect = not autoCollect
    CollectBtn.Text = autoCollect and "💰 Auto Collect: ON" or "💰 Auto Collect: OFF"
    CollectBtn.BackgroundColor3 = autoCollect and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(50, 50, 70)
    task.spawn(function()
        while autoCollect do
            pcall(function()
                local collector = workspace.Tycoons:FindFirstChild("Plot1").Tycoon2.Mansion.Collectors.Collector.Touch
                firetouchinterest(root, collector, 0)
                firetouchinterest(root, collector, 1)
            end)
            task.wait(0.5)
        end
    end)
end)

-- 4. ANIMACIÓN DE LETRAS
task.spawn(function()
    local t1 = "✨ Bienvenidos a"
    for i = 1, #t1 do Welcome.Text = t1:sub(1, i) task.wait(0.05) end
    task.wait(0.2)
    local t2 = "Scripts JoseAngel_Blox"
    for i = 1, #t2 do Name.Text = t2:sub(1, i) task.wait(0.06) end
    
    task.wait(1.5) -- Pausa para ver el nombre
    
    LoadGui:Destroy() -- Quita las letras
    MainFrame.Visible = true -- Muestra el script
end)
