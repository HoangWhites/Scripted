repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players
repeat task.wait() until game.Players.LocalPlayer
repeat wait()
    pcall(function() 
        for r, v in pairs(getconnections(game.Players.LocalPlayer.PlayerGui.Main.ChooseTeam.Container[getgenv().Team].Frame.TextButton.Activated)) do
            v.Function()
        end 
    end) 
until game.Players.LocalPlayer.Team ~= nil and game:IsLoaded()
repeat task.wait() until game.Players.LocalPlayer:FindFirstChild("DataLoaded")
-- Anti AFK --
for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.Idled)) do 
	v:Disable()
end
-- Hook --
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/HoangWhites/Scripted/refs/heads/main/Library.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/HoangWhites/Scripted/refs/heads/main/Hookfunction.lua"))()
-- Local SomeFunc --
local plr = game.Players.LocalPlayer
local RS = game.ReplicatedStorage
local WS = game.Workspace
local Remotes = RS.Remotes
local HttpService = game:GetService("HttpService")
-- Save Settings --
config = {
    ["Tween Speed"] = 180,
    ["Bypass Teleport"] = true,
    ["Bring Range"] = 220,
    ["FastDelay"] = "0.02",
    ["Bring Mob"] = true
}
function Save(Values, Boolean)
    if Values ~= nil and Boolean ~= nil then
        config[Values] = Boolean
    end
    if not isfolder("Whites Hub") then
        makefolder("Whites Hub")
    end
    writefile("Whites Hub" .. "/" .. plr.Name .. " - Blox Fruit.json", HttpService:JSONEncode(config))
end
function Load()
    local c1, c2 = pcall(function()
        if not isfolder("Whites Hub") then
            makefolder("Whites Hub")
        end
        return HttpService:JSONDecode(readfile("Whites Hub" .. "/" .. plr.Name .. " - Blox Fruit.json"))
    end)
    if c1 then return c2
    else
        Save()
        return Load()
    end
end
config = Load()
-- NPC Bypass --
HomePoint = {}
for i, v in pairs(WS.NPCs:GetChildren()) do 
    if string.find(string.lower(v.Name), "home point") then
        table.insert(HomePoint, v:GetModelCFrame())
    end
end
for i, v in pairs(getnilinstances()) do 
    if string.find(string.lower(v.Name), "home point") then
        table.insert(HomePoint, v:GetModelCFrame())
    end
end
-- Sub Function --
function GetDistance(Partion1, Partion2)
    if Partion2 == nil then
        Partion2 = plr.Character.HumanoidRootPart.Position
    end
    if typeof(Partion1) == "CFrame" then
        return (Partion1.Position - Partion2).Magnitude
    elseif typeof(Partion1) == "Vector3" then
        return (Partion1 - Partion2).Magnitude
    end
end
local placeid = game.PlaceId
function Yamate(c)
    if c == 1 then
        return placeid == 2753915549
    elseif c == 2 then
        return placeid == 4442272183
    elseif c == 3 then
        return placeid == 7449423635
    end
end
local SeaValues
if Yamate(1) then SeaValues = 1 elseif Yamate(2) then SeaValues = 2 elseif Yamate(3) then SeaValues = 3 else plr:Kick("Not Supported : Please Ask to Developers!!!") end
local PortalEntrance = {
    {
        Vector3.new(-7894.6201171875, 5545.49169921875, -380.2467346191406),
        Vector3.new(-4607.82275390625, 872.5422973632812, -1667.556884765625),
        Vector3.new(61163.8515625, 11.759522438049316, 1819.7841796875),
        Vector3.new(3876.280517578125, 35.10614013671875, -1939.3201904296875)
    },
    {
        Vector3.new(-288.46246337890625, 306.130615234375, 597.9988403320312),
        Vector3.new(2284.912109375, 15.152046203613281, 905.48291015625),
        Vector3.new(923.21252441406, 126.9760055542, 32852.83203125),
        Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422)
    },
    {
        Vector3.new(-5058.77490234375, 314.5155029296875, -3155.8833078125),
        Vector3.new(5756.83740234375, 610.4240112304688, -253.9253692626953),
        Vector3.new(-12463.8740234375, 374.9144592285156, -7523.77392578125),
        Vector3.new(28282.5703125, 14896.8505859375, 105.1042709350586),
        Vector3.new(-11993.58078125, 334.7812805175781, -8844.1826171875),
        Vector3.new(5314.58203125, 25.419387817382812, -125.94227600097656)
    }
}
function CheckNearPortal(uhh)
    local ngu, max = Vector3.new(0, 0, 0), math.huge
    for r, v in pairs(PortalEntrance[SeaValues]) do
        local abc = GetDistance(uhh, v)
        if abc < max and v ~= ngu then
            ngu = v
            max = abc
        end
    end
    return ngu
