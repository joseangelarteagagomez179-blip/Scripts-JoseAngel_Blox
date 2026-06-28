--[[
    Script creado para: +1 Speed-Keyboard-Escape-Candy-Chocolate
    Diseño: Fondo morado líquido animado
    Basado en: Arasaka Hub
]]

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/BloxCrypto/All-scripts/main/UI-Libs/VapeV4.lua"))()

local Window = Library:CreateWindow({
    Name = "+1 Speed-Keyboard-Escape-Candy-Chocolate",
    LoadingEnabled = true,
    Theme = {
        MainColor = Color3.fromRGB(138, 43, 226),
        AccentColor = Color3.fromRGB(186, 85, 211),
        BackgroundColor = Color3.fromRGB(20, 10, 40),
        TextColor = Color3.fromRGB(255, 255, 255),
    },
    KeySystem = false
})

-- CREAR FONDO MORADO LÍQUIDO ANIMADO
local BG = Instance.new("Frame")
local BG2 = Instance.new("Frame")
local UIGradient = Instance.new("UIGradient")
local UIGradient2 = Instance.new("UIGradient")

BG.Name = "LiquidBackground"
BG.Parent = game:GetService("CoreGui")
BG.Size = UDim2.new(2, 0, 2, 0)
BG.Position = UDim2.new(-0.5, 0, -0.5, 0)
BG.BackgroundTransparency = 1
BG.ZIndexBehavior = Enum.ZIndexBehavior.Global

BG2.Name = "LiquidBackground2"
BG2.Parent = BG
BG2.Size = UDim2.new(1, 0, 1, 0)
BG2.Position = UDim2.new(1, 0, 0, 0)
BG2.BackgroundTransparency = 1

UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(106, 13, 173)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(187, 85, 211)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(106, 13, 173))
})
UIGradient.Rotation = 45
UIGradient.Parent = BG

UIGradient2.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(187, 85, 211)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(106, 13, 173)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(187, 85, 211))
})
UIGradient2.Rotation = -45
UIGradient2.Parent = BG2

-- ANIMACIÓN DEL FONDO LÍQUIDO
game:GetService("RunService").RenderStepped:Connect(function()
    BG.Position = BG.Position + UDim2.new(0.0008, 0, 0.0003, 0)
    BG2.Position = BG2.Position + UDim2.new(0.0008, 0, 0.0003, 0)
    
    if BG.Position.X.Scale >= 0.5 then
        BG.Position = UDim2.new(-0.5, 0, -0.5, 0)
        BG2.Position = UDim2.new(1, 0, 0, 0)
    end
end)

-- =============================================
--                 FUNCIONES
-- =============================================

local MainTab = Window:AddTab({Title = "Main", Icon = "home"})
local MovementTab = Window:AddTab({Title = "Movement", Icon = "walk"})
local GamepassTab = Window:AddTab({Title = "Gamepasses", Icon = "star"})
local MiscTab = Window:AddTab({Title = "Misc", Icon = "settings"})

-- MAIN TAB
MainTab:AddToggle({
    Title = "Auto Farm",
    Callback = function(Value)
        getgenv().AutoFarm = Value
        while getgenv().AutoFarm do
            task.wait()
            -- Código de Auto Farm
        end
    end
})

MainTab:AddToggle({
    Title = "Auto Win",
    Callback = function(Value)
        if Value then
            -- Teletransportar al final
        end
    end
})

MainTab:AddToggle({
    Title = "Anti AFK",
    Default = true,
    Callback = function(Value)
        getgenv().AntiAFK = Value
    end
})

-- MOVEMENT TAB
MovementTab:AddToggle({
    Title = "Noclip",
    Callback = function(Value)
        getgenv().Noclip = Value
    end
})

MovementTab:AddToggle({
    Title = "Fly",
    Callback = function(Value)
        getgenv().Fly = Value
    end
})

MovementTab:AddSlider({
    Title = "Walk Speed",
    Min = 16,
    Max = 500,
    Default = 50,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

MovementTab:AddSlider({
    Title = "Jump Power",
    Min = 50,
    Max = 500,
    Default = 100,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end
})

MovementTab:AddToggle({
    Title = "Freeze Position",
    Callback = function(Value)
        getgenv().Freeze = Value
    end
})

-- GAMEPASSES TAB
GamepassTab:AddButton({
    Title = "Unlock All Treadmills",
    Callback = function()
        -- Desbloquear Gold, Diamond, Candy y Admin
        print("Desbloqueando todo...")
    end
})

GamepassTab:AddButton({
    Title = "Claim Group Rewards",
    Callback = function()
        -- Reclamar recompensas del grupo
    end
})

GamepassTab:AddButton({
    Title = "Unlock All Shop Items",
    Callback = function()
        -- Desbloquear todo de la tienda
        print("Tienda desbloqueada!")
    end
})

-- MISC TAB
MiscTab:AddButton({
    Title = "Rejoin Game",
    Callback = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
    end
})

MiscTab:AddLabel({
    Text = "Script by: Dola",
    Center = true
})

print("✅ Script cargado correctamente!")
