--// Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

--// Variables
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

--// == CREACIÓN DE LA UI PREMIUM == \\
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Corner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local BackgroundImage = Instance.new("ImageLabel")
local ChocolateEffect = Instance.new("ImageLabel") -- Efecto Chocolate

--// Propiedades de la UI
ScreenGui.Name = "PremiumScriptUI"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

--// Marco Principal (Cuadrado con esquinas redondeadas)
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MainFrame.Size = UDim2.new(0, 550, 0, 400)
MainFrame.Position = UDim2.new(0.35, 0, 0.2, 0)
MainFrame.Active = true
MainFrame.Draggable = true -- Para mover la ventana

--// Esquinas Redondeadas
Corner.CornerRadius = UDim.new(0, 15)
Corner.Parent = MainFrame

--// Fondo del Juego
BackgroundImage.Name = "Background"
BackgroundImage.Parent = MainFrame
BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
BackgroundImage.Position = UDim2.new(0,0,0,0)
BackgroundImage.Image = "http://www.roblox.com/asset/?id=13612147265" -- Imagen Dulces/Chocolate
BackgroundImage.ScaleType = Enum.ScaleType.Crop
BackgroundImage.ZIndex = 0

--// EFECTO CHOCOLATE DERRAMÁNDOSE EN LAS ESQUINAS
ChocolateEffect.Name = "ChocolateDrip"
ChocolateEffect.Parent = MainFrame
ChocolateEffect.Size = UDim2.new(1, 0, 0.2, 0)
ChocolateEffect.Position = UDim2.new(0, 0, 0.98, 0)
ChocolateEffect.Image = "http://www.roblox.com/asset/?id=10589185886" -- Imagen de goteo/chocolate
ChocolateEffect.ZIndex = 2

--// Título
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(0, 300, 0, 40)
Title.Position = UDim2.new(0.5, -150, 0, 10)
Title.Font = Enum.Font.GothamBold
Title.Text = "+1 Speed Keyboard Escape"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.ZIndex = 3

--// == FUNCIONES Y BOTONES == \\
-- Aquí dentro van todas las funciones que ya tenemos

-- Variables de estado
local AutoFarmEnabled = false
local AutoWinEnabled = false
local AutoRebirthEnabled = false
local FlyEnabled = false
local SpeedValue = 50
local SoundsUnlocked = false

--// === SECCIÓN PRINCIPAL ===

-- AUTO FARM
local AutoFarmBtn = Instance.new("TextButton")
AutoFarmBtn.Parent = MainFrame
AutoFarmBtn.Size = UDim2.new(0, 200, 0, 40)
AutoFarmBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
AutoFarmBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
AutoFarmBtn.Text = "Auto Farm: OFF"
AutoFarmBtn.TextColor3 = Color3.new(1,1,1)
AutoFarmBtn.Font = Enum.Font.Gotham
Corner:Clone().Parent = AutoFarmBtn

AutoFarmBtn.MouseButton1Click:Connect(function()
    AutoFarmEnabled = not AutoFarmEnabled
    AutoFarmBtn.Text = "Auto Farm: "..(AutoFarmEnabled and "ON" or "OFF")
    AutoFarmBtn.BackgroundColor3 = AutoFarmEnabled and Color3.fromRGB(0,200,0) or Color3.fromRGB(50,50,60)
    
    if AutoFarmEnabled then
        task.spawn(function()
            while AutoFarmEnabled do
                task.wait(0.1)
                pcall(function() fireproximityprompt() end)
            end
        end)
    end
end)

-- AUTO WIN
local AutoWinBtn = Instance.new("TextButton")
AutoWinBtn.Parent = MainFrame
AutoWinBtn.Size = UDim2.new(0, 200, 0, 40)
AutoWinBtn.Position = UDim2.new(0.05, 0, 0.32, 0)
AutoWinBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
AutoWinBtn.Text = "Auto Win: OFF"
AutoWinBtn.TextColor3 = Color3.new(1,1,1)
AutoWinBtn.Font = Enum.Font.Gotham
Corner:Clone().Parent = AutoWinBtn

