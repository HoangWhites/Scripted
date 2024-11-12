if not Config or Config == nil then
    Config = {
        ["Team"] = "Pirates",
        ["Settings"] = {
            ["Auto Awakening Race"] = true,
            ["Bounty Locked"] = {
                ["Value"] = 3000000,
                ["Enalbed"] = true,
            },
            ["Panic Mode"] = {true, 3000, 4000},
            ["Skip Race V4"] = true,
            ["Fruit Skip"] = {
                "Portal-Portal",
                "Leopard-Leopard",
                "Kitsune-Kitsune",
                "Chop-Chop",
                "Nigger-Nigger"
            },
            ["Camera Mode"] = {
                ["Specated"] = true,
                ["Lock"] = true
            },
            ["Ultra Gun Gay Mode"] = {
                ["Enalbed Click Gun"] = true, -- Beta
                ["Enemy Health"] = 2000
            },
        },
        ["Weapon"] = {
            ["Melee"] = {
                ["Enable"] = true,
                ["Z"] = {
                    ["Enable"] = true,
                    ["Hold"] = 0
                },
                ["X"] = {
                    ["Enable"] = true,
                    ["Hold"] = 0
                },
                ["C"] = {
                    ["Enable"] = true,
                    ["Hold"] = 0
                },
            },
            ["Sword"] = {
                ["Enable"] = true,
                ["Z"] = {
                    ["Enable"] = true,
                    ["Hold"] = 1.2
                },
                ["X"] = {
                    ["Enable"] = true,
                    ["Hold"] = 0.5
                },
            },
            ["Gun"] = {
                ["Enable"] = false,
                ["Z"] = {
                    ["Enable"] = true,
                    ["Hold"] = 0
                },
                ["X"] = {
                    ["Enable"] = true,
                    ["Hold"] = 0
                },
            },
            ["Blox Fruit"] = {
                ["Enable"] = false,
                ["Z"] = {
                    ["Enable"] = true,
                    ["Hold"] = 0
                },
                ["X"] = {
                    ["Enable"] = true,
                    ["Hold"] = 0
                },
                ["C"] = {
                    ["Enable"] = false,
                    ["Hold"] = 0
                },
                ["V"] = {
                    ["Enable"] = false,
                    ["Hold"] = 0
                },
                ["F"] = {
                    ["Enable"] = false,
                    ["Hold"] = 0
                },
            },
        },
    }
end

repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players
repeat task.wait() until game.Players.LocalPlayer

repeat wait()
    pcall(function() 
        for i, v in pairs(getconnections(game.Players.LocalPlayer.PlayerGui.Main.ChooseTeam.Container[Config["Team"]].Frame.TextButton.Activated)) do
            v.Function()
        end 
    end) 
until tostring(game.Players.LocalPlayer.Team) == Config.Team

local plr = game.Players.LocalPlayer
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

function GetWeaponType(cc)
    for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") and v.ToolTip == cc then
            return v.Name
        end
    end
    for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v:IsA("Tool") and v.ToolTip == cc then
            return v.Name
        end
    end
end

ToolName = ""
function EquipTool(toolname)
    for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") and tostring(v) == toolname or v.ToolTip == toolname then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
            ToolName = tostring(v)
        end
    end
end

function GetSkillsByWeapon()
    v2 = game.Players.LocalPlayer.PlayerGui.Main.Skills
    for _, v in next, Config.Weapon do
        if v.Enable and not string.find(plr.Data.DevilFruit.Value, "Buddha") and not string.find(plr.Data.DevilFruit.Value, "Portal") then
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

enemytable = {}
function GetEnemy()
    cucac = {}
    for _, v in next, game.Players:GetPlayers() do
        if v.Name ~= game.Players.LocalPlayer.Name and v.Character and v.Parent then
            if v.Character.Humanoid.Health > 0 and v.Character:FindFirstChild("HumanoidRootPart") then
                for a, b in next, Config["Settings"]["Fruit Skip"] do
                    if v.Data.DevilFruit.Value ~= tostring(a) then
                        if v.Character.Humanoid.Sit == false and v.Data.Race.Value ~= "Mink" and v.Data.Race.Value ~= "Cyborg" then
                            if not table.find(cucac, v) and not table.find(enemytable, v) then
                                table.insert(cucac, v)
                            end
                        end
                    end
                end
            end    
        end
    end
    return cucac
