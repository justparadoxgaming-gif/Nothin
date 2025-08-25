
--// Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local SoundService = game:GetService("SoundService")

local LocalPlayer = Players.LocalPlayer
local isMobile = UserInputService.TouchEnabled
local startTime = tick()

--// GUI Setup
local gui = Instance.new("ScreenGui")
gui.Name = "CentuDox"
gui.Parent = game:GetService("CoreGui")
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.ResetOnSpawn = false

-- Main Frame
local mainGui = Instance.new("Frame", gui)
mainGui.Name = "SymphonyMainGui"
mainGui.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
mainGui.BackgroundTransparency = 0.35
mainGui.Size = UDim2.new(0.65, 0, 0.9, 0)
mainGui.Position = UDim2.new(0.175, 0, 0.1, 0)
mainGui.BorderSizePixel = 0
mainGui.Active = true
mainGui.ZIndex = 1
mainGui.Visible = true
Instance.new("UICorner", mainGui).CornerRadius = UDim.new(0, 25)

-- Smooth red ↔ blue outline
local stroke = Instance.new("UIStroke", mainGui)
stroke.Thickness = 3
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
task.spawn(function()
    local t = 0
    while stroke and stroke.Parent do
        local r = 127 + 127 * math.sin(t)
        local b = 127 + 127 * math.cos(t)
        stroke.Color = Color3.fromRGB(r, 0, b)
        t = t + 0.05
        task.wait(0.02)
    end
end)



--- Title
local mainTitle = Instance.new("TextLabel", mainGui)
mainTitle.Text = "Blox Fruits #1 Aimbot Hub ==> CentuDox 0.5"
mainTitle.Font = Enum.Font.GothamBold
mainTitle.TextSize = 26
mainTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
mainTitle.BackgroundTransparency = 1
mainTitle.Position = UDim2.new(0.38, -225, 0.02, 0)
mainTitle.Size = UDim2.new(0, 600, 0, 50)
mainTitle.ZIndex = 2

-- 🌈 RGB Text Effect
task.spawn(function()
    local t = 0
    while mainTitle and mainTitle.Parent do
        local r = 127 + 127 * math.sin(t)
        local g = 127 + 127 * math.sin(t + 2) -- shifted so green cycles separately
        local b = 127 + 127 * math.sin(t + 4) -- shifted so blue cycles separately
        mainTitle.TextColor3 = Color3.fromRGB(r, g, b)
        t = t + 0.05
        task.wait(0.03)
    end
end)




-- Tab Frame
local tabFrame = Instance.new("ScrollingFrame", mainGui)
tabFrame.Size = UDim2.new(0, 170, 1, -60)
tabFrame.Position = UDim2.new(0.02, 0, 0.12, 0)
tabFrame.BackgroundTransparency = 1
tabFrame.ScrollBarThickness = 3
tabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
tabFrame.ZIndex = 2

-- Content Area
local contentArea = Instance.new("ScrollingFrame", mainGui)
contentArea.Name = "TabContent"
contentArea.Position = UDim2.new(0.3, 0, 0.12, 0)
contentArea.Size = UDim2.new(0.68, 0, 0.8, 0)
contentArea.BackgroundTransparency = 1
contentArea.CanvasSize = UDim2.new(0, 0, 2.1, 0)
contentArea.ScrollBarThickness = 3
contentArea.ZIndex = 2

-- Sounds
local toggleSound = Instance.new("Sound", gui)
toggleSound.SoundId = "rbxassetid://6895079853"
toggleSound.Volume = 1

local tabSound = Instance.new("Sound", gui)
tabSound.SoundId = "rbxassetid://111174530730534"
tabSound.Volume = 1

-- Tabs
local tabInfo = {
    {Name = "Main", Icon = "rbxassetid://101341665485984"},
    {Name = "Visual", Icon = "rbxassetid://133449748838127"},
    {Name = "Combat", Icon = "rbxassetid://114325401780469"},
    {Name = "Settings", Icon = "rbxassetid://71680634825856"}
}

for i, info in ipairs(tabInfo) do
    local tab = Instance.new("TextButton", tabFrame)
    tab.Name = info.Name .. "Tab"
    tab.Text = "" -- clear, we’ll add text separately
    tab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tab.BackgroundTransparency = 0.5
    tab.Size = UDim2.new(1, -10, 0, 45)
    tab.Position = UDim2.new(0, 5, 0, (i - 1) * 55)
    tab.ZIndex = 3
    tab.AutoButtonColor = true
    Instance.new("UICorner", tab).CornerRadius = UDim.new(0, 10)
    local stroke = Instance.new("UIStroke", tab)
    stroke.Thickness = 1.2
    stroke.Color = Color3.fromRGB(100, 100, 100)

    -- Layout (horizontal for icon + text)
    local layout = Instance.new("UIListLayout", tab)
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.VerticalAlignment = Enum.VerticalAlignment.Center
    layout.Padding = UDim.new(0, 6)

    -- Icon
    local icon = Instance.new("ImageLabel", tab)
    icon.Image = info.Icon
    icon.BackgroundTransparency = 1
    icon.Size = UDim2.new(0, 24, 0, 24)
    icon.ZIndex = 4

    -- Text
    local label = Instance.new("TextLabel", tab)
    label.Text = info.Name
    label.Font = Enum.Font.GothamBold
    label.TextSize = 22
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.BackgroundTransparency = 1
    label.ZIndex = 4
    label.Size = UDim2.new(1, -30, 1, 0) -- leave space for icon

    -- Tab switching
    tab.MouseButton1Click:Connect(function()
        tabSound:Play()
        for _, child in pairs(contentArea:GetChildren()) do
            if child:IsA("Frame") then
                child.Visible = (child.Name == info.Name .. "Box")
            end
        end
    end)
end

-- Toggle Button
local toggleButton = Instance.new("ImageButton", gui)
toggleButton.Image = "rbxassetid://109358824258439"
toggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleButton.Size = UDim2.new(0, 55, 0, 55)
toggleButton.Position = UDim2.new(0.02, 0, 0.02, 0)
toggleButton.Active = true
toggleButton.Draggable = true
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(1, 0)

toggleButton.MouseButton1Click:Connect(function()
toggleSound:Play()
mainGui.Visible = not mainGui.Visible
end)



-- MAIN TAB BOX
local mainBox = Instance.new("Frame", contentArea)
mainBox.Name = "MainBox"
mainBox.Size = UDim2.new(1, -20, 0, 200)
mainBox.Position = UDim2.new(0, 10, 0, 10)
mainBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainBox.BackgroundTransparency = 0.3
mainBox.ZIndex = 3
mainBox.Visible = true
Instance.new("UICorner", mainBox).CornerRadius = UDim.new(0, 10)

local mainStroke = Instance.new("UIStroke", mainBox)
mainStroke.Thickness = 2
mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
task.spawn(function()
    local hue = 0.5
    while mainStroke and mainStroke.Parent do
        local r, g, b = Color3.fromHSV(hue, 1, 1):ToRGB()
        mainStroke.Color = Color3.fromRGB(r, g, b)
        hue = (hue + 0.0015) % 1
        task.wait(0.01)
    end
end)

-- Avatar Headshot
local headshotBox = Instance.new("Frame", mainBox)
headshotBox.Size = UDim2.new(0, 80, 0, 80)
headshotBox.Position = UDim2.new(0, 20, 0, 20)
headshotBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
local corner = Instance.new("UICorner", headshotBox)
corner.CornerRadius = UDim.new(1, 0)

local redStroke = Instance.new("UIStroke", headshotBox)
redStroke.Color = Color3.fromRGB(255, 0, 0)
redStroke.Thickness = 3
redStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local thumbType = Enum.ThumbnailType.HeadShot
local thumbSize = Enum.ThumbnailSize.Size100x100
local content, isReady = Players:GetUserThumbnailAsync(LocalPlayer.UserId, thumbType, thumbSize)

local headshotImage = Instance.new("ImageLabel", headshotBox)
headshotImage.Size = UDim2.new(1, -6, 1, -6)
headshotImage.Position = UDim2.new(0, 3, 0, 3)
headshotImage.BackgroundTransparency = 1
headshotImage.Image = content
Instance.new("UICorner", headshotImage).CornerRadius = UDim.new(1, 0)

-- Username + DisplayName
local nameLabel = Instance.new("TextLabel", mainBox)
nameLabel.Position = UDim2.new(0, 110, 0, 35)
nameLabel.Size = UDim2.new(0, 300, 0, 30)
nameLabel.BackgroundTransparency = 1
nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
nameLabel.Font = Enum.Font.GothamBold
nameLabel.TextSize = 18
nameLabel.TextXAlignment = Enum.TextXAlignment.Left
nameLabel.RichText = true
nameLabel.Text = '<font color="#00FF00">' .. LocalPlayer.Name .. '</font> <font color="#FFA500">(' .. LocalPlayer.DisplayName .. ')</font>'

-- FPS Label
local fpsLabel = Instance.new("TextLabel", mainBox)
fpsLabel.Position = UDim2.new(0, 130, 0, 75)
fpsLabel.Size = UDim2.new(0, 200, 0, 25)
fpsLabel.BackgroundTransparency = 1
fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.TextSize = 16
fpsLabel.TextXAlignment = Enum.TextXAlignment.Left
fpsLabel.Text = "FPS: 0"

task.spawn(function()
    while true do
        local start = tick()
        local frameCount = 0
        local connection
        connection = RunService.RenderStepped:Connect(function()
            frameCount += 1
        end)
        wait(2)
        connection:Disconnect()
        local fps = math.floor(frameCount / 2)
        fpsLabel.Text = "FPS: " .. tostring(fps)
    end
end)

