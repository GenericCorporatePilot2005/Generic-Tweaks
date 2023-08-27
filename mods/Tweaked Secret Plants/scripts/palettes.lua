local mod = modApi:getCurrentMod()
local path = mod_loader.mods[modApi.currentMod].resourcePath
local scriptPath = mod.scriptPath
require(scriptPath .."weapons/weapons")
modApi:addPalette{--base chili
    Image="units/player/chili_palette_1.png",
    ID = "Nico_itw_chili",
    Name = "Spicy Red",
    PlateHighlight = {255,199,54},--lights
    PlateLight     = {249,81,81},--main highlight
    PlateMid       = {147,63,69},--main light
    PlateDark      = {77,42,41},--main mid
    PlateOutline   = {16,14,14},--main dark
    PlateShadow    = {47,71,52},--metal dark
    BodyColor      = {109,159,105},--metal mid
    BodyHighlight  = {177,221,108},--metal light
}
modApi:addPalette{--alpha chili
    Image="units/player/chili_palette_2.png",
    ID = "Nico_itw_alpha_chili",
    Name = "Flame Blue & Orange",
    PlateHighlight = {255,199,54},--lights
    PlateLight     = {255,163,53},--main highlight
    PlateMid       = {230,105,28},--main light
    PlateDark      = {213,49,29},--main mid
    PlateOutline   = {12,20,32},--main dark
    PlateShadow    = {49,50,76},--metal dark
    BodyColor      = {76,86,134},--metal mid
    BodyHighlight  = {110,207,226},--metal light
}
modApi:addPalette{--boss chili
    Image="units/player/chili_palette_3.png",
    ID = "Nico_itw_boss_chili",
    Name = "Red HellFire",
    PlateHighlight = {197,255,255},--lights
    PlateLight     = {255,112,109},--main highlight
    PlateMid       = {250,0,0},--main light
    PlateDark      = {145,0,0},--main mid
    PlateOutline   = {12,20,32},--main dark
    PlateShadow    = {77,42,41},--metal dark
    BodyColor      = {147,63,69},--metal mid
    BodyHighlight  = {249,81,81},--metal light
}
modApi:addPalette{--base puffer
    Image="units/player/puffer_palette.png",
    ID = "Nico_itw_puffer",
    Name = "Fungal Purple",
    PlateHighlight = {255,199,54},--lights
    PlateLight     = {218,71,135},--main highlight
    PlateMid       = {152,43,94},--main light
    PlateDark      = {83,27,47},--main mid
    PlateOutline   = {12,19,31},--main dark
    PlateShadow    = {44,43,47},--metal dark
    BodyColor      = {103,94,97},--metal mid
    BodyHighlight  = {155,135,133},--metal light
}
modApi:addPalette{--alpha puffer
    Image="units/player/puffer_palette.png",
    ID = "Nico_itw_alpha_puffer",
    Name = "Cyan Mycelium",
    PlateHighlight = {255,199,54},--lights
    PlateLight     = {198,255,153},--main highlight
    PlateMid       = {52,171,140},--main light
    PlateDark      = {32,93,84},--main mid
    PlateOutline   = {9,22,27},--main dark
    PlateShadow    = {38,40,50},--metal dark
    BodyColor      = {80,81,91},--metal mid
    BodyHighlight  = {122,113,135},--metal light
}
modApi:addPalette{--base chomper
    Image="units/player/chomper_palette_1.png",
    ID = "Nico_itw_chomper",
    Name = "Gluttonous Green",
    PlateHighlight = {255,199,54},--lights
    PlateLight     = {177,221,108},--main highlight
    PlateMid       = {76,130,79},--main light
    PlateDark      = {49,74,54},--main mid
    PlateOutline   = {27,35,25},--main dark
    PlateShadow    = {49,74,54},--metal dark
    BodyColor      = {76,130,79},--metal mid
    BodyHighlight  = {177,221,108},--metal light
}
modApi:addPalette{--alpha chomper
    Image="units/player/chomper_palette_2.png",
    ID = "Nico_itw_alpha_chomper",
    Name = "Deep Blue Stomach",
    PlateHighlight = {255,199,54},--lights
    PlateLight     = {110,207,226},--main highlight
    PlateMid       = {76,86,134},--main light
    PlateDark      = {49,50,76},--main mid
    PlateOutline   = {25,30,36},--main dark
    PlateShadow    = {49,50,76},--metal dark
    BodyColor      = {76,86,134},--metal mid
    BodyHighlight  = {110,207,226},--metal light
}
modApi:addPalette{--boss chomper
    Image="units/player/chomper_palette_3.png",
    ID = "Nico_itw_boss_chomper",
    Name = "Endless Crimson Hunger",
    PlateHighlight = {243,255,134},--lights
    PlateLight     = {249,81,91},--main highlight
    PlateMid       = {147,63,69},--main light
    PlateDark      = {77,42,41},--main mid
    PlateOutline   = {27,35,25},--main dark
    PlateShadow    = {8,16,16},--metal dark
    BodyColor      = {183,85,31},--metal mid
    BodyHighlight  = {210,114,36},--metal light
}