end
function GetBypassedCFrame(c)
    local pass, di = nil, math.huge
    for r, v in pairs(HomePoint) do
        if (v.Position - c.Position).Magnitude < di and GetDistance(c.Position) >= 3000 then
            pass = v
            di = (v.Position - c.Position).Magnitude
        end
    end
    return pass
end
function BypassCFrame(nitga)
    wait(.5)
    pcall(function()
        repeat wait()
            plr.Character:WaitForChild("Humanoid"):ChangeState(15)
            plr.Character.HumanoidRootPart.CFrame = GetBypassedCFrame(nitga)
        until plr.Character.PrimaryPart.CFrame == GetBypassedCFrame(nitga) or config["Bypass Teleport"] == false
        plr.Character:SetPrimaryPartCFrame(GetBypassedCFrame(nitga))
        wait(0.1)
        plr.Character.Head:Destroy()
        repeat wait()
        until plr.Character:FindFirstChild("Humanoid").Health <= 0
        repeat  wait()
        until plr.Character:FindFirstChild("Head")
        wait(1)
    end)
end
function RequestEntrance(cc)
    Args = {
        "requestEntrance",
        cc
    }
    Remotes.CommF_:InvokeServer(unpack(Args))
    task.wait(.3)
end
function ToTarget(TargetCFrame)
    pcall(function()
        if config["Tween Speed"] == nil then config["Tween Speed"] = 160 end
    if plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 and plr.Character:FindFirstChild("HumanoidRootPart") then
        local plrhrp = plr and plr.Character:WaitForChild("HumanoidRootPart")
        local Aaa = GetDistance(TargetCFrame)
        local TweenService = game:GetService("TweenService")
        local TweenI = TweenInfo.new(Aaa / config["Tween Speed"], Enum.EasingStyle.Quad)
        local Pt = CheckNearPortal(TargetCFrame)
        Velocity = true
        if Aaa <= 200 then
            if tween then tween:Pause() tween:Cancel() end
            plrhrp.CFrame = TargetCFrame
        else
            tween = TweenService:Create(plr.Character.HumanoidRootPart, TweenI, {CFrame = TargetCFrame})
            if (plrhrp.Position - TargetCFrame.Position).Magnitude > (Pt - TargetCFrame.Position).Magnitude + 250 and Aaa >= 3000 and (TargetCFrame.Position - Pt).Magnitude <= 2500 then
                if plr.Character.Humanoid.Health > 0 then
                    if Aaa >= 3000 then
                        if tween then tween:Pause() tween:Cancel() end
                        wait(.3)
                        RequestEntrance(Pt)
                    end
                end
            end
            if config["Bypass Teleport"] and (plr.Character.HumanoidRootPart.Position - TargetCFrame.Position).Magnitude >= 3125 and plr.Character:WaitForChild("Humanoid").Health > 0 then
                if plr.Character.Humanoid.Health > 0 then
                    wait(.4)
                    if tween then tween:Pause() tween:Cancel() end
                    BypassCFrame(TargetCFrame)
                end
            end
            for r, v in pairs(plr.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
            plrhrp.CFrame = CFrame.new(plrhrp.Position.X, TargetCFrame.Y, plrhrp.Position.Z)
            tween:Play()
        end
    end
    end)
end
spawn(function()
    while task.wait() do
        if tween then
            Velocity = false
        elseif tween and tween.PlaybackState == Enum.PlaybackState.Playing then
            Velocity = true
        end
    end
end)
spawn(function()
    while wait() do
        if Velocity then
            if not plr.Character:WaitForChild("Head"):FindFirstChild("VelocityC") then
                local VelocityC = Instance.new("BodyVelocity", plr.Character.Head)
                VelocityC.Name = "VelocityC"
                VelocityC.P = 1500
                VelocityC.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                VelocityC.Velocity = Vector3.new(0, 0, 0)
            end
        else
            if plr.Character:WaitForChild("Head"):FindFirstChild("VelocityC") then
                plr.Character:WaitForChild("Head"):FindFirstChild("VelocityC"):Destroy()
            end
        end
    end
end)
function GetWeaponType(Type)
    local n = ""
    for r, v in pairs(plr.Backpack:GetChildren()) do
        if v:IsA("Tool") and v.ToolTip == Type then
            n = v.Name
        end
    end
    for r, v in pairs(plr.Character:GetChildren()) do
        if v:IsA("Tool") and v.ToolTip == Type then
            n = v.Name
        end
    end
    return n
end
function EWP()
    if config["Select Tool"] == nil or config["Select Tool"] == "" then
        config["Select Tool"] = "Melee"
    end
    local ab = GetWeaponType(config["Select Tool"])
    if plr.Backpack:FindFirstChild(ab) then
        local labubu = plr.Backpack:FindFirstChild(ab)
        plr.Character.Humanoid:EquipTool(labubu)
    end
end
local animationIds = {10129760884, 9400509141, 10375950022, 9400516463, 9897746533, 8708225668,8708222938, 15087184962, 8708176378, 913389285, 8708224329, 8708225020, 15041522318,14977822399,15088352061,8994252874,10129768335,9897436286,9811880619,9897433386,9884584522,9799137678,9886242181,9811521002,9799138662,9884586404,9800654017,9799139408,9884587348,507766388,507766951,507766666,507785072,507784897,9799140065,9799140958,9802959564,9799136714,9841350003,9841333648,9841361789,3467766626,9811914002,9841324959,3406511948,9841340380,10432912847,8982044407,10375985353,8994244101,10432951137,10432969960}
local function formattedNumber(animationId)
    local id = animationId:match("%d+")
    return tonumber(id)
end
function CheckAnimation(EHumanoid)
    local exceptSet = {}
    for _, id in ipairs(animationIds) do
        exceptSet[id] = true
    end
    if EHumanoid then
        for _, track in ipairs(EHumanoid:GetPlayingAnimationTracks()) do
            local animationIdString = tostring(track.Animation.AnimationId)
            local trackId = formattedNumber(animationIdString)
            if not exceptSet[trackId] then
                if trackId == 8708176378 or trackId == 8708221792 or trackId == 8708222556 then
                    track.KeyframeReached:Connect(function(keyframeName)
                        if keyframeName == "End" then
                            return true
                        end
                    end)
                else
                    return true
                end
            end
        end
    end
    return false
end
function DetectEnemy(mob, rep)
    for _, v in next, WS.Enemies:GetChildren() do
        if ((typeof(mob) == "table" and table.find(mob, v.Name)) or ((typeof(mob) == "string" and (string.find(v.Name, mob) or v.Name == mob)))) and v and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
            return v
        end
    end
    if rep ~= nil and rep ~= false then
        for _, v in next, RS:GetChildren() do
            if ((typeof(mob) == "table" and table.find(mob, v.Name)) or ((typeof(mob) == "string" and (string.find(v.Name, mob) or v.Name == mob)))) and v and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                return v
            end
        end
    end
end
function FireRemotes(type, ...)
    arg = ({"Redeem", "CommF_"})[type]
    return Remotes[arg]:InvokeServer(unpack({...}))
end
function EBuso()
    if not plr.Character:FindFirstChild("HasBuso") then
        FireRemotes(2, "Buso")
    end
end
function SendKey(nah, ilose)
    if ilose == nil then ilose = 0.1 end
    game:service("VirtualInputManager"):SendKeyEvent(true, nah, false, game)
    wait(ilose)
    game:service("VirtualInputManager"):SendKeyEvent(false, nah, false, game)
end
AllBladeHits = function(Sizes)
    local Hits = {}
    local Client = game.Players.LocalPlayer
    local Enemies = game:GetService("Workspace").Enemies:GetChildren()
    for i, v in pairs(Enemies) do
        local Human = v:FindFirstChildOfClass("Humanoid")
        if Human and Human.Health > 0 and Human.RootPart and Client:DistanceFromCharacter(Human.RootPart.Position) <= Sizes + 5 then
            table.insert(Hits, Human.RootPart)
        end
    end
    return Hits
end
AllPlayerHits = function(Sizes)
    local Hits = {}
    local Client = game.Players.LocalPlayer
    local Characters = game:GetService("Workspace").Characters:GetChildren()
    for i, v in pairs(Characters) do
        local Human = v:FindFirstChildOfClass("Humanoid")
        if v.Name ~= Client.Name and Human and Human.Health > 0 and Human.RootPart and Client:DistanceFromCharacter(Human.RootPart.Position) <= Sizes + 5 then
            table.insert(Hits, Human.RootPart)
        end
    end
    return Hits
end
local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("CombatFramework"))
local CombatFrameworkR = getupvalues(CombatFramework)[2]
local Rig = game:GetService("ReplicatedStorage").RigControllerEvent
local Animation = Instance.new("Animation")
local Cooldown = 0
local HDown = 0
local MaxAttack = 1000
local Delay = 0.02
local Attacked = 0
FireAttack = function()
	local ac = CombatFrameworkR.activeController
	if ac and ac.equipped then
		Cooldown = tick() + (Delay or 0.01) + ((Attacked/MaxAttack)*0.3)
		Rig.FireServer(Rig,"weaponChange",ac.currentWeaponModel.Name)
		Attacked = Attacked + 1
		task.delay((Delay or 0.01) + ((Attacked+0.4/MaxAttack)*0.3),function()
			Attacked = Attacked - 1
		end)
	end
