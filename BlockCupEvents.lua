-- JoseAngel_Blox - Block Cup (VERSION FINAL)

local Player = game:GetService("Players").LocalPlayer
local HumRoot = Player.Character:WaitForChild("HumanoidRootPart")

local function RecogerBolas()
    for _, v in pairs(workspace:GetDescendants()) do
        if string.find(string.lower(v.Name), "ball") then
            if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("BasePart") then
                v.CFrame = HumRoot.CFrame -- ✅ AQUI ESTA CORREGIDO
                v.CanCollide = false
            end
        end
    end
end

-- GUI
local Gui = Instance.new("ScreenGui")
Gui.Name = "JoseAngel_Blox"
Gui.Parent = Player.PlayerGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 220, 0, 130)
Frame.Position = UDim2.new(0.1, 0, 0.1, 0)
Frame.BackgroundColor3 = Color3.new(0,0,0)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = Gui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Frame

-- Imagen
local BackgroundImage = Instance.new("ImageLabel")
BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
BackgroundImage.Position = UDim2.new(0,0,0,0)
BackgroundImage.BackgroundTransparency = 1
BackgroundImage.Image = "rbxassetid://1234567890"
BackgroundImage.ScaleType = Enum.ScaleType.Fit
BackgroundImage.Parent = Frame

-- Texto
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 25)
Title.Position = UDim2.new(0,0,0,0)
Title.BackgroundTransparency = 1
Title.Text = "JoseAngel_Blox"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.ZIndex = 2
Title.Parent = Frame

-- Botones
local Btn1 = Instance.new("TextButton")
Btn1.Size = UDim2.new(0.9, 0, 0, 32)
Btn1.Position = UDim2.new(0.05, 0, 0, 35)
Btn1.BackgroundColor3 = Color3.fromRGB(0, 80, 200)
Btn1.BorderSizePixel = 0
Btn1.Text = "Collect Ball Once"
Btn1.TextColor3 = Color3.new(1,1,1)
Btn1.Font = Enum.Font.GothamBold
Btn1.TextSize = 13
Btn1.ZIndex = 2
Btn1.Parent = Frame

local Btn2 = Instance.new("TextButton")
Btn2.Size = UDim2.new(0.9, 0, 0, 32)
Btn2.Position = UDim2.new(0.05, 0, 0, 75)
Btn2.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
Btn2.BorderSizePixel = 0
Btn2.Text = "Auto Collect: OFF"
Btn2.TextColor3 = Color3.new(1,1,1)
Btn2.Font = Enum.Font.GothamBold
Btn2.TextSize = 13
Btn2.ZIndex = 2
Btn2.Parent = Frame

local Corner1 = Instance.new("UICorner")
Corner1.CornerRadius = UDim.new(0, 8)
Corner1.Parent = Btn1

local Corner2 = Instance.new("UICorner")
Corner2.CornerRadius = UDim.new(0, 8)
Corner2.Parent = Btn2

-- Logica
local Auto = false
local Loop = nil

Btn1.MouseButton1Click:Connect(RecogerBolas)

Btn2.MouseButton1Click:Connect(function()
    Auto = not Auto
    if Auto then
        Btn2.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
        Btn2.Text = "Auto Collect: ON"
        Loop = task.spawn(function()
            while Auto and task.wait(0.05) do
                RecogerBolas()
            end
        end)
    else
        Btn2.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
        Btn2.Text = "Auto Collect: OFF"
        if Loop then task.cancel(Loop) end
    end
end)
