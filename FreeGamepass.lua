--[[
    SCRIPT HECHO POR TI | SIN LIBRERÍAS
    Compatible con Celular y PC
]]

local Player = game.Players.LocalPlayer
local PlayerGui = Player.PlayerGui
local TweenService = game:GetService("TweenService")

-- CREAR LA INTERFAZ VISUAL
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local UnlockBtn = Instance.new("TextButton")
local CloseBtn = Instance.new("TextButton")

-- PROPIEDADES DE LA INTERFAZ
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "CartolaV2"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderColor3 = Color3.fromRGB(0, 170, 255)
MainFrame.BorderSizePixel = 2
MainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 180)
MainFrame.Active = true
MainFrame.Draggable = true -- ¡IMPORTANTE! Para mover el menú con el dedo

Title.Name = "Titulo"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "CARTOLA V2"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20

UnlockBtn.Name = "BotonDesbloquear"
UnlockBtn.Parent = MainFrame
UnlockBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
UnlockBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
UnlockBtn.Size = UDim2.new(0.8, 0, 0, 45)
UnlockBtn.Font = Enum.Font.GothamBold
UnlockBtn.Text = "DESBLOQUEAR TODO"
UnlockBtn.TextColor3 = Color3.new(1,1,1)
UnlockBtn.TextSize = 16
UnlockBtn.ClipsDescendants = true

CloseBtn.Name = "BotonCerrar"
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
CloseBtn.Size = UDim2.new(0.8, 0, 0, 40)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "CERRAR"
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.TextSize = 16

-- FUNCIÓN PRINCIPAL (LA MAGIA)
local function DesbloquearTodo()
    pcall(function()
        -- Método 1: Enviar señal al servidor
        local args = {"Gamepasses", "OwnsAll", true}
        game:GetService("ReplicatedStorage"):WaitForChild("Brookhaven"):FireServer(unpack(args))
        
        -- Método 2: Forzar valores locales
        for _, v in pairs(PlayerGui:GetChildren()) do
            if v:FindFirstChild("Gamepasses") then
                for _, pass in pairs(v.Gamepasses:GetChildren()) do
                    pass.Value = true
                end
            end
        end
        
        -- Notificación
        game.StarterGui:SetCore("SendNotification", {
            Title = "✅ ÉXITO",
            Text = "Gamepass desbloqueados!",
            Duration = 3
        })
    end)
end

-- EVENTOS DE LOS BOTONES
UnlockBtn.MouseButton1Click:Connect(DesbloquearTodo)
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- EFECTO DE APARICIÓN (OPCIONAL)
MainFrame.Size = UDim2.new(0,0,0,0)
TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0,220,0,180)}):Play()

print("✅ Script Cargado Correctamente")