-- Ping Label
local pingLabel = Instance.new("TextLabel", mainBox)
pingLabel.Position = UDim2.new(0, 260, 0, 75)
pingLabel.Size = UDim2.new(0, 200, 0, 25)
pingLabel.BackgroundTransparency = 1
pingLabel.TextColor3 = Color3.fromRGB(120, 180, 255)
pingLabel.Font = Enum.Font.GothamBold
pingLabel.TextSize = 16
pingLabel.TextXAlignment = Enum.TextXAlignment.Left
pingLabel.Text = "Ping: ..."

task.spawn(function()
    while true do
        local ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
        pingLabel.Text = "Ping: " .. math.floor(ping) .. " ms"
        wait(2.5)
    end
end)

-- Team Label
local teamLabel = Instance.new("TextLabel", mainBox)
teamLabel.Position = UDim2.new(0, 130, 0, 105) -- below FPS
teamLabel.Size = UDim2.new(0, 200, 0, 25)
teamLabel.BackgroundTransparency = 1
teamLabel.Font = Enum.Font.GothamBold
teamLabel.TextSize = 16
teamLabel.TextXAlignment = Enum.TextXAlignment.Left
teamLabel.Text = "Team: ..."
teamLabel.TextColor3 = Color3.fromRGB(255, 165, 0) -- orange default

task.spawn(function()
    while true do
        local team = LocalPlayer.Team
        if team then
            if team.Name == "Pirates" then
                teamLabel.Text = "Team: Pirates"
                teamLabel.TextColor3 = Color3.fromRGB(255, 0, 0) -- red
            elseif team.Name == "Marines" then
                teamLabel.Text = "Team: Marines"
                teamLabel.TextColor3 = Color3.fromRGB(0, 150, 255) -- blue
            else
                teamLabel.Text = "Team: " .. team.Name
                teamLabel.TextColor3 = Color3.fromRGB(255, 165, 0) -- fallback orange
            end
        else
            teamLabel.Text = "Team: None"
            teamLabel.TextColor3 = Color3.fromRGB(255, 165, 0)
        end
        task.wait(2)
    end
end)

-- Bounty/Honor Label
local bountyLabel = Instance.new("TextLabel", mainBox)
bountyLabel.Position = UDim2.new(0, 250, 0, 105) -- beside Team
bountyLabel.Size = UDim2.new(0, 200, 0, 25)
bountyLabel.BackgroundTransparency = 1
bountyLabel.Font = Enum.Font.GothamBold
bountyLabel.TextSize = 16
bountyLabel.TextXAlignment = Enum.TextXAlignment.Left
bountyLabel.TextColor3 = Color3.fromRGB(139, 0, 0) -- dark red
bountyLabel.Text = "Bounty/Honor: 0"

task.spawn(function()
    while true do
        local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
        if leaderstats then
            local bh = leaderstats:FindFirstChild("Bounty/Honor")
            if bh then
                bountyLabel.Text = "Bounty/Honor: " .. tostring(bh.Value)
            end
        end
        task.wait(1) -- update every second
    end
end)

-- Level Label (below Team)
local levelLabel = Instance.new("TextLabel", mainBox)
levelLabel.Position = UDim2.new(0, 130, 0, 135) -- right below Team
levelLabel.Size = UDim2.new(0, 200, 0, 25)
levelLabel.BackgroundTransparency = 1
levelLabel.Font = Enum.Font.GothamBold
levelLabel.TextSize = 16
levelLabel.TextXAlignment = Enum.TextXAlignment.Left
levelLabel.Text = "Level: ..."
levelLabel.TextColor3 = Color3.fromRGB(0, 255, 127) -- greenish default

task.spawn(function()
    while true do
        local data = LocalPlayer:FindFirstChild("Data")
        if data and data:FindFirstChild("Level") then
            levelLabel.Text = "Level: " .. tostring(data.Level.Value)
        else
            levelLabel.Text = "Level: ..."
        end
        task.wait(2)
    end
end)

-- SELF-MODIFICATIONS Heading (only inside Main tab)
local modsHeading = Instance.new("TextLabel", mainBox)
modsHeading.Name = "ModsHeading"
modsHeading.Size = UDim2.new(1, -20, 0, 40)
modsHeading.Position = UDim2.new(0, 10, 0, mainBox.Size.Y.Offset + 15)
modsHeading.BackgroundTransparency = 1
modsHeading.Font = Enum.Font.FredokaOne -- cool modern font
modsHeading.TextSize = 22
modsHeading.TextXAlignment = Enum.TextXAlignment.Left
modsHeading.TextColor3 = Color3.fromRGB(20, 80, 200) -- dark blue
modsHeading.TextStrokeTransparency = 0.4
modsHeading.Text = "SELF-MODIFICATIONS"

-- Underline
local underline = Instance.new("Frame", modsHeading)
underline.Size = UDim2.new(0.35, 0, 0, 2)
underline.Position = UDim2.new(0, 0, 1, -3)
underline.BackgroundColor3 = Color3.fromRGB(20, 80, 200)
underline.BorderSizePixel = 0

-- Glow effect
local glow = Instance.new("UIStroke", underline)
glow.Thickness = 4
glow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
glow.Color = Color3.fromRGB(0, 0, 150)
glow.Transparency = 0.2

-- // WalkSpeed Section
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- Character + Humanoid handler
local function getHumanoid()
	local char = player.Character or player.CharacterAdded:Wait()
	return char:WaitForChild("Humanoid")
end

local humanoid = getHumanoid()
player.CharacterAdded:Connect(function(char)
	humanoid = char:WaitForChild("Humanoid")
end)

-- WalkSpeed container
local wsFrame = Instance.new("Frame", mainBox)
wsFrame.Size = UDim2.new(1, -20, 0, 90)
wsFrame.Position = UDim2.new(0, 10, 0, modsHeading.Position.Y.Offset + modsHeading.Size.Y.Offset + 10)
wsFrame.BackgroundTransparency = 0.3
wsFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
wsFrame.BorderSizePixel = 0
wsFrame.Name = "WalkSpeedSection"
Instance.new("UICorner", wsFrame).CornerRadius = UDim.new(0, 8)

-- Label
local wsLabel = Instance.new("TextLabel", wsFrame)
wsLabel.Size = UDim2.new(0.6, 0, 0, 25)
wsLabel.Position = UDim2.new(0, 5, 0, 5)
wsLabel.BackgroundTransparency = 1
wsLabel.Font = Enum.Font.FredokaOne
wsLabel.TextSize = 18
wsLabel.TextXAlignment = Enum.TextXAlignment.Left
wsLabel.TextColor3 = Color3.fromRGB(200, 220, 255)
wsLabel.Text = "Enable WalkSpeed"

-- Toggle
local toggleBtn = Instance.new("ImageButton", wsFrame)
toggleBtn.Size = UDim2.new(0, 30, 0, 30)
toggleBtn.Position = UDim2.new(1, -40, 0, 0)
toggleBtn.BackgroundTransparency = 1
toggleBtn.Image = "rbxassetid://97439421965675"

local toggleOn = false
local toggleOnImage = "rbxassetid://122477350304902"
local toggleOffImage = "rbxassetid://97439421965675"
local toggleSound = Instance.new("Sound", toggleBtn)
toggleSound.SoundId = "rbxassetid://18755588842"

-- Input background
local inputBg = Instance.new("ImageLabel", wsFrame)
inputBg.Size = UDim2.new(0, 60, 0, 25)
inputBg.Position = UDim2.new(0, 5, 0, 40)
inputBg.Image = "rbxassetid://121978541146753"
inputBg.BackgroundTransparency = 1
inputBg.ZIndex = 0

-- Input box
local inputBox = Instance.new("TextBox", wsFrame)
inputBox.Size = UDim2.new(0, 60, 0, 25)
inputBox.Position = UDim2.new(0, 5, 0, 40)
inputBox.BackgroundTransparency = 1
inputBox.Text = "16"
inputBox.Font = Enum.Font.FredokaOne
inputBox.TextSize = 16
inputBox.TextColor3 = Color3.fromRGB(255,255,255)
inputBox.ClearTextOnFocus = false
inputBox.ZIndex = 1

-- Slider background
local sliderBg = Instance.new("Frame", wsFrame)
sliderBg.Size = UDim2.new(0.8, 0, 0, 8)
sliderBg.Position = UDim2.new(0, 5, 0, 75)
sliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
sliderBg.BorderSizePixel = 0
Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(1,0)

-- Knob
local knob = Instance.new("Frame", sliderBg)
knob.Size = UDim2.new(0, 16, 0, 16)
knob.Position = UDim2.new(0, -8, -0.25, 0)
knob.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

local stroke = Instance.new("UIStroke", knob)
stroke.Color = Color3.fromRGB(0, 100, 255)
stroke.Thickness = 3

-- Values
local wsValue = 16
local maxSpeed = 200
local isDragging = false

-- Knob drag
knob.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		isDragging = true
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		isDragging = false
	end
end)

UIS.InputChanged:Connect(function(input)
	if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local relX = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
		knob.Position = UDim2.new(relX, -8, -0.25, 0)
		wsValue = math.floor(relX * maxSpeed)
		inputBox.Text = tostring(wsValue)
	end
end)

-- Manual input
inputBox.FocusLost:Connect(function()
	local val = tonumber(inputBox.Text)
	if val and val > 0 then
		wsValue = math.clamp(val, 1, maxSpeed)
	else
		wsValue = 16
	end
	inputBox.Text = tostring(wsValue)
end)

