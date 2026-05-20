--// Xynn Hub
--// Auto Bonus Claim + FinishedRace Spam + Auto Claim Cash
--// Drag + Minimize + Close
--// Safe Hook (Compact UI)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

pcall(function()
    CoreGui:FindFirstChild("XynnHub"):Destroy()
end)

--// Remote
local FinishedRace = ReplicatedStorage
    :WaitForChild("Packages")
    :WaitForChild("_Index")
    :WaitForChild("sleitnick_knit@1.7.0")
    :WaitForChild("knit")
    :WaitForChild("Services")
    :WaitForChild("RunningService")
    :WaitForChild("RF")
    :WaitForChild("FinishedRace")

--// Variables
local autoBonus = false
local autoSpam = false
local autoClaimCash = false
local spamAmount = 10
local bypass = false

--// GUI
local gui = Instance.new("ScreenGui")
gui.Name = "XynnHub"
gui.ResetOnSpawn = false
gui.Parent = CoreGui

-- Main (lebih kecil)
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 250, 0, 200)
main.Position = UDim2.new(0.5, -125, 0.5, -127)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.BorderSizePixel = 0
main.Parent = gui

local mainCorner = Instance.new("UICorner", main)
mainCorner.CornerRadius = UDim.new(0, 12)

local shadow = Instance.new("UIStroke", main)
shadow.Color = Color3.fromRGB(10, 10, 10)
shadow.Thickness = 1
shadow.Transparency = 0.7

-- Topbar (lebih pendek)
local top = Instance.new("Frame")
top.Size = UDim2.new(1, 0, 0, 34)
top.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
top.BorderSizePixel = 0
top.Parent = main

local topCorner = Instance.new("UICorner", top)
topCorner.CornerRadius = UDim.new(0, 12)

local topGradient = Instance.new("UIGradient", top)
topGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 65, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(65, 150, 255))
}
topGradient.Rotation = 90

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -70, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Xynn Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.new(1, 1, 1)
title.Parent = top

-- Minimize button
local mini = Instance.new("TextButton")
mini.Size = UDim2.new(0, 24, 0, 24)
mini.Position = UDim2.new(1, -52, 0, 5)
mini.Text = "-"
mini.Font = Enum.Font.GothamBold
mini.TextSize = 18
mini.TextColor3 = Color3.new(1, 1, 1)
mini.BackgroundColor3 = Color3.fromRGB(0.15, 0, 155, 0.15)
mini.BorderSizePixel = 0
mini.Parent = top

local miniCorner = Instance.new("UICorner", mini)
miniCorner.CornerRadius = UDim.new(1, 0)

mini.MouseEnter:Connect(function()
    mini.BackgroundColor3 = Color3.fromRGB(255, 255, 255, 0.25)
end)
mini.MouseLeave:Connect(function()
    mini.BackgroundColor3 = Color3.fromRGB(0.15, 0, 155, 0.15)
end)

-- Close button
local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 24, 0, 24)
close.Position = UDim2.new(1, -26, 0, 5)
close.Text = "X"
close.Font = Enum.Font.GothamBold
close.TextSize = 14
close.TextColor3 = Color3.new(1, 1, 1)
close.BackgroundColor3 = Color3.fromRGB(255, 60, 60, 0.8)
close.BorderSizePixel = 0
close.Parent = top

local closeCorner = Instance.new("UICorner", close)
closeCorner.CornerRadius = UDim.new(1, 0)

close.MouseEnter:Connect(function()
    close.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
end)
close.MouseLeave:Connect(function()
    close.BackgroundColor3 = Color3.fromRGB(255, 60, 60, 0.8)
end)

-- ===== TOGGLE CLAIM CASH (paling atas) =====
local claimCashContainer = Instance.new("Frame")
claimCashContainer.Size = UDim2.new(1, -16, 0, 40)
claimCashContainer.Position = UDim2.new(0, 8, 0, 32)
claimCashContainer.BackgroundTransparency = 1
claimCashContainer.Parent = main

local claimCashLabel = Instance.new("TextLabel")
claimCashLabel.Size = UDim2.new(0, 100, 1, 0)
claimCashLabel.Position = UDim2.new(0, 2, 0, 0)
claimCashLabel.BackgroundTransparency = 1
claimCashLabel.Text = "Claim Cash"
claimCashLabel.Font = Enum.Font.GothamSemibold
claimCashLabel.TextSize = 13
claimCashLabel.TextXAlignment = Enum.TextXAlignment.Left
claimCashLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
claimCashLabel.Parent = claimCashContainer