end
Attack = function()
    local ac = CombatFrameworkR.activeController
    if ac and ac.equipped then
        local bladehit = {}
        for r, v in pairs(AllBladeHits(55)) do
            table.insert(bladehit, v)
        end
        for r, v in pairs(AllPlayerHits(55)) do
            table.insert(bladehit, v)
        end
        if #bladehit > 0 then
            pcall(task.spawn, ac.attack, ac)
            if tick() > Cooldown then
                FireAttack()
            end
            if tick() - HDown > 0.3 then
                ac.timeToNextAttack = 0
                ac.hitboxMagnitude = 60
                HDown = tick()
            end
            local AMI3 = ac.anims.basic[3]
            local AMI2 = ac.anims.basic[2]
            local REALID = AMI3 or AMI2
            Animation.AnimationId = REALID
            local StartP = ac.humanoid:LoadAnimation(Animation)
            StartP:Play(0.001, 0.001, 0.001)
            Rig.FireServer(Rig, "hit", bladehit, AMI3 and 3 or 2, "")
            task.delay(0.001, function()
                StartP:Stop()
            end)
        end
    end
end
function CheckStun()
    if game:GetService('Players').LocalPlayer.Character:FindFirstChild("Stun") then
        return game:GetService('Players').LocalPlayer.Character.Stun.Value ~= 0
    end
    return false
