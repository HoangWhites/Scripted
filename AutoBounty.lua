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

repeat wait() -- muahahahahahahah
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

enemytable = {}
function GetEnemy()
    cucac = {}
    for _, v in next, game.Players:GetPlayers() do
        if v.Name ~= game.Players.LocalPlayer.Name and v.Character and v.Parent then
            if v.Character.Humanoid.Health > 0 and v.Character:FindFirstChild("HumanoidRootPart") then
                for a, b in next, Config["Settings"]["Fruit Skip"] do
                    if v.Data.DevilFruit.Value ~= tostring(v) then
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

local FPS = Instance.new("ScreenGui")
local CountFPS = Instance.new("TextLabel")
FPS.Name = "FPS"
FPS.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
CountFPS.Name = "CountFPS"
CountFPS.Parent = FPS
CountFPS.AnchorPoint = Vector2.new(0, 1)
CountFPS.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CountFPS.BackgroundTransparency = 1.000
CountFPS.BorderColor3 = Color3.fromRGB(0, 0, 0)
CountFPS.BorderSizePixel = 0
CountFPS.Position = UDim2.new(0.667487681, 0, 0.276422769, 0)
CountFPS.Size = UDim2.new(0, 200, 0, 50)
CountFPS.FontFace = Font.new([[rbxasset://fonts/families/Merriweather.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
CountFPS.Text = "FPS : 60"
CountFPS.TextColor3 = Color3.fromRGB(255, 255, 255)
CountFPS.TextSize = 17.000
game:GetService("RunService").RenderStepped:Connect(function(deltaTime)
    local fps = math.floor(1 / deltaTime)
    CountFPS.Text = "FPS : " .. fps
end)

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

function checknotify(terubedai)
    for r, v in pairs(plr.PlayerGui.Notifications:GetChildren()) do
        if v and v.Text and string.find(string.lower(v.Text), terubedai) then
            return true
        end
    end
    return false
end

function BigHitbox() 

end

function NoStun() 
    for _, v in game.Players.LocalPlayer.Character.HumanoidRootPart:GetChildren() do 
        if v.Name == "BodyGyro" or v.Name == "BodyPosition" then 
            v:Destroy() 
        end 
    end 
end 

function GetPortal(nig)
    ccp = nig.Position
    min = math.huge
    min2 = math.huge
    if game.PlaceId == 7449423635 then
        TableLocations = {
            ["Caslte On The Sea"] = Vector3.new(-5058.77490234375, 314.5155029296875, -3155.88330078125),
            ["Hydra"] = Vector3.new(5756.83740234375, 610.4240112304688, -253.9253692626953),
            ["Mansion"] = Vector3.new(-12463.8740234375, 374.9144592285156, -7523.77392578125),
            ["Great Tree"] = Vector3.new(28282.5703125, 14896.8505859375, 105.1042709350586),
            ["Hydra 1"] = Vector3.new(-11993.580078125, 334.7812805175781, -8844.1826171875),
            ["Hydra 2"] = Vector3.new(5314.58203125, 25.419387817382812, -125.94227600097656)
        }
    elseif game.PlaceId == 4442272183 then
        TableLocations = {
            ["Mansion"] = Vector3.new(-288.46246337890625, 306.130615234375, 597.9988403320312),
            ["Flamingo"] = Vector3.new(2284.912109375, 15.152046203613281, 905.48291015625),
            ["Out Ship"] = Vector3.new(923.21252441406, 126.9760055542, 32852.83203125),
            ["In Ship"] = Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422)
        }
    elseif game.PlaceId == 2753915549 then
        TableLocations = {
            ["Sky 3"] = Vector3.new(-7894.6201171875, 5545.49169921875, -380.2467346191406),
            ["Sky 2"] = Vector3.new(-4607.82275390625, 872.5422973632812, -1667.556884765625),
            ["In WaterCity"] = Vector3.new(61163.8515625, 11.759522438049316, 1819.7841796875),
            ["Out WaterCity"] = Vector3.new(3876.280517578125, 35.10614013671875, -1939.3201904296875)
        }
    end
    TableLocations2 = {}
    for r, v in pairs(TableLocations) do
        TableLocations2[r] = (v - ccp).Magnitude
    end
    for r, v in pairs(TableLocations2) do
        if v < min then
            min = v
            min2 = v
        end
    end
    for r, v in pairs(TableLocations2) do
        if v < min then
            min = v
            min2 = v
        end
    end
    for r, v in pairs(TableLocations2) do
        if v <= min then
            choose = TableLocations[r]
        end
    end
    min3 = (ccp - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if min2 <= min3 then
        return choose
    end
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
    if dist > 2500 and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - GetBypassCFrame(TargetCFrame).Position).Magnitude > 2500 and not CheckInComBat() and canthop == false then
        return bypass(TargetCFrame)
    end
    if dist <= 250 then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = TargetCFrame
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
                if (checknotify("died") or checknotify("player") or checknotify("Safe") or checknotify("zone")) and (enemy.Character.Head.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 150 then
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
                if enemy:DistanceFromCharacter(plr.Character.Head.Position) <= 100 then
                    if elapsed == nil or elapsed == 0 then
                        if os.time() - elapsed >= 10 and not CheckInComBat() then
                            FindNewEnemy()
                        end
                    else
                        elapsed = os.time()
                    end
                end
                if plr.PlayerGui.Main.BottomHUDList.SafeZone.Visible and enemy:DistanceFromCharacter(plr.Character.Head.Position) <= 100 then
                    FindNewEnemy()
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
                        to(enemy.Character.HumanoidRootPart.CFrame * CFrame.new(((math.random(1, 2) == 1 and 0) or -15), ((math.random(1, 2) == 1 and 0) or -15), 0))
                    end
                end
            end
        end
end
GaySec()