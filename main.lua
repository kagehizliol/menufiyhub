-- MENUFİY HUB - IMAGE_4.PNG BİREBİR TASARIM
-- Optimize Edilmiş ve İşlevsel Sekmeler ve Açma/Kapama Tuşu

local player = game.Players.LocalPlayer
local coreGui = game:GetService("CoreGui") -- En güvenli GUI konumu

-- 1. Anti-Overlap (Eski menüyü siler)
if coreGui:FindFirstChild("MenufiyHub_UI") then
    coreGui.MenufiyHub_UI:Destroy()
end

-- 2. Ana ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MenufiyHub_UI"
screenGui.Parent = coreGui
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true

-- 3. Tema Renk Paleti (image_4.png'daki gibi)
local theme = {
    MainBg = Color3.fromRGB(15, 10, 25),      -- Çok Koyu Mor Arkaplan
    Border = Color3.fromRGB(80, 20, 180),    -- Canlı Mor Kenarlık
    HeaderBg = Color3.fromRGB(20, 15, 35),    -- Başlık Arkaplanı
    ButtonDefault = Color3.fromRGB(25, 20, 40), -- Buton Kapalı
    ButtonActive = Color3.fromRGB(100, 40, 220), -- Buton Açık
    Slider = Color3.fromRGB(130, 80, 255),    -- Kaydırıcı ve Vurgu
    TextMain = Color3.fromRGB(255, 255, 255),
    TextSub = Color3.fromRGB(160, 140, 200),
    Icon = Color3.fromRGB(180, 100, 255),     -- İkon Rengi
}

-- Yardımcı Fonksiyon: Köşe Yuvarlama
local function applyCorner(obj, res)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, res)
    corner.Parent = obj
end

-- ==========================================
-- 4. AÇMA/KAPAMA TUŞU ('M' Logosu - image_3.png/image_4.png)
-- ==========================================
local toggleButton = Instance.new("ImageButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 60, 0, 60)
toggleButton.Position = UDim2.new(1, -70, 1, -70) -- Sağ Alt
toggleButton.BackgroundColor3 = Color3.fromRGB(10, 5, 20)
toggleButton.BorderSizePixel = 0
toggleButton.Image = "rbxassetid://16027471131" -- Buraya 'M' logosunu yüklemen gerekir, örnek ID
toggleButton.ScaleType = Enum.ScaleType.Fit
toggleButton.Parent = screenGui
applyCorner(toggleButton, 30) -- Tam Yuvarlak

local toggleStroke = Instance.new("UIStroke")
toggleStroke.Thickness = 2
toggleStroke.Color = theme.Border
toggleStroke.Parent = toggleButton

local mainFrame = Instance.new("Frame") -- Ana Menü Çerçevesi

-- Tuşlama İşlevi (Aç/Kapat)
local function toggleMenu()
    mainFrame.Visible = not mainFrame.Visible
end
toggleButton.MouseButton1Click:Connect(toggleMenu)

-- ==========================================
-- 5. ANA MENÜ ÇERÇEVESİ (Main Frame)
-- ==========================================
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 500, 0, 400) -- image_4.png en-boy oranı
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -200) -- Tam Orta
mainFrame.BackgroundColor3 = theme.MainBg
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = false -- Başlangıçta kapalı
mainFrame.Parent = screenGui
applyCorner(mainFrame, 12)

local mainStroke = Instance.new("UIStroke")
mainStroke.Thickness = 2
mainStroke.Color = theme.Border
mainStroke.Parent = mainFrame

