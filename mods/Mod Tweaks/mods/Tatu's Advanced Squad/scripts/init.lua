local mod = {
	id = "Nico_TW_Advanced_Squad",
    name = "Tatu's Advanced Squad",
    description="This mods tweaks the Advanced Squad made by Tatu mod.",
	modApiVersion = "2.8.2",
    version="iolet-like pink and bright Orange make a great combo, ngl.",
	gameVersion = "1.2.83",
	icon = "img/icon.png",
	dependencies = {"tatu_Advanced_Squad"},
	libs = {},
	enabled=false,
}
function mod:init()
    local options = mod_loader.currentModContent[mod.id].options
    local path = mod_loader.mods[modApi.currentMod].resourcePath
    --------------------
    -- Starfish Mech ---
    --------------------
        local Nico_twStarfishMech = options["Nico_twStarfishMech"].value
        if Nico_twStarfishMech==1 then
            -- locate our mech assets.

            local starfishPath = path .."img/mech_starfish/"

            -- make a list of our files.
            local files = {
                "tatu_mech_starfish.png",
                "tatu_mech_starfish_a.png",
                "tatu_mech_starfish_w.png",
                "tatu_mech_starfish_broken.png",
                "tatu_mech_starfish_w_broken.png",
                "tatu_mech_starfish_ns.png",
            }

            -- iterate our files and add the assets so the game can find them.
            for _, file in ipairs(files) do
                modApi:appendAsset("img/units/player/".. file, starfishPath .. file)
            end
        end
        
        modApi:appendAsset("img/units/player/starfish_palette.png", path .."img/mech_starfish/starfish_palette.png")
        --palettes
            local Nico_twStarfishPalette = options["Nico_twStarfishPalette"].value
            modApi:addPalette{
                ID = "Nico_Palette_VekB",
                Image="img/units/player/starfish_palette.png",
                Name = "Tweaked Normal Starfish",
                PlateHighlight = {255, 226, 171},
                PlateLight     = {248, 249, 193},
                PlateMid       = {72, 183, 215},
                PlateDark      = {58, 74, 128},
                PlateOutline   = {12, 19, 31},
                PlateShadow    = {47, 37, 53},
                BodyColor      = {121, 83, 76},
                BodyHighlight  = {200, 156, 88},
            }
            modApi:addPalette({
                ID = "Nico_Palette_Normal_Starfish",
                Name = "Tweaked Alpha Starfish",
                Image = "units/player/starfish_palette.png",
                PlateHighlight = {255, 197, 86},
                PlateLight     = {206, 212, 135},
                PlateMid       = {79, 146, 107},
                PlateDark      = {60, 87, 89},
                PlateOutline   = {9, 22, 27},
                PlateShadow    = {36, 41, 65},
                BodyColor      = {85, 88, 112},
                BodyHighlight  = {139, 121, 164},
            })
            modApi:addPalette{--Tweaked Techno-Starfish
                ID = "Nico_AdvancedColors",
                Image="img/units/player/starfish_palette.png",
                Name = "Tweaked Leader Starfish",
                PlateHighlight = {255, 198, 138},	--lights
                PlateLight     = {255, 187, 131},	--main highlight
                PlateMid       = {255, 95, 75},	    --main light
                PlateDark      = {155, 63, 63},		--main mid
                PlateOutline   = {9, 22, 27},		--main dark
                BodyHighlight  = {243, 94, 222},	--metal light
                BodyColor      = {133, 55, 152},	--metal mid
                PlateShadow    = {56, 34, 78},		--metal dark
            }
            if Nico_twStarfishPalette==1 then
                tatu_StarfishMech.ImageOffset = modApi:getPaletteImageOffset("Nico_Palette_Scarab1")
            elseif Nico_twStarfishPalette==2 then
                tatu_StarfishMech.ImageOffset = modApi:getPaletteImageOffset("Nico_Palette_VekB")
            elseif Nico_twStarfishPalette==3 then
                tatu_StarfishMech.ImageOffset = modApi:getPaletteImageOffset("Nico_Palette_Scarab2")
            elseif Nico_twStarfishPalette==4 then
                tatu_StarfishMech.ImageOffset = modApi:getPaletteImageOffset("Nico_Palette_Normal_Starfish")
            elseif Nico_twStarfishPalette==6 then
                tatu_StarfishMech.ImageOffset = modApi:getPaletteImageOffset("Nico_AdvancedColors")
            end

        if (Nico_twStarfishMech==0 and Nico_twStarfishPalette==1) or (Nico_twStarfishMech==1 and Nico_twStarfishPalette==2) then--normal portrait
            modApi:appendAsset("img/portraits/pilots/Pilot_tatu_StarfishMech.png",path.."img/portraits/Pilot_tatu_StarfishMech1.png")
        elseif (Nico_twStarfishMech==0 and Nico_twStarfishPalette==2) or (Nico_twStarfishMech==1 and Nico_twStarfishPalette==1) then--alt normal portrait
            modApi:appendAsset("img/portraits/pilots/Pilot_tatu_StarfishMech.png",path.."img/portraits/Pilot_tatu_StarfishMech1.5.png")
        elseif (Nico_twStarfishMech==0 and Nico_twStarfishPalette==3) or (Nico_twStarfishMech==1 and Nico_twStarfishPalette==4) then--alpha portrait
            modApi:appendAsset("img/portraits/pilots/Pilot_tatu_StarfishMech.png",path.."img/portraits/Pilot_tatu_StarfishMech2.png")
        elseif (Nico_twStarfishMech==0 and Nico_twStarfishPalette==4) or (Nico_twStarfishMech==1 and Nico_twStarfishPalette==3) then--alt alpha portait
            modApi:appendAsset("img/portraits/pilots/Pilot_tatu_StarfishMech.png",path.."img/portraits/Pilot_tatu_StarfishMech2.5.png")
        elseif (Nico_twStarfishMech==0 and Nico_twStarfishPalette==6) or (Nico_twStarfishMech==1 and Nico_twStarfishPalette==5) then
            modApi:appendAsset("img/portraits/pilots/Pilot_tatu_StarfishMech.png",path.."img/portraits/Pilot_tatu_StarfishMech3.5.png")--alt leader potrait
        end

        --custom Starfish attack sprites
        local Nico_twStarfishAttack = options["Nico_twStarfishAttack"].value
        -- functions
        local function tatu_hash(point) return point.x + point.y*10 end

        local function tatu_pos(p1,p2)
            if p1.y > p2.y and p1.x > p2.x then
                return 3
            elseif p1.y < p2.y and p1.x > p2.x then
                return 2
            elseif p1.y < p2.y and p1.x < p2.x then
                return 1
            elseif p1.y > p2.y and p1.x < p2.x then
                return 0
            end
        end
        tatu_StarfishAttack = tatu_StarfishAttack:new{
            Name = "Titanic Tentacles",
            Description = "Strike any number of oblique tiles with powerful tentacles.",
            Class = "TechnoVek",
            Icon = "weapons/tatu_starfish_attack.png",
            LaunchSound = "/enemy/starfish_2/attack",
            Rarity = 3,
            Range = 1,
            Damage = 2, -- Upgrades
            PowerCost = 0,
            Upgrades = 2,
            UpgradeCost = {2,3},
            TwoClick = true,
            tentacles="",
            TipImage = {
                Unit = Point(2,2),
                Enemy = Point(1,1),
                Enemy2 = Point(3,1),
                Enemy3 = Point(1,3),
                Building = Point(3,3),
                Target = Point(2,1),
                Second_Click = Point(1,3),
                CustomPawn = "tatu_StarfishMech",
            }
        }
        if Nico_twStarfishAttack==1 and (Nico_twStarfishPalette==1 or Nico_twStarfishPalette==2) then
            -- art, icons, animations
            modApi:appendAsset("img/advanced/effects/Nico_starfish_D.png",mod.resourcePath.."img/advanced/effects/Nico_starfish1_D.png")
            modApi:appendAsset("img/advanced/effects/Nico_starfish_L.png",mod.resourcePath.."img/advanced/effects/Nico_starfish1_L.png")
            modApi:appendAsset("img/advanced/effects/Nico_starfish_R.png",mod.resourcePath.."img/advanced/effects/Nico_starfish1_R.png")
            modApi:appendAsset("img/advanced/effects/Nico_starfish_U.png",mod.resourcePath.."img/advanced/effects/Nico_starfish1_U.png")
            tatu_StarfishAttack.tentacles="exploNicostarfish_"
        elseif Nico_twStarfishAttack==2 and (Nico_twStarfishPalette==3 or Nico_twStarfishPalette==4) then
            -- art, icons, animations
            modApi:appendAsset("img/advanced/effects/Nico_starfish_D.png",mod.resourcePath.."img/advanced/effects/Nico_starfish2_D.png")
            modApi:appendAsset("img/advanced/effects/Nico_starfish_L.png",mod.resourcePath.."img/advanced/effects/Nico_starfish2_L.png")
            modApi:appendAsset("img/advanced/effects/Nico_starfish_R.png",mod.resourcePath.."img/advanced/effects/Nico_starfish2_R.png")
            modApi:appendAsset("img/advanced/effects/Nico_starfish_U.png",mod.resourcePath.."img/advanced/effects/Nico_starfish2_U.png")
            tatu_StarfishAttack.tentacles="exploNicostarfish_"
        elseif Nico_twStarfishAttack==3 and (Nico_twStarfishPalette==5 or Nico_twStarfishPalette==6) then
            -- art, icons, animations
            modApi:appendAsset("img/advanced/effects/Nico_starfish_D.png",mod.resourcePath.."img/advanced/effects/Nico_starfish_D.png")
            modApi:appendAsset("img/advanced/effects/Nico_starfish_L.png",mod.resourcePath.."img/advanced/effects/Nico_starfish_L.png")
            modApi:appendAsset("img/advanced/effects/Nico_starfish_R.png",mod.resourcePath.."img/advanced/effects/Nico_starfish_R.png")
            modApi:appendAsset("img/advanced/effects/Nico_starfish_U.png",mod.resourcePath.."img/advanced/effects/Nico_starfish_U.png")
            tatu_StarfishAttack.tentacles="exploNicostarfish_"
        elseif Nico_twStarfishAttack==0 then
            tatu_StarfishAttack.tentacles="explostarfish_"
        end
        if Nico_twStarfishAttack~=0 then
            ANIMS.exploNicostarfish_0 = Animation:new{
                Image = "advanced/effects/Nico_starfish_R.png",
                NumFrames = 7,
                Time = 0.1,
                PosX = -35,
                PosY = -1,}
            ANIMS.exploNicostarfish_1 = ANIMS.exploNicostarfish_0:new{
                Image = "advanced/effects/Nico_starfish_D.png",
                PosX = -10,
                PosY = -3}
            ANIMS.exploNicostarfish_2 = ANIMS.exploNicostarfish_0:new{
                Image = "advanced/effects/Nico_starfish_L.png",
                PosX = 5,
                PosY = -1,}
            ANIMS.exploNicostarfish_3 = ANIMS.exploNicostarfish_0:new{
                Image = "advanced/effects/Nico_starfish_U.png",
                PosX = -6,
                PosY = 19}
        end
        
        function tatu_StarfishAttack:GetSkillEffect(p1, p2)
            local ret = SkillEffect()
            local dist = p1:Manhattan(p2)
            local pList = {}
            
            -- 1st target
            if dist < 2 then
                dir = GetDirection(p2 - p1)
                pA = p2 + DIR_VECTORS[(dir+1)%4]
                pB = p2 + DIR_VECTORS[(dir-1)%4]
                if Board:IsValid(pA) then pList[tatu_hash(pA)] = pA end
                if Board:IsValid(pB) then pList[tatu_hash(pB)] = pB end
            else
                pList[tatu_hash(p2)] = p2
            end
            
            -- add damage
            for i,p in pairs(pList) do
                local damage = SpaceDamage(p,self.Damage)
                damage.sAnimation = self.tentacles..tatu_pos(p1,p)
                ret:AddDamage(damage)
            end
            
            return ret
        end
        
        function tatu_StarfishAttack:GetFinalEffect(p1, p2, p3)
            local ret = SkillEffect()
            local dist = p1:Manhattan(p2)
            local dist2 = p1:Manhattan(p3)
            local pList = {}
            
            -- 1st target
            if dist < 2 then
                dir = GetDirection(p2 - p1)
                pA = p2 + DIR_VECTORS[(dir+1)%4]
                pB = p2 + DIR_VECTORS[(dir-1)%4]
                if Board:IsValid(pA) then pList[tatu_hash(pA)] = pA end
                if Board:IsValid(pB) then pList[tatu_hash(pB)] = pB end
            else
                pList[tatu_hash(p2)] = p2
            end
            
            -- 2nd target
            if p3 ~= p1 then
                if dist2 < 2 then
                    dir = GetDirection(p3 - p1)
                    pA = p3 + DIR_VECTORS[(dir+1)%4]
                    pB = p3 + DIR_VECTORS[(dir-1)%4]
                    if Board:IsValid(pA) then pList[tatu_hash(pA)] = pA end
                    if Board:IsValid(pB) then pList[tatu_hash(pB)] = pB end
                else
                    pList[tatu_hash(p3)] = p3
                end
            end
            
            -- add damage
            for i,p in pairs(pList) do
                local damage = SpaceDamage(p,self.Damage)
                damage.sAnimation = self.tentacles..tatu_pos(p1,p)
                ret:AddDamage(damage)
            end
            
            return ret
        end
    --------------------
    -- Gastropod Mech ---
    --------------------
        local Nico_twGastropodMech = options["Nico_twGastropodMech"].value
        if Nico_twGastropodMech==1 then
            -- locate our mech assets.
            local gastropodPath = path .."img/mech_gastropod/"

            -- make a list of our files.
            local files = {
                "tatu_mech_gastropod.png",
                "tatu_mech_gastropod_a.png",
                "tatu_mech_gastropod_ns.png",
            }
            -- iterate our files and add the assets so the game can find them.
            for _, file in ipairs(files) do
                modApi:appendAsset("img/units/player/".. file, gastropodPath .. file)
            end
        end
        local Nico_Weapon_Gastropod = options["Nico_Weapon_Gastropod"].value
        if Nico_Weapon_Gastropod==1 then
            --new weapon icon
            modApi:appendAsset("img/weapons/tatu_gastropod_attack.png",path.."img/weapon/tatu_gastropod_attack2.5.png")
        end
        local Nico_Hook_Gastropod = options["Nico_Hook_Gastropod"].value
        if Nico_Hook_Gastropod==1 then
            --custom hook sprite
            modApi:appendAsset("img/effects/shot_burnbug_grapple_U.png", path .."img/effects/shot_burnbug_grapple_U.png")
            modApi:appendAsset("img/effects/shot_burnbug_grapple_R.png", path .."img/effects/shot_burnbug_grapple_R.png")
            function tatu_GastropodAttack:GetSkillEffect(p1,p2)
                local ret = SkillEffect()
                local direction = GetDirection(p2 - p1)
                local target = GetProjectileEnd(p1,p2,PATH_PROJECTILE)
                
                local damage = SpaceDamage(target)
                damage.bHidePath = true
                ret:AddProjectile(damage,"effects/shot_burnbug_grapple")
                
                damage = SpaceDamage(target, self.Damage)
                damage.sSound = self.PullSound
                ret:AddDamage(damage)
                
                local endTarget = p1 + DIR_VECTORS[direction]
                local endSelf = target - DIR_VECTORS[direction]
                if self.ChooseEnd then
                    if p2 ~= target then
                        endTarget = p2
                        endSelf = p2
                    elseif p2 ~= p1 + DIR_VECTORS[direction] then
                        endTarget = p2 - DIR_VECTORS[direction]
                        endSelf = p2 - DIR_VECTORS[direction]
                    end
                end
                
                if not Board:IsValid(target) or (Board:IsPawnSpace(target) and not Board:GetPawn(target):IsGuarding()) then  -- If it's a pawn
                    ret:AddCharge(Board:GetSimplePath(target, endTarget), FULL_DELAY)
                elseif Board:IsBlocked(target, PATH_PROJECTILE) then  --If it's an obstruction
                    ret:AddCharge(Board:GetSimplePath(p1, endSelf), FULL_DELAY)	
                end

                return ret
            end
        end
    -------------------
    -- Spore Spawner --
    -------------------
        local Nico_Movement_Plasmodia = options["Nico_Movement_Plasmodia"].value
        if Nico_Movement_Plasmodia==1 then
            tatu_PlasmodiaMech.MoveSpeed = 3
        end
        local Nico_Weapon_Plasmodia = options["Nico_Weapon_Plasmodia"].value
        if Nico_Weapon_Plasmodia==1 then
            function tatu_PlasmodiaAttack:GetTargetArea(point)
                local ret = PointList()
            
                for dir = DIR_START, DIR_END do
                    for i = 1, self.ArtillerySize do
                        local curr = Point(point + DIR_VECTORS[dir] * i)
                        if not Board:IsValid(curr) then
                            break
                        end

                        if not self.OnlyEmpty or not Board:IsBlocked(curr,PATH_GROUND) then
                            ret:push_back(curr)
                        end

                    end
                end
                return ret
            end
        end
    --adds the weapons to the Weapon Deck
        local Nico_tw_AD_weapon_deck = options["Nico_tw_AD_weapon_deck"].value

        if Nico_tw_AD_weapon_deck==0 then
            modApi:addWeaponDrop("tatu_GastropodAttack")
            modApi:addWeaponDrop("tatu_PlasmodiaAttack")
            modApi:addWeaponDrop("tatu_StarfishAttack")
        end