AutoWinBtn.MouseButton1Click:Connect(function()
    AutoWinEnabled = not AutoWinEnabled
    AutoWinBtn.Text = "Auto Win: "..(AutoWinEnabled and "ON" or "OFF")
    AutoWinBtn.BackgroundColor3 = AutoWinEnabled and Color3.fromRGB(0,200,0) or Color3.fromRGB(50,50,60)
    
    if AutoWinEnabled then
        task.spawn(function()
            while AutoWinEnabled do
                task.wait(1)
                for _, part in pairs(workspace:GetChildren()) do
                    if part.Name:lower():find("finish") or part.Name:lower():find("win") then
                        RootPart.CFrame = part.CFrame + Vector3.new(0, 2, 0)
                        task.wait(0.5)
                    end
                end
            end
        end)
    end
end)

-- SPEED SLIDER
local SpeedText = Instance.new("TextLabel")
SpeedText.Parent = MainFrame
SpeedText.Size = UDim2.new(0, 200, 0, 30)
SpeedText.Position = UDim2.new(0.05, 0, 0.44, 0)
SpeedText.BackgroundTransparency = 1
SpeedText.Text = "Speed: 50"
SpeedText.TextColor3 = Color3.new(1,1,1)
SpeedText.Font = Enum.Font.Gotham

local SpeedSlider = Instance.new("TextButton")
SpeedSlider.Parent = MainFrame
SpeedSlider.Size = UDim2.new(0, 200, 0, 15)
SpeedSlider.Position = UDim2.new(0.05, 0, 0.5, 0)
SpeedSlider.BackgroundColor3 = Color3.fromRGB(80,80,100)
Corner:Clone().Parent = SpeedSlider

SpeedSlider.MouseButton1Down:Connect(function()
    SpeedValue = 16
    Humanoid.WalkSpeed = SpeedValue
    SpeedText.Text = "Speed: "..SpeedValue
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and UserInputService:IsMouseDown(MouseButton1) then
        local pos = SpeedSlider.AbsolutePosition.X
        local size = SpeedSlider.AbsoluteSize.X
        local mouseX = UserInputService:GetMouseLocation().X
        local percent = math.clamp((mouseX - pos) / size, 0, 1)
        SpeedValue = math.floor(16 + (percent * 484))
        Humanoid.WalkSpeed = SpeedValue
        SpeedText.Text = "Speed: "..SpeedValue
    end
end)

-- FLY
local FlyBtn = Instance.new("TextButton")
FlyBtn.Parent = MainFrame
FlyBtn.Size = UDim2.new(0, 200, 0, 40)
FlyBtn.Position = UDim2.new(0.05, 0, 0.58, 0)
FlyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
FlyBtn.Text = "Fly Mode: OFF"
FlyBtn.TextColor3 = Color3.new(1,1,1)
FlyBtn.Font = Enum.Font.Gotham
Corner:Clone().Parent = FlyBtn

FlyBtn.MouseButton1Click:Connect(function()
    FlyEnabled = not FlyEnabled
    FlyBtn.Text = "Fly Mode: "..(FlyEnabled and "ON" or "OFF")
    FlyBtn.BackgroundColor3 = FlyEnabled and Color3.fromRGB(0,200,0) or Color3.fromRGB(50,50,60)
    Humanoid.PlatformStand = FlyEnabled
    Humanoid.GravityScale = FlyEnabled and 0 or 1
end)

RunService.RenderStepped:Connect(function()
    if FlyEnabled then
        local SpeedFly = 50
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then RootPart.Velocity = RootPart.CFrame.LookVector * SpeedFly end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then RootPart.Velocity = -RootPart.CFrame.LookVector * SpeedFly end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then RootPart.Velocity = -RootPart.CFrame.RightVector * SpeedFly end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then RootPart.Velocity = RootPart.CFrame.RightVector * SpeedFly end
    end
end)

-- AUTO REBIRTH
local AutoRebirthBtn = Instance.new("TextButton")
AutoRebirthBtn.Parent = MainFrame
AutoRebirthBtn.Size = UDim2.new(0, 200, 0, 40)
AutoRebirthBtn.Position = UDim2.new(0.05, 0, 0.7, 0)
AutoRebirthBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
AutoRebirthBtn.Text = "Auto Rebirth: OFF"
AutoRebirthBtn.TextColor3 = Color3.new(1,1,1)
AutoRebirthBtn.Font = Enum.Font.Gotham
Corner:Clone().Parent = AutoRebirthBtn