-- 6. BAŞLIK VE SEKME GÖSTERGESİ
local headerFrame = Instance.new("Frame")
headerFrame.Size = UDim2.new(1, 0, 0, 50)
headerFrame.BackgroundColor3 = theme.HeaderBg
headerFrame.BorderSizePixel = 0
headerFrame.Parent = mainFrame
applyCorner(headerFrame, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 200, 1, 0)
title.Position = UDim2.new(0.5, -100, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Text = "MENUFİY HUB"
title.TextColor3 = theme.Slider
title.TextSize = 26
title.Parent = headerFrame

local tabIndicator = Instance.new("TextLabel")
tabIndicator.Size = UDim2.new(0, 100, 0, 20)
tabIndicator.Position = UDim2.new(1, -110, 0.5, -10)
tabIndicator.BackgroundTransparency = 1
tabIndicator.Font = Enum.Font.GothamMedium
tabIndicator.Text = "Features" -- Başlangıç sekmesi
tabIndicator.TextColor3 = theme.TextSub
tabIndicator.TextSize = 14
tabIndicator.TextXAlignment = Enum.TextXAlignment.Right
tabIndicator.Parent = headerFrame

-- ==========================================
-- 7. SEKME SİSTEMİ (Tab System)
-- ==========================================
local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1, -20, 0, 40)
tabContainer.Position = UDim2.new(0, 10, 0, 60)
tabContainer.BackgroundTransparency = 1
tabContainer.Parent = mainFrame

local uiListTabs = Instance.new("UIListLayout")
uiListTabs.FillDirection = Enum.FillDirection.Horizontal
uiListTabs.HorizontalAlignment = Enum.HorizontalAlignment.Center
uiListTabs.Padding = UDim.new(0, 8)
uiListTabs.Parent = tabContainer

local function createTabButton(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 100, 1, 0)
    btn.BackgroundColor3 = theme.ButtonDefault
    btn.Font = Enum.Font.GothamMedium
    btn.Text = string.upper(name)
    btn.TextColor3 = theme.TextMain
    btn.TextSize = 14
    btn.Parent = tabContainer
    applyCorner(btn, 8)
    return btn
end

local featTabBtn = createTabButton("Features")
local keyTabBtn = createTabButton("Keybinds")
local settTabBtn = createTabButton("Settings")

-- Başlangıçta 'Features' aktif
featTabBtn.BackgroundColor3 = theme.ButtonActive

-- ==========================================
-- 8. İÇERİK KONTEYNERLERİ (Tab Pages)
-- ==========================================
local pagesContainer = Instance.new("Frame")
pagesContainer.Size = UDim2.new(1, -20, 1, -160)
pagesContainer.Position = UDim2.new(0, 10, 0, 110)
pagesContainer.BackgroundTransparency = 1
pagesContainer.Parent = mainFrame

local function createTabPage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name .. "_Page"
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 2
    page.ScrollBarImageColor3 = theme.Slider
    page.Visible = false -- Başlangıçta gizli
    page.Parent = pagesContainer
    
    local uiList = Instance.new("UIListLayout")
    uiList.Padding = UDim.new(0, 8)
    uiList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    uiList.Parent = page
    
    return page
end

local featuresPage = createTabPage("Features")
local keybindsPage = createTabPage("Keybinds")
local settingsPage = createTabPage("Settings")

-- Başlangıç sayfası
featuresPage.Visible = true

-- SEKME GEÇİŞ İŞLEVLERİ
local function showPage(name, button)
    tabIndicator.Text = name
    for _, page in pairs(pagesContainer:GetChildren()) do
        if page:IsA("ScrollingFrame") then page.Visible = false end
    end
    for _, tabBtn in pairs(tabContainer:GetChildren()) do
        if tabBtn:IsA("TextButton") then tabBtn.BackgroundColor3 = theme.ButtonDefault end
    end
    button.BackgroundColor3 = theme.ButtonActive
    pagesContainer:FindFirstChild(name .. "_Page").Visible = true
end

featTabBtn.MouseButton1Click:Connect(function() showPage("Features", featTabBtn) end)
keyTabBtn.MouseButton1Click:Connect(function() showPage("Keybinds", keyTabBtn) end)
settTabBtn.MouseButton1Click:Connect(function() showPage("Settings", settTabBtn) end)

-- ==========================================
-- 9. ÖZELLİKLER (Features) İÇERİĞİ (image_4.png)
-- ==========================================

-- YARDIMCI FONKSİYONLAR: Özellik Elemanları Oluşturma

