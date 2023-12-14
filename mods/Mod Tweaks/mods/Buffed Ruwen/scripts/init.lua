
local mod = {
	id = "NicoRUWEN",
	name = "Buffed Ruwen",
	version = "1.2.0",
	modApiVersion = "2.9.1",
	gameVersion = "1.2.88",
	description= "Allows Ruwen to turn any non-massive mech into a massive mech, this allows Ruwen to not die when they go on water, which would make their skill useless.",
	icon = "icon.png",
	dependencies = {"lmn_flt_pilots"},
	libs = {},
	enabled = false,
}

function mod:init()
	local function lmn_Crystal_Mech()
		modApi:scheduleHook(500, function()
			for i = 0,2 do
				if Game:GetPawn(i):IsAbility("Freeze_Walk") then Game:GetPawn(i):SetMassive(true) end
			end
		end)
	end
	
	local function EVENT_onModsLoaded()
		modapiext:addResetTurnHook(lmn_Crystal_Mech)
		modapiext:addGameLoadedHook(lmn_Crystal_Mech)
	end
	
	modApi.events.onPostStartGame:subscribe(lmn_Crystal_Mech)
	modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)
end

function mod:load(options, version)
end

return mod
