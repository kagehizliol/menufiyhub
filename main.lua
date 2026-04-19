local player = game.Players.LocalPlayer
local coreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

if coreGui:FindFirstChild("MenufiyHub_UI") then
    coreGui.MenufiyHub_UI:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MenufiyHub_UI"
screenGui.Parent = coreGui
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local theme = {
    MainBg = Color3.fromRGB(15, 0, 30),
    Border = Color3.fromRGB(100, 30, 200),
    ButtonDefault = Color3.fromRGB(30, 0, 60),
    ButtonActive = Color3.fromRGB(120, 50, 220),
    SliderBg = Color3.fromRGB(45, 10, 80),
    TextMain = Color3.fromRGB(255, 255, 255)
}

local toggleBtn = Instance.new("ImageButton")
toggleBtn.Name = "Toggle"
toggleBtn.Size = UDim2.new(0, 50, 0, 50)
toggleBtn.Position = UDim2.new(0.02, 0, 0.4, 0)
toggleBtn.BackgroundColor3 = theme.MainBg
toggleBtn.Image = "rbxassetid://6031094678"
toggleBtn.Parent = screenGui
local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 10)
btnCorner.Parent = toggleBtn
local btnStroke = Instance.new("UIStroke")
btnStroke.Color = theme.Border
btnStroke.Thickness = 2
btnStroke.Parent = toggleBtn

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 280, 0, 420)
mainFrame.Position = UDim2.new(0.5, -140, 0.5, -210)
mainFrame.BackgroundColor3 = theme.MainBg
mainFrame.BorderSizePixel = 0
mainFrame.Visible = true
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui
local mainCorner = Instance.new("UICorner")
mainCorner.Parent = mainFrame
local mainStroke = Instance.new("UIStroke")
mainStroke.Color = theme.Border
mainStroke.Thickness = 2
mainStroke.Parent = mainFrame

toggleBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Text = "MENUFİY HUB"
title.TextColor3 = theme.TextMain
title.TextSize = 22
title.Parent = mainFrame

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -20, 1, -70)
scroll.Position = UDim2.new(0, 10, 0, 55)
scroll.BackgroundTransparency = 1
scroll.CanvasSize = UDim2.new(0, 0, 0, 550)
scroll.ScrollBarThickness = 2
scroll.Parent = mainFrame
local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 10)
layout.Parent = scroll

local speedBoosted = false
local boostSpeed = 16
local originalWalkSpeed = 16
local infJumpEnabled = false
local lastUpdate = 0
local updateCooldown = 0.1

local function createSpeedFeature()
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -5, 0, 35)
    container.BackgroundTransparency = 1
    container.ClipsDescendants = true
    container.Parent = scroll
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.BackgroundColor3 = theme.ButtonDefault
    btn.Text = "Speed Boost"
    btn.Font = Enum.Font.GothamMedium
    btn.TextColor3 = theme.TextMain
    btn.TextSize = 14
    btn.Parent = container
    local c1 = Instance.new("UICorner")
    c1.CornerRadius = UDim.new(0, 6)
    c1.Parent = btn
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, 0, 0, 45)
    sliderFrame.Position = UDim2.new(0, 0, 0, 40)
    sliderFrame.BackgroundColor3 = theme.SliderBg
    sliderFrame.Parent = container
    local c2 = Instance.new("UICorner")
    c2.CornerRadius = UDim.new(0, 6)
    c2.Parent = sliderFrame
    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(0.8, 0, 0, 6)
    bar.Position = UDim2.new(0.1, 0, 0.6, 0)
    bar.BackgroundColor3 = theme.ButtonDefault
    bar.Parent = sliderFrame
    Instance.new("UICorner", bar)
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(0, 0, 1, 0)
    fill.BackgroundColor3 = theme.ButtonActive
    fill.Parent = bar
    Instance.new("UICorner", fill)
    local valLabel = Instance.new("TextLabel")
    valLabel.Size = UDim2.new(1, 0, 0, 20)
    valLabel.BackgroundTransparency = 1
    valLabel.Text = "Hiz: 16"
    valLabel.TextColor3 = theme.TextMain
    valLabel.Font = Enum.Font.Gotham
    valLabel.TextSize = 12
    valLabel.Parent = sliderFrame
    btn.MouseButton1Click:Connect(function()
        speedBoosted = not speedBoosted
        btn.BackgroundColor3 = speedBoosted and theme.ButtonActive or theme.ButtonDefault
        container.Size = speedBoosted and UDim2.new(1, -5, 0, 90) or UDim2.new(1, -5, 0, 35)
    end)
    local dragging = false
    local function updateSlider(input)
        local pos = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        fill.Size = UDim2.new(pos, 0, 1, 0)
        boostSpeed = math.floor(16 + (pos * 184))
        valLabel.Text = "Hiz: " .. tostring(boostSpeed)
    end
    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true updateSlider(input) end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then updateSlider(input) end
    end)
end

local function addInfJump()
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -5, 0, 35)
    b.BackgroundColor3 = theme.ButtonDefault
    b.Text = "Infinity Jump"
    b.Font = Enum.Font.GothamMedium
    b.TextColor3 = theme.TextMain
    b.TextSize = 14
    b.Parent = scroll
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = b
    b.MouseButton1Click:Connect(function()
        infJumpEnabled = not infJumpEnabled
        b.BackgroundColor3 = infJumpEnabled and theme.ButtonActive or theme.ButtonDefault
    end)
end

local function addUnload()
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -5, 0, 35)
    b.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    b.Text = "Menuyu Kapat"
    b.Font = Enum.Font.GothamBold
    b.TextColor3 = theme.TextMain
    b.TextSize = 14
    b.Parent = scroll
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = b
    b.MouseButton1Click:Connect(function()
        speedBoosted = false
        infJumpEnabled = false
        if player.Character and player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.WalkSpeed = originalWalkSpeed end
        screenGui:Destroy()
    end)
end

createSpeedFeature()
addInfJump()
addUnload()

RunService.Heartbeat:Connect(function(deltaTime)
    lastUpdate = lastUpdate + deltaTime
    if lastUpdate >= updateCooldown then
        lastUpdate = 0
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            local humanoid = player.Character.Humanoid
            if speedBoosted then
                humanoid.WalkSpeed = boostSpeed
            else
                humanoid.WalkSpeed = originalWalkSpeed
            end
        end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if infJumpEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.Velocity = Vector3.new(player.Character.HumanoidRootPart.Velocity.X, 50, player.Character.HumanoidRootPart.Velocity.Z)
    end
end)
