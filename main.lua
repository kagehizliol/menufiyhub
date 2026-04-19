local player = game.Players.LocalPlayer
local coreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

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
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", toggleBtn).Color = theme.Border

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 280, 0, 420)
mainFrame.Position = UDim2.new(0.5, -140, 0.5, -210)
mainFrame.BackgroundColor3 = theme.MainBg
mainFrame.Visible = true
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui
Instance.new("UICorner", mainFrame)
Instance.new("UIStroke", mainFrame).Color = theme.Border

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
scroll.CanvasSize = UDim2.new(0, 0, 0, 600)
scroll.ScrollBarThickness = 0
scroll.Parent = mainFrame
local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 10)
layout.SortOrder = Enum.SortOrder.LayoutOrder

local speedBoosted = false
local boostSpeed = 16
local infJumpEnabled = false
local autoStealEnabled = false

local function addBtn(name, order, callback)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -5, 0, 35)
    b.BackgroundColor3 = theme.ButtonDefault
    b.Text = name
    b.Font = Enum.Font.GothamMedium
    b.TextColor3 = theme.TextMain
    b.TextSize = 14
    b.LayoutOrder = order
    b.Parent = scroll
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    local toggled = false
    b.MouseButton1Click:Connect(function()
        toggled = not toggled
        b.BackgroundColor3 = toggled and theme.ButtonActive or theme.ButtonDefault
        callback(toggled)
    end)
end

-- SPEED
local container = Instance.new("Frame")
container.Size = UDim2.new(1, -5, 0, 35)
container.BackgroundTransparency = 1
container.ClipsDescendants = true
container.LayoutOrder = 1
container.Parent = scroll
local sBtn = Instance.new("TextButton")
sBtn.Size = UDim2.new(1, 0, 0, 35)
sBtn.BackgroundColor3 = theme.ButtonDefault
sBtn.Text = "Speed Boost"
sBtn.Font = Enum.Font.GothamMedium
sBtn.TextColor3 = theme.TextMain
sBtn.TextSize = 14
sBtn.Parent = container
Instance.new("UICorner", sBtn).CornerRadius = UDim.new(0, 6)
local sliderFrame = Instance.new("Frame", container)
sliderFrame.Size = UDim2.new(1, 0, 0, 45)
sliderFrame.Position = UDim2.new(0, 0, 0, 40)
sliderFrame.BackgroundColor3 = theme.SliderBg
Instance.new("UICorner", sliderFrame).CornerRadius = UDim.new(0, 6)
local bar = Instance.new("Frame", sliderFrame)
bar.Size = UDim2.new(0.8, 0, 0, 6)
bar.Position = UDim2.new(0.1, 0, 0.6, 0)
bar.BackgroundColor3 = theme.ButtonDefault
local fill = Instance.new("Frame", bar)
fill.Size = UDim2.new(0, 0, 1, 0)
fill.BackgroundColor3 = theme.ButtonActive
local valLabel = Instance.new("TextLabel", sliderFrame)
valLabel.Size = UDim2.new(1, 0, 0, 20)
valLabel.BackgroundTransparency = 1
valLabel.Text = "Hiz: 16"
valLabel.TextColor3 = theme.TextMain
valLabel.TextSize = 12
sBtn.MouseButton1Click:Connect(function()
    speedBoosted = not speedBoosted
    sBtn.BackgroundColor3 = speedBoosted and theme.ButtonActive or theme.ButtonDefault
    container.Size = speedBoosted and UDim2.new(1, -5, 0, 90) or UDim2.new(1, -5, 0, 35)
end)
local dragging = false
local function updateSlider(input)
    local pos = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
    fill.Size = UDim2.new(pos, 0, 1, 0)
    boostSpeed = math.floor(16 + (pos * 234))
    valLabel.Text = "Hiz: " .. tostring(boostSpeed)
end
bar.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true updateSlider(input) end end)
UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
UserInputService.InputChanged:Connect(function(input) if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then updateSlider(input) end end)

addBtn("Infinity Jump", 2, function(v) infJumpEnabled = v end)
addBtn("Safe Auto Steal", 3, function(v) autoStealEnabled = v end)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(1, -5, 0, 35)
closeBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
closeBtn.Text = "Menuyu Kapat"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextColor3 = theme.TextMain
closeBtn.LayoutOrder = 10
closeBtn.Parent = scroll
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
closeBtn.MouseButton1Click:Connect(function()
    speedBoosted = false
    infJumpEnabled = false
    if player.Character and player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.WalkSpeed = 16 end
    screenGui:Destroy()
end)

RunService.Stepped:Connect(function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = speedBoosted and boostSpeed or 16
    end
    
    if autoStealEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local myPos = player.Character.HumanoidRootPart.Position
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("ProximityPrompt") then
                local dist = (v.Parent:IsA("Model") and v.Parent.PrimaryPart and (v.Parent.PrimaryPart.Position - myPos).Magnitude) or (v.Parent:IsA("BasePart") and (v.Parent.Position - myPos).Magnitude) or 100
                if dist < 12 then -- Sadece 12 birim yanındakileri al
                    if v.Parent.Name:lower():find("brainrot") or v.ObjectText:lower():find("brainrot") or v.ActionText:lower():find("brainrot") then
                        fireproximityprompt(v)
                    end
                end
            elseif v:IsA("TouchTransmitter") then
                local part = v.Parent
                if part:IsA("BasePart") and (part.Position - myPos).Magnitude < 12 then
                    if part.Name:lower():find("brainrot") then
                        firetouchinterest(player.Character.HumanoidRootPart, part, 0)
                        firetouchinterest(player.Character.HumanoidRootPart, part, 1)
                    end
                end
            end
        end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if infJumpEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.Velocity = Vector3.new(player.Character.HumanoidRootPart.Velocity.X, 50, player.Character.HumanoidRootPart.Velocity.Z)
    end
end)
