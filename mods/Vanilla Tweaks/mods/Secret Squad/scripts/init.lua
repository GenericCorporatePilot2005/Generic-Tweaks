
-- init.lua is the entry point of every mod

local mod = {
	id = "Nico_SS_Tweaks",
	name = "Secret Squad.",
	version = "1",
	description = "Adds some small changes to the squad that got me hooked into Cyborg-Class Mechs.\nIt's time to repay my debt.\nChanges in further detail:\nAllows the player to change the palette and sprites of the Squad, giving them the choice to look like their normal/alpha/leader variants.\nGives minor buffs to Beetle, and the cyborg class in general.\nVek Pheromones now also boot cyborg damage, Med Suplies now revive Cyborgs at mission end.",
	requirements = {},
	dependencies = { --This requests modApiExt from the mod loader
		modApiExt = "1.17",
		"Nico_Tweaks"
	},
	modApiVersion = "2.8.3",
	icon = "img/icon.png"
}

function mod:init()
	local options = mod_loader.currentModContent[mod.id].options
    local path = self.resourcePath
	require(self.scriptPath .."TechnoVekHormones")
	require(self.scriptPath .."cyborg_medical")
    --squad's tweaked sprites
        local mechPath = "img/units/player/"
		--Beetle
			local Nico_TBeetle_sprites = options["Nico_TBeetle_sprites"].value
				modApi:appendAsset(mechPath.."vek_beetle.png",path..mechPath.."vek_beetle"..Nico_TBeetle_sprites..".png")
				modApi:appendAsset(mechPath.."vek_beetle_a.png",path..mechPath.."vek_beetle"..Nico_TBeetle_sprites.."_a.png")
				modApi:appendAsset(mechPath.."vek_beetle_w.png",path..mechPath.."vek_beetle"..Nico_TBeetle_sprites.."_w.png")
				modApi:appendAsset(mechPath.."vek_beetle_ns.png",path..mechPath.."vek_beetle"..Nico_TBeetle_sprites.."_ns.png")
			if Nico_TBeetle_sprites==1 then
				modApi:appendAsset(mechPath.."vek_beetle_broken.png",path..mechPath.."vek_beetle"..Nico_TBeetle_sprites.."_broken.png")
				modApi:appendAsset(mechPath.."vek_beetle_w_broken.png",path..mechPath.."vek_beetle"..Nico_TBeetle_sprites.."_w_broken.png")
			end
			if Nico_TBeetle_sprites~=2 then
				modApi:appendAsset(mechPath.."vek_beetle_h.png",path..mechPath.."vek_beetle"..Nico_TBeetle_sprites.."_h.png")
			end
		--Hornet
			local Nico_THornet_sprites = options["Nico_THornet_sprites"].value
			modApi:appendAsset(mechPath.."vek_hornet.png",path..mechPath.."vek_hornet"..Nico_THornet_sprites..".png")
			modApi:appendAsset(mechPath.."vek_hornet_a.png",path..mechPath.."vek_hornet"..Nico_THornet_sprites.."_a.png")
			modApi:appendAsset(mechPath.."vek_hornet_ns.png",path..mechPath.."vek_hornet"..Nico_THornet_sprites.."_ns.png")
			if Nico_THornet_sprites~=2 then modApi:appendAsset(mechPath.."vek_hornet_broken.png",path..mechPath.."vek_hornet"..Nico_THornet_sprites.."_broken.png") end
			if Nico_THornet_sprites==1 then modApi:appendAsset(mechPath.."vek_hornet_h.png",path..mechPath.."vek_hornet"..Nico_THornet_sprites.."_h.png") end
		--Scarab
			local Nico_TScarab_sprites = options["Nico_TScarab_sprites"].value
			modApi:appendAsset(mechPath.."vek_scarab.png",path..mechPath.."vek_scarab"..Nico_TScarab_sprites..".png")
			modApi:appendAsset(mechPath.."vek_scarab_a.png",path..mechPath.."vek_scarab"..Nico_TScarab_sprites.."_a.png")
			modApi:appendAsset(mechPath.."vek_scarab_w.png",path..mechPath.."vek_scarab"..Nico_TScarab_sprites.."_w.png")
			modApi:appendAsset(mechPath.."vek_scarab_ns.png",path..mechPath.."vek_scarab"..Nico_TScarab_sprites.."_ns.png")
	--adds the weapons to the Weapon Deck
    local weapondeck= options["Nico_SS_weapondeck"].value

    if weapondeck==0 then
		modApi:addWeaponDrop("Vek_Beetle")
		modApi:addWeaponDrop("Vek_Hornet")
		modApi:addWeaponDrop("Vek_Scarab")
	end

	--Hornet's new shield
		HornetMech.LargeShield = true
	--Beetle's smoke immunity
		BeetleMech.IgnoreSmoke = true
	--Beetle's HP
		BeetleMech.Health = 4
	--Palettes
		--beetle
			local Nico_TBeetle_palette = options["Nico_TBeetle_palette"].value
			if Nico_TBeetle_palette==1 then BeetleMech.ImageOffset = modApi:getPaletteImageOffset("Nico_Palette_Vek") end
			if Nico_TBeetle_palette~=2 then modApi:appendAsset("img/portraits/pilots/Pilot_BeetleMech.png", path .."img/portraits/pilots/Pilot_BeetleMech"..Nico_TBeetle_palette..".png") end
			if Nico_TBeetle_palette==3 then BeetleMech.ImageOffset = modApi:getPaletteImageOffset("Nico_Palette_Vek_Boss") end
		--hornet
			local Nico_THornet_palette = options["Nico_THornet_palette"].value
			modApi:appendAsset("img/weapons/enemy_hornet3.png", path .."img/weapons/enemy_hornet3.png")
			if Nico_THornet_palette==1 then HornetMech.ImageOffset = modApi:getPaletteImageOffset("Nico_Palette_Vek") end
			if Nico_THornet_palette~=2 then
				Vek_Hornet.Icon = "weapons/enemy_hornet"..Nico_THornet_palette..".png"
				modApi:appendAsset("img/portraits/pilots/Pilot_HornetMech.png", path .."img/portraits/pilots/Pilot_HornetMech"..Nico_THornet_palette..".png")
			end
			if Nico_THornet_palette==3 then HornetMech.ImageOffset = modApi:getPaletteImageOffset("Nico_Palette_Vek_Boss") end
		--scarab
			local Nico_TScarab_palette = options["Nico_TScarab_palette"].value
			modApi:appendAsset("img/weapons/enemy_scarab3.png", path .."img/weapons/enemy_scarab3.png")
			modApi:copyAsset("img/effects/shotup_antB.png","img/effects/shotup_ant3.png")
			Vek_Scarab.Icon = "weapons/enemy_scarab"..Nico_TScarab_palette..".png"
			ScarabMech.ImageOffset = modApi:getPaletteImageOffset("Nico_Palette_Scarab"..Nico_TScarab_palette)
			Vek_Scarab.UpShot = "effects/shotup_ant"..Nico_TScarab_palette..".png"
			if Nico_TScarab_palette~=2 then modApi:appendAsset("img/portraits/pilots/Pilot_ScarabMech.png", path .."img/portraits/pilots/Pilot_ScarabMech"..Nico_TScarab_palette..".png") end
	
