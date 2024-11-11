local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("CombatFramework"))
local CombatFrameworkR = getupvalues(CombatFramework)[2]
local TickWait = 0
local TickCooldown = 0.02
local FireMax = 1000
local Rig = game:GetService("ReplicatedStorage"):WaitForChild("RigControllerEvent")
local Animation = Instance.new("Animation")
local _getupvalue = (debug.getupvalue or getupvalue or getupvalues or function(...)return ... end)
local _setupvalue = (debug.setupvalue or setupvalue or setupvalues or function(...)return ... end)
BladeHits = function(Value)
    local Hits = {}
	local Client = game.Players.LocalPlayer
	local Enemies = game:GetService("Workspace").Enemies:GetChildren()
	for i,v in pairs(Enemies) do
		local Human = v:FindFirstChildOfClass("Humanoid")
		if Human and Human.RootPart and Human.Health > 0 and Client:DistanceFromCharacter(Human.RootPart.Position) < Value+5 then
			table.insert(Hits, Human.RootPart)
		end
	end
	return Hits
end
PlayerHits = function(Value)
    local Hits = {}
	local Client = game.Players.LocalPlayer
	local Characters = game:GetService("Workspace").Characters:GetChildren()
	for i,v in pairs(Characters) do
		local Human = v:FindFirstChildOfClass("Humanoid")
		if v.Name ~= game.Players.LocalPlayer.Name and Human and Human.RootPart and Human.Health > 0 and Client:DistanceFromCharacter(Human.RootPart.Position) < Value+5 then
			table.insert(Hits, Human.RootPart)
		end
	end
	return Hits
end
FireAttack = function()
    local AC = CombatFrameworkR.activeController
    if AC and AC.equipped then
        Attacked = tick() + (TickCooldown or 0.01) + ((Fire/FireMax) * 0.3)
        Fire = Fire + 1
        Rig.FireServer("weaponChange", AC.currentWeaponModel.Name)
        task.delay((TickCooldown or 0.01) - ((Fire+0.4/FireMax)*0.3), function()
            Fire = Fire - 1
        end)
    end
end
AddAttack = function()
    if Players.LocalPlayer.Character.Stun.Value ~= 0 then return nil end
    local AC = CombatFrameworkR.activeController
    if AC and AC.equipped then
        local Hit = {}
        for r, v in next, BladeHits(65) do
            table.insert(Hit, v)
        end
        for r, v in next, PlayerHits(55) do
            table.insert(Hit, v)
        end
        if #Hit > 0 then
            local agrs1 = _getupvalue(AC.attack, 5)
            local agrs2 = _getupvalue(AC.attack, 6)
            local agrs3 = _getupvalue(AC.attack, 4)
            local agrs4 = _getupvalue(AC.attack, 7)
            local agrs5 = (agrs1 * 798405 + agrs3 * 727595) % agrs2
            local agrs6 = agrs3 * 798405
            agrs5 = (agrs5 * agrs2 + agrs6) % 1099511627776
            agrs1 = math.floor(agrs5 / agrs2)
            agrs3 = agrs5 - agrs1 * agrs2
            agrs4 = agrs4 + 1
            _setupvalue(AC.attack, 5, agrs1)
            _setupvalue(AC.attack, 6, agrs2)
            _setupvalue(AC.attack, 4, agrs3)
            _setupvalue(AC.attack, 7, agrs4)
            local Blade = AC.currentWeaponModel
            Animation.AnimationId = AC.anims.basic[2]
            AC.humanoid:LoadAnimation(Animation):Play(1, 1)
            pcall(task.spawn, AC.attack, AC)
            if tick() > Attacked then
                FireAttack()
                pcall(task.spawn, AC.attack, AC)
            end
            if tick() - TickWait > 0.25 then
                AC.timeToNextAttack = 0
                AC.hitboxMagnitude = 60
                TickWait = tick()
            end
            if Blade then
                ReplicatedStorage.Remotes.Validator:FireServer(math.floor(agrs5 / 1099511627776 * 16777215), agrs4)
                Rig.FireServer(Rig, "hit", Hit, 2, "")
            end
        end
    end
end
function CheckStun()
	if game:GetService('Players').LocalPlayer.Character:FindFirstChild("Stun") then
		return game:GetService('Players').LocalPlayer.Character.Stun.Value ~= 0
	end
	return false
end
spawn(function()
    while game:GetService("RunService").Stepped:Wait() do
        local AC = CombatFrameworkR.activeController
        if AC and AC.equipped and not CheckStun() then
            AC.hitSound = nil
            task.spawn(function()
                pcall(task.spawn, AddAttack)
            end)
        end
    end
end)

local kkii = require(game.ReplicatedStorage.Util.CameraShaker)
kkii:Stop()
