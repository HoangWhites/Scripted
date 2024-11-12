local plr = game.Players.LocalPlayer
local CombatFr = require(plr.PlayerScripts:WaitForChild("CombatFramework"))
local CombatFr1 = getupvalues(CombatFr)[2]
local Rig = game:GetService("ReplicatedStorage"):WaitForChild("RigControllerEvent")
local Delay = 0.1
local Animation = Instance.new("Animation")
local Workspace = game:GetService("Workspace")
local Repli = game:GetService("ReplicatedStorage")
local _getupvalue = (debug.getupvalue or getupvalue or getupvalues or function(...)return ... end)
local _setupvalue = (debug.setupvalue or setupvalue or setupvalues or function(...)return ... end)

GetBladeHits = function(SizeValue)
    local enemy = Workspace.Enemies:GetChildren()
    local Blade = {}
    for _, v in pairs(enemy) do
        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and v.Parent and getdistance(v.HumanoidRootPart.Position) < SizeValue + 5 then
            table.insert(Blade, v)
        end
    end
    return Blade
end

AddFast = function()
    local ac = CombatFr1.activeController
    if ac and ac.equiped and not plr.Character.Stun.Value ~= 0 then
        local blade = {}
        for r, v in next, GetBladeHits(60) do
            table.insert(blade, v)
        end
        if #blade > 0 then
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
            Animation.AnimationId = ac.anims.basic[2]
            ac.humanoid:LoadAnimation(Animation):Play(1, 1)
            if ac.currentWeaponModel then
                Rig:FireServer("weaponChange", ac.currentWeaponModel.Name)
                Repli.Remotes.Validator:FireServer(math.floor(agrs5 / 1099511627776 * 16777215), agrs4)
                Rig.FireServer(Rig, "hit", blade, 1, "")
            end
        end
    end
end

getgenv().FastAttack = true
spawn(function()
    while wait(0.001) do
        if getgenv().FastAttack then
            repeat task.wait(Delay)
                AddFast()
            until getgenv().FastAttack == false or not plr.Character.Stun.Value ~= 0
        end
    end
end)

local kkii = require(game.ReplicatedStorage.Util.CameraShaker)
kkii:Stop()
