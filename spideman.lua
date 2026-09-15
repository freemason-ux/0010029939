local players = game:GetService("Players")
local runService = game:GetService("RunService")
local replicatedStorage = game:GetService("ReplicatedStorage")

local localPlayer = players.LocalPlayer
local char = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local behaviorFolder = replicatedStorage:WaitForChild("Assets"):WaitForChild("Survivors"):WaitForChild("Veeronica"):WaitForChild("Behavior")
local lastTrick = 0
local autoTrick = false

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PotentVeeronica"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = game:GetService("CoreGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 110)
mainFrame.Position = UDim2.new(0.5, -110, 0, 20)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(220, 60, 180)
stroke.Thickness = 1.5
stroke.Parent = mainFrame

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 32)
titleBar.BackgroundColor3 = Color3.fromRGB(220, 60, 180)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = titleBar

local titleFix = Instance.new("Frame")
titleFix.Size = UDim2.new(1, 0, 0.5, 0)
titleFix.Position = UDim2.new(0, 0, 0.5, 0)
titleFix.BackgroundColor3 = Color3.fromRGB(220, 60, 180)
titleFix.BorderSizePixel = 0
titleFix.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 1, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "🛹 Veeronica — by spiderman"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 13
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = titleBar

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(1, -20, 0, 36)
toggleBtn.Position = UDim2.new(0, 10, 0, 42)
toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
toggleBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
toggleBtn.Text = "Auto Trick: OFF"
toggleBtn.TextSize = 14
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.BorderSizePixel = 0
toggleBtn.Parent = mainFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = toggleBtn

local btnStroke = Instance.new("UIStroke")
btnStroke.Color = Color3.fromRGB(220, 60, 180)
btnStroke.Thickness = 1
btnStroke.Parent = toggleBtn

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 84)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Waiting..."
statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
statusLabel.TextSize = 11
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = mainFrame

local function setStatus(text, color)
	statusLabel.Text = text
	statusLabel.TextColor3 = color or Color3.fromRGB(150, 150, 150)
end

local function isHighlightTargetMe(highlight)
	if not char or not highlight.Adornee then return false end
	if highlight.Adornee == char then return true end
	if char:FindFirstChild(highlight.Adornee.Name) and highlight.Adornee:IsDescendantOf(char) then
		return true
	end
	return false
end

local function pressMobileButton()
	local btn = localPlayer.PlayerGui:WaitForChild("MainUI"):WaitForChild("SprintingButton")
	for _, connection in pairs(getconnections(btn.MouseButton1Down)) do
		pcall(function()
			if connection.Fire then connection:Fire()
			elseif connection.Function then connection:Function() end
		end)
	end
end

toggleBtn.MouseButton1Click:Connect(function()
	autoTrick = not autoTrick
	if autoTrick then
		toggleBtn.Text = "Auto Trick: ON"
		toggleBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 140)
		setStatus("Activate Sk8 near a surface!", Color3.fromRGB(220, 60, 180))
	else
		toggleBtn.Text = "Auto Trick: OFF"
		toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
		setStatus("Waiting...", Color3.fromRGB(150, 150, 150))
	end
end)

runService.Heartbeat:Connect(function()
	if not autoTrick then return end
	local t = tick()
	if t - lastTrick < 0.3 then return end
	for _, obj in pairs(behaviorFolder:GetDescendants()) do
		if obj:IsA("Highlight") and isHighlightTargetMe(obj) then
			lastTrick = t
			setStatus("Tricking!", Color3.fromRGB(100, 255, 100))
			pressMobileButton()
			break
		end
	end
end)

localPlayer.CharacterAdded:Connect(function(newChar)
	char = newChar
end)