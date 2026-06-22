-- // Kick A Lucky Block - Duplicador Avanzado //
-- Creado especialmente para ti 😎

-- == SERVICIOS ==
local Players = game:GetService("Players")
local PlayerGui = game:GetService("Players").LocalPlayer.PlayerGui
local UserInput = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- == VARIABLES ==
local LocalPlayer = Players.LocalPlayer
local SelectedItem = nil -- Aquí guardaremos el que selecciones

-- == CREAR MENU INTERFAZ (GUI) ==
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local DupeButton = Instance.new("TextButton")
local SelectedText = Instance.new("TextLabel")

-- Propiedades de la ventana
ScreenGui.Name = "DuplicadorMenu"
ScreenGui.Parent = PlayerGui

MainFrame.Size = UDim2.new(0, 250, 0, 180)
MainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
MainFrame.BorderSizePixel = 2
MainFrame.Draggable = true -- ¡Puedes mover la ventana!
MainFrame.Active = true
MainFrame.Parent = ScreenGui

Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.new(0, 0.5, 1)
Title.Text = "DUPLICADOR DE BRAINROTS"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.new(1,1,1)
Title.Parent = MainFrame

SelectedText.Size = UDim2.new(1, -20, 0, 40)
SelectedText.Position = UDim2.new(0, 10, 0, 40)
SelectedText.BackgroundTransparency = 1
SelectedText.Text = "Selecciona un Brainrot en tu inventario"
SelectedText.TextColor3 = Color3.new(1,1,1)
SelectedText.Font = Enum.Font.Gotham
SelectedText.Parent = MainFrame

DupeButton.Size = UDim2.new(0.8, 0, 0, 40)
DupeButton.Position = UDim2.new(0.1, 0, 0, 100)
DupeButton.BackgroundColor3 = Color3.new(0, 0.8, 0)
DupeButton.Text = "🔄 DUPLICAR"
DupeButton.Font = Enum.Font.GothamBold
DupeButton.TextSize = 20
DupeButton.Parent = MainFrame

-- == FUNCIONES PRINCIPALES ==

-- Detectar cuando haces CLIC en un Brainrot del inventario
RunService.Heartbeat:Connect(function()
    pcall(function()
        -- Buscamos la ventana del inventario (suele llamarse Inventory o similar)
        local Inventory = PlayerGui:FindFirstChildWhichIsA("GuiObject", true)
        if Inventory then
            -- Buscamos todos los botones o imagenes
            for _, v in pairs(Inventory:GetDescendants()) do
                if v:IsA("ImageButton") or v:IsA("TextButton") then
                    -- Si el botón tiene nombre de Brainrot
                    if v.Name:lower():find("brainrot") or v.Parent and v.Parent.Name:lower():find("brainrot") then
                        
                        -- Hacemos que al hacer clic lo seleccione
                        v.MouseButton1Click:Connect(function()
                            SelectedItem = v -- Guardamos el seleccionado
                            SelectedText.Text = "✅ SELECCIONADO: \n" .. v.Name
                            print("Brainrot seleccionado: " .. v.Name)
                        end)
                    end
                end
            end
        end
    end)
end)

-- Función de Duplicar
DupeButton.MouseButton1Click:Connect(function()
    if SelectedItem then
        -- Clonamos el objeto
        local Clone = SelectedItem:Clone()
        Clone.Parent = SelectedItem.Parent
        
        -- Cambiamos un poquito el nombre para que parezca otro
        Clone.Name = SelectedItem.Name .. "_Duplicado"
        
        SelectedText.Text = "✅ ¡DUPLICADO!\nAhora tienes 2 de: " .. SelectedItem.Name
        print("¡Duplicado exitoso!")
    else
        SelectedText.Text = "❌ PRIMERO SELECCIONA \nUN BRAINROT EN TU INVENTARIO"
    end
end)

print("✅ Script cargado correctamente!")
