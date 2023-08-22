local mod = modApi:getCurrentMod()
local path = mod_loader.mods[modApi.currentMod].resourcePath
local writePath = "img/units/player/"
local readPath = path .."img/units/aliens/"
local path2 = mod.scriptPath
require(path2 .."pawns")

modApi:appendAsset("img/portraits/pilots/Pilot_lmn_Chomper.png", path .."img/portraits/chomperalt2.png")
modApi:appendAsset("img/portraits/pilots/Pilot_lmn_Puffer.png", path .."img/portraits/pufferalt.png")

modApi:appendAsset("img/units/player/chilialt1_ns.png", readPath .."chilialt1_ns.png")--alpha chili's pilot
modApi:appendAsset("img/units/player/chilialt2_ns.png", readPath .."chilialt2_ns.png")--leader chili's pilot
modApi:appendAsset("img/units/player/chomperalt1_ns.png", readPath .."chomperalt1_ns.png")--alpha chomper's pilot
modApi:appendAsset("img/units/player/chomperalt2_ns.png", readPath .."chomperalt2_ns.png")--leader chomper's pilot

local a=ANIMS
--Chili
LOG(" -> Alpha!")
modApi:appendAsset("img/portraits/pilots/Pilot_lmn_Chili.png", path .."img/portraits/chilialt1.png")
--alternative chili sprites that resemble the alpha/leader chili
local files = {
    "chilialt1.png",
    "chilialt1_a.png",
    "chilialt1_w.png",
    "chilialt1_w_broken.png",
    "chilialt1_broken.png",
    "chilialt1_ns.png",
    "chilialt1_h.png",
    "chilialt2.png",
    "chilialt2_a.png",
    "chilialt2_w.png",
    "chilialt2_w_broken.png",
    "chilialt2_broken.png",
    "chilialt2_ns.png",
    "chilialt2_h.png",}
for _, file in ipairs(files) do
    modApi:appendAsset("img/units/player/".. file, readPath .. file)
end
local imagePath = "units/player/"
local base = a.MechUnit:new{Image = imagePath .."chilialt1.png", PosX = -12, PosY = 0}
a.Nico_ChiliMech = base
a.Nico_ChiliMecha = base:new{Image = imagePath .."chilialt1_a.png", PosX = -12, PosY = 0, NumFrames = 4}
a.Nico_ChiliMech_broken = base:new{Image = imagePath .."chilialt1_broken.png", PosX = -27}
a.Nico_ChiliMechw = base:new{Image = imagePath .."chilialt1_w.png", PosY = 8}
a.Nico_ChiliMechw_broken = base:new{Image = imagePath .."chilialt1_w_broken.png", PosX = -27, PosY = 8}
a.Nico_ChiliMech_ns = a.MechIcon:new{Image = imagePath .."chilialt1_ns.png"}

LOG(" -> Leader!")
modApi:appendAsset("img/portraits/pilots/Pilot_lmn_Chili.png", path .."img/portraits/chilialt2.png")

local imagePath = "units/player/"
local base = a.MechUnit:new{Image = imagePath .."chilialt2.png", PosX = -12, PosY = 0}
a.Nico_ChiliMech2 = base
a.Nico_ChiliMech2a = base:new{Image = imagePath .."chilialt2_a.png", PosX = -12, PosY = 0, NumFrames = 4}
a.Nico_ChiliMech2_broken = base:new{Image = imagePath .."chilialt2_broken.png", PosX = -27}
a.Nico_ChiliMech2w = base:new{Image = imagePath .."chilialt2_w.png", PosY = 8}
a.Nico_ChiliMech2w_broken = base:new{Image = imagePath .."chilialt2_w_broken.png", PosX = -27, PosY = 8}
a.Nico_ChiliMech_ns = a.MechIcon:new{Image = imagePath .."chilialt2_ns.png"}
--tweaked puffer sprites

local files = {
    "pufferalt.png",
    "pufferalt_a.png",
    "pufferalt_w.png",
    "pufferalt_w_broken.png",
    "pufferalt_broken.png",
    "pufferalt_ns.png",
    "pufferalt_h.png",
    "pufferalt_emerge.png",
}
local writePath = "img/units/player/"
local readPath = path .."img/units/aliens/"
local imagePath = "units/player/"
for _, file in ipairs(files) do
    modApi:appendAsset("img/units/player/".. file, readPath .. file)
end
local base = a.MechUnit:new{Image = imagePath .."pufferalt.png", PosX = -14, PosY = 2}