local claimCashSwitch = Instance.new("TextButton")
claimCashSwitch.Size = UDim2.new(0, 40, 0, 22)
claimCashSwitch.Position = UDim2.new(1, -48, 0.5, -11)
claimCashSwitch.BackgroundTransparency = 1
claimCashSwitch.Text = ""
claimCashSwitch.Parent = claimCashContainer

local claimCashTrack = Instance.new("Frame")
claimCashTrack.Size = UDim2.new(1, 0, 1, 0)
claimCashTrack.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
claimCashTrack.BorderSizePixel = 0
claimCashTrack.Parent = claimCashSwitch
Instance.new("UICorner", claimCashTrack).CornerRadius = UDim.new(1, 0)

local claimCashKnob = Instance.new("Frame")
claimCashKnob.Size = UDim2.new(0, 18, 0, 18)
claimCashKnob.Position = UDim2.new(0, 2, 0.5, -9)
claimCashKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
claimCashKnob.BorderSizePixel = 0
claimCashKnob.Parent = claimCashSwitch
Instance.new("UICorner", claimCashKnob).CornerRadius = UDim.new(1, 0)

Instance.new("UIStroke", claimCashKnob).Color = Color3.fromRGB(0, 0, 0)
claimCashKnob.UIStroke.Thickness = 1
claimCashKnob.UIStroke.Transparency = 0.5

local function updateClaimCashVisual(on)
    if on then
        claimCashTrack.BackgroundColor3 = Color3.fromRGB(80, 180, 100)
        claimCashKnob.Position = UDim2.new(1, -20, 0.5, -9)
    else
        claimCashTrack.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        claimCashKnob.Position = UDim2.new(0, 2, 0.5, -9)
    end
end
updateClaimCashVisual(false)

claimCashSwitch.MouseButton1Click:Connect(function()
    autoClaimCash = not autoClaimCash
    updateClaimCashVisual(autoClaimCash)
end)

-- ===== TOGGLE BONUS TRAIN =====
local bonusContainer = Instance.new("Frame")
bonusContainer.Size = UDim2.new(1, -16, 0, 40)
bonusContainer.Position = UDim2.new(0, 8, 0, 60)
bonusContainer.BackgroundTransparency = 1
bonusContainer.Parent = main

local bonusLabel = Instance.new("TextLabel")
bonusLabel.Size = UDim2.new(0, 100, 1, 0)
bonusLabel.Position = UDim2.new(0, 2, 0, 0)
bonusLabel.BackgroundTransparency = 1
bonusLabel.Text = "Bonus Train"
bonusLabel.Font = Enum.Font.GothamSemibold
bonusLabel.TextSize = 13
bonusLabel.TextXAlignment = Enum.TextXAlignment.Left
bonusLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
bonusLabel.Parent = bonusContainer

local bonusSwitch = Instance.new("TextButton")
bonusSwitch.Size = UDim2.new(0, 40, 0, 22)
bonusSwitch.Position = UDim2.new(1, -48, 0.5, -11)
bonusSwitch.BackgroundTransparency = 1
bonusSwitch.Text = ""
bonusSwitch.Parent = bonusContainer

local bonusTrack = Instance.new("Frame")
bonusTrack.Size = UDim2.new(1, 0, 1, 0)
bonusTrack.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
bonusTrack.BorderSizePixel = 0
bonusTrack.Parent = bonusSwitch
Instance.new("UICorner", bonusTrack).CornerRadius = UDim.new(1, 0)

local bonusKnob = Instance.new("Frame")
bonusKnob.Size = UDim2.new(0, 18, 0, 18)
bonusKnob.Position = UDim2.new(0, 2, 0.5, -9)
bonusKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
bonusKnob.BorderSizePixel = 0
bonusKnob.Parent = bonusSwitch
Instance.new("UICorner", bonusKnob).CornerRadius = UDim.new(1, 0)

Instance.new("UIStroke", bonusKnob).Color = Color3.fromRGB(0, 0, 0)
bonusKnob.UIStroke.Thickness = 1
bonusKnob.UIStroke.Transparency = 0.5

local function updateBonusVisual(on)
    if on then
        bonusTrack.BackgroundColor3 = Color3.fromRGB(80, 180, 100)
        bonusKnob.Position = UDim2.new(1, -20, 0.5, -9)
    else
        bonusTrack.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        bonusKnob.Position = UDim2.new(0, 2, 0.5, -9)
    end
end
updateBonusVisual(false)

bonusSwitch.MouseButton1Click:Connect(function()
    autoBonus = not autoBonus
    updateBonusVisual(autoBonus)
end)

-- ===== TOGGLE RACE SPAM =====
local spamContainer = Instance.new("Frame")
spamContainer.Size = UDim2.new(1, -16, 0, 40)
spamContainer.Position = UDim2.new(0, 8, 0, 88)
spamContainer.BackgroundTransparency = 1
spamContainer.Parent = main

