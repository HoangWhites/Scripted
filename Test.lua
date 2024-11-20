print("[Whites Hub] Loading FastAttack")
local RL = require(game:GetService("ReplicatedStorage").CombatFramework.RigLib)
RL.wrapAttackAnimationAsync = function(a)
	a:Play(0.001, 0.001, 0.001)
end
AllBladeHits = function(Sizes)
	local Hits = {}
	local Client = game.Players.LocalPlayer
	local Enemies = game:GetService("Workspace").Enemies:GetChildren()
	for i,v in pairs(Enemies) do
		local Human = v:FindFirstChildOfClass("Humanoid")
		if Human and Human.RootPart and Human.Health > 0 and Client:DistanceFromCharacter(Human.RootPart.Position) < Sizes+5 then
			table.insert(Hits,Human.RootPart)
		end
	end
	return Hits
end
PlayersBladeHits = function(Sizes)
	local Hits = {}
	local Client = game.Players.LocalPlayer
	local Characters = game:GetService("Workspace").Characters:GetChildren()
	for i,v in pairs(Characters) do
		local Human = v:FindFirstChildOfClass("Humanoid")
		if v.Name ~= game.Players.LocalPlayer.Name and Human and Human.RootPart and Human.Health > 0 and Client:DistanceFromCharacter(Human.RootPart.Position) < Sizes+5 then
			table.insert(Hits,Human.RootPart)
		end
	end
	return Hits
end
local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("CombatFramework"))
local CombatFrameworkR = getupvalues(CombatFramework)[2]
local Rig = game:GetService("ReplicatedStorage").RigControllerEvent
local Aniamtion = Instance.new("Animation")
local TickAttack = 0
local Cooldown = 0
local MaxAttack = 1000
local Delay = 0.02
local Attacked = 0
local bladehit = {}
local RS = game.ReplicatedStorage
local _getupvalue = (debug.getupvalue or getupvalue or getupvalues or function(...)return ... end)
local _setupvalue = (debug.setupvalue or setupvalue or setupvalues or function(...)return ... end)

FireAttack = function()
	local ac = CombatFrameworkR.activeController
	if ac and ac.equipped then
		TickAttack = tick() + (Delay or 0.02) + ((Attacked/MaxAttack)*0.3)
		Rig.FireServer(Rig,"weaponChange",ac.currentWeaponModel.Name)
		Attacked = Attacked + 1
		task.delay((Delay or 0.02) + ((Attacked+0.4/MaxAttack)*0.3),function()
			Attacked = Attacked - 1
		end)
	end
end

Attack = function(typef)
	local ac = CombatFrameworkR.activeController
	if ac and ac.equipped then
		local bladehit = {}
        for r,v in pairs(AllBladeHits(55)) do
            table.insert(bladehit, v)
        end
        for r,v in pairs(PlayersBladeHits(55)) do
            table.insert(bladehit, v)
        end
		if #bladehit > 0 then
            pcall(task.spawn, ac.attack, ac)
            local agrs1 = _getupvalue(ac.attack, 5)
            local agrs2 = _getupvalue(ac.attack, 6)
            local agrs3 = _getupvalue(ac.attack, 4)
            local agrs4 = _getupvalue(ac.attack, 7)
            local agrs5 = (agrs1 * 798405 + agrs3 * 727595) % agrs2
            local agrs6 = agrs3 * 798405
            agrs5 = (agrs5 * agrs2 + agrs6) % 1099511627776
            agrs1 = math.floor(agrs5 / agrs2)
            agrs3 = agrs5 - agrs1 * agrs2
            agrs4 = agrs4 + 1
            _setupvalue(ac.attack, 5, agrs1)
            _setupvalue(ac.attack, 6, agrs2)
            _setupvalue(ac.attack, 4, agrs3)
            _setupvalue(ac.attack, 7, agrs4)
			if tick() > TickAttack then
				FireAttack()
			end
			if tick() - Cooldown > 0.3 then
				ac.timeToNextAttack = 0
				ac.hitboxMagnitude = 60
				Cooldown = tick()
			end
            if ac.currentWeaponModel then
                RS.Remotes.Validator:FireServer(math.floor(agrs5 / 1099511627776 * 16777215), agrs4)
			    Rig.FireServer(Rig, "hit", bladehit, 1, "")
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

getgenv().FastAttack = true
task.spawn(function()
    while game:GetService("RunService").Stepped:Wait(0.00000000001) do
        local ac = CombatFrameworkR.activeController
        if ac and ac.equipped and not CheckStun() then
            if getgenv().FastAttack then
                task.spawn(function()
                    pcall(task.spawn, Attack)
                end)
            end
        end
    end
end)

local kkii = require(game.ReplicatedStorage.Util.CameraShaker)
kkii:Stop()