end
Hop = false
function FindNewEnemy()
    dist, targetselected = math.huge, nil
    for _, v in next, GetEnemy() do
        if v.Character and v.Parent and v.Character:FindFirstChild("Head") and v.Character:FindFirstChild("Humanoid").Health > 0 and v.Character:FindFirstChild("HumanoidRootPart") then
            for i, a in next, NPCBypass do
                if v:DistanceFromCharacter(a.p) <= 2500 then
                    if (v.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude < dist then
                        targetselected = v
                        dist = (v.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude
                    end
                end
            end
        end
    end
    if targetselected ~= nil then
        enemy = targetselected
        table.insert(enemytable, targetselected)
    else
        Hop = true
    end
end

spawn(function()
    local gg = getrawmetatable(game)
    local old = gg.__namecall
    setreadonly(gg, false)
    gg.__namecall = newcclosure(function(...)
        local method = getnamecallmethod()
        local args = {...}
        if tostring(method) == "FireServer" then
            if tostring(args[1]) == "RemoteEvent" then
                if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
                    if enemy and enemy and enemy.Character.HumanoidRootPart then
                        args[2] = enemy.Character.HumanoidRootPart.Position
                        return old(unpack(args))
                    end
                end
            end
        end
        return old(...)
    end)
end)

function checknotify(aa)
    for r, v in pairs(plr.PlayerGui.Notifications:GetChildren()) do
        if v and v.Text and string.find(string.lower(v.Text), aa) then
            return true
        end
    end
    return false
end

function BigHitbox() 
    pcall(function()
        local old = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
        local com = getupvalue(old, 2)
        com.activeController.hitboxMagnitude = 6000
    end) 
end

function NoStun() 
    for _, v in game.Players.LocalPlayer.Character.HumanoidRootPart:GetChildren() do 
        if v.Name == "BodyGyro" or v.Name == "BodyPosition" then 
            v:Destroy() 
        end 
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
    TableEntrances = {
        Vector3.new(-5058.77490234375, 314.5155029296875, -3155.8833078125),
        Vector3.new(5756.83740234375, 610.4240112304688, -253.9253692626953),
        Vector3.new(-12463.8740234375, 374.9144592285156, -7523.77392578125),
        Vector3.new(28282.5703125, 14896.8505859375, 105.1042709350586),
        Vector3.new(-11993.58078125, 334.7812805175781, -8844.1826171875),
        Vector3.new(5314.58203125, 25.419387817382812, -125.94227600097656)
    }
elseif CheckSea(2) then
    TableEntrances = {
        Vector3.new(-288.46246337890625, 306.130615234375, 597.9988403320312),
        Vector3.new(2284.912109375, 15.152046203613281, 905.48291015625),
        Vector3.new(923.21252441406, 126.9760055542, 32852.83203125),
        Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422)
    }
elseif CheckSea(1) then
    TableEntrances = {
        Vector3.new(-7894.6201171875, 5545.49169921875, -380.2467346191406),
        Vector3.new(-4607.82275390625, 872.5422973632812, -1667.556884765625),
        Vector3.new(61163.8515625, 11.759522438049316, 1819.7841796875),
        Vector3.new(3876.280517578125, 35.10614013671875, -1939.3201904296875)
    }
end

function GetPortal(nig)
    ccp = nig.Position
    dist = math.huge
    vec = Vector3.new(0, 0, 0)
    for r, v in next, TableEntrances do
        local distance = (v - ccp).Magnitude
        if distance < dist and vec ~= v then
            dist = distance
            vec = v
        end
    end
    return vec
end

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

local plr = game.Players.LocalPlayer
function CheckInComBat()
    return plr.PlayerGui.Main.InCombat.Visible and plr.PlayerGui.Main.InCombat.Text and (string.find(string.lower(plr.PlayerGui.Main.InCombat.Text),"risk"))
end 

function bypass(Pos)
    if canthop == true then return end
    wait(.5)
    pcall(function()
        repeat
            task.wait()
            tween:Cancel()
            if plr.Character:FindFirstChild("Nigger") then
                plr.Character:FindFirstChild("Nigger").CFrame = GetBypassCFrame(Pos)
            end
            game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid"):ChangeState(15)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = GetBypassCFrame(Pos)
        until game.Players.LocalPlayer.Character.PrimaryPart.CFrame == GetBypassCFrame(Pos) or canthop == true
        game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid", 9):ChangeState(15)
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(GetBypassCFrame(Pos))
        wait(0.1)
        game.Players.LocalPlayer.Character.Head:Destroy()
        repeat
            task.wait()
        until game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health <= 0
        repeat
            task.wait()
        until game.Players.LocalPlayer.Character:FindFirstChild("Head")
        wait(0.5)
    end)
end

function requestEntrance(b)
    args = {"requestEntrance", b}
    game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
    if plr.Character:FindFirstChild("Nigger") then
        plr.Character:FindFirstChild("Nigger").CFrame = plr.Character.HumanoidRootPart.CFrame
    end
    task.wait(.2)
end
canthop = false
function to(TargetCFrame)
    local dist = (TargetCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    local tweenservice = game:GetService("TweenService")
    local info = TweenInfo.new(dist / 325, Enum.EasingStyle.Linear)
    local Portal = GetPortal(TargetCFrame)
    tween = tweenservice:Create(plr.Character.HumanoidRootPart, info, {CFrame = TargetCFrame})
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X, TargetCFrame.Y, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z)
    if not game.Players.LocalPlayer.Character.Head:FindFirstChild("cac") then
        local buu = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character.Head)
        buu.Velocity = Vector3.new(0, 0, 0)
        buu.P = 1500
        buu.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        buu.Name = "cac"
    end
    for i, v in pairs(plr.Character:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CanCollide = false
        end
    end
    if plr.Character.Humanoid.Sit == true then
        plr.Character.Humanoid.Sit = false
    end
    if dist > 2500 and Portal then
        requestEntrance(Portal)
    end
    if (TargetCFrame.Position - plr.Character.HumanoidRootPart.Position).Magnitude >= 3000 then
        bypass(TargetCFrame)
    end
    if Portal and (plr.Character.HumanoidRootPart.Position - TargetCFrame.p).Magnitude > (TargetCFrame.p - Portal).Magnitude then
        if dist >= 3500 then
            tween:Cancel()
            requestEntrance(Portal)
        end
    end
    tween:Play()
end

function HopSivi() 
    function bQ(v)
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
        bQ(v) 
    end
    game.CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(bQ)
    
    while wait() do
    canthop = true
        plr.Character.HumanoidRootPart.CFrame = CFrame.new(0, math.random(9999, 99999), 0)
        if not CheckInComBat() then
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
end

function FireRemotes(number, ...)
    arg = ({"CommF_", "Redeem"})[number]
    return game:GetService("ReplicatedStorage").Remotes[arg]:InvokeServer(unpack({...}))
end

function EnableV4()
    if plr.Character and plr.Character:FindFirstChild("RaceTransformed") and plr.Character:FindFirstChild("RaceEnergy") and plr.Character.RaceEnergy.Value >= 1 and not plr.Character.RaceTransformed.Value then
        SendKey("Y", 0)
    end
end

MathRandom = 1
spawn(function()
    while task.wait() do 
        MathRandom = math.random(1,5)
    end
end)

spawn(function()
    while wait() do
        if MathRandom == 1 then
            PosHunt = CFrame.new(0, 12, 10)
        elseif MathRandom == 2 then
            PosHunt = CFrame.new(0, 12, -10)
        elseif MathRandom == 3 then
            PosHunt = CFrame.new(10, 12, 0)
        elseif MathRandom == 4 then
            PosHunt = CFrame.new(0, 12, -10)
        elseif MathRandom == 5 then
            PosHunt = CFrame.new(-10, 12, 0)
        else
            PosHunt = CFrame.new(0, 12, 10)
        end
    end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------

local BountyGUI = Instance.new("ScreenGui")
local MainBounty = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local DropShadowHolder = Instance.new("Frame")
local DropShadow = Instance.new("ImageLabel")
local IconPlayer = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")
local IconPlayer_2 = Instance.new("ImageLabel")
local UICorner_3 = Instance.new("UICorner")
local PlayersName = Instance.new("TextLabel")
local Time = Instance.new("TextLabel")
local ClientTime = Instance.new("TextLabel")
local Earned = Instance.new("TextLabel")
local TotalEarned = Instance.new("TextLabel")
local Hop = Instance.new("Frame")
local UICorner_4 = Instance.new("UICorner")
local nigga = Instance.new("TextButton")
local aaaa = Instance.new("TextLabel")
local NextPlayers = Instance.new("Frame")
local UICorner_5 = Instance.new("UICorner")
local aaaa_2 = Instance.new("TextLabel")
local nigga_2 = Instance.new("TextButton")
local uuu = Instance.new("Frame")
local _1 = Instance.new("Frame")
local UICorner_6 = Instance.new("UICorner")
local _2 = Instance.new("Frame")
local UICorner_7 = Instance.new("UICorner")
local UIclose = Instance.new("Frame")
local UICorner_8 = Instance.new("UICorner")
local UIStroke_2 = Instance.new("UIStroke")
local Logo = Instance.new("ImageLabel")
local UICorner_9 = Instance.new("UICorner")
local aaaaa = Instance.new("TextButton")
local TweenService = game:GetService("TweenService")
local uis = game:GetService("UserInputService")
makedraggable = function (topbar, object)
	local Dragging = false
	local DragInput = nil
	local DragStart = nil
	local PositionStart = nil

	local function Update(input)
		local Delta = input.Position - DragStart
		local newPos = UDim2.new(
			PositionStart.X.Scale,
			PositionStart.X.Offset + Delta.X,
			PositionStart.Y.Scale,
			PositionStart.Y.Offset + Delta.Y
		)
		object.Position = newPos
	end

	topbar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			Dragging = true
			DragStart = input.Position
			PositionStart = object.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					Dragging = false
				end
			end)
		end
	end)

	topbar.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			DragInput = input
		end
	end)

	uis.InputChanged:Connect(function(input)
		if input == DragInput and Dragging then
			Update(input)
		end
	end)
