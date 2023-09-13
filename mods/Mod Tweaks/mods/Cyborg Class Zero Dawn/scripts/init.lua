local mod = {
	id = "Nico_Cyborg_ZeroDawn",
    name = "Cyborg-Class Zero Dawn",
    description="'semi-sentient Mechs'? not anymore!\nThis mod only changes the class of the mechs in the Zero Dawn squad and their weapons, adding pilots and portraits to go along.\nThanks to Zerovirus for the base pilot sprites, without them this project wouldn't have been as cool as it was.",
	modApiVersion = "2.8.2",
	gameVersion = "1.2.83",
    version="ery thankful to Zerovirus :)",
	icon = "img/icon.png",
	dependencies = {"tosx_ZeroDawn"},
	libs = {},
}
function mod:init()
    local path = mod_loader.mods[modApi.currentMod].resourcePath
    local options = mod_loader.currentModContent[mod.id].options
    --Earth Mech
    local Nico_CyborgBehemoth = options["Nico_CyborgBehemoth"].value
    if Nico_CyborgBehemoth==1 then
        modApi:appendAsset("img/portraits/pilots/Pilot_ZeroDawn_EarthMech.png", path .."img/portraits/pilots/Pilot_ZeroDawn_EarthMech.png")
        modApi:appendAsset("img/portraits/pilots/Pilot_ZeroDawn_EarthMech_2.png", path .."img/portraits/pilots/Pilot_ZeroDawn_EarthMech_2.png")
        modApi:appendAsset("img/portraits/pilots/Pilot_ZeroDawn_EarthMech_blink.png", path .."img/portraits/pilots/Pilot_ZeroDawn_EarthMech_blink.png")

        CreatePilot{
            Id = "Pilot_ZeroDawn_EarthMech",
            Name = "Behemoth",
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
        
        ZeroDawn_Brute_ForceLoader.Class = "TechnoVek"
    end
    --Thunder Mech
    local Nico_CyborgThunderjaw = options["Nico_CyborgThunderjaw"].value
    if Nico_CyborgThunderjaw==1 then
        modApi:appendAsset("img/portraits/pilots/Pilot_ZeroDawn_ThunderMech.png", path .."img/portraits/pilots/Pilot_ZeroDawn_ThunderMech.png")
        modApi:appendAsset("img/portraits/pilots/Pilot_ZeroDawn_ThunderMech_2.png", path .."img/portraits/pilots/Pilot_ZeroDawn_ThunderMech_2.png")
        modApi:appendAsset("img/portraits/pilots/Pilot_ZeroDawn_ThunderMech_blink.png", path .."img/portraits/pilots/Pilot_ZeroDawn_ThunderMech_blink.png")

        CreatePilot{
            Id = "Pilot_ZeroDawn_ThunderMech",
            Name = "Thunderjaw",
            Personality = "Vek",
            Sex = SEX_VEK,
            GetSkill = function() NicoIsMachine = true; return "Survive_Death" end,
            Skill = "Survive_Death",
            Rarity = 0,
            Blacklist = {"Invulnerable", "Popular"},
        }

        ZeroDawn_ThunderMech = ZeroDawn_ThunderMech:new{
            Class = "TechnoVek",
            NicoIsMachine = true,
        }
        
        ZeroDawn_Prime_ZetaCannon.Class = "TechnoVek"
    end
    --Tall Mech
    local Nico_CyborgTallneck = options["Nico_CyborgTallneck"].value
    if Nico_CyborgTallneck==1 then
        modApi:appendAsset("img/portraits/pilots/Pilot_ZeroDawn_TallMech.png", path .."img/portraits/pilots/Pilot_ZeroDawn_TallMech.png")
        modApi:appendAsset("img/portraits/pilots/Pilot_ZeroDawn_TallMech_2.png", path .."img/portraits/pilots/Pilot_ZeroDawn_TallMech_2.png")
        
        CreatePilot{
            Id = "Pilot_ZeroDawn_TallMech",
            Name = "Tallneck",
            Personality = "Vek",
            Sex = SEX_VEK,
            GetSkill = function() NicoIsMachine = true; return "Survive_Death" end,
            Skill = "Survive_Death",
            Rarity = 0,
            Blacklist = {"Invulnerable", "Popular"},
        }

        ZeroDawn_TallMech = ZeroDawn_TallMech:new{
            Class = "TechnoVek",
            NicoIsMachine = true,
        }

        ZeroDawn_Science_NavRelay.Class = "TechnoVek"
    end
    local oldGetSkillInfo = GetSkillInfo
    function GetSkillInfo(skill)

    if NicoIsMachine then
        NicoIsMachine = nil
        if skill == "Survive_Death" then
            return PilotSkill("Machine", "Normal Pilots cannot be equipped. Loses 25 XP when the unit is disabled.")
        end
    end
    return oldGetSkillInfo(skill)
    end
end

function mod:metadata()--Don't make any changes to resources in metadata. metadata runs regardless of if your mod is enabled or not.
    --Earth Mech
        modApi:addGenerationOption(
            "Nico_CyborgBehemoth", "Cyborg-Class Earth Mech.",
            "Changes the class of the Earth Mech, and their weapons to Cyborg, and it adds both a pilot and 3 portraits for this mech.\nREQUIRES RESTART TO TAKE EFFECT!",
            {
                strings = { "Brute.", "Cyborg."},
                values = { 0, 1},
                value = 1
            }
        )
    --Thunder Mech
        modApi:addGenerationOption(
            "Nico_CyborgThunderjaw", "Cyborg-Class Thunder Mech.",
            "Changes the class of the Thunder Mech, and their weapons to Cyborg, and it adds both a pilot and 3 portraits for this mech.\nREQUIRES RESTART TO TAKE EFFECT!",
            {
                strings = { "Prime.", "Cyborg."},
                values = { 0, 1},
                value = 1
            }
        )
    --Tall Mech
        modApi:addGenerationOption(
            "Nico_CyborgTallneck", "Cyborg-Class Tall Mech.",
            "Changes the class of the Tall Mech, and their weapons to Cyborg, and it adds both a pilot and 3 portraits for this mech.\nREQUIRES RESTART TO TAKE EFFECT!",
            {
                strings = { "Science.", "Cyborg."},
                values = { 0, 1},
                value = 1
            }
        )
end
function mod:load(options, version)
end

return mod