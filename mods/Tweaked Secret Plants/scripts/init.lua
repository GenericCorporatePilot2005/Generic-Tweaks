local mod = {
	id = "Nico_SP_tweak",
	name = "Secret Plants' tweaks",
	version = "0",
	modApiVersion = "2.8.2",
	gameVersion = "1.2.83",
	description="A tweaked version of a cyborg squad that I considered needed improvements, this mod aims to give a better experience overall, by giving buffs to mechs and reworks to their weapons, in hopes to make them better; other additions include customizable palettes and sprites.",
	icon = "icon.png",
	dependencies = {"lmn_into_the_wild"},
	libs = {},
}

function mod:init()
	require(self.scriptPath .."assets")
	require(self.scriptPath .."pawns")
	require(self.scriptPath .."pilots")
	require(self.scriptPath .."weapons/weapons")
	local options = mod_loader.currentModContent[mod.id].options
	modApi:addGenerationOption(
		--I want these to affect the mech
		"Nico_Chili_Sprites", "Techno-Chili's Sprites",
		"What the Sprites of the Techno-Chili will be. REQUIRES RESTART TO TAKE EFFECT!",
		{
			strings = { "Default", "Alpha", "Leader"},
			values = { 1, 2, 3 },
			value = 1
		}
	)
	modApi:addGenerationOption(
		"Nico_Puffer_Sprites", "Techno-Puffer's Sprites",
		"What the Sprites of the Techno-Puffer will be. REQUIRES RESTART TO TAKE EFFECT!",
		{
			strings = { "Original", "Tweaked"},
			values = { 0, 1},
			value = 1
		}
	)
	modApi:addGenerationOption(
		--I want these to affect the mech
		"Nico_Chomper_Sprites", "Techno-Chomper's Sprites",
		"What the Sprites of the Techno-Chomper will be. REQUIRES RESTART TO TAKE EFFECT!",
		{
			strings = { "Default", "Alpha", "Leader"},
			values = { 1, 2, 3 },
			value = 1
		}
	)
	modApi:addGenerationOption(
		"Nico_Chili_Palette", "Techno-Chili's Palettes",
		"What the palette of the Techno-Chili will be. REQUIRES RESTART TO TAKE EFFECT!",
		{
			strings = { "Secret Squad", "Default", "Alpha", "Leader"},
			values = { 0, 1, 2, 3 },
			value = 1
		}
	)
	modApi:addGenerationOption(
		"Nico_Chomper_Palette", "Techno-Chomper's Palettes",
		"What the palette of the Techno-Chomper will be. REQUIRES RESTART TO TAKE EFFECT!",
		{
			strings = { "Secret Squad", "Default", "Alpha", "Leader"},
			values = { 0, 1, 2, 3 },
			value = 1
		}
	)
	modApi:addGenerationOption(
		"Nico_Puffer_Palette", "Techno-Puffer's Palettes",
		"What the palette of the Techno-Puffer will be. REQUIRES RESTART TO TAKE EFFECT!",
		{
			strings = { "Secret Squad", "Default", "Alpha"},
			values = { 0, 1, 2},
			value = 1
		}
	)
end


function mod:load(options, version)
end

return mod