end

BountyGUI.Name = "BountyGUI"
BountyGUI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

MainBounty.Name = "Main Bounty"
MainBounty.Parent = BountyGUI
MainBounty.AnchorPoint = Vector2.new(0.5, 0.5)
MainBounty.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
MainBounty.BorderColor3 = Color3.fromRGB(0, 0, 0)
MainBounty.BorderSizePixel = 0
MainBounty.Position = UDim2.new(0.5, 0, 0.5, 0)
MainBounty.Size = UDim2.new(0 ,0, 0 ,0)
MainBounty.ClipsDescendants = true
TweenService:Create(MainBounty, TweenInfo.new(1.5, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 300, 0, 200)}):Play()

UICorner.CornerRadius = UDim.new(0, 6)
UICorner.Parent = MainBounty

DropShadowHolder.Name = "DropShadowHolder"
DropShadowHolder.Parent = MainBounty
DropShadowHolder.BackgroundTransparency = 1.000
DropShadowHolder.BorderSizePixel = 0
DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
DropShadowHolder.ZIndex = 0

DropShadow.Name = "DropShadow"
DropShadow.Parent = DropShadowHolder
DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
DropShadow.BackgroundTransparency = 1.000
DropShadow.BorderSizePixel = 0
DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
DropShadow.Size = UDim2.new(1, 47, 1, 47)
DropShadow.ZIndex = 0
DropShadow.Image = "rbxassetid://6015897843"
DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
DropShadow.ImageTransparency = 0.500
DropShadow.ScaleType = Enum.ScaleType.Slice
DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