end
task.spawn(function()
    while game:GetService("RunService").Stepped:Wait() do
        pcall(function()
            local ac = CombatFrameworkR.activeController
            ac.hitSound = nil
            if ac and ac.equipped and not CheckStun() then
                if config["Fast Attack"] then
                    task.spawn(function()
                        Attack()
                    end)
                end
            end
        end)
    end
end)

function RemoveLevelTitle(Value)
    return tostring(tostring(Value):gsub(" %pLv. %d+%p", ""):gsub(" %pRaid Boss%p", ""):gsub(" %pBoss%p", ""))
end

FolderMob = Instance.new("Folder", workspace)
FolderMob.Name = "FolderMob"
local Quests = require(RS.Quests)
local GuideModule = require(RS.GuideModule)
repeat wait() until game.Workspace:FindFirstChild("FolderMob")
function CheckMobPart()
    if not game.Workspace:FindFirstChild("FolderMob") then
        FolderMob = Instance.new("Folder", workspace)
        FolderMob.Name = "FolderMob"
    else
        for r, v in next, game.Workspace["_WorldOrigin"].EnemySpawns:GetChildren() do
            if v:IsA("Part") then
                cloner = v:Clone()
                cloner.Parent = game.Workspace.FolderMob
            end
        end
        local TableMobLvFarm = {}
        for r, v in next, Quests do
            for r1, v1 in next, v do
                for r2, plr in next, v1.Task do
                    if plr > 1 then
                        table.insert(TableMobLvFarm, r2)
                    end
                end
            end
        end
        pcall(function()
            for r, v in next, game.Workspace.Enemies:GetChildren() do
                if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                    local ngu = v.HumanoidRootPart
                    cloner = ngu:Clone()
                    cloner.Parent = game.Workspace.FolderMob
                end
            end
            for r, v in next, game.ReplicatedStorage:GetChildren() do
                if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                    local ngu = v.HumanoidRootPart
                    cloner = ngu:Clone()
                    cloner.Parent = game.Workspace.FolderMob
                end
            end
        end)
        for r, v in next, getnilinstances() do
            if table.find(TableMobLvFarm, RemoveLevelTitle(v.Name)) and v:IsA("Part") then
                cloner = v:Clone()
                cloner.Parent = game.Workspace.FolderMob
            end
        end
        for r, v in next, game.Workspace.FolderMob:GetChildren() do
            v.Name = RemoveLevelTitle(v.Name)
        end
    end