-- Toggle
toggleBtn.MouseButton1Click:Connect(function()
	toggleOn = not toggleOn
	toggleBtn.Image = toggleOn and toggleOnImage or toggleOffImage
	toggleSound:Play()
end)

-- Speed loop
RunService.RenderStepped:Connect(function()
	if toggleOn and humanoid and humanoid.Parent then
		humanoid.WalkSpeed = wsValue
	end
end)




-- JumpPower container
local jpFrame = Instance.new("Frame", mainBox)
jpFrame.Size = UDim2.new(1, -20, 0, 90)
jpFrame.Position = UDim2.new(0, 10, 0, wsFrame.Position.Y.Offset + wsFrame.Size.Y.Offset + 10)
jpFrame.BackgroundTransparency = 0.3
jpFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
jpFrame.BorderSizePixel = 0
jpFrame.Name = "JumpPowerSection"
Instance.new("UICorner", jpFrame).CornerRadius = UDim.new(0, 8)

-- Label
local jpLabel = Instance.new("TextLabel", jpFrame)
jpLabel.Size = UDim2.new(0.6, 0, 0, 25)
jpLabel.Position = UDim2.new(0, 5, 0, 5)
jpLabel.BackgroundTransparency = 1
jpLabel.Font = Enum.Font.FredokaOne
jpLabel.TextSize = 18
jpLabel.TextXAlignment = Enum.TextXAlignment.Left
jpLabel.TextColor3 = Color3.fromRGB(200, 220, 255)
jpLabel.Text = "Enable JumpPower"

-- Toggle
local jpToggleBtn = Instance.new("ImageButton", jpFrame)
jpToggleBtn.Size = UDim2.new(0, 30, 0, 30)
jpToggleBtn.Position = UDim2.new(1, -40, 0, 0)
jpToggleBtn.BackgroundTransparency = 1
jpToggleBtn.Image = "rbxassetid://97439421965675"

local jpToggleOn = false
local jpToggleOnImage = "rbxassetid://122477350304902"
local jpToggleOffImage = "rbxassetid://97439421965675"
local jpToggleSound = Instance.new("Sound", jpToggleBtn)
jpToggleSound.SoundId = "rbxassetid://18755588842"

-- Input background
local jpInputBg = Instance.new("ImageLabel", jpFrame)
jpInputBg.Size = UDim2.new(0, 60, 0, 25)
jpInputBg.Position = UDim2.new(0, 5, 0, 40)
jpInputBg.Image = "rbxassetid://121978541146753"
jpInputBg.BackgroundTransparency = 1
jpInputBg.ZIndex = 0

-- Input box
local jpInputBox = Instance.new("TextBox", jpFrame)
jpInputBox.Size = UDim2.new(0, 60, 0, 25)
jpInputBox.Position = UDim2.new(0, 5, 0, 40)
jpInputBox.BackgroundTransparency = 1
jpInputBox.Text = "50"
jpInputBox.Font = Enum.Font.FredokaOne
jpInputBox.TextSize = 16
jpInputBox.TextColor3 = Color3.fromRGB(255,255,255)
jpInputBox.ClearTextOnFocus = false
jpInputBox.ZIndex = 1

-- Slider background
local jpSliderBg = Instance.new("Frame", jpFrame)
jpSliderBg.Size = UDim2.new(0.8, 0, 0, 8)
jpSliderBg.Position = UDim2.new(0, 5, 0, 75)
jpSliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
jpSliderBg.BorderSizePixel = 0
Instance.new("UICorner", jpSliderBg).CornerRadius = UDim.new(1,0)

-- Knob
local jpKnob = Instance.new("Frame", jpSliderBg)
jpKnob.Size = UDim2.new(0, 16, 0, 16)
jpKnob.Position = UDim2.new(0, -8, -0.25, 0)
jpKnob.BackgroundColor3 = Color3.fromRGB(255, 180, 100)
Instance.new("UICorner", jpKnob).CornerRadius = UDim.new(1, 0)

local jpStroke = Instance.new("UIStroke", jpKnob)
jpStroke.Color = Color3.fromRGB(255, 120, 0)
jpStroke.Thickness = 3

-- Values
local jpValue = 50
local maxJump = 300
local jpDragging = false

-- Knob drag
jpKnob.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
jpDragging = true
end
end)

UIS.InputEnded:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
jpDragging = false
end
end)

UIS.InputChanged:Connect(function(input)
if jpDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
local relX = math.clamp((input.Position.X - jpSliderBg.AbsolutePosition.X) / jpSliderBg.AbsoluteSize.X, 0, 1)
jpKnob.Position = UDim2.new(relX, -8, -0.25, 0)
jpValue = math.floor(relX * maxJump)
jpInputBox.Text = tostring(jpValue)
end
end)

-- Manual input
jpInputBox.FocusLost:Connect(function()
local val = tonumber(jpInputBox.Text)
if val and val > 0 then
jpValue = math.clamp(val, 1, maxJump)
else
jpValue = 50
end
jpInputBox.Text = tostring(jpValue)
end)

-- Toggle
jpToggleBtn.MouseButton1Click:Connect(function()
jpToggleOn = not jpToggleOn
jpToggleBtn.Image = jpToggleOn and jpToggleOnImage or jpToggleOffImage
jpToggleSound:Play()
end)

-- Jump loop
RunService.RenderStepped:Connect(function()
if jpToggleOn and humanoid and humanoid.Parent then
humanoid.UseJumpPower = true
humanoid.JumpPower = jpValue
end
end)




-- Jump Hack GUI container
local jhFrame = Instance.new("Frame", mainBox)
jhFrame.Size = UDim2.new(1, -20, 0, 60)
jhFrame.Position = UDim2.new(0, 10, 0, jpFrame.Position.Y.Offset + jpFrame.Size.Y.Offset + 10)
jhFrame.BackgroundTransparency = 0.3
jhFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
jhFrame.BorderSizePixel = 0
jhFrame.Name = "JumpHackSection"
Instance.new("UICorner", jhFrame).CornerRadius = UDim.new(0, 8)

-- Button
local jumpHackButton = Instance.new("TextButton", jhFrame)
jumpHackButton.Size = UDim2.new(0.8, 0, 0, 35)
jumpHackButton.Position = UDim2.new(0.1, 0, 0.5, -17)
jumpHackButton.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
jumpHackButton.Text = "Jump Hack GUI"
jumpHackButton.Font = Enum.Font.FredokaOne
jumpHackButton.TextSize = 20
jumpHackButton.TextColor3 = Color3.fromRGB(220, 240, 255)
jumpHackButton.AutoButtonColor = true
Instance.new("UICorner", jumpHackButton).CornerRadius = UDim.new(0, 6)

-- Glow outline
local jhStroke = Instance.new("UIStroke", jumpHackButton)
jhStroke.Color = Color3.fromRGB(0, 120, 255)
jhStroke.Thickness = 3

-- Sound
local jhSound = Instance.new("Sound", jumpHackButton)
jhSound.SoundId = "rbxassetid://18755588842"

-- Flag so we only create GUI once
local jumpGuiCreated = false

