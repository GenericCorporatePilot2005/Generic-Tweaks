local mod = {
	id = "Nico_TW_Vextra",
    name = "Vextra SS",
    description="This mod tweaks some loose ends in the mod Vextra, mostly on their Secret Squad.(Check the options once the mod's enabled to see those options)",
	modApiVersion = "2.8.2",
    version="1.2",
	gameVersion = "1.2.83",
	icon = "img/icon.png",
	dependencies = {"Djinn_NAH_Tatu_Vextra"},
	libs = {},
}
function mod:init()
    local options = mod_loader.currentModContent[mod.id].options
    local path = mod_loader.mods[modApi.currentMod].resourcePath
    local writepath = "img/weapons/"
    local readpath = path .. writepath
    local Nico_tw_fly_weapon= options["Nico_tw_fly_weapon"].value
    if Nico_tw_fly_weapon==1 then
        modApi:appendAsset(writepath.."DNT_SS_SappingProboscis.png", readpath.."DNT_SS_SappingProboscis.png")
    end
    --squad's tweaked sprites
        local Nico_new_sprites= options["Nico_SS_sprites"].value
        if Nico_new_sprites==1 then
            local files = {
                "DNT_dragonfly_mech.png",
                "DNT_dragonfly_mech_a.png",
                "DNT_dragonfly_mech_w_broken.png",
                "DNT_dragonfly_mech_broken.png",
                "DNT_dragonfly_mech_death.png",
                "DNT_dragonfly_mech_ns.png",
                "DNT_fly_mech.png",
                "DNT_fly_mech_a.png",
                "DNT_fly_mech_w_broken.png",
                "DNT_fly_mech_broken.png",
                "DNT_fly_mech_death.png",
                "DNT_fly_mech_ns.png",
                "DNT_stinkbug_mech.png",
                "DNT_stinkbug_mech_a.png",
                "DNT_stinkbug_mech_w.png",
                "DNT_stinkbug_mech_w_broken.png",
                "DNT_stinkbug_mech_broken.png",
                "DNT_stinkbug_mech_death.png",
                "DNT_stinkbug_mech_ns.png",
            }
        local mechPath = path .."img/units/player/"
        for _, file in ipairs(files) do
            modApi:appendAsset("img/units/player/".. file, mechPath .. file)
            end
        end
end

function mod:metadata()--Don't make any changes to resources in metadata. metadata runs regardless of if your mod is enabled or not.
    --Op Techno-Stinkbug
        modApi:addGenerationOption(
            "Nico_Mech_Stinkbug", "Old Techno-Stinkbug",
            "Restores the scrapped upgrade for Vextra's Techno-Stinkbug, where it would make fart clouds until reaching a mountain or building (You'll soon find why this feature was scapped).\nREQUIRES RESTART TO TAKE EFFECT!",
            {
                strings = { "nah, I'm fine without it.", "YES, F*CK BALANCE!!!"},
                values = { 0, 1},
                value = 0
            }
        )
    --Op Leader Stinkbug
        modApi:addGenerationOption(
            "Nico_Boss_Stinkbug", "Old Leader Stinkbug",
            "Restores the old Leader Stinkbug, which would create fart clouds until they were stopped by a building or a mountain, I added the option, but I don't know WHY you would want this.\nREQUIRES RESTART TO TAKE EFFECT!",
            {
                strings = { "no, please don't.", "YES, I WANNA SUFFER!!!"},
                values = { 0, 1},
                value = 0
            }
        )
    --Tweaked Vextra SS's sprites
        modApi:addGenerationOption(
            "Nico_SS_sprites", "Tweaked Vextra Secret Squad's sprites",
            "Tweaks the sprites of the Secret Squad from the Vextra mod by:\nChanging the eye colors to change with different palettes.\nRealigns the shadows of the mechs.\nREQUIRES RESTART TO TAKE EFFECT!",
            {
                strings = { "Vextra's Default Sprites.", "Tweaked Sprites"},
                values = { 0, 1},
                value = 1
            }
        )
    --adds the weapons to the Weapon Deck
        modApi:addGenerationOption(
            "Nico_tw_vextra_weapon_deck", "Vextra SS's weapons on Weapon Deck",
            "Adds the three Cyborg weapons to the weapon deck.\nREQUIRES RESTART TO TAKE EFFECT!",
            {
                strings = { "Do it.", "Don't."},
                values = { 0, 1},
                value = 0
            }
        )
    --Tweaked Techno-Fly's weapon icon
        modApi:addGenerationOption(
            "Nico_tw_fly_weapon", "Tweaked Techno-Fly's weapon icon",
            "New icon Techno-Fly's weapon, meant to resemble the Mech's portrait.\nREQUIRES RESTART TO TAKE EFFECT!",
            {
                strings = { "Weapon's Default Icon.", "Tweaked Icon."},
                values = { 0, 1},
                value = 0
            }
        )
