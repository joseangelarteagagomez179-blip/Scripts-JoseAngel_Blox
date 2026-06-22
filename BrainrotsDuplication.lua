-- // KICK A LUCKY BLOCK - DUPLICADOR FINAL //
-- ✅ Funciona modificando los datos reales

-- SERVICIOS
local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local mouse = lp:GetMouse()

-- == CREAR MENU ==
local sg = Instance.new("ScreenGui")
local f = Instance.new("Frame")
local t = Instance.new("TextLabel")
local b = Instance.new("TextButton")
local st = Instance.new("TextLabel")

sg.Parent = lp.PlayerGui
f.Size = UDim2.new(0,250,0,180)
f.Position = UDim2.new(0.05,0,0.2,0)
f.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
f.Draggable = true
f.Active = true
f.Parent = sg

t.Size = UDim2.new(1,0,0,30,0)
t.BackgroundColor3 = Color3.new(0,0,0.8)
t.Text = "⚡ DUPLICADOR FINAL ⚡"
t.TextColor3 = Color3.new(1,1,1)
t.Font = Enum.Font.GothamBold
t.Parent = f

st.Size = UDim2.new(1,-20,0,50)
st.Position = UDim2.new(0,10,0,40)
st.BackgroundTransparency = 1
st.Text = "Modo: Click en item -> Duplicar"
st.TextColor3 = Color3.new(1,1,1)
st.Parent = f

b.Size = UDim2.new(0.8,0,0,40,0)
b.Position = UDim2.new(0.1,0,0,100)
b.BackgroundColor3 = Color3.new(0,0.8,0)
b.Text = "✅ DUPLICAR"
b.TextColor3 = Color3.new(1,1,1)
b.Font = Enum.Font.GothamBold
b.Parent = f

-- == VARIABLES GLOBALES ==
local ItemSeleccionado = nil
local NombreItem = ""

-- == DETECTAR CLIC ==
mouse.Button1Down:Connect(function()
    pcall(function()
        -- Objeto que tocas con el mouse
        local obj = mouse.Target
        if obj and obj.Parent then
            -- Guardamos el nombre de lo que tocaste
            NombreItem = obj.Name
            st.Text = "✅ SELECCIONADO:\n" .. NombreItem
            ItemSeleccionado = obj
        end
    end)
end)

-- == FUNCION PRINCIPAL DE DUPLICAR ==
b.MouseButton1Click:Connect(function()
    if NombreItem == "" then
        st.Text = "❌ TOCA PRIMERO\nEL BRAINROT EN EL SUELO O INVENTARIO"
        return
    end

    -- BUSCAR EN TODAS PARTES DONDE PUEDE ESTAR
    pcall(function()
        -- METODO 1: Buscar en leaderstats o carpeta de items
        local carpeta = lp:FindFirstChild("leaderstats") or lp:FindFirstChild("Inventory") or lp:FindFirstChild("Items") or lp:FindFirstChild("Data")
        
        if carpeta then
            local item = carpeta:FindFirstChild(NombreItem)
            if item and item:IsA("NumberValue") or item:IsA("IntValue") then
                item.Value = item.Value + 1 -- AÑADIMOS UNO MAS
                st.Text = "✅ DUPLICADO!\nTotal: " .. item.Value
                return
            end
        end

        -- METODO 2: Si esta en la barra de abajo (Hotbar)
        for _, v in pairs(lp.PlayerGui:GetDescendants()) do
            if v:IsA("TextLabel") or v:IsA("TextButton") then
                if v.Text == NombreItem or v.Name == NombreItem then
                    -- Buscamos el valor asociado
                    local valor = v:FindFirstChildOfClass("NumberValue") or v:FindFirstChildOfClass("IntValue")
                    if valor then
                        valor.Value = valor.Value + 1
                        st.Text = "✅ DUPLICADO!\nTotal: " .. valor.Value
                        return
                    end
                end
            end
        end

        -- METODO 3: CLONAR DIRECTAMENTE
        if ItemSeleccionado and ItemSeleccionado.Parent then
            local clon = ItemSeleccionado:Clone()
            clon.Parent = ItemSeleccionado.Parent
            st.Text = "✅ CREADO NUEVO ITEM"
        end

    end)
end)

print("Script Listo!")