IconPlayer.Name = "IconPlayer"
IconPlayer.Parent = MainBounty
IconPlayer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
IconPlayer.BackgroundTransparency = 1.000
IconPlayer.BorderColor3 = Color3.fromRGB(0, 0, 0)
IconPlayer.BorderSizePixel = 0
IconPlayer.Position = UDim2.new(0.620000005, 0, 0.0649999976, 0)
IconPlayer.Size = UDim2.new(0, 100, 0, 100)

UICorner_2.CornerRadius = UDim.new(1, 0)
UICorner_2.Parent = IconPlayer

UIStroke.Parent = IconPlayer
UIStroke.Color = Color3.fromRGB(255, 255, 255)
UIStroke.Transparency = 0.960
UIStroke.Thickness = 1.500

IconPlayer_2.Name = "IconPlayer"
IconPlayer_2.Parent = IconPlayer
IconPlayer_2.AnchorPoint = Vector2.new(0.5, 0.5)
IconPlayer_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
IconPlayer_2.BackgroundTransparency = 1.000
IconPlayer_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
IconPlayer_2.BorderSizePixel = 0
IconPlayer_2.Position = UDim2.new(0.5, 0, 0.5, 0)
IconPlayer_2.Size = UDim2.new(1, -1, 1, -1)
IconPlayer_2.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="..game:GetService("Players").LocalPlayer.UserId .."&width=420&height=420&format=png" or getgenv().PlayersLogo

