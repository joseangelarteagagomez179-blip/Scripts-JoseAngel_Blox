--// Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

--// Variables
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

--// UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/KiriX200/UI-Library/main/source.lua"))()
local Window = Library:CreateWindow({
    Name = "+1 Speed Keyboard Escape",
    LoadingTitle = "Cargando Script...",
    LoadingSubtitle = "Bienvenido",
    Theme = "Dark",
    Color = Color3.fromRGB(255, 105, 180), -- Rosa Vibrante
    BackgroundImage = "http://www.roblox.com/asset/?id=13612147265" -- Fondo Caramelo/Chocolate
})

--// Tabs
local MainTab = Window:CreateTab({Name = "Principal", Icon = "rbxassetid://4483345998"})
local ShopTab = Window:CreateTab({Name = "Free Shop", Icon = "rbxassetid://4483346461"})

--// Variables de estado
local AutoFarmEnabled = false
local AutoWinEnabled = false
local AutoRebirthEnabled = false
local FlyEnabled = false
local SpeedValue = 50
local SoundsUnlocked = false

--// === SECCIÓN PRINCIPAL ===

--// 1. AUTO FARM
MainTab:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Callback = function(Value)
        AutoFarmEnabled = Value
        task.spawn(function()
            while AutoFarmEnabled do
                task.wait(0.1)
                pcall(function()
                    fireproximityprompt()
                end)
            end
        end)
    end
})

--// 2. AUTO WIN (Todas las wins)
MainTab:CreateToggle({
    Name = "Auto Win (All Stages)",
    CurrentValue = false,
    Callback = function(Value)
        AutoWinEnabled = Value
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
})

--// 3. SPEED
MainTab:CreateSlider({
    Name = "WalkSpeed",
    Min = 16,
    Max = 500,
    Default = 50,
    Callback = function(Value)
        SpeedValue = Value
        Humanoid.WalkSpeed = Value
    end
})

--// 4. FLY (PC y Joystick)
MainTab:CreateToggle({
    Name = "Fly Mode",
    CurrentValue = false,
    Callback = function(Value)
        FlyEnabled = Value
        Humanoid.PlatformStand = Value
        Humanoid.GravityScale = Value and 0 or 1
        
        if FlyEnabled then
            -- Control PC
            UserInputService.InputBegan:Connect(function(input, gp)
                if gp then return end
                local speed = 100
                if input.KeyCode == Enum.KeyCode.W then RootPart.Velocity = RootPart.CFrame.LookVector * speed end
                if input.KeyCode == Enum.KeyCode.S then RootPart.Velocity = -RootPart.CFrame.LookVector * speed end
                if input.KeyCode == Enum.KeyCode.A then RootPart.Velocity = -RootPart.CFrame.RightVector * speed end
                if input.KeyCode == Enum.KeyCode.D then RootPart.Velocity = RootPart.CFrame.RightVector * speed end
            end)
            -- Control Móvil/Joystick
            RunService.RenderStepped:Connect(function()
                if FlyEnabled then
                    local MoveVector = Humanoid.MoveDirection
                    RootPart.Velocity = MoveVector * 100
                end
            end)
        end
    end
})

--// 5. AUTO REBIRTH
MainTab:CreateToggle({
    Name = "Auto Rebirth",
    CurrentValue = false,
    Callback = function(Value)
        AutoRebirthEnabled = Value
        task.spawn(function()
            while AutoRebirthEnabled do
                task.wait(2)
                pcall(function()
                    fireclickdetector(gethui("Rebirth"):FindFirstChildOfClass("ClickDetector"))
                end)
            end
        end)
    end
})

--// 6. AUTO END / TP AL FINAL
MainTab:CreateButton({
    Name = "TP al Final",
    Callback = function()
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Part") and (v.Name:find("End") or v.Name:find("Finish")) then
                RootPart.CFrame = v.CFrame + Vector3.new(0,3,0)
                break
            end
        end
    end
})

--// === SECCIÓN FREE SHOP ===
ShopTab:CreateLabel("Desbloquear Cintas (Treadmills)")

-- Candy Treadmill
ShopTab:CreateToggle({
    Name = "Unlock Candy-Treadmill",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            pcall(function()
                game:GetService("ReplicatedStorage").Events.BuyTreadmill:InvokeServer("1799448573")
            end)
        end
    end
})

-- Admin Treadmill
ShopTab:CreateToggle({
    Name = "Unlock ADMIN-Treadmill",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            pcall(function()
                game:GetService("ReplicatedStorage").Events.BuyTreadmill:InvokeServer("1799430547")
            end)
        end
    end
})

-- Diamond Treadmill
ShopTab:CreateToggle({
    Name = "Unlock Diamond-Treadmill",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            pcall(function()
                game:GetService("ReplicatedStorage").Events.BuyTreadmill:InvokeServer("1724758929")
            end)
        end
    end
})

-- Gold Treadmill
ShopTab:CreateToggle({
    Name = "Unlock Gold-Treadmill",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            pcall(function()
                game:GetService("ReplicatedStorage").Events.BuyTreadmill:InvokeServer("1674743386")
            end)
        end
    end
})

