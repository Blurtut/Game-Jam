--[[
	Demonstrates how to update a player's camera to create an Isometric Camera style.
	The camera updates every render step to ensure the camera maintains a constant distance from the player, as well as follows the player as they move.
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
-- Change the camera type to Scriptable to not conflict with the default camera behavior
camera.CameraType = Enum.CameraType.Scriptable


-- Controls how far the camera is relative to the player's position
local CAMERA_DEPTH = 75
-- Controls the height above the player the camera will focus towards
local HEIGHT_OFFSET = 2
-- Field of view controls how much of the world the player can see
local FIELD_OF_VIEW = 20
-- Control the delay of camera following the player
local CAMERA_SPEED = 0.1
local CAMERA_OFFSET = Vector3.new(2, 30, 0)
local currentCameraCFrame = camera.CFrame


--[[
Runs every render step to ensure camera:
	- maintains a constant distance from the player
	- follows the player as they move
--]]

local function updateCamera(dt)
	local character = player.Character
	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	if character then
		if humanoidRootPart then
			local playerPosition = humanoidRootPart.Position + Vector3.yAxis * HEIGHT_OFFSET
			local cameraPosition = playerPosition + Vector3.one * CAMERA_DEPTH

			local target = CFrame.lookAt(cameraPosition, playerPosition)
			currentCameraCFrame = currentCameraCFrame:Lerp(target, CAMERA_SPEED)
			camera.CFrame = currentCameraCFrame
		end
	end
end

-- Set the camera's field of view
camera.FieldOfView = FIELD_OF_VIEW

-- Update the camera every render step
RunService.RenderStepped:Connect(function(dt)
	updateCamera(dt)
end)
