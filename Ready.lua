local TIMEOUT = 1 -- Length of time where no descendants have been added to consider the object loaded

-- Author: EmeraldSlash
-- Repository: https://github.com/EmeraldSlash/RbxReady
-- Last Updated: 04/16/2018

local Ready = {}

function Ready:Wait(Object)
	local Timestamp = tick()

	Object.DescendantAdded:Connect(function()
		Timestamp = tick()
	end)	
	
	repeat wait() until (tick() - Timestamp) > TIMEOUT
end

function Ready:Connect(Object, Function)
	local Timestamp = tick()
	local Connection

	Connection = Object.DescendantAdded:Connect(function(Descendant)
		local LocalTimestamp = tick()
		Timestamp = LocalTimestamp
		
		wait(TIMEOUT)
		if Timestamp == LocalTimestamp and Connection.Connected then
			Connection:Disconnect()
			Function(Descendant)			
		end
	end)
end

return Ready
