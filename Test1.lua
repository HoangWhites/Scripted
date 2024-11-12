local player = game.Players.LocalPlayer
local playerhrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

function GetDistance(position1, position2)
    return (position1 - position2).Magnitude
end

function IsAlive(npc)
    local humanoid = npc:FindFirstChildOfClass("Humanoid")
    return humanoid and humanoid.Health > 0.11 or false
end

function GetMidBring(MobName, b2)
    local total, count = Vector3.new(), 0
    for _, enemy in pairs(game.Workspace.Enemies:GetChildren()) do
        if enemy.Name == MobName then
            local hrp = enemy:FindFirstChild("HumanoidRootPart")
            local humanoid = enemy:FindFirstChildOfClass("Humanoid")
            if hrp and humanoid and humanoid.Health > 0 and GetDistance(hrp.Position, b2.Position) <= 325 then
                total = total + hrp.Position
                count = count + 1
            end
        end
    end
    return count > 0 and total / count or nil
end

function ErrorHandler(error)
    print("\x1b[41m\x1b[30m[+ Error]\x1b[0m\x1b[31m : " .. tostring(error))
end

function BringMob(enable)
    xpcall(function()
        if not enable or not playerhrp then 
            return 
        end
        local mob = game.Workspace.Enemies:GetChildren()
        for _, enemy in pairs(mob) do
            local humanoid = enemy:FindFirstChild("Humanoid")
            local hrp = enemy:FindFirstChild("HumanoidRootPart")
            if not humanoid or humanoid.Health <= 0 or not hrp then return end
            if not string.find(enemy.Name, "Boss") and humanoid.MaxHealth < 130000 then
                local mid = GetMidBring(enemy.Name, hrp)
                local lockCFrame = mid and CFrame.new(mid) or hrp.CFrame
                if playerhrp and GetDistance(hrp.Position, playerhrp.Position) <= 325 and IsAlive(enemy) then
                    if enemy:GetPrimaryPartCFrame() ~= lockCFrame then
                        enemy:SetPrimaryPartCFrame(lockCFrame)
                    end
                    hrp.CanCollide = false
                    enemy.Head.CanCollide = false
                    humanoid.WalkSpeed = 0
                    humanoid.JumpPower = 0
                    humanoid.AutoRotate = true
                    humanoid:ChangeState(14)
                    sethiddenproperty(player, "SimulationRadius", 3150)
                end
            end
        end
    end, ErrorHandler)
end
while wait() do
    BringMob(true)
end