-- Jump Hack GUI creation
local function createJumpButton()
    if jumpGuiCreated then
        jhSound:Play()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Notice",
            Text = "Jump Hack GUI already executed!",
            Duration = 3
        })
        return
    end
    jumpGuiCreated = true

    local gui = Instance.new("ScreenGui")
    gui.Name = "JumpButtonGUI"
    gui.Parent = game:GetService("CoreGui")

    local button = Instance.new("TextButton", gui)
    button.Text = "Jump"
    button.Size = UDim2.new(0, 110, 0, 44)
    button.Position = UDim2.new(0, 20, 0.5, -22)
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    button.BackgroundTransparency = 0.3
    button.TextColor3 = Color3.fromRGB(230, 230, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 22
    button.BorderSizePixel = 0
    button.Active = true
    button.Draggable = true
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 14)

    local outline = Instance.new("UIStroke", button)
    outline.Color = Color3.fromRGB(0, 0, 139)
    outline.Thickness = 3
    outline.LineJoinMode = Enum.LineJoinMode.Round

    local jumpPower = 250
    local jumpActive = false
    local jumpConnection

    local function startJumping()
        if jumpActive then return end
        jumpActive = true
        button.Text = "Jump ON"
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            local originalJumpPower = humanoid.JumpPower
            humanoid.JumpPower = jumpPower
            jumpConnection = RunService.Heartbeat:Connect(function()
                if humanoid and jumpActive then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
            task.delay(0.5, function()
                if humanoid then
                    humanoid.JumpPower = originalJumpPower
                end
            end)
        end
    end

    local function stopJumping()
        jumpActive = false
        button.Text = "Jump"
        if jumpConnection then
            jumpConnection:Disconnect()
            jumpConnection = nil
        end
    end

    button.MouseButton1Down:Connect(startJumping)
    button.MouseButton1Up:Connect(stopJumping)
end

-- Hook up button
jumpHackButton.MouseButton1Click:Connect(function()
    jhSound:Play()
    createJumpButton()
end)

-- INFINITE JUMP GUI container
local ijFrame = Instance.new("Frame", mainBox)
ijFrame.Size = UDim2.new(1, -20, 0, 60)
ijFrame.Position = UDim2.new(0, 10, 0, jhFrame.Position.Y.Offset + jhFrame.Size.Y.Offset + 10)
ijFrame.BackgroundTransparency = 0.3
ijFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
ijFrame.BorderSizePixel = 0
ijFrame.Name = "InfiniteJumpSection"
Instance.new("UICorner", ijFrame).CornerRadius = UDim.new(0, 8)

-- Button
local infiniteJumpButton = Instance.new("TextButton", ijFrame)
infiniteJumpButton.Size = UDim2.new(0.8, 0, 0, 35)
infiniteJumpButton.Position = UDim2.new(0.1, 0, 0.5, -17)
infiniteJumpButton.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
infiniteJumpButton.Text = "Infinite Jump GUI"
infiniteJumpButton.Font = Enum.Font.FredokaOne
infiniteJumpButton.TextSize = 20
infiniteJumpButton.TextColor3 = Color3.fromRGB(220, 240, 255)
infiniteJumpButton.AutoButtonColor = true
Instance.new("UICorner", infiniteJumpButton).CornerRadius = UDim.new(0, 6)

-- Glow outline
local ijStroke = Instance.new("UIStroke", infiniteJumpButton)
ijStroke.Color = Color3.fromRGB(0, 200, 120)
ijStroke.Thickness = 3

-- Sound
local ijSound = Instance.new("Sound", infiniteJumpButton)
ijSound.SoundId = "rbxassetid://18755588842"

-- Flag so we only create GUI once
local infiniteGuiCreated = false

-- Infinite Jump GUI creation
local function createInfiniteJumpButton()
    if infiniteGuiCreated then
        ijSound:Play()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Notice",
            Text = "Infinite Jump GUI already executed!",
            Duration = 3
        })
        return
    end
    infiniteGuiCreated = true

    local gui = Instance.new("ScreenGui")
    gui.Name = "InfiniteJumpGUI"
    gui.Parent = game:GetService("CoreGui")

    local button = Instance.new("TextButton", gui)
    button.Text = "Inf Jump OFF"
    button.Size = UDim2.new(0, 130, 0, 44)
    button.Position = UDim2.new(0, 20, 0.6, -22)
    button.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    button.BackgroundTransparency = 0.3
    button.TextColor3 = Color3.fromRGB(200, 255, 200)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 20
    button.BorderSizePixel = 0
    button.Active = true
    button.Draggable = true
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 14)

    local outline = Instance.new("UIStroke", button)
    outline.Color = Color3.fromRGB(0, 200, 120)
    outline.Thickness = 3
    outline.LineJoinMode = Enum.LineJoinMode.Round

    -- Infinite jump toggle
    local infJumpEnabled = false
    local uis = game:GetService("UserInputService")

    local function toggleInfJump()
        infJumpEnabled = not infJumpEnabled
        button.Text = infJumpEnabled and "Inf Jump ON" or "Inf Jump OFF"
    end

    button.MouseButton1Click:Connect(toggleInfJump)

    -- Reapply after respawn
    local function hookCharacter(char)
        uis.JumpRequest:Connect(function()
            if infJumpEnabled then
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
    end

    -- Hook current + future characters
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    hookCharacter(char)
    LocalPlayer.CharacterAdded:Connect(hookCharacter)
end

-- Hook up button
infiniteJumpButton.MouseButton1Click:Connect(function()
    ijSound:Play()
    createInfiniteJumpButton()
end)

-- INFINITE JUMP GUI container
local ijFrame = Instance.new("Frame", mainBox)
ijFrame.Size = UDim2.new(1, -20, 0, 60)
ijFrame.Position = UDim2.new(0, 10, 0, jhFrame.Position.Y.Offset + jhFrame.Size.Y.Offset + 10)
ijFrame.BackgroundTransparency = 0.3
ijFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
ijFrame.BorderSizePixel = 0
ijFrame.Name = "InfiniteJumpSection"
Instance.new("UICorner", ijFrame).CornerRadius = UDim.new(0, 8)

-- Button
local infiniteJumpButton = Instance.new("TextButton", ijFrame)
infiniteJumpButton.Size = UDim2.new(0.8, 0, 0, 35)
infiniteJumpButton.Position = UDim2.new(0.1, 0, 0.5, -17)
infiniteJumpButton.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
infiniteJumpButton.Text = "Infinite Jump"
infiniteJumpButton.Font = Enum.Font.FredokaOne
infiniteJumpButton.TextSize = 20
infiniteJumpButton.TextColor3 = Color3.fromRGB(220, 240, 255)
infiniteJumpButton.AutoButtonColor = true
Instance.new("UICorner", infiniteJumpButton).CornerRadius = UDim.new(0, 6)

-- Glow outline
local ijStroke = Instance.new("UIStroke", infiniteJumpButton)
ijStroke.Color = Color3.fromRGB(0, 200, 120)
ijStroke.Thickness = 3

-- Sound
local ijSound = Instance.new("Sound", infiniteJumpButton)
ijSound.SoundId = "rbxassetid://18755588842"

-- Flag so we only set up once
local infiniteJumpSetup = false
local infJumpEnabled = false

-- Hook for infinite jump
local function setupInfiniteJump()
    if infiniteJumpSetup then
        ijSound:Play()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Notice",
            Text = "Infinite Jump Goated !",
            Duration = 3
        })
        return
    end
    infiniteJumpSetup = true

    local uis = game:GetService("UserInputService")
    local function hookChar(char)
        uis.JumpRequest:Connect(function()
            if infJumpEnabled then
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
    end

    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    hookChar(char)
    LocalPlayer.CharacterAdded:Connect(hookChar)
end

-- Toggle button logic
infiniteJumpButton.MouseButton1Click:Connect(function()
    ijSound:Play()
    setupInfiniteJump()
    infJumpEnabled = not infJumpEnabled
    infiniteJumpButton.Text = infJumpEnabled and "Infinite Jump: ON" or "Infinite Jump: OFF"
end)

-- Fly container
local flyFrame = Instance.new("Frame", mainBox)
flyFrame.Size = UDim2.new(1, -20, 0, 90)
flyFrame.Position = UDim2.new(0, 10, 0, ijFrame.Position.Y.Offset + ijFrame.Size.Y.Offset + 10)
flyFrame.BackgroundTransparency = 0.3
flyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
flyFrame.BorderSizePixel = 0
flyFrame.Name = "FlySection"
Instance.new("UICorner", flyFrame).CornerRadius = UDim.new(0, 8)

-- Label
local flyLabel = Instance.new("TextLabel", flyFrame)
flyLabel.Size = UDim2.new(0.6, 0, 0, 25)
flyLabel.Position = UDim2.new(0, 5, 0, 5)
flyLabel.BackgroundTransparency = 1
flyLabel.Font = Enum.Font.FredokaOne
flyLabel.TextSize = 18
flyLabel.TextXAlignment = Enum.TextXAlignment.Left
flyLabel.TextColor3 = Color3.fromRGB(200, 220, 255)
flyLabel.Text = "Enable Fly (Risky Due to Ban)"

-- Toggle
local flyToggle = Instance.new("ImageButton", flyFrame)
flyToggle.Size = UDim2.new(0, 30, 0, 30)
flyToggle.Position = UDim2.new(1, -40, 0, 0)
flyToggle.BackgroundTransparency = 1
flyToggle.Image = "rbxassetid://97439421965675"

local flyToggleOn = false
local flyToggleOnImage = "rbxassetid://122477350304902"
local flyToggleOffImage = "rbxassetid://97439421965675"
local toggleSound = Instance.new("Sound", flyToggle)
toggleSound.SoundId = "rbxassetid://18755588842"

-- Input background
local flyInputBg = Instance.new("ImageLabel", flyFrame)
flyInputBg.Size = UDim2.new(0, 60, 0, 25)
flyInputBg.Position = UDim2.new(0, 5, 0, 40)
flyInputBg.Image = "rbxassetid://121978541146753"
flyInputBg.BackgroundTransparency = 1
flyInputBg.ZIndex = 0

-- Input box
local flySpeedBox = Instance.new("TextBox", flyFrame)
flySpeedBox.Size = UDim2.new(0, 60, 0, 25)
flySpeedBox.Position = UDim2.new(0, 5, 0, 40)
flySpeedBox.BackgroundTransparency = 1
flySpeedBox.Text = "55"
flySpeedBox.Font = Enum.Font.FredokaOne
flySpeedBox.TextSize = 16
flySpeedBox.TextColor3 = Color3.fromRGB(255,255,255)
flySpeedBox.ClearTextOnFocus = false
flySpeedBox.ZIndex = 1

-- Slider background
local flySliderBar = Instance.new("Frame", flyFrame)
flySliderBar.Size = UDim2.new(0.8, 0, 0, 8)
flySliderBar.Position = UDim2.new(0, 5, 0, 75)
flySliderBar.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
flySliderBar.BorderSizePixel = 0
Instance.new("UICorner", flySliderBar).CornerRadius = UDim.new(1,0)

-- Knob
local flySliderDot = Instance.new("Frame", flySliderBar)
flySliderDot.Size = UDim2.new(0, 16, 0, 16)
flySliderDot.Position = UDim2.new(0, -8, -0.25, 0)
flySliderDot.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
Instance.new("UICorner", flySliderDot).CornerRadius = UDim.new(1, 0)

local dotStroke = Instance.new("UIStroke", flySliderDot)
dotStroke.Color = Color3.fromRGB(0, 180, 255)
dotStroke.Thickness = 3

-- Fly Logic
local uis = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local flyEnabled = false
local flyConn = nil

local function enableFly(speed)
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    local humanoid = char:WaitForChild("Humanoid")

    -- Clean up  
    if hrp:FindFirstChild("FlyVelocity") then hrp.FlyVelocity:Destroy() end  
    if hrp:FindFirstChild("FlyGyro") then hrp.FlyGyro:Destroy() end  

    local bv = Instance.new("BodyVelocity")  
    bv.Name = "FlyVelocity"  
    bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)  
    bv.P = 12500  
    bv.Velocity = Vector3.zero  
    bv.Parent = hrp  

    local bg = Instance.new("BodyGyro")  
    bg.Name = "FlyGyro"  
    bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5)  
    bg.P = 1e4  
    bg.CFrame = hrp.CFrame  
    bg.Parent = hrp  

    humanoid:ChangeState(Enum.HumanoidStateType.Physics)  

    flyConn = RunService.RenderStepped:Connect(function()  
        if not hrp or not humanoid or not humanoid.Parent then return end  
        local cam = workspace.CurrentCamera  
        bg.CFrame = cam.CFrame  

        if humanoid.MoveDirection.Magnitude > 0.01 then  
            bv.Velocity = cam.CFrame.LookVector * speed  
        else  
            bv.Velocity = Vector3.zero  
        end  
    end)