end

function mod:metadata()--Don't make any changes to resources in metadata. metadata runs regardless of if your mod is enabled or not.
    --Tweaked Sprites for Techno-Starfish
        modApi:addGenerationOption(
            "Nico_twStarfishMech", "Tweaked Techno-Starfish sprites",
            "Palette swaps the colors of the Techno-Starfish's sprites to have greens as the dominant color, making it work better with other palettes.\nREQUIRES RESTART TO TAKE EFFECT!",
            {
                strings = { "Base Sprites.", "Tweaked Sprites."},
                values = { 0, 1},
                value = 1
            }
        )
    --Tweaked Palettes for Techno-Starfish
        modApi:addGenerationOption(
            "Nico_twStarfishPalette", "Tweaked Techno-Starfish Palette",
            "Adds a new palette which has the same colors as the Advanced Squad's palette, but inverted in order.\n(works better if the option `Tweaked Techno-Starfish sprites` is on `Tweaked Sprites`).\nREQUIRES RESTART TO TAKE EFFECT!",
            {
                strings = { "Normal Palette 1.", "Normal Palette 2.", "Alpha Palette 1.", "Alpha Palette 2.", "Leader Palette 1.", "Leader Palette 2."},
                values = { 1, 2, 3, 4, 5, 6},
                value = 6
            }
        )
    --Tweaked Techno-Starfish's weapon icon
        modApi:addGenerationOption(
            "Nico_twStarfishAttack", "Tweaked Techno-Starfish Attack",
            "Adds new attack effects to the Techno-Starfish's weapon, in the form of different colored tentacles(Changes color with the palette).\nREQUIRES RESTART TO TAKE EFFECT!",
            {
                strings = { "Weapon's Default Effects.", "Tweaked Effects"},
                values = { 0, 1},
                value = 1
            }
        )
    --Buffed Spore Launcher
        modApi:addGenerationOption(
            "Nico_Weapon_Plasmodia", "Tweaked Techno-Plasmodia's Weapon",
            "Buffs the Spore Spawner by reducing the amount of tiles it needs to shoot a Techno-Spore.\n(It works better if `Tweaked Techno-Gastropod's Projectile.` is on `Tweaked Sprites`\nREQUIRES RESTART TO TAKE EFFECT!",
            {
                strings = { "No Buff.", "Buff."},
                values = { 0, 1},
                value = 1
            }
        )
    --Buffed Spore Launcher
        modApi:addGenerationOption(
            "Nico_Movement_Plasmodia", "Tweaked Techno-Plasmodia's Movement",
            "Buffs the movement of the Techno-Plasmodia from 2 to 3.\nREQUIRES RESTART TO TAKE EFFECT!",
            {
                strings = { "No Buff.", "Buff."},
                values = { 0, 1},
                value = 1
            }
        )
    --Tweaked Sprites for Techno-Gastropod
        modApi:addGenerationOption(
            "Nico_twGastropodMech", "Tweaked Techno-Gastropod sprites",
            "Palette swaps the colors of the Techno-Gastropod's sprites to have angry eyes, like the Gastropod Leader.\nREQUIRES RESTART TO TAKE EFFECT!",
            {
                strings = { "Base Sprites.", "Tweaked Sprites."},
                values = { 0, 1},
                value = 1
            }
        )
    --Tweaked Techno Gaspropod's weapon icon
        modApi:addGenerationOption(
            "Nico_Weapon_Gastropod", "Tweaked Techno-Gastropod's Weapon Icon",
            "Adds a new weapon icon for the Techno-Gastropod's weapon.\n(It works better if `Tweaked Techno-Gastropod's Projectile.` is on `Tweaked Sprites`\nREQUIRES RESTART TO TAKE EFFECT!",
            {
                strings = { "Mod's default Icon.", "Tweaked Icon."},
                values = { 0, 1},
                value = 1
            }
        )
    --Tweaked Techno-Gastropod's Hook
        modApi:addGenerationOption(
            "Nico_Hook_Gastropod", "Tweaked Techno-Gastropod's Projectile.",
            "Adds a custom projectile for the Techno-Gastropod's weapon.\nREQUIRES RESTART TO TAKE EFFECT!",
            {
                strings = { "Default Sprites.", "Tweaked Sprites"},
                values = { 0, 1},
                value = 1
            }
        )
    --adds the weapons to the Weapon Deck
        modApi:addGenerationOption(
            "Nico_tw_AD_weapon_deck", "Advanced Squad's weapons on Weapon Deck",
            "Adds the three Cyborg weapons to the weapon deck.\nREQUIRES RESTART TO TAKE EFFECT!",
            {
                strings = { "Do it.", "Don't."},
                values = { 0, 1},
                value = 0
            }
        )
end

function mod:load(options, version)
end

return mod