end

function mod:metadata()--Don't make any changes to resources in metadata. metadata runs regardless of if your mod is enabled or not.
    --adds the weapons to the Weapon Deck
	modApi:addGenerationOption(
		"Nico_SS_weapondeck", "Vextra SS's weapons on Weapon Deck",
		"Adds the three Cyborg weapons to the weapon deck.\nREQUIRES RESTART TO TAKE EFFECT!",
		{
			strings = { "Do it.", "Don't."},
			values = {0, 1},
			value = 0
		}
	)
	--Techno-Beetle sprites
	modApi:addGenerationOption(
		"Nico_TBeetle_sprites", "Tweaked Techno-Beetle sprites",
		"Changes the sprites of the Techno-Beetle.\nREQUIRES RESTART TO TAKE EFFECT!",
		{
			strings = {"Normal Vek Sprite", "Tweaked Alpha Vek Sprites", "Leader Vek Sprite"},
			values = {1, 2, 3},
			value = 2
		}
	)
	--Techno-Hornet's sprites
	modApi:addGenerationOption(
		"Nico_THornet_sprites", "Tweaked Techno-Hornet sprites",
		"Changes the sprites of the Techno-Hornet.\nREQUIRES RESTART TO TAKE EFFECT!",
		{
			strings = {"Normal Vek Sprite", "Tweaked Alpha Vek Sprites", "Leader Vek Sprite"},
			values = {1, 2, 3},
			value = 2
		}
	)
	--Techno-Scarab's sprites
	modApi:addGenerationOption(
		"Nico_TScarab_sprites", "Tweaked Techno-Scarab sprites",
		"Changes the sprites of the Techno-Scarab.\nREQUIRES RESTART TO TAKE EFFECT!",
		{
			strings = {"Tweaked Sprites", "Leader Vek Sprite"},
			values = {1, 2},
			value = 1
		}
	)
	--Techno-Beetle palette
	modApi:addGenerationOption(
		"Nico_TBeetle_palette", "Tweaked Techno-Beetle palette",
		"Changes the palette of the Techno-Beetle.\nREQUIRES RESTART TO TAKE EFFECT!",
		{
			strings = { "Normal Vek Palette", "Alpha Vek Palette", "Leader Vek Palette"},
			values = {1, 2, 3},
			value = 2
		}
	)
	--Techno-Hornet's palette
	modApi:addGenerationOption(
		"Nico_THornet_palette", "Tweaked Techno-Hornet palette",
		"Changes the palette of the Techno-Hornet.\nREQUIRES RESTART TO TAKE EFFECT!",
		{
			strings = { "Normal Vek Palette", "Alpha Vek Palette", "Leader Vek Palette"},
			values = {1, 2, 3},
			value = 2
		}
	)
	--Techno-Scarab's palette
	modApi:addGenerationOption(
		"Nico_TScarab_palette", "Tweaked Techno-Scarab palette",
		"Changes the palette of the Techno-Scarab.\nREQUIRES RESTART TO TAKE EFFECT!",
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