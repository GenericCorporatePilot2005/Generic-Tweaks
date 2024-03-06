
local mod = {
	id = "NicoT-Floater",
	name = "Techno-Floater",
	version = "1.2.0",
	modApiVersion = "2.9.1",
	gameVersion = "1.2.88",
	description= "The only Cyborg from Bots and Bugs that we could never see becoming a reality, now playabale!",
	icon = "icon.png",
	dependencies = {"lmn_bots_and_bugs"},
	libs = {},
	enabled = false,
}

function mod:init()
	require(self.scriptPath .."pawns")
	require(self.scriptPath .."weapons")
	-- add extra mech to selection screen
	modApi.events.onModsInitialized:subscribe(function()

		local oldGetStartingSquad = getStartingSquad
		function getStartingSquad(choice, ...)
		local result = oldGetStartingSquad(choice, ...)

		if choice == 0 then
			return add_arrays(result, {"Nico_Techno_Floater"})
		end
		return result
		end
	end)
end

function mod:load(options, version)
end

return mod
