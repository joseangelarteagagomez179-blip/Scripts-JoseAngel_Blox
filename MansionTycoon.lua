-- FILTRO DEFINITIVO ANTI-ROBUX (MEJORADO)
local function isSafeToTouch(v)
    if not (v:IsA("BasePart") and v.Name == "Touch") then return false end
    local parent = v.Parent
    if not parent then return false end
    
    -- 1. DETECTAR GUI DE COMPRA (GoldButtonGui es el que sale en tu imagen)
    if parent:FindFirstChild("GoldButtonGui") or 
       parent:FindFirstChild("ButtonGui") or 
       parent:FindFirstChild("RobuxGui") or
       parent:FindFirstChild("ProductGui") or
       parent:FindFirstChild("PurchaseGui") then
        return false
    end
    
    -- 2. DETECTAR ICONOS O TEXTOS DE ROBUX EN CARTELITOS
    for _, child in pairs(parent:GetChildren()) do
        if child:IsA("BillboardGui") or child:IsA("SurfaceGui") then
            local textElements = child:GetDescendants()
            for _, t in pairs(textElements) do
                if t:IsA("TextLabel") then
                    local txt = t.Text:lower()
                    if txt:find("robux") or txt:find("r%$") or txt:find("premium") or txt:find("vip") or 
                       txt:find("auto%-recoger") or txt:find("starter") or txt:find("pack") or 
                       txt:find("velocidad") or txt:find("extra") or txt:find("correo") or
                       txt:find("doble") or txt:find("dinero") then
                        return false
                    end
                end
                if t:IsA("ImageLabel") and (t.Image:find("rbxassetid://") or t.Image:find("robux")) then
                    return false
                end
            end
        end
    end
    
    -- 3. FILTRO POR NOMBRE DEL PADRE (agrega más palabras clave)
    local pName = parent.Name:lower()
    local badWords = {
        "vip", "robux", "premium", "gamepass", "gold", "shop", "double", 
        "moneytier", "starterpack", "boost", "buycash", "autorecoger", 
        "recoger", "velocidad", "correo", "extra", "doble", "starter", 
        "pack", "speed", "mail", "collector"
    }
    for _, kw in ipairs(badWords) do
        if pName:find(kw) then return false end
    end

    -- 4. NUEVO: DETECTAR PRECIO DE ROBUX EN EL TEXTO DEL BOTÓN
    -- Busca en toda la jerarquía del padre algún texto que contenga "R$" o "Robux"
    local allDescendants = parent:GetDescendants()
    for _, d in pairs(allDescendants) do
        if d:IsA("TextLabel") or d:IsA("TextButton") then
            local txt = d.Text:lower()
            if txt:find("r$") or txt:find("robux") or txt:find("premium") then
                return false
            end
        end
    end

    -- 5. NUEVO: FILTRO POR POSICIÓN (opcional, si los botones robux están en una zona específica)
    -- Si sabes que los botones de Robux están en un rango de Y o X, puedes agregarlo:
    -- if v.Position.Y > 100 and v.Position.Y < 200 then return false end

    return true
end