a.Nico_PufferMech = base
a.Nico_PufferMecha = base:new{Image = imagePath .."pufferalt_a.png", NumFrames = 4}
a.Nico_PufferMech_broken = base:new{Image = imagePath .."pufferalt_broken.png"}
a.Nico_PufferMechw = base:new{Image = imagePath .."pufferalt_w.png", PosY = 10}
a.Nico_PufferMechw_broken = base:new{Image = imagePath .."pufferalt_w_broken.png", PosY = 10}
a.Nico_PufferMech_ns = a.MechIcon:new{Image = imagePath .."pufferalt_ns.png"}
a.Nico_PufferMeche = a.BaseEmerge:new{Image = imagePath .."pufferalt_emerge.png", PosX = -14, PosY = 2, Height = GetColorCount(), NumFrames = 6, Time = 0.08}

--alternative chomper sprites
local files = {
    "chomperalt1.png",
    "chomperalt1_a.png",
    "chomperalt1_w.png",
    "chomperalt1_w_broken.png",
    "chomperalt1_broken.png",
    "chomperalt1_ns.png",
    "chomperalt1_h.png",
    "chomperalt2.png",
    "chomperalt2_a.png",
    "chomperalt2_w.png",
    "chomperalt2_w_broken.png",
    "chomperalt2_broken.png",
    "chomperalt2_ns.png",
    "chomperalt2_h.png",
}
for _, file in ipairs(files) do
    modApi:appendAsset("img/units/player/".. file, readPath .. file)
end

local imagePath = "units/player/"
local base = a.MechUnit:new{Image = imagePath .."chomperalt1.png", PosX = -16, PosY = -16}

a.Nico_ChomperMech = base
a.Nico_ChomperMecha = base:new{Image = imagePath .."chomperalt1_a.png", NumFrames = 6}
a.Nico_ChomperMech_broken = base:new{Image = imagePath .."chomperalt1_broken.png"}
a.Nico_ChomperMechw = base:new{Image = imagePath .."chomperalt1_w.png", PosY = -4}
a.Nico_ChomperMechw_broken = base:new{Image = imagePath .."chomperalt1_w_broken.png", PosY = -4}
a.Nico_ChomperMech_ns = a.MechIcon:new{Image = imagePath .."chomperalt1_ns.png"}


a.Nico_ChomperMech2 = base
a.Nico_ChomperMech2a = base:new{Image = imagePath .."chomperalt2_a.png", NumFrames = 6}
a.Nico_ChomperMech2_broken = base:new{Image = imagePath .."chomperalt2_broken.png"}
a.Nico_ChomperMech2w = base:new{Image = imagePath .."chomperalt2_w.png", PosY = -4}
a.Nico_ChomperMech2w_broken = base:new{Image = imagePath .."chomperalt2_w_broken.png", PosY = -4}
a.Nico_ChomperMech2_ns = a.MechIcon:new{Image = imagePath .."chomperalt2_ns.png"}

modApi.events.onModLoaded:subscribe(function(id)
	if id ~= mod.id then return end
	local options = mod_loader.currentModContent[id].options
    --Chili
        local spritesChili
        spritesChili = options["Nico_Chili_Sprites"].value

        LOG("spritesChili: " .. spritesChili)

        if spritesChili==2 then
            lmn_Chili = lmn_Chili:new{
                Image = "Nico_ChiliMech",
            }
        elseif spritesChili==3 then
            lmn_Chili = lmn_Chili:new{
                Image = "Nico_ChiliMech2",
            }
        end
    --Puffer
        local spritesPuffer
        spritesPuffer = options["Nico_Puffer_Sprites"].value

        LOG("spritesPuffer: " .. spritesPuffer)

        if spritesPuffer==1 then
            lmn_Puffer = lmn_Puffer:new{
                Image = "Nico_PufferMech",
            }
        end

    --Chomper
        local spritesChomper
        spritesChomper = options["Nico_Chomper_Sprites"].value

        LOG("spritesChomper: " .. spritesChomper)

        if spritesChomper==1 then
            lmn_Chomper = lmn_Chomper:new{Icon = path .."img/units/aliens/chomperic.png",}
        elseif spritesChomper==2 then
            lmn_Chomper = lmn_Chomper:new{Icon = path .."img/units/aliens/chomperalt1ic.png",}
            lmn_Chomper = lmn_Chomper:new{
                Image = "Nico_ChomperMech",
            }
        elseif spritesChomper==3 then
            lmn_Chomper = lmn_Chomper:new{Icon = path .."img/units/aliens/chomperalt2ic.png",}
            lmn_Chomper = lmn_Chomper:new{
                Image = "Nico_ChomperMech2",
            }
        end
end)