--// === SECCIÓN SONIDOS ===
ShopTab:CreateLabel("") -- Espacio separador
ShopTab:CreateLabel("Gamepass Sounds")

-- Unlock Sounds
ShopTab:CreateToggle({
    Name = "Unlock Sounds",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            pcall(function()
                game:GetService("ReplicatedStorage").Events.BuySound:InvokeServer("1724877043")
                SoundsUnlocked = true
            end)
        else
            SoundsUnlocked = false
        end
    end
})

-- Selector de Sonidos
ShopTab:CreateDropdown({
    Name = "Seleccionar Sonido",
    Options = {"Sonido 1", "Sonido 2", "Sonido 3", "Sonido 4", "Sonido 5"},
    CurrentOption = "Sonido 1",
    Callback = function(Option)
        if SoundsUnlocked then
            print("Sonido seleccionado: " .. Option)
        else
            print("Primero desbloquea los sonidos!")
        end
    end
})

--// === SECCIÓN AURAS ===
ShopTab:CreateLabel("") -- Espacio separador
ShopTab:CreateLabel("✨ Gamepass Auras ✨")

-- Glow Aura
ShopTab:CreateToggle({
    Name = "Unlock GlowAura",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            pcall(function()
                game:GetService("ReplicatedStorage").Events.BuyAura:InvokeServer("1841065578")
            end)
        end
    end
})

-- Wind Aura
ShopTab:CreateToggle({
    Name = "Unlock WindAura",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            pcall(function()
                game:GetService("ReplicatedStorage").Events.BuyAura:InvokeServer("1841089568")
            end)
        end
    end
})

-- Electric Aura
ShopTab:CreateToggle({
    Name = "Unlock Electric-Aura",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            pcall(function()
                game:GetService("ReplicatedStorage").Events.BuyAura:InvokeServer("1883044917")
            end)
        end
    end
})

-- Water Aura
ShopTab:CreateToggle({
    Name = "Unlock WaterAura",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            pcall(function()
                game:GetService("ReplicatedStorage").Events.BuyAura:InvokeServer("1840979522")
            end)
        end
    end
})

-- Fire Aura
ShopTab:CreateToggle({
    Name = "Unlock FireAura",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            pcall(function()
                game:GetService("ReplicatedStorage").Events.BuyAura:InvokeServer("1860376482")
            end)
        end
    end
})

--// === SECCIÓN TRAILS ===
ShopTab:CreateLabel("") -- Espacio separador
ShopTab:CreateLabel("💫 Gamepass Trails 💫")

-- GalaxyTrail
ShopTab:CreateToggle({
    Name = "Unlock GalaxyTrail",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            pcall(function()
                game:GetService("ReplicatedStorage").Events.BuyTrail:InvokeServer("1705684677")
            end)
        end
    end
})

-- RedTrail
ShopTab:CreateToggle({
    Name = "Unlock RedTrail",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            pcall(function()
                game:GetService("ReplicatedStorage").Events.BuyTrail:InvokeServer("1705880432")
            end)
        end
    end
})

-- RainbowTrail
ShopTab:CreateToggle({
    Name = "Unlock RainbowTrail",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            pcall(function()
                game:GetService("ReplicatedStorage").Events.BuyTrail:InvokeServer("1705872346")
            end)
        end
    end
})

-- PurpleTrail
ShopTab:CreateToggle({
    Name = "Unlock PurpleTrail",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            pcall(function()
                game:GetService("ReplicatedStorage").Events.BuyTrail:InvokeServer("1705766445")
            end)
        end
    end
})

-- BlueTrail
ShopTab:CreateToggle({
    Name = "Unlock BlueTrail",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            pcall(function()
                game:GetService("ReplicatedStorage").Events.BuyTrail:InvokeServer("1705790528")
            end)
        end
    end
})

-- SupernovaTrail
ShopTab:CreateToggle({
    Name = "Unlock SupernovaTrail",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            pcall(function()
                game:GetService("ReplicatedStorage").Events.BuyTrail:InvokeServer("1828536440")
            end)
        end
    end
})

-- VoidTrail
ShopTab:CreateToggle({
    Name = "Unlock VoidTrail",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            pcall(function()
                game:GetService("ReplicatedStorage").Events.BuyTrail:InvokeServer("1829431034")
            end)
        end
    end
})

-- CosmicTrail
ShopTab:CreateToggle({
    Name = "Unlock CosmicTrail",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            pcall(function()
                game:GetService("ReplicatedStorage").Events.BuyTrail:InvokeServer("1826883825")
            end)
        end
    end
})

-- GodlikeTrail
ShopTab:CreateToggle({
    Name = "Unlock GodlikeTrail",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            pcall(function()
                game:GetService("ReplicatedStorage").Events.BuyTrail:InvokeServer("1825327908")
            end)
        end
    end
})

-- InfinityTrail
ShopTab:CreateToggle({
    Name = "Unlock InfinityTrail",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            pcall(function()
                game:GetService("ReplicatedStorage").Events.BuyTrail:InvokeServer("1829496998")
            end)
        end
    end
})

print("✅ Script Premium Cargado Correctamente!")
