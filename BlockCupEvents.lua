--// Services
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

--// Variables
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

--// GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local AutoFarmButton = Instance.new("TextButton")
local ImageLabel = Instance.new("ImageLabel")

--// Properties
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
MainFrame.BackgroundTransparency = 0.3 -- Fondo semi-transparente
MainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 280, 0, 200)
MainFrame.Active = true
MainFrame.Draggable = true -- Para moverlo

-- Esquinas redondeadas
UICorner.Parent = MainFrame
UICorner.CornerRadius = UDim.new(0, 18)

-- Imagen de fondo (Mundial)
ImageLabel.Parent = MainFrame
ImageLabel.BackgroundTransparency = 1
ImageLabel.Position = UDim2.new(0, 0, 0, 0)
ImageLabel.Size = UDim2.new(1, 0, 1, 0)
ImageLabel.Image = "rbxassetid://11934795837" -- Imagen tematica Mundial
ImageLabel.ImageTransparency = 0.7 -- Transparente
ImageLabel.ScaleType = Enum.ScaleType.Crop
ImageLabel.ZIndex = 0

-- Titulo
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(0, 280, 0, 50)
Title.Font = Enum.Font.GothamBold
Title.Text = "JoseAngel_Blox\nBlock Cup"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 20
Title.ZIndex = 2

-- Boton Auto Farm
AutoFarmButton.Name = "AutoFarmButton"
AutoFarmButton.Parent = MainFrame
AutoFarmButton.BackgroundColor3 = Color3.new(0.2, 0.6, 0.2)
AutoFarmButton.Position = UDim2.new(0.15, 0, 0.6, 0)
AutoFarmButton.Size = UDim2.new(0, 190, 0, 50)
AutoFarmButton.Font = Enum.Font.GothamBold
AutoFarmButton.Text = "Auto Farm Pelotas ⚽"
AutoFarmButton.TextColor3 = Color3.new(1, 1, 1)
AutoFarmButton.TextSize = 18
AutoFarmButton.ZIndex = 2

local UICorner2 = Instance.new("UICorner")
UICorner2.Parent = AutoFarmButton
UICorner2.CornerRadius = UDim.new(0, 12)

--// Logic
local AutoFarmEnabled = false

-- Funcion para farmear
local function FarmBalls()
    while AutoFarmEnabled do
        for _, descendant in pairs(Workspace:GetDescendants()) do
            if descendant:IsA("Part") or descendant:IsA("MeshPart") then
                -- Busca cualquier nombre que tenga "ball" o "balls"
                if string.find(descendant.Name:lower(), "ball") then
                    -- Ir hacia la pelota
                    HumanoidRootPart.CFrame = descendant.CFrame + Vector3.new(0, 2, 0)
                    task.wait(0.1)
                end
            end
        end
        task.wait(0.2)
    end
end

-- Evento del boton
AutoFarmButton.MouseButton1Click:Connect(function()
    AutoFarmEnabled = not AutoFarmEnabled
    if AutoFarmEnabled then
        AutoFarmButton.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
        AutoFarmButton.Text = "DETENER ⛔"
        task.spawn(FarmBalls)
    else
        AutoFarmButton.BackgroundColor3 = Color3.new(0.2, 0.6, 0.2)
        AutoFarmButton.Text = "Auto Farm Pelotas ⚽"
    end
end)

--// Animacion de entrada
MainFrame.Size = UDim2.new(0, 0, 0, 0)
local Tween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 280, 0, 200)})
Tween:Play()

print("Script JoseAngel_Blox Block Cup cargado!")
