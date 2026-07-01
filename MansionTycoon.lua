-- DETECTOR COLLECTOR
local player = game.Players.LocalPlayer
local rootPart = player.Character.HumanoidRootPart

local sg = Instance.new("ScreenGui", player.PlayerGui)
local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 430, 0, 580)
frame.Position = UDim2.new(0, 0, 0, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

local txt = Instance.new("TextLabel", frame)
txt.Size = UDim2.new(1, -5, 1, 0)
txt.Position = UDim2.new(0, 5, 0, 0)
txt.BackgroundTransparency = 1
txt.TextColor3 = Color3.fromRGB(0, 255, 0)
txt.Font = Enum.Font.Gotham
txt.TextSize = 12
txt.TextXAlignment = Enum.TextXAlignment.Left
txt.TextYAlignment = Enum.TextYAlignment.Top
txt.TextWrapped = true

game:GetService("RunService").Heartbeat:Connect(function()
    local result = "OBJETOS cerca (20 studs):\n\n"
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            local dist = (v.Position - rootPart.Position).Magnitude
            if dist < 20 then
                local path = v.Name
                local p = v.Parent
                while p and p ~= workspace do
                    path = p.Name .. " > " .. path
                    p = p.Parent
                end
                result = result .. path .. "\n"
            end
        end
    end
    txt.Text = result
end)
