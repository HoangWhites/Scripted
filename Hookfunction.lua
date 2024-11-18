for i, v in pairs(game.ReplicatedStorage.Assets.GUI:GetChildren()) do 
    v.Enabled = false 
end
hookfunction(require(game.ReplicatedStorage.Effect.Container.Death), function() end)
hookfunction(require(game.ReplicatedStorage.Effect.Container.Respawn), function() end)
