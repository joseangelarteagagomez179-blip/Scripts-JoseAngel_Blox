--[[
    SCRIPT PARA MANSION TYCOON - Delta Executor
    Automatiza colección de dinero, compras y mejoras
]]

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- ========== CONFIGURACIÓN ==========
local CONFIG = {
    AutoCollect = true,        -- Recolectar dinero automático
    AutoBuyTiers = true,       -- Comprar mejoras de dinero
    AutoDoubleCash = true,     -- Usar doble dinero
    AutoBuyCustoms = true,     -- Comprar personalizaciones
    AutoCloseGUI = true,       -- Cerrar GUIs molestas
    CollectInterval = 0.5,     -- Segundos entre colecciones
    BuyInterval = 2,           -- Segundos entre compras
}

-- ========== RUTAS DE OBJETOS (de tu consola) ==========
local RUTAS = {
    -- Botones de dinero
    MoneyTier5 = "Workspace.Tycoons.Plot1.TycoonB.Mansion.GlobalMoneyButtons.MoneyTier5",
    MoneyTier3 = "Workspace.Tycoons.Plot1.TycoonB.Mansion.GlobalMoneyButtons.MoneyTier3",
    DoubleCash = "Workspace.Tycoons.Plot1.TycoonB.Mansion.GlobalButtons.DoubleCash",
    CashToCollect = "Workspace.Tycoons.Plot1.TycoonB.Mansion.Collectors.CollectorCollectorCu.1.MainFrame.CashToCollect",
    
    -- Botones de GUI
    CloseButton = "Players.joseangel1071.PlayerGui.MansionCustomizerGui.TextureEditor.CloseButton",
    TryButton = "Players.joseangel1071.PlayerGui.MansionCustomizerGui.TextureEditor.ItemEttons.Frame.Try",
    BuyButton = "Players.joseangel1071.PlayerGui.MansionCustomizerGui.TextureEditor.ItemEttons.Frame.Buy",
    ResetAll = "Players.joseangel1071.PlayerGui.MansionCustomizerGui.TextureEditor.ItemEttons.Frame.ResetAll",
}

-- ========== FUNCIÓN PARA OBTENER OBJETO POR RUTA ==========
local function getObject(ruta)
    local partes = {}
    for parte in string.gmatch(ruta, "[^%.]+") do
        table.insert(partes, parte)
    end
    
    local objeto = game
    for i, parte in ipairs(partes) do
        if objeto then
            objeto = objeto:FindFirstChild(parte)
        else
            break
        end
    end
    return objeto
end

-- ========== FUNCIÓN PARA HACER CLICK SEGURO ==========
local function clickObject(objeto)
    if not objeto then return false end
    
    -- Intentar diferentes métodos de click
    local success, err = pcall(function()
        if objeto:IsA("GuiButton") or objeto:IsA("ImageButton") or objeto:IsA("TextButton") then
            objeto:Click()
        elseif objeto:IsA("BasePart") and objeto:FindFirstChild("ClickDetector") then
            objeto.ClickDetector:FireClick(player.Character and player.Character:FindFirstChild("HumanoidRootPart") or player.Character)
        elseif objeto:IsA("Model") then
            -- Buscar ClickDetector en el modelo
            for _, child in ipairs(objeto:GetDescendants()) do
                if child:IsA("ClickDetector") then
                    child:FireClick(player.Character and player.Character:FindFirstChild("HumanoidRootPart") or player.Character)
                    break
                end
            end
        elseif objeto:IsA("ScreenGui") then
            -- Buscar botones dentro de la GUI
            for _, child in ipairs(objeto:GetDescendants()) do
                if child:IsA("GuiButton") or child:IsA("ImageButton") or child:IsA("TextButton") then
                    child:Click()
                    break
                end
            end
        else
            -- Simular click con input
            local position = objeto.AbsolutePosition or Vector2.new(0, 0)
            local size = objeto.AbsoluteSize or Vector2.new(100, 50)
            local center = position + size / 2
            local args = {
                [1] = Enum.UserInputType.MouseButton1,
                [2] = Vector2.new(center.X, center.Y),
                [3] = 0,
                [4] = false,
                [5] = 1,
            }
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(center.X, center.Y, 1, true, game, 1)
            task.wait(0.05)
            game:GetService("VirtualInputManager"):SendMouseButtonEvent(center.X, center.Y, 1, false, game, 1)
        end
    end)
    return success