UICorner_3.CornerRadius = UDim.new(1, 0)
UICorner_3.Parent = IconPlayer_2

PlayersName.Name = "PlayersName"
PlayersName.Parent = IconPlayer
PlayersName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PlayersName.BackgroundTransparency = 1.000
PlayersName.BorderColor3 = Color3.fromRGB(0, 0, 0)
PlayersName.BorderSizePixel = 0
PlayersName.Position = UDim2.new(-0.5, 0, 0.910000026, 0)
PlayersName.Size = UDim2.new(0, 200, 0, 50)
PlayersName.Font = Enum.Font.GothamBold
PlayersName.Text = "Gay"
PlayersName.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayersName.TextSize = 13.000

Time.Name = "Time"
Time.Parent = MainBounty
Time.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Time.BackgroundTransparency = 1.000
Time.BorderColor3 = Color3.fromRGB(0, 0, 0)
Time.BorderSizePixel = 0
Time.Position = UDim2.new(0.023, 9, 0, 24)
Time.Size = UDim2.new(0, 200, 0, 30)
Time.Font = Enum.Font.GothamBold
Time.Text = "Time Elapsed : 0H 0M 0S"
Time.TextColor3 = Color3.fromRGB(255, 255, 255)
Time.TextSize = 12.000
Time.TextXAlignment = Enum.TextXAlignment.Left
function getElapsedTime(startTime)
    local elapsedTime = tick() - startTime
    local hours = math.floor(elapsedTime / 3600)
    local minutes = math.floor((elapsedTime % 3600) / 60)
    local seconds = elapsedTime % 60

    return string.format("%dH %dM %dS", hours, minutes, seconds)
end
startTime = tick()
game:GetService("RunService").Stepped:Connect(function()
    Time.Text = "Time Elapsed : " ..getElapsedTime(startTime)
end)

ClientTime.Name = "ClientTime"
ClientTime.Parent = MainBounty
ClientTime.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ClientTime.BackgroundTransparency = 1.000
ClientTime.BorderColor3 = Color3.fromRGB(0, 0, 0)
ClientTime.BorderSizePixel = 0
ClientTime.Position = UDim2.new(0.0233333334, 9, 0.270000011, 0)
ClientTime.Size = UDim2.new(0, 200, 0, 30)
ClientTime.Font = Enum.Font.GothamBold
ClientTime.Text = "Current Bounty : 0"
ClientTime.TextColor3 = Color3.fromRGB(255, 255, 255)
ClientTime.TextSize = 12.000
ClientTime.TextXAlignment = Enum.TextXAlignment.Left
game:GetService("RunService").Stepped:Connect(function()
    ClientTime.Text = "Current Bounty : " ..game.Players.LocalPlayer.leaderstats["Bounty/Honor"].Value 
end)

Earned.Name = "Earned"
Earned.Parent = MainBounty
Earned.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Earned.BackgroundTransparency = 1.000
Earned.BorderColor3 = Color3.fromRGB(0, 0, 0)
Earned.BorderSizePixel = 0
Earned.Position = UDim2.new(0.0233333334, 9, 0.425000012, 0)
Earned.Size = UDim2.new(0, 200, 0, 30)
Earned.Font = Enum.Font.GothamBold
Earned.Text = "Earned : 0"
Earned.TextColor3 = Color3.fromRGB(255, 255, 255)
Earned.TextSize = 12.000
Earned.TextXAlignment = Enum.TextXAlignment.Left

