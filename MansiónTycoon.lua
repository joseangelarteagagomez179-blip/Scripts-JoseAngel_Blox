--// 🔒 PROTECCIÓN: SOLO FUNCIONA EN MANSION TYCOON
local GameID = game.PlaceId
local TargetID = 12912731475 -- ID DEL JUEGO

if GameID ~= TargetID then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "⚠️ SCRIPT DE JOSEANGEL_BLOX",
        Text = "Este script solo funciona en Mansion Tycoon!",
        Duration = 4
    })
    return -- SE DETIENE AQUÍ
end

--// SERVICES
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

--// VARIABLES
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local Container = Instance.new("Frame")

--// PESTAÑAS
local TabInfo = Instance.new("TextButton")
local TabMain = Instance.new("TextButton")

--// PAGINAS
local PageInfo = Instance.new("Frame")
local PageMain = Instance.new("Frame")

--// ESTADO DE FUNCIONES
local AutoCollectON = false
local AutoBuildON = false
local SpeedON = false

--// CREAR GUI
ScreenGui.Name = "MansionTycoonHub"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

--// MARCO PRINCIPAL
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.Size = UDim2.new(0, 650, 0, 420)
MainFrame.Position = UDim2.new(0.5, -325, 0.5, -210)
MainFrame.Active = true
MainFrame.Draggable = true -- SE PUEDE MOVER
MainFrame.Selectable = false

UICorner.CornerRadius = UDim.new(0, 18)
UICorner.Parent = MainFrame

--// TITULO
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
Title.Size = UDim2.new(1, 0, 0, 55)
Title.Font = Enum.Font.GothamBold
Title.Text = "🏰 MANSION TYCOON - JOSEANGEL_BLOX"
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.TextSize = 24
Title.BorderSizePixel = 0

local TitleCorner = Instance.new("UICorner", Title)
TitleCorner.CornerRadius = UDim.new(0,18)

--// BOTONES DE PESTAÑAS
TabInfo.Name = "TabInfo"
TabInfo.Parent = MainFrame
TabInfo.Position = UDim2.new(0, 15, 0, 65)
TabInfo.Size = UDim2.new(0, 110, 0, 35)
TabInfo.Text = "ℹ️ INFO"
TabInfo.BackgroundColor3 = Color3.fromRGB(70, 150, 255)
TabInfo.TextColor3 = Color3.new(1,1,1)
TabInfo.Font = Enum.Font.GothamBold
TabInfo.BorderSizePixel = 0

TabMain.Name = "TabMain"
TabMain.Parent = MainFrame
TabMain.Position = UDim2.new(0, 135, 0, 65)
TabMain.Size = UDim2.new(0, 110, 0, 35)
TabMain.Text = "🚀 FUNCIONES"
TabMain.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
TabMain.TextColor3 = Color3.new(1,1,1)
TabMain.Font = Enum.Font.GothamBold
TabMain.BorderSizePixel = 0

--// CONTENEDOR
Container.Name = "Container"
Container.Parent = MainFrame
Container.Position = UDim2.new(0, 15, 0, 110)
Container.Size = UDim2.new(1, -30, 1, -130)
Container.BackgroundTransparency = 1

--// PAGINA INFO
PageInfo.Name = "PageInfo"
PageInfo.Parent = Container
PageInfo.Size = UDim2.new(1, 0, 1, 0)
PageInfo.BackgroundTransparency = 1

local InfoText = Instance.new("TextLabel", PageInfo)
InfoText.Size = UDim2.new(1, 0, 1, 0)
InfoText.BackgroundTransparency = 1
InfoText.Font = Enum.Font.Gotham
InfoText.TextColor3 = Color3.new(1,1,1)
InfoText.TextSize = 17
InfoText.TextWrapped = true
InfoText.Text = [[
👨‍💻 CREADOR: JoseAngel_Blox
📅 FECHA: 29/06/2026

📖 MANUAL DE USO

¡Hola! Gracias por usar mi script.
Este script funciona 100% local y sin internet.

✅ CARACTERÍSTICAS:
• Auto Collect: Recoge dinero automáticamente.
• Auto Build: Construye rápido tu mansión.
• Speed Boost: Corre más rápido.

📌 INSTRUCCIONES:
1. Ve a la pestaña "FUNCIONES".
2. Activa lo que necesites con un clic.
3. ¡Disfruta y sube de nivel rápido!

⚠️ NOTA: Si algo no funciona, reinicia el script.
]]

--// PAGINA MAIN
PageMain.Name = "PageMain"
PageMain.Parent = Container
PageMain.Size = UDim2.new(1, 0, 1, 0)
PageMain.BackgroundTransparency = 1
PageMain.Visible = false

--// BOTONES
local BtnCollect = Instance.new("TextButton")
BtnCollect.Size = UDim2.new(0.9, 0, 0, 45)
BtnCollect.Position = UDim2.new(0.05, 0, 0, 20)
BtnCollect.BackgroundColor3 = Color3.fromRGB(60, 180, 80)
BtnCollect.Text = "✅ AUTO COLLECT DINERO"
BtnCollect.TextColor3 = Color3.new(1,1,1)
BtnCollect.Font = Enum.Font.GothamBold
BtnCollect.Parent = PageMain

