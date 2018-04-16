local TIMEOUT = 1 -- Length of time where no descendants have been added to consider the object loaded

-- Author: EmeraldSlash
-- Repository: https://github.com/EmeraldSlash/RbxReady
-- Last Updated: 04/16/2018

local Ready = {}

function Ready:Wait(Object, Timeout)
	if not Timeout then Timeout = TIMEOUT end		
	
	local Timestamp = tick()

	Object.DescendantAdded:Connect(function()
		Timestamp = tick()
	end)	
	
	repeat wait() until (tick() - Timestamp) > TIMEOUT
end

function Ready:Connect(Object, Function, Timeout)
	if not Timeout then Timeout = TIMEOUT end	
	
	local Timestamp = tick()
	local Connection

	local function LogDescendant(Descendant)
		local LocalTimestamp = tick()
		Timestamp = LocalTimestamp
		
		wait(TIMEOUT)
		if Timestamp == LocalTimestamp and Connection.Connected then
			Connection:Disconnect()
			Function(Descendant)			
		end
	end

	coroutine.wrap(LogDescendant)()
	Connection = Object.DescendantAdded:Connect(LogDescendant)
	
	return Connection
end

return Ready