AutoRebirthBtn.MouseButton1Click:Connect(function()
    AutoRebirthEnabled = not AutoRebirthEnabled
    AutoRebirthBtn.Text = "Auto Rebirth: "..(AutoRebirthEnabled and "ON" or "OFF")
    AutoRebirthBtn.BackgroundColor3 = AutoRebirthEnabled and Color3.fromRGB(0,200,0) or Color3.fromRGB(50,50,60)
    
    if AutoRebirthEnabled then
        task.spawn(function()
            while AutoRebirthEnabled do
                task.wait(2)
                pcall(function()
                    fireclickdetector(gethui("Rebirth"):FindFirstChildOfClass("ClickDetector"))
                end)
            end
        end)
    end
end)

-- TP AL FINAL
local TPBtn = Instance.new("TextButton")
TPBtn.Parent = MainFrame
TPBtn.Size = UDim2.new(0, 200, 0, 40)
TPBtn.Position = UDim2.new(0.05, 0, 0.82, 0)
TPBtn.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
TPBtn.Text = "TP AL FINAL"
TPBtn.TextColor3 = Color3.new(1,1,1)
TPBtn.Font = Enum.Font.GothamBold
Corner:Clone().Parent = TPBtn

TPBtn.MouseButton1Click:Connect(function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Part") and (v.Name:find("End") or v.Name:find("Finish")) then
            RootPart.CFrame = v.CFrame + Vector3.new(0,3,0)
            break
        end
    end
end)

--// === SECCIÓN FREE SHOP (Lado Derecho) ===

local ShopTitle = Instance.new("TextLabel")
ShopTitle.Parent = MainFrame
ShopTitle.Size = UDim2.new(0, 200, 0, 30)
ShopTitle.Position = UDim2.new(0.6, 0, 0.15, 0)
ShopTitle.BackgroundTransparency = 1
ShopTitle.Text = "FREE SHOP ITEMS"
ShopTitle.TextColor3 = Color3.fromRGB(255, 200, 0)
ShopTitle.Font = Enum.Font.GothamBold
ShopTitle.TextSize = 16

-- === TREADMILLS ===
local yPos = 0.22
local function CreateUnlockButton(name, id, y)
    local Btn = Instance.new("TextButton")
    Btn.Parent = MainFrame
    Btn.Size = UDim2.new(0, 180, 0, 25)
    Btn.Position = UDim2.new(0.6, 0, y, 0)
    Btn.BackgroundColor3 = Color3.fromRGB(60,60,80)
    Btn.Text = "Unlock "..name
    Btn.TextColor3 = Color3.new(1,1,1)
    Btn.Font = Enum.Font.Gotham
    Corner:Clone().Parent = Btn
    
    Btn.MouseButton1Click:Connect(function()
        pcall(function()
            game:GetService("ReplicatedStorage").Events.BuyTreadmill:InvokeServer(id)
            Btn.BackgroundColor3 = Color3.fromRGB(0,200,0)
            Btn.Text = "✅ "..name
        end)
    end)
end

CreateUnlockButton("Candy-Treadmill", "1799448573", yPos)
CreateUnlockButton("ADMIN-Treadmill", "1799430547", yPos+0.05)
CreateUnlockButton("Diamond-Treadmill", "1724758929", yPos+0.10)
CreateUnlockButton("Gold-Treadmill", "1674743386", yPos+0.15)

-- === SONIDOS ===
local SoundTitle = Instance.new("TextLabel")
SoundTitle.Parent = MainFrame
SoundTitle.Size = UDim2.new(0, 200, 0, 25)
SoundTitle.Position = UDim2.new(0.6, 0, yPos+0.22, 0)
SoundTitle.BackgroundTransparency = 1
SoundTitle.Text = "SOUNDS"
SoundTitle.TextColor3 = Color3.fromRGB(0,255,255)
SoundTitle.Font = Enum.Font.GothamBold

local UnlockSoundBtn = Instance.new("TextButton")
UnlockSoundBtn.Parent = MainFrame
UnlockSoundBtn.Size = UDim2.new(0, 180, 0, 25)
UnlockSoundBtn.Position = UDim2.new(0.6, 0, yPos+0.27, 0)
UnlockSoundBtn.BackgroundColor3 = Color3.fromRGB(60,60,80)
UnlockSoundBtn.Text = "Unlock Sounds"
UnlockSoundBtn.TextColor3 = Color3.new(1,1,1)
Corner:Clone().Parent = UnlockSoundBtn

