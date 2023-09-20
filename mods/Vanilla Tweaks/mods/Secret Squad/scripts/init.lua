
-- init.lua is the entry point of every mod

local mod = {
	id = "Nico_SS_Tweaks",
	name = "Secret Squad.",
	version = "1",
	description="Adds some small changes to the squad that got me hooked into Cyborg-Class Mechs.\nIt's time to repay my debt.",
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
        local mechPath = path .."img/units/player/"
        local Nico_TBeetle_sprites = options["Nico_TBeetle_sprites"].value
    	if Nico_TBeetle_sprites==1 then
			--normal beetle
				modApi:appendAsset("img/units/player/vek_beetle.png",mechPath.."vek_beetle1.png")
				modApi:appendAsset("img/units/player/vek_beetle_a.png",mechPath.."vek_beetle1_a.png")
				modApi:appendAsset("img/units/player/vek_beetle_w.png",mechPath.."vek_beetle1_w.png")
				modApi:appendAsset("img/units/player/vek_beetle_ns.png",mechPath.."vek_beetle1_ns.png")
				modApi:appendAsset("img/units/player/vek_beetle_broken.png",mechPath.."vek_beetle1_broken.png")
				modApi:appendAsset("img/units/player/vek_beetle_w_broken.png",mechPath.."vek_beetle1_w_broken.png")
				modApi:appendAsset("img/units/player/vek_beetle_h.png",mechPath.."vek_beetle1_h.png")
		elseif Nico_TBeetle_sprites==2 then
			--alpha beetle
				modApi:appendAsset("img/units/player/vek_beetle.png",mechPath.."vek_beetle.png")
				modApi:appendAsset("img/units/player/vek_beetle_a.png",mechPath.."vek_beetle_a.png")
				modApi:appendAsset("img/units/player/vek_beetle_w.png",mechPath.."vek_beetle_w.png")
				modApi:appendAsset("img/units/player/vek_beetle_ns.png",mechPath.."vek_beetle_ns.png")
		elseif Nico_TBeetle_sprites==3 then
			--leader beetle
				modApi:appendAsset("img/units/player/vek_beetle.png",mechPath.."vek_beetle3.png")
				modApi:appendAsset("img/units/player/vek_beetle_a.png",mechPath.."vek_beetle3_a.png")
				modApi:appendAsset("img/units/player/vek_beetle_w.png",mechPath.."vek_beetle3_w.png")
				modApi:appendAsset("img/units/player/vek_beetle_ns.png",mechPath.."vek_beetle3_ns.png")
				modApi:appendAsset("img/units/player/vek_beetle_h.png",mechPath.."vek_beetle3_h.png")
		end
        local Nico_THornet_sprites = options["Nico_THornet_sprites"].value
    	if Nico_THornet_sprites==1 then
			--normal hornet
				modApi:appendAsset("img/units/player/vek_hornet.png",mechPath.."vek_hornet1.png")
				modApi:appendAsset("img/units/player/vek_hornet_a.png",mechPath.."vek_hornet1_a.png")
				modApi:appendAsset("img/units/player/vek_hornet_ns.png",mechPath.."vek_hornet1_ns.png")
				modApi:appendAsset("img/units/player/vek_hornet_broken.png",mechPath.."vek_hornet1_broken.png")
				modApi:appendAsset("img/units/player/vek_hornet_h.png",mechPath.."vek_hornet1_h.png")
		elseif Nico_THornet_sprites==2 then
			--alpha hornet
				modApi:appendAsset("img/units/player/vek_hornet.png",mechPath.."vek_hornet.png")
				modApi:appendAsset("img/units/player/vek_hornet_a.png",mechPath.."vek_hornet_a.png")
				modApi:appendAsset("img/units/player/vek_hornet_ns.png",mechPath.."vek_hornet_ns.png")
		elseif Nico_THornet_sprites==3 then
			--leader hornet
				modApi:appendAsset("img/units/player/vek_hornet.png",mechPath.."vek_hornet3.png")
				modApi:appendAsset("img/units/player/vek_hornet_a.png",mechPath.."vek_hornet3_a.png")
				modApi:appendAsset("img/units/player/vek_hornet_ns.png",mechPath.."vek_hornet3_ns.png")
				modApi:appendAsset("img/units/player/vek_hornet_broken.png",mechPath.."vek_hornet3_broken.png")
				modApi:appendAsset("img/units/player/vek_hornet_w_broken.png",mechPath.."vek_hornet3_w_broken.png")
		end
        local Nico_TScarab_sprites = options["Nico_TScarab_sprites"].value
    	if Nico_TScarab_sprites==1 then
			--normal scarab
				modApi:appendAsset("img/units/player/vek_scarab.png",mechPath.."vek_scarab.png")
				modApi:appendAsset("img/units/player/vek_scarab_a.png",mechPath.."vek_scarab_a.png")
				modApi:appendAsset("img/units/player/vek_scarab_w.png",mechPath.."vek_scarab_w.png")
				modApi:appendAsset("img/units/player/vek_scarab_ns.png",mechPath.."vek_scarab_ns.png")
		elseif Nico_TScarab_sprites==2 then
			--leader scarab
				modApi:appendAsset("img/units/player/vek_scarab.png",mechPath.."vek_scarab2.png")
				modApi:appendAsset("img/units/player/vek_scarab_a.png",mechPath.."vek_scarab2_a.png")
				modApi:appendAsset("img/units/player/vek_scarab_w.png",mechPath.."vek_scarab2_w.png")
				modApi:appendAsset("img/units/player/vek_scarab_ns.png",mechPath.."vek_scarab2_ns.png")
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

	--Palettes
	modApi:appendAsset("img/units/player/vek_beetle1.png", mod.resourcePath .."img/units/player/vek_beetle1.png")
	modApi:appendAsset("img/units/player/vek_beetle3.png", mod.resourcePath .."img/units/player/vek_beetle3.png")
	modApi:appendAsset("img/units/player/scarab_palette.png", mod.resourcePath .."img/units/player/vek_scarab_ns.png")
	modApi:appendAsset("img/units/player/scarab_palette2.png", mod.resourcePath .."img/units/player/vek_scarab2_ns.png")
	modApi:appendAsset("img/units/player/vek_beetle3.png", mod.resourcePath .."img/units/player/vek_beetle3.png")
		modApi:addPalette({
			ID = "Nico_Palette_Vek",
			Image="img/units/player/vek_beetle1.png",
			Name = "Normal Hornet & Beetle",
			PlateHighlight = {255, 226, 171},
			PlateLight     = {200, 156, 88},
			PlateMid       = {121, 83, 76},
			PlateDark      = {47, 37, 53},
			PlateOutline   = {12, 19, 31},
			PlateShadow    = {33, 57, 45},
			BodyColor      = {93, 121, 97},
			BodyHighlight  = {254, 195, 187},
		})
		modApi:addPalette({
			ID = "Nico_Palette_Vek_Boss",
			Image="img/units/player/vek_beetle3.png",
			Name = "Leader Hornet & Beetle",
			PlateHighlight = {255, 197, 86},
			PlateLight     = {243, 94, 222},
			PlateMid       = {133, 55, 152},
			PlateDark      = {56, 34, 78},
			PlateOutline   = {22, 9, 10},
			PlateShadow    = {79, 33, 32},
			BodyColor      = {255, 95, 75},
			BodyHighlight  = {255, 187, 131},
		})
		modApi:addPalette({
			ID = "Nico_Palette_Scarab1",
			Image="units/player/scarab_palette.png",
			Name = "Normal Scarab",
			PlateHighlight = {255, 226, 171},
			PlateLight     = {200, 156, 88},
			PlateMid       = {121, 83, 76},
			PlateDark      = {47, 37, 53},
			PlateOutline   = {12, 19, 31},
			PlateShadow    = {58, 74, 128},
			BodyColor      = {72, 183, 215},
			BodyHighlight  = {248, 249, 193},
		})
		modApi:addPalette({
			ID = "Nico_Palette_Scarab2",
			Name = "Alpha Scarab",
			Image = "units/player/scarab_palette.png",
			PlateHighlight = {255, 197, 86},
			PlateLight     = {139, 121, 164},
			PlateMid       = {85, 88, 112},
			PlateDark      = {36, 41, 65},
			PlateOutline   = {9, 22, 27},
			PlateShadow    = {60, 87, 89},
			BodyColor      = {79, 146, 107},
			BodyHighlight  = {206, 212, 135},
		})
		modApi:addPalette({
			ID = "Nico_Palette_Scarab3",
			Name = "Leader Scarab",
			Image = "units/player/scarab_palette2.png",
			PlateHighlight = {255, 198, 138},
			PlateLight     = {243, 94, 222},
			PlateMid       = {133, 55, 152},
			PlateDark      = {56, 34, 78},
			PlateOutline   = {9, 13, 23},
			PlateShadow    = {160, 95, 54},
			BodyColor      = {221, 170, 73},
			BodyHighlight  = {255, 246, 220},
		})
        local Nico_TBeetle_palette = options["Nico_TBeetle_palette"].value
    	if Nico_TBeetle_palette==1 then
			modApi:appendAsset("img/portraits/pilots/Pilot_BeetleMech.png", path .."img/portraits/pilots/Pilot_BeetleMech1.png")
			BeetleMech.ImageOffset = modApi:getPaletteImageOffset("Nico_Palette_Vek")
		elseif Nico_TBeetle_palette==3 then
            modApi:appendAsset("img/portraits/pilots/Pilot_BeetleMech.png", path .."img/portraits/pilots/Pilot_BeetleMech3.png")
			BeetleMech.ImageOffset = modApi:getPaletteImageOffset("Nico_Palette_Vek_Boss")
		end
		--hornet
			local Nico_THornet_palette = options["Nico_THornet_palette"].value
			if Nico_THornet_palette==1 then
				modApi:appendAsset("img/portraits/pilots/Pilot_HornetMech.png", path .."img/portraits/pilots/Pilot_HornetMech1.png")
				HornetMech.ImageOffset = modApi:getPaletteImageOffset("Nico_Palette_Vek")
				Vek_Hornet.Icon = "weapons/enemy_hornet1.png"
			elseif Nico_THornet_palette==3 then
				modApi:appendAsset("img/weapons/HornetAtkBoss.png", path .."img/weapons/HornetAtkBoss.png")
				modApi:appendAsset("img/portraits/pilots/Pilot_HornetMech.png", path .."img/portraits/pilots/Pilot_HornetMech3.png")
				HornetMech.ImageOffset = modApi:getPaletteImageOffset("Nico_Palette_Vek_Boss")
				Vek_Hornet.Icon = "weapons/HornetAtkBoss.png"
			end
		--scarab
			local Nico_TScarab_palette = options["Nico_TScarab_palette"].value
			if Nico_TScarab_palette==1 then
				modApi:appendAsset("img/portraits/pilots/Pilot_ScarabMech.png", path .."img/portraits/pilots/Pilot_ScarabMech1.png")
				ScarabMech.ImageOffset = modApi:getPaletteImageOffset("Nico_Palette_Scarab1")
				Vek_Scarab.UpShot = "effects/shotup_ant1.png"
				Vek_Scarab.Icon = "weapons/enemy_scarab1.png"
			elseif Nico_TScarab_palette==2 then
				ScarabMech.ImageOffset = modApi:getPaletteImageOffset("Nico_Palette_Scarab2")
				Vek_Scarab.UpShot = "effects/shotup_ant2.png"
			elseif Nico_TScarab_palette==3 then
				modApi:appendAsset("img/weapons/ScarabAtkBoss.png", path .."img/weapons/ScarabAtkBoss.png")
				modApi:appendAsset("img/portraits/pilots/Pilot_ScarabMech.png", path .."img/portraits/pilots/Pilot_ScarabMech3.png")
				ScarabMech.ImageOffset = modApi:getPaletteImageOffset("Nico_Palette_Scarab3")
				Vek_Scarab.UpShot = "effects/shotup_antB.png"
				Vek_Scarab.Icon = "weapons/ScarabAtkBoss.png"
			end
	
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
	--Techno-Beetle sprites
	modApi:addGenerationOption(
		"Nico_TBeetle_sprites", "Tweaked Techno-Beetle sprites",
		"What the Sprites of the Techno-Beetle will be.\nREQUIRES RESTART TO TAKE EFFECT!",
		{
			strings = { "Squad's Default Sprites.", "Normal Vek Sprite", "Tweaked Alpha Vek Sprites", "Leader Vek Sprite"},
			values = { 0, 1, 2, 3},
			value = 2
		}
	)
	--Techno-Hornet's sprites
	modApi:addGenerationOption(
		"Nico_THornet_sprites", "Tweaked Techno-Hornet sprites",
		"What the Sprites of the Techno-Hornet will be.\nREQUIRES RESTART TO TAKE EFFECT!",
		{
			strings = { "Squad's Default Sprites.", "Normal Vek Sprite", "Tweaked Alpha Vek Sprites", "Leader Vek Sprite"},
			values = { 0, 1, 2, 3},
			value = 2
		}
	)
	--Techno-Scarab's sprites
	modApi:addGenerationOption(
		"Nico_TScarab_sprites", "Tweaked Techno-Scarab sprites",
		"What the Sprites of the Techno-Scarab will be.\nREQUIRES RESTART TO TAKE EFFECT!",
		{
			strings = { "Squad's Default Sprites.", "Tweaked Sprites", "Leader Vek Sprite"},
			values = { 0, 1, 2},
			value = 2
		}
	)
	--Techno-Beetle palette
	modApi:addGenerationOption(
		"Nico_TBeetle_palette", "Tweaked Techno-Beetle palette",
		"What the Palette of the Techno-Beetle will be.\nREQUIRES RESTART TO TAKE EFFECT!",
		{
			strings = { "Normal Vek Palette", "Alpha Vek Palette", "Leader Vek Palette"},
			values = {1, 2, 3},
			value = 2
		}
	)
	--Techno-Hornet's palette
	modApi:addGenerationOption(
		"Nico_THornet_palette", "Tweaked Techno-Hornet palette",
		"What the Palette of the Techno-Hornet will be.\nREQUIRES RESTART TO TAKE EFFECT!",
		{
			strings = { "Normal Vek Palette", "Alpha Vek Palette", "Leader Vek Palette"},
			values = {1, 2, 3},
			value = 2
		}
	)
	--Techno-Scarab's palette
	modApi:addGenerationOption(
		"Nico_TScarab_palette", "Tweaked Techno-Scarab palette",
		"What the palette of the Techno-Scarab will be.\nREQUIRES RESTART TO TAKE EFFECT!",
		{
			strings = { "Normal Vek Palette", "Alpha Vek Palette", "Leader Vek Palette"},
			values = { 1, 2, 3},
			value = 2
		}
	)
end

function mod:load(options, version)
end

return mod