-- MENUFİY HUB - INFINITY JUMP & REVERTED DESIGN
local player = game.Players.LocalPlayer
local coreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

-- Eski sürümü temizle
if coreGui:FindFirstChild("MenufiyHub_UI") then
    coreGui.MenufiyHub_UI:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MenufiyHub_UI"
screenGui.Parent = coreGui
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- TEMA RENKLERİ
local theme = {
    MainBg = Color3.fromRGB(15, 0, 30),
    Border = Color3.fromRGB(100, 30, 200),
    ButtonDefault = Color3.fromRGB(30, 0, 60),
    ButtonActive = Color3.fromRGB(120, 50, 220),
    TextMain = Color3.fromRGB(255, 255, 255)
}

-- 1. AÇMA/KAPAMA TUŞU (Senin istediğin ikon ile)
local toggleBtn = Instance.new("ImageButton")
toggleBtn.Name = "Toggle"
toggleBtn.Size = UDim2.new(0, 50, 0, 50)
toggleBtn.Position = UDim2.new(0.02, 0, 0.4, 0)
toggleBtn.BackgroundColor3 = theme.MainBg
toggleBtn.Image = "rbxassetid://6031094678" -- Hazır menü çizgileri ikonu
toggleBtn.Parent = screenGui

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 10)
btnCorner.Parent = toggleBtn

local btnStroke = Instance.new("UIStroke")
btnStroke.Color = theme.Border
btnStroke.Thickness = 2
btnStroke.Parent = toggleBtn

-- 2. ANA ÇERÇEVE
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 260, 0, 380)
mainFrame.Position = UDim2.new(0.5, -130, 0.5, -190)
mainFrame.BackgroundColor3 = theme.MainBg
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = theme.Border
mainFrame.Visible = true
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.Parent = mainFrame

-- Aç/Kapat Mantığı
toggleBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

-- 3. BAŞLIK
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Text = "MENUFİY HUB"
title.TextColor3 = theme.TextMain
title.TextSize = 20
title.Parent = mainFrame

-- 4. ÖZELLİKLER LİSTESİ
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -20, 1, -60)
scroll.Position = UDim2.new(0, 10, 0, 50)
scroll.BackgroundTransparency = 1
scroll.CanvasSize = UDim2.new(0, 0, 0, 450)
scroll.ScrollBarThickness = 3
scroll.Parent = mainFrame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 5)
layout.Parent = scroll

-- BUTON OLUŞTURMA FONKSİYONU
local function addBtn(name, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -5, 0, 35)
    b.BackgroundColor3 = theme.ButtonDefault
    b.Font = Enum.Font.GothamMedium
    b.Text = name
    b.TextColor3 = theme.TextMain
    b.TextSize = 14
    b.Parent = scroll
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = b
    
    local toggled = false
    b.MouseButton1Click:Connect(function()
        toggled = not toggled
        b.BackgroundColor3 = toggled and theme.ButtonActive or theme.ButtonDefault
        if callback then callback(toggled) end
    end)
end

-- ==========================================
-- ÖZELLİKLER
-- ==========================================

-- INFINITY JUMP MANTIĞI
local infJumpEnabled = false
UserInputService.JumpRequest:Connect(function()
    if infJumpEnabled then
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.Velocity = Vector3.new(hrp.Velocity.X, 50, hrp.Velocity.Z)
        end
    end
end)

-- BUTONLAR
addBtn("Infinity Jump", function(v)
    infJumpEnabled = v
end)

addBtn("Speed Boost", function(v) 
    player.Character.Humanoid.WalkSpeed = v and 60 or 16 
end)

addBtn("Auto Steal", function(v) print("Steal:", v) end)
addBtn("Galaxy Mode", function(v) print("Galaxy:", v) end)
addBtn("Anti Ragdoll", function(v) print("AntiRag:", v) end)

print("Menufiy Hub: Infinity Jump eklendi!")