end

-- ========== FUNCIÓN PARA RECOLECTAR DINERO ==========
local function collectCash()
    local collector = getObject(RUTAS.CashToCollect)
    if collector then
        clickObject(collector)
        return true
    end
    return false
end

-- ========== FUNCIÓN PARA COMPRAR MEJORAS ==========
local function buyTier(tier)
    local ruta = tier == 5 and RUTAS.MoneyTier5 or RUTAS.MoneyTier3
    local boton = getObject(ruta)
    if boton and boton.Visible and boton.Active then
        clickObject(boton)
        return true
    end
    return false
end

-- ========== FUNCIÓN PARA ACTIVAR DOBLE DINERO ==========
local function useDoubleCash()
    local boton = getObject(RUTAS.DoubleCash)
    if boton and boton.Visible and boton.Active then
        clickObject(boton)
        return true
    end
    return false
end

-- ========== FUNCIÓN PARA CERRAR GUIs ==========
local function closeGUIs()
    local closeBtn = getObject(RUTAS.CloseButton)
    if closeBtn and closeBtn.Visible then
        clickObject(closeBtn)
        return true
    end
    return false
end

-- ========== FUNCIÓN PARA COMPRAR PERSONALIZACIONES ==========
local function buyCustomization()
    local tryBtn = getObject(RUTAS.TryButton)
    local buyBtn = getObject(RUTAS.BuyButton)
    
    if tryBtn and tryBtn.Visible then
        clickObject(tryBtn)
        task.wait(0.5)
    end
    
    if buyBtn and buyBtn.Visible and buyBtn.Active then
        clickObject(buyBtn)
        return true
    end
    return false
end

-- ========== FUNCIÓN PRINCIPAL DE AUTOMATIZACIÓN ==========
local function autoFarm()
    print("🚀 Iniciando auto-farm en Mansion Tycoon...")
    
    while RunService:IsRunning() and CONFIG.AutoCollect do
        task.wait(CONFIG.CollectInterval)
        
        -- 1. Recolectar dinero
        if CONFIG.AutoCollect then
            collectCash()
        end
        
        -- 2. Comprar mejoras
        if CONFIG.AutoBuyTiers then
            buyTier(3)
            task.wait(0.3)
            buyTier(5)
        end
        
        -- 3. Activar doble dinero
        if CONFIG.AutoDoubleCash then
            useDoubleCash()
        end
        
        -- 4. Comprar personalizaciones
        if CONFIG.AutoBuyCustoms then
            buyCustomization()
        end
        
        -- 5. Cerrar GUIs molestas
        if CONFIG.AutoCloseGUI then
            closeGUIs()
        end
    end
end

