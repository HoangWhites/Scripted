--[[
 __          ___     _ _              _    _       _     
 \ \        / / |   (_) |            | |  | |     | |    
  \ \  /\  / /| |__  _| |_ ___  ___  | |__| |_   _| |__  
   \ \/  \/ / | '_ \| | __/ _ \/ __| |  __  | | | | '_ \ 
    \  /\  /  | | | | | ||  __/\__ \ | |  | | |_| | |_) |
     \/  \/   |_| |_|_|\__\___||___/ |_|  |_|\__,_|_.__/ 
                                                                                                 
]]--

repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players
repeat task.wait() until game.Players.LocalPlayer
if getgenv().Team == "" or getgenv().Team == nil then getgenv().Team = "Pirates" end
repeat wait()
    pcall(function() 
        for i, v in pairs(getconnections(game.Players.LocalPlayer.PlayerGui.Main.ChooseTeam.Container[getgenv().Team].Frame.TextButton.Activated)) do
            v.Function()
        end 
    end) 
until game.Players.LocalPlayer.Team ~= nil and game:IsLoaded()
repeat wait() until game.Players.LocalPlayer:FindFirstChild("DataLoaded")
for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.Idled)) do 
	v:Disable()
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/HoangWhites/Scripted/refs/heads/main/Library.lua"))()
local Window = Library:AddWindows()
local Tab1 = Window:AddTab({
    Name = "Config Tab",
})
local Tab2 = Window:AddTab({
    Name = "Farm Tab",
})
local Tab3 = Window:AddTab({
    Name = "Stack Tab",
})
local Tab4 = Window:AddTab({
    Name = "Item Tab",
})
local Tab5 = Window:AddTab({
    Name = "Race V4",
})
local Tab6 = Window:AddTab({
    Name = "Sea Tab",
})
local Tab10 = Window:AddTab({
    Name = "Fruits & Raid",
})
local Tab9 = Window:AddTab({
    Name = "Shop",
})
local Tab7 = Window:AddTab({
    Name = "Settings Tab",})
local Tab8 = Window:AddTab({
    Name = "Misc Tab",
})
----------------------------------------------------------------------------------------------------------------------------------------------------------------
local RS = game.ReplicatedStorage
local plr = game.Players.LocalPlayer
for i, v in pairs(RS.Assets.GUI:GetChildren()) do 
    v.Enabled = false 
end
hookfunction(require(RS.Effect.Container.Death), function() end)
hookfunction(require(RS.Effect.Container.Respawn), function() end)
----------------------------------------------------------------------------------------------------------------------------------------------------------------
Scibidi = {
    ["Fast Attack"] = true,
    ["FastDelay"] = "0.2",
    ["Bring Range"] = 325,
    ['Tween Speed'] = 180
}
function Save(value, bool)
    if value ~= nil then
        Scibidi[value] = bool
    end
    if not isfolder("Whites Hub") then
        makefolder("Whites Hub")
    end
    writefile("Whites Hub" .. "/" .. game:GetService("Players").LocalPlayer.Name .. " - Blox Fruit.json", game:GetService("HttpService"):JSONEncode(Scibidi))
end
function Read()
    local c, ac = pcall(function()
        if not isfolder("Whites Hub") then
            makefolder("Whites Hub")
        end
        return game:GetService("HttpService"):JSONDecode(readfile("Whites Hub" .. "/" .. game:GetService("Players").LocalPlayer.Name .. " - Blox Fruit.json"))
    end)
    if c then return ac
    else
        Save()
        return Read()
    end
end
Scibidi = Read()
----------------------------------------------------------------------------------------------------------------------------------------------------------------

NPCBypass = {}
for i, v in pairs(game.Workspace.NPCs:GetChildren()) do 
    if string.find(string.lower(v.Name), "home point") then
        table.insert(NPCBypass, v:GetModelCFrame())
    end
end
for i, v in pairs(getnilinstances()) do 
    if string.find(string.lower(v.Name), "home point") then
        table.insert(NPCBypass, v:GetModelCFrame())
    end
end

local placeid = game.PlaceId
function CheckSea(number)
    if number == 1 then
        return placeid == 2753915549
    elseif number == 2 then
        return placeid == 4442272183
    elseif number == 3 then
        return placeid == 7449423635
    else
        print("Check cai lon")
    end
end

if CheckSea(3) then
    PortalIns = {
        Vector3.new(-5058.77490234375, 314.5155029296875, -3155.8833078125),
        Vector3.new(5756.83740234375, 610.4240112304688, -253.9253692626953),
        Vector3.new(-12463.8740234375, 374.9144592285156, -7523.77392578125),
        Vector3.new(28282.5703125, 14896.8505859375, 105.1042709350586),
        Vector3.new(-11993.58078125, 334.7812805175781, -8844.1826171875),
        Vector3.new(5314.58203125, 25.419387817382812, -125.94227600097656)
    }
elseif CheckSea(2) then
    PortalIns = {
        Vector3.new(-288.46246337890625, 306.130615234375, 597.9988403320312),
        Vector3.new(2284.912109375, 15.152046203613281, 905.48291015625),
        Vector3.new(923.21252441406, 126.9760055542, 32852.83203125),
        Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422)
    }
elseif CheckSea(1) then
    PortalIns = {
        Vector3.new(-7894.6201171875, 5545.49169921875, -380.2467346191406),
        Vector3.new(-4607.82275390625, 872.5422973632812, -1667.556884765625),
        Vector3.new(61163.8515625, 11.759522438049316, 1819.7841796875),
        Vector3.new(3876.280517578125, 35.10614013671875, -1939.3201904296875)
    }
end

function GetPortal(nigger)
    local n, nn, nnn = Vector3.new(0, 0 ,0), math.huge, nigger.Position
    for r,v in next, PortalIns do
        if (nnn - v).Magnitude < nn and n ~= v then
            n = v
            nn = (nnn - v).Magnitude
        end
    end
    return n
end

function SendNotification(title, content, time)
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = title, Text = content, Duration = time})
end
SendNotification("Whites Hub", "Loading", 5)
function GetBypassCFrame(pos)
    pos = Vector3.new(pos.X, pos.Y, pos.Z)
    local lll, mmm = nil, math.huge
    for i, v in pairs(NPCBypass) do
        if (v.p - pos).Magnitude < mmm then
            lll = v
            mmm = (v.p - pos).Magnitude
        end
    end
    return lll
end

function CheckPlayerBackpack(item)
    for r, v in next, plr.Backpack:GetChildren() do
        if tostring(v) == item then
            return v
        end
    end
    for r, v in next, plr.Character:GetChildren() do
        if tostring(v) == item then
            return v
        end
    end
end

function getdistance(i, ii)
    if ii == nil then
        ii = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position
    end
    if typeof(i) == "CFrame" then
        return (i.Position - ii).Magnitude
    elseif typeof(i) == "Vector3" then
        return (i - ii).Magnitude
    end
end

function requestEntrance(b)
    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", b)
    plr.Character.HumanoidRootPart.CFrame = CFrame.new(plr.Character.HumanoidRootPart.Position.X, plr.Character.HumanoidRootPart.Position.Y + 80, plr.Character.HumanoidRootPart.Position.Z)
end

local plr = game.Players.LocalPlayer
local block = Instance.new("Part", workspace)
block.Size = Vector3.new(1, 1, 1)
block.Name = "player platform ............."
block.Anchored = true
block.CanCollide = false
block.CanTouch = false
block.Transparency = 1
local blockfind = workspace:FindFirstChild(block.Name)
if blockfind and blockfind ~= block then
	blockfind:Destroy()
end

spawn(function()
	repeat task.wait()
	until plr.Character and plr.Character.PrimaryPart
	block.CFrame = plr.Character.PrimaryPart.CFrame
	while task.wait() do
		pcall(function()
			if NoClip then
				if block and block.Parent == workspace then
					if plr.Character.HumanoidRootPart and (plr.Character.HumanoidRootPart.Position - block.Position).Magnitude <= 200 then
						plr.Character.HumanoidRootPart.CFrame = block.CFrame
					else
						block.CFrame = plr.Character.HumanoidRootPart.CFrame
					end
				end
			end
		end)
	end
end)

function SpecialItem()
    if not CheckPlayerBackpack("Torch") and not CheckPlayerBackpack("God's Chalice") and not CheckPlayerBackpack("Sweet Chalice") and not CheckPlayerBackpack("Fist Of Darkness") and not CheckPlayerBackpack("Hallow Essence") then
        return true
    end
    return false
end

function BypassTeleport(nigga)
    pcall(function()
        wait(.4)
        repeat wait(0)
            tween:Cancel()
            game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid"):ChangeState(15)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = GetBypassCFrame(nigga)
        until game.Players.LocalPlayer.Character.PrimaryPart.CFrame == GetBypassCFrame(nigga) or Scibidi["Bypass Teleport"] == false
        game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid", 9):ChangeState(15)
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(GetBypassCFrame(nigga))
        wait(0.1)
        game.Players.LocalPlayer.Character.Head:Destroy()
        repeat task.wait()
        until game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health <= 0
        repeat  task.wait()
        until game.Players.LocalPlayer.Character:FindFirstChild("Head")
        wait(1)
    end)
end

function Tween(targetcframe)
    pcall(function()
        if Scibidi["Tween Speed"] == nil or Scibidi["Tween Speed"] == "" then Scibidi["Tween Speed"] = 180 end
        if plr.Character.Humanoid.Health > 0 and plr.Character:FindFirstChild("HumanoidRootPart") then
            local plh = game:GetService("Players").LocalPlayer and game:GetService("Players").LocalPlayer.Character.PrimaryPart
            local Distance = (targetcframe.Position - plh.Position).Magnitude
            local PortalPos = GetPortal(targetcframe)
            if block and block.Parent == workspace then
                NoClip = true
                if Distance <= 250 then
                    tween:Cancel()
                    NoClip = true
                    plh.CFrame = targetcframe
                    block.CFrame = targetcframe
                else
                    local tweenInfo = TweenInfo.new(Distance / Scibidi["Tween Speed"], Enum.EasingStyle.Linear)
                    tween = game:GetService("TweenService"):Create(block, tweenInfo, {CFrame = targetcframe})
                    if (plh.Position - targetcframe.Position).Magnitude > (PortalPos - targetcframe.Position).Magnitude + 250 and Distance >= 3000 then
                        tween:Cancel()
                        requestEntrance(PortalPos)
                    end
                    if Scibidi["Bypass Teleport"] and (targetcframe.Position - plh.Position).Magnitude >= 3000 and SpecialItem() then
                        wait(0.4)
                        BypassTeleport(targetcframe)
                    end
                    if plr.Character.Humanoid.Sit then
                        plr.Character.Humanoid.Sit = false
                    end
                    block.CFrame = CFrame.new(block.Position.X, targetcframe.Y, block.Position.Z)
                    plh.CFrame = CFrame.new(plh.Position.X, targetcframe.Y, plh.Position.Z)
                    tween:Play()
                end
            end
        end
    end)
end

spawn(function()
    while wait() do
        if NoClip then
            if not game.Players.LocalPlayer.Character:WaitForChild("Head"):FindFirstChild("cac") then
                local buu = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character.Head)
                buu.Velocity = Vector3.new(0, 0, 0)
                buu.P = 1500
                buu.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                buu.Name = "cac"
            end
        else
            if game.Players.LocalPlayer.Character:WaitForChild("Head"):FindFirstChild("cac") then
                game.Players.LocalPlayer.Character:WaitForChild("Head").cac:Destroy()
            end
        end
    end
end)

spawn(function()
    while wait(2) do
        if tween and tween.PlaybackState == Enum.PlaybackState.Playing then
            NoClip = true
        elseif tween then
            NoClip = false
        end
    end
end)
        
