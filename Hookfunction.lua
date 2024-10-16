if hookfunction and not islclosure(hookfunction) then 
    for i,v in game:GetService("ReplicatedStorage").Assets.GUI:GetChildren() do 
        v.Enabled = false 
    end
    hookfunction(require(game:GetService("ReplicatedStorage").Effect.Container.Death), function() end)
    hookfunction(require(game:GetService("ReplicatedStorage").Effect.Container.Respawn), function() end)
end
