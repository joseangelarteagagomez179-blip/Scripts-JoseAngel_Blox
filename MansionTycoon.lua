-- // Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

-- // Variables
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- // Settings (Puedes modificar los tiempos si quieres)
local Settings = {
    AutoFarm = true,
    AutoBuy = true,
    AntiAFK = true,
    DelayFarm = 0.1, -- Tiempo entre cada recolección
    DelayBuy = 0.5   -- Tiempo entre cada compra
}

-- // Funciones Auxiliares (Manejo de errores)
local function SafeWaitForChild(parent, childName, timeout)
    timeout = timeout or 5
    local found = nil
    local startTime = tick()
    while not found and tick() - startTime < timeout do
        found = parent:FindFirstChild(childName)
        task.wait()
    end
    return found
end

-- // 1. AUTO FARM
if Settings.AutoFarm then
    task.spawn(function()
        while task.wait(Settings.DelayFarm) do
            -- Buscamos los Givers/Dispensers de dinero dentro de la base
            for _, obj in pairs(workspace:GetChildren()) do
                if obj.Name:lower():find("giver") or obj.Name:lower():find("collect") or obj.Name:lower():find("money") then
                    -- Verificamos que sea parte de nuestro tycoon
                    if obj:IsA("Part") or obj:IsA("MeshPart") then
                        -- Simulamos el toque
                        firetouchinterest(HumanoidRootPart, obj, 0)
                        firetouchinterest(HumanoidRootPart, obj, 1)
                    end
                end
            end
        end
    end)
end

-- // 2. AUTO BUY MEJORAS
if Settings.AutoBuy then
    task.spawn(function()
        while task.wait(Settings.DelayBuy) do
            local buttonsToBuy = {}
            
            -- Buscamos todos los botones de compra
            for _, button in pairs(workspace:GetChildren()) do
                if button:IsA("Part") and (button.Name:lower():find("buy") or button.Name:lower():find("upgrade")) then
                    table.insert(buttonsToBuy, button)
                end
            end
            
            -- Intentamos clickearlos
            for _, btn in pairs(buttonsToBuy) do
                if btn then
                    firetouchinterest(HumanoidRootPart, btn, 0)
                    firetouchinterest(HumanoidRootPart, btn, 1)
                    task.wait(0.1) -- Pequeña pausa para no saturar
                end
            end
        end
    end)
end

-- // 3. ANTI AFK
if Settings.AntiAFK then
    LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
        print("[AntiAFK] Activado - Evitando desconexión...")
    end)
end

-- // 4. PROTECCIÓN Y RECONEXIÓN DE PERSONAJE
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
end)

print("====================================")
print("🎮 MEGA MANSION TYCOON SCRIPT LOADED")
print("✅ AutoFarm: Activado")
print("✅ AutoBuy: Activado")
print("✅ AntiAFK: Activado")
print("====================================")
