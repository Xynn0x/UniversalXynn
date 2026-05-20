repeat task.wait() until game:IsLoaded()

local place = game.PlaceId
print("Loaded PlaceId:", place)

if place ~= 105742951729183 then
    warn("Wrong place:", place)
    return
end
loadstring(game:HttpGet("https://raw.githubusercontent.com/Xynn0x/RaceLuckyXynn/refs/heads/main/RaceYourLuckyBlock.lua"))()
