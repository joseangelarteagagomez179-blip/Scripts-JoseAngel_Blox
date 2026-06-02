-- Script JoseAngel_Blox
-- Interfaz Cuadrada con Estilo Hacker

local Rayfield = loadstring(game:HttpGet('https://sirius.menu'))()

local Window = Rayfield:CreateWindow({
   Name = "Script JoseAngel_Blox 🟢",
   LoadingTitle = "Kick a Lucky Block Hub",
   LoadingSubtitle = "by JoseAngel_Blox",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "JoseAngelBloxConfig",
      FileName = "KickALuckyBlock"
   },
   Discord = {
      Enabled = false,
      Invite = "",
      RememberJoins = true
   },
   KeySystem = false
})

-- Variables de Estado
local _G = getgenv and getgenv() or {}
_G.AutoFarm = false
_G.AutoWeight = false
_G.AutoClickX2 = false
_G.CollectMoney = false
_G.EnableMove = false
_G.Fly = false
_G.Invisible = false

_G.WalkSpeedValue = 16
_G.FlySpeedValue = 50

-- Guardar posiciones originales para el Auto Farm
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

-- Pestañas Principales (Estructura Cuadrada)
local MainTab = Window:CreateTab("Main", 4483362458)
local PlayerTab = Window:CreateTab("Player", 4483345906)
local ConfigTab = Window:CreateTab("Configuraciones", 4483362534)

------------------------------------------------------------------------
-- PESTAÑA: MAIN
------------------------------------------------------------------------

MainTab:CreateSection("Funciones de Automatización")

MainTab:CreateToggle({
   Name = "Auto Farm (Patear + Regresar)",
   CurrentValue = false,
   Flag = "ToggleAutoFarm",
   Callback = function(Value)
      _G.AutoFarm = Value
      if Value then
         task.spawn(function()
            while _G.AutoFarm do
               -- Guardar posición antes de ir a patear
               local originalPos = hrp.CFrame
               
               -- Buscar el área de patear (Ajustar "KickArea" según el nombre exacto en el mapa)
               local kickArea = workspace:FindFirstChild("KickArea") or workspace:FindFirstChild("KickZone")
               if kickArea then
                  hrp.CFrame = kickArea.CFrame
                  task.wait(0.2)
                  
                  -- Simular patada perfecta (Remotes del juego)
                  local remote = game:GetService("ReplicatedStorage"):FindFirstChild("KickRemote") or game:GetService("ReplicatedStorage"):FindFirstChild("Kick")
                  if remote and remote:IsA("RemoteEvent") then
                     remote:FireServer("Perfect")
                  end
               end
               
               -- Detectar si aparece "brainrot" o pantalla final y regresar
               -- Nota: Cambiar "BrainrotUI" por el nombre real del aviso en el juego si es necesario
               if player.PlayerGui:FindFirstChild("BrainrotUI") or player.PlayerGui:FindFirstChild("WinUI") then
                  hrp.CFrame = originalPos
                  task.wait(1)
               end
               task.wait(0.1)
            end
         end)
      end
   end,
})

MainTab:CreateToggle({
   Name = "Auto Weight (Equipar Pesa)",
   CurrentValue = false,
   Flag = "ToggleAutoWeight",
   Callback = function(Value)
      _G.AutoWeight = Value
      if Value then
         task.spawn(function()
            while _G.AutoWeight do
               local backpack = player:FindFirstChild("Backpack")
               local weight = backpack:FindFirstChild("Weight") or backpack:FindFirstChild("Pesa")
               if weight then
                  humanoid:EquipTool(weight)
               end
               task.wait(1)
            end
         end)
      end
   end,
})

MainTab:CreateToggle({
   Name = "Auto Click x2 (Botones de Multiplicador)",
   CurrentValue = false,
   Flag = "ToggleClickX2",
   Callback = function(Value)
      _G.AutoClickX2 = Value
      if Value then
         task.spawn(function()
            while _G.AutoClickX2 do
               -- Buscar botones x2 en la interfaz del juego y activarlos
               for _, v in pairs(player.PlayerGui:GetDescendants()) do
                  if v:IsA("TextButton") and (string.find(string.lower(v.Text), "x2") or string.find(string.lower(v.Name), "x2")) then
                     firesignal(v.MouseButton1Click)
                  end
               end
               task.wait(2)
            end
         end)
      end
   end,
})

MainTab:CreateToggle({
   Name = "Collect Money (Auto Recoger Dinero)",
   CurrentValue = false,
   Flag = "ToggleCollectMoney",
   Callback = function(Value)
      _G.CollectMoney = Value
      if Value then
         task.spawn(function()
            while _G.CollectMoney do
               -- Buscar monedas/dinero suelto en el mapa
               for _, obj in pairs(workspace:GetChildren()) do
                  if obj:IsA("Part") and (obj.Name == "Coin" or obj.Name == "Money" or obj.Name == "Cash") then
                     obj.CFrame = hrp.CFrame
                  end
               end
               task.wait(0.5)
            end
         end)
      end
   end,
})