local function formattedNumber(animationId)
    local id = animationId:match("%d+")
    return tonumber(id)
end

function CheckAnimation(EHumanoid)
    local exceptSet = {}
    for _, id in ipairs({10129760884, 9400509141, 10375950022, 9400516463, 9897746533, 8708225668,8708222938, 15087184962, 8708176378, 913389285, 8708224329, 8708225020, 15041522318,14977822399,15088352061,8994252874,10129768335,9897436286,9811880619,9897433386,9884584522,9799137678,9886242181,9811521002,9799138662,9884586404,9800654017,9799139408,9884587348,507766388,507766951,507766666,507785072,507784897,9799140065,9799140958,9802959564,9799136714,9841350003,9841333648,9841361789,3467766626,9811914002,9841324959,3406511948,9841340380,10432912847,8982044407,10375985353,8994244101,10432951137,10432969960}) do
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

function GetCurrentTool(toolvalue)
    for _, v in next, game:GetService("Players").LocalPlayer.Backpack:GetChildren() do
        if v:IsA("Tool") and v.ToolTip == toolvalue then
            return v.Name
        end
    end
    for _, v in next, game:GetService("Players").LocalPlayer.Character:GetChildren() do
        if v:IsA("Tool") and v.ToolTip == toolvalue then
            return v.Name
        end
    end
end

function EquipTool(toolname)
    for _, v in next, game:GetService("Players").LocalPlayer.Backpack:GetChildren() do
        if v:IsA("Tool") and tostring(v) == toolname or v.ToolTip == toolname then
            game:GetService("Players").LocalPlayer.Character.Humanoid:EquipTool(v)
        end
    end
end

function EquipWeapon()
    pcall(function()
        if Scibidi["Select Tool"] == nil or Scibidi["Select Tool"] == "" then
            Scibidi["Select Tool"] = "Melee"
        end
        local wp = GetCurrentTool(Scibidi["Select Tool"])
        local v1 = game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(wp)
        if v1 then
            game:GetService("Players").LocalPlayer.Character.Humanoid:EquipTool(v1)
        end
    end)
end

function CheckMob(mob, checkrep)
    for _, v in next, game:GetService("Workspace").Enemies:GetChildren() do
        if ((typeof(mob) == "table" and table.find(mob, v.Name)) or ((typeof(mob) == "string" and (string.find(v.Name, mob) or v.Name == mob)))) and v and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
            return v
        end
    end
    if checkrep ~= nil and checkrep ~= false then
        for _, v in next, RS:GetChildren() do
            if ((typeof(mob) == "table" and table.find(mob, v.Name)) or ((typeof(mob) == "string" and (string.find(v.Name, mob) or v.Name == mob)))) and v and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                return v
            end
        end
    end
end

function HopSivi() 
    local function nigga(v)
        if v.Name == "ErrorPrompt" then
            if v.Visible then
                if v.TitleFrame.ErrorTitle.Text == "Teleport Failed" then
                    v.Visible = false
                end
            end
            v:GetPropertyChangedSignal("Visible"):Connect(function()
                if v.Visible then
                    if v.TitleFrame.ErrorTitle.Text == "Teleport Failed" then
                        v.Visible = false
                    end
                end
            end)
        end
    end
    for i, v in game.CoreGui.RobloxPromptGui.promptOverlay:GetChildren() do
        nigga(v) 
    end
    game.CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(nigga)
    
    while wait() do
        plr.PlayerGui.ServerBrowser.Frame.Filters.SearchRegion.TextBox.Text = "Singapore"
        for r = 1, math.huge do
            for k, v in game.ReplicatedStorage.__ServerBrowser:InvokeServer(r) do
                if k ~= game.JobId and v["Count"] <= 10 then
                    game.ReplicatedStorage.__ServerBrowser:InvokeServer("teleport", k)
                end
            end
        end
    end
end

function FireRemotes(type, ...)
    arg = ({"Redeem", "CommF_"})[type]
    return RS.Remotes[arg]:InvokeServer(unpack({...}))
end

function EBuso()
    if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HasBuso") then
        FireRemotes(2, "Buso")
    end
end

function SendKey(nah, ilose)
    if ilose == nil then ilose = 0.1 end
    game:service("VirtualInputManager"):SendKeyEvent(true, nah, false, game)
    task.wait(ilose)
    game:service("VirtualInputManager"):SendKeyEvent(false, nah, false, game)
end

local TableNotQuest = {
    "BartiloQuest",
    "Trainees",
    "MarineQuest",
    "CitizenQuest"
}
local Quests = require(game.ReplicatedStorage.Quests)
local GuideModule = require(game.ReplicatedStorage.GuideModule)
function GetQuest()
    local Levels = plr.Data.Level.Value
    local phuongngu = 0
    if Levels >= 700 and CheckSea(1) then
        Mob = "Galley Captain"
        NameQuest = "FountainQuest"
        ID = 2
    elseif Levels >= 1500 and CheckSea(2) then
        Mob = "Water Fighter"
        NameQuest = "ForgottenQuest"
        ID = 2
    else
        for _, v in next, Quests do
            for r, i in next, v do
                local levelreq = i.LevelReq
                for d, b in next, i.Task do
                    if Levels >= levelreq and levelreq >= phuongngu and i.Task[d] > 1 and not table.find(TableNotQuest, tostring(_)) then
                        phuongngu = levelreq
                        Mob = tostring(d)
                        NameQuest = _
                        ID = r
                    end
                end
            end
        end
    end
end

function CFrameNPC()
    for r, v in next, GuideModule["Data"]["NPCList"] do
        if v["NPCName"] == GuideModule["Data"]["LastClosestNPC"] then
            return r["CFrame"]
        end
    end
end

function GetDataQuest()
    for r, v in next, GuideModule["Data"] do
        if string.find(r, "QuestData") then
            return true
        end
    end
    return false
end

function MobData()
    local mobcontainer
    if GetDataQuest() then
        for r, v in next, GuideModule["Data"]["QuestData"]["Task"] do
            mobcontainer = r
        end
    end
    return mobcontainer
end

function RemoveLevelTitle(Value)
    return tostring(tostring(Value):gsub(" %pLv. %d+%p", ""):gsub(" %pRaid Boss%p", ""):gsub(" %pBoss%p", ""))
end

FolderMob = Instance.new("Folder", workspace)
FolderMob.Name = "FolderMob"
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
                for r2, v2 in next, v1.Task do
                    if v2 > 1 then
                        table.insert(TableMobLvFarm, r2)
                    end
                end
            end
        end
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
function checkdbq()
    local n = {}
    for _, v in next, Quests do
        for r, i in next, v do
            for d, b in next, i.Task do
                if d == Mob then
                    for ngu, dot in next, v do
                        if dot.LevelReq <= game.Players.LocalPlayer.Data.Level.Value and dot.Name ~= "Town Raid" then
                            for phuong, sike in next, dot.Task do
                                if sike > 4 then
                                    table.insert(n, phuong)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return n
end

function checkdoublequest()
    local returner = {}
    GetQuest()
    if Scibidi["Double Quest"] and GetDataQuest() and MobData() == Mob  and #checkdbq() >= 2 and plr.Data.Level.Value >= 10 then
        for _, v in next, Quests do
            for r, i in next, v do
                for d, b in next, i.Task do
                    if tostring(d) == Mob then
                        for ngu, dot in next, v do
                            for phuong, sieungu in next, dot.Task do
                                if phuong ~= Mob and sieungu > 1 then
                                    returner["Mob"] = tostring(phuong)
                                    returner["NameQuest"] = _
                                    returner["ID"] = ngu
                                    return returner
                                end
                            end
                        end
                    end
                end
            end
        end
    else
        returner["Mob"] = Mob
        returner["NameQuest"] = NameQuest
        returner["ID"] = ID
    end
    return returner
end

function ClaimQuestLevelFarm()
    if getdistance(CFrameNPC().Position) >= 20 then
        Tween(CFrameNPC())
    else
        FireRemotes(2, "StartQuest", tostring(checkdoublequest()["NameQuest"]), checkdoublequest()["ID"])
    end
end
print("[Whites Hub] Loaded All Function Farm")
----------------------------------------------------------------------------------------------------------------------------------------------------------------
print("[Whites Hub] Loading FastAttack")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rig = ReplicatedStorage.RigControllerEvent
local Animation = Instance.new("Animation")
local Delay = 0.1
local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("CombatFramework"))
local CombatFrameworkR = getupvalues(CombatFramework)[2]
local _getupvalue = (debug.getupvalue or getupvalue or getupvalues or function(...)return ... end)
local _setupvalue = (debug.setupvalue or setupvalue or setupvalues or function(...)return ... end)
local RL = require(game:GetService("ReplicatedStorage").CombatFramework.RigLib)
local oldRL = RL.wrapAttackAnimationAsync
RL.wrapAttackAnimationAsync = function(a)
    a:Play(0.001, 0.001, 0.001)
end
BladeHits = function(Value)
    local Hits = {}
    for _, Hit in ipairs(Workspace.Enemies:GetChildren()) do
        local Humanoid = Hit and Hit:FindFirstChildOfClass("Humanoid")
        if Humanoid and Humanoid.Health > 0 then
            local RootPart = Humanoid.RootPart
            if RootPart and Players.LocalPlayer:DistanceFromCharacter(RootPart.Position) < Value then
                table.insert(Hits, RootPart)
            end
        end
    end
    return Hits
end
Attack = function()
    local AC = CombatFrameworkR.activeController
    if AC and AC.equipped then
        local Hit = {}
        for r, v in pairs(BladeHits(60)) do
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
            if Blade then
                Rig:FireServer("weaponChange", Blade.Name)
                ReplicatedStorage.Remotes.Validator:FireServer(math.floor(agrs5 / 1099511627776 * 16777215), agrs4)
                Rig:FireServer("hit", Hit, 2, "")
            end
        end
    end
end

task.spawn(function()
    while task.wait() do
        if Scibidi["Fast Attack"] then
            pcall(function()
                repeat task.wait(Delay)
                    task.spawn(function()
                        pcall(task.spawn, Attack)
                    end)
                until not Scibidi["Fast Attack"] or plr.Character.Stun.Value ~= 0
            end)
        end
    end
end)

local kkii = require(game.ReplicatedStorage.Util.CameraShaker)
kkii:Stop()
			
function BringMob(vv)
    for r, v in next, workspace.Enemies:GetChildren() do
        if v.Name == vv.Name and v.Parent and v.Humanoid.Health > 0 and v.HumanoidRootPart then
            v.HumanoidRootPart.CFrame = LockMob
            v.Humanoid:ChangeState(14)
            v.HumanoidRootPart.CanCollide = false
            v.Head.CanCollide = false
            if v.Humanoid:FindFirstChild("Animator") then
                v.Humanoid.Animator:Destroy()
            end
            sethiddenproperty(plr, "SimulationRadius", math.huge)
        end
    end
end

function KillMob(mobname, dodge, valuefunc)
    pcall(function()
        if valuefunc and valuefunc() then return end
        local v = CheckMob(mobname.Name, true)
        repeat task.wait()
            if valuefunc and valuefunc() then return end
            NoClip = true
            EquipWeapon()
            EBuso()
            LockMob = v.HumanoidRootPart.CFrame
            BringMob(v)
            if dodge then
                if CheckAnimation(v.Humanoid) then
                    Tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 400, 0))
                else
                    Tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0))
                end
            else
                if mobname.Name == "Cake Prince" then
                    if CheckAnimation(v.Humanoid) or game:GetService("Workspace")["_WorldOrigin"]:FindFirstChild("Ring") or game:GetService("Workspace")["_WorldOrigin"]:FindFirstChild("Fist") then
                        Tween(v.HumanoidRootPart.CFrame * CFrame.new(0, -40, 0))
                    else
                        Tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 15, 50))
                    end
                else
                    Tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 15, 0))
                end
            end
        until not v:FindFirstChild("HumanoidRootPart") or not v:FindFirstChild("Humanoid") or v.Humanoid.Health <= 0 or not v.Parent
    end)