end
CheckMobPart()

local CameraNgu = require(game.ReplicatedStorage.Util.CameraShaker)
CameraNgu:Stop()

local EliteMobs = {
    "Deandre",
    "Urban",
    "Diablo",
}

DetectElite = function()
    for r, v in pairs(workspace.Enemies) do
        if v:IsA("Model") and table.find(EliteMobs, v.Name) and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            return v
        end
    end
    for r, v in pairs(RS) do
        if v:IsA("Model") and table.find(EliteMobs, v.Name) and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            return v
        end
    end
end

GetMobPosition = function(EnemiesName)
    local pos
    local count = 0
    for r, v in pairs(workspace.Enemies:GetChildren()) do
        if v.Name == EnemiesName then
            if not pos then
                pos = v.HumanoidRootPart.Position
            else
                pos = pos + v.HumanoidRootPart.Position
            end
            count = count + 1
        end
    end
    pos = pos / count
    return pos
end

BringMob = function(value)
    if value then
        for r, v in pairs(workspace.Enemies:GetChildren()) do
            if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v.Parent and v:FindFirstChild("HumanoidRootPart") then
                if (v.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= config["Bring Range"] then
                    local Sm = GetMobPosition(v.Name)
                    local Lock = Sm and CFrame.new(Sm) or Sm.CFrame
                    v.HumanoidRootPart.CFrame = Lock
                    v.HumanoidRootPart.CanCollide = false
                    v.Head.CanCollide = false
                    v.HumanoidRootPart.Size = Vector3.new(80, 80, 80)
                    v.Humanoid.WalkSpeed = 0
                    v.Humanoid.JumpPower = 0
                    v.Humanoid.AutoRotate = true
                    v.Humanoid:ChangeState(14)
                    sethiddenproperty(plr, "SimulationRadius", math.huge)
                end
            end
        end
    end
end
function KillMob(mobname, dodge, valuefunc)
    if valuefunc and valuefunc() then return end
    local v = DetectEnemy(mobname.Name, true)
    repeat task.wait()
        if valuefunc and valuefunc() then return end
        Velocity = true
        EWP()
        EBuso()
        BringMob(true)
        if dodge then
            if CheckAnimation(v.Humanoid) then
                ToTarget(v.HumanoidRootPart.CFrame * CFrame.new(0, 400, 0))
            else
                ToTarget(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 9))
            end
        else
            if mobname.Name == "Cake Prince" then
                if CheckAnimation(v.Humanoid) or game:GetService("Workspace")["_WorldOrigin"]:FindFirstChild("Ring") or game:GetService("Workspace")["_WorldOrigin"]:FindFirstChild("Fist") then
                    ToTarget(v.HumanoidRootPart.CFrame * CFrame.new(0, -40, 0))
                else
                    ToTarget(v.HumanoidRootPart.CFrame * CFrame.new(-12, 30, 50))
                end
            else
                ToTarget(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 9))
            end
        end
    until not v:FindFirstChild("HumanoidRootPart") or not v:FindFirstChild("Humanoid") or v.Humanoid.Health <= 0 or not v.Parent
end
function CheckStringQuests(ac)
    return plr.PlayerGui.Main.Quest.Visible and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, ac)
end
local TableHauntedMobs = {
    "Reborn Skeleton",
    "Living Zombie",
    "Demonic Soul",
    "Posessed Mummy"
}

function BuyMelee(meleename)
    FireRemotes(2, meleename, true)
    FireRemotes(2, meleename)
end

----- hehehehehe ---
local Window = Library:AddWindows()
local ShopTab = Window:AddTab({Name = "Shop"})
local ConfigTab = Window:AddTab({Name = "Config Farm"})
local MainTab = Window:AddTab({Name = "Main Farm"})
local SubFarmTab = Window:AddTab({Name = "Sub Farmming"})
local StackTab = Window:AddTab({Name = "Stack Farm"})

--- Tab -----
ShopTab:AddSeperator("Travel Teleport")

ShopTab:AddButton({
    Name = "Teleport Old Sea",
    Description = "Remotes Teleport To Travel 1, Old Sea",
    Callback = function()
        FireRemotes(2, "TravelMain")
    end
})

ShopTab:AddButton({
    Name = "Teleport New World",
    Description = "Remotes Teleport To Travel 2, New World",
    Callback = function()
        FireRemotes(2, "TravelDressrosa")
    end
})