UnlockSoundBtn.MouseButton1Click:Connect(function()
    pcall(function()
        game:GetService("ReplicatedStorage").Events.BuySound:InvokeServer("1724877043")
        SoundsUnlocked = true
        UnlockSoundBtn.BackgroundColor3 = Color3.fromRGB(0,200,0)
        UnlockSoundBtn.Text = "✅ Sounds Unlocked"
    end)
end)

-- === AURAS ===
local AuraTitle = Instance.new("TextLabel")
AuraTitle.Parent = MainFrame
AuraTitle.Size = UDim2.new(0, 200, 0, 25)
AuraTitle.Position = UDim2.new(0.6, 0, yPos+0.34, 0)
AuraTitle.BackgroundTransparency = 1
AuraTitle.Text = "AURAS"
AuraTitle.TextColor3 = Color3.fromRGB(255,0,255)
AuraTitle.Font = Enum.Font.GothamBold

local function CreateAuraBtn(name, id, y)
    local Btn = Instance.new("TextButton")
    Btn.Parent = MainFrame
    Btn.Size = UDim2.new(0, 180, 0, 22)
    Btn.Position = UDim2.new(0.6, 0, y, 0)
    Btn.BackgroundColor3 = Color3.fromRGB(60,60,80)
    Btn.Text = "Unlock "..name
    Btn.TextColor3 = Color3.new(1,1,1)
    Btn.TextSize = 13
    Corner:Clone().Parent = Btn
    Btn.MouseButton1Click:Connect(function()
        pcall(function()
            game:GetService("ReplicatedStorage").Events.BuyAura:InvokeServer(id)
            Btn.BackgroundColor3 = Color3.fromRGB(0,200,0)
        end)
    end)
end

CreateAuraBtn("GlowAura", "1841065578", yPos+0.39)
CreateAuraBtn("WindAura", "1841089568", yPos+0.43)
CreateAuraBtn("Electric-Aura", "1883044917", yPos+0.47)
CreateAuraBtn("WaterAura", "1840979522", yPos+0.51)
CreateAuraBtn("FireAura", "1860376482", yPos+0.55)

-- === TRAILS ===
local TrailTitle = Instance.new("TextLabel")
TrailTitle.Parent = MainFrame
TrailTitle.Size = UDim2.new(0, 200, 0, 25)
TrailTitle.Position = UDim2.new(0.6, 0, yPos+0.60, 0)
TrailTitle.BackgroundTransparency = 1
TrailTitle.Text = "TRAILS"
TrailTitle.TextColor3 = Color3.fromRGB(255,255,0)
TrailTitle.Font = Enum.Font.GothamBold

local function CreateTrailBtn(name, id, y)
    local Btn = Instance.new("TextButton")
    Btn.Parent = MainFrame
    Btn.Size = UDim2.new(0, 180, 0, 20)
    Btn.Position = UDim2.new(0.6, 0, y, 0)
    Btn.BackgroundColor3 = Color3.fromRGB(60,60,80)
    Btn.Text = "Unlock "..name
    Btn.TextColor3 = Color3.new(1,1,1)
    Btn.TextSize = 12
    Corner:Clone().Parent = Btn
    Btn.MouseButton1Click:Connect(function()
        pcall(function()
            game:GetService("ReplicatedStorage").Events.BuyTrail:InvokeServer(id)
            Btn.BackgroundColor3 = Color3.fromRGB(0,200,0)
        end)
    end)
end

CreateTrailBtn("GalaxyTrail", "1705684677", yPos+0.64)
CreateTrailBtn("RedTrail", "1705880432", yPos+0.67)
CreateTrailBtn("RainbowTrail", "1705872346", yPos+0.70)
CreateTrailBtn("PurpleTrail", "1705766445", yPos+0.73)
CreateTrailBtn("BlueTrail", "1705790528", yPos+0.76)
CreateTrailBtn("SupernovaTrail", "1828536440", yPos+0.79)
CreateTrailBtn("VoidTrail", "1829431034", yPos+0.82)
CreateTrailBtn("CosmicTrail", "1826883825", yPos+0.85)
CreateTrailBtn("GodlikeTrail", "1825327908", yPos+0.88)
CreateTrailBtn("InfinityTrail", "1829496998", yPos+0.91)

print("✅ Script Premium Cargado Correctamente!")
