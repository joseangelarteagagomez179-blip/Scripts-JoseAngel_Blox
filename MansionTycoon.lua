local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local runService = game:GetService("RunService")

-- Configuraciones
local speedValue = 100            -- Velocidad del jugador
local jumpPowerValue = 150        -- Potencia de salto
local autoBuildInterval = 5       -- Segundos entre construcciones automáticas
local autoFarmInterval = 3        -- Segundos entre acciones de farm

-- Función para recolectar dinero automáticamente
local function autoCollectMoney()
    for _, item in pairs(workspace:GetChildren()) do
        if item.Name == "Money" or item.Name == "Coin" then
            if item:IsA("BasePart") and (item.Position - character.HumanoidRootPart.Position).magnitude < 100 then
                item.CFrame = character.HumanoidRootPart.CFrame  -- Teletransporta la moneda al jugador
            end
        end
    end
end

-- Función para construir automáticamente
-- Este ejemplo asume que hay un RemoteEvent para construir que se llama "BuildEvent"
-- Cambia el nombre y parámetros según el juego
local function autoBuild()
    local buildEvent = game:GetService("ReplicatedStorage"):FindFirstChild("BuildEvent")
    if buildEvent then
        -- Ejemplo: construir una parte de mansion en posición relativa
        local buildPosition = character.HumanoidRootPart.Position + Vector3.new(5, 0, 0)
        buildEvent:FireServer("Wall", buildPosition)  -- Los parámetros dependen del juego
    end
end

-- Función de auto farm simple (depende del juego)
local function autoFarm()
    -- Esto depende directamente de cómo funciona el "farm" dentro del juego
    -- Por ejemplo, activar algún objeto o teletransportarse a zonas para farmear
    -- Aquí un ejemplo genérico:
    local farmArea = workspace:FindFirstChild("FarmArea")
    if farmArea then
        character.HumanoidRootPart.CFrame = farmArea.CFrame
    end
end

-- Ajustar velocidad y salto
local function setSpeedAndJump()
    humanoid.WalkSpeed = speedValue
    humanoid.JumpPower = jumpPowerValue
end

setSpeedAndJump()

-- Ejecutar tareas periódicas
spawn(function()
    while true do
        autoCollectMoney()
        wait(0.1)
    end
end)

spawn(function()
    while true do
        autoFarm()
        wait(autoFarmInterval)
    end
end)

spawn(function()
    while true do
        autoBuild()
        wait(autoBuildInterval)
    end
end)
