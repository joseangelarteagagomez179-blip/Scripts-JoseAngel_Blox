-- Mansion Tycoon v1.0 | Scripts JoseAngel_Blox 🔥
-- Creado el 30/06/2026

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local window = OrionLib:MakeWindow({
    Name = "Mansion Tycoon v1.0",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "MansionTycoon"
})

-- ===================== ANIMACIÓN DE BIENVENIDA =====================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BienvenidaJoseAngel"
screenGui.ResetOnSpawn = false
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.5, 0, 0.3, 0)
frame.Position = UDim2.new(0.25, 0, 0.35, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 1
frame.Parent = screenGui

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.BackgroundTransparency = 1
textLabel.Text = "Bienvenidos a Scripts JoseAngel_Blox"
textLabel.TextColor3 = Color3.fromRGB(255, 0, 255)
textLabel.TextScaled = true
textLabel.Font = Enum.Font.Arcade
textLabel.TextStrokeTransparency = 0
textLabel.TextStrokeColor3 = Color3.fromRGB(255, 0, 255)
textLabel.Parent = frame

-- Letras en movimiento (efecto neón)
local function animateText()
    for i = 1, 8 do
        spawn(function()
            local tween = TweenService:Create(textLabel, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, true), {TextColor3 = Color3.fromRGB(0, 255, 255)})
            tween:Play()
            tween.Completed:Wait()
        end)
    end
end

-- Barra de carga
local barFrame = Instance.new("Frame")
barFrame.Size = UDim2.new(0.6, 0, 0.04, 0)
barFrame.Position = UDim2.new(0.2, 0, 0.6, 0)
barFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
barFrame.Parent = frame

local fill = Instance.new("Frame")
fill.Size = UDim2.new(0, 0, 1, 0)
fill.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
fill.Parent = barFrame

local percent = Instance.new("TextLabel")
percent.Size = UDim2.new(1, 0, 1, 0)
percent.BackgroundTransparency = 1
percent.Text = "0%"
percent.TextColor3 = Color3.fromRGB(255, 255, 255)
percent.TextScaled = true
percent.Font = Enum.Font.Arcade
percent.Parent = barFrame

local loading = true
local percentValue = 1

local loadingConnection = game:GetService("RunService").Heartbeat:Connect(function()
    if loading then
        percentValue = math.min(percentValue + 1, 100)
        fill.Size = UDim2.new(percentValue / 100, 0, 1, 0)
        percent.Text = tostring(percentValue) .. "%"
        
        if percentValue == 100 then
            loading = false
            loadingConnection:Disconnect()
            
            -- Animación neón final
            local glow = Instance.new("UIStroke")
            glow.Color = Color3.fromRGB(255, 0, 255)
            glow.Thickness = 8
            glow.Parent = textLabel
            
            -- Desvanecer
            TweenService:Create(frame, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
            TweenService:Create(fill, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
            
            wait(1.5)
            screenGui:Destroy()
            
            -- ===================== SCRIPT PRINCIPAL =====================
            local Players = game:GetService("Players")
            local RunService = game:GetService("RunService")
            local VirtualUser = game:GetService("VirtualUser")
            local player = Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local hrp = character:WaitForChild("HumanoidRootPart")
            local humanoid = character:WaitForChild("Humanoid")

            local autoBuy = true
            local autoCollect = true
            local autoBuild = true
            local speedBoost = 200

            -- Fondo con luces moradas neon en movimiento (GitHub style)
            local bg = Instance.new("Frame")
            bg.Size = UDim2.new(1, 0, 1, 0)
            bg.BackgroundColor3 = Color3.fromRGB(10, 0, 20)
            bg.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

            local neonEffect = Instance.new("UIStroke")
            neonEffect.Color = Color3.fromRGB(180, 0, 255)
            neonEffect.Thickness = 4
            neonEffect.Transparency = 0.3
            neonEffect.Parent = bg

            -- Animación de luces neon
            spawn(function()
                while bg.Parent do
                    TweenService:Create(neonEffect, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Color = Color3.fromRGB(255, 0, 255)}):Play()
                    wait(1.5)
                    TweenService:Create(neonEffect, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Color = Color3.fromRGB(0, 255, 255)}):Play()
                    wait(1.5)
                end
            end)

            -- ===================== INFO ↓ =====================
            local infoTab = window:MakeTab({Name = "Info", Icon = "rbxassetid://4483345998", PremiumOnly = false})
            infoTab:AddParagraph("Creador", "JoseAngel_Blox")
            infoTab:AddParagraph("Fecha", "30/06/2026")
            infoTab:AddParagraph("Versión", "v1.0")

            -- ===================== MAIN ↓ =====================
            local mainTab = window:MakeTab({Name = "Main", Icon = "rbxassetid://4483345998", PremiumOnly = false})
            mainTab:AddToggle({Name = "Auto Buy", Default = true, Callback = function(v) autoBuy = v end})
            mainTab:AddToggle({Name = "Auto Collect Cash", Default = true, Callback = function(v) autoCollect = v end})
            mainTab:AddToggle({Name = "Auto Build Mansion", Default = true, Callback = function(v) autoBuild = v end})
            mainTab:AddSlider({Name = "WalkSpeed", Min = 16, Max = 500, Default = 200, Callback = function(v) speedBoost = v end})

            -- ===================== FUNCIONES PRINCIPALES =====================
            local function autoFarm()
                local tycoon = workspace:FindFirstChild("Tycoons") or workspace:FindFirstChild("Mansion") or workspace:FindFirstChildWhichIsA("Model", true)
                if not tycoon then return end

                if autoBuy then
                    for _, button in ipairs(tycoon:FindFirstChild("Buttons", true) or {}) do
                        local price = button:FindFirstChild("Price") or button:FindFirstChild("Value") or button:FindFirstChild("Cost")
                        if price and price.Value and player.leaderstats and player.leaderstats:FindFirstChild("Cash") and player.leaderstats.Cash.Value >= price.Value then
                            firetouchinterest(hrp, button:FindFirstChild("Head") or button, 0)
                            firetouchinterest(hrp, button:FindFirstChild("Head") or button, 1)
                        end
                    end
                end

                if autoCollect then
                    for _, drop in ipairs(workspace:FindFirstChild("Drops", true) or workspace:FindFirstChild("Cash") or {}) do
                        if drop:IsA("Part") or drop:IsA("MeshPart") then
                            firetouchinterest(hrp, drop, 0)
                            firetouchinterest(hrp, drop, 1)
                        end
                    end
                end

                if autoBuild then
                    for _, part in ipairs(workspace:GetDescendants()) do
                        if part:IsA("BasePart") and (part.Name:lower():find("mansion") or part.Name:lower():find("villa") or part.Name:lower():find("build")) then
                            if part:FindFirstChild("Price") and part.Price.Value <= (player.leaderstats and player.leaderstats:FindFirstChild("Cash") and player.leaderstats.Cash.Value or 0) then
                                firetouchinterest(hrp, part, 0)
                                firetouchinterest(hrp, part, 1)
                            end
                        end
                    end
                end

                if humanoid then
                    humanoid.WalkSpeed = speedBoost
                    humanoid.JumpPower = speedBoost
                end

                hrp.CFrame = tycoon:FindFirstChild("Spawn") and tycoon.Spawn.CFrame or tycoon.CFrame + Vector3.new(0, 20, 0)
            end

            RunService.Heartbeat:Connect(autoFarm)

            -- Anti-AFK
            player.Idled:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)

            print("✅ Mansion Tycoon v1.0 cargado - JoseAngel_Blox")
        end
    end
end)
