if hookfunction and not islclosure(hookfunction) then 
    for i, v in next, RS.Assets.GUI:GetChildren() do 
        v.Enabled = false 
    end
    hookfunction(require(RS.Effect.Container.Death), function() end)
    hookfunction(require(RS.Effect.Container.Respawn), function() end)
end
