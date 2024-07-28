-- dragging with topbar
local uic = game:GetService("UserInputService")

local isDragging = false
local dragInput
local mouseStartPos
local frameStartPos

local topBar -- equal to the topbar you are moving to move the frame
local frame -- equal to the frame u wanted to move

local function upd(input)
	local delta = input.Position - mouseStartPos
	frame.Position = UDim2.new(frameStartPos.X.Scale, frameStartPos.X.Offset + delta.X, frameStartPos.Y.Scale, frameStartPos.Y.Offset + delta.Y)
end

topBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		isDragging = true
		mouseStartPos = input.Position
		frameStartPos = frame.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				isDragging = false
			end
		end)
	end
	
end)

topBar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

uic.InputChanged:Connect(function(inp)
	if inp == dragInput and isDragging then
		upd(inp)
	end
end)
