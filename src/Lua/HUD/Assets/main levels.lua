
-- handles main level hud!!

local CH = customhud
local mlvl = {}
local HUDscale = FU + FU/2

local function getLives(stplyr)
	if stplyr == nil then return end

	local candrawlives = false;
	local livescount = -1

	local cv_cooplives = CV_FindVar("cooplives")

	// Co-op and Competition, normal life counter
	if (G_GametypeUsesLives()) then
		// Handle cooplives here
		if ((netgame or multiplayer) and G_GametypeUsesCoopLives() and cv_cooplives.value == 3) then
			livescount = 0;
			for p in players.iterate() do
				if p.spectator
				or p.lives < 1 then
					continue;
				end

				if (p.lives == INFLIVES) then
					livescount = INFLIVES;
					break;
				elseif (livescount < 99) then
					livescount = $+(p.lives);
				end
			end
		else
			livescount = (((netgame or multiplayer) and G_GametypeUsesCoopLives() and cv_cooplives.value == 0) and INFLIVES or stplyr.lives);
		end
		
		candrawlives = true
	// Infinity symbol (Race)
	elseif (G_PlatformGametype() and not (gametyperules & GTR_LIVES)) then
		livescount = INFLIVES;
		candrawlives = true;
	end

	return livescount, candrawlives
end

function mlvl.rings(v, p)
	local ringFrame = ((leveltime / 5) % 4) + 1
	local flags = V_SNAPTOTOP|V_SNAPTOLEFT|V_HUDTRANS|V_PERPLAYER
	
	v.drawScaled(16*FU, 30*FU, HUDscale, v.cachePatch("SPARING"+ringFrame), flags)
	CH.CustomNum(v, 16*FU+8*HUDscale, 30*FU, p.rings, "SPANM", 3, flags, nil, HUDscale)
end

function mlvl.time(v, p)
	local flags = V_SNAPTOTOP|V_SNAPTOLEFT|V_HUDTRANS|V_PERPLAYER
	local mins = G_TicsToMinutes(p.realtime, true)
	local secs = string.format("%02d", G_TicsToSeconds(p.realtime))
	
	CH.CustomFontString(v, 16*FU, 10*FU, mins+":"+secs, "SPANM", flags, nil, HUDscale)
end

function mlvl.lives(v, p)
	local lives, shouldDraw = getLives(p)
	
	if not shouldDraw then return end
	
	local flags = V_SNAPTOBOTTOM|V_SNAPTOLEFT|V_HUDTRANS|V_PERPLAYER
	
	v.drawScaled(16*FU, 185*FU, HUDscale, v.cachePatch("SPALIFEICON"), flags)
	CH.CustomNum(v, 40*FU, 185*FU, lives, "SPANM", 0, flags, nil, HUDscale)
end

return mlvl