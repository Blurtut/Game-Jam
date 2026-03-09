-- Disable Jump
local character = script.Parent
local humanoid = character:WaitForChild("Humanoid")
local userInput = game:GetService("UserInputService")
local player = {
	stamina = 100, 
	speed = 20, 
}

-- This disables the ability for the humanoid to enter the jumping state
humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)

local WalkSpd = function(value)
	humanoid.WalkSpeed = value
end

WalkSpd(player.speed)


userInput.InputBegan:Connect(function(input, gameProcessed)
	local playerSprint = player.speed + 10
	if gameProcessed then return end
	if userInput:IsKeyDown(Enum.KeyCode.LeftShift) then 
		while player.stamina > 0 do
			WalkSpd(playerSprint)
			print("reducing stamina")
			player.stamina -= 1
		end	
		WalkSpd(player.speed)
	else
	end
end)

-- More code here that runs immediately?