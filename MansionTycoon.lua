-- =============================================
-- ⚡ ANIMACIÓN DE CARGA ÉPICA (CORREGIDA)
-- =============================================

spawn(function()
    -- Animación de la barra
    local Progress = 0
    while Progress <= 100 do
        Progress = Progress + 1
        local Percent = Progress / 100
        LoadingBar.Size = UDim2.new(Percent, 0, 0, 20)
        PercentText.Text = "Cargando... "..Progress.."%"
        
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
    
    -- ✅ ESPERA UN MOMENTO PARA QUE SE VEA EL 100%
    wait(0.5)
    
    -- ✅ PRIMERO: OCULTAR LA BARRA
    LoadingBar.Visible = false
    LoadingBarBackground.Visible = false
    PercentText.Visible = false
    
    -- ✅ SEGUNDO: ANIMACIÓN DE DESVANECIMIENTO
    local FadeTween = TweenService:Create(LoadFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    })
    
    -- Desvanecer texto de bienvenida
    local WelcomeFade = TweenService:Create(WelcomeText, TweenInfo.new(0.5), {
        TextTransparency = 1
    })
    WelcomeFade:Play()
    
    FadeTween:Play()
    wait(0.5)
    
    -- ✅ TERCERO: DESTRUIR LA PANTALLA DE CARGA
    LoadFrame:Destroy()
    
    -- ✅ CUARTO: MOSTRAR EL MENÚ CON ANIMACIÓN
    MainFrame.Visible = true
    MainFrame.Size = UDim2.new(0, 0, 0, 0) -- Empieza pequeño
    wait(0.1)
    
    -- Animación de aparición del menú
    local isMobile = UserInputService.TouchEnabled
    local MenuSize = isMobile and UDim2.new(0, 340, 0, 500) or UDim2.new(0, 360, 0, 550)
    local MenuPos = isMobile and UDim2.new(0.5, -170, 0.5, -250) or UDim2.new(0.5, -180, 0.5, -275)
    
    MainFrame.Position = MenuPos
    local AppearTween = TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = MenuSize
    })
    AppearTween:Play()
    
    print("✅ Menú cargado correctamente!")
end)