MainTab:CreateToggle({
   Name = "Enable Move (Moverse con Peso)",
   CurrentValue = false,
   Flag = "ToggleEnableMove",
   Callback = function(Value)
      _G.EnableMove = Value
      -- Rompe el anclaje de velocidad que imponen algunos juegos al usar pesas
      if Value then
         task.spawn(function()
            while _G.EnableMove do
               if humanoid.WalkSpeed < _G.WalkSpeedValue then
                  humanoid.WalkSpeed = _G.WalkSpeedValue
               end
               task.wait(0.1)
            end
         end)
      end
   end,
})

------------------------------------------------------------------------
-- PESTAÑA: PLAYER
------------------------------------------------------------------------

PlayerTab:CreateSection("Modificaciones del Personaje")

PlayerTab:CreateSlider({
   Name = "Velocidad de Caminado (WalkSpeed)",
   Range = {16, 500},
   Increment = 1,
   CurrentValue = 16,
   Flag = "WalkSpeedSlider",
   Callback = function(Value)
      _G.WalkSpeedValue = Value
      humanoid.WalkSpeed = Value
   end,
})

PlayerTab:CreateToggle({
   Name = "Activar WalkSpeed Infinita",
   CurrentValue = false,
   Flag = "ToggleWalkSpeed",
   Callback = function(Value)
      if Value then
         humanoid.WalkSpeed = _G.WalkSpeedValue
      else
         humanoid.WalkSpeed = 16
      end
   end,
})

-- Función de vuelo optimizada anti-bugs
local flyFlying = false
local deb = true
local ctrl = {f = 0, b = 0, l = 0, r = 0}
local lastctrl = {f = 0, b = 0, l = 0, r = 0}

local function FlyFunction()
   local bg = Instance.new("BodyGyro", hrp)
   bg.P = 9e4
   bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
   bg.cframe = hrp.CFrame
   local bv = Instance.new("BodyVelocity", hrp)
   bv.velocity = Vector3.new(0, 0.1, 0)
   bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
   
   task.spawn(function()
      while _G.Fly do
         task.wait()
         humanoid.PlatformStand = true
         if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
            bv.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f + ctrl.b)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l + ctrl.r, (ctrl.f + ctrl.b) * 2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * _G.FlySpeedValue
            lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
         elseif tonumber(_G.FlySpeedValue) then
            bv.velocity = Vector3.new(0, 0.1, 0)
         end
      end
      ctrl = {f = 0, b = 0, l = 0, r = 0}
      lastctrl = {f = 0, b = 0, l = 0, r = 0}
      bg:Destroy()
      bv:Destroy()
      humanoid.PlatformStand = false
   end)
end

PlayerTab:CreateToggle({
   Name = "Volar (Fly)",
   CurrentValue = false,
   Flag = "ToggleFly",
   Callback = function(Value)
      _G.Fly = Value
      if Value then
         FlyFunction()
      end
   end,
})

PlayerTab:CreateSlider({
   Name = "Velocidad de Vuelo",
   Range = {10, 300},
   Increment = 5,
   CurrentValue = 50,
   Flag = "FlySpeedSlider",
   Callback = function(Value)
      _G.FlySpeedValue = Value
   end,
})

PlayerTab:CreateToggle({
   Name = "Invisibilidad (Invisible)",
   CurrentValue = false,
   Flag = "ToggleInvisible",
   Callback = function(Value)
      _G.Invisible = Value
      for _, part in pairs(character:GetDescendants()) do
         if part:IsA("BasePart") or part:IsA("Decal") then
            if part.Name ~= "HumanoidRootPart" then
               part.Transparency = Value and 1 or 0
            end
         end
      end
   end,
})

PlayerTab:CreateButton({
   Name = "Rejoin (Reiniciar Servidor)",
   Callback = function()
      local ts = game:GetService("TeleportService")
      local placeId = game.PlaceId
      ts:Teleport(placeId, player)
   end,
})

------------------------------------------------------------------------
-- PESTAÑA: CONFIGURACIONES
------------------------------------------------------------------------

ConfigTab:CreateSection("Rendimiento del Sistema")

local fpsLabel = ConfigTab:CreateLabel("FPS: Calculando...")
task.spawn(function()
   local startTime = os.clock()
   local frames = 0
   while true do
      frames = frames + 1
      local now = os.clock()
      if now - startTime >= 1 then
         fpsLabel:Set("FPS: " .. tostring(frames))
         frames = 0
         startTime = now
      end
      task.wait()
   end
end)

ConfigTab:CreateButton({
   Name = "Optimizar Juego (No Lag)",
   Callback = function()
      -- Desactiva texturas pesadas y efectos visuales innecesarios
      for _, v in pairs(workspace:GetDescendants()) do
         if v:IsA("BasePart") and not v:IsA("MeshPart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
         elseif v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
         elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Enabled = false
         end
      end
