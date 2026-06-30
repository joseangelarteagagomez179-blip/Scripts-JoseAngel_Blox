-- SERVICIOS
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

-- LOCAL
local LP = Players.LocalPlayer
local Char = LP.Character or LP.CharacterAdded:Wait()
local Hum = Char:WaitForChild("Humanoid")
local HRP = Char.HumanoidRootPart

-- ENCONTRAR TU TYCOON (ADAPTADO PARA MANSION TYCOON)
local MyTycoon = nil

-- Buscamos la carpeta principal del juego
for _, obj in pairs(Workspace:GetChildren()) do
    -- Buscamos el modelo que tenga tu nombre o que sea tu base
    if obj.Name:find(LP.Name) or obj.Name:find("Mansion") and obj:FindFirstChild("Owner") then
        if obj.Owner.Value == LP then
            MyTycoon = obj
            break
        end
    end
end

-- Si no lo encuentra arriba, busca en la carpeta general
if not MyTycoon then
    local Tycoons = Workspace:FindFirstChild("Tycoons") or Workspace:FindFirstChild("Mansions")
    if Tycoons then
        for _, v in pairs(Tycoons:GetChildren()) do
            if v:FindFirstChild("Owner") and v.Owner.Value == LP then
                MyTycoon = v
                break
            end
        end
    end
end

-- CREAR MENU
local PlayerGui = LP.PlayerGui
if PlayerGui:FindFirstChild("MansionMenu") then PlayerGui.MansionMenu:Destroy() end

local Menu = Instance.new("ScreenGui")
Menu.Name = "MansionMenu"
Menu.Parent = PlayerGui

-- == BURBUJA REDONDA LOGO ==
local BtnMin = Instance.new("TextButton")
BtnMin.Size = UDim2.new(0, 50, 0, 50)
BtnMin.Position = UDim2.new(0.02, 0, 0.1, 0)
BtnMin.BackgroundColor3 = Color3.new(0, 0.4, 1)
BtnMin.BorderColor3 = Color3.new(1,1,1)
BtnMin.BorderSizePixel = 1
BtnMin.Text = "MT"
BtnMin.TextColor3 = Color3.new(1,1,1)
BtnMin.Font = Enum.Font.GothamBold
BtnMin.TextSize = 20
local c1 = Instance.new("UICorner", BtnMin)
c1.CornerRadius = UDim.new(1,0)
BtnMin.Parent = Menu

-- == MARCO PRINCIPAL ==
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 260, 0, 300)
Main.Position = UDim2.new(0.02, 0, 0.17, 0)
Main.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Main.BorderColor3 = Color3.new(0, 0.5, 1)
Main.BorderSizePixel = 1
Main.Draggable = true
Main.Active = true
local c2 = Instance.new("UICorner", Main)
c2.CornerRadius = UDim.new(0,10)
Main.Parent = Menu

-- TITULO
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "MANSION TYCOON"
Title.TextColor3 = Color3.new(1, 0.7, 0.2)
Title.Font = Enum.Font.FredokaOne
Title.TextSize = 14
Title.Parent = Main

-- BOTONES DE PESTAÑAS
local BtnInfo = Instance.new("TextButton")
BtnInfo.Size = UDim2.new(0.5, -2, 0, 25)
BtnInfo.Position = UDim2.new(0, 0, 1, -25)
BtnInfo.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
BtnInfo.BorderColor3 = Color3.new(1,1,1)
BtnInfo.BorderSizePixel = 1
local ci1 = Instance.new("UICorner", BtnInfo)
ci1.CornerRadius = UDim.new(0,6)
BtnInfo.Text = "INFO"
BtnInfo.TextColor3 = Color3.new(1,1,1)
BtnInfo.Font = Enum.Font.GothamBold
BtnInfo.TextSize = 12
BtnInfo.Parent = Main

local BtnMain = Instance.new("TextButton")
BtnMain.Size = UDim2.new(0.5, -2, 0, 25)
BtnMain.Position = UDim2.new(0.5, 2, 1, -25)
BtnMain.BackgroundColor3 = Color3.new(0.15,0.15,0.15)
BtnMain.BorderColor3 = Color3.new(1,1,1)
BtnMain.BorderSizePixel = 1
local ci2 = Instance.new("UICorner", BtnMain)
ci2.CornerRadius = UDim.new(0,6)
BtnMain.Text = "MAIN"
BtnMain.TextColor3 = Color3.new(1,1,1)
BtnMain.Font = Enum.Font.GothamBold
BtnMain.TextSize = 12
BtnMain.Parent = Main

-- == PESTAÑA INFO ==
local InfoFrame = Instance.new("ScrollingFrame")
InfoFrame.Size = UDim2.new(1, -20, 1, -65)
InfoFrame.Position = UDim2.new(0, 10, 0, 35)
InfoFrame.BackgroundTransparency = 1
InfoFrame.BorderSizePixel = 0
InfoFrame.ScrollBarThickness = 4
InfoFrame.CanvasSize = UDim2.new(0,0, 2, 0)
InfoFrame.Parent = Main

local Texto = Instance.new("TextLabel")
Texto.Size = UDim2.new(1, 0, 1, 0)
Texto.BackgroundTransparency = 1
Texto.Text = [[
Creador: JoseAngel_Blox
Adaptado para: Mansion Tycoon

Manual:
hola a todos aquí un
tutorial fácil de como
usar el script bueno
como puedes ver en la
parte de abajo tiene
dos botones en info es
aqui donde estas leyendo
esto y en la segunda
opción donde dice Main
están las funciones.

1) auto recojer dinero:
Busca el buzón o zona
de cobro y recolecta.

2) auto construir:
Esta opcion te compra
los botones verdes y
mejoras automáticamente.

