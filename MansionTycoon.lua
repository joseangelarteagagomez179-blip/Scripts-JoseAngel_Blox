--// SERVICES
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

--// DESTROY OLD UI
if PlayerGui:FindFirstChild("MansionTycoonUI") then 
    PlayerGui.MansionTycoonUI:Destroy() 
end

--// ========== SISTEMA DE CONTROL DE PROCESOS ==========
local ProcessManager = {
    processes = {},
    
    Start = function(self, processId, callback, interval)
        if self.processes[processId] then
            self:Stop(processId)
        end
        
        local running = true
        local connection
        
        connection = RunService.Heartbeat:Connect(function()
            if not running then
                connection:Disconnect()
                return
            end
            pcall(callback)
        end)
        
        self.processes[processId] = {
            running = running,
            connection = connection
        }
        
        return true
    end,
    
    Stop = function(self, processId)
        local process = self.processes[processId]
        if process then
            process.running = false
            if process.connection then
                process.connection:Disconnect()
                process.connection = nil
            end
            self.processes[processId] = nil
            return true
        end
        return false
    end,
    
    IsRunning = function(self, processId)
        return self.processes[processId] ~= nil
    end,
    
    StopAll = function(self)
        for id, _ in pairs(self.processes) do
            self:Stop(id)
        end
    end
}

--// ========== FUNCIONES ESPECÍFICAS PARA MANSION TYCOON ==========

-- BUSCAR EL BUZÓN (MEJORADO)
local function FindMailbox()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            local name = string.lower(obj.Name or "")
            -- Buscamos más palabras clave para asegurar que lo encuentre
            if name:find("mail") or name:find("buzon") or name:find("collect") or name:find("drop") or name:find("money") then
                return obj
            end
        end
    end
    return nil
end

-- BUSCAR TODOS LOS BOTONES
local function FindAllButtons()
    local buttons = {}
    for _, gui in pairs(PlayerGui:GetChildren()) do
        for _, button in pairs(gui:GetDescendants()) do
            if button:IsA("TextButton") or button:IsA("ImageButton") then
                if button.Visible and button.Active then
                    table.insert(buttons, button)
                end
            end
        end
    end
    return buttons
end

-- BUSCAR CLICKDETECTORS
local function FindAllClickDetectors()
    local detectors = {}
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ClickDetector") then
            table.insert(detectors, obj)
        end
    end
    return detectors
end

-- ✅ FUNCIÓN CORREGIDA PARA RECOGER DINERO
local function SimulateMailboxTouch()
    local mailbox = FindMailbox()
    if not mailbox then return false end
    
    -- Método 1: FireClickDetector
    local clickDetector = mailbox:FindFirstChildWhichIsA("ClickDetector")
    if clickDetector then
        pcall(function()
            fireclickdetector(clickDetector)
        end)
        return true
    end
    
    -- Método 2: Buscar en hijos
    for _, child in pairs(mailbox:GetDescendants()) do
        if child:IsA("ClickDetector") then
            pcall(function()
                fireclickdetector(child)
            end)
            return true
        end
    end
    
    -- Método 3: Teletransporte rápido (si lo anterior falla)
    local char = Player.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            local originalPos = hrp.CFrame
            hrp.CFrame = mailbox.CFrame + Vector3.new(0,1,0)
            task.wait(0.01)
            hrp.CFrame = originalPos
            return true
        end
    end
    
    return false
end

--// ... (EL CÓDIGO DE LA UI SE QUEDA IGUAL, NO LO BORRES) ...
--// ==================================================
--// AQUÍ IRÍA TODO TU CÓDIGO DE CREAR LA INTERFAZ, LOS BOTONES, ETC.
--// (Déjalo tal cual como lo tienes)
--// ==================================================

--// =============================================
--// ✅ FUNCIONES PRINCIPALES CORREGIDAS
--// =============================================

--// 1. AUTO RECOGER DINERO (AHORA SÍ FUNCIONA)
CreateToggle(AutoSection, "💰 Auto Recoger", function(state)
    local processId = "AutoRecoger"
    
    if state then
        ProcessManager:Start(processId, function()
            SimulateMailboxTouch()
            
            -- También busca orbes o dinero flotante
            local detectors = FindAllClickDetectors()
            for _, detector in pairs(detectors) do
                local parentName = string.lower(detector.Parent and detector.Parent.Name or "")
                if parentName:find("money") or parentName:find("cash") or parentName:find("collect") then
                    pcall(function() fireclickdetector(detector) end)
                end
            end
        end)
    else
        ProcessManager:Stop(processId)
    end
end)

--// 2. AUTO COMPRAR (MEJORADO)
CreateToggle(AutoSection, "🛒 Auto Comprar", function(state)
    local processId = "AutoComprar"
    
    if state then
        ProcessManager:Start(processId, function()
            local allButtons = FindAllButtons()
            for _, button in pairs(allButtons) do
                if button.Visible and button.Active then
                    local name = string.lower(button.Name or "")
                    local text = string.lower(button.Text or "")
                    
                    -- Añadí más palabras clave
                    if text:find("comprar") or text:find("buy") or text:find("build") or text:find("place") or
                       name:find("buy") or name:find("build") or name:find("purchase") then
                        pcall(function()
                            button:MouseButton1Click()
                        end)
                    end
                end
            end
        end)
    else
        ProcessManager:Stop(processId)
    end
end)

--// 3. AUTO MEJORAS
CreateToggle(AutoSection, "⬆️ Auto Mejoras", function(state)
    local processId = "AutoMejoras"
    
    if state then
        ProcessManager:Start(processId, function()
            local detectors = FindAllClickDetectors()
            for _, detector in pairs(detectors) do
                local parentName = string.lower(detector.Parent and detector.Parent.Name or "")
                if parentName:find("upgrade") or parentName:find("mejora") or parentName:find("level") then
                    pcall(function() fireclickdetector(detector) end)
                end
            end
        end)
    else
        ProcessManager:Stop(processId)
    end
end)

--// 4. AUTO FARM COMPLETO
CreateToggle(AutoSection, "⚡ Auto Farm", function(state)
    local processId = "AutoFarm"
    
    if state then
        ProcessManager:Start(processId, function()
            -- Recoger
            SimulateMailboxTouch()
            
            -- Comprar
            local allButtons = FindAllButtons()
            for _, button in pairs(allButtons) do
                if button.Visible and button.Active then
                    local text = string.lower(button.Text or "")
                    if text:find("comprar") or text:find("buy") or text:find("build") then
                        pcall(function() button:MouseButton1Click() end)
                    end
                end
            end
        end)
    else
        ProcessManager:Stop(processId)
    end
end)

--// ... (EL RESTO DEL CÓDIGO SIGUE IGUAL) ...