end

function GetSkills()
    v2 = game.Players.LocalPlayer.PlayerGui.Main.Skills
    for _, v in next, Config.Weapon do
        if v.Enable then
            ToolName = GetWeaponType(_)
            for i1, v1 in next, v do
                if i1 == "Enable" then
                else
                    v175 = not ToolName or not v2:FindFirstChild(ToolName) or v2:FindFirstChild(ToolName)[i1].Cooldown.AbsoluteSize.X < 5  
                    if v175 and v1.Enable then
                        return {_, i1, v1}
                    end
                end
            end
        end
    end
end

function SendKey(nah, ilose)
    if ilose == nil then ilose = 0.1 end
    pcall(function()
        set_thread_identity(8) 
        game:service("VirtualInputManager"):SendKeyEvent(true, nah, false, game)
        task.wait(ilose)
        game:service("VirtualInputManager"):SendKeyEvent(false, nah, false, game)
    end)
end

print("[Whites Hub] Loaded FastAttack")
----------------------------------------------------------------------------------------------------------------------------------------------------------------
print("[Whites Hub] Loading Features")
------ // Config Tab \\ ------

Tab1:AddSeperator("Farmming Settings")

Tab1:AddToggle({
    Name = "FastAttack",
    Default = Scibidi["Fast Attack"],
    Callback = function(Value)
        Save("Fast Attack", Value)
    end
})

local tabledelay = {"0.02", "0.05", "0.07", "0.09", "0.1", "0.175"}
local function FastCooldown(nichgadaden)
    if nichgadaden == "0.02" then
        Delay = 0.02
    elseif nichgadaden == "0.05" then
        Delay = 0.05
    elseif nichgadaden == "0.07" then
        Delay = 0.07
    elseif nichgadaden == "0.09" then
        Delay = 0.09
    elseif nichgadaden == "0.1" then
        Delay = 0.1
    elseif nichgadaden == "0.175" then
        Delay = 0.175
    end
end

Tab1:AddDropdown({
    Name = "FastAttack Delay",
    Options = tabledelay,
    Default = Scibidi["FastDelay"],
    Callback = function(Value)
        Save("FastDelay", Value)
        FastCooldown(Scibidi["FastDelay"])
    end
})

Tab1:AddSlider({
    Name = "Bring Range",
    Max = 350,
    Min = 220,
    Default = Scibidi["Bring Range"],
    Callback = function(Value)
        Save("Bring Range", Value)
    end
})

Tab1:AddToggle({
    Name = "Bring Mob",
    Default = Scibidi["Bring Mob"],
    Callback = function(Value)
        Save("Bring Mob", Value)
    end
})

Tab1:AddDropdown({
    Name = "Tween Speed",
    Options = {"180", "220", "275", "300", "325", "350", "400"},
    Default = Scibidi["Tween Speed"],
    Callback = function(Value)
        Save("Tween Speed", Value)
    end
})

Tab1:AddSeperator("Players Settings")

function EnableV4()
    if plr.Character and plr.Character:FindFirstChild("RaceTransformed") and plr.Character:FindFirstChild("RaceEnergy") and plr.Character.RaceEnergy.Value >= 1 and not plr.Character.RaceTransformed.Value then
        game:GetService("Players").LocalPlayer.Backpack.Awakening.RemoteFunction:InvokeServer(true)
        wait(.2)
    end
end

Tab1:AddToggle({
    Name = "Auto Buso",
    Default = Scibidi["Auto Buso"],
    Callback = function(Value)
        Save("Auto Buso", Value)
    end
})

function EnableKen()
    if plr:FindFirstChild("PlayerGui") and plr.PlayerGui:FindFirstChild("ScreenGui") and plr.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
    else
        game:service("VirtualUser"):CaptureController()
        game:service("VirtualUser"):SetKeyDown("0x65")
        game:service("VirtualUser"):SetKeyUp("0x65")
        wait(3)
    end 
end

spawn(function()
    while wait() do
        if Scibidi["Auto Buso"] then
            if not plr.Character:FindFirstChild("HasBuso") then
                EBuso()
            end
        end
        if Scibidi["Auto Observation"] then
            EnableKen()
        end
        if Scibidi["No Stun"] then
            for r, v in next, plr.Character:GetDescendants() do
                if table.find({"BodyGyro", "BodyPosition"}, v.ClassName) then
                    v:Destroy()
                end
            end
        end
        if Scibidi["Auto Awakening"] then
            EnableV4()
        end
    end
end)

Tab1:AddToggle({
    Name = "Auto Observation",
    Default = Scibidi["Auto Observation"],
    Callback = function(Value)
        Save("Auto Observation", Value)
    end
})

Tab1:AddToggle({
    Name = "No Stun",
    Default = Scibidi["No Stun"],
    Callback = function(Value)
        Save("No Stun", Value)
    end
})

Tab1:AddToggle({
    Name = "Auto Awakening",
    Default = Scibidi["Auto Awakening"],
    Callback = function(Value)
        Save("Auto Awakening", Value)
    end
})

Tab1:AddToggle({
    Name = "Bypass Teleport",
    Default = Scibidi["Bypass Teleport"],
    Callback = function(Value)
        Save("Bypass Teleport", Value)
    end
})

----------------------------------------------------------------------------------------------------------------------------------------------------------------

Tab2:AddSeperator("Farm Settings")

Tab2:AddDropdown({
    Name = "Select Tool",
    Options = {"Melee", "Sword"},
    Default = Scibidi["Select Tool"],
    Callback = function(Value)
        Save("Select Tool", Value)
    end
})

Tab2:AddDropdown({
    Name = "Stats Select",
    Options = {"Melee", "Sword", "Gun", "Defense", "Demon Fruit"},
    Default = Scibidi["Select Stats"],
    Callback = function(Value)
        Save("Select Stats", Value)
    end
})

spawn(function()
    while wait() do
        pcall(function()
            if Scibidi["Select Stats"] and plr.Data.Stats[Scibidi["Select Stats"]].Level.Value <= 2449 and Scibidi["Select Stats"] ~= "" then
                FireRemotes(2, "AddPoint", Scibidi["Select Stats"], 9999)
            end
        end)
    end
end)