-- ========== CREAR GUI DE CONTROL (OPCIONAL) ==========
local function createGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MansionTycoonGUI"
    screenGui.Parent = player.PlayerGui
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 250, 0, 300)
    frame.Position = UDim2.new(0, 10, 0, 10)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BackgroundTransparency = 0.1
    frame.Parent = screenGui
    
    -- Título
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Text = "🏠 Mansion Tycoon"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundTransparency = 1
    title.Parent = frame
    
    -- Checkbox Auto Collect
    local toggle1 = Instance.new("TextButton")
    toggle1.Size = UDim2.new(1, -20, 0, 30)
    toggle1.Position = UDim2.new(0, 10, 0, 40)
    toggle1.Text = "✅ Auto Collect"
    toggle1.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    toggle1.Parent = frame
    toggle1.MouseButton1Click:Connect(function()
        CONFIG.AutoCollect = not CONFIG.AutoCollect
        toggle1.Text = CONFIG.AutoCollect and "✅ Auto Collect" or "❌ Auto Collect"
    end)
    
    -- Checkbox Auto Buy Tiers
    local toggle2 = Instance.new("TextButton")
    toggle2.Size = UDim2.new(1, -20, 0, 30)
    toggle2.Position = UDim2.new(0, 10, 0, 75)
    toggle2.Text = "✅ Auto Buy Tiers"
    toggle2.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    toggle2.Parent = frame
    toggle2.MouseButton1Click:Connect(function()
        CONFIG.AutoBuyTiers = not CONFIG.AutoBuyTiers
        toggle2.Text = CONFIG.AutoBuyTiers and "✅ Auto Buy Tiers" or "❌ Auto Buy Tiers"
    end)
    
    -- Checkbox Auto Double Cash
    local toggle3 = Instance.new("TextButton")
    toggle3.Size = UDim2.new(1, -20, 0, 30)
    toggle3.Position = UDim2.new(0, 10, 0, 110)
    toggle3.Text = "✅ Auto Double Cash"
    toggle3.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    toggle3.Parent = frame
    toggle3.MouseButton1Click:Connect(function()
        CONFIG.AutoDoubleCash = not CONFIG.AutoDoubleCash
        toggle3.Text = CONFIG.AutoDoubleCash and "✅ Auto Double Cash" or "❌ Auto Double Cash"
    end)
    
    -- Botón Start/Stop
    local startBtn = Instance.new("TextButton")
    startBtn.Size = UDim2.new(0, 100, 0, 35)
    startBtn.Position = UDim2.new(0.5, -50, 1, -45)
    startBtn.Text = "▶️ Iniciar"
    startBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    startBtn.Parent = frame
    
    local isRunning = false
    local loopThread = nil
    
    startBtn.MouseButton1Click:Connect(function()
        if isRunning then
            isRunning = false
            CONFIG.AutoCollect = false
            CONFIG.AutoBuyTiers = false
            CONFIG.AutoDoubleCash = false
            startBtn.Text = "▶️ Iniciar"
            startBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
            print("⏹️ Auto-farm detenido")
        else
            isRunning = true
            CONFIG.AutoCollect = true
            CONFIG.AutoBuyTiers = true
            CONFIG.AutoDoubleCash = true
            startBtn.Text = "⏹️ Detener"
            startBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
            print("▶️ Auto-farm iniciado")
            
            -- Iniciar loop en un hilo separado
            task.spawn(function()
                while isRunning do
                    task.wait(CONFIG.CollectInterval)
                    collectCash()
                    task.wait(0.3)
                    if CONFIG.AutoBuyTiers then
                        buyTier(3)
                        task.wait(0.3)
                        buyTier(5)
                    end
                    task.wait(0.3)
                    if CONFIG.AutoDoubleCash then
                        useDoubleCash()
                    end
                end
            end)
        end
    end)
end

-- ========== INICIALIZACIÓN ==========
print("🏠 Cargando script para Mansion Tycoon...")
print("✅ Rutas encontradas:")
print("   - MoneyTier5: " .. tostring(getObject(RUTAS.MoneyTier5) ~= nil))
print("   - MoneyTier3: " .. tostring(getObject(RUTAS.MoneyTier3) ~= nil))
print("   - DoubleCash: " .. tostring(getObject(RUTAS.DoubleCash) ~= nil))
print("   - CashToCollect: " .. tostring(getObject(RUTAS.CashToCollect) ~= nil))

-- Crear GUI de control
createGUI()

-- Iniciar auto-farm automáticamente
task.wait(1)
autoFarm()

print("✅ Script cargado completamente")
print("📌 Usa la GUI en pantalla para controlar el auto-farm")
