-- DETECTOR - Mansion Tycoon
-- Párate encima del buzón y los botones verdes

local player = game.Players.LocalPlayer
local rootPart = player.Character.HumanoidRootPart

-- GUI para mostrar resultados
local sg = Instance.new("ScreenGui", player.PlayerGui)
local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 400, 0, 500)
frame.Position = UDim2.new(0, 0, 0, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

local txt = Instance.new("TextLabel", frame)
txt.Size = UDim2.new(1, 0, 1, 0)
txt.BackgroundTransparency = 1
txt.TextColor3 = Color3.fromRGB(0, 255, 0)
txt.Font = Enum.Font.Gotham
txt.TextScaled = true
txt.TextXAlignment = Enum.TextXAlignment.Left
txt.TextYAlignment = Enum.TextYAlignment.Top

-- Busca todo lo que tenga TouchTransmitter cerca tuyo
game:GetService("RunService").Heartbeat:Connect(function()
    local result = "=== OBJETOS CERCANOS ===\n"
    local count = 0
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("TouchTransmitter") and v.Parent and v.Parent:IsA("BasePart") then
            local dist = (v.Parent.Position - rootPart.Position).Magnitude
            if dist < 20 then
                result = result .. "- " .. v.Parent.Name .. " (parent: " .. (v.Parent.Parent and v.Parent.Parent.Name or "?") .. ")\n"
                count = count + 1
            end
        end
    end
    if count == 0 then
        result = result .. "(ninguno cercano)\nAcercate al buzon o boton verde"
    end
    txt.Text = result
end)
