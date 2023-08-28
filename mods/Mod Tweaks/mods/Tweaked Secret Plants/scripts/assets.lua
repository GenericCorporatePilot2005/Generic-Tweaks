local mod = modApi:getCurrentMod()
local path = mod_loader.mods[modApi.currentMod].resourcePath
local options = mod_loader.currentModContent[mod.id].options
local writePath = "img/units/player/"
local readPath = path .."img/units/aliens/"
local scriptPath = mod.scriptPath
require(scriptPath .."weapons/weapons")
require(scriptPath .."pawns")

modApi:appendAsset("img/units/player/chilialt2_ns.png", readPath .."chilialt2_ns.png")--leader chili's pilot
modApi:appendAsset("img/units/player/chomperalt1_ns.png", readPath .."chomperalt1_ns.png")--alpha chomper's pilot
modApi:appendAsset("img/units/player/chomperalt2_ns.png", readPath .."chomperalt2_ns.png")--leader chomper's pilot

--alternative chili sprites that resemble the alpha/leader chili


modApi:appendAsset("img/units/player/chili_palette_1.png", mod.resourcePath .."img/units/aliens/chilins.png")
modApi:appendAsset("img/units/player/chili_palette_2.png", mod.resourcePath .."img/units/aliens/chilialt1_ns.png")
modApi:appendAsset("img/units/player/chili_palette_3.png", mod.resourcePath .."img/units/aliens/chilialt2_ns.png")
modApi:appendAsset("img/units/player/puffer_palette.png", mod.resourcePath .."img/units/aliens/pufferalt_ns.png")
modApi:appendAsset("img/units/player/chomper_palette_1.png", mod.resourcePath .."img/units/aliens/chomperns.png")
modApi:appendAsset("img/units/player/chomper_palette_2.png", mod.resourcePath .."img/units/aliens/chomperalt1_ns.png")
modApi:appendAsset("img/units/player/chomper_palette_3.png", mod.resourcePath .."img/units/aliens/chomperalt2_ns.png")

--Chili
local spritesChili = options["Nico_Chili_Sprites"].value
LOG("spritesChili: " .. spritesChili)

if spritesChili==2 then
    LOG(" -> Alpha!")
    Nico_TW_chili.Icon="weapons/lmn_ChiliAtk2.png"
    modApi:appendAsset("img/units/player/lmn_chili.png", mod.resourcePath .."img/units/aliens/chilialt1.png")
    modApi:appendAsset("img/units/player/lmn_chili_ns.png", mod.resourcePath .."img/units/aliens/chilialt1_ns.png")
    modApi:appendAsset("img/units/player/lmn_chili_h.png", mod.resourcePath .."img/units/aliens/chilialt1_h.png")
    modApi:appendAsset("img/units/player/lmn_chili_a.png", mod.resourcePath .."img/units/aliens/chilialt1_a.png")
    modApi:appendAsset("img/units/player/lmn_chili_w.png", mod.resourcePath .."img/units/aliens/chilialt1_w.png")
    modApi:appendAsset("img/units/player/lmn_chili_broken.png", mod.resourcePath .."img/units/aliens/chilialt1_broken.png")
    modApi:appendAsset("img/units/player/lmn_chili_w_broken.png", mod.resourcePath .."img/units/aliens/chilialt1_w_broken.png")
elseif spritesChili==3 then
    LOG(" -> Leader!")
    Nico_TW_chili.Icon="weapons/lmn_ChiliAtkB.png"
    modApi:appendAsset("img/units/player/lmn_chili.png", mod.resourcePath .."img/units/aliens/chilialt2.png")
    modApi:appendAsset("img/units/player/lmn_chili_ns.png", mod.resourcePath .."img/units/aliens/chilialt2_ns.png")
    modApi:appendAsset("img/units/player/lmn_chili_h.png", mod.resourcePath .."img/units/aliens/chilialt2_h.png")
    modApi:appendAsset("img/units/player/lmn_chili_a.png", mod.resourcePath .."img/units/aliens/chilialt2_a.png")
    modApi:appendAsset("img/units/player/lmn_chili_w.png", mod.resourcePath .."img/units/aliens/chilialt2_w.png")
    modApi:appendAsset("img/units/player/lmn_chili_broken.png", mod.resourcePath .."img/units/aliens/chilialt2_broken.png")
    modApi:appendAsset("img/units/player/lmn_chili_w_broken.png", mod.resourcePath .."img/units/aliens/chilialt2_w_broken.png")
