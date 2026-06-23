local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EventoAbrir = ReplicatedStorage:WaitForChild("EventoAbrirLuckyBlock_Kick")
local Players = game:GetService("Players")
local jugador = Players.LocalPlayer -- Si es LocalScript
-- O bien: local jugador = Players:GetPlayerFromCharacter(script.Parent.Parent) -- Si es Script en el bloque

-- Cuando se abra el bloque:
EventoAbrir:FireServer(script.Parent, jugador)
