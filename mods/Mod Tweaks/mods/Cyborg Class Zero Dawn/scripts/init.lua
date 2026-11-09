local mod = {
	id = "Nico_Cyborg_ZeroDawn",
    name = "Cyborg-Class Zero Dawn",
    description="'semi-sentient Mechs'? not anymore!\nThis mod only changes the class of the mechs in the Zero Dawn squad and their weapons, adding pilots and portraits to go along.\nThanks to Zerovirus for the base pilot sprites, without them this project wouldn't have been as cool as it was.",
	modApiVersion = "2.8.2",
	gameVersion = "1.2.83",
    version="ery thankful to them and to Tosx.",
	icon = "img/icon.png",
	dependencies = {"tosx_ZeroDawn"},
	libs = {},
	enabled=false,
}
local names = {"Behemoth","Thunderjaw","Tallneck"}
function mod:init()
    local path = mod_loader.mods[modApi.currentMod].resourcePath
    local options = mod_loader.currentModContent[mod.id].options
    local pilots = {"Pilot_ZeroDawn_EarthMech","Pilot_ZeroDawn_ThunderMech","Pilot_ZeroDawn_TallMech",}
    for i = 1,3 do
        CreatePilot{
            Id = pilots[i],
            Name = names[i],
            Personality = "Vek",
            Sex = SEX_VEK,
            GetSkill = function() NicoIsMachine = true; return "Survive_Death" end,
            Skill = "Survive_Death",
            Rarity = 0,
            Blacklist = {"Invulnerable", "Popular"},
        }
    end
    --Earth Mech
    local Nico_CyborgBehemoth = options["Nico_CyborgBehemoth"].value
    if Nico_CyborgBehemoth ~= ZeroDawn_Brute_ForceLoader.Class then
        modApi:appendAsset("img/portraits/pilots/Pilot_ZeroDawn_EarthMech.png", path .."img/portraits/pilots/Pilot_ZeroDawn_EarthMech.png")
        modApi:appendAsset("img/portraits/pilots/Pilot_ZeroDawn_EarthMech_2.png", path .."img/portraits/pilots/Pilot_ZeroDawn_EarthMech_2.png")
        modApi:appendAsset("img/portraits/pilots/Pilot_ZeroDawn_EarthMech_blink.png", path .."img/portraits/pilots/Pilot_ZeroDawn_EarthMech_blink.png")

        ZeroDawn_EarthMech = ZeroDawn_EarthMech:new{
            Class = Nico_CyborgBehemoth,
            NicoIsMachine = true,
        }
        
        ZeroDawn_Brute_ForceLoader.Class = Nico_CyborgBehemoth
    end
    --Thunder Mech
    local Nico_CyborgThunderjaw = options["Nico_CyborgThunderjaw"].value
    if Nico_CyborgThunderjaw ~= ZeroDawn_Prime_ZetaCannon.Class then
        modApi:appendAsset("img/portraits/pilots/Pilot_ZeroDawn_ThunderMech.png", path .."img/portraits/pilots/Pilot_ZeroDawn_ThunderMech.png")
        modApi:appendAsset("img/portraits/pilots/Pilot_ZeroDawn_ThunderMech_2.png", path .."img/portraits/pilots/Pilot_ZeroDawn_ThunderMech_2.png")
        modApi:appendAsset("img/portraits/pilots/Pilot_ZeroDawn_ThunderMech_blink.png", path .."img/portraits/pilots/Pilot_ZeroDawn_ThunderMech_blink.png")

        ZeroDawn_ThunderMech = ZeroDawn_ThunderMech:new{
            Class = Nico_CyborgThunderjaw,
            NicoIsMachine = true,
        }
        
        ZeroDawn_Prime_ZetaCannon.Class = Nico_CyborgThunderjaw
    end
    --Tall Mech
    local Nico_CyborgTallneck = options["Nico_CyborgTallneck"].value
    if Nico_CyborgTallneck ~= ZeroDawn_Science_NavRelay.Class then
        modApi:appendAsset("img/portraits/pilots/Pilot_ZeroDawn_TallMech.png", path .."img/portraits/pilots/Pilot_ZeroDawn_TallMech.png")
        modApi:appendAsset("img/portraits/pilots/Pilot_ZeroDawn_TallMech_2.png", path .."img/portraits/pilots/Pilot_ZeroDawn_TallMech_2.png")

        ZeroDawn_TallMech = ZeroDawn_TallMech:new{
            Class = Nico_CyborgTallneck,
            NicoIsMachine = true,
        }

        ZeroDawn_Science_NavRelay.Class = Nico_CyborgTallneck
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
    local classes = {"Brute","Prime","Science"}
    local namesMech = {"Earth","Thunder","Tall"}
    for i = 1,3 do
        modApi:addGenerationOption(
            "Nico_Cyborg"..names[i], "Cyborg-Class "..namesMech[i].."Mech.",
            "Changes the class of the "..namesMech[i].." Mech, and their weapons to Cyborg, and it adds both a pilot and 3 portraits for this mech.\nREQUIRES RESTART TO TAKE EFFECT!",
            {
                values = { classes[i], "TechnoVek"},
                value = "TechnoVek"
            }
        )

    end
end
function mod:load(options, version)
end

return mod