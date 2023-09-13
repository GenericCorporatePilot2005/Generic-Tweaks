
-- init.lua is the entry point of every mod

local mod = {
	id = "Nico_SS_Tweaks",
	name = "Secret squad's weapons on shops",
	version = "1",
	requirements = {},
	dependencies = { --This requests modApiExt from the mod loader
		modApiExt = "1.17", --We can get this by using the variable `modapiext`
	},
	modApiVersion = "2.8.3",
	icon = "img/icon.png"
}

function mod:init()
	local options = mod_loader.currentModContent[mod.id].options
    local path = mod_loader.mods[modApi.currentMod].resourcePath
    --squad's tweaked sprites
        local Nico_new_sprites= options["Nico_SS_sprites"].value
        if Nico_new_sprites==1 then
            local files = {
                "vek_beetle.png",
                "vek_beetle_a.png",
                "vek_beetle_w.png",
                "vek_beetle_ns.png",
                "vek_hornet.png",
                "vek_hornet_a.png",
                "vek_hornet_ns.png",
                "vek_scarab.png",
                "vek_scarab_a.png",
                "vek_scarab_w.png",
                "vek_scarab_ns.png",
            }
        local mechPath = path .."img/units/player/"
        for _, file in ipairs(files) do
            modApi:appendAsset("img/units/player/".. file, mechPath .. file)
            end
        end
	--adds the weapons to the Weapon Deck
    local weapondeck= options["Nico_SS_weapondeck"].value

    if weapondeck==0 then
		modApi:addWeaponDrop("Vek_Beetle")
		modApi:addWeaponDrop("Vek_Hornet")
		modApi:addWeaponDrop("Vek_Scarab")
	end

	--Hornnet's new shield
		HornetMech.LargeShield = true

	--Beetle's smoke immunity
		BeetleMech.IgnoreSmoke=true

	--Scarab's palette
		--new palette for the Techno-Scarab
		modApi:addPalette({
			ID = "Nico_Palette_Scarab",
			Name = "Secret Squad's Scarab",
			Image = "units/player/vek_scarab_ns.png",
			PlateHighlight = {255, 197, 86},
			PlateLight     = {139, 121, 164},
			PlateMid       = {85, 88, 112},
			PlateDark      = {36, 41, 65},
			PlateOutline   = {9, 22, 27},
			PlateShadow    = {60, 87, 89},
			BodyColor      = {79, 146, 107},
			BodyHighlight  = {206, 212, 135},
			}
		)
		ScarabMech.ImageOffset = modApi:getPaletteImageOffset("Nico_Palette_Scarab")
	
end

function mod:metadata()--Don't make any changes to resources in metadata. metadata runs regardless of if your mod is enabled or not.
    --adds the weapons to the Weapon Deck
	modApi:addGenerationOption(
		"Nico_SS_weapondeck", "Vextra SS's weapons on Weapon Deck",
		"Adds the three Cyborg weapons to the weapon deck.\nREQUIRES RESTART TO TAKE EFFECT!",
		{
			strings = { "Do it.", "Don't."},
			values = { 0, 1},
			value = 0
		}
	)
	--SS's sprites
	modApi:addGenerationOption(
		"Nico_SS_sprites", "Tweaked Vextra Secret Squad's sprites",
		"Tweaks the sprites of the Secret Squad by:\nChanging the eye colors to change with different palettes.\nREQUIRES RESTART TO TAKE EFFECT!",
		{
			strings = { "Squad's Default Sprites.", "Tweaked Sprites"},
			values = { 0, 1},
			value = 1
		}
	)
end

function mod:load( options, version)
	-- after we have added our mechs, we can add a squad using them.
end

return mod