TotalEarned.Name = "Total Earned"
TotalEarned.Parent = MainBounty
TotalEarned.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TotalEarned.BackgroundTransparency = 1.000
TotalEarned.BorderColor3 = Color3.fromRGB(0, 0, 0)
TotalEarned.BorderSizePixel = 0
TotalEarned.Position = UDim2.new(0.0233333334, 9, 0.574999988, 0)
TotalEarned.Size = UDim2.new(0, 200, 0, 30)
TotalEarned.Font = Enum.Font.GothamBold
TotalEarned.Text = "Total Earned : 0"
TotalEarned.TextColor3 = Color3.fromRGB(255, 255, 255)
TotalEarned.TextSize = 12.000
TotalEarned.TextXAlignment = Enum.TextXAlignment.Left

Hop.Name = "Hop"
Hop.Parent = MainBounty
Hop.BackgroundColor3 = Color3.fromRGB(58, 58, 58)
Hop.BorderColor3 = Color3.fromRGB(0, 0, 0)
Hop.BorderSizePixel = 0
Hop.Position = UDim2.new(0.0500000007, 0, 0.769999981, 0)
Hop.Size = UDim2.new(0, 100, 0, 31)

UICorner_4.CornerRadius = UDim.new(0, 6)
UICorner_4.Parent = Hop

nigga.Name = "nigga"
nigga.Parent = Hop
nigga.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
nigga.BackgroundTransparency = 1.000
nigga.BorderColor3 = Color3.fromRGB(0, 0, 0)
nigga.BorderSizePixel = 0
nigga.Size = UDim2.new(1, 0, 1, 0)
nigga.Font = Enum.Font.SourceSans
nigga.Text = ""
nigga.TextColor3 = Color3.fromRGB(0, 0, 0)
nigga.TextSize = 14.000
nigga.Activated:Connect(function()
    Hop.BackgroundColor3 = Color3.fromRGB(85, 85, 85)
    TweenService:Create(Hop, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(58, 58, 58)}):Play()
    HopSivi() 
end)

aaaa.Name = "aaaa"
aaaa.Parent = Hop
aaaa.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
aaaa.BackgroundTransparency = 1.000
aaaa.BorderColor3 = Color3.fromRGB(0, 0, 0)
aaaa.BorderSizePixel = 0
aaaa.Size = UDim2.new(1, 0, 1, 0)
aaaa.Font = Enum.Font.GothamBold
aaaa.Text = "Hop Servers"
aaaa.TextColor3 = Color3.fromRGB(255, 255, 255)
aaaa.TextSize = 13.000

NextPlayers.Name = "Next Players"
NextPlayers.Parent = MainBounty
NextPlayers.BackgroundColor3 = Color3.fromRGB(58, 58, 58)
NextPlayers.BorderColor3 = Color3.fromRGB(0, 0, 0)
NextPlayers.BorderSizePixel = 0
NextPlayers.Position = UDim2.new(0.616666675, 0, 0.769999981, 0)
NextPlayers.Size = UDim2.new(0, 100, 0, 31)

UICorner_5.CornerRadius = UDim.new(0, 6)
UICorner_5.Parent = NextPlayers

aaaa_2.Name = "aaaa"
aaaa_2.Parent = NextPlayers
aaaa_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
aaaa_2.BackgroundTransparency = 1.000
aaaa_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
aaaa_2.BorderSizePixel = 0
aaaa_2.Size = UDim2.new(1, 0, 1, 0)
aaaa_2.Font = Enum.Font.GothamBold
aaaa_2.Text = "Next Players"
aaaa_2.TextColor3 = Color3.fromRGB(255, 255, 255)
aaaa_2.TextSize = 13.000

nigga_2.Name = "nigga"
nigga_2.Parent = NextPlayers
nigga_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
nigga_2.BackgroundTransparency = 1.000
nigga_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
nigga_2.BorderSizePixel = 0
nigga_2.Size = UDim2.new(1, 0, 1, 0)
nigga_2.Font = Enum.Font.SourceSans
nigga_2.Text = ""
nigga_2.TextColor3 = Color3.fromRGB(0, 0, 0)
nigga_2.TextSize = 14.000
nigga_2.Activated:Connect(function()
    NextPlayers.BackgroundColor3 = Color3.fromRGB(85, 85, 85)
    TweenService:Create(NextPlayers, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(58, 58, 58)}):Play()
    FindNewEnemy()