local tablex2code = {
    "EARN_FRUITS",
    "SUB2GAMERROBOT_RESET1",
    "KITT_RESET",
    "Bignews",
    "CHANDLER",
    "Fudd10",
    "fudd10_v2",
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


Tab2:AddButton({
    Name = "Redeem All Codes",
    Callback = function()
        for r, v in next, tablex2code do
            FireRemotes(1, tostring(v))
        end
    end
})

Tab2:AddSeperator("Auto Farm")

local CakeStt = Tab2:AddParagraph({Name = "Cake Prince Status : Killed 0"})

Tab2:AddDropdown({
    Name = "Method Farm",
    Options = {"Levels Farm", "Cake Prince Farm", "Bones Farm"},
    Default = Scibidi["Method Farm"],
    Callback = function(Value)
        Save("Method Farm", Value)
    end
})

Tab2:AddToggle({
    Name = "Auto Farm",
    Default = Scibidi["Auto Farm"],
    Callback = function(Value)
        Save("Auto Farm", Value)
    end
})

Tab2:AddToggle({
    Name = "Double Quest",
    Default = Scibidi["Double Quest"],
    Callback = function(Value)
        Save("Double Quest", Value)
    end
})

function GetPartMob(mobname)
    local mobnamegsub
    if string.find(mobname, "Lv.") then
        mobnamegsub = RemoveLevelTitle(mobname)
    end
    for r, v in next, game.Workspace["_WorldOrigin"].EnemySpawns:GetChildren() do
        if string.find(v.Name, "Lv.") then
            v.Name = RemoveLevelTitle(v.Name)
        end
        if v:IsA("Part") and mobnamegsub == v.Name or v.Name == mobname then
            return v
        end
    end
    for r, v in next, getnilinstances() do
        if string.find(v.Name, "Lv.") then
            v.Name = RemoveLevelTitle(v.Name)
        end
        if v:IsA("Part") and mobnamegsub == v.Name or v.Name == mobname then
            return v
        end
    end
end

function TweenMobSpawn(value, loopstop)
    if loopstop and loopstop() then return end
    for r, v in next, game.Workspace.FolderMob:GetChildren() do
        if v:IsA("Part") and ((typeof(value) == "table" and table.find(value, v.Name)) or (typeof(value) == "string" and string.find(v.Name, value))) then
            repeat wait()
                if loopstop and loopstop() then return end
                NoClip = true
                Tween(v.CFrame * CFrame.new(0, 40, 0))
            until CheckMob(value) or loopstop or getdistance(v.Position) <= 10
        end 
    end
end

local TableElite = {
    "Deandre",
    "Urban",
    "Diablo",
}

function CheckNotification(hieudubai)
    for r, v in pairs(plr.PlayerGui.Notifications:GetChildren()) do
        if v and v.Text and string.find(string.lower(v.Text), hieudubai) then
            return true
        end
    end
    return false
end

function GetMobCastle()
    for r, v in next, game.ReplicatedStorage:GetChildren() do
        if v and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then 
            if getdistance(Vector3.new(-5543.5327148438, 313.80062866211, -2964.2585449219), v.HumanoidRootPart.Position) <= 1000 then
                return v
            end 
        end
    end
    for r, v in next, game.Workspace.Enemies:GetChildren() do
        if v and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then 
            if getdistance(Vector3.new(-5543.5327148438, 313.80062866211, -2964.2585449219), v.HumanoidRootPart.Position) <= 1000 then
                return v
            end 
        end
    end
end

function GetPlayerInventory(wpname)
    for _, v in next, RS.Remotes.CommF_:InvokeServer("getInventory") do
        if string.find(v.Name, wpname) or tostring(v) == wpname then
            return true
        end
    end
    return false
end

function CheckElite()
    for i,v in next, RS:GetChildren() do
        if v:IsA("Model") and table.find(TableElite, v.Name) and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            return v 
        end
    end
    for i,v in next, game:GetService("Workspace").Enemies:GetChildren() do
        if v:IsA("Model") and table.find(TableElite, v.Name) and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            return v 
        end
    end
end

function GetFruitSpawn()
    for r, v in pairs(workspace:GetChildren()) do
        if v:IsA("Model") and string.find(v.Name, "Fruit") then
            return v
        end
    end
end

function GetPlate()
    for r, v in next, game.Workspace.Map.Jungle.QuestPlates:GetDescendants() do
        if string.find(v.Name, "Plate") then
            if v.Button.BrickColor ~= BrickColor.new("Camo") then
                return v
            end
        end
    end
end

function GetDoorTorch()
    if not game:GetService("Workspace").Map.Jungle.QuestPlates.Door.CanCollide then
        return true
    end
    return false
end

function GetSaberDoor()
    for r,v in next,game:GetService("Workspace").Map.Jungle.Final:GetChildren() do
        if v:IsA("Part") and not v.CanCollide then
            return true
        end
    end
    return false
end

function DetectMeleeMastery(MeleeNigger, nigga)
    local v = CheckPlayerBackpack(MeleeNigger)
    if v:FindFirstChild("Level") then
        if v.Level.Value >= nigga then
            return true
        end
    end
    return false
end

function GetDoorCup()
    for r, v in next, workspace.Map.Desert.Burn:GetChildren() do
        if v:IsA("Part") and not v.CanCollide then
            return true
        end
    end
    return false
end

IsRaid = false
function CheckStack(NameFunc)
    if NameFunc == "Method Farm" then
        if Scibidi["Auto Elite"] and CheckElite() then return true
        elseif Scibidi["Auto Castle Raid"] and CastleRaiding then return true
        elseif Scibidi["Auto Hallow Scythe [FULLY]"] and CheckMob("Soul Reaper", true) and not GetPlayerInventory("Hallow Scythe") then return true
        elseif Scibidi["Auto Rip Indra"] and CheckMob({"rip_indra", "rip_indra True Form"}, true) then return true
        elseif Scibidi["Auto Dough King"] and CheckMob("Dough King", true) then return true    
        elseif Scibidi["Auto Find DF"] and GetFruitSpawn() then return true
        elseif Scibidi["Auto Raid"] and IsRaid then return true
        elseif Scibidi["Auto Bartilo"] and plr.Data.Level.Value >= 850 and RS.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") ~= 3 then return true
        elseif Scibidi["Auto Saber"] and not GetPlayerInventory("Saber") and plr.Data.Level.Value >= 200 and game:GetService("Workspace").Map.Jungle.Final.Part.Transparency == 0 then return true
        elseif Scibidi["Auto Saber"] and not GetPlayerInventory("Saber") and game:GetService("Workspace").Map.Jungle.Final.Part.Transparency == 1 and CheckMob("Saber Expert", true) then return true
        elseif Scibidi["Auto Second Sea"] and plr.Data.Level.Value >= 700 and RS.Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Dressrosa") ~= 0 then return true 
        end
    elseif NameFunc == "Bartilo" then
        if Scibidi["Auto Raid"] and IsRaid then return true
        elseif Scibidi["Auto Find DF"] and GetFruitSpawn() then return true
        elseif Scibidi["Auto Saber"] and not GetPlayerInventory("Saber") and plr.Data.Level.Value >= 200 and game:GetService("Workspace").Map.Jungle.Final.Part.Transparency == 0 then return true
        elseif Scibidi["Auto Saber"] and not GetPlayerInventory("Saber") and game:GetService("Workspace").Map.Jungle.Final.Part.Transparency == 1 and CheckMob("Saber Expert", true) then return true
        end
    elseif NameFunc == "Elite" then
        if Scibidi["Auto Rip Indra"] and CheckMob({"rip_indra", "rip_indra True Form"}, true) then return true
        elseif Scibidi["Auto Castle Raid"] and CastleRaiding then return true
        elseif Scibidi["Auto Dough King"] and CheckMob("Dough King", true) then return true
        elseif Scibidi["Auto Find DF"] and GetFruitSpawn() then return true
        elseif Scibidi["Auto Raid"] and IsRaid then return true
        elseif Scibidi["Auto Trial"] and plr.PlayerGui.Main.Timer.Visible then return true
        end
    elseif NameFunc == "Castle Raid" then
        if Scibidi["Auto Rip Indra"] and CheckMob({"rip_indra", "rip_indra True Form"}, true) then return true
        elseif Scibidi["Auto Dough King"] and CheckMob("Dough King", true) then return true
        elseif Scibidi["Auto Find DF"] and GetFruitSpawn() then return true
        elseif Scibidi["Auto Raid"] and IsRaid then return true
        elseif Scibidi["Auto Trial"] and plr.PlayerGui.Main.Timer.Visible then return true
        end
    elseif NameFunc == "Yama" then
        if Scibidi["Auto Rip Indra"] and CheckMob({"rip_indra", "rip_indra True Form"}, true) then return true
        elseif Scibidi["Auto Elite"] and CheckElite() then return true
        elseif Scibidi["Auto Dough King"] and CheckMob("Dough King", true) then return true
        elseif Scibidi["Auto Find DF"] and GetFruitSpawn() then return true
        elseif Scibidi["Auto Raid"] and IsRaid then return true
        elseif Scibidi["Auto Trial"] and plr.PlayerGui.Main.Timer.Visible then return true
        end 
    elseif NameFunc == "Auto Hallow Scythe [FULLY]" then
        if Scibidi["Auto Rip Indra"] and CheckMob({"rip_indra", "rip_indra True Form"}, true) then return true
        elseif Scibidi["Auto Castle Raid"] and CastleRaiding then return true
        elseif Scibidi["Auto Dough King"] and CheckMob("Dough King", true) then return true
        elseif Scibidi["Auto Elite"] and CheckElite() then return true
        elseif Scibidi["Auto Find DF"] and GetFruitSpawn() then return true
        elseif Scibidi["Auto Raid"] and IsRaid then return true
        elseif Scibidi["Auto Trial"] and plr.PlayerGui.Main.Timer.Visible then return true
        end
    elseif NameFunc == "Fruit" then
        if Scibidi["Auto Trial"] and plr.PlayerGui.Main.Timer.Visible then return true
        elseif Scibidi["Auto Saber"] and not GetPlayerInventory("Saber") and plr.Data.Level.Value >= 200 and game:GetService("Workspace").Map.Jungle.Final.Part.Transparency == 0 then return true
        elseif Scibidi["Auto Saber"] and not GetPlayerInventory("Saber") and game:GetService("Workspace").Map.Jungle.Final.Part.Transparency == 1 and CheckMob("Saber Expert", true) then return true
        elseif Scibidi["Auto Second Sea"] and plr.Data.Level.Value >= 700 and RS.Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Dressrosa") ~= 0 then return true 
        end
    end
end

spawn(function()
    while wait() do
        pcall(function()
        if string.len(RS.Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 88 then
				CakeStt:Set({Name = "Cake Prince Status Killed : "..string.sub(RS.Remotes.CommF_:InvokeServer("CakePrinceSpawner"),39,41)..""})
			elseif string.len(RS.Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 87 then
				CakeStt:Set({Name = "Cake Prince Status Killed : "..string.sub(RS.Remotes.CommF_:InvokeServer("CakePrinceSpawner"),39,40)..""})
			elseif string.len(RS.Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 86 then
				CakeStt:Set({Name = "Cake Prince Status Killed : "..string.sub(RS.Remotes.CommF_:InvokeServer("CakePrinceSpawner"),39,39).." "})
			else
				CakeStt:Set({Name = "Cake Prince Status Spawned!!"})
			end
        end)
    end
end)

local TableMobSkipLevel = {
    "Shanda",
    "Royal Squad"
}

local TableCakeMobs = {
    "Cookie Crafter",
    "Cake Guard",
    "Baking Staff",
    "Head Baker"
}

local TableHauntedMobs = {
    "Reborn Skeleton",
    "Living Zombie",
    "Demonic Soul",
    "Posessed Mummy"
}

Tab2:AddToggle({
    Name = "Auto Summon Cake Prince",
    Default = Scibidi["Auto Summon Cake Prince"],
    Callback = function(Value)
        Save("Auto Summon Cake Prince", Value)
    end
})

spawn(function()
    while wait() do
        if Scibidi["Auto Summon Cake Prince"] and CheckSea(3) then
            RS.Remotes.CommF_:InvokeServer("CakePrinceSpawner", true)
        end
    end
end)

function AutoFarm()
    if CheckStack("Method Farm") then
    else
        if Scibidi["Method Farm"] == "Levels Farm" and Scibidi["Auto Farm"] then
            if plr.Data.Level.Value >= 1 and plr.Data.Level.Value <= 119 then
                if CheckMob(TableMobSkipLevel, true) then
                    local v = CheckMob(TableMobSkipLevel, true)
                    repeat wait()
                        KillMob(v, true, function() return not Scibidi["Auto Farm"] or CheckStack("Method Farm") end) 
                    until not Scibidi["Auto Farm"] or not v.Parent or not v.Humanoid or v.Humanoid.Health <= 0
                else
                    TweenMobSpawn(TableMobSkipLevel, function() return not Scibidi["Auto Farm"] or CheckStack("Method Farm") end)
                end
            else
                if plr.PlayerGui.Main.Quest.Visible then
                    local MobLevelFarm = MobData() or ""
                    if CheckMob(MobLevelFarm) then
                        for r, v in next, game.Workspace.Enemies:GetChildren() do
                            if v.Name == MobLevelFarm then
                                if v and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then 
                                    repeat wait()
                                        KillMob(v, false, function() return not Scibidi["Auto Farm"] or CheckStack("Method Farm") end)
                                    until not v or not v.Parent or not v:FindFirstChild("Humanoid") or v:FindFirstChild("Humanoid").health <= 0 or not Scibidi["Auto Farm"] or plr.PlayerGui.Main.Quest.Visible == false
                                end
                            end
                        end
                    else
                        TweenMobSpawn(MobLevelFarm, function() return not Scibidi["Auto Farm"] or CheckStack("Method Farm") end)
                    end
                else
                    ClaimQuestLevelFarm()
                end
            end
        elseif Scibidi["Method Farm"] == "Cake Prince Farm" and Scibidi["Auto Farm"] and CheckSea(3) then
            if CheckMob("Cake Prince", true) then
                local v = CheckMob("Cake Prince", true)
                if getdistance(v.HumanoidRootPart.Position) <= 1000 then
                    repeat wait()
                        KillMob(v, false, function() return not Scibidi["Auto Farm"] or CheckStack("Method Farm") end)
                    until not v or not v.Parent or not v:FindFirstChild("Humanoid") or v:FindFirstChild("Humanoid").health <= 0 or not Scibidi["Auto Farm"]
                else
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Map.CakeLoaf.BigMirror.Main, 0)
                    wait(0.1)
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, workspace.Map.CakeLoaf.BigMirror.Main, 1)
                end
            else
                if CheckMob(TableCakeMobs) then
                    for _, v in next, game:GetService("Workspace").Enemies:GetChildren() do
                        if table.find(TableCakeMobs, v.Name) then
                            if v and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                                repeat wait()
                                    KillMob(v, true, function() return not Scibidi["Auto Farm"] or CheckStack("Method Farm") end)
                                until not v or not v.Parent or not v:FindFirstChild("Humanoid") or v:FindFirstChild("Humanoid").health <= 0 or not Scibidi["Auto Farm"]
                            end
                        end
                    end
                else
                    Tween(CFrame.new(-2039.1698, 251.508789, -12326.1787))
                end
            end
        elseif Scibidi["Method Farm"] == "Bones Farm" and Scibidi["Auto Farm"] and CheckSea(3) then
            if CheckMob(TableHauntedMobs) then
                for _, v in next, game:GetService("Workspace").Enemies:GetChildren() do
                    if table.find(TableHauntedMobs, v.Name) then
                        if v and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                            repeat wait()
                                KillMob(v, true, function() return not Scibidi["Auto Farm"] or CheckStack("Method Farm") end)
                            until not v or not v.Parent or not v:FindFirstChild("Humanoid") or v:FindFirstChild("Humanoid").health <= 0 or not Scibidi["Auto Farm"]
                        end
                    end
                end
            else
                Tween(CFrame.new(-9504.8564453125, 172.14292907714844, 6057.259765625))
            end
        end
    end
end

spawn(function()
    while task.wait() do
        if Scibidi["Auto Farm"] then
            AutoFarm()
        end
    end
end)

Tab2:AddToggle({
    Name = "Auto Random Suprises",
    Default = Scibidi["Auto Random Suprises"],
    Callback = function(Value)
        Save("Auto Random Suprises", Value)
    end
})


spawn(function()
    while wait() do
        if Scibidi["Auto Random Suprises"] then
            FireRemotes(2, "Bones", "Buy", 1, 1)
        end
    end
end)

Tab2:AddSeperator("Nearest")

Tab2:AddToggle({
    Name = "KillAura",
    Default = Scibidi["KillAura"],
    Callback = function(Value)
        Save("KillAura", Value)
    end
})

function KillAura()
    if CheckStack("Method Farm") then
    else
        for _, v in next, game:GetService("Workspace").Enemies:GetChildren() do
            if v and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") and getdistance(v.HumanoidRootPart.Position) <= 1000 then
                repeat wait()
                    KillMob(v, false, function() return not Scibidi["KillAura"] or CheckStack("Method Farm") end)
                until v:FindFirstChild("Humanoid").Health <= 0 or not v.Parent or Scibidi["KillAura"] == false
            end
        end
    end
end 

local ChestToggled = Tab2:AddToggle({
    Name = "Auto Chest",
    Default = Scibidi["Auto Chest"],
    Settings = true,
    Callback = function(Value)
        Save("Auto Chest", Value)
    end
})

ChestToggled:AddToggle({
    Name = "Stop Special Item",
    Default = Scibidi["Stop Special Item"],
    Callback = function(Value)
        Save("Stop Special Item", Value)
    end
})

function getnearestchest()
    local min = math.huge
    local ngu
    for r, v in next, game.Workspace:GetChildren() do
        if v.Parent and v:IsA("Part") and string.match(v.Name, "Chest") then
            if getdistance(v.Position) < min then
                min, ngu = getdistance(v.Position), v
            end
        end
    end
    if not ngu then
        for r, v in next, game.Workspace:GetChildren() do
            if v.Parent and v:IsA("Part") and string.match(v.Name, "Chest") then
                if getdistance(v.Position) < min then
                    min, ngu = getdistance(v.Position), v
                end
            end
        end
    end
    return ngu
end

function AutoChest()
    pcall(function()
        if CheckStack("Method Farm") then
        else
            local v = getnearestchest()
            repeat wait()
                NoClip = true
                Tween(v.CFrame)
            until not v.Parent or Scibidi["Auto Chest"] == false or CheckStack("Method Farm") or Scibidi["Stop Special Item"] and CheckPlayerBackpack("God's Chalice") or CheckPlayerBackpack("Fist Of Darkness")
        end
    end)
end

spawn(function()
    while task.wait() do
        if Scibidi["KillAura"] then
            KillAura()
        end
        if Scibidi["Auto Chest"] then
            AutoChest()
        end
    end
end)

Tab2:AddSeperator("Server")

Tab2:AddInput({
    Name = "Job Id",
    Description = "...",
    PlaceHolderText = "...",
    Default = "",
    Callback = function(Value)
        _G.JobId = Value
    end
})

Tab2:AddButton({
    Name = "Join Job Id",
    Callback = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.placeId, _G.JobId, plr)
    end
})

Tab2:AddButton({
    Name = "Copy Job Id",
    Callback = function()
        setclipboard(tostring(game.JobId))
    end
})

Tab2:AddButton({
    Name = "Rejoin",
    Callback = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.placeId, game.JobId, plr)
    end
})