end

local function disableFly()
    local char = game.Players.LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp then
        if hrp:FindFirstChild("FlyVelocity") then hrp.FlyVelocity:Destroy() end
        if hrp:FindFirstChild("FlyGyro") then hrp.FlyGyro:Destroy() end
    end
    if flyConn then flyConn:Disconnect() flyConn = nil end

    local humanoid = char:FindFirstChild("Humanoid")  
    if humanoid then  
        humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)  
    end
end

-- Toggle Logic
flyToggle.MouseButton1Click:Connect(function()
    toggleSound:Play()
    flyEnabled = not flyEnabled
    flyToggle.Image = flyEnabled and flyToggleOnImage or flyToggleOffImage

    if flyEnabled then  
        local speed = tonumber(flySpeedBox.Text) or 55  
        enableFly(speed)  
    else  
        disableFly()  
    end
end)

-- Slider Update Logic
local function updateFlySlider(pos)
    local x = math.clamp(pos.X - flySliderBar.AbsolutePosition.X, 0, flySliderBar.AbsoluteSize.X)
    local percent = x / flySliderBar.AbsoluteSize.X
    local value = math.floor(20 + percent * (100 - 20))
    flySliderDot.Position = UDim2.new(0, x - flySliderDot.AbsoluteSize.X / 2, 0.5, -flySliderDot.AbsoluteSize.Y / 2)
    flySpeedBox.Text = tostring(value)
end

flySliderDot.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local moveConn, releaseConn
        moveConn = uis.InputChanged:Connect(function(moveInput)
            if moveInput.UserInputType == Enum.UserInputType.MouseMovement then
                updateFlySlider(moveInput.Position)
            end
        end)
        releaseConn = uis.InputEnded:Connect(function(endInput)
            if endInput.UserInputType == Enum.UserInputType.MouseButton1 then
                moveConn:Disconnect()
                releaseConn:Disconnect()
            end
        end)
    end
end)

flySpeedBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local val = tonumber(flySpeedBox.Text)
        if val then
            val = math.clamp(val, 20, 100)
            flySpeedBox.Text = tostring(val)
            local percent = (val - 20) / (100 - 20)
            local x = percent * flySliderBar.AbsoluteSize.X
            flySliderDot.Position = UDim2.new(0, x - flySliderDot.AbsoluteSize.X / 2, 0.5, -flySliderDot.AbsoluteSize.Y / 2)
        end
    end
end)

-- NOCLIP GUI container
local noclipFrame = Instance.new("Frame", mainBox)
noclipFrame.Size = UDim2.new(1, -20, 0, 60)
noclipFrame.Position = UDim2.new(0, 10, 0, flyFrame.Position.Y.Offset + flyFrame.Size.Y.Offset + 10)
noclipFrame.BackgroundTransparency = 0.3
noclipFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
noclipFrame.BorderSizePixel = 0
noclipFrame.Name = "NoclipSection"
Instance.new("UICorner", noclipFrame).CornerRadius = UDim.new(0, 8)

-- Button
local noclipButton = Instance.new("TextButton", noclipFrame)
noclipButton.Size = UDim2.new(0.8, 0, 0, 35)
noclipButton.Position = UDim2.new(0.1, 0, 0.5, -17)
noclipButton.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
noclipButton.Text = "Noclip: OFF"
noclipButton.Font = Enum.Font.FredokaOne
noclipButton.TextSize = 20
noclipButton.TextColor3 = Color3.fromRGB(220, 240, 255)
noclipButton.AutoButtonColor = true
Instance.new("UICorner", noclipButton).CornerRadius = UDim.new(0, 6)

-- Glow outline
local ncStroke = Instance.new("UIStroke", noclipButton)
ncStroke.Color = Color3.fromRGB(255, 180, 0)
ncStroke.Thickness = 3

-- Sound
local ncSound = Instance.new("Sound", noclipButton)
ncSound.SoundId = "rbxassetid://18755588842"

-- State
local noclipEnabled = false
local noclipConn

-- Enable Noclip
local function enableNoclip()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()

    noclipConn = game:GetService("RunService").Stepped:Connect(function()
        if noclipEnabled and char and char:FindFirstChildOfClass("Humanoid") then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end
    end)
end

-- Disable Noclip
local function disableNoclip()
    if noclipConn then
        noclipConn:Disconnect()
        noclipConn = nil
    end
    local char = game.Players.LocalPlayer.Character
    if char then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

-- Toggle button logic
noclipButton.MouseButton1Click:Connect(function()
    ncSound:Play()
    noclipEnabled = not noclipEnabled
    noclipButton.Text = noclipEnabled and "Noclip: ON" or "Noclip: OFF"

    if noclipEnabled then
        enableNoclip()
    else
        disableNoclip()
    end
end)



-- ANTI STUN Section
local antiStunFrame = Instance.new("Frame", mainBox)
antiStunFrame.Size = UDim2.new(1, -20, 0, 60)
antiStunFrame.Position = UDim2.new(0, 10, 0, noclipFrame.Position.Y.Offset + noclipFrame.Size.Y.Offset + 10)
antiStunFrame.BackgroundTransparency = 0.3
antiStunFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
antiStunFrame.BorderSizePixel = 0
antiStunFrame.Name = "AntiStunSection"
Instance.new("UICorner", antiStunFrame).CornerRadius = UDim.new(0, 8)

-- Label
local antiStunLabel = Instance.new("TextLabel", antiStunFrame)
antiStunLabel.Size = UDim2.new(0.6, 0, 0, 25)
antiStunLabel.Position = UDim2.new(0, 5, 0, 5)
antiStunLabel.BackgroundTransparency = 1
antiStunLabel.Font = Enum.Font.FredokaOne
antiStunLabel.TextSize = 18
antiStunLabel.TextXAlignment = Enum.TextXAlignment.Left
antiStunLabel.TextColor3 = Color3.fromRGB(200, 220, 255)
antiStunLabel.Text = "Anti Stun"

-- Toggle Button
local antiStunToggle = Instance.new("ImageButton", antiStunFrame)
antiStunToggle.Size = UDim2.new(0, 30, 0, 30)
antiStunToggle.Position = UDim2.new(1, -40, 0, 0)
antiStunToggle.BackgroundTransparency = 1
antiStunToggle.Image = "rbxassetid://97439421965675" -- Off Image

local antiStunToggleOnImage = "rbxassetid://122477350304902"
local antiStunToggleOffImage = "rbxassetid://97439421965675"

-- Sound
local antiStunSound = Instance.new("Sound", antiStunToggle)
antiStunSound.SoundId = "rbxassetid://18755588842"

-- Anti Stun Logic
local RunService = game:GetService("RunService")
local LocalPlayer = game.Players.LocalPlayer
local antiStunEnabled = false
local antiStunConnection = nil

local function startAntiStun()
    antiStunConnection = RunService.RenderStepped:Connect(function()
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if hrp and humanoid then
            local moveDir = humanoid.MoveDirection
            if moveDir.Magnitude > 0 then
                local flatDir = Vector3.new(moveDir.X, 0, moveDir.Z).Unit
                hrp.CFrame = hrp.CFrame + flatDir * 1.2
            end
        end
    end)
end

local function stopAntiStun()
    if antiStunConnection then
        antiStunConnection:Disconnect()
        antiStunConnection = nil
    end
end

-- Toggle Logic
antiStunToggle.MouseButton1Click:Connect(function()
    antiStunSound:Play()
    antiStunEnabled = not antiStunEnabled
    antiStunToggle.Image = antiStunEnabled and antiStunToggleOnImage or antiStunToggleOffImage

    if antiStunEnabled then
        startAntiStun()
    else
        stopAntiStun()
    end
end)

-- AUTO TELEPORT WHEN LOW HEALTH Section
local autoTpFrame = Instance.new("Frame", mainBox)
autoTpFrame.Size = UDim2.new(1, -20, 0, 80)
autoTpFrame.Position = UDim2.new(0, 10, 0, antiStunFrame.Position.Y.Offset + antiStunFrame.Size.Y.Offset + 10)
autoTpFrame.BackgroundTransparency = 0.3
autoTpFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
autoTpFrame.BorderSizePixel = 0
autoTpFrame.Name = "AutoTPSection"
Instance.new("UICorner", autoTpFrame).CornerRadius = UDim.new(0, 8)

-- Label
local autoTpLabel = Instance.new("TextLabel", autoTpFrame)
autoTpLabel.Size = UDim2.new(0.8, 0, 0, 25)
autoTpLabel.Position = UDim2.new(0, 5, 0, 5)
autoTpLabel.BackgroundTransparency = 1
autoTpLabel.Font = Enum.Font.FredokaOne
autoTpLabel.TextSize = 18
autoTpLabel.TextXAlignment = Enum.TextXAlignment.Left
autoTpLabel.TextColor3 = Color3.fromRGB(200, 220, 255)
autoTpLabel.Text = "Auto Teleport When Low Health"

