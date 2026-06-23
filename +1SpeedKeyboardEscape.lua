-- FREE SHOP LOGIC (ACTUALIZADO CON LO QUE VEMOS)
TreadmillsToggle.MouseButton1Click:Connect(function()
    AllTreadmillsUnlocked = not AllTreadmillsUnlocked
    if AllTreadmillsUnlocked then
        TreadmillsStatus.Text = "ON"
        TreadmillsStatus.TextColor3 = Color3.fromRGB(50, 255, 50)
        
        -- BUSCA EN ReplicatedStorage ESPECIFICAMENTE
        local RS = game:GetService("ReplicatedStorage")
        for _, v in pairs(RS:GetDescendants()) do
            if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                -- Intenta disparar todo lo que parezca compra o desbloqueo
                spawn(function()
                    pcall(function()
                        v:FireServer()
                        v:InvokeServer()
                    end)
                end)
            end
        end
        print("Desbloqueando caminadoras...")
    else
        TreadmillsStatus.Text = "OFF"
        TreadmillsStatus.TextColor3 = Color3.fromRGB(255, 50, 50)
    end
end)

TrailsToggle.MouseButton1Click:Connect(function()
    AllTrailsUnlocked = not AllTrailsUnlocked
    if AllTrailsUnlocked then
        TrailsStatus.Text = "ON"
        TrailsStatus.TextColor3 = Color3.fromRGB(50, 255, 50)
        
        local RS = game:GetService("ReplicatedStorage")
        for _, v in pairs(RS:GetDescendants()) do
            if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                spawn(function()
                    pcall(function()
                        v:FireServer()
                        v:InvokeServer()
                    end)
                end)
            end
        end
        print("Desbloqueando rastros...")
    else
        TrailsStatus.Text = "OFF"
        TrailsStatus.TextColor3 = Color3.fromRGB(255, 50, 50)
    end
end)

AurasToggle.MouseButton1Click:Connect(function()
    AllAurasUnlocked = not AllAurasUnlocked
    if AllAurasUnlocked then
        AurasStatus.Text = "ON"
        AurasStatus.TextColor3 = Color3.fromRGB(50, 255, 50)
        
        local RS = game:GetService("ReplicatedStorage")
        for _, v in pairs(RS:GetDescendants()) do
            if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                spawn(function()
                    pcall(function()
                        v:FireServer()
                        v:InvokeServer()
                    end)
                end)
            end
        end
        print("Desbloqueando auras...")
    else
        AurasStatus.Text = "OFF"
        AurasStatus.TextColor3 = Color3.fromRGB(255, 50, 50)
    end
end)
