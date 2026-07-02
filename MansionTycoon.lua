-- [[ Mansión Tycoon v1.1 - VERSIÓN FINAL ]] --
-- Creador: JoseAngel_Blox
-- Actualización: Detección de "Giver" y "Essence" activada

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ContentScroll = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

-- // Diseño Principal (Ancho y Redondeado) // --
ScreenGui.Parent = game.CoreGui
MainFrame.Name = "MansionTycoonGui"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 480, 0, 400)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 15)

local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Thickness = 2
Stroke.Color = Color3.fromRGB(65, 65, 65)

Title.Parent = MainFrame
Title.Text = "Mansión Tycoon v1.1"
Title.Size = UDim2.new(1, 0, 0, 50)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20

ContentScroll.Parent = MainFrame
ContentScroll.Size = UDim2.new(1, -20, 1, -65)
ContentScroll.Position = UDim2.new(0, 10, 0, 55)
ContentScroll.BackgroundTransparency = 1
ContentScroll.CanvasSize = UDim2.new(0, 0, 0, 700)
ContentScroll.ScrollBarThickness = 2

UIListLayout.Parent = ContentScroll
UIListLayout.Padding = UDim.new(0, 10)

-- // Sistema de Secciones ↓↑ // --
local function CreateSection(name)
    local SFrame = Instance.new("Frame", ContentScroll)
    SFrame.Size = UDim2.new(1, 0, 0, 40)
    SFrame.BackgroundTransparency = 1
    SFrame.ClipsDescendants = true

    local SBtn = Instance.new("TextButton", SFrame)
    SBtn.Size = UDim2.new(1, 0, 0, 35)
    SBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    SBtn.Text = "  " .. name
    SBtn.TextColor3 = Color3.new(1, 1, 1)
    SBtn.TextXAlignment = Enum.TextXAlignment.Left
    SBtn.Font = Enum.Font.GothamMedium
    Instance.new("UICorner", SBtn).CornerRadius = UDim.new(0, 8)

    local Arrow = Instance.new("TextLabel", SBtn)
    Arrow.Size = UDim2.new(0, 30, 1, 0)
    Arrow.Position = UDim2.new(1, -35, 0, 0)
    Arrow.Text = "↓"
    Arrow.TextColor3 = Color3.new(1, 1, 1)
    Arrow.BackgroundTransparency = 1
    Arrow.Font = Enum.Font.GothamBold

    local Container = Instance.new("Frame", SFrame)
    Container.Position = UDim2.new(0, 5, 0, 40)
    Container.Size = UDim2.new(1, -10, 0, 0)
    Container.BackgroundTransparency = 1
    local CLayout = Instance.new("UIListLayout", Container)
    CLayout.Padding = UDim.new(0, 5)

    local open = false
    SBtn.MouseButton1Click:Connect(function()
        open = not open
        Arrow.Text = open and "↑" or "↓"
        SFrame:TweenSize(UDim2.new(1, 0, 0, open and (45 + CLayout.AbsoluteContentSize.Y) or 40), "Out", "Quart", 0.3, true)
    end)
    return Container
end

local function CreateToggle(name, parent, callback)
    local TBtn = Instance.new("TextButton", parent)
    TBtn.Size = UDim2.new(1, 0, 0, 35)
    TBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TBtn.Text = "  " .. name
    TBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    TBtn.TextXAlignment = Enum.TextXAlignment.Left
    TBtn.Font = Enum.Font.Gotham
    Instance.new("UICorner", TBtn).CornerRadius = UDim.new(0, 6)

    local Ind = Instance.new("Frame", TBtn)
    Ind.Size = UDim2.new(0, 12, 0, 12)
    Ind.Position = UDim2.new(1, -25, 0.5, -6)
    Ind.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    Instance.new("UICorner", Ind).CornerRadius = UDim.new(1, 0)

    local active = false
    TBtn.MouseButton1Click:Connect(function()
        active = not active
        Ind.BackgroundColor3 = active and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
        callback(active)
    end)
end

-- // SECCIONES // --

-- 1) INFO
local Info = CreateSection("Info ↓↑")
local il = Instance.new("TextLabel", Info)
il.Size = UDim2.new(1,0,0,100); il.BackgroundTransparency = 1; il.TextColor3 = Color3.new(0.8,0.8,0.8)
il.Text = "Creador: JoseAngel_Blox\nFecha: 01/07/2026\nVersión: 1.1\n\n¡Bienvenido! Script optimizado.\nGracias por usarlo. ¡Vuelve pronto!"
il.Font = Enum.Font.Gotham; il.TextSize = 14; il.TextWrapped = true

-- 2) MAIN (CON NOMBRES DE IMAGENES)
local Main = CreateSection("Main ↓↑")
CreateToggle("Auto Collect", Main, function(s)
    _G.AutoCollect = s
    spawn(function()
        while _G.AutoCollect do
            pcall(function()
                local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    -- Nombres exactos de tus fotos: "Giver" y "Essence"
                    if v.Name == "Giver" or v.Name == "Essence" or v.Name == "Collect" then
                        firetouchinterest(hrp, v, 0)
                        firetouchinterest(hrp, v, 1)
                    end
                end
            end)
            task.wait(0.5)
        end
    end)
end)

CreateToggle("Auto Build", Main, function(s)
    _G.AutoBuild = s
    spawn(function()
        while _G.AutoBuild do
            pcall(function()
                local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    -- Busca botones por TouchTransmitter y visibilidad
                    if v:IsA("TouchTransmitter") and (v.Parent.Name:find("Button") or v.Parent:FindFirstChild("Price")) then
                        if v.Parent.Transparency < 1 then
                            firetouchinterest(hrp, v.Parent, 0)
                            firetouchinterest(hrp, v.Parent, 1)
                        end
                    end
                end
            end)
            task.wait(0.7)
        end
    end)
end)

-- 3) PLAYER
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

-- 4) CONFIG
local Config = CreateSection("Config ↓↑")
CreateToggle("Anti-Lag", Config, function(s)
    if s then
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
            if v:IsA("Decal") then v:Destroy() end
        end
    end
end)