-- Toggle Button
local autoTpToggle = Instance.new("ImageButton", autoTpFrame)
autoTpToggle.Size = UDim2.new(0, 30, 0, 30)
autoTpToggle.Position = UDim2.new(1, -40, 0, 0)
autoTpToggle.BackgroundTransparency = 1
autoTpToggle.Image = "rbxassetid://97439421965675" -- off image

local autoTpToggleOnImage = "rbxassetid://122477350304902"
local autoTpToggleOffImage = "rbxassetid://97439421965675"
local autoTpSound = Instance.new("Sound", autoTpToggle)
autoTpSound.SoundId = "rbxassetid://18755588842"

-- Input Background
local autoTpInputBg = Instance.new("ImageLabel", autoTpFrame)
autoTpInputBg.Size = UDim2.new(0, 80, 0, 25)
autoTpInputBg.Position = UDim2.new(0, 5, 0, 40)
autoTpInputBg.Image = "rbxassetid://121978541146753"
autoTpInputBg.BackgroundTransparency = 1
autoTpInputBg.ZIndex = 0

-- Input Box
local autoTpBox = Instance.new("TextBox", autoTpFrame)
autoTpBox.Size = UDim2.new(0, 80, 0, 25)
autoTpBox.Position = UDim2.new(0, 5, 0, 40)
autoTpBox.BackgroundTransparency = 1
autoTpBox.Text = "1000"
autoTpBox.Font = Enum.Font.FredokaOne
autoTpBox.TextSize = 16
autoTpBox.TextColor3 = Color3.fromRGB(255,255,255)
autoTpBox.ClearTextOnFocus = false
autoTpBox.ZIndex = 1

--// Auto Teleport Logic
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local autoTpEnabled = false
local healthThreshold = tonumber(autoTpBox.Text) or 1000
local floatHeight = 10000
local floating = false
local safePos = nil
local autoTpConn = nil

local function teleportUp(HRP)
    if not floating then
        safePos = HRP.CFrame
        HRP.CFrame = CFrame.new(HRP.Position + Vector3.new(0, floatHeight, 0))

        local float = Instance.new("BodyVelocity")
        float.Velocity = Vector3.new(0,0,0)
        float.MaxForce = Vector3.new(1e9,1e9,1e9)
        float.Name = "FloatForce"
        float.Parent = HRP

        floating = true
    end
end

local function teleportDown(HRP)
    if floating and safePos then
        HRP.CFrame = safePos
        if HRP:FindFirstChild("FloatForce") then
            HRP.FloatForce:Destroy()
        end
        floating = false
    end
end

local function startAutoTp()
    autoTpConn = RunService.Heartbeat:Connect(function()
        local char = LocalPlayer.Character
        if not char then return end
        local Humanoid = char:FindFirstChildOfClass("Humanoid")
        local HRP = char:FindFirstChild("HumanoidRootPart")
        if not Humanoid or not HRP then return end

        if Humanoid.Health > 0 then
            if Humanoid.Health <= healthThreshold then
                teleportUp(HRP)
            elseif floating and Humanoid.Health >= Humanoid.MaxHealth * 0.9 then
                teleportDown(HRP)
            end
        end
    end)
end

local function stopAutoTp()
    if autoTpConn then
        autoTpConn:Disconnect()
        autoTpConn = nil
    end
    floating = false
end

-- Toggle logic
autoTpToggle.MouseButton1Click:Connect(function()
    autoTpSound:Play()
    autoTpEnabled = not autoTpEnabled
    autoTpToggle.Image = autoTpEnabled and autoTpToggleOnImage or autoTpToggleOffImage

    if autoTpEnabled then
        healthThreshold = tonumber(autoTpBox.Text) or 1000
        startAutoTp()
    else
        stopAutoTp()
    end
end)

-- Update threshold when typing
autoTpBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local val = tonumber(autoTpBox.Text)
        if val then
            healthThreshold = val
        end
    end
end)

-- Respawn handling
LocalPlayer.CharacterAdded:Connect(function(char)
    char:WaitForChild("HumanoidRootPart")
    char:WaitForChild("Humanoid")
    floating = false
    safePos = nil
end)


-- GAME-INFO Heading (only inside Main tab)
local gameInfoHeading = Instance.new("TextLabel", mainBox)
gameInfoHeading.Name = "GameInfoHeading"
gameInfoHeading.Size = UDim2.new(1, -20, 0, 40)
gameInfoHeading.Position = UDim2.new(0, 10, 0, autoTpFrame.Position.Y.Offset + autoTpFrame.Size.Y.Offset + 15)
gameInfoHeading.BackgroundTransparency = 1
gameInfoHeading.Font = Enum.Font.FredokaOne
gameInfoHeading.TextSize = 22
gameInfoHeading.TextXAlignment = Enum.TextXAlignment.Left
gameInfoHeading.TextColor3 = Color3.fromRGB(20, 80, 200) -- dark blue
gameInfoHeading.TextStrokeTransparency = 0.4
gameInfoHeading.Text = "GAME-INFO"

-- Underline
local underline2 = Instance.new("Frame", gameInfoHeading)
underline2.Size = UDim2.new(0.35, 0, 0, 2)
underline2.Position = UDim2.new(0, 0, 1, -3)
underline2.BackgroundColor3 = Color3.fromRGB(20, 80, 200)
underline2.BorderSizePixel = 0

-- Glow effect
local glow2 = Instance.new("UIStroke", underline2)
glow2.Thickness = 4
glow2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
glow2.Color = Color3.fromRGB(0, 0, 150)
glow2.Transparency = 0.2

    
-- Game Info Box
local gameInfoBox = Instance.new("Frame", mainBox)
gameInfoBox.Name = "GameInfoBox"
gameInfoBox.Size = UDim2.new(1, -20, 0, 200)
gameInfoBox.Position = UDim2.new(0, 10, 0, gameInfoHeading.Position.Y.Offset + gameInfoHeading.Size.Y.Offset + 20)
gameInfoBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
gameInfoBox.BackgroundTransparency = 0.25
gameInfoBox.ZIndex = 3
gameInfoBox.Visible = true
Instance.new("UICorner", gameInfoBox).CornerRadius = UDim.new(0, 10)

-- Outline stroke
local gameStroke = Instance.new("UIStroke", gameInfoBox)
gameStroke.Thickness = 2
gameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Animate outline between cyan and purple
task.spawn(function()
local t = 0
while gameStroke and gameStroke.Parent do
local color = Color3.fromHSV(math.abs(math.sin(t)) * 0.8, 0.9, 1)
gameStroke.Color = color
t = t + 0.01
task.wait(0.03)
end
end)


-- Game Name Label
local gameNameLabel = Instance.new("TextLabel", gameInfoBox)
gameNameLabel.Size = UDim2.new(1, -20, 0, 50)
gameNameLabel.Position = UDim2.new(0, 10, 0, 20)
gameNameLabel.BackgroundTransparency = 1
gameNameLabel.Text = "Game : " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
gameNameLabel.Font = Enum.Font.GothamBold
gameNameLabel.TextSize = 22
gameNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
gameNameLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Stroke for text
local stroke = Instance.new("UIStroke", gameNameLabel)
stroke.Thickness = 1.5
stroke.Color = Color3.fromRGB(0, 0, 0)

-- Gradient for cool color effect
local gradient = Instance.new("UIGradient", gameNameLabel)
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)), -- cyan
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255)) -- purple
})
gradient.Rotation = 0

-- Animate gradient slowly
task.spawn(function()
    while gradient and gradient.Parent do
        for i = 0, 360, 2 do
            gradient.Rotation = i
            task.wait(0.05)
        end
    end
end)

-- Player Counter Label
local playerCountLabel = Instance.new("TextLabel", gameInfoBox)
playerCountLabel.Size = UDim2.new(1, -20, 0, 40)
playerCountLabel.Position = UDim2.new(0, 10, 0, 70) -- below the game name
playerCountLabel.BackgroundTransparency = 1
playerCountLabel.Text = "Players : " .. tostring(#game.Players:GetPlayers()) .. " / " .. tostring(game.Players.MaxPlayers)
playerCountLabel.Font = Enum.Font.GothamBold
playerCountLabel.TextSize = 20
playerCountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
playerCountLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Stroke for text
local stroke2 = Instance.new("UIStroke", playerCountLabel)
stroke2.Thickness = 1.5
stroke2.Color = Color3.fromRGB(0, 0, 0)

-- Gradient for color effect
local gradient2 = Instance.new("UIGradient", playerCountLabel)
gradient2.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)), -- cyan
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255)) -- purple
})
gradient2.Rotation = 0

-- Animate gradient slowly
task.spawn(function()
    while gradient2 and gradient2.Parent do
        for i = 0, 360, 2 do
            gradient2.Rotation = i
            task.wait(0.05)
        end
    end
end)

-- Update player count dynamically
game.Players.PlayerAdded:Connect(function()
    playerCountLabel.Text = "Players : " .. tostring(#game.Players:GetPlayers()) .. " / " .. tostring(game.Players.MaxPlayers)
end)

game.Players.PlayerRemoving:Connect(function()
    playerCountLabel.Text = "Players : " .. tostring(#game.Players:GetPlayers()) .. " / " .. tostring(game.Players.MaxPlayers)
end)



-- Total Executions Label
local execCountLabel = Instance.new("TextLabel", gameInfoBox)
execCountLabel.Size = UDim2.new(1, -20, 0, 40)
execCountLabel.Position = UDim2.new(0, 10, 0, 120) -- Below player count
execCountLabel.BackgroundTransparency = 1
execCountLabel.Text = "Total Executions: 0"
execCountLabel.Font = Enum.Font.GothamBold
execCountLabel.TextSize = 20
execCountLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
execCountLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Stroke for better readability
local stroke3 = Instance.new("UIStroke", execCountLabel)
stroke3.Thickness = 1.5
stroke3.Color = Color3.fromRGB(0, 0, 0)

-- Gradient effect
local gradient3 = Instance.new("UIGradient", execCountLabel)
gradient3.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)), -- cyan
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))  -- purple
})
gradient3.Rotation = 0

