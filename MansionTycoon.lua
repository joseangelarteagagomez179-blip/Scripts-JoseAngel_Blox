local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/Database/main/UiLib"))()

local Window = Library:CreateWindow({
    Name = "Scripts JoseAngel_Blox",
    LoadingTitle = "Bienvenidos a Scripts JoseAngel_Blox",
    LoadingSubTitle = "Cargando...",
    Theme = "Default",
    Credit = "JoseAngel_Blox"
})

local TweenService = game:GetService("TweenService")
local PlayerGui = game.Players.LocalPlayer.PlayerGui

local LoadingGui = Instance.new("ScreenGui")
LoadingGui.Name = "LoadingAnimation"
LoadingGui.Parent = PlayerGui

local WelcomeText = Instance.new("TextLabel")
WelcomeText.Name = "WelcomeText"
WelcomeText.Parent = LoadingGui
WelcomeText.BackgroundTransparency = 1
WelcomeText.Position = UDim2.new(0.5, -200, 0.5, 0)
WelcomeText.Size = UDim2.new(0, 400, 0, 50)
WelcomeText.Font = Enum.Font.GothamBold
WelcomeText.TextColor3 = Color3.new(1, 1, 1)
WelcomeText.TextSize = 30
WelcomeText.Text = "Bienvenidos a Scripts JoseAngel_Blox"
WelcomeText.TextTransparency = 1

local TweenIn = TweenService:Create(WelcomeText, TweenInfo.new(1.2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
    TextTransparency = 0,
    Position = UDim2.new(0.5, -200, 0.5, -25)
})

local TweenOut = TweenService:Create(WelcomeText, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
    TextTransparency = 1,
    Position = UDim2.new(0.5, -200, 0.5, -100)
})

TweenIn:Play()
task.wait(2.5)
TweenOut:Play()
task.wait(0.5)
LoadingGui:Destroy()

Window:CreateSection({Name = "📄 Información"})

local InfoOpen = false
local InfoButton = Window:CreateButton({
    Name = "Ver Datos del Script ▶",
    Callback = function()
        InfoOpen = not InfoOpen
        if InfoOpen then
            Window:CreateLabel({Text = "Nombre del Creador: JoseAngel_Blox"})
            Window:CreateLabel({Text = "Fecha de lanzamiento: 29/06/2026"})
            InfoButton.Name = "Ver Datos del Script ▼"
        else
            for i,v in pairs(Window.Sections.Informacion.Elements) do
                if v.Type == "Label" then
                    v:Destroy()
                end
            end
            InfoButton.Name = "Ver Datos del Script ▶"
        end
    end
})

Window:CreateSection({Name = "⚡ Main"})

Window:CreateToggle({
    Name = "Auto Collect",
    Current = false,
    Flag = "autocollect",
    Callback = function(Value)
        getgenv().AutoCollect = Value
    end
})

Window:CreateToggle({
    Name = "Auto Buy",
    Current = false,
    Flag = "autobuy",
    Callback = function(Value)
        getgenv().AutoBuy = Value
    end
})

Window:CreateToggle({
    Name = "Auto Upgrade",
    Current = false,
    Flag = "autoupgrade",
    Callback = function(Value)
        getgenv().AutoUpgrade = Value
    end
})

Window:CreateToggle({
    Name = "Auto Build",
    Current = false,
    Flag = "autobuild",
    Callback = function(Value)
        getgenv().AutoBuild = Value
    end
})

Window:CreateToggle({
    Name = "WalkSpeed",
    Current = false,
    Flag = "speed",
    Callback = function(Value)
        getgenv().SpeedEnabled = Value
        if Value then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
        else
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
})

Window:CreateToggle({
    Name = "JumpPower",
    Current = false,
    Flag = "jump",
    Callback = function(Value)
        getgenv().JumpEnabled = Value
        if Value then
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = 150
        else
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
        end
    end
})

Window:CreateToggle({
    Name = "Noclip",
    Current = false,
    Flag = "noclip",
    Callback = function(Value)
        getgenv().Noclip = Value
    end
})

Window:CreateToggle({
    Name = "Esp Cajas",
    Current = false,
    Flag = "espboxes",
    Callback = function(Value)
        getgenv().EspBoxes = Value
    end
})

Window:CreateToggle({
    Name = "Auto Construir Casa",
    Current = false,
    Flag = "autohouse",
    Callback = function(Value)
        getgenv().AutoHouse = Value
    end
})

Window:CreateToggle({
    Name = "Auto Comprar Todo",
    Current = false,
    Flag = "autobuyall",
    Callback = function(Value)
        getgenv().AutoBuyAll = Value
    end
})

spawn(function()
    while task.wait() do
        if getgenv().AutoCollect then
            for _, v in pairs(game.Workspace:GetChildren()) do
                if v:FindFirstChild("Money") then
                    fireclickdetector(v.Money.ClickDetector)
                end
            end
        end
        
        if getgenv().Noclip then
            for _, part in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)
