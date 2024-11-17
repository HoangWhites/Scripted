local RS = game.ReplicatedStorage
local plr = game.Players.LocalPlayer
for i, v in pairs(RS.Assets.GUI:GetChildren()) do 
    v.Enabled = false 
end
hookfunction(require(RS.Effect.Container.Death), function() end)
hookfunction(require(RS.Effect.Container.Respawn), function() end)
