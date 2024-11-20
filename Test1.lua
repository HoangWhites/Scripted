GetOwnerShip = function()
    for r, v in next, game.Workspace.Boats:GetChildren() do
        if v:FindFirstChild("Owner") then
            if v.Owner.Value == game.Players.LocalPlayer.Name then
                return v
            end
        end
    end
end

TweenObject = fucntion(Object, Pos, Speed)
    if Speed == nil then Speed = 325 end
    local Distance = (Object.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    local tweenService = game:GetService("TweenService")
    local info = TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear)
    local tween = tweenService:Create(ObjectTween, info, {CFrame = Pos})
    if not Object:FindFirstChild("PartTween") then
        local ObjectTween = Instance.new("Part", Object)
        ObjectTween.Size = Vector3.new(1, 1, 1)
        ObjectTween.Name = "Object Part....."
        ObjectTween.Anchored = true
        ObjectTween.CanCollide = false
        ObjectTween.CanTouch = false
        ObjectTween.Transparency = 1
        ObjectTween:GetPropertyChangedSignal("CFrame"):Connect(function()
            task.wait(0.01)
            Object.CFrame = ObjectTween.CFrame
        end)
    end
    tween:Play()
end
while wait() do
    if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
        if GetOwnerShip() then
            TweenObject(GetOwnerShip().VehicleSeat, CFrame.new(-16927.451171875, 9.0863618850708, 433.8642883300781))
        end
    end
end
