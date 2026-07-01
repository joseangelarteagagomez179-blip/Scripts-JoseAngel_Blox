-- DETECTOR v2 - muestra el contenido de ButtonGui
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
    local result = "BOTONES (30 studs):\n"
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Name == "Touch" then
            local dist = (v.Position - rootPart.Position).Magnitude
            if dist < 30 then
                local p = v.Parent
                local info = "[" .. (p and p.Name or "?") .. "]\n"
                if p then
                    for _, child in pairs(p:GetChildren()) do
                        if child.ClassName == "ObjectValue" or child.ClassName == "NumberValue" 
                        or child.ClassName == "StringValue" or child.ClassName == "BoolValue"
                        or child.ClassName == "IntValue" then
                            local val = tostring(child.Value)
                            info = info .. "  " .. child.Name .. "=" .. val .. "\n"
                        elseif child.Name == "ButtonGui" then
                            -- Entra adentro del ButtonGui
                            for _, sub in pairs(child:GetChildren()) do
                                local val2 = tostring(pcall(function() return sub.Value end) and sub.Value or "?")
                                info = info .. "  ButtonGui>" .. sub.Name .. "(" .. sub.ClassName .. ")=" .. val2 .. "\n"
                            end
                        end
                    end
                end
                result = result .. info .. "\n"
            end
        end
    end
    txt.Text = result
end)