local spamLabel = Instance.new("TextLabel")
spamLabel.Size = UDim2.new(0, 100, 1, 0)
spamLabel.Position = UDim2.new(0, 2, 0, 0)
spamLabel.BackgroundTransparency = 1
spamLabel.Text = "Race Spam"
spamLabel.Font = Enum.Font.GothamSemibold
spamLabel.TextSize = 13
spamLabel.TextXAlignment = Enum.TextXAlignment.Left
spamLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
spamLabel.Parent = spamContainer

local spamSwitch = Instance.new("TextButton")
spamSwitch.Size = UDim2.new(0, 40, 0, 22)
spamSwitch.Position = UDim2.new(1, -48, 0.5, -11)
spamSwitch.BackgroundTransparency = 1
spamSwitch.Text = ""
spamSwitch.Parent = spamContainer

local spamTrack = Instance.new("Frame")
spamTrack.Size = UDim2.new(1, 0, 1, 0)
spamTrack.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
spamTrack.BorderSizePixel = 0
spamTrack.Parent = spamSwitch
Instance.new("UICorner", spamTrack).CornerRadius = UDim.new(1, 0)

local spamKnob = Instance.new("Frame")
spamKnob.Size = UDim2.new(0, 18, 0, 18)
spamKnob.Position = UDim2.new(0, 2, 0.5, -9)
spamKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
spamKnob.BorderSizePixel = 0
spamKnob.Parent = spamSwitch
Instance.new("UICorner", spamKnob).CornerRadius = UDim.new(1, 0)

Instance.new("UIStroke", spamKnob).Color = Color3.fromRGB(0, 0, 0)
spamKnob.UIStroke.Thickness = 1
spamKnob.UIStroke.Transparency = 0.5

local function updateSpamVisual(on)
    if on then
        spamTrack.BackgroundColor3 = Color3.fromRGB(80, 180, 100)
        spamKnob.Position = UDim2.new(1, -20, 0.5, -9)
    else
        spamTrack.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        spamKnob.Position = UDim2.new(0, 2, 0.5, -9)
    end
end
updateSpamVisual(false)

spamSwitch.MouseButton1Click:Connect(function()
    autoSpam = not autoSpam
    updateSpamVisual(autoSpam)
end)

--// Slider Spam Amount (lebih kecil)
local sliderContainer = Instance.new("Frame")
sliderContainer.Size = UDim2.new(1, -16, 0, 42)
sliderContainer.Position = UDim2.new(0, 8, 0, 130)
sliderContainer.BackgroundTransparency = 1
sliderContainer.Parent = main

local sliderLabel = Instance.new("TextLabel")
sliderLabel.Size = UDim2.new(0, 100, 0, 18)
sliderLabel.Position = UDim2.new(0, 2, 0, -5)
sliderLabel.BackgroundTransparency = 1
sliderLabel.Text = "Spam Amount"
sliderLabel.Font = Enum.Font.GothamSemibold
sliderLabel.TextSize = 13
sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
sliderLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
sliderLabel.Parent = sliderContainer

local track = Instance.new("Frame")
track.Size = UDim2.new(0, 190, 0, 5)
track.Position = UDim2.new(0, 2, 0, 24)
track.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
track.BorderSizePixel = 0
track.Parent = sliderContainer
Instance.new("UICorner", track).CornerRadius = UDim.new(0, 2)

local fill = Instance.new("Frame")
fill.Size = UDim2.new(0, 0, 1, 0)
fill.Position = UDim2.new(0, 0, 0, 0)
fill.BackgroundColor3 = Color3.fromRGB(80, 180, 100)
fill.BorderSizePixel = 0
fill.Parent = track
Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 2)

local fillGradient = Instance.new("UIGradient", fill)
fillGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 180, 100)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 220, 160))
}

local knob = Instance.new("TextButton")
knob.Size = UDim2.new(0, 16, 0, 16)
knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
knob.BorderSizePixel = 0
knob.Text = ""
knob.Parent = sliderContainer
Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

Instance.new("UIStroke", knob).Color = Color3.fromRGB(0, 0, 0)
knob.UIStroke.Thickness = 1
knob.UIStroke.Transparency = 0.6

local valueLabel = Instance.new("TextLabel")
valueLabel.Size = UDim2.new(0, 35, 0, 18)
valueLabel.Position = UDim2.new(0, 200, 0, 16)
valueLabel.BackgroundTransparency = 1
valueLabel.Text = tostring(spamAmount)
valueLabel.Font = Enum.Font.GothamBold
valueLabel.TextSize = 13
valueLabel.TextColor3 = Color3.new(1, 1, 1)
valueLabel.TextXAlignment = Enum.TextXAlignment.Center
valueLabel.Parent = sliderContainer

