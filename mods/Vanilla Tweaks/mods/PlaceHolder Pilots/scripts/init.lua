local mod = {
	id = "Nico_PlaceholderPilots",
	name = "PlaceHolder Pilots",
	version = "1.0",
	icon = "img/icon.png",
	description = "The modloader adds 2 extra pilot slots if you add any additional pilots to the roster, this is good, except when you turn off that mod, if the game knows you left the hangar on a pilot slot that doesn't exist, it'll not allow you to enter the hangar until you enable a pilot mod, or delete the profile.",
	enabled = false,
}


function mod:init()
    for i = 1,2 do
		local pilot = {
			Id = "Pilot_Placeholder_"..i,
			Name = "PlaceHolder "..i,
			Personality = "Vek",
			Rarity = 0,
			Voice = "/voice/ai",
		}
		CreatePilot(pilot)
		--modApi:addPilotDrop{id = pilot.Id, pod = true, recruit = false }
	end
end


function mod:load(options, version)
end

return mod