else
    LOG(" -> Default!")
end
--Puffer
    local spritesPuffer = options["Nico_Puffer_Sprites"].value

    LOG("spritesPuffer: " .. spritesPuffer)

    if spritesPuffer==1 then
        modApi:appendAsset("img/units/player/lmn_puffer.png", mod.resourcePath .."img/units/aliens/pufferalt.png")
        modApi:appendAsset("img/units/player/lmn_puffer_ns.png", mod.resourcePath .."img/units/aliens/pufferalt_ns.png")
        modApi:appendAsset("img/units/player/lmn_puffer_h.png", mod.resourcePath .."img/units/aliens/pufferalt_h.png")
        modApi:appendAsset("img/units/player/lmn_puffer_emerge.png", mod.resourcePath .."img/units/aliens/pufferalt_emerge.png")
        modApi:appendAsset("img/units/player/lmn_puffer_a.png", mod.resourcePath .."img/units/aliens/pufferalt_a.png")
        modApi:appendAsset("img/units/player/lmn_puffer_w.png", mod.resourcePath .."img/units/aliens/pufferalt_w.png")
        modApi:appendAsset("img/units/player/lmn_puffer_broken.png", mod.resourcePath .."img/units/aliens/pufferalt_broken.png")
        modApi:appendAsset("img/units/player/lmn_puffer_w_broken.png", mod.resourcePath .."img/units/aliens/pufferalt_w_broken.png")
    end
--Chomper
    local spritesChomper = options["Nico_Chomper_Sprites"].value
    LOG("spritesChomper: " .. spritesChomper)

    if spritesChomper==2 then
        lmn_Chomper.Icon = path .."img/units/aliens/chomperalt1ic.png"
        Nico_TW_chomper.Icon="weapons/lmn_ChomperAtk2.png"
        modApi:appendAsset("img/units/player/lmn_chomper.png", mod.resourcePath .."img/units/aliens/chomperalt1.png")
        modApi:appendAsset("img/units/player/lmn_chomper_ns.png", mod.resourcePath .."img/units/aliens/chomperalt1_ns.png")
        modApi:appendAsset("img/units/player/lmn_chomper_h.png", mod.resourcePath .."img/units/aliens/chomperalt1_h.png")
        modApi:appendAsset("img/units/player/lmn_chomper_a.png", mod.resourcePath .."img/units/aliens/chomperalt1_a.png")
        modApi:appendAsset("img/units/player/lmn_chomper_w.png", mod.resourcePath .."img/units/aliens/chomperalt1_w.png")
        modApi:appendAsset("img/units/player/lmn_chomper_broken.png", mod.resourcePath .."img/units/aliens/chomperalt1_broken.png")
        modApi:appendAsset("img/units/player/lmn_chomper_w_broken.png", mod.resourcePath .."img/units/aliens/chomperalt1_w_broken.png")
    elseif spritesChomper==3 then
        lmn_Chomper.Icon = path .."img/units/aliens/chomperalt2ic.png"
        Nico_TW_chomper.Icon="weapons/lmn_ChomperAtkB.png"
        modApi:appendAsset("img/units/player/lmn_chomper.png", mod.resourcePath .."img/units/aliens/chomperalt2.png")
        modApi:appendAsset("img/units/player/lmn_chomper_ns.png", mod.resourcePath .."img/units/aliens/chomperalt2_ns.png")
        modApi:appendAsset("img/units/player/lmn_chomper_h.png", mod.resourcePath .."img/units/aliens/chomperalt2_h.png")
        modApi:appendAsset("img/units/player/lmn_chomper_a.png", mod.resourcePath .."img/units/aliens/chomperalt2_a.png")
        modApi:appendAsset("img/units/player/lmn_chomper_w.png", mod.resourcePath .."img/units/aliens/chomperalt2_w.png")
        modApi:appendAsset("img/units/player/lmn_chomper_broken.png", mod.resourcePath .."img/units/aliens/chomperalt2_broken.png")
        modApi:appendAsset("img/units/player/lmn_chomper_w_broken.png", mod.resourcePath .."img/units/aliens/chomperalt2_w_broken.png")
    end