-- A) Basit Toggle Butonu (Örn: Auto Left, Galaxy Mode)
local function createToggleButton(parent, iconId, name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -5, 0, 35) -- Kaydırma çubuğu için boşluk
    btn.BackgroundColor3 = theme.ButtonDefault
    btn.Font = Enum.Font.Gotham
    btn.Text = "        " .. name
    btn.TextColor3 = theme.TextMain
    btn.TextSize = 14
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = parent
    applyCorner(btn, 6)

    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(0, 20, 0, 20)
    icon.Position = UDim2.new(0, 8, 0.5, -10)
    icon.BackgroundTransparency = 1
    icon.Image = iconId
    icon.ImageColor3 = theme.Icon
    icon.Parent = btn

    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(0, 40, 1, 0)
    status.Position = UDim2.new(1, -50, 0, 0)
    status.BackgroundTransparency = 1
    status.Font = Enum.Font.GothamMedium
    status.Text = "Off"
    status.TextColor3 = theme.TextSub
    status.TextSize = 12
    status.Parent = btn

    local toggled = false
    btn.MouseButton1Click:Connect(function()
        toggled = not toggled
        status.Text = toggled and "On" or "Off"
        status.TextColor3 = toggled and theme.Slider or theme.TextSub
        btn.BackgroundColor3 = toggled and theme.ButtonActive or theme.ButtonDefault
        if callback then callback(toggled) end
    end)
    return btn
end

-- B) Kaydırıcılı Gelişmiş Özellik (Örn: Speed Boost)
local function createSliderFeature(parent, iconId, name, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -5, 0, 60)
    frame.BackgroundColor3 = theme.ButtonDefault
    frame.BorderSizePixel = 0
    frame.Parent = parent
    applyCorner(frame, 6)

    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 30)
    header.BackgroundTransparency = 1
    header.Parent = frame

    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(0, 18, 0, 18)
    icon.Position = UDim2.new(0, 8, 0.5, -9)
    icon.BackgroundTransparency = 1
    icon.Image = iconId
    icon.ImageColor3 = theme.Icon
    icon.Parent = header

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0, 150, 1, 0)
    title.Position = UDim2.new(0, 35, 0, 0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.Gotham
    title.Text = name
    title.TextColor3 = theme.TextMain
    title.TextSize = 13
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = header

    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(0, 40, 1, 0)
    statusLabel.Position = UDim2.new(1, -50, 0, 0)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Font = Enum.Font.GothamMedium
    statusLabel.Text = "Off"
    statusLabel.TextColor3 = theme.TextSub
    statusLabel.TextSize = 12
    statusLabel.Parent = header

    -- Kaydırıcı (Slider) Alanı
    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(1, -40, 0, 6)
    sliderBg.Position = UDim2.new(0, 20, 0, 40)
    sliderBg.BackgroundColor3 = Color3.fromRGB(40, 30, 60)
    sliderBg.Parent = frame
    applyCorner(sliderBg, 3)

    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    sliderFill.BackgroundColor3 = theme.Slider
    sliderFill.Parent = sliderBg
    applyCorner(sliderFill, 3)

    local sliderButton = Instance.new("TextButton")
    sliderButton.Size = UDim2.new(0, 14, 0, 14)
    sliderButton.Position = UDim2.new((default - min) / (max - min), -7, 0.5, -7)
    sliderButton.BackgroundColor3 = theme.Slider
    sliderButton.Text = ""
    sliderButton.Parent = sliderBg
    applyCorner(sliderButton, 7)

    local sliderValueLabel = Instance.new("TextLabel")
    sliderValueLabel.Size = UDim2.new(0, 30, 0, 16)
    sliderValueLabel.Position = UDim2.new(0, -35, 0.5, -8) -- SliderButton'ın yanına
    sliderValueLabel.BackgroundTransparency = 1
    sliderValueLabel.Font = Enum.Font.GothamMedium
    sliderValueLabel.Text = tostring(default)
    sliderValueLabel.TextColor3 = theme.TextSub
    sliderValueLabel.TextSize = 11
    sliderValueLabel.Parent = sliderButton

    -- Kaydırıcı Mantığı (Slider Logic)
    local UserInputService = game:GetService("UserInputService")
    local dragging = false
    
    sliderButton.MouseButton1Down:Connect(function() dragging = true end)
    UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
            sliderFill.Size = UDim2.new(pos, 0, 1, 0)
            sliderButton.Position = UDim2.new(pos, -7, 0.5, -7)
            local value = math.floor(min + (pos * (max - min)))
            sliderValueLabel.Text = tostring(value)
            if callback then callback(value) end
        end
    end)

    return frame
end

-- C) Dropdownlu Gelişmiş Özellik (Örn: Bat Aimbot)
local function createDropdownFeature(parent, iconId, name, options, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -5, 0, 60)
    frame.BackgroundColor3 = theme.ButtonDefault
    frame.BorderSizePixel = 0
    frame.Parent = parent
    applyCorner(frame, 6)

    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 30)
    header.BackgroundTransparency = 1
    header.Parent = frame

    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(0, 18, 0, 18)
    icon.Position = UDim2.new(0, 8, 0.5, -9)
    icon.BackgroundTransparency = 1
    icon.Image = iconId
    icon.ImageColor3 = theme.Icon
    icon.Parent = header

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0, 150, 1, 0)
    title.Position = UDim2.new(0, 35, 0, 0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.Gotham
    title.Text = name
    title.TextColor3 = theme.TextMain
    title.TextSize = 13
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = header

    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(0, 40, 1, 0)
    statusLabel.Position = UDim2.new(1, -50, 0, 0)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Font = Enum.Font.GothamMedium
    statusLabel.Text = "Off"
    statusLabel.TextColor3 = theme.TextSub
    statusLabel.TextSize = 12
    statusLabel.Parent = header

    local dropdownBtn = Instance.new("TextButton")
    dropdownBtn.Size = UDim2.new(1, -40, 0, 20)
    dropdownBtn.Position = UDim2.new(0, 20, 0, 35)
    dropdownBtn.BackgroundColor3 = Color3.fromRGB(40, 30, 60)
    dropdownBtn.Font = Enum.Font.Gotham
    dropdownBtn.Text = "  " .. options[1] .. "  ▼" -- Varsayılan seçim
    dropdownBtn.TextColor3 = theme.TextMain
    dropdownBtn.TextSize = 11
    dropdownBtn.TextXAlignment = Enum.TextXAlignment.Left
    dropdownBtn.Parent = frame
    applyCorner(dropdownBtn, 4)

    local dropdownFrame = Instance.new("ScrollingFrame")
    dropdownFrame.Size = UDim2.new(1, 0, 0, #options * 22)
    dropdownFrame.Position = UDim2.new(0, 0, 1, 0) -- DropdownBtn'in altında
    dropdownFrame.BackgroundColor3 = Color3.fromRGB(35, 25, 50)
    dropdownFrame.Visible = false
    dropdownFrame.ScrollBarThickness = 2
    dropdownFrame.ScrollBarImageColor3 = theme.Slider
    dropdownFrame.CanvasSize = UDim2.new(0, 0, 0, #options * 22)
    dropdownFrame.ZIndex = 5
    dropdownFrame.Parent = dropdownBtn
    applyCorner(dropdownFrame, 4)

    local uiList = Instance.new("UIListLayout")
    uiList.Padding = UDim.new(0, 1)
    uiList.Parent = dropdownFrame

    -- Mantık: Aç/Kapat
    dropdownBtn.MouseButton1Click:Connect(function() dropdownFrame.Visible = not dropdownFrame.Visible end)

    -- Seçenekler
    for _, optName in ipairs(options) do
        local optBtn = Instance.new("TextButton")
        optBtn.Size = UDim2.new(1, -5, 0, 20)
        optBtn.BackgroundColor3 = Color3.fromRGB(45, 35, 60)
        optBtn.Font = Enum.Font.Gotham
        optBtn.Text = "  " .. optName
        optBtn.TextColor3 = theme.TextSub
        optBtn.TextSize = 11
        optBtn.TextXAlignment = Enum.TextXAlignment.Left
        optBtn.Parent = dropdownFrame
        applyCorner(optBtn, 3)

        optBtn.MouseButton1Click:Connect(function()
            dropdownBtn.Text = "  " .. optName .. "  ▼"
            dropdownFrame.Visible = false
            statusLabel.Text = optName == options[1] and "Off" or "On" -- Eğer ilk seçenek seçiliyse Off (Varsayılan kapalı)
            statusLabel.TextColor3 = statusLabel.Text == "On" and theme.Slider or theme.TextSub
            if callback then callback(optName) end
        end)
    end
    
    return frame
end

-- 10. ÖZELLİKLERİ EKLEME (image_4.png Birebir)

-- Geyik Kafası/Yön İkonu ID'leri
local icon_directional = "rbxassetid://16027376378"
local icon_steal = "rbxassetid://16027376722"
local icon_aimbot = "rbxassetid://16027376912"
local icon_galaxy = "rbxassetid://16027377114"
local icon_speed = "rbxassetid://16027377287"

-- A) Basit Toggles
createToggleButton(featuresPage, icon_directional, "AUTO LEFT", function(state) print("Left: ", state) end)
createToggleButton(featuresPage, icon_directional, "AUTO RIGHT", function(state) print("Right: ", state) end)

-- B) Gelişmiş Toggles (Kaydırıcılı/Dropdownlu - image_4.png'daki gibi)

-- AUTO USA (image_4.png'da bir slider ve dropdown içeren panel)
createSliderFeature(featuresPage, icon_directional, "AUTO USA - Radius", 1, 100, 50, function(val) print("Radius: ", val) end)
createDropdownFeature(featuresPage, icon_directional, "AUTO USA - Target", {"Player/Chest", "Player", "Chest", "Boss"}, function(sel) print("Target: ", sel) end)

-- AUTO STEAL
createDropdownFeature(featuresPage, icon_steal, "AUTO STEAL - Target", {"Player/Chest", "Player", "Chest"}, function(sel) print("Steal Tar: ", sel) end)
createSliderFeature(featuresPage, icon_steal, "AUTO STEAL - Radius", 1, 100, 30, function(val) print("Steal Rad: ", val) end)

-- SPEED BOOST
createSliderFeature(featuresPage, icon_speed, "SPEED BOOST", 1, 10, 5, function(val)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 16 + (val * 4) -- Maksimum hız ~56
    end
end)

-- BAT AIMBOT
createSliderFeature(featuresPage, icon_aimbot, "BAT AIMBOT - Precision", 1, 5, 3, function(val) print("Precision: ", val) end)
createDropdownFeature(featuresPage, icon_aimbot, "BAT AIMBOT - Target Type", {"PvP/Mob", "PvP", "Mob"}, function(sel) print("Aimbot Tar: ", sel) end)

-- GALAXY MODE & OPTIMIZER
createToggleButton(featuresPage, icon_galaxy, "GALAXY MODE", function(state) print("Galaxy: ", state) end)
createToggleButton(featuresPage, icon_aimbot, "Optimizer + XRay", function(state) print("Optimizer: ", state) end) -- İkon tahmini

-- 11. DİĞER SEKMELER (Keybinds, Settings - Boş İçerik)
local function createPlaceholder(page, text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 40)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamMedium
    label.Text = text
    label.TextColor3 = theme.TextSub
    label.TextSize = 14
    label.Parent = page
end

createPlaceholder(keybindsPage, "[Coming Soon] - Buraya tuş atamaları gelecek.")
createPlaceholder(settingsPage, "[Coming Soon] - Buraya menü ayarları gelecek.")

-- ==========================================
-- 12. ALT BİLGİ (Footer)
-- ==========================================
local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 30)
footer.Position = UDim2.new(0, 0, 1, -30)
footer.BackgroundTransparency = 1
footer.Font = Enum.Font.Gotham
footer.Text = "discord.gg/menufiyhub"
footer.TextColor3 = theme.TextSub
footer.TextSize = 12
footer.ZIndex = 3
footer.Parent = mainFrame

local footerStroke = Instance.new("Frame")
footerStroke.Size = UDim2.new(1, -20, 0, 1)
footerStroke.Position = UDim2.new(0, 10, 0, 0)
footerStroke.BackgroundColor3 = Color3.fromRGB(30, 25, 50)
footerStroke.Parent = footer

print("Menufiy Hub `image_4.png` birebir tasarımı başarıyla yüklendi!")
