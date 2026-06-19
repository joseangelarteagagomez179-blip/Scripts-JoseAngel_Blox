-- JoseAngel_Blox - Block Cup

local Player = game:GetService("Players").LocalPlayer
local HumRoot = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") or Player.CharacterAdded:Wait():WaitForChild("HumanoidRootPart")

local function RecogerBolas()
    for _, v in pairs(workspace:GetChildren()) do
        if string.find(string.lower(v.Name), "ball") then
            if v:IsA("Part") or v:IsA("MeshPart") then
                v.CFrame = HumRoot.CFrame
            end
        end
    end
end

local Gui = Instance.new("ScreenGui")
Gui.Name = "JoseAngel_Blox"
Gui.Parent = Player.PlayerGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 250, 0, 150)
Frame.Position = UDim2.new(0.1, 0, 0.1, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
Frame.BorderSizePixel = 0
Frame.ClipsDescendants = true
Frame.Active = true
Frame.Draggable = true
Frame.Parent = Gui

local BackgroundImage = Instance.new("ImageLabel")
BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
BackgroundImage.Position = UDim2.new(0,0,0,0)
BackgroundImage.BackgroundTransparency = 1
BackgroundImage.Image = "rbxassetid://1234567890"
BackgroundImage.ScaleType = Enum.ScaleType.Fit
BackgroundImage.Parent = Frame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = Frame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0,0,0,0)
Title.BackgroundTransparency = 1
Title.Text = "JoseAngel_Blox"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.ZIndex = 2
Title.Parent = Frame

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, 0, 0, 20)
SubTitle.Position = UDim2.new(0, 0, 0, 25)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Block Cup 🏆"
SubTitle.TextColor3 = Color3.new(255, 215, 0)
SubTitle.Font = Enum.Font.GothamBold
SubTitle.TextSize = 12
SubTitle.ZIndex = 2
SubTitle.Parent = Frame

local Btn1 = Instance.new("TextButton")
Btn1.Size = UDim2.new(0.9, 0, 0, 35)
Btn1.Position = UDim2.new(0.05, 0, 0, 55)
Btn1.BackgroundColor3 = Color3.fromRGB(0, 80, 200)
Btn1.BorderSizePixel = 0
Btn1.Text = "Collect Ball Once"
Btn1.TextColor3 = Color3.new(1,1,1)
Btn1.Font = Enum.Font.GothamBold
Btn1.TextSize = 14
Btn1.ZIndex = 2
Btn1.Parent = Frame

local Corner1 = Instance.new("UICorner")
Corner1.CornerRadius = UDim.new(0, 8)
Corner1.Parent = Btn1

local Btn2 = Instance.new("TextButton")
Btn2.Size = UDim2.new(0.9, 0, 0, 35)
Btn2.Position = UDim2.new(0.05, 0, 0, 95)
Btn2.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
Btn2.BorderSizePixel = 0
Btn2.Text = "Auto Collect Ball: OFF"
Btn2.TextColor3 = Color3.new(1,1,1)
Btn2.Font = Enum.Font.GothamBold
Btn2.TextSize = 14
Btn2.ZIndex = 2
Btn2.Parent = Frame

local Corner2 = Instance.new("UICorner")
Corner2.CornerRadius = UDim.new(0, 8)
Corner2.Parent = Btn2

local Auto = false

Btn1.MouseButton1Click:Connect(function()
    RecogerBolas()
end)

Btn2.MouseButton1Click:Connect(function()
    Auto = not Auto
    if Auto then
        Btn2.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
        Btn2.Text = "Auto Collect Ball: ON"
        spawn(function()
            while Auto and task.wait(0.1) do
                RecogerBolas()
            end
        end)
    else
        Btn2.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
        Btn2.Text = "Auto Collect Ball: OFF"
    end
end)