end)

uuu.Name = "uuu"
uuu.Parent = MainBounty
uuu.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
uuu.BackgroundTransparency = 1.000
uuu.BorderColor3 = Color3.fromRGB(0, 0, 0)
uuu.BorderSizePixel = 0
uuu.ClipsDescendants = true
uuu.Size = UDim2.new(1, 0, 1, 0)

_1.Name = "1"
_1.Parent = uuu
_1.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
_1.BorderColor3 = Color3.fromRGB(0, 0, 0)
_1.BorderSizePixel = 0
_1.Position = UDim2.new(-0.166666672, 0, -0.119999997, 0)
_1.Size = UDim2.new(0, 200, 0, 272)
wait(0.5)
TweenService:Create(_1, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {Position = UDim2.new(-1, 22, -0.119999997, 0)}):Play()
TweenService:Create(_2, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {Position = UDim2.new(1, 22, -0.119999997, 0)}):Play()
UICorner_6.CornerRadius = UDim.new(0, 6)
UICorner_6.Parent = _1

_2.Name = "2"
_2.Parent = uuu
_2.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
_2.BorderSizePixel = 0
_2.Position = UDim2.new(0.5, 0, -0.119999997, 0)
_2.Size = UDim2.new(0, 133, 0, 272)
UICorner_7.CornerRadius = UDim.new(0, 6)
UICorner_7.Parent = _2

UIclose.Name = "UIclose"
UIclose.Parent = BountyGUI
UIclose.BackgroundColor3 = Color3.fromRGB(20, 18, 19)
UIclose.BorderColor3 = Color3.fromRGB(0, 0, 0)
UIclose.BorderSizePixel = 0
UIclose.Position = UDim2.new(0.226027399, 0, 0.235772356, 0)
UIclose.Size = UDim2.new(0, 30, 0, 30)

UICorner_8.CornerRadius = UDim.new(1, 0)
UICorner_8.Parent = UIclose

UIStroke_2.Parent = UIclose
UIStroke_2.Color = Color3.fromRGB(255, 255, 255)
UIStroke_2.Transparency = 0.770

Logo.Name = "Logo"
Logo.Parent = UIclose
Logo.AnchorPoint = Vector2.new(0.5, 0.5)
Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Logo.BackgroundTransparency = 1.000
Logo.BorderColor3 = Color3.fromRGB(0, 0, 0)
Logo.BorderSizePixel = 0
Logo.Position = UDim2.new(0.5, 0, 0.5, 0)
Logo.Size = UDim2.new(1, -3, 1, -3)
Logo.Image = "http://www.roblox.com/asset/?id=118645841061849"

UICorner_9.CornerRadius = UDim.new(1, 0)
UICorner_9.Parent = Logo

aaaaa.Name = "aaaaa"
aaaaa.Parent = UIclose
aaaaa.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
aaaaa.BackgroundTransparency = 1.000
aaaaa.BorderColor3 = Color3.fromRGB(0, 0, 0)
aaaaa.BorderSizePixel = 0
aaaaa.Size = UDim2.new(1, 0, 1, 0)
aaaaa.Font = Enum.Font.SourceSans
aaaaa.Text = ""
aaaaa.TextColor3 = Color3.fromRGB(0, 0, 0)
aaaaa.TextSize = 14.000

function SaveSettings()
    HttpService = game:GetService("HttpService")
    if not isfolder("Whites Hub") then
        makefolder("Whites Hub")
    end
    writefile("Whites Hub".."/" .. plr.Name .. " - AutoBounty.json", HttpService:JSONEncode(_G))
end

function Read()
    local c, AC = pcall(function()
        if not isfolder("Whites Hub") then
            makefolder("Whites Hub")
        end
        return game:GetService("HttpService"):JSONDecode(readfile("Whites Hub".."/" .. plr.Name .. " - AutoBounty.json"))
    end)
    if c then return AC
    else
        SaveSettings()
        return Read()
    end
