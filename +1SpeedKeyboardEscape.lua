--// Services
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

--// Variables
local AutoFarmEnabled = false
local AutoFarmLoop = nil

--// Crear GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local UnlockBtn = Instance.new("TextButton")
local FarmBtn = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

--// Propiedades de la GUI
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "WalkerScriptGUI"

--// Marco Principal
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MainFrame.Size = UDim2.new(0, 280, 0, 220)
MainFrame.Position = UDim2.new(0.4, 0, 0.3, 0)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true

--// Esquinas Redondeadas
UICorner.Parent = MainFrame
UICorner.CornerRadius = UDim.new(0, 15)

--// Título
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0.2, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "UNLOCKED WALKERS"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20

--// Botón 1: Desbloquear Todo
UnlockBtn.Parent = MainFrame
UnlockBtn.BackgroundColor3 = Color3.fromRGB(70, 150, 255)
UnlockBtn.Size = UDim2.new(0.8, 0, 0.25, 0)
UnlockBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
UnlockBtn.Font = Enum.Font.GothamBold
UnlockBtn.Text = "🔓 Unlock All Walkers"
UnlockBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
UnlockBtn.TextSize = 16
UICorner:Clone().Parent = UnlockBtn

--// Botón 2: Auto Farm
FarmBtn.Parent = MainFrame
FarmBtn.BackgroundColor3 = Color3.fromRGB(255, 90, 90)
FarmBtn.Size = UDim2.new(0.8, 0, 0.25, 0)
FarmBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
FarmBtn.Font = Enum.Font.GothamBold
FarmBtn.Text = "⚡ Auto Farm: OFF"
FarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmBtn.TextSize = 16
UICorner:Clone().Parent = FarmBtn

--// ✅ FUNCIÓN MEJORADA: Búsqueda Total
local function UnlockAll()
    -- BUSCAR EN TODOS LADOS
    local Carpetas = {
        game:GetService("Workspace"):FindFirstChild("Walkers"),
        game:GetService("Workspace"):FindFirstChild("Treadmills"),
        game:GetService("Workspace"):FindFirstChild("Machines"),
        game:GetService("Workspace"):FindFirstChild("Gym"),
        game:GetService("Workspace"):FindFirstChild("Items")
    }

    local Encontrado = false

    for _, Carpeta in pairs(Carpetas) do
        if Carpeta then
            for _, Objeto in pairs(Carpeta:GetChildren()) do
                -- INTENTAR COMPRAR DE TODAS LAS FORMAS POSIBLES
                fireproximityprompt(Objeto) -- Método directo y potente
                if Objeto:FindFirstChild("BuyPrompt") then Objeto.BuyPrompt:FireServer() end
                if Objeto:FindFirstChild("Purchase") then Objeto.Purchase:FireServer() end
                if Objeto:FindFirstChild("Interact") then Objeto.Interact:FireServer() end

                -- FORZAR QUE DIGA QUE ES TUYO
                for _, Valor in pairs(Objeto:GetChildren()) do
                    if Valor:IsA("BoolValue") or Valor:IsA("IntValue") then
                        Valor.Value = true
                    end
                end
                Encontrado = true
            end
        end
    end

    if Encontrado then
        UnlockBtn.Text = "✅ DESBLOQUEADO!"
    else
        UnlockBtn.Text = "❌ BUSCANDO..."
    end

    wait(1)
    UnlockBtn.Text = "🔓 Unlock All Walkers"
end

--// ✅ Auto Farm (Funciona siempre)
local function ToggleAutoFarm()
    AutoFarmEnabled = not AutoFarmEnabled
    if AutoFarmEnabled then
        FarmBtn.Text = "⚡ Auto Farm: ON"
        FarmBtn.BackgroundColor3 = Color3.fromRGB(80, 220, 100)
        AutoFarmLoop = spawn(function()
            while AutoFarmEnabled do
                local Character = Player.Character
                if Character then
                    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                    if Humanoid then
                        Humanoid.WalkSpeed = 1000
                    end
                end
                wait(0.1)
            end
        end)
    else
        FarmBtn.Text = "⚡ Auto Farm: OFF"
        FarmBtn.BackgroundColor3 = Color3.fromRGB(255, 90, 90)
        local Character = Player.Character
        if Character then
            local Humanoid = Character:FindFirstChildOfClass("Humanoid")
            if Humanoid then
                Humanoid.WalkSpeed = 16
            end
        end
        if AutoFarmLoop then
            AutoFarmLoop:Disconnect()
        end
    end
end

--// Eventos
UnlockBtn.MouseButton1Click:Connect(UnlockAll)
FarmBtn.MouseButton1Click:Connect(ToggleAutoFarm)

--// Animación
MainFrame.Size = UDim2.new(0, 0, 0, 0)
local TweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local Goal = {Size = UDim2.new(0, 280, 0, 220)}
local Tween = TweenService:Create(MainFrame, TweenInfo, Goal)
Tween:Play()

print("✅ Script Cargado - Unlocked Walkers v3")
