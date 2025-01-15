if game.PlaceId == 2753915549 or game.PlaceId == 4442272183 or game.PlaceId == 7449423635 then
  loadstring(game:HttpGet("https://raw.githubusercontent.com/HoangWhites/Scripted/refs/heads/main/BloxFruitMain.lua"))()
elseif game.PlaceId == 4520749081 or game.PlaceId == 6381829480 or game.PlaceId == 15759515082 then
  loadstring(game:HttpGet("https://raw.githubusercontent.com/HoangWhites/Scripted/refs/heads/main/KingLegacy.lua"))()
else
  game:GetService("Players").LocalPlayer:Kick("Zinner Hub\n Not Supported")
end