-- Slider logic (disesuaikan)
local SLIDER_MIN = 1
local SLIDER_MAX = 50
local TRACK_WIDTH = 190

local function updateSlider(value)
    value = math.clamp(math.floor(value + 0.5), SLIDER_MIN, SLIDER_MAX)
    spamAmount = value
    valueLabel.Text = tostring(value)

    local percent = (value - SLIDER_MIN) / (SLIDER_MAX - SLIDER_MIN)
    local knobX = 2 + percent * TRACK_WIDTH - 8
    knob.Position = UDim2.new(0, knobX, 0, 19)
    fill.Size = UDim2.new(0, percent * TRACK_WIDTH, 1, 0)
end
updateSlider(spamAmount)

local draggingKnob = false

knob.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingKnob = true
    end
end)

track.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local mousePos = UserInputService:GetMouseLocation()
        local trackAbsX = track.AbsolutePosition.X
        local relativeX = mousePos.X - trackAbsX
        local percent = math.clamp(relativeX / TRACK_WIDTH, 0, 1)
        local newValue = SLIDER_MIN + percent * (SLIDER_MAX - SLIDER_MIN)
        updateSlider(newValue)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if draggingKnob and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mousePos = UserInputService:GetMouseLocation()
        local trackAbsX = track.AbsolutePosition.X
        local relativeX = mousePos.X - trackAbsX
        local percent = math.clamp(relativeX / TRACK_WIDTH, 0, 1)
        local newValue = SLIDER_MIN + percent * (SLIDER_MAX - SLIDER_MIN)
        updateSlider(newValue)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingKnob = false
    end
end)

--// Drag (main window)
local dragging = false
local dragStart
local startPos

top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

--// Close
close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

--// Minimize
local minimized = false
local contentObjects = {
    claimCashContainer,
    bonusContainer,
    spamContainer,
    sliderContainer
}

mini.MouseButton1Click:Connect(function()
    minimized = not minimized
    for _, obj in ipairs(contentObjects) do
        obj.Visible = not minimized
    end
    if minimized then
        main.Size = UDim2.new(0, 250, 0, 34)
    else
        main.Size = UDim2.new(0, 250, 0, 200)
    end
end)

--// Auto Bonus Claim (unchanged)
task.spawn(function()
    while task.wait(0.1) do
        if autoBonus then
            pcall(function()
                local button =
                    LocalPlayer.PlayerGui
                    .SpeedEffect
                    .LeftContainer
                    .Currency
                    .Speed
                    .x2Speed
                    .Button

                if button.Parent.Visible then
                    for _,conn in pairs(
                        getconnections(button.Activated)
                    ) do
                        local func = conn.Function
                        if func then
                            pcall(func)
                        end
                    end
                end
            end)
        end
    end
end)

--// FinishedRace Hook (unchanged)
local old
old = hookmetamethod(game, "__namecall", function(self, ...)
    local args = {...}
    local method = getnamecallmethod()

    if not checkcaller()
    and not bypass
    and autoSpam
    and self == FinishedRace
    and method == "InvokeServer" then

        task.spawn(function()
            bypass = true
            for i = 2, spamAmount do
                task.spawn(function()
                    pcall(function()
                        FinishedRace:InvokeServer(unpack(args))
                    end)
                end)
                task.wait(0.03)
            end
            bypass = false
        end)
    end

    return old(self, ...)
end)

--// Auto Claim Cash (unchanged)
local function getMyPlot()
    local plots = Workspace:WaitForChild("Plots")
    for _, plotFolder in pairs(plots:GetChildren()) do
        for _, plot in pairs(plotFolder:GetChildren()) do
            for _, obj in pairs(plot:GetChildren()) do
                if obj.Name == LocalPlayer.Name .. "_FloatingPlotSign" then
                    return plot
                end
            end
        end
    end
end

task.spawn(function()
    if not LocalPlayer.Character then
        LocalPlayer.CharacterAdded:Wait()
    end
    local hrp = LocalPlayer.Character:WaitForChild("HumanoidRootPart")

    while task.wait(1.5) do
        if autoClaimCash then
            local myPlot = getMyPlot()
            if myPlot and myPlot:FindFirstChild("Containers") then
                for _, obj in pairs(myPlot.Containers:GetDescendants()) do
                    if obj.Name == "CollectionPad" and obj:IsA("BasePart") then
                        firetouchinterest(hrp, obj, 0)
                        firetouchinterest(hrp, obj, 1)
                    end
                end
            end
        end
    end
end)