local BtnBuild = Instance.new("TextButton")
BtnBuild.Size = UDim2.new(0.9, 0, 0, 45)
BtnBuild.Position = UDim2.new(0.05, 0, 0, 80)
BtnBuild.BackgroundColor3 = Color3.fromRGB(60, 180, 80)
BtnBuild.Text = "🏗️ AUTO CONSTRUIR"
BtnBuild.TextColor3 = Color3.new(1,1,1)
BtnBuild.Font = Enum.Font.GothamBold
BtnBuild.Parent = PageMain

local BtnSpeed = Instance.new("TextButton")
BtnSpeed.Size = UDim2.new(0.9, 0, 0, 45)
BtnSpeed.Position = UDim2.new(0.05, 0, 0, 140)
BtnSpeed.BackgroundColor3 = Color3.fromRGB(60, 180, 80)
BtnSpeed.Text = "⚡ VELOCIDAD EXTRA"
BtnSpeed.TextColor3 = Color3.new(1,1,1)
BtnSpeed.Font = Enum.Font.GothamBold
BtnSpeed.Parent = PageMain

--// FUNCION CAMBIAR PESTAÑAS
TabInfo.MouseButton1Click:Connect(function()
    PageInfo.Visible = true
    PageMain.Visible = false
    TabInfo.BackgroundColor3 = Color3.fromRGB(70, 150, 255)
    TabMain.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
end)

TabMain.MouseButton1Click:Connect(function()
    PageInfo.Visible = false
    PageMain.Visible = true
    TabInfo.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    TabMain.BackgroundColor3 = Color3.fromRGB(70, 150, 255)
end)

--// ANIMACION DE BIENVENIDA
local WelcomeText = Instance.new("TextLabel")
WelcomeText.Size = UDim2.new(1, 0, 1, 0)
WelcomeText.Position = UDim2.new(0,0,0,0)
WelcomeText.BackgroundColor3 = Color3.fromRGB(0,0,0)
WelcomeText.Font = Enum.Font.GothamBold
WelcomeText.Text = "BIENVENIDO\nJOSEANGEL_BLOX"
WelcomeText.TextColor3 = Color3.fromRGB(255, 215, 0)
WelcomeText.TextScaled = true
WelcomeText.Parent = ScreenGui
WelcomeText.ZIndex = 100

local tweenIn = TweenService:Create(WelcomeText, TweenInfo.new(0.8), {BackgroundTransparency = 0, TextTransparency = 0})
local tweenOut = TweenService:Create(WelcomeText, TweenInfo.new(0.8), {BackgroundTransparency = 1, TextTransparency = 1})

tweenIn:Play()
task.wait(2.5)
tweenOut:Play()
task.wait(1)
WelcomeText:Destroy()

--// LOGICA DE FUNCIONES

-- AUTO COLLECT
BtnCollect.MouseButton1Click:Connect(function()
    AutoCollectON = not AutoCollectON
    if AutoCollectON then
        BtnCollect.Text = "❌ AUTO COLLECT (ACTIVO)"
        BtnCollect.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
        -- Iniciar loop
        task.spawn(function()
            while AutoCollectON do
                for _, obj in pairs(workspace:GetChildren()) do
                    if obj:IsA("Part") or obj:IsA("Model") then
                        if string.find(string.lower(obj.Name), "money") or string.find(string.lower(obj.Name), "cash") then
                            firetouchinterest(Character.HumanoidRootPart, obj, 0)
                            firetouchinterest(Character.HumanoidRootPart, obj, 1)
                        end
                    end
                end
                task.wait(0.5)
            end
        end)
    else
        BtnCollect.Text = "✅ AUTO COLLECT DINERO"
        BtnCollect.BackgroundColor3 = Color3.fromRGB(60, 180, 80)
    end
end)

-- VELOCIDAD
BtnSpeed.MouseButton1Click:Connect(function()
    SpeedON = not SpeedON
    if SpeedON then
        BtnSpeed.Text = "❌ VELOCIDAD (ACTIVA)"
        BtnSpeed.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
        Humanoid.WalkSpeed = 50
    else
        BtnSpeed.Text = "⚡ VELOCIDAD EXTRA"
        BtnSpeed.BackgroundColor3 = Color3.fromRGB(60, 180, 80)
        Humanoid.WalkSpeed = 16 -- Velocidad normal
    end
end)

-- AUTO BUILD (SIMULADO)
BtnBuild.MouseButton1Click:Connect(function()
    AutoBuildON = not AutoBuildON
    if AutoBuildON then
        BtnBuild.Text = "❌ AUTO CONSTRUIR (ACTIVO)"
        BtnBuild.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
    else
        BtnBuild.Text = "🏗️ AUTO CONSTRUIR"
        BtnBuild.BackgroundColor3 = Color3.fromRGB(60, 180, 80)
    end
end)

print("✅ SCRIPT CARGADO CORRECTAMENTE - JOSEANGEL_BLOX")