-- Animate gradient slowly
task.spawn(function()
    while gradient3 and gradient3.Parent do
        for i = 0, 360, 2 do
            gradient3.Rotation = i
            task.wait(0.05)
        end
    end
end)

-- Function to read execution count
local function updateExecLabel()
    local userId = game.Players.LocalPlayer.UserId
    local fileName = "CentuDoxExecCount_" .. tostring(userId) .. ".txt"
    local execCount = 0
    if isfile and readfile and isfile(fileName) then
        local val = tonumber(readfile(fileName))
        if val then execCount = val end
    end
    execCountLabel.Text = "Total Executions: " .. tostring(execCount)
end

-- Auto-update every second
task.spawn(function()
    while true do
        updateExecLabel()
        task.wait(1)
    end
end)


  -- Bounty/Honor Gained Label
local bountyLabel = Instance.new("TextLabel", gameInfoBox)
bountyLabel.Size = UDim2.new(1, -20, 0, 40)
bountyLabel.Position = UDim2.new(0, 10, 0, 160) -- Below executions
bountyLabel.BackgroundTransparency = 1
bountyLabel.Text = "Bounty/Honor Gained: 0"
bountyLabel.Font = Enum.Font.GothamBold
bountyLabel.TextSize = 20
bountyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
bountyLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Stroke
local stroke4 = Instance.new("UIStroke", bountyLabel)
stroke4.Thickness = 1.5
stroke4.Color = Color3.fromRGB(0, 0, 0)

-- Gradient
local gradient4 = Instance.new("UIGradient", bountyLabel)
gradient4.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 0)), -- yellow
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 100, 0))  -- orange
})
gradient4.Rotation = 0

-- Animate gradient
task.spawn(function()
    while gradient4 and gradient4.Parent do
        for i = 0, 360, 2 do
            gradient4.Rotation = i
            task.wait(0.05)
        end
    end
end)

-- Track bounty/honor gained
local player = game.Players.LocalPlayer
local leaderstats = player:WaitForChild("leaderstats")
local bountyStat = leaderstats:WaitForChild("Bounty/Honor")

local startingValue = bountyStat.Value
local function updateBountyLabel()
    local gained = bountyStat.Value - startingValue
    bountyLabel.Text = "Bounty/Honor Gained: " .. tostring(gained)
end

-- Update whenever value changes
bountyStat:GetPropertyChangedSignal("Value"):Connect(updateBountyLabel)
updateBountyLabel()

-- Visual Tab Content Frame
local visualBox = Instance.new("Frame", contentArea)
visualBox.Name = "VisualBox"
visualBox.Size = UDim2.new(1, -20, 1, 0)
visualBox.Position = UDim2.new(0, 10, 0, 0)
visualBox.BackgroundTransparency = 1
visualBox.Visible = false -- only visible when the Visual tab is clicked

-- ESP Heading (only inside Visual tab)
local espHeading = Instance.new("TextLabel", visualBox)
espHeading.Name = "ESPHeading"
espHeading.Size = UDim2.new(1, -20, 0, 40)
espHeading.Position = UDim2.new(0, 10, 0, 10) -- adjust Y offset as needed
espHeading.BackgroundTransparency = 1
espHeading.Font = Enum.Font.FredokaOne -- modern font
espHeading.TextSize = 22
espHeading.TextXAlignment = Enum.TextXAlignment.Left
espHeading.TextColor3 = Color3.fromRGB(20, 80, 200) -- dark blue
espHeading.TextStrokeTransparency = 0.4
espHeading.Text = "ESP"

-- Underline
local underlineESP = Instance.new("Frame", espHeading)
underlineESP.Size = UDim2.new(0.2, 0, 0, 2) -- smaller width
underlineESP.Position = UDim2.new(0, 0, 1, -3)
underlineESP.BackgroundColor3 = Color3.fromRGB(20, 80, 200)
underlineESP.BorderSizePixel = 0

-- Glow effect
local glowESP = Instance.new("UIStroke", underlineESP)
glowESP.Thickness = 4
glowESP.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
glowESP.Color = Color3.fromRGB(0, 0, 150)
glowESP.Transparency = 0.2


-- ESP Box
local espBox = Instance.new("Frame", visualBox)
espBox.Name = "ESPBox"
espBox.Size = UDim2.new(1, -20, 0, 150) -- adjust height if needed
espBox.Position = UDim2.new(0, 10, 0, espHeading.Position.Y.Offset + espHeading.Size.Y.Offset + 20)
espBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
espBox.BackgroundTransparency = 0.25
espBox.ZIndex = 3
espBox.Visible = true
Instance.new("UICorner", espBox).CornerRadius = UDim.new(0, 10)

-- Outline stroke
local espStroke = Instance.new("UIStroke", espBox)
espStroke.Thickness = 2
espStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Animate outline between cyan and purple
task.spawn(function()
    local t = 0
    while espStroke and espStroke.Parent do
        local color = Color3.fromHSV(math.abs(math.sin(t)) * 0.8, 0.9, 1)
        espStroke.Color = color
        t = t + 0.01
        task.wait(0.03)
    end
end)

-- Enable Player ESP Section
local espSection = Instance.new("Frame", espBox)
espSection.Size = UDim2.new(1, -20, 0, 60)
espSection.Position = UDim2.new(0, 10, 0, 10)
espSection.BackgroundTransparency = 0.3
espSection.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
espSection.BorderSizePixel = 0
espSection.Name = "PlayerESPSection"
Instance.new("UICorner", espSection).CornerRadius = UDim.new(0, 8)

-- Label
local espLabel = Instance.new("TextLabel", espSection)
espLabel.Size = UDim2.new(0.6, 0, 0, 25)
espLabel.Position = UDim2.new(0, 5, 0, 5)
espLabel.BackgroundTransparency = 1
espLabel.Font = Enum.Font.FredokaOne
espLabel.TextSize = 18
espLabel.TextXAlignment = Enum.TextXAlignment.Left
espLabel.TextColor3 = Color3.fromRGB(200, 220, 255)
espLabel.Text = "Enable Player ESP"

-- Toggle Button
local espToggle = Instance.new("ImageButton", espSection)
espToggle.Size = UDim2.new(0, 30, 0, 30)
espToggle.Position = UDim2.new(1, -40, 0, 0)
espToggle.BackgroundTransparency = 1
espToggle.Image = "rbxassetid://97439421965675" -- Off image

local espToggleOnImage = "rbxassetid://122477350304902"
local espToggleOffImage = "rbxassetid://97439421965675"

-- Sound
local espSound = Instance.new("Sound", espToggle)
espSound.SoundId = "rbxassetid://18755588842"

-- ESP Logic
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local espEnabled = false
local espConnections = {}
local espTags = {}

