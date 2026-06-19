-- Script: JoseAngel_Blox Block Cup

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local RootPart = Character:WaitForChild("HumanoidRootPart")

local activado = true

local function agarrarBolas()
    if not activado then return end
    for _, objeto in pairs(workspace:GetChildren()) do
        if string.find(objeto.Name:lower(), "ball") then
            firetouchinterest(RootPart, objeto, 0)
            firetouchinterest(RootPart, objeto, 1)
            if objeto:FindFirstChildOfClass("ClickDetector") then
                fireclickdetector(objeto.ClickDetector)
            end
            wait(0.05)
        end
    end
end

spawn(function()
    while wait(0.1) do
        if activado then
            agarrarBolas()
        end
    end
end)

RunService.Heartbeat:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

print("Script JoseAngel_Blox Block Cup activado")
