-- [[ ZAPIA SUPREME TYCOON - VERSION UNIVERSAL ]] --
-- Copia este código completo en tu ejecutor.

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function getMyTycoon()
    local folders = {workspace:FindFirstChild("Tycoons"), workspace:FindFirstChild("Plots"), workspace}
    for _, folder in ipairs(folders) do
        if folder then
            for _, t in ipairs(folder:GetChildren()) do
                local owner = t:FindFirstChild("Owner") or t:FindFirstChild("Player")
                if owner and (owner.Value == player or owner.Value == player.Name) then
                    return t
                end
            end
        end
    end
    return nil
end

spawn(function()
    while task.wait(0.5) do
        local tycoon = getMyTycoon()
        if tycoon then
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                -- RECOLECTAR
                local coll = tycoon:FindFirstChild("Collector") or tycoon:FindFirstChild("Essentials")
                if coll then
                    local pad = coll:FindFirstChild("Pad") or coll:FindFirstChild("TouchPart") or coll:FindFirstChild("Hitbox")
                    if pad then firetouchinterest(root, pad, 0); firetouchinterest(root, pad, 1) end
                end
                -- COMPRAR
                local btns = tycoon:FindFirstChild("Buttons") or tycoon:FindFirstChild("Purchases")
                if btns then
                    for _, b in ipairs(btns:GetChildren()) do
                        local h = b:FindFirstChild("Head") or b:FindFirstChild("TouchPart")
                        if h and h.Transparency < 0.5 and not (b:FindFirstChild("Gamepass") or b.Name:lower():find("vip")) then
                            root.CFrame = h.CFrame
                            task.wait(0.1)
                        end
                    end
                end
            end
        end
    end
end)

-- Anti-AFK
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    task.wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

print("✅ Zapia Universal Activado")
