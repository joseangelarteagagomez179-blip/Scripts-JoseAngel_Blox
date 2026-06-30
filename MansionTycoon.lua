-- =============================================
-- ⚡ ANIMACIÓN DE CARGA ÉPICA (CORREGIDA)
-- =============================================

spawn(function()
    -- OBTENER REFERENCIAS SEGURAS
    local LoadingBar = script.Parent:FindFirstChild("LoadingBar")
    local LoadingBarBackground = script.Parent:FindFirstChild("LoadingBarBackground")
    local PercentText = script.Parent:FindFirstChild("PercentText")
    local LoadFrame = script.Parent:FindFirstChild("LoadFrame")
    local WelcomeText = script.Parent:FindFirstChild("WelcomeText")
    local MainFrame = script.Parent:FindFirstChild("MainFrame")
    
    -- VERIFICAR QUE TODO EXISTA
    if not LoadingBar or not LoadingBarBackground or not PercentText then
        warn("❌ Faltan objetos UI necesarios")
        return
    end
    
    -- Animación de la barra
    local Progress = 0
    while Progress <= 100 do
        Progress = Progress + 1
        local Percent = Progress / 100
        
        -- Protección contra nil
        if LoadingBar then
            LoadingBar.Size = UDim2.new(Percent, 0, 0, 20)
        end
        if PercentText then
            PercentText.Text = "Cargando... "..Progress.."%"
        end
        
        -- Cambio de color
        if Progress < 30 then
            LoadingBar.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        elseif Progress < 60 then
            LoadingBar.BackgroundColor3 = Color3.fromRGB(255, 200, 100)
        elseif Progress < 85 then
            LoadingBar.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
        else
            LoadingBar.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
        end
        
        wait(0.015)
    end
    
    wait(0.5)
    
    -- OCULTAR UI
    if LoadingBar then LoadingBar.Visible = false end
    if LoadingBarBackground then LoadingBarBackground.Visible = false end
    if PercentText then PercentText.Visible = false end
    
    -- ANIMACIÓN DE DESVANECIMIENTO
    if LoadFrame and WelcomeText then
        local FadeTween = TweenService:Create(LoadFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        })
        
        local WelcomeFade = TweenService:Create(WelcomeText, TweenInfo.new(0.5), {
            TextTransparency = 1
        })
        WelcomeFade:Play()
        FadeTween:Play()
        wait(0.5)
        LoadFrame:Destroy()
    end
    
    -- MOSTRAR MENÚ
    if MainFrame then
        MainFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        wait(0.1)
        
        local isMobile = UserInputService.TouchEnabled
        local MenuSize = isMobile and UDim2.new(0, 340, 0, 500) or UDim2.new(0, 360, 0, 550)
        local MenuPos = isMobile and UDim2.new(0.5, -170, 0.5, -250) or UDim2.new(0.5, -180, 0.5, -275)
        
        MainFrame.Position = MenuPos
        local AppearTween = TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = MenuSize
        })
        AppearTween:Play()
    end
    
    print("✅ Menú cargado correctamente!")
end)