end
_G.Total = 0
Read()
makedraggable(MainBounty, MainBounty)
Bounty = game.Players.LocalPlayer.leaderstats["Bounty/Honor"].Value 
spawn(function()
    while task.wait() do
        local OldEarned = Bounty
        local NewBounty = game.Players.LocalPlayer.leaderstats["Bounty/Honor"].Value 
        EarnedValue = NewBounty - OldEarned
        Earned.Text = "Earned : " .. EarnedValue
        TotalEarned.Text = "Total Earned : " .. _G.Total + EarnedValue
    end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------

local lastCombatTime = tick()
local Nguvai = tick()
function GaySec()
    while task.wait() do
        if Hop == true then
            HopSivi()
        else
            if plr:FindFirstChild("PlayerGui") and plr.PlayerGui:FindFirstChild("ScreenGui") and plr.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
            else
                game:service("VirtualUser"):CaptureController()
                game:service("VirtualUser"):SetKeyDown("0x65")
                game:service("VirtualUser"):SetKeyUp("0x65")
                wait(.3)
            end 
            BigHitbox()
            NoStun()
            EnableV4()
            plr.Character:SetAttribute("DashLength", 100)
            if not enemy or not enemy.Parent or enemy.Character.Humanoid.Health <= 0 or not enemy.Character.Head then
                FindNewEnemy()
            end
            if (checknotify("died") or checknotify("player") or checknotify("Safe") or checknotify("zone")) and (enemy.Character.Head.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 20 then
                FindNewEnemy()
            end 
            if Config["Settings"]["Camera Mode"]["Specated"] then 
                workspace.CurrentCamera.CameraSubject = enemy.Character 
            else 
                workspace.CurrentCamera.CameraSubject = plr.Character 
            end 
            if not plr.Character:FindFirstChild("HasBuso") then
                FireRemotes(1, "Buso")
            end
            if plr.PlayerGui.Main.BottomHUDList.SafeZone.Visible and enemy:DistanceFromCharacter(plr.Character.Head.Position) <= 100 then
                FindNewEnemy()
            end
            if enemy:DistanceFromCharacter(plr.Character.Head.Position) < 100 and tick() - Nguvai >= 15 then
                FindNewEnemy()
                Nguvai = tick()
            end
            if Config["Settings"]["Camera Mode"]["Lock"] == true then
                game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, enemy.Character.HumanoidRootPart.Position)
            end
            if plr.PlayerGui.Main.PvpDisabled.Visible then
                FireRemotes(1, "EnablePvp")
            end 
            if plr.Character.Humanoid.Health < Config["Settings"]["Panic Mode"][2] and plr.Character.Humanoid.Health < Config["Settings"]["Panic Mode"][3] and Config["Settings"]["Panic Mode"][1] then
                plr.Character.HumanoidRootPart.CFrame = enemy.Character.HumanoidRootPart.CFrame * CFrame.new(0, math.random(9999, 99999), 0)
            elseif ((plr.Character.Humanoid.Health > Config["Settings"]["Panic Mode"][2] and plr.Character.Humanoid.Health > Config["Settings"]["Panic Mode"][3] and Config["Settings"]["Panic Mode"][1]) or (not Config["Settings"]["Panic Mode"][1])) then 
                if (enemy.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude >= 150 then
                    to(enemy.Character.HumanoidRootPart.CFrame * CFrame.new(0, 25, 0))
                else
                    if GetSkillsByWeapon() then
                        local concac = GetSkillsByWeapon()
                        EquipTool(concac[1])
                        SendKey(concac[2], concac[2][4])
                    else
                        if enemy.Character.Humanoid.Health >= 3000 then
                            game:GetService("VirtualUser"):CaptureController()
                            game:GetService("VirtualUser"):Button1Down(Vector2.new(0,1,0,1))
                        end
                    end
                    to(enemy.Character.HumanoidRootPart.CFrame * PosHunt)
                end
            end
            lastCombatTime = tick()
            if tick() - lastCombatTime >= 15 then
                FindNewEnemy()
                lastCombatTime = tick()
            end
        end
    end
end
GaySec()
