-- [[ Mansión Tycoon v1.1 ]] --
-- Creador: JoseAngel_Blox
-- Fecha de lanzamiento: 01/07/2026

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")
local UIGradient = Instance.new("UIGradient")
local Title = Instance.new("TextLabel")
local ContentScroll = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

-- // Configuración de la Ventana (Ancha y con fondo bonito) // --
ScreenGui.Parent = game.CoreGui
MainFrame.Name = "MansionTycoonGui"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 450, 0, 380) -- Ancha
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true

UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

UIStroke.Parent = MainFrame
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(70, 70, 70)

UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 15))
}
UIGradient.Rotation = 45
UIGradient.Parent = MainFrame

Title.Parent = MainFrame
Title.Text = "Mansión Tycoon v1.1"
Title.Size = UDim2.new(1, 0, 0, 45)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

ContentScroll.Parent = MainFrame
ContentScroll.Size = UDim2.new(1, -20, 1, -55)
ContentScroll.Position = UDim2.new(0, 10, 0, 50)
ContentScroll.BackgroundTransparency = 1
ContentScroll.ScrollBarThickness = 4
ContentScroll.CanvasSize = UDim2.new(0, 0, 0, 650)

UIListLayout.Parent = ContentScroll
UIListLayout.Padding = UDim.new(0, 8)

-- // FUNCIONES DE INTERFAZ (Animaciones y Flechas ↓↑) // --
local function CreateSection(name)
    local SectionFrame = Instance.new("Frame")
    local SectionButton = Instance.new("TextButton")
    local SectionTitle = Instance.new("TextLabel")
    local Arrow = Instance.new("TextLabel")
    local Container = Instance.new("Frame")
    local ContainerLayout = Instance.new("UIListLayout")

    SectionFrame.Parent = ContentScroll
    SectionFrame.Size = UDim2.new(1, 0, 0, 40)
    SectionFrame.BackgroundTransparency = 1
    SectionFrame.ClipsDescendants = true

    SectionButton.Size = UDim2.new(1, 0, 0, 35)
    SectionButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    SectionButton.Parent = SectionFrame
    SectionButton.Text = ""
    Instance.new("UICorner", SectionButton).CornerRadius = UDim.new(0, 6)

    SectionTitle.Parent = SectionButton
    SectionTitle.Size = UDim2.new(1, -40, 1, 0)
    SectionTitle.Position = UDim2.new(0, 10, 0, 0)
    SectionTitle.Text = name
    SectionTitle.TextColor3 = Color3.new(1, 1, 1)
    SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
    SectionTitle.Font = Enum.Font.GothamMedium
    SectionTitle.BackgroundTransparency = 1

    Arrow.Parent = SectionButton
    Arrow.Size = UDim2.new(0, 30, 1, 0)
    Arrow.Position = UDim2.new(1, -35, 0, 0)
    Arrow.Text = "↓"
    Arrow.TextColor3 = Color3.new(1, 1, 1)
    Arrow.BackgroundTransparency = 1
    Arrow.Font = Enum.Font.GothamBold

    Container.Parent = SectionFrame
    Container.Position = UDim2.new(0, 5, 0, 40)
    Container.Size = UDim2.new(1, -10, 0, 0)
    Container.BackgroundTransparency = 1
    ContainerLayout.Parent = Container
    ContainerLayout.Padding = UDim.new(0, 5)

    local open = false
    SectionButton.MouseButton1Click:Connect(function()
        open = not open
        Arrow.Text = open and "↑" or "↓"
        SectionFrame:TweenSize(UDim2.new(1, 0, 0, open and (45 + ContainerLayout.AbsoluteContentSize.Y) or 40), "Out", "Quart", 0.3, true)
    end)
    return Container
end

local function CreateToggle(name, parent, callback)
    local TFrame = Instance.new("TextButton")
    TFrame.Size = UDim2.new(1, 0, 0, 30)
    TFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TFrame.Text = "  " .. name
    TFrame.TextColor3 = Color3.fromRGB(200, 200, 200)
    TFrame.TextXAlignment = Enum.TextXAlignment.Left
    TFrame.Font = Enum.Font.Gotham
    TFrame.Parent = parent
    Instance.new("UICorner", TFrame).CornerRadius = UDim.new(0, 4)

    local Indicator = Instance.new("Frame")
    Indicator.Size = UDim2.new(0, 10, 0, 10)
    Indicator.Position = UDim2.new(1, -20, 0.5, -5)
    Indicator.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    Indicator.Parent = TFrame
    Instance.new("UICorner", Indicator).CornerRadius = UDim.new(1, 0)

    local state = false
    TFrame.MouseButton1Click:Connect(function()
        state = not state
        Indicator.BackgroundColor3 = state and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
        callback(state)
    end)
end

-- // 1) SECCIÓN INFO ↓↑ // --
local Info = CreateSection("Info ↓↑")
local function AddLabel(txt, p)
    local l = Instance.new("TextLabel", p)
    l.Size = UDim2.new(1,0,0,20); l.BackgroundTransparency = 1; l.TextColor3 = Color3.new(0.7,0.7,0.7)
    l.Text = txt; l.TextXAlignment = 0; l.Font = Enum.Font.Gotham
end
AddLabel("Creador: JoseAngel_Blox", Info)
AddLabel("Lanzamiento: 01/07/2026", Info)
AddLabel("Versión: 1.1", Info)
AddLabel("¡Bienvenido! Script hecho para ti.", Info)

-- // 2) SECCIÓN MAIN ↓↑ // --
local Main = CreateSection("Main ↓↑")
CreateToggle("Auto Collect", Main, function(s)
    _G.AC = s
    while _G.AC do
        pcall(function()
            local p = game.Players.LocalPlayer
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name == "Collect" or v.Name == "Giver" then
                    firetouchinterest(p.Character.HumanoidRootPart, v.Parent, 0)
                    firetouchinterest(p.Character.HumanoidRootPart, v.Parent, 1)
                end
            end
        end)
        task.wait(0.5)
    end
end)

CreateToggle("Auto Build", Main, function(s)
    _G.AB = s
    while _G.AB do
        pcall(function()
            local p = game.Players.LocalPlayer
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v:IsA("TouchTransmitter") and (v.Parent.Name:find("Button") or v.Parent.Parent.Name:find("Buttons")) then
                    firetouchinterest(p.Character.HumanoidRootPart, v.Parent, 0)
                    firetouchinterest(p.Character.HumanoidRootPart, v.Parent, 1)
                end
            end
        end)
        task.wait(0.5)
    end
end)

-- // 3) SECCIÓN PLAYER ↓↑ // --
local Player = CreateSection("Player ↓↑")
CreateToggle("Speed", Player, function(s)
    _G.Spd = s
    game:GetService("RunService").RenderStepped:Connect(function()
        if _G.Spd then game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 60 else game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16 end
    end)
end)

CreateToggle("Noclip", Player, function(s)
    _G.Nc = s
    game:GetService("RunService").Stepped:Connect(function()
        if _G.Nc then
            for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)
end)

CreateToggle("Infinite Jump", Player, function(s)
    _G.IJ = s
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if _G.IJ then game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping") end
    end)
end)

-- // 4) SECCIÓN CONFIG ↓↑ // --
local Config = CreateSection("Config ↓↑")
CreateToggle("Mostrar FPS", Config, function(s)
    _G.FPS = s
    if s then spawn(function() while _G.FPS do print("FPS: " .. math.floor(1/wait())); wait(2) end end) end
end)

CreateToggle("Anti Lag", Config, function(s)
    if s then
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
            if v:IsA("Decal") then v:Destroy() end
        end
    end
end)