ShopTab:AddButton({
    Name = "Teleport Third Sea",
    Description = "Remotes Teleport To Travel 3, Third Sea",
    Callback = function()
        FireRemotes(2, "TravelZou")
    end
})

ShopTab:AddSeperator("Fighting Style")

ShopTab:AddDropdown({
    Name = "Select Melee",
    Description = "Select Melee, If Your Select Done, Will Auto Buy Melee For Your",
    Options = {"Black Legs", "Electro", "Fishman Karate", "Dragon Claw", "Superhuman", "Death Step", "Electric Claw", "Sharkman Karate", "Dragon Claw", "Godhuman", "Sanguine Art"},
    Default = "",
    Callback = function(Value)
        if Value == "Black Legs" then
            BuyMelee("BuyBlackLeg")
        elseif Value == "Electro" then
            BuyMelee("BuyElectro")
        elseif Value == "Fishman Karate" then
            BuyMelee("BuyFishmanKarate")
        elseif Value == "Dragon Claw" then
            FireRemotes(2, "BlackbeardReward", "DragonClaw", "1")
            FireRemotes(2, "BlackbeardReward", "DragonClaw", "2")
        elseif Value == "Superhuman" then
            BuyMelee("BuySuperhuman")
        elseif Value == "Death Step" then
            BuyMelee("BuyDeathStep")
        elseif Value == "Electric Claw" then
            BuyMelee("BuyElectricClaw")
        elseif Value == "Sharkman Karate" then
            BuyMelee("BuySharkmanKarate")
        elseif Value == "Dragon Talon" then
            BuyMelee("BuyDragonTalon")
        elseif Value == "Godhuman" then
            BuyMelee("BuyGodhuman")
        elseif Value == "Sanguine Art" then
            BuyMelee("BuySanguineArt")
        end
    end
})

ShopTab:AddSeperator("Haki")

ShopTab:AddButton({
    Name = "Buy Buso",
    Callback = function()
        local args = {
            [1] = "BuyHaki",
            [2] = "Buso"
        }
        Remotes.CommF_:InvokeServer(unpack(args))
    end
})

ShopTab:AddButton({
    Name = "Buy Geppo",
    Callback = function()
        local args = {
            [1] = "BuyHaki",
            [2] = "Geppo"
        }
        Remotes.CommF_:InvokeServer(unpack(args))
    end
})

ShopTab:AddButton({
    Name = "Buy Observation",
    Callback = function()
        local args = {
            [1] = "KenTalk",
            [2] = "Buy"
        }
        Remotes.CommF_:InvokeServer(unpack(args))
    end
})

ShopTab:AddButton({
    Name = "Buy Soru",
    Callback = function()
        local args = {
            [1] = "BuyHaki",
            [2] = "Soru"
        }
        Remotes.CommF_:InvokeServer(unpack(args))
    end
})

ConfigTab:AddSeperator("Farmming Config")

ConfigTab:AddToggle({
    Name = "Enable FastAttack",
    Description = "Attack Very Faster And No Kick(24/24)",
    Default = config["Fast Attack"],
    Callback = function(Value)
        Save("Fast Attack", Value)
    end
})

local tabledelay = {"0.02", "0.05", "0.07", "0.09", "0.1", "0.175"}
local function FastCooldown(DelayNumber)
    if DelayNumber == "0.02" then
        Delay = 0.02
    elseif DelayNumber == "0.05" then
        Delay = 0.05
    elseif DelayNumber == "0.07" then
        Delay = 0.07
    elseif DelayNumber == "0.09" then
        Delay = 0.09
    elseif DelayNumber == "0.1" then
        Delay = 0.1
    elseif DelayNumber == "0.175" then
        Delay = 0.175
    end
end

ConfigTab:AddDropdown({
    Name = "Fast Attack Cooldown",
    Description = "Cooldown For Fast Attack, If The Number Small, The FastAttack I'll Faster More",
    Options = tabledelay,
    Default = config["FastDelay"],
    Callback = function(Value)
        Save("FastDelay", Value)
        FastCooldown(config["FastDelay"])
    end
})

ConfigTab:AddToggle({
    Name = "Enable Bring Mob",
    Description = "",
    Default = config["Bring Mob"],
    Callback = function(Value)
        Save("Bring Mob", Value)
    end
})

ConfigTab:AddSlider({
    Name = "Bring Range",
    Max = 350,
    Min = 220,
    Default = config["Bring Range"],
    Callback = function(Value)
        Save("Bring Range", Value)
    end
})

