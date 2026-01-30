
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

function mod:metadata()
	modApi:addGenerationOption(
		"Nico_Floater_cheat", "Techno-Floater Unlock.",
		"Unlocks the Techno-Floater if you don't want to kill a Floater Leader like in regular Bots and Bugs.\nREQUIRES A RESTART TO APPLY.",
		{
			strings = { "Default.", "Force Unlock."},
			values = {false,true},
			value = false,
			tooltips = {"Requires manual unlocking.", "Next time the game is loaded, Techno-Floater will be unlocked."},
		}
	)
end

function mod:init()
    require(self.scriptPath .."achievement+triggers")
    local options = mod_loader.currentModContent[self.id].options
    local cheat = options["Nico_Floater_cheat"].value
	modApi:addModsInitializedHook(function()
		local oldGetStartingSquad = getStartingSquad
		function getStartingSquad(choice, ...)
			local result = oldGetStartingSquad(choice, ...)

			if choice == 0 then
				local copy = {}
				for i, v in pairs(result) do
					copy[#copy+1] = v
				end

				local name = "floater"
				local Name = name:gsub("^.", string.upper) -- capitalize first letter

				-- add technomechs at the end to
				-- enable them as random and custom mechs.
				if modApi.achievements:isComplete(self.id, name) or cheat == true then
					table.insert(copy, "Nico_Techno_Colony")
				end

				return copy
			end

			return result
		end
	end)
    if modApi.achievements:isComplete(self.id, "floater") or cheat == true then
        require(self.scriptPath .."pawns")
        require(self.scriptPath .."weapons")
        require(self.scriptPath.."libs/FloaterIcon")--floater icon

        _G.IsAnyColony = function(pawn)--cross compat
            if not pawn then return false end
            local type = pawn:GetType()
            local isVek = (type == "lmn_Colony1" or type == "lmn_Colony2" or type == "lmn_Colony3")
            local isTechno = type:find("Nico_Techno_Colony") ~= nil
            return isVek or isTechno
        end

        modApi.events.onModsInitialized:subscribe(function()
            local oldGetStartingSquad = getStartingSquad
            function getStartingSquad(choice, ...)
                local result = oldGetStartingSquad(choice, ...)
                if choice == 0 then return add_arrays(result, {"Nico_Techno_Floater"}) end
                return result
            end

            for i = 1, 3 do
                local name = "lmn_Colony"..i
                if _G[name] then
                    local oldDeath = _G[name].GetDeathEffect
                    _G[name].GetDeathEffect = function(pawn, p1)
                        return Nico_Techno_Colony:GetDeathEffect(p1)
                    end
                end
            end
        end)
    end
end

function mod:load(options, version)
end

return mod