-- Function to create ESP tag
local function createESPTAG(player)
    if player == LocalPlayer then return end
    if not player.Character then return end
    local head = player.Character:FindFirstChild("Head")
    if not head then return end

    -- BillboardGui for text
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Tag"
    billboard.Adornee = head
    billboard.Size = UDim2.new(0, 100, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.AlwaysOnTop = true

    local textLabel = Instance.new("TextLabel", billboard)
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Font = Enum.Font.FredokaOne
    textLabel.Text = player.Name
    textLabel.TextSize = 16
    textLabel.TextColor3 = Color3.fromRGB(255, 0, 0) -- RED text
    textLabel.TextStrokeTransparency = 0.3

    billboard.Parent = head
    espTags[player] = billboard
end

-- Enable ESP
local function enableESP()
    for _, plr in ipairs(Players:GetPlayers()) do
        createESPTAG(plr)
    end

    -- handle new players
    table.insert(espConnections, Players.PlayerAdded:Connect(function(plr)
        plr.CharacterAdded:Connect(function()
            task.wait(1)
            createESPTAG(plr)
        end)
    end))

    -- handle character respawn
    for _, plr in ipairs(Players:GetPlayers()) do
        table.insert(espConnections, plr.CharacterAdded:Connect(function()
            task.wait(1)
            createESPTAG(plr)
        end))
    end
end

-- Disable ESP
local function disableESP()
    -- remove billboard GUIs
    for _, billboard in pairs(espTags) do
        if billboard and billboard.Parent then
            billboard:Destroy()
        end
    end
    espTags = {}

    -- disconnect events
    for _, conn in ipairs(espConnections) do
        conn:Disconnect()
    end
    espConnections = {}
end

-- Toggle Logic
espToggle.MouseButton1Click:Connect(function()
    espSound:Play()
    espEnabled = not espEnabled
    espToggle.Image = espEnabled and espToggleOnImage or espToggleOffImage

    if espEnabled then
        enableESP()
    else
        disableESP()
    end
end)

-- Enable Distance ESP Section
local distanceSection = Instance.new("Frame", espBox)
distanceSection.Size = UDim2.new(1, -20, 0, 60)
distanceSection.Position = UDim2.new(0, 10, 0, espSection.Position.Y.Offset + espSection.Size.Y.Offset + 10)
distanceSection.BackgroundTransparency = 0.3
distanceSection.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
distanceSection.BorderSizePixel = 0
distanceSection.Name = "DistanceSection"
Instance.new("UICorner", distanceSection).CornerRadius = UDim.new(0, 8)

-- Label
local distanceLabel = Instance.new("TextLabel", distanceSection)
distanceLabel.Size = UDim2.new(0.6, 0, 0, 25)
distanceLabel.Position = UDim2.new(0, 5, 0, 5)
distanceLabel.BackgroundTransparency = 1
distanceLabel.Font = Enum.Font.FredokaOne
distanceLabel.TextSize = 18
distanceLabel.TextXAlignment = Enum.TextXAlignment.Left
distanceLabel.TextColor3 = Color3.fromRGB(200, 220, 255)
distanceLabel.Text = "Enable Distance ESP"

-- Toggle Button
local distanceToggle = Instance.new("ImageButton", distanceSection)
distanceToggle.Size = UDim2.new(0, 30, 0, 30)
distanceToggle.Position = UDim2.new(1, -40, 0, 0)
distanceToggle.BackgroundTransparency = 1
distanceToggle.Image = "rbxassetid://97439421965675" -- Off image

local distanceToggleOnImage = "rbxassetid://122477350304902"
local distanceToggleOffImage = "rbxassetid://97439421965675"

-- Sound
local distanceSound = Instance.new("Sound", distanceToggle)
distanceSound.SoundId = "rbxassetid://18755588842"

-- Logic
local distanceEnabled = false
local distanceTags = {}

local function createDistanceTag(player)
    if player == LocalPlayer then return end
    if not player.Character then return end
    local head = player.Character:FindFirstChild("Head")
    if not head then return end

    -- BillboardGui for distance (higher than ESP/Health)
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "Distance_Tag"
    billboard.Adornee = head
    billboard.Size = UDim2.new(0, 150, 0, 30)
    billboard.StudsOffset = Vector3.new(0, 4.5, 0) -- higher above the head
    billboard.AlwaysOnTop = true

    local textLabel = Instance.new("TextLabel", billboard)
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Font = Enum.Font.FredokaOne
    textLabel.TextSize = 16
    textLabel.TextStrokeTransparency = 0.3
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 0) -- Yellow text

    billboard.Parent = head
    distanceTags[player] = textLabel

    -- update loop
    task.spawn(function()
        while distanceEnabled and player.Character and LocalPlayer.Character do
            local myRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local theirRoot = player.Character:FindFirstChild("HumanoidRootPart")
            if myRoot and theirRoot then
                local dist = (myRoot.Position - theirRoot.Position).Magnitude
                textLabel.Text = string.format("%d studs", math.floor(dist))
            end
            task.wait(0.2)
        end
    end)
end

local function enableDistance()
    for _, plr in ipairs(Players:GetPlayers()) do
        createDistanceTag(plr)
    end
    table.insert(espConnections, Players.PlayerAdded:Connect(function(plr)
        plr.CharacterAdded:Connect(function()
            task.wait(1)
            createDistanceTag(plr)
        end)
    end))
end

local function disableDistance()
    for _, lbl in pairs(distanceTags) do
        if lbl and lbl.Parent then
            lbl.Parent:Destroy()
        end
    end
    distanceTags = {}
end

-- Toggle Logic
distanceToggle.MouseButton1Click:Connect(function()
    distanceSound:Play()
    distanceEnabled = not distanceEnabled
    distanceToggle.Image = distanceEnabled and distanceToggleOnImage or distanceToggleOffImage

    if distanceEnabled then
        enableDistance()
    else
        disableDistance()
    end
end)


-- CHAMS Heading
local chamsHeading = Instance.new("TextLabel", visualBox)
chamsHeading.Name = "ChamsHeading"
chamsHeading.Size = UDim2.new(1, -20, 0, 40)
chamsHeading.Position = UDim2.new(0, 10, 0, espBox.Position.Y.Offset + espBox.Size.Y.Offset + 10) -- below ESP box
chamsHeading.BackgroundTransparency = 1
chamsHeading.Font = Enum.Font.FredokaOne
chamsHeading.TextSize = 22
chamsHeading.TextXAlignment = Enum.TextXAlignment.Left
chamsHeading.TextColor3 = Color3.fromRGB(20, 80, 200)
chamsHeading.TextStrokeTransparency = 0.4
chamsHeading.Text = "CHAMS"

-- Underline
local underlineChams = Instance.new("Frame", chamsHeading)
underlineChams.Size = UDim2.new(0.2, 0, 0, 2)
underlineChams.Position = UDim2.new(0, 0, 1, -3)
underlineChams.BackgroundColor3 = Color3.fromRGB(20, 80, 200)
underlineChams.BorderSizePixel = 0

-- Glow effect
local glowChams = Instance.new("UIStroke", underlineChams)
glowChams.Thickness = 4
glowChams.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
glowChams.Color = Color3.fromRGB(0, 0, 150)
glowChams.Transparency = 0.2

   
  
  
-- CHAMS Box
local chamsBox = Instance.new("Frame", visualBox)
chamsBox.Name = "ChamsBox"
chamsBox.Size = UDim2.new(1, -20, 0, 80) -- big height for content
chamsBox.Position = UDim2.new(0, 10, 0, chamsHeading.Position.Y.Offset + chamsHeading.Size.Y.Offset + 10)
chamsBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
chamsBox.BackgroundTransparency = 0.25
chamsBox.ZIndex = 3
chamsBox.Visible = true
Instance.new("UICorner", chamsBox).CornerRadius = UDim.new(0, 10)

-- Outline stroke
local chamsStroke = Instance.new("UIStroke", chamsBox)
chamsStroke.Thickness = 2
chamsStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Animate outline between cyan and purple
task.spawn(function()
    local t = 0
    while chamsStroke and chamsStroke.Parent do
        local color = Color3.fromHSV(math.abs(math.sin(t)) * 0.8, 0.9, 1)
        chamsStroke.Color = color
        t = t + 0.01
        task.wait(0.03)
    end
end)



-- Enable Player Chams UI Section
local chamsSection = Instance.new("Frame", chamsBox)
chamsSection.Size = UDim2.new(1, -20, 0, 60)
chamsSection.Position = UDim2.new(0, 10, 0, 10)
chamsSection.BackgroundTransparency = 0.3
chamsSection.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
chamsSection.BorderSizePixel = 0
chamsSection.Name = "PlayerChamsSection"
Instance.new("UICorner", chamsSection).CornerRadius = UDim.new(0, 8)

-- Label
local chamsLabel = Instance.new("TextLabel", chamsSection)
chamsLabel.Size = UDim2.new(0.6, 0, 0, 25)
chamsLabel.Position = UDim2.new(0, 5, 0, 5)
chamsLabel.BackgroundTransparency = 1
chamsLabel.Font = Enum.Font.FredokaOne
chamsLabel.TextSize = 18
chamsLabel.TextXAlignment = Enum.TextXAlignment.Left
chamsLabel.TextColor3 = Color3.fromRGB(200, 220, 255)
chamsLabel.Text = "Enable Player Chams"

-- Toggle Button
local chamsToggle = Instance.new("ImageButton", chamsSection)
chamsToggle.Size = UDim2.new(0, 30, 0, 30)
chamsToggle.Position = UDim2.new(1, -40, 0, 0)
chamsToggle.BackgroundTransparency = 1
chamsToggle.Image = "rbxassetid://97439421965675" -- Off image

-- Optional sound when clicked
local chamsSound = Instance.new("Sound", chamsToggle)
chamsSound.SoundId = "rbxassetid://18755588842"

-- State
local chamsEnabled = false

-- Toggle logic
chamsToggle.MouseButton1Click:Connect(function()
    chamsSound:Play()
    chamsEnabled = not chamsEnabled
    chamsToggle.Image = chamsEnabled and "rbxassetid://122477350304902" or "rbxassetid://97439421965675"

    if chamsEnabled then
        -- 🔮 Run external CHAMS script
           -- 🔮 Player Chams (not highlight chams)
-- This uses BoxHandleAdornment to overlay glowing boxes on player parts

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- SETTINGS
local chamColor = Color3.fromRGB(0, 255, 100) -- neon green
local chamTransparency = 0.5

-- Function to apply chams to a character
local function applyChams(character)
    for _, part in pairs(character:GetChildren()) do
        if part:IsA("BasePart") and not part:FindFirstChild("ChamBox") then
            local adorn = Instance.new("BoxHandleAdornment")
            adorn.Name = "ChamBox"
            adorn.Adornee = part
            adorn.AlwaysOnTop = true
            adorn.ZIndex = 10
            adorn.Size = part.Size
            adorn.Color3 = chamColor
            adorn.Transparency = chamTransparency
            adorn.Parent = part
        end
    end
end

-- Add chams to all players
local function onPlayerAdded(player)
    player.CharacterAdded:Connect(function(character)
        -- wait until character fully loads
        character:WaitForChild("HumanoidRootPart")
        task.wait(0.5)
        applyChams(character)
    end)
    if player.Character then
        applyChams(player.Character)
    end
end

-- Loop existing players
for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        onPlayerAdded(player)
    end
end

-- Detect new players
Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        onPlayerAdded(player)
    end
end)
        if not success then
            warn("Failed to load CHAMS script: " .. tostring(err))
        end
    else
        -- 🔘 Destroy all existing Chams
for _, player in pairs(game:GetService("Players"):GetPlayers()) do
    if player.Character then
        for _, part in pairs(player.Character:GetChildren()) do
            if part:IsA("BasePart") then
                local cham = part:FindFirstChild("ChamBox")
                if cham then
                    cham:Destroy()
                end
            end
        end
    end
end
    end
end)