ConfigTab:AddSlider({
    Name = "Tween Speed",
    Max = 350,
    Min = 160,
    Default = config["Tween Speed"],
    Callback = function(Value)
        Save("Tween Speed", Value)
    end
})

ConfigTab:AddToggle({
    Name = "Enable Buso",
    Description = "",
    Default = config["Enable Buso"],
    Callback = function(Value)
        Save("Enable Buso", Value)
    end
})

ConfigTab:AddToggle({
    Name = "Enable Race V4",
    Description = "",
    Default = config["Enable Race V4"],
    Callback = function(Value)
        Save("Enable Race V4", Value)
    end
})

ConfigTab:AddToggle({
    Name = "Enable Ken",
    Description = "",
    Default = config["Enable Ken"],
    Callback = function(Value)
        Save("Enable Ken", Value)
    end
})

ConfigTab:AddToggle({
    Name = "Bypass Teleport",
    Description = "",
    Default = config["Bypass Teleport"],
    Callback = function(Value)
        Save("Bypass Teleport", Value)
    end
})

spawn(function()
    while wait() do
        if config["Enable Buso"] and not plr.Character:FindFirstChild("HasBuso") then
            EBuso()
        end
        if config["Enable Ken"] and not plr.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
            game:service("VirtualUser"):CaptureController()
            game:service("VirtualUser"):SetKeyDown("0x65")
            game:service("VirtualUser"):SetKeyUp("0x65")
            wait(3)
        end
        if config["Enable Race V4"] and plr.Character and plr.Character:FindFirstChild("RaceTransformed") and plr.Character:FindFirstChild("RaceEnergy") and plr.Character.RaceEnergy.Value >= 1 and not plr.Character.RaceTransformed.Value then
            plr.Backpack.Awakening.RemoteFunction:InvokeServer(true)
        end
    end
end)

MainTab:AddSeperator("Select Tool")

local TableCodes = {
    "EARN_FRUITS",
    "SUB2GAMERROBOT_RESET1",
    "KITT_RESET",
    "Bignews",
    "CHANDLER",
    "Fudd10",
    "fudd10_plr",
    "Sub2UncleKizaru",
    "FIGHT4FRUIT",
    "kittgaming",
    "TRIPLEABUSE",
    "Sub2CaptainMaui",
    "Sub2Fer999",
    "Enyu_is_Pro",
    "Magicbus",
    "JCWK",
    "Starcodeheo",
    "Bluxxy",
    "SUB2GAMERROBOT_EXP1",
    "Sub2NoobMaster123",
    "Sub2Daigrock",
    "Axiore",
    "TantaiGaming",
    "StrawHatMaine",
    "Sub2OfficialNoobie",
    "TheGreatAce",
    "JULYUPDATE_RESET",
    "ADMINHACKED",
    "SEATROLLING",
    "24NOADMIN",
    "ADMIN_TROLL",
    "NEWTROLL",
    "SECRET_ADMIN",
    "staffbattle",
    "NOEXPLOIT",
    "NOOB2ADMIN",
    "CODESLIDE",
    "fruitconcepts",
    "krazydares"
}

MainTab:AddButton({
    Name = "Redeem All Codes",
    Description = "Redeem All Codes In Blox Fruit",
    Callback = function()
        for r, v in next, TableCodes do
            FireRemotes(1, tostring(v))
        end
    end
})

MainTab:AddDropdown({
    Name = "Select Tool",
    Options = {"Melee", "Sword"},
    Default = config["Select Tool"],
    Callback = function(Value)
        Save("Select Tool", Value)
    end
})

MainTab:AddDropdown({
    Name = "Stats Select",
    Options = {"Melee", "Sword", "Gun", "Defense", "Demon Fruit"},
    Default = config["Select Stats"],
    Callback = function(Value)
        Save("Select Stats", Value)
    end
})

MainTab:AddToggle({
    Name = "Auto Stats",
    Default = config["Auto Stats"],
    Callback = function(Value)
        Save("Auto Stats", Value)
    end
})

spawn(function()
    while wait() do
        if config["Auto Stats"] and config["Select Stats"] ~= "" then
            FireRemotes(2, "AddPoint", config["Select Stats"], 9999)
        end
    end
end)

ConfigTab:AddSeperator("Method Farm")

MainTab:AddDropdown({
    Name = "Method Farm",
    Options = {"Levels Farm", "Cake Prince Farm", "Bones Farm"},
    Default = config["Method Farm"],
    Callback = function(Value)
        Save("Method Farm", Value)
    end
})