Tab2:AddButton({
    Name = "Hop Server",
    Callback = function()
        HopSivi()
    end
})

----------------------------------------------------------------------------------------------------------------------------------------------------------------

Tab3:AddSeperator("Sea 1")

local SaberStatus = Tab3:AddParagraph({Name = "Saber Expert : Spawned", Description = "Status..."})
spawn(function()
    while wait() do
        if CheckMob("Saber Expert", true) then
            SaberStatus:Set({Name = "Saber Expert : Spawned"})
        else
            SaberStatus:Set({Name = "Saber Expert : Not Spawned"})
        end
    end
end)

Tab3:AddToggle({
    Name = "Auto Saber",
    Default = Scibidi["Auto Saber"],
    Callback = function(Value)
        Save("Auto Saber", Value)
    end
})

function GetSaber()
    if not GetSaberDoor() then
        if not GetDoorTorch() then
            local v = GetPlate()
            Tween(v.Button.CFrame)
        else
            if RS.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") ~= 1 and RS.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") ~= 0 then
                if not CheckPlayerBackpack("Cup") then
                    if not GetDoorCup() then
                        if not CheckPlayerBackpack("Torch") then
                            Tween(workspace.Map.Jungle.Torch.CFrame)
                        else
                            EquipTool("Torch")
                            Tween(CFrame.new(1114.3269, 5.2647109, 4351.73047, -0.669475853, -4.66796521e-08, 0.742833853, -2.86030915e-08, 1, 3.70615503e-08, -0.742833853, 3.56446872e-09, -0.669475853))
                        end
                    else
                        Tween(workspace.Map.Desert.Cup.CFrame)
                    end
                else
                    EquipTool("Cup")
                    wait(.1)
                    FireRemotes(2, "ProQuestProgress","FillCup",plr.Character.Cup)
                    wait(.1)
                    FireRemotes(2, "ProQuestProgress","SickMan")
                end
            elseif RS.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") == 0 then
                local v = CheckMob("Mob Leader", true)
                repeat wait()
                    KillMob(v, false, function() return not Scibidi["Auto Saber"] or RS.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") == 1 end)
                until not Scibidi["Auto Saber"] or RS.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") == 1
            elseif RS.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") == 1 then
                if not CheckPlayerBackpack("Relic") then
                    FireRemotes(2, "ProQuestProgress", "RichSon")
                else
                    EquipTool("Relic")
                    Tween(CFrame.new(-1404.91504, 29.9773273, 3.80598116, 0.876514494, 5.66906877e-09, 0.481375456, 2.53851997e-08, 1, -5.79995607e-08, -0.481375456, 6.30572643e-08, 0.876514494))
                end
            end
        end
    else
        local v = CheckMob("Saber Expert", true)
        repeat wait()
            KillMob(v, false, function() return not Scibidi["Auto Saber"] or GetPlayerInventory("Saber") end)
        until not Scibidi["Auto Saber"] or GetPlayerInventory("Saber")
    end
end

spawn(function()
    while task.wait() do
        if Scibidi["Auto Saber"] and plr.Data.Level.Value >= 200 and CheckSea(1) and not GetPlayerInventory("Saber") then
            GetSaber()
        end
    end
end)

Tab3:AddToggle({
    Name = "Auto Pole",
    Default = Scibidi["Auto Pole"],
    Callback = function(Value)
        Save("Auto Pole", Value)
    end
})

function AutoPole()
    if Scibidi["Auto Saber"] and CheckMob("Saber Expert") and not CheckPlayerBackpack("Saber") then return end
    if not CheckPlayerBackpack("Pole (1st Form)") then
        if CheckMob("Thunder God", true) then
            local v = CheckMob("Thunder God", true)
            repeat wait()
                KillMob(v, false, function() return not Scibidi["Auto Pole"] or GetPlayerInventory("Pole (1st Form)") end)
            until not Scibidi["Auto Pole"] or GetPlayerInventory("Pole (1st Form)")
        end
    end
end

spawn(function()
    while task.wait() do
        if Scibidi["Auto Pole"] and plr.Data.Level.Value >= 200 and CheckSea(1) and not GetPlayerInventory("Pole (1st Form)") then
            AutoPole()
        end
    end
end)

local ToggledAutoSea2 = Tab3:AddToggle({
    Name = "Auto Second Sea",
    Default = Scibidi["Auto Second Sea"],
    Callback = function(Value)
        Save("Auto Second Sea", Value)
    end
})

function QuaSea2()
    if plr.Data.Level.Value >= 700 and CheckSea(1) then
        if RS.Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Dressrosa") ~= 0 then
            if game.Workspace.Map.Ice.Door.CanCollide then
                if not CheckPlayerBackpack("Key") then
                    if (CFrame.new(4852.2895507813, 5.651451587677, 718.53070068359).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                        FireRemotes(2, "DressrosaQuestProgress", "Detective")
                    else
                        Tween(CFrame.new(4852.2895507813, 5.651451587677, 718.53070068359))
                    end
                else
                    EquipTool("Key")
                    Tween(game.Workspace.Map.Ice.Door.CFrame)
                end
            else
                if CheckMob("Ice Admiral", true) then
                    repeat wait()
                        KillMob(CheckMob("Ice Admiral", true), function() return not CheckMob("Ice Admiral", true) or not Scibidi["Auto Second Sea"] or not plr.Data.Level.Value >= 700 and RS.Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Dressrosa") ~= 0 end)
                    until not CheckMob("Ice Admiral", true) or not Scibidi["Auto Second Sea"] or not plr.Data.Level.Value < 700 or RS.Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Dressrosa") == 0
                end
            end
        else
            FireRemotes(2, "TravelDressrosa")
            wait(.1)
            ToggledAutoSea2:Set(false)
        end
    end
end

spawn(function()
    while task.wait() do
        if Scibidi["Auto Second Sea"] and plr.Data.Level.Value >= 700 and CheckSea(1) then
            FireRemotes(2, "TravelDressrosa")
            QuaSea2()
        end
    end
end)

Tab3:AddSeperator("Sea 3")

Tab3:AddToggle({
    Name = "Auto Rip Indra",
    Default = Scibidi["Auto Rip Indra"],
    Callback = function(Value)
        Save("Auto Rip Indra", Value)
    end
})

Tab3:AddToggle({
    Name = "Auto Dough King",
    Default = Scibidi["Auto Dough King"],
    Callback = function(Value)
        Save("Auto Dough King", Value)
    end
})

Tab3:AddToggle({
    Name = "Auto Observation Level",
    Default = Scibidi["Auto Observation Level"],
    Callback = function(Value)
        Save("Auto Observation Level", Value)
    end
})

local TableRipindra = {
    "rip_indra",
    "rip_indra True Form"
}

function AutoRipIndra()
    if CheckMob(TableRipindra, true) then
        local v = CheckMob(TableRipindra)
        repeat wait()
            KillMob(v, false, function()
                return not Scibidi["Auto Rip Indra"]
            end)
        until not Scibidi["Auto Rip Indra"] or not v.Parent or not v.Humanoid or v.Humanoid.Health <= 0
    end
end

function getInventorycount(l)
    for _, v in next, RS.Remotes.CommF_:InvokeServer("getInventory") do
        if v.Name == l then
            return v.Count
        end
    end
end

function AutoDoughKing()
    if not CheckMob("Dough King", true) then
        if CheckPlayerBackpack("Sweet Chalice") then
            if getInventorycount("Conjured Cocoa") >= 10 then
                v1 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CakePrinceSpawner", true)
                if v1:find("open the portal now") then
                    spawn(function()
                        RS.Remotes.CommF_:InvokeServer("CakePrinceSpawner")
                    end)
                else
                    if CheckMob(TableCakeMobs) then
                        for _, v in next, game:GetService("Workspace").Enemies:GetChildren() do
                            if table.find(TableCakeMobs, v.Name) then
                                if v and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                                    repeat wait()
                                        KillMob(v, true, function()
                                            return not Scibidi["Auto Dough King"]
                                        end)
                                    until not v or not v.Parent or not v:FindFirstChild("Humanoid") or v:FindFirstChild("Humanoid").health <= 0 or not Scibidi["Auto Dough King"]
                                end
                            end
                        end
                    else
                        Tween(CFrame.new(-2039.1698, 251.508789, -12326.1787))
                    end
                end
            end
        else
            if CheckPlayerBackpack("God's Chalice") then
                if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("SweetChaliceNpc")  ~= "Where are the items?" then
                    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("SweetChaliceNpc")
                else
                    if CheckMob({"Chocolate Bar Battler", "Cocoa Warrior"}, true) then
                        local v = CheckMob({"Chocolate Bar Battler", "Cocoa Warrior"}, true)
                        repeat wait()
                            KillMob(v, true, function() return not Scibidi["Auto Dough King"] or game.ReplicatedStorage.Remotes.CommF_:InvokeServer("SweetChaliceNpc")  ~= "Where are the items?" end)
                        until game.ReplicatedStorage.Remotes.CommF_:InvokeServer("SweetChaliceNpc")  ~= "Where are the items?" or  not v or not v.Parent or not v:FindFirstChild("Humanoid") or v:FindFirstChild("Humanoid").health <= 0 or not Scibidi["Auto Dough King"]
                    else
                        TweenMobSpawn({"Chocolate Bar Battler", "Cocoa Warrior"}, function() return not Scibidi["Auto Dough King"] or game.ReplicatedStorage.Remotes.CommF_:InvokeServer("SweetChaliceNpc")  ~= "Where are the items?" end)
                    end
                end
            end
        end
    else
        local v = CheckMob("Dough King", true) 
        repeat wait()
            KillMob(v, true, function()
                return not Scibidi["Auto Dough King"]
            end)
        until not v or not v.Parent or not v:FindFirstChild("Humanoid") or v:FindFirstChild("Humanoid").health <= 0 or not Scibidi["Auto Dough King"]
    end
end

function CheckMobBuso()
    for r, v in next, game.Workspace.Enemies:GetChildren() do
        if v.Humanoid then
            for _, i in next, v.Humanoid:GetChildren() do
                if string.find(i.Name, "Buso") then
                    return v
                end
            end
        end
    end
end

TickWait = tick()
function AutoObservationLevel()
    if CheckStack("Method Farm") then
    else
        EnableKen()
        if CheckMobBuso() then
            local v = CheckMobBuso()
            if plr.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
                repeat wait()
                    Tween(v.HumanoidRootPart.CFrame)
                until CheckStack("Method Farm") or v.Humanoid.Health <= 0 or not plr.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") or Scibidi["Auto Observation Level"] == false
                TickWait = tick()
            else
                if tick() - TickWait >= 3 and Scibidi["Auto Observation Level"] then
                    HopSivi()
                end
            end
        end
    end
end

spawn(function()
    while task.wait() do
        if Scibidi["Auto Rip Indra"] and CheckSea(3) then
            AutoRipIndra()
        end
        if Scibidi["Auto Dough King"] and CheckSea(3) then
            AutoDoughKing()
        end
        if Scibidi["Auto Observation Level"] then
            AutoObservationLevel()
        end
    end
end)

Tab3:AddSeperator("Function Sea3")

local EliteStatus = Tab3:AddParagraph({
    Name = "Elite Status : "
})

spawn(function()
    while wait() do
        if CheckElite() then
            EliteStatus:Set({Name = "Elite Status : Spawned!!"})
        else
            EliteStatus:Set({Name = "Elite Status : Not Spawned!!"})
        end
    end
end)

Tab3:AddToggle({
    Name = "Auto Elite",
    Default = Scibidi["Auto Elite"],
    Callback = function(Value)
        Save("Auto Elite", Value)
    end
})

Tab3:AddToggle({
    Name = "Auto Elite [HOP]",
    Default = Scibidi["Auto Elite [HOP]"],
    Callback = function(Value)
        Save("Auto Elite [HOP]", Value)
        if Value and not Scibidi["Auto Elite"] then
            Library:AddNotify({
                Title = "Auto Elite [HOP]",
                Content = "Turn Auto Elite Please!!!",
                Time = 5
            })
        end
    end
})

function GetTextQuest(textcheck)
    return string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, textcheck)
end

function AutoElite()
    if CheckStack("Elite") then
    else
        if CheckElite() then
            if plr.PlayerGui.Main.Quest.Visible == true and GetTextQuest("Urban") or GetTextQuest("Deandre") or GetTextQuest("Diablo") then
                local v = CheckElite()
                repeat wait()
                    KillMob(v, false, function()
                        return not Scibidi["Auto Elite"] or CheckStack("Elite")
                    end)
                until not v or not v.Parent or not v:FindFirstChild("Humanoid") or v:FindFirstChild("Humanoid").health <= 0 or not Scibidi["Auto Elite"]
            elseif plr.PlayerGui.Main.Quest.Visible == false or not GetTextQuest("Urban") and not GetTextQuest("Deandre") and not GetTextQuest("Diablo") then
                FireRemotes(2, "EliteHunter")
            end
        else
            if Scibidi["Auto Elite [HOP]"] then
                Library:AddNotify({
                    Title = "Auto Elite",
                    Content = "Wait 5 Seconds Hop Find Elite",
                    Time = 5
                })
                wait(5)
                HopSivi()
            end
        end
    end
end

spawn(function()
    while task.wait() do
        if Scibidi["Auto Elite"] and CheckSea(3) then
            AutoElite()
        end
    end
end)

Tab3:AddToggle({
    Name = "Auto Castle Raid",
    Default = Scibidi["Auto Castle Raid"],
    Callback = function(Value)
        Save("Auto Castle Raid", Value)
    end
})

spawn(function()
    while wait() do
        if Scibidi["Auto Castle Raid"] then
            if GetMobCastle() then
                CastleRaiding = true
                RaidStartTicka = tick()
                repeat task.wait()
                    if GetMobCastle() then
                        RaidStartTicka = tick()
                    end
                until not Scibidi["Auto Castle Raid"] or tick() - RaidStartTicka >= 20 and not GetMobCastle() or CheckNotification("Good job!")
                CastleRaiding = false
            end
        end
    end
end)

function AutoCastleRaid()
    if CheckStack('Castle Raid') then
    else
        if GetMobCastle() then
            local v = GetMobCastle()
            repeat wait()
                KillMob(v, false, function() return not Scibidi["Auto Castle Raid"] or CheckStack("Castle Raid") end)
            until not v or not v.Parent or not v:FindFirstChild("Humanoid") or v:FindFirstChild("Humanoid").health <= 0 or not Scibidi["Auto Elite"] or not CastleRaiding
        end
    end
end

spawn(function()
    while task.wait() do
        if Scibidi["Auto Castle Raid"] and CheckSea(3) then
            AutoCastleRaid()
        end
    end
end)

Tab3:AddSeperator("Sea 2")

Tab3:AddToggle({
    Name = "Auto Bartilo",
    Default = Scibidi["Auto Bartilo"],
    Callback = function(Value)
        Save("Auto Bartilo", Value)
    end
})

function Checkplate()
    local plate  
    if workspace.Map.Dressrosa.BartiloPlates.Plate1.BrickColor == BrickColor.new("Sand yellow") then 
        plate = "Plate1"
    elseif workspace.Map.Dressrosa.BartiloPlates.Plate2.BrickColor == BrickColor.new("Sand yellow") then
        plate = "Plate2"
    elseif workspace.Map.Dressrosa.BartiloPlates.Plate3.BrickColor == BrickColor.new("Sand yellow") then
        plate = "Plate3"
    elseif workspace.Map.Dressrosa.BartiloPlates.Plate4.BrickColor == BrickColor.new("Sand yellow") then
        plate = "Plate4"
    elseif workspace.Map.Dressrosa.BartiloPlates.Plate5.BrickColor == BrickColor.new("Sand yellow") then
        plate = "Plate5"
    elseif workspace.Map.Dressrosa.BartiloPlates.Plate6.BrickColor == BrickColor.new("Sand yellow") then
        plate = "Plate6"
    elseif workspace.Map.Dressrosa.BartiloPlates.Plate7.BrickColor == BrickColor.new("Sand yellow") then
        plate = "Plate7"
    elseif workspace.Map.Dressrosa.BartiloPlates.Plate8.BrickColor == BrickColor.new("Sand yellow") then
        plate = "Plate8"
    end
    return plate 
end

function AutoBartilo()
    if CheckStack("Bartilo") then
    else
        if plr.Data.Level.Value >= 850 then
            if RS.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 0 then
                if CheckMob("Swan Pirate", true) then
                    local v = CheckMob("Swan Pirate", true)
                    repeat wait()
                        KillMob(v, false, function() return not Scibidi["Auto Bartilo"] or CheckStack("Bartilo") end)
                    until RS.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 1 or not v or not v.Parent or not v:FindFirstChild("Humanoid") or v:FindFirstChild("Humanoid").health <= 0 or not Scibidi["Auto Bartilo"]
                else
                    TweenMobSpawn("Swan Pirate", function() return not Scibidi["Auto Bartilo"] end)
                end
            elseif RS.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 1 then
                if CheckMob("Jeremy", true) then
                    local v = CheckMob("Jeremy", true)
                    repeat wait()
                        KillMob(v, false, function() return not Scibidi["Auto Bartilo"] or CheckStack("Bartilo") end)
                    until RS.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 2 or not v or not v.Parent or not v:FindFirstChild("Humanoid") or v:FindFirstChild("Humanoid").health <= 0 or not Scibidi["Auto Bartilo"]
                else
                    Library:AddNotify({
                        Title = "Auto Bartilo",
                        Content = "Wait 5 Seconds Hop Find Jeremy",
                        Time = 5
                    })
                    wait(5)
                    HopSivi()
                end
            elseif RS.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 2 then
                if getdistance(CFrame.new(-1835.65, 10.4325, 1679.75).Position) >= 100 then
                    Tween(CFrame.new(-1835.65, 10.4325, 1679.75))
                else
                    repeat wait()
                        plr.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates[Checkplate()].CFrame
                        task.wait(0.5)
                        firetouchinterest(workspace.Map.Dressrosa.BartiloPlates[Checkplate()], plr.Character.HumanoidRootPart, 0)
                        firetouchinterest(workspace.Map.Dressrosa.BartiloPlates[Checkplate()], plr.Character.HumanoidRootPart, 1)
                    until RS.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 3 or not Scibidi["Auto Bartilo"]
                end
            end
        end
    end
end

spawn(function()
    while task.wait() do
        if Scibidi["Auto Bartilo"] and CheckSea(2) then
            AutoBartilo()
        end
    end
end)

Tab4:AddSeperator("Fighting Style")

Tab4:AddToggle({
    Name = "Auto Superhuman",
    Default = Scibidi["Auto Superhuman"],
    Callback = function(Value)
        Save("Auto Superhuman", Value)
    end
})

Tab4:AddToggle({
    Name = "Auto Electric Claw",
    Default = Scibidi["Auto Electric Claw"],
    Callback = function(Value)
        Save("Auto Electric Claw", Value)
    end
})

-- Rise Eating Shit

function AutoElectricityShit()
    if RS.Remotes.CommF_:InvokeServer("BuyElectricClaw", true) ~= 1 then
        if CheckPlayerBackpack("Electro") then
            if DetectMeleeMastery("Electro", 400) then
                FireRemotes(2, "BuyElectricClaw","Start")
                wait(1)
                FireRemotes(2, "requestEntrance",Vector3.new(-12549.7236, 337.511505, -7470.36328))
                wait(0.5)
                FireRemotes(2, "BuyElectricClaw")
                wait(.1)
                SendNotification("Script Warning", "All Done!!", 7)
            end
        else
            wait(0.5)
            FireRemotes(2, "BuyElectro")
        end
    else
        wait(0.5)
        FireRemotes(2, "BuyElectricClaw")
    end
end

spawn(function()
    while wait() do
        pcall(function()
            if Scibidi["Auto Superhuman"] then
                AutoShitHuman()
            end
            if Scibidi["Auto Electric Claw"] then
                AutoElectricityShit()
            end
        end)
    end
end)

Tab4:AddSeperator("Hallow Scythe")

Tab4:AddToggle({
    Name = "Auto Hallow Scythe [FULLY]",
    Default = Scibidi["Auto Hallow Scythe [FULLY]"],
    Callback = function(Value)
        Save("Auto Hallow Scythe [FULLY]", Value)
    end
})

Tab4:AddToggle({
    Name = "Auto Hallow Scythe [HOP]",
    Default = Scibidi["Auto Hallow Scythe [HOP]"],
    Callback = function(Value)
        Save("Auto Hallow Scythe [HOP]", Value)
        if Value and not Scibidi["Auto Elite"] then
            Library:AddNotify({
                Title = "Auto Hallow Scythe [HOP]",
                Content = "Turn Auto Hallow Scythe [FULLY] Please!!!",
                Time = 5
            })
        end
        if Value and getInventorycount("Bones") < 50 then
            SendNotification("Script Warning", "Start Farming Bones", 12)
        end
    end
})

function AutoHallowScythe()
    if CheckStack("Auto Hallow Scythe [FULLY]") then
    else
        if not CheckMob("Soul Reaper", true) then
            if Scibidi["Auto Hallow Scythe [HOP]"] then
                Library:AddNotify({
                    Title = "Auto Hallow Scythe",
                    Content = "Wait 5 Seconds Hop Find Soul Reaper",
                    Time = 5
                })
                wait(5)
                HopSivi()
            else
                if CheckPlayerBackpack("Hallow Essence") then
                    EquipTool("Hallow Essence")
                    Tween(game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.CFrame)
                else
                    if getInventorycount("Bones") >= 50 then
                        FireRemotes(2, "Bones", "Buy", 1, 1)
                        wait(.1)
                    else
                        if CheckMob(TableHauntedMobs) then
                            for _, v in next, game:GetService("Workspace").Enemies:GetChildren() do
                                if table.find(TableHauntedMobs, v.Name) then
                                    if v and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                                        repeat wait()
                                            KillMob(v, false, function() return not Scibidi["Auto Hallow Scythe [FULLY]"] or CheckStack("Auto Hallow Scythe [FULLY]") end)
                                        until not v or not v.Parent or not v:FindFirstChild("Humanoid") or v:FindFirstChild("Humanoid").health <= 0 or not Scibidi["Auto Hallow Scythe [FULLY]"]
                                    end
                                end
                            end
                        else
                            TweenMobSpawn(TableHauntedMobs, function() return not Scibidi["Auto Hallow Scythe [FULLY]"] end)
                        end            
                    end
                end
            end
        else
            local v = CheckMob("Soul Reaper", true)
            repeat wait()
                KillMob(v, false, function() return not Scibidi["Auto Hallow Scythe [FULLY]"] or CheckStack("Auto Hallow Scythe [FULLY]") end)
            until not v or not v.Parent or not v:FindFirstChild("Humanoid") or v:FindFirstChild("Humanoid").health <= 0 or not Scibidi["Auto Hallow Scythe [FULLY]"]
        end
    end
end

spawn(function()
    while task.wait() do
        if Scibidi["Auto Hallow Scythe [FULLY]"] and CheckSea(3) then
            AutoHallowScythe()
        end
    end
end)

Tab4:AddSeperator("Yama")

Tab4:AddToggle({
    Name = "Auto Yama",
    Default = Scibidi["Auto Yama"],
    Callback = function(Value)
        Save("Auto Yama", Value)
    end
})

Tab4:AddToggle({
    Name = "Auto Yama [HOP]",
    Default = Scibidi["Auto Yama [HOP]"],
    Callback = function(Value)
        Save("Auto Yama [HOP]", Value)
    end
})

function GetYama()
    if CheckStack("Yama") then
    else
        if RS.Remotes.CommF_:InvokeServer("EliteHunter", "Progress") < 30 then
            if CheckElite() then
                if plr.PlayerGui.Main.Quest.Visible and GetTextQuest(TableElite) then
                    local v = CheckElite()
                    repeat wait()
                        KillMob(v, false, function() return not Scibidi["Auto Yama"] or CheckStack("Yama") end)
                    until not v or not v.Parent or not v:FindFirstChild("Humanoid") or v:FindFirstChild("Humanoid").health <= 0 or not Scibidi["Auto Elite"]
                else
                    FireRemotes(2, "EliteHunter")
                end
            else
                if Scibidi["Auto Yama [HOP]"] then
                    Library:AddNotify({
                        Title = "Auto Yama",
                        Content = "Wait 5 Seconds Hop Find Elite",
                        Time = 5
                    })
                    wait(5)
                    HopSivi()
                end
            end
        else
            if getdistance(game.Workspace.Map.Waterfall.SealedKatana.Handle.Position) > 10 then
                Tween(game.Workspace.Map.Waterfall.SealedKatana.Handle.CFrame)
            else
                fireclickdetector(game.Workspace.Map.Waterfall.SealedKatana.Handle.ClickDetector)
            end
        end
    end
end

spawn(function()
    while task.wait() do
        if Scibidi["Auto Yama"] and CheckSea(3) and not GetWeaponInventory("Yama") then
            GetYama()
        end
    end
end)

-- // Shop Tab \\ ---

function BuyMelee(meleename)
    FireRemotes(2, meleename, true)
    FireRemotes(2, meleename)
end

Tab9:AddSeperator("Melee")

Tab9:AddButton({
    Name = "Buy Black Leg",
    Callback = function()
        BuyMelee("BuyBlackLeg")
    end
})

Tab9:AddButton({
    Name = "Buy Electro",
    Callback = function()
        BuyMelee("BuyElectro")
    end
})

Tab9:AddButton({
    Name = "Buy Fishman Karate",
    Callback = function()
        BuyMelee("BuyFishmanKarate")
    end
})

Tab9:AddButton({
    Name = "Buy Dragon Claw",
    Callback = function()
        FireRemotes(2, "BlackbeardReward", "DragonClaw", "1")
        FireRemotes(2, "BlackbeardReward", "DragonClaw", "2")
    end
})

Tab9:AddButton({
    Name = "Buy Superhuman",
    Callback = function()
        BuyMelee("BuySuperhuman")
    end
})

Tab9:AddButton({
    Name = "Buy Death Step",
    Callback = function()
        BuyMelee("BuyDeathStep")
    end
})

Tab9:AddButton({
    Name = "Buy Electric Claw",
    Callback = function()
        BuyMelee("BuyElectricClaw")
    end
})

Tab9:AddButton({
    Name = "Buy Sharkman Karate",
    Callback = function()
        BuyMelee("BuySharkmanKarate")
    end
})

Tab9:AddButton({
    Name = "Buy Dragon Talon",
    Callback = function()
        BuyMelee("BuyDragonTalon")
    end
})

Tab9:AddButton({
    Name = "Buy Godhuman",
    Callback = function()
        BuyMelee("BuyGodhuman")
    end
})

Tab9:AddButton({
    Name = "Buy Sanguine Art",
    Callback = function()
        BuyMelee("BuySanguineArt")
    end
})

Tab9:AddSeperator("Haki")

Tab9:AddButton({
    Name = "Buy Buso",
    Callback = function()
        local args = {
            [1] = "BuyHaki",
            [2] = "Buso"
        }
        RS.Remotes.CommF_:InvokeServer(unpack(args))
    end
})

Tab9:AddButton({
    Name = "Buy Geppo",
    Callback = function()
        local args = {
            [1] = "BuyHaki",
            [2] = "Geppo"
        }
        RS.Remotes.CommF_:InvokeServer(unpack(args))
    end
})

Tab9:AddButton({
    Name = "Buy Observation",
    Callback = function()
        local args = {
            [1] = "KenTalk",
            [2] = "Buy"
        }
        RS.Remotes.CommF_:InvokeServer(unpack(args))
    end
})

Tab9:AddButton({
    Name = "Buy Soru",
    Callback = function()
        local args = {
            [1] = "BuyHaki",
            [2] = "Soru"
        }
        RS.Remotes.CommF_:InvokeServer(unpack(args))
    end
})

----------------------------------------------------------------------------------------------------------------------------------------------------------------

Tab10:AddSeperator("Fruits")

function RandomDF()
    FireRemotes(2, "Cousin","Buy")
end

Tab10:AddButton({
    Name = "Random Fruit",
    Callback = function()
        RandomDF()
    end
})

Tab10:AddToggle({
    Name = "Auto Random Fruit",
    Default = Scibidi["Auto Random Fruit"],
    Callback = function(Value)
        Save("Auto Random Fruit", Value)
    end
})

spawn(function()
    while wait() do
        if Scibidi["Auto Random Fruit"] then
            RandomDF()
        end
    end
end)

Tab10:AddToggle({
    Name = "Auto Find DF",
    Default = Scibidi["Auto Find DF"],
    Callback = function(Value)
        Save("Auto Find DF", Value)
    end
})

spawn(function()
    while wait() do
        if Scibidi["Auto Find DF"] then
            if CheckStack("Fruit") then
            else
                if GetFruitSpawn() then
                    if GetFruitSpawn().Handle then
                        local v = GetFruitSpawn().Handle
                        Tween(v.CFrame)
                    end
                end
            end
        end
    end
end)

Tab10:AddToggle({
    Name = "Auto Store DF",
    Default = Scibidi["Auto Store DF"],
    Callback = function(Value)
        Save("Auto Store DF", Value)
    end
})

function StoreFruit()
    for i, v in pairs(plr.Backpack:GetChildren()) do
        if string.find(v.Name, "Fruit") then
            local args = {
                [1] = "StoreFruit",
                [2] = v:GetAttribute("OriginalName"),
                [3] = v
            }
            RS:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
        end
    end
    for i, v in pairs(plr.Character:GetChildren()) do
        if string.find(v.Name, "Fruit") then
            local args = {
                [1] = "StoreFruit",
                [2] = v:GetAttribute("OriginalName"),
                [3] = v
            }
            RS:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
        end
    end
end

spawn(function()
    while wait() do
        if Scibidi["Auto Store DF"] then
            StoreFruit()
            if CheckNotification("Only") then
                for r, v in next, plr.PlayerGui.Notifications:GetChildren() do
                    if string.find(v.Text, "Only") then
                        v.Visible = false
                    end
                end
            end
        end
    end
end)

TableFruitSell = {}
for i,v in next,game.ReplicatedStorage:FindFirstChild("Remotes").CommF_:InvokeServer("GetFruits") do
    if v.OnSale then
        table.insert(TableFruitSell, v.Name)
    end
end

Tab10:AddDropdown({
    Name = "Fruits Sniper",
    Options = TableFruitSell,
    Default = Scibidi["Fruits Sniper"] or "Flame-Flame",
    Callback = function(Value)
        Save("Fruits Sniper", Value)
    end
})

Tab10:AddToggle({
    Name = "Auto Buy Snipe Fruit",
    Default = Scibidi["Auto Buy Snipe Fruit"],
    Callback = function(Value)
        Save("Auto Buy Snipe Fruit", Value)
    end
})

spawn(function()
    while wait() do
        if Scibidi["Auto Buy Snipe Fruit"] then
            RS.Remotes.CommF_:InvokeServer("GetFruits")
            RS.Remotes.CommF_:InvokeServer("PurchaseRawFruit", Scibidi["Fruits Sniper"], false)
        end
    end
end)

Tab10:AddSeperator("Raid")


Tab10:AddDropdown({
    Name = "Raid Chips",
    Options = {"Flame","Ice","Quake","Light","Dark","Spider","Rumble","Magma","Buddha","Sand","Phoenix","Dough"},
    Default = Scibidi["Raid Chips"] or "Flame",
    Callback = function(Value)
        Save("Raid Chips", Value)
    end
})

Tab10:AddToggle({
    Name = "Auto Raid",
    Default = Scibidi["Auto Raid"],
    Callback = function(Value)
        Save("Auto Raid", Value)
    end
})

function BuyChips()
    FireRemotes(2, "RaidsNpc", "Select", Scibidi["Raid Chips"])
end

function GetIslandRaid(Number)
    for r, v in next, workspace["_WorldOrigin"].Locations:GetChildren() do
        if v:IsA("Part") then
            if string.find(v.Name, Number) then
                if getdistance(v.Position) <= 2000 then
                    return v
                end
            end
        end
    end
end

function KillRaid()
    for _, v in next, workspace.Enemies:GetChildren() do
        if v.Humanoid.Health > 0 and v.Parent then
            repeat wait()
                v.Humanoid.Health = 0
                v.Humanoid:ChangeState(14)
                v.Head:Destroy()
                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
            until v.Humanoid.Health == 0 or not v.Head or not v.Parent
        end
    end
end

getgenv().Nigga = false
function AutoRaid()
    if not plr.PlayerGui.Main.Timer.Visible then
        if not CheckPlayerBackpack("Special Microchip") and getgenv().Nigga == false then
            BuyChips()
            IsRaid = false
            getgenv().Nigga = true
        elseif CheckPlayerBackpack("Special Microchip") and not IsRaid then
            getgenv().Nigga = true
            IsRaid = true
            if CheckSea(2) then
                fireclickdetector(workspace.Map.CircleIsland.RaidSummon2.Button.Main.ClickDetector)
            elseif CheckSea(3) then
                fireclickdetector(workspace.Map["Boat Castle"].RaidSummon2.Button.Main.ClickDetector)
            end
        end
    else
        IsRaid = true
        getgenv().Nigga = false
        spawn(function()
            pcall(function()
                KillRaid()
            end)
        end)
        if GetIslandRaid("5") then
            Tween(GetIslandRaid("5").CFrame * CFrame.new(0, 50, 0))
        elseif GetIslandRaid("4") then
            Tween(GetIslandRaid("4").CFrame * CFrame.new(0, 50, 0))
        elseif GetIslandRaid("3") then
            Tween(GetIslandRaid("3").CFrame * CFrame.new(0, 50, 0))
        elseif GetIslandRaid("2") then
            Tween(GetIslandRaid("2").CFrame * CFrame.new(0, 50, 0))
        elseif GetIslandRaid("1") then
            Tween(GetIslandRaid("1").CFrame * CFrame.new(0, 50, 0))
        end
    end
end

function AutoShitHuman()
    if RS.Remotes.CommF_:InvokeServer("BuySuperhuman", true) ~= 1 then
        if not CheckPlayerBackpack("Black Leg") and not CheckPlayerBackpack("Electro") and not CheckPlayerBackpack("Fishman Karate") and not CheckPlayerBackpack("Dragon Claw") and plr.Character.Humanoid.Health > 0 then
            wait(0.5)
            FireRemotes(2, "BuyBlackLeg")
        end
        if CheckPlayerBackpack("Black Leg") and DetectMeleeMastery("Black Leg", 300) then
            wait(0.5)
            FireRemotes(2, "BuyElectro")
        end
        if CheckPlayerBackpack("Electro") and DetectMeleeMastery("Electro", 300) then
            wait(0.5)
            FireRemotes(2, "BuyFishmanKarate")
        end
        if CheckPlayerBackpack("Fishman Karate") and DetectMeleeMastery("Fishman Karate", 300) then
            wait(0.5)
            if plr.Data.Fragments.Value >= 1500 or RS.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2", true) == 1 then
                FireRemotes(2, "BlackbeardReward", "DragonClaw", "2")
            elseif plr.Data.Fragments.Value < 1500 and RS.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2", true) ~= 1 then
                AutoRaid()
            end
        end
        if CheckPlayerBackpack("Dragon Claw") and DetectMeleeMastery("Dragon Claw", 300) then
            wait(0.5)
            FireRemotes(2, "BuySuperhuman")
            wait(0.2)
            FireRemotes(2, "BuyBlackLeg")
        end
    else
        FireRemotes(2, "BuySuperhuman")
    end
end

spawn(function()
    while task.wait() do
        if Scibidi["Auto Raid"] then
            AutoRaid()
        end
    end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------

function TweenTemple()
    if getdistance(Vector3.new(28282.5703125, 14896.8505859375, 105.1042709350586)) > 1500 then
        requestEntrance(Vector3.new(28282.5703125, 14896.8505859375, 105.1042709350586))
    end
end

function GreatTree()
    TweenTemple()
    wait(1)
    for r, v in next, NpcGame do
        if v.Name == "Mysterious Force3" then
            Npc = v
            wait(.1)
            Tween(Npc.HumanoidRootPart.CFrame)
            wait(1.5)
            if getdistance(Npc.HumanoidRootPart.Position) <= 15 then
                FireRemotes(2, "RaceV4Progress", "TeleportBack")
            end
        end
    end
end

function TweenAncient()
    TweenTemple()
    wait(1)
    for r, v in next, NpcGame do
        if v.Name == "Ancient One" then
            Npc = v
            wait(.1)
            Tween(Npc.HumanoidRootPart.CFrame)
        end
    end
end

TableRaceDoor = {}
for r, v in next, workspace:GetDescendants() do
    if string.find(v.Name, "Corridor") then
        table.insert(TableRaceDoor, v)
    end
end

function TweenCurrentRaceDoors()
    TweenTemple()
    wait(1)
    for r, v in next, TableRaceDoor do
        if string.find(v.Name, plr.Data.Race.Value) then
            Tween(v.Door.Door.RightDoor.Union.CFrame)
        end
    end
end

function AcientClock()
    TweenTemple()
    wait(1)
    Tween(game:GetService("Workspace")["_WorldOrigin"].Locations["Ancient Clock"].CFrame)
end

function BuyGear()
    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy")
end

Tab5:AddButton({
    Name = "Tween To Great Tree",
    Description = "Tween To Temple and ask to npc your i'll teleport to top great tree",
    Callback = function()
        GreatTree()
    end
})

Tab5:AddButton({
    Name = "Teleport Temple",
    Description = "",
    Callback = function()
        requestEntrance(Vector3.new(28282.5703125, 14896.8505859375, 105.1042709350586))
    end
})

Tab5:AddButton({
    Name = "Teleport Ancient",
    Description = "",
    Callback = function()
        TweenAncient()
    end
})

Tab5:AddButton({
    Name = "Tween Current Race Doors",
    Description = "",
    Callback = function()
        TweenCurrentRaceDoors()
    end
})

Tab5:AddButton({
    Name = "Tween Acient Clock",
    Description = "",
    Callback = function()
        AcientClock()
    end
})

Tab5:AddButton({
    Name = "Buy Gear",
    Description = "",
    Callback = function()
        BuyGear()
    end
})

local ToggleTrial = Tab5:AddToggle({
    Name = "Auto Trials",
    Description = "Auto Trial New Method",
    Default = Scibidi["Auto Trials"],
    Callback = function(Value)
        Save("Auto Trials", Value)
        if Value and plr.Data.Race.Value == "Fishman" then
            Library:AddNotify({
                Title = "Script Error",
                Content = "Auto Trial Now Not Support Fish Race!!!",
                Time = 7
            })
        end
    end
})

Tab5:AddToggle({
    Name = "Auto Upgrade Race",
    Description = "Auto Buy Gear For Trials",
    Default = Scibidi["Auto Upgrade Race"],
    Callback = function(Value)
        Save("Auto Upgrade Race", Value)
    end
})

spawn(function()
    while wait() do
        if Scibidi["Auto Upgrade Race"] then
            BuyGear()
        end
    end
end)

CompleteTrial = false
StopTweenDoor = false
spawn(function()
    while task.wait() do
        if CheckNotification("All trials have been completed!") then
            CompleteTrial = true
        end
        if CheckNotification("5") then
            StopTweenDoor = true
        end
    end
end)

function AutoTrials()
    if CompleteTrial then
        ToggleTrial:Set(false)
        SpamSkills = false
        AimSkills = false
        return 
    end
    if CompleteTrial and not plr.PlayerGui.Main.Timer.Visible then
        CompleteTrial = false
    end
    if plr.PlayerGui.Main.Timer.Visible then
        if plr.Data.Race.Value == "Cyborg" then
            if getdistance(CFrame.new(-20021.8691, 10090.4893, -16.3799).Position) <= 1500 then
                Tween(CFrame.new(-20021.8691, 10090.4893, -16.3799))
            end
        elseif plr.Data.Race.Value == "Mink" then
            for r, v in next, game.Workspace:GetDescendants() do
                if string.find(v.Name, "StartPoint") then
                    if getdistance(v.Position) <= 1500 then
                        Tween(v.CFrame)
                    end
                end
            end
        elseif plr.Data.Race.Value == "Skypiea" then
            local tngoiday2tiengroi = game:GetService("Workspace").Map.SkyTrial.Model.FinishPart
            if getdistance(tngoiday2tiengroi.Position) <= 2500 then
                wait(2)
                tween(tngoiday2tiengroi.CFrame)
            end
        elseif plr.Data.Race.Value == "Fishman" then
            for r, v in next, game.Workspace.SeaBeasts:GetChildren() do
                if string.find(v.Name, "SeaBeast") and v:FindFirstChild("HumanoidRootPart") and getdistance(v.HumanoidRootPart.Position) <= 1500 then
                    repeat wait()
                        Tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 400, 0))  
                        SpamSkills = true
                        AimSkills = v.HumanoidRootPart.Position
                    until plr.PlayerGui.Main.Timer.Visible == false or not Scibidi["Auto Trials"] or v.Humanoid.Health <= 0 or not v.Parent
                    SpamSkills = false
                    AimSkills = nil
                end
            end
        elseif plr.Data.Race.Value == "Human" then
            for r, v in next, game.Workspace.Enemies:GetChildren() do
                if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and v.Parent then
                    repeat wait()
                        KillRaid()
                        EquipWeapon()
                        Tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                    until plr.PlayerGui.Main.Timer.Visible == false or not Scibidi["Auto Trials"] or v.Humanoid.Health <= 0 or not v.Parent
                end
            end
        end
    elseif not CompleteTrial and not StopTweenDoor and not plr.PlayerGui.Main.Timer.Visible then
        TweenCurrentRaceDoors()
    end
end

spawn(function()
    while task.wait() do
        if Scibidi["Auto Trials"] and CheckSea(3) then
            AutoTrials()
        end
    end
end)

Tab5:AddToggle({
    Name = "Auto Kill Players After Trial <Wait Fix>",
    Description = "[NEW]",
    Settings = true,
    Default = Scibidi["Auto Kill Players After Trial"],
    Callback = function(Value)
        Save("Auto Kill Players After Trial", Value)
    end
})

spawn(function()
    while task.wait() do
        if Scibidi["Auto Kill Players After Trial"] and CheckSea(3) then
            pcall(function()
                for r, v in next, game.Workspace.Characters:GetChildren() do
                    if plr.PlayerGui.Main.Timer.Visible == true and v.Parent and v.Humanoid.Health > 0 and getdistance(v.HumanoidRootPart.Position) <= 350 and (v.HumanoidRootPart.Position - CFrame.new(8722.4707, 14887.5361, -95.0011368)) <= 350 and CanKillTrial then
                        repeat task.wait()
                            EquipWeapon()
                            EBuso()
                            Tween(v.HumanoidRootPart.CFrame * CFrame.new(0, 9, 5))
                            EnableKen()
                        until v.Humanoid.Health <= 0 or not v.Parent or not v.Humanoid or Scibidi["Auto Kill Players After Trial"] == false
                    end
                end
            end)
        end
    end
end)
print"Success"
----------------------------------------------------------------------------------------------------------------------------------------------------------------
