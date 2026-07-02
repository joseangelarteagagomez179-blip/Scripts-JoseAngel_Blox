-- DETECTOR DE NOMBRES PARA ZAPIA
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BackgroundTransparency = 0.4
MainFrame.Position = UDim2.new(0.3, 0, 0.05, 0)
MainFrame.Size = UDim2.new(0, 400, 0, 100)
MainFrame.Active = true
MainFrame.Draggable = true

TextLabel.Parent = MainFrame
TextLabel.Size = UDim2.new(1, 0, 1, 0)
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 0) -- Color amarillo para que resalte
TextLabel.TextSize = 18
TextLabel.Text = "CAMINA SOBRE EL OBJETO\nPARA VER EL NOMBRE"
TextLabel.TextWrapped = true

-- Función que detecta lo que tocas
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Touched:Connect(function(part)
    local nombre = part.Name
    local padre = (part.Parent and part.Parent.Name or "Sin padre")
    local abuelo = (part.Parent and part.Parent.Parent and part.Parent.Parent.Name or "Sin abuelo")
    
    local info = "OBJETO: " .. nombre .. "\nCARPETA: " .. padre .. "\nGRUPO: " .. abuelo
    
    TextLabel.Text = info
    warn("Zapia Detectó: " .. nombre .. " | Carpeta: " .. padre) -- También sale en la consola (F9)
end)