local mod = modApi:getCurrentMod()
local options = mod_loader.currentModContent[mod.id].options
		--Chili
        local paletteChili = options["Nico_Chili_Palette"].value
        local spritesChili = options["Nico_Chili_Sprites"].value
	
        LOG("paletteChili: " .. paletteChili)

        if paletteChili==0 and spritesChili==1 then
            modApi:appendAsset("img/portraits/pilots/Pilot_lmn_Chili.png", path .."img/portraits/chilialt0.5.png")
        elseif paletteChili==1 then
            LOG(" -> Default!")
            lmn_Chili.ImageOffset = modApi:getPaletteImageOffset("Nico_itw_chili")
        elseif paletteChili==2 then
            LOG(" -> Alpha!")
            lmn_Chili.ImageOffset = modApi:getPaletteImageOffset("Nico_itw_alpha_chili")
        elseif paletteChili==3 then
            LOG(" -> Leader!")
            lmn_Chili.ImageOffset = modApi:getPaletteImageOffset("Nico_itw_boss_chili")                
        else
            LOG(" -> Secret Squad!")
        end
    --Puffer
        local palettePuffer= options["Nico_Puffer_Palette"].value

        LOG("palettePuffer: " .. palettePuffer)

        if palettePuffer==0 then
            modApi:appendAsset("img/portraits/pilots/Pilot_lmn_Puffer.png", path .."img/portraits/pufferalt0.5.png")
        elseif palettePuffer==1 then
            LOG(" -> Default!")
            lmn_Puffer.ImageOffset = modApi:getPaletteImageOffset("Nico_itw_puffer")
        elseif palettePuffer==2 then
            Nico_TW_puffer.Emitter = "lmn_Puffer_Cloud_Burst_Alpha"
            Nico_TW_puffer.Icon="weapons/lmn_PufferAtk2.png"
            modApi:appendAsset("img/portraits/pilots/Pilot_lmn_Puffer.png", path .."img/portraits/pufferalt.png")--alpha puffer's pilot
            LOG(" -> Alpha!")
            lmn_Puffer.ImageOffset = modApi:getPaletteImageOffset("Nico_itw_alpha_puffer")
        else
            LOG(" -> Secret Squad!")
        end
    --Chomper
        local paletteChomper = options["Nico_Chomper_Palette"].value
        local spritesChomper = options["Nico_Chomper_Sprites"].value

        LOG("paletteChomper: " .. paletteChomper)

        if paletteChomper==0 and spritesChomper==1 then
            modApi:appendAsset("img/portraits/pilots/Pilot_lmn_Chomper.png", path .."img/portraits/chomperalt0.5.png")
        elseif paletteChomper==1 then
            LOG(" -> Default!")
            lmn_Chomper.Icon = path .."img/units/aliens/chomperatl0.5ic.png"
            lmn_Chomper.ImageOffset = modApi:getPaletteImageOffset("Nico_itw_chomper")
        elseif paletteChomper==2 then
            LOG(" -> Alpha!")
            lmn_Chomper.ImageOffset = modApi:getPaletteImageOffset("Nico_itw_alpha_chomper")
        elseif paletteChomper==3 then
            LOG(" -> Leader!")
            lmn_Chomper.ImageOffset = modApi:getPaletteImageOffset("Nico_itw_boss_chomper")
        else
            LOG(" -> Secret Squad!")
        end
        
