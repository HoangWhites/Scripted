getAllBladeHits = function(Sizes)
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

getAllBladeHitsPlayers = function(Sizes)
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
RL.wrapAttackAnimationAsync = function(a)
    a:Play(0.01, 0.01, 0.01)
end
local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("CombatFramework"))
local CombatFrameworkR = getupvalues(CombatFramework)[2]
local Rig = game:GetService("ReplicatedStorage").RigControllerEvent
local TickAttack = 0
local TickCooldown = 0
local MaxAttack = 1200
local FireCooldown = 0.02
local FireL = 0
local bladehit = {}
local Animation = Instance.new("Animation")

FireAttack = function()
	local ac = CombatFrameworkR.activeController
	if ac and ac.equipped then
		TickAttack = tick() + (FireCooldown or 0.01) + ((FireL/MaxAttack)*0.25)
		Rig.FireServer(Rig,"weaponChange",ac.currentWeaponModel.Name)
		FireL = FireL + 1
		task.delay((FireCooldown or 0.01) + ((FireL+0.25/MaxAttack)*0.25),function()
			FireL = FireL - 1
		end)
	end
end

Attack = function()
	local ac = CombatFrameworkR.activeController
	if ac and ac.equipped then
		local bladehit = {}
        for r,v in pairs(getAllBladeHits(60)) do
            table.insert(bladehit,v)
        end
        for r,v in pairs(getAllBladeHitsPlayers(55)) do
            table.insert(bladehit,v)
        end
		if #bladehit > 0 then
			pcall(task.spawn,ac.attack,ac)
			if tick() > TickAttack then
				FireAttack()
			end
			if tick() - TickCooldown > 0.3 then
				ac.timeToNextAttack = 0
				ac.hitboxMagnitude = 60
				TickCooldown = tick()
			end
            Animation.AnimationId = ac.anims.basic[2]
            ac.humanoid:LoadAnimation(Animation):Play(1, 1)
			Rig.FireServer(Rig, "hit", bladehit, 2, "")
		end
	end
end

function CheckStun()
	if game:GetService('Players').LocalPlayer.Character:FindFirstChild("Stun") then
		return game:GetService('Players').LocalPlayer.Character.Stun.Value ~= 0
	end
	return false
end
Scibidi["Fast Attack"] = true
spawn(function()
    while wait() do
        local ac = CombatFrameworkR.activeController
        if ac and ac.equipped and not CheckStun() then
            if Scibidi["Fast Attack"] then
                repeat task.wait()
                    task.spawn(function()
                        pcall(task.spawn, Attack)
                    end)
                until Scibidi["Fast Attack"] == false or CheckStun()
            end
        end
    end
end)
local kkii = require(game.ReplicatedStorage.Util.CameraShaker)
kkii:Stop()
