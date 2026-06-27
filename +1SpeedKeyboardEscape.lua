-- Servicios
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- Variables de control
local AutoFarmEnabled = false
local AutoWinEnabled = false
local Connections = {}

-- =============================================
-- CREAR INTERFAZ (Cuadrada con esquinas redondas)
-- =============================================
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local BtnAutoFarm = Instance.new("TextButton")
local BtnAutoWin = Instance.new("TextButton")
local BtnUnlockTreads = Instance.new("TextButton")

-- Propiedades de la GUI
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Marco Principal (Cuadrado con esquinas redondas)
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 280, 0, 320) -- Tamaño cuadrado
MainFrame.Active = true
MainFrame.Draggable = true -- Para mover la ventana

-- Esquinas Redondas
UICorner.Parent = MainFrame
UICorner.CornerRadius = UDim.new(0, 14) -- Aquí ajustas lo redondo

-- Título
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "⚡ HOSHI HUB ⚡"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20

-- Botón Auto Farm
BtnAutoFarm.Name = "BtnAutoFarm"
BtnAutoFarm.Parent = MainFrame
BtnAutoFarm.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
BtnAutoFarm.BorderSizePixel = 0
BtnAutoFarm.Position = UDim2.new(0.08, 0, 0.2, 0)
BtnAutoFarm.Size = UDim2.new(0.84, 0, 0, 45)
BtnAutoFarm.Font = Enum.Font.Gotham
BtnAutoFarm.Text = "▶️ AUTO FARM"
BtnAutoFarm.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnAutoFarm.TextSize = 16
local corner1 = Instance.new("UICorner", BtnAutoFarm)
corner1.CornerRadius = UDim.new(0,8)

-- Botón Auto Win
BtnAutoWin.Name = "BtnAutoWin"
BtnAutoWin.Parent = MainFrame
BtnAutoWin.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
BtnAutoWin.BorderSizePixel = 0
BtnAutoWin.Position = UDim2.new(0.08, 0, 0.4, 0)
BtnAutoWin.Size = UDim2.new(0.84, 0, 0, 45)
BtnAutoWin.Font = Enum.Font.Gotham
BtnAutoWin.Text = "▶️ AUTO WIN"
BtnAutoWin.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnAutoWin.TextSize = 16
local corner2 = Instance.new("UICorner", BtnAutoWin)
corner2.CornerRadius = UDim.new(0,8)

-- Botón Desbloquear Cintas
BtnUnlockTreads.Name = "BtnUnlockTreads"
BtnUnlockTreads.Parent = MainFrame
BtnUnlockTreads.BackgroundColor3 = Color3.fromRGB(80, 50, 120)
BtnUnlockTreads.BorderSizePixel = 0
BtnUnlockTreads.Position = UDim2.new(0.08, 0, 0.6, 0)
BtnUnlockTreads.Size = UDim2.new(0.84, 0, 0, 45)
BtnUnlockTreads.Font = Enum.Font.GothamBold
BtnUnlockTreads.Text = "💎 CINTAS GRATIS"
BtnUnlockTreads.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnUnlockTreads.TextSize = 16
local corner3 = Instance.new("UICorner", BtnUnlockTreads)
corner3.CornerRadius = UDim.new(0,8)

-- =============================================
-- FUNCIONES
-- =============================================

-- 🔓 Función: Desbloquear todas las cintas
local function UnlockAllTreadmills()
    pcall(function()
        -- Intenta buscar en diferentes lugares donde el juego guarda los datos
        local args = {
            [1] = "Purchase",
            [2] = "AllTreadmills"
        }
        -- O busca los valores locales
        for _, v in pairs(game:GetService("Workspace"):GetChildren()) do
            if v.Name:lower():find("tread") or v.Name:lower():find("buy") then
                if v:FindFirstChild("Locked") then
                    v.Locked.Value = false
                end
                if v:FindFirstChild("Price") then
                    v.Price.Value = 0
                end
            end
        end
        -- Busca en PlayerGui también
        local Gui = Player.PlayerGui
        for _, ui in pairs(Gui:GetChildren()) do
            if ui:FindFirstChild("Treadmills", true) then
                for _, item in pairs(ui.Treadmills:GetChildren()) do
                    if item:FindFirstChild("Locked") then item.Locked.Value = false end
                    if item:FindFirstChild("Owned") then item.Owned.Value = true end
                end
            end
        end
        BtnUnlockTreads.Text = "✅ DESBLOQUEADO!"
        BtnUnlockTreads.BackgroundColor3 = Color3.fromRGB(30, 130, 60)
        wait(2)
        BtnUnlockTreads.Text = "💎 CINTAS GRATIS"
        BtnUnlockTreads.BackgroundColor3 = Color3.fromRGB(80, 50, 120)
    end)
end

-- ⚡ Función: Auto Farm
local function ToggleAutoFarm()
    AutoFarmEnabled = not AutoFarmEnabled
    if AutoFarmEnabled then
        BtnAutoFarm.Text = "⏸️ AUTO FARM (ON)"
        BtnAutoFarm.BackgroundColor3 = Color3.fromRGB(120, 30, 30)
        -- Loop de farm
        spawn(function()
            while AutoFarmEnabled do
                wait(0.1)
                -- Simular presionar teclas o caminar
                if Humanoid then
                    Humanoid.WalkSpeed = 100 -- Velocidad maxima
                end
                -- Click en objetos o teclas
                Mouse.hit = Vector3.new(Mouse.hit.X, Mouse.hit.Y, Mouse.hit.Z + 5)
            end
        end)
    else
        BtnAutoFarm.Text = "▶️ AUTO FARM"
        BtnAutoFarm.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        if Humanoid then Humanoid.WalkSpeed = 16 end
    end
end

-- 🏁 Función: Auto Win
local function ToggleAutoWin()
    AutoWinEnabled = not AutoWinEnabled
    if AutoWinEnabled then
        BtnAutoWin.Text = "⏸️ AUTO WIN (ON)"
        BtnAutoWin.BackgroundColor3 = Color3.fromRGB(120, 30, 30)
        spawn(function()
            while AutoWinEnabled do
                wait()
                -- Teletransportarse o caminar directo al final
                local EndPart = workspace:FindFirstChild("Finish") or workspace:FindFirstChild("End") or workspace:FindFirstChild("Win")
                if EndPart then
                    Character:SetPrimaryPartCFrame(CFrame.new(EndPart.Position + Vector3.new(0,3,0)))
                end
            end
        end)
    else
        BtnAutoWin.Text = "▶️ AUTO WIN"
        BtnAutoWin.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    end
end

-- =============================================
-- CONECTAR BOTONES
-- =============================================
BtnAutoFarm.MouseButton1Click:Connect(ToggleAutoFarm)
BtnAutoWin.MouseButton1Click:Connect(ToggleAutoWin)
BtnUnlockTreads.MouseButton1Click:Connect(UnlockAllTreadmills)

print("✅ Script Cargado Correctamente!")
