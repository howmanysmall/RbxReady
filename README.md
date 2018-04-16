# RbxReady
A way to wait until an object has been fully loaded.

# Usage
There is a single config variable in the module called `TIMEOUT`. This is default number of seconds the script will wait where no descendants have been added to deem the object loaded.

```lua
local Ready = require(script.Ready)

Ready:Wait(workspace, 10)

Ready:Connect(workspace, function(LastToLoad)
  print("Workspace has been fully loaded - the last instance to load was " ..LastToLoad)
end, 10)
```

# API
### *void* Ready:Wait(*instance* Object, *number* Timeout)

Repeatedly calls `wait()` until it has been `x` seconds since the last descendant of `Object` was added (where `x` is the value of the config variable `TIMEOUT` in the module, or the `Timeout` variable passed in as an argument).

### *RBXScriptConnection* Ready:Connect(*instance* Object, *function* Callback, *number* Timeout)

Waits `x` seconds after every time a descendant of `Object` was added, then calls `Callback` if no other descendants had been added in the wait time. Returns a `RBXScriptConnection` which can be disconnected at any time, and is disconnected after the object has loaded.

The `Callback` function may take one argument; this being the last descendant that was added. Will be `nil` if no descendants were added.
