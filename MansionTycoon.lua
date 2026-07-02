-- [[ Detector de Nombres para Mansión Tycoon ]] --
-- Creador: JoseAngel_Blox

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local LogLabel = Instance.new("TextLabel")

ScreenGui.Parent = game.CoreGui
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 320, 0, 120)
MainFrame.Position = UDim2.new(0.5, -160, 0.05, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

LogLabel.Parent = MainFrame
LogLabel.Size = UDim2.new(1, -20, 1, -20)
LogLabel.Position = UDim2.new(0, 10, 0, 10)
LogLabel.Text = "CAMINA SOBRE EL RECOLECTOR O UN BOTÓN..."
LogLabel.TextColor3 = Color3.new(0, 1, 0)
LogLabel.BackgroundTransparency = 1
LogLabel.TextWrapped = true
LogLabel.Font = Enum.Font.GothamMedium

-- Detectar qué tocas
game.Players.LocalPlayer.Character.HumanoidRootPart.Touched:Connect(function(hit)
    local name = hit.Name
    local parent = hit.Parent.Name
    LogLabel.Text = "OBJETO: " .. name .. "\nPADRE: " .. parent .. "\n\n¡Dime estos nombres!"
end)
