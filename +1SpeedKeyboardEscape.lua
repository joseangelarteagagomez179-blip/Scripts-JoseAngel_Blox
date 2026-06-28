--[[ DOLA HUB - FIXED ]]
local Player = game.Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")

--// GUI
local Gui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Min = Instance.new("TextButton")

Gui.Name = "DolaHub"
Gui.Parent = Player.PlayerGui

Main.Parent = Gui
Main.BackgroundColor3 = Color3.fromRGB(20,20,35)
Main.Size = UDim2.new(0,320,0,420)
Main.Position = UDim2.new(0.35,0,0.15,0)
Main.Active = true
Main.Draggable = true

local Corner = Instance.new("UICorner", Main)
Corner.CornerRadius = UDim.new(0,14)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(255,100,180)
Stroke.Thickness = 2

--// TOP BAR
Title.Parent = Main
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1,0,0,40)
Title.Position = UDim2.new(0,0,0,0)
Title.Font = Enum.Font.GothamBold
Title.Text = "✨ DOLA HUB"
Title.TextColor3 = Color3.new(1,1,1)
Title.TextSize = 16

Min.Parent = Main
Min.Size = UDim2.new(0,30,0,30)
Min.Position = UDim2.new(0.9,0,0,5)
Min.BackgroundColor3 = Color3.fromRGB(255,70,70)
Min.Text = "-"
Min.TextColor3 = Color3.new(1,1,1)
Min.Font = Enum.Font.GothamBold
local MinC = Instance.new("UICorner", Min)
MinC.CornerRadius = UDim.new(1,0)

--// FUNCION BOTON
local function Btn(name,color,y,call)
    local B = Instance.new("TextButton")
    B.Parent = Main
    B.Size = UDim2.new(0.9,0,0,45)
    B.Position = UDim2.new(0.05,0,0,y,0)
    B.BackgroundColor3 = color
    B.Text = name
    B.TextColor3 = Color3.new(1,1,1)
    B.Font = Enum.Font.GothamBold
    B.TextSize = 14
    local BC = Instance.new("UICorner", B)
    BC.CornerRadius = UDim.new(0,8)
    B.MouseButton1Click:Connect(call)
end

--// ==================== FUNCIONES CORREGIDAS ====================

Btn("⚡ ACTIVAR VELOCIDAD",Color3.fromRGB(70,200,255),55,function()
    local H = Player.Character.Humanoid
    H.WalkSpeed = 200 -- Velocidad controlada para no buguear
    H.JumpPower = 150
    spawn(function() while true do for _,v in pairs(Player.Character:GetChildren()) do if v:IsA("BasePart") then v.CanCollide = false end end task.wait() end end)
end)

Btn("🏆 AUTO WIN SEGURO",Color3.fromRGB(255,160,60),105,function()
    spawn(function()
        while true do
            task.wait(0.1)
            local hrp = Player.Character.HumanoidRootPart
            -- Moverse suavemente hacia adelante
            hrp.CFrame = hrp.CFrame * CFrame.new(0, 0.1, -5)
        end
    end)
end)

Btn("🚀 IR A LA META (SEGURO)",Color3.fromRGB(140,120,255),155,function()
    local hrp = Player.Character.HumanoidRootPart
    -- Coordenadas ALTAS y SEGURAS (arriba del mapa)
    hrp.CFrame = CFrame.new(hrp.Position.X, hrp.Position.Y + 200, hrp.Position.Z - 5000)
end)

Btn("💎 COMPRAR TODO + TREADMILLS",Color3.fromRGB(255,80,150),205,function()
    pcall(function()
        -- Dinero Infinito
        for _,v in pairs(Player.leaderstats:GetChildren()) do
            if v:IsA("NumberValue") or v:IsA("IntValue") then v.Value = math.huge end
        end
        
        -- BUSCAR Y COMPRAR LAS CINTAS (TREADMILLS)
        for _,v in pairs(workspace:GetDescendants()) do
            if v:IsA("ClickDetector") then
                -- Busca palabras clave como comprar, treadmill, cinta, etc.
                local name = v.Parent.Name:lower()
                if name:find("buy") or name:find("treadmill") or name:find("cinta") or name:find("shop") then
                    fireclickdetector(v)
                    task.wait(0.1)
                end
            end
        end
    end)
    game.StarterGui:SetCore("SendNotification", {Title="LISTO!", Text="Treadmills desbloqueadas!", Duration=2})
end)

Btn("♻️ AUTO REBIRTH",Color3.fromRGB(190,80,255),255,function()
    spawn(function() while true do task.wait(1) pcall(function() for _,v in pairs(workspace:GetDescendants()) do if v:IsA("ClickDetector") and v.Parent.Name:lower():find("rebirth") then fireclickdetector(v) end end end) end end)
end)

Btn("💨 VELOCIDAD MAXIMA",Color3.fromRGB(60,255,150),305,function()
    Player.Character.Humanoid.WalkSpeed = 9999
end)

--// MINIMIZAR
Min.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

print("✅ DOLA HUB - VERSION CORREGIDA")
