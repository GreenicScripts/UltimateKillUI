-- LocalPlayer UI Reset Script
-- Does NOT affect other players
-- Safe GUI utility

--// Ultimate Kill UI by Grennic + Copilot
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local lp = Players.LocalPlayer

--// GUI
local gui = Instance.new("ScreenGui")
gui.Name = "UltimateKillUI"
gui.ResetOnSpawn = false

pcall(function()
    gui.Parent = game:GetService("CoreGui")
end)

if not gui.Parent then
    gui.Parent = lp:WaitForChild("PlayerGui")
end

--// Kill Function
local function killPlayer()
    local char = lp.Character or lp.CharacterAdded:Wait()
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then hum.Health = 0 end
end

--// Universal Sound Player
local function playSound(id, vol)
    local s = Instance.new("Sound")
    s.SoundId = "rbxassetid://"..id
    s.Volume = vol or 1
    s.Parent = gui
    s:Play()
    task.delay(1, function() s:Destroy() end)
end

--// Fade-out animation
local function fadeOut(obj)
    local tween = TweenService:Create(obj, TweenInfo.new(0.4), {BackgroundTransparency = 1})
    tween:Play()
    for _,v in ipairs(obj:GetDescendants()) do
        if v:IsA("TextLabel") or v:IsA("TextButton") then
            TweenService:Create(v, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
        elseif v:IsA("UIStroke") then
            TweenService:Create(v, TweenInfo.new(0.4), {Transparency = 1}):Play()
        end
    end
    task.wait(0.4)
    obj:Destroy()
end

--// Draggable Function
local function makeDraggable(frame)
    local dragging, dragStart, startPos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

--// Kill Button
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0,160,0,50)
btn.Position = UDim2.new(0.5,-80,0.8,0)
btn.BackgroundColor3 = Color3.fromRGB(20,20,20)
btn.Text = "KILL ME"
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 20
btn.Parent = gui

makeDraggable(btn)

local corner = Instance.new("UICorner", btn)
corner.CornerRadius = UDim.new(0,8)

local stroke = Instance.new("UIStroke", btn)
stroke.Thickness = 3
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

--// Rainbow Outline Loop
task.spawn(function()
    local hue = 0
    while btn.Parent do
        hue = (hue + 0.01) % 1
        stroke.Color = Color3.fromHSV(hue,1,1)
        task.wait(0.03)
    end
end)

--// ⭐ UPDATED HOVER SOUND (92876108656319)
btn.MouseEnter:Connect(function()
    playSound(92876108656319, 0.9)
    TweenService:Create(btn, TweenInfo.new(0.15), {Size = UDim2.new(0,170,0,55)}):Play()
end)

btn.MouseLeave:Connect(function()
    TweenService:Create(btn, TweenInfo.new(0.15), {Size = UDim2.new(0,160,0,50)}):Play()
end)

btn.MouseButton1Click:Connect(function()
    playSound(12221967, 1)
    killPlayer()
end)

--// FIRST NOTIFICATION
local notif = Instance.new("Frame")
notif.Size = UDim2.new(0,280,0,60)
notif.Position = UDim2.new(0.5,-140,0.1,0)
notif.BackgroundColor3 = Color3.fromRGB(25,25,25)
notif.Parent = gui

makeDraggable(notif)

local notifCorner = Instance.new("UICorner", notif)
notifCorner.CornerRadius = UDim.new(0,8)

local notifStroke = Instance.new("UIStroke", notif)
notifStroke.Thickness = 2

task.spawn(function()
    local hue = 0
    while notif.Parent do
        hue = (hue + 0.01) % 1
        notifStroke.Color = Color3.fromHSV(hue,1,1)
        task.wait(0.03)
    end
end)

local notifText = Instance.new("TextLabel")
notifText.Size = UDim2.new(1,-40,1,0)
notifText.Position = UDim2.new(0,10,0,0)
notifText.BackgroundTransparency = 1
notifText.Text = "R to reset for Computer"
notifText.Font = Enum.Font.GothamBold
notifText.TextSize = 18
notifText.TextColor3 = Color3.new(1,1,1)
notifText.TextXAlignment = Enum.TextXAlignment.Left
notifText.Parent = notif

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0,25,0,25)
closeBtn.Position = UDim2.new(1,-30,0,5)
closeBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Parent = notif

local closeCorner = Instance.new("UICorner", closeBtn)
closeCorner.CornerRadius = UDim.new(0,6)

--// SECOND NOTIFICATION (Made by Grennic)
local function spawnSecondNotif()
    local n2 = Instance.new("Frame")
    n2.Size = UDim2.new(0,260,0,60)
    n2.Position = UDim2.new(0.5,-130,0.18,0)
    n2.BackgroundColor3 = Color3.fromRGB(25,25,25)
    n2.Parent = gui

    makeDraggable(n2)

    local c2 = Instance.new("UICorner", n2)
    c2.CornerRadius = UDim.new(0,8)

    local s2 = Instance.new("UIStroke", n2)
    s2.Thickness = 2

    task.spawn(function()
        local hue = 0
        while n2.Parent do
            hue = (hue + 0.01) % 1
            s2.Color = Color3.fromHSV(hue,1,1)
            task.wait(0.03)
        end
    end)

    local t2 = Instance.new("TextLabel")
    t2.Size = UDim2.new(1,-20,1,0)
    t2.Position = UDim2.new(0,10,0,0)
    t2.BackgroundTransparency = 1
    t2.Text = "Made by Grennic"
    t2.Font = Enum.Font.GothamBold
    t2.TextSize = 20
    t2.TextColor3 = Color3.new(1,1,1)
    t2.Parent = n2

    task.delay(2, function()
        fadeOut(n2)
    end)
end

--// Close first → spawn second
closeBtn.MouseButton1Click:Connect(function()
    playSound(12221967, 1)
    fadeOut(notif)
    task.wait(0.4)
    spawnSecondNotif()
end)

--// R Keybind
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.R then
        playSound(9118823101, 1)
        killPlayer()
    end
end)

--// Mobile Reset Button
local mobileBtn = Instance.new("TextButton")
mobileBtn.Size = UDim2.new(0,120,0,40)
mobileBtn.Position = UDim2.new(0.5,-60,0.88,0)
mobileBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
mobileBtn.Text = "RESET"
mobileBtn.TextColor3 = Color3.new(1,1,1)
mobileBtn.Font = Enum.Font.GothamBold
mobileBtn.TextSize = 18
mobileBtn.Visible = UserInputService.TouchEnabled
mobileBtn.Parent = gui

makeDraggable(mobileBtn)

local mobileCorner = Instance.new("UICorner", mobileBtn)
mobileCorner.CornerRadius = UDim.new(0,8)

mobileBtn.MouseButton1Click:Connect(function()
    playSound(12221967, 1)
    killPlayer()
end)
