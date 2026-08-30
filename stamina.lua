local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer

local sprinting = replicatedStorage:WaitForChild("Systems"):WaitForChild("Character"):WaitForChild("Game"):WaitForChild("Sprinting")
local stamina = require(sprinting)

local infStamina = false

-- UI.
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PotentStamina"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = game:GetService("CoreGui")

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 200, 0, 90)
mainFrame.Position = UDim2.new(0.5, -100, 0, 140)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new("UIStroke", mainFrame)
stroke.Color = Color3.fromRGB(80, 180, 255)
stroke.Thickness = 1.5

local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(80, 180, 255)
titleBar.BorderSizePixel = 0
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 8)
local titleFix = Instance.new("Frame", titleBar)
titleFix.Size = UDim2.new(1, 0, 0.5, 0)
titleFix.Position = UDim2.new(0, 0, 0.5, 0)
titleFix.BackgroundColor3 = Color3.fromRGB(80, 180, 255)
titleFix.BorderSizePixel = 0
local titleLabel = Instance.new("TextLabel", titleBar)
titleLabel.Size = UDim2.new(1, 0, 1, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "⚡ Inf Stamina — by daplayer"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 12
titleLabel.Font = Enum.Font.GothamBold

local toggleBtn = Instance.new("TextButton", mainFrame)
toggleBtn.Size = UDim2.new(1, -20, 0, 34)
toggleBtn.Position = UDim2.new(0, 10, 0, 40)
toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
toggleBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
toggleBtn.Text = "Inf Stamina: OFF"
toggleBtn.TextSize = 13
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.BorderSizePixel = 0
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 6)
local btnStroke = Instance.new("UIStroke", toggleBtn)
btnStroke.Color = Color3.fromRGB(80, 180, 255)
btnStroke.Thickness = 1

toggleBtn.MouseButton1Click:Connect(function()
	infStamina = not infStamina
	if infStamina then
		toggleBtn.Text = "Inf Stamina: ON"
		toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 100, 200)
	else
		toggleBtn.Text = "Inf Stamina: OFF"
		toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
		stamina.MaxStamina = 100
		stamina.MinStamina = 0
		stamina.StaminaGain = 20
		stamina.StaminaLoss = 10
		stamina.StaminaLossDisabled = false
	end
end)

task.spawn(function()
	while task.wait() do
		if infStamina then
			stamina.MaxStamina = 100
			stamina.MinStamina = 0
			stamina.StaminaGain = 1000
			stamina.StaminaLoss = 0
			stamina.StaminaLossDisabled = true
		end
	end
end)