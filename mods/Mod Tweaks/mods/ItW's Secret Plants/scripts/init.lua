local mod = {
	id = "Nico_SP_tweak",
	name = "Secret Plants",
	version = "0",
	modApiVersion = "2.8.2",
	gameVersion = "1.2.83",
	description="A tweaked version of a cyborg squad that I considered needed improvements, this mod aims to give a better experience overall, by giving buffs to mechs and reworks to their weapons, in hopes to make them better; other additions include customizable palettes and sprites.",
	icon = "icon.png",
	dependencies = {"lmn_into_the_wild"},
	libs = {},
	enabled=false,
}

function mod:init()
	require(self.scriptPath .."assets")
	require(self.scriptPath .."pawns")
	require(self.scriptPath .."weapons/weapons")
	local options = mod_loader.currentModContent[mod.id].options
	    --adds the weapons to the Weapon Deck
        local Nico_tw_ITW_weapon_deck= options["Nico_tw_ITW_weapon_deck"].value

        if Nico_tw_ITW_weapon_deck==0 then
            modApi:addWeaponDrop("Nico_TW_chili")
            modApi:addWeaponDrop("Nico_TW_chomper")
            modApi:addWeaponDrop("Nico_TW_puffer")
        end
end

function mod:metadata()--Don't make any changes to resources in metadata. metadata runs regardless of if your mod is enabled or not.

	modApi:addGenerationOption(
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
		"Nico_Puffer_Palette", "Techno-Puffer's Palettes",
		"What the palette of the Techno-Puffer will be. REQUIRES RESTART TO TAKE EFFECT!",
		{
			strings = { "Secret Squad", "Default", "Alpha"},
			values = { 0, 1, 2},
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
		"Nico_tw_ITW_weapon_deck", "Secret Plant's weapons on Weapon Deck",
		"Adds the three Cyborg weapons to the weapon deck.\nREQUIRES RESTART TO TAKE EFFECT!",
		{
			strings = { "Do it.", "Don't."},
			values = { 0, 1},
			value = 0
		}
	)
end

function mod:load(options, version)
end

return mod