
local remotes = {}
local function logRemoteCall(remote, method, args)
    if not table.find(remotes, remote) then
        table.insert(remotes, remote)
    end

    print("Remote Call Detected:")
    print("Remote:", remote)
    print("Method:", method)
    print("Arguments:")
    for i, v in ipairs(args) do
        print(i, v)
    end

    if getgenv().AdvancedMode then
        print("Advanced Info:")
        print("Remote Full Name:", remote:GetFullName())
        print("Caller:", getcallingscript() and getcallingscript().Name or "N/A")
    end
end
getgenv().AdvancedMode = true
local old_nc
old_nc = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    if not checkcaller() and (method == "FireServer" or method == "InvokeServer") then
        logRemoteCall(self, method, args)
    end
    return old_nc(self, ...)
end))
