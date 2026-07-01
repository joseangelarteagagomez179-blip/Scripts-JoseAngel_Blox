-- DETECTOR DE BOTONES
local player = game.Players.LocalPlayer
local rootPart = player.Character.HumanoidRootPart

local sg = Instance.new("ScreenGui", player.PlayerGui)
local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 420, 0, 550)
frame.Position = UDim2.new(0, 0, 0, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

local txt = Instance.new("TextLabel", frame)
txt.Size = UDim2.new(1, -5, 1, 0)
txt.Position = UDim2.new(0, 5, 0, 0)
txt.BackgroundTransparency = 1
txt.TextColor3 = Color3.fromRGB(0, 255, 0)
txt.Font = Enum.Font.Gotham
txt.TextSize = 13
txt.TextXAlignment = Enum.TextXAlignment.Left
txt.TextYAlignment = Enum.TextYAlignment.Top
txt.TextWrapped = true

game:GetService("RunService").Heartbeat:Connect(function()
    local result = "BOTONES TOUCH cerca (50 studs):\n"
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and v.Name == "Touch" then
            local dist = (v.Position - rootPart.Position).Magnitude
            if dist < 50 then
                local p = v.Parent
                -- Muestra nombre del padre y sus valores/hijos
                local info = "TOUCH > " .. (p and p.Name or "?") .. " | "
                if p then
                    for _, child in pairs(p:GetChildren()) do
                        info = info .. child.Name .. "(" .. child.ClassName .. ") "
                    end
                end
                result = result .. info .. "\n"
            end
        end
    end
    txt.Text = result
end)
