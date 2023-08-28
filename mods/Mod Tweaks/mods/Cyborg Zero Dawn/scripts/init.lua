local mod = {
	id = "Nico_Cyborg_ZeroDawn",
    name = "Cyborg class Zero Dawn",
    description="'semi-sentient Mechs'? not anymore!\nThis mod only changes the class of the mechs in the Zero Dawn squad and their weapons, adding a pilot and portraits to go along.\nThanks to Zerovirus for the base pilot sprites, without them this project wouldn't have been as cool as it was.",
	modApiVersion = "2.8.2",
	gameVersion = "1.2.83",
    version="ery thankful to Zerovirus :)",
	icon = "img/icon.png",
	dependencies = {"tosx_ZeroDawn"},
	libs = {},
}
function mod:init()
    local path = mod_loader.mods[modApi.currentMod].resourcePath
	modApi:appendAsset("img/portraits/pilots/Pilot_ZeroDawn_ThunderMech.png", path .."img/portraits/pilots/Pilot_ZeroDawn_ThunderMech.png")
	modApi:appendAsset("img/portraits/pilots/Pilot_ZeroDawn_ThunderMech_2.png", path .."img/portraits/pilots/Pilot_ZeroDawn_ThunderMech_2.png")
	modApi:appendAsset("img/portraits/pilots/Pilot_ZeroDawn_ThunderMech_blink.png", path .."img/portraits/pilots/Pilot_ZeroDawn_ThunderMech_blink.png")
	modApi:appendAsset("img/portraits/pilots/Pilot_ZeroDawn_EarthMech.png", path .."img/portraits/pilots/Pilot_ZeroDawn_EarthMech.png")
	modApi:appendAsset("img/portraits/pilots/Pilot_ZeroDawn_EarthMech_2.png", path .."img/portraits/pilots/Pilot_ZeroDawn_EarthMech_2.png")
	modApi:appendAsset("img/portraits/pilots/Pilot_ZeroDawn_EarthMech_blink.png", path .."img/portraits/pilots/Pilot_ZeroDawn_EarthMech_blink.png")
	modApi:appendAsset("img/portraits/pilots/Pilot_ZeroDawn_TallMech.png", path .."img/portraits/pilots/Pilot_ZeroDawn_TallMech.png")
	modApi:appendAsset("img/portraits/pilots/Pilot_ZeroDawn_TallMech_2.png", path .."img/portraits/pilots/Pilot_ZeroDawn_TallMech_2.png")
    CreatePilot{
        Id = "Pilot_ZeroDawn_EarthMech",
        Name="Behemoth",
        Personality = "Vek",
        Sex = SEX_VEK,
        GetSkill = function() NicoIsMachine = true; return "Survive_Death" end,
        Skill = "Survive_Death",
        Rarity = 0,
        Blacklist = {"Invulnerable", "Popular"},
    }
    CreatePilot{
        Id = "Pilot_ZeroDawn_ThunderMech",
        Name="Thunderjaw",
        Personality = "Vek",
        Sex = SEX_VEK,
        GetSkill = function() NicoIsMachine = true; return "Survive_Death" end,
        Skill = "Survive_Death",
        Rarity = 0,
        Blacklist = {"Invulnerable", "Popular"},
    }
    CreatePilot{
        Id = "Pilot_ZeroDawn_TallMech",
        Name="Tallneck",
        Personality = "Vek",
        Sex = SEX_VEK,
        GetSkill = function() NicoIsMachine = true; return "Survive_Death" end,
        Skill = "Survive_Death",
        Rarity = 0,
        Blacklist = {"Invulnerable", "Popular"},
    }
    ZeroDawn_EarthMech = ZeroDawn_EarthMech:new{
        Class = "TechnoVek",
        NicoIsMachine = true,
    }
    ZeroDawn_ThunderMech = ZeroDawn_ThunderMech:new{
        Class = "TechnoVek",
        NicoIsMachine = true,
    }
    ZeroDawn_TallMech = ZeroDawn_TallMech:new{
        Class = "TechnoVek",
        NicoIsMachine = true,
    }
    ZeroDawn_Prime_ZetaCannon.Class = "TechnoVek"
    ZeroDawn_Brute_ForceLoader.Class = "TechnoVek"
    ZeroDawn_Science_NavRelay.Class = "TechnoVek"
    
    local oldGetSkillInfo = GetSkillInfo
    function GetSkillInfo(skill)

    if NicoIsMachine then
        NicoIsMachine = nil
        if skill == "Survive_Death"    then
            return PilotSkill("Machine", "Normal Pilots cannot be equipped. Loses 25 XP when the unit is disabled.")
        end
    end
    return oldGetSkillInfo(skill)
    end
end

function mod:load(options, version)
end

return mod