end

function mod:load(options, version)
    --op Techno-Stinkbug
        local opMechStinkbug= options["Nico_Mech_Stinkbug"].value
        if opMechStinkbug==1 then            
            local function IsTipImage()
                return Board:GetSize() == Point(6,6)
            end
            
            local function DNT_hash(point) return point.x + point.y*10 end
    
            DNT_SS_AcridSpray_A = DNT_SS_AcridSpray_A:new{
                CustomTipImage = "DNT_SS_AcridSpray_A_Tip",
                UpgradeDescription = "Stink clouds extend to both sides infinitely until hitting an object.",
                FartRange = 8,
            }
            
            DNT_SS_AcridSpray_AB = DNT_SS_AcridSpray_A:new{
                CustomTipImage = "DNT_SS_AcridSpray_AB_Tip",
                Damage = 3,
            }
    
            DNT_SS_AcridSpray_A_Tip.FartRange = 4
            DNT_SS_AcridSpray_AB_Tip.Damage = 3
            function DNT_SS_AcridSpray:GetSkillEffect(p1,p2)
                local ret = SkillEffect()
                local dir = GetDirection(p2 - p1)
                local mission = GetCurrentMission()
                if not mission.DNT_FartList then mission.DNT_FartList = {} end
            
                local damage = SpaceDamage(p2,self.Damage,dir) -- attack
                damage.sAnimation = "explomosquito_"..dir
                damage.sSound = self.SoundBase.."/attack"
                ret:AddMelee(p1,damage,NO_DELAY)
            
                local L = true
                local R = true
                local FartAppear = IsPassiveSkill("Electric_Smoke") and "DNT_FartAppearDark" or "DNT_FartAppear"
                for i = 1, self.FartRange do
                    if L then
                        local dir2 = dir+1 > 3 and 0 or dir+1
                        local p3 = p1 + DIR_VECTORS[dir2]*i
                        -- ret:AddScript(string.format("table.insert(GetCurrentMission().DNT_FartList,%s)",p3:GetString())) -- insert point in fart list
                        ret:AddScript("GetCurrentMission().DNT_FartList["..DNT_hash(p3).."] = "..p3:GetString()) -- insert point in fart list
                        local damage = SpaceDamage(p3,0) -- smoke
                        damage.sAnimation = FartAppear
                        damage.iSmoke = EFFECT_CREATE
                        damage.sImageMark = "combat/icons/DNT_icon_stink.png"
                        ret:AddDamage(damage)
                    if Board:IsBlocked(p3,PATH_PROJECTILE) and not Board:IsPawnSpace(p3) then L = false end
                    end
                    if R then
                        local dir3 = dir-1 < 0 and 3 or dir-1
                        local p4 = p1 + DIR_VECTORS[dir3]*i
                        -- ret:AddScript(string.format("table.insert(GetCurrentMission().DNT_FartList,%s)",p4:GetString())) -- insert other fart point
                        ret:AddScript("GetCurrentMission().DNT_FartList["..DNT_hash(p4).."] = "..p4:GetString()) -- insert point in fart list
                        local damage = SpaceDamage(p4,0) -- smoke
                        damage.sAnimation = FartAppear
                        damage.iSmoke = EFFECT_CREATE
                        damage.sImageMark = "combat/icons/DNT_icon_stink.png"
                        ret:AddDamage(damage)
                        if Board:IsBlocked(p4,PATH_PROJECTILE) and not Board:IsPawnSpace(p4) then R = false end
                    end
                    ret:AddDelay(0.1)
                end
            
                ret:AddDelay(0.24) -- delay for adding smoke anim (hook)
            
                return ret
            end
        end
    --op Leader Stinkbug
        local opStinkbugBoss= options["Nico_Boss_Stinkbug"].value

        if opStinkbugBoss==1 then
            DNT_StinkbugAtkBoss.FartRange = 8

            DNT_StinkbugAtkBoss_Tip.FartRange = 4
            local function IsTipImage()
                return Board:GetSize() == Point(6,6)
            end
            local function DNT_hash(point) return point.x + point.y*10 end
            function DNT_StinkbugAtk1:GetSkillEffect(p1,p2)
                local ret = SkillEffect()
                local dir = GetDirection(p2 - p1)
                local mission = GetCurrentMission()
                if not mission.DNT_FartList then mission.DNT_FartList = {} end

                local L = true
                local R = true
                local FartAppear = IsPassiveSkill("Electric_Smoke") and "DNT_FartAppearDark" or "DNT_FartAppear"
                for i = 1, self.FartRange do
                    if L then
                        local dir2 = dir+1 > 3 and 0 or dir+1
                        local p3 = p1 + DIR_VECTORS[dir2]*i
                        -- ret:AddScript(string.format("table.insert(GetCurrentMission().DNT_FartList,%s)",p3:GetString())) -- insert point in fart list
                        ret:AddScript("GetCurrentMission().DNT_FartList["..DNT_hash(p3).."] = "..p3:GetString()) -- insert point in fart list
                        local damage = SpaceDamage(p3,0) -- smoke
                        damage.sAnimation = FartAppear
                        damage.iSmoke = EFFECT_CREATE
                        ret:AddDamage(damage)
                        if Board:IsBlocked(p3,PATH_PROJECTILE) then L = false end
                    end
                    if R then
                        local dir3 = dir-1 < 0 and 3 or dir-1
                        local p4 = p1 + DIR_VECTORS[dir3]*i
                        -- ret:AddScript(string.format("table.insert(GetCurrentMission().DNT_FartList,%s)",p4:GetString())) -- insert other fart point
                        ret:AddScript("GetCurrentMission().DNT_FartList["..DNT_hash(p4).."] = "..p4:GetString()) -- insert point in fart list
                        local damage = SpaceDamage(p4,0) -- smoke
                        damage.sAnimation = FartAppear
                        damage.iSmoke = EFFECT_CREATE
                        ret:AddDamage(damage)
                        if Board:IsBlocked(p4,PATH_PROJECTILE) then R = false end
                    end
                    ret:AddDelay(0.1)
                end

                local damage = SpaceDamage(p2,self.Damage) -- attack
                damage.sAnimation = "explomosquito_"..dir
                damage.sSound = self.SoundBase.."/attack"
                ret:AddQueuedMelee(p1,damage)

                ret:AddDelay(0.24) -- delay for adding smoke anim (hook)

                return ret
            end
        end
    

        
    --adds the weapons to the Weapon Deck
        local Nico_tw_vextra_weapon_deck= options["Nico_tw_vextra_weapon_deck"].value

        if Nico_tw_vextra_weapon_deck==0 then
            modApi:addWeaponDrop("DNT_SS_AcridSpray")
            modApi:addWeaponDrop("DNT_SS_SappingProboscis")
            modApi:addWeaponDrop("DNT_SS_SparkHurl")
        end

end

return mod