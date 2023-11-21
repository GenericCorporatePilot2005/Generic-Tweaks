
local mod = {
	id = "Nico_Tweaks",
	name = "Generic's Tweaks",
	description = "A collection of small tweaks for several mods that were not made by me.\n(The tweaks aren't generic, I am.).\n(note, Generic's Tweaks will add some new palettes, this have the purpose of allowing certain mods to work in a more optimal way)",
	icon = "img/icon.png",
	submodFolders = {"mods/"},
	version = "1.93",
	enabled=false,
}

function mod:init()
	--Palettes
	modApi:appendAsset("img/units/player/vek_beetle1_ns.png", mod.resourcePath .."img/vek_beetle1_ns.png")
	modApi:appendAsset("img/units/player/vek_beetle3_ns.png", mod.resourcePath .."img/vek_beetle3_ns.png")
	modApi:appendAsset("img/units/player/scarab_palette.png", mod.resourcePath .."img/vek_scarab_ns.png")
	modApi:appendAsset("img/units/player/scarab_palette2.png", mod.resourcePath .."img/vek_scarab2_ns.png")
	modApi:appendAsset("img/units/player/DNT_dragonfly_mech3_ns.png", mod.resourcePath .."img/DNT_dragonfly_mech3_ns.png")
		modApi:addPalette({
			ID = "Nico_Palette_Vek",
			Image="img/units/player/vek_beetle1_ns.png",
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
			Image="img/units/player/vek_beetle3_ns.png",
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
		modApi:addPalette({
			ID = "Nico_Palette_Vextra_Boss",
			Name = "Leader DragonFly & Fly",
			Image = "img/units/player/DNT_dragonfly_mech3_ns.png",
			PlateHighlight = {255, 198, 138},
			PlateLight     = {243, 94, 222},
			PlateMid       = {133, 55, 152},
			PlateDark      = {56, 34, 78},
			PlateOutline   = {9, 13, 23},
			PlateShadow    = {82, 76, 57},
			BodyColor      = {155, 164, 132},
			BodyHighlight  = {218, 255, 210},
		})
end

function mod:load()
end

return mod