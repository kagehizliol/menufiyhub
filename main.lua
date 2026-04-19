--[[
    MENUFİY HUB - OPTIMIZED FOR EXECUTORS
    Tema: Modern Mor
]]

-- 1. ÜST ÜSTE BİNMEYİ ÖNLEME (Anti-Overlap)
if game:GetService("CoreGui"):FindFirstChild("MenufiyHub_UI") then
    game:GetService("CoreGui").MenufiyHub_UI:Destroy()
end

local player = game.Players.LocalPlayer
local coreGui = game:GetService("CoreGui") -- Executorlar için en güvenli yer

-- 2. ANA SCREEN GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MenufiyHub_UI"
screenGui.Parent = coreGui
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true

-- 3. RENK PALETİ (MODERN MOR)
local theme = {
    MainBg = Color3.fromRGB(18, 12, 28),      -- Derin Mor Arkaplan
    Border = Color3.fromRGB(110, 40, 230),   -- Parlak Mor Kenarlık
    ButtonDefault = Color3.fromRGB(30, 20, 45), -- Buton Kapalı
    ButtonActive = Color3.fromRGB(130, 60, 255), -- Buton Açık
    TextMain = Color3.fromRGB(255, 255, 255),
    TextSub = Color3.fromRGB(170, 140, 200),
    Accent = Color3.fromRGB(180, 100, 255)
}

-- YARDIMCI FONKSİYONLAR
local function applyCorner(obj, res)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, res)
    corner.Parent = obj
end

-- 4. ANA ÇERÇEVE (Main Frame)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 300, 0, 420)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -210)
mainFrame.BackgroundColor3 = theme.MainBg
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true -- Fareyle sürüklenebilir
mainFrame.Parent = screenGui
applyCorner(mainFrame, 10)

-- Kenarlık Efekti (Stroke)
local uiStroke = Instance.new("UIStroke")
uiStroke.Thickness = 2
uiStroke.Color = theme.Border
uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uiStroke.Parent = mainFrame

-- 5. BAŞLIK VE TAG
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Text = "MENUFİY HUB"
title.TextColor3 = theme.Accent
title.TextSize = 22
title.Parent = mainFrame

-- 6. SEKME SİSTEMİ (Tabs)
local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1, -20, 0, 35)
tabContainer.Position = UDim2.new(0, 10, 0, 50)
tabContainer.BackgroundTransparency = 1
tabContainer.Parent = mainFrame

local uiListTabs = Instance.new("UIListLayout")
uiListTabs.FillDirection = Enum.FillDirection.Horizontal
uiListTabs.Padding = UDim.new(0, 5)
uiListTabs.HorizontalAlignment = Enum.HorizontalAlignment.Center
uiListTabs.Parent = tabContainer

local function createTab(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 85, 1, 0)
    btn.BackgroundColor3 = theme.ButtonDefault
    btn.Font = Enum.Font.GothamMedium
    btn.Text = name
    btn.TextColor3 = theme.TextMain
    btn.TextSize = 14
    btn.Parent = tabContainer
    applyCorner(btn, 6)
    return btn
end

local featBtn = createTab("Features")
local keyBtn = createTab("Keybinds")
local settBtn = createTab("Settings")

-- 7. ÖZELLİKLER LİSTESİ (Scrolling Frame)
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -20, 1, -140)
scrollFrame.Position = UDim2.new(0, 10, 0, 95)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 2
scrollFrame.ScrollBarImageColor3 = theme.Accent
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 400)
scrollFrame.Parent = mainFrame

local uiListFeat = Instance.new("UIListLayout")
uiListFeat.Padding = UDim.new(0, 7)
uiListFeat.HorizontalAlignment = Enum.HorizontalAlignment.Center
uiListFeat.Parent = scrollFrame

-- ÖZELLİK BUTONU OLUŞTURUCU
local function addFeature(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -5, 0, 35)
    btn.BackgroundColor3 = theme.ButtonDefault
    btn.Font = Enum.Font.Gotham
    btn.Text = name
    btn.TextColor3 = theme.TextMain
    btn.TextSize = 14
    btn.Parent = scrollFrame
    applyCorner(btn, 6)

    local toggled = false
    btn.MouseButton1Click:Connect(function()
        toggled = not toggled
        btn.BackgroundColor3 = toggled and theme.ButtonActive or theme.ButtonDefault
        if callback then callback(toggled) end
    end)
end

-- BUTONLARA İŞLEV EKLEME ALANI
addFeature("Auto Steal", function(state)
    print("Auto Steal: ", state)
    -- Buraya Auto Steal kodun gelecek
end)

addFeature("Speed Boost", function(state)
    if state then
        player.Character.Humanoid.WalkSpeed = 60
    else
        player.Character.Humanoid.WalkSpeed = 16
    end
end)

addFeature("Bat Aimbot", function(state)
    print("Aimbot: ", state)
end)

addFeature("Anti Ragdoll", function(state)
    print("Anti Ragdoll: ", state)
end)

addFeature("Galaxy Mode", function(state)
    print("Galaxy Mode: ", state)
end)

-- 8. ALT BİLGİ (Footer)
local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 30)
footer.Position = UDim2.new(0, 0, 1, -30)
footer.BackgroundTransparency = 1
footer.Font = Enum.Font.Gotham
footer.Text = "discord.gg/menufiyhub"
footer.TextColor3 = theme.TextSub
footer.TextSize = 12
footer.Parent = mainFrame

-- MENÜYÜ AÇIP KAPATMA TUŞU (Insert)
game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.Insert then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

print("Menufiy Hub Başarıyla Yüklendi! Kapatmak için 'Insert' tuşuna bas.")
