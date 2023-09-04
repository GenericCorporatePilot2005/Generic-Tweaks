local mod = {
	id = "Nico_Cyborg_BlackHole",
    name = "Cyborg class Palanquin Mech",
    description="Reality can be whatever I want it to be.",
	modApiVersion = "2.8.2",
	gameVersion = "1.2.83",
    version="1.",
	icon = "img/icon.png",
	dependencies = {"hedera_voidscrapers"},
	libs = {},
}
function mod:init()
    local path = mod_loader.mods[modApi.currentMod].resourcePath
	modApi:appendAsset("img/portraits/pilots/Pilot_VS_TurtleMech.png", path .."img/portraits/pilots/Pilot_VS_TurtleMech.png")
	modApi:appendAsset("img/portraits/pilots/Pilot_VS_TurtleMech_2.png", path .."img/portraits/pilots/Pilot_VS_TurtleMech_2.png")
	modApi:appendAsset("img/portraits/pilots/Pilot_VS_TurtleMech_blink.png", path .."img/portraits/pilots/Pilot_VS_TurtleMech_blink.png")
    CreatePilot{
        Id = "Pilot_VS_TurtleMech",
        Personality = "Vek",
        Name="Palanquin Mech",
        Sex = SEX_VEK,
        GetSkill = function() NicoIsVoid = true; return "Survive_Death" end,
        Skill = "Survive_Death",
        Rarity = 0,
        Blacklist = {"Invulnerable", "Popular"},
    }
    VS_TurtleMech = VS_TurtleMech:new{
        Class = "TechnoVek",
        NicoIsVoid = true,
    }
    SS_CrushPull.Class = "TechnoVek"

    local oldGetSkillInfo = GetSkillInfo
    function GetSkillInfo(skill)

    if NicoIsVoid then
        NicoIsVoid = nil
        if skill == "Survive_Death"    then
            return PilotSkill("Anomaly Container", "Normal Pilots cannot be equipped. Loses 25 XP when the unit is disabled.")
        end
    end
    return oldGetSkillInfo(skill)
    end
end

function mod:load(options, version)
end

return mod