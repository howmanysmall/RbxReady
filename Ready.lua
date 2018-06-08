local DEFAULT_TIMEOUT = 1 -- Length of time where no descendants have been added to consider the object loaded

-- @author EmeraldSlash
-- @repository https://github.com/EmeraldSlash/RbxReady
-- @rostrap Can be loaded using the Rostrap library manager

local Ready = {}

function Ready:Wait(Object, Timeout)
	if not Timeout then Timeout = DEFAULT_TIMEOUT end		
	
	local Timestamp = tick()
	local LastDescendant

	Object.DescendantAdded:Connect(function(Descendant)
		Timestamp = tick()
		LastDescendant = Descendant
	end)	
	
	repeat wait() until (tick() - Timestamp) > Timeout
	return LastDescendant
end

function Ready:Connect(Object, Function, Timeout)
	if not Timeout then Timeout = DEFAULT_TIMEOUT end	
	
	local Timestamp = tick()
	local Connection

	local function LogDescendant(Descendant)
		local LocalTimestamp = tick()
		Timestamp = LocalTimestamp
		
		wait(Timeout)
		if Timestamp == LocalTimestamp and Connection.Connected then
			Connection:Disconnect()
			Function(Descendant)			
		end
	end

	coroutine.resume(coroutine.create(LogDescendant))
	Connection = Object.DescendantAdded:Connect(LogDescendant)
	
	return Connection
end

return Ready
