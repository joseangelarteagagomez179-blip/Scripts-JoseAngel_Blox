local VirtualUser = game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

local tycoons = game:GetService("Workspace")["Zednov's Tycoon Kit"].Tycoons
local players = game:GetService("Players")
local player = players.LocalPlayer
local character = player.Character
local tycoon = nil

getgenv().run = false
wait(0.5)
getgenv().run = true

local function get_by_path(root_obj, path_string)
    if not root_obj then return nil end
    for part in string.gmatch(path_string, "[^%.]+") do
        local found = nil
        if type(root_obj) == 'table' and root_obj[part] \~= nil then
            found = root_obj[part]
        else
            found = root_obj:FindFirstChild(part)
        end
        if found then root_obj = found else return nil end
    end
    return root_obj
end

while wait() and getgenv().run == true do
    for _,loop_tycoon in pairs(tycoons:GetChildren()) do
        if loop_tycoon.ClassName == "Model" and loop_tycoon.Owner.Value == player then
            tycoon = loop_tycoon
            break
        end
    end

    if tycoon then
        -- Auto Collect Cash (busca droppers y los toca)
        for _, drop in pairs(tycoon:GetDescendants()) do
            if drop.Name:find("Dropper") or drop.Name:find("Cash") then
                firetouchinterest(player.Character.HumanoidRootPart, drop, 0)
                firetouchinterest(player.Character.HumanoidRootPart, drop, 1)
            end
        end

        -- Auto Build / Mansion
        if tycoon:FindFirstChild("BuildButton") then
            firetouchinterest(player.Character.HumanoidRootPart, tycoon.BuildButton, 0)
            firetouchinterest(player.Character.HumanoidRootPart, tycoon.BuildButton, 1)
        end

        -- Auto Buy Upgrades (simula el click en los botones de upgrade)
        for _, upgrade in pairs(tycoon:GetDescendants()) do
            if upgrade.Name:find("Upgrade") and upgrade.Parent:FindFirstChild("BuyButton") then
                firetouchinterest(player.Character.HumanoidRootPart, upgrade.BuyButton, 0)
                firetouchinterest(player.Character.HumanoidRootPart, upgrade.BuyButton, 1)
            end
        end
    end
end
