
-- handles the entir hud stuff
-- mostly stuff like knowing if it
-- should draw the special stage hud or not :P

local CH = customhud

CH.SetupFont("SPANM")

local path = "HUD/Assets/" -- is assets even the right name for this???
local mlvl = dofile(path+"main levels.lua")

CH.SetupItem("rings", "SPAHUD", function(v, p)
	mlvl.rings(v, p)
end, "game", 0, 3)

CH.SetupItem("time", "SPAHUD", function(v, p)
	mlvl.time(v, p)
end)

CH.SetupItem("score", "SPAHUD", function(v, p)
end)

CH.SetupItem("lives", "SPAHUD", function(v, p)
	mlvl.lives(v, p)
end)