3) velocidad:
Para correr mas rapido.

Disfruta el script!
]]
Texto.TextColor3 = Color3.new(1,1,1)
Texto.Font = Enum.Font.Gotham
Texto.TextSize = 11
Texto.TextWrapped = true
Texto.Parent = InfoFrame

-- PESTAÑA MAIN
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(1, -20, 1, -65)
MainFrame.Position = UDim2.new(0, 10, 0, 35)
MainFrame.BackgroundTransparency = 1
MainFrame.Visible = false
MainFrame.Parent = Main

-- VARIABLES
local CollectON = false
local BuyON = false
local SpeedON = false
local Visible = true

local ConnectionCollect = nil
local ConnectionBuy = nil

-- FUNCION PARA CREAR BOTONES
local function MakeBtn(name, pos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 38)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.new(0.15,0.15,0.15)
    btn.BorderColor3 = Color3.new(1,0,0)
    btn.BorderSizePixel = 2
    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0,8)
    btn.Text = name
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.Parent = MainFrame
    return btn
end

-- CREAR BOTONES
local Btn1 = MakeBtn("AUTO COLLECT", UDim2.new(0,0,0,0))
local Btn2 = MakeBtn("AUTO COMPRAR", UDim2.new(0,0,0,45))
local Btn3 = MakeBtn("VELOCIDAD", UDim2.new(0,0,0,90))

-- FUNCION MINIMIZAR
BtnMin.MouseButton1Click:Connect(function()
    Visible = not Visible
    Main.Visible = Visible
end)

-- CAMBIAR PESTAÑAS
BtnInfo.MouseButton1Click:Connect(function()
    InfoFrame.Visible = true
    MainFrame.Visible = false
    BtnInfo.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
    BtnMain.BackgroundColor3 = Color3.new(0.15,0.15,0.15)
end)

BtnMain.MouseButton1Click:Connect(function()
    InfoFrame.Visible = false
    MainFrame.Visible = true
    BtnInfo.BackgroundColor3 = Color3.new(0.15,0.15,0.15)
    BtnMain.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
end)

-- === AUTO COLLECT (BUSCA EL BUZON) ===
Btn1.MouseButton1Click:Connect(function()
    CollectON = not CollectON
    if CollectON then
        Btn1.Text = "AUTO COLLECT [ON]"
        Btn1.BorderColor3 = Color3.new(0,1,0)
        ConnectionCollect = RunService.Heartbeat:Connect(function()
            pcall(function()
                if MyTycoon then
                    -- Busca dentro de tu base lo que sea para cobrar
                    for _, obj in pairs(MyTycoon:GetDescendants()) do
                        if obj:IsA("Part") then
                            local name = string.lower(obj.Name)
                            if name:find("collect") or name:find("buzon") or name:find("drop") or name:find("money") then
                                firetouchinterest(obj, HRP, 0)
                                firetouchinterest(obj, HRP, 1)
                            end
                        end
                    end
                else
                    -- Si no encuentra base, busca en todo el mapa
                    for _, obj in pairs(Workspace:GetDescendants()) do
                        if obj:IsA("Part") then
                            local name = string.lower(obj.Name)
                            if name:find("collect") or name:find("buzon") or name:find("drop") then
                                firetouchinterest(obj, HRP, 0)
                                firetouchinterest(obj, HRP, 1)
                            end
                        end
                    end
                end
            end)
            task.wait(0.1)
        end)
    else
        Btn1.Text = "AUTO COLLECT"
        Btn1.BorderColor3 = Color3.new(1,0,0)
        if ConnectionCollect then ConnectionCollect:Disconnect() end
    end
end)

-- === AUTO COMPRAR (BUSCA BOTONES VERDES) ===
Btn2.MouseButton1Click:Connect(function()
    BuyON = not BuyON
    if BuyON then
        Btn2.Text = "AUTO COMPRAR [ON]"
        Btn2.BorderColor3 = Color3.new(0,1,0)
        ConnectionBuy = RunService.Heartbeat:Connect(function()
            pcall(function()
                if MyTycoon then
                    -- Busca TODO lo clicable dentro de TU base
                    for _, obj in pairs(MyTycoon:GetDescendants()) do
                        if obj:IsA("Part") or obj:IsA("MeshPart") then
                            -- Click en botones verdes
                            if obj.BrickColor.Name == "Bright green" or obj.BrickColor.Name == "Lime green" then
                                firetouchinterest(obj, HRP, 0)
                                firetouchinterest(obj, HRP, 1)
                            end
                            -- Click en cualquier boton
                            if obj:FindFirstChildOfClass("ClickDetector") then
                                obj.ClickDetector:MouseClick()
                            end
                        end
                    end
                end
            end)
            task.wait(0.2)
        end)
    else
        Btn2.Text = "AUTO COMPRAR"
        Btn2.BorderColor3 = Color3.new(1,0,0)
        if ConnectionBuy then ConnectionBuy:Disconnect() end
    end
end)

-- === VELOCIDAD ===
Btn3.MouseButton1Click:Connect(function()
    SpeedON = not SpeedON
    if SpeedON then
        Btn3.Text = "VELOCIDAD [ON]"
        Btn3.BorderColor3 = Color3.new(0,1,0)
        Hum.WalkSpeed = 70
    else
        Btn3.Text = "VELOCIDAD"
        Btn3.BorderColor3 = Color3.new(1,0,0)
        Hum.WalkSpeed = 16
    end
end)

print("✅ Script Mansion Tycoon cargado por JoseAngel_Blox")