local ToggleFarm = MainTab:AddToggle({
    Name = "Auto Farm",
    Default = config["Auto Farm"],
    Settings = true,
    Callback = function(Value)
        Save("Auto Farm", Value)
    end
})

ToggleFarm:AddToggle({
    Name = "Double Quest",
    Default = config["Double Quest"],
    Callback = function(Value)
        Save("Double Quest", Value)
    end
})

ToggleFarm:AddToggle({
    Name = "Claim Quest",
    Default = config["Claim Quest"],
    Callback = function(Value)
        Save("Claim Quest", Value)
    end
})

function CheckingStack(StackMode)
    if StackMode == "Normal Farm" then
        if config["Auto Elite"] and DetectElite() then return true end
    end
end

local TableCakeMobs = {
    "Cookie Crafter",
    "Cake Guard",
    "Baking Staff",
    "Head Baker"
}

function AutoFarm()
    if CheckingStack("Normal Farm") then
    else
        if config["Method Farm"] == "Levels Farm" then
            
        elseif config["Method Farm"] == "Cake Prince Farm" then
            if DetectEnemy("Cake Prince", true) then
                local v = DetectEnemy("Cake Prince")
                if v then
                    if GetDistance(v.HumanoidRootPart.Position) <= 1000 then
                        KillMob(v, true, function() return config["Auto Farm"] == false or CheckingStack("Normal Farm") end)
                    else
                        firetouchinterest(plr.Character.HumanoidRootPart, workspace.Map.CakeLoaf.BigMirror.Main, 0)
                        wait(0.1)
                        firetouchinterest(plr.Character.HumanoidRootPart, workspace.Map.CakeLoaf.BigMirror.Main, 1)
                    end
                end
            else
                if config["Claim Quest"] and not CheckStringQuests("Cookie Crafter") then
                    if GetDistance(CFrame.new(-2021.32007, 37.7982254, -12028.7295).Position) <= 10 then
                        FireRemotes(2, "StartQuest", "CakeQuest1", 2)
                    else
                        ToTarget(CFrame.new(-2021.32007, 37.7982254, -12028.7295))
                    end
                elseif not config["Claim Quest"] or (CheckStringQuests("Cookie Crafter") and config["Claim Quest"]) then
                    if not DetectEnemy(TableCakeMobs) then
                        for r, v in pairs(workspace.FolderMob:GetChildren()) do
                            if v:IsA("Part") and table.find(TableCakeMobs, v.Name) then
                                repeat wait()
                                    ToTarget(v.CFrame * CFrame.new(0, 30, 0))
                                until (v.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 9 or DetectEnemy(TableCakeMobs) or config["Auto Farm"] == false or CheckStack("Normal Farm")
                                if tween then tween:Pause() tween:Cancel() end
                            end
                        end
                    else
                        if DetectEnemy(TableCakeMobs) then
                            local v = DetectEnemy(TableCakeMobs)
                            KillMob(v, true, function() return config["Auto Farm"] == false or CheckingStack("Normal Farm") end)
                        end
                    end
                end
            end
        elseif config["Method Farm"] == "Bones Farm" then
            if config["Claim Quest"] and not CheckStringQuests("Posessed Mummy") then
                if GetDistance(CFrame.new(-9505.8720703125, 172.10482788085938, 6158.9931640625).Position) <= 10 then
                    FireRemotes(2, "StartQuest", "HauntedQuest2", 2)
                else
                    ToTarget(CFrame.new(-9505.8720703125, 172.10482788085938, 6158.9931640625))
                end
            elseif not config["Claim Quest"] or (CheckStringQuests("Posessed Mummy") and config["Claim Quest"]) then
                if not DetectEnemy(TableHauntedMobs) then
                    for r, v in pairs(workspace.FolderMob:GetChildren()) do
                        if v:IsA("Part") and table.find(TableHauntedMobs, v.Name) then
                            repeat wait()
                                ToTarget(v.CFrame * CFrame.new(0, 30, 0))
                            until (v.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 9 or DetectEnemy(TableCakeMobs) or config["Auto Farm"] == false or CheckStack("Normal Farm")
                            if tween then tween:Pause() tween:Cancel() end
                        end
                    end
                else
                    if DetectEnemy(TableHauntedMobs) then
                        local v = DetectEnemy(TableHauntedMobs)
                        KillMob(v, true, function() return config["Auto Farm"] == false or CheckingStack("Normal Farm") end)
                    end
                end
            end
        end
    end
end

spawn(function()
    while wait() do
        if config["Auto Farm"] then
            AutoFarm()
        end
    end
end)
