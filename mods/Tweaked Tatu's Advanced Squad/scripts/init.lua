local mod = {
	id = "Nico_TW_Advanced_Squad",
    name = "Tweaked Tatu's Advanced Squad",
    description="This mods tweaks the sprites of the Techno-Starfish made by Tatu mod by:\nChanging the colors to work better with different palettes.\nIt also adds a custom visual hook for the Techno-Gastropod's weapon.\nAnd Adds the three Cyborg weapons to the weapon deck.",
	modApiVersion = "2.8.2",
    version="iolet-like pink and bright Orange make a great combo, ngl.",
	gameVersion = "1.2.83",
	icon = "img/icon.png",
	dependencies = {"tatu_Advanced_Squad"},
	libs = {},
}
function mod:init()
    modApi:addPalette{--Tweaked Techno-Starfish
        ID = "Nico_AdvancedColors",
        Image="img/units/player/tatu_mech_starfish_ns.png",
        Name = "Tweaked Starfish",
		PlateHighlight = {255, 198, 138},	--lights
		PlateLight     = {255, 187, 131},	--main highlight
		PlateMid       = {255, 95, 75},	    --main light
		PlateDark      = {155, 63, 63},		--main mid
		PlateOutline   = {9, 22, 27},		--main dark
		BodyHighlight  = {243, 94, 222},	--metal light
		BodyColor      = {133, 55, 152},	--metal mid
		PlateShadow    = {56, 34, 78},		--metal dark
    }
    tatu_StarfishMech.ImageOffset= modApi:getPaletteImageOffset("Nico_AdvancedColors")
    --------------------
    -- Starfish Mech ---
    --------------------
        -- locate our mech assets.

        local path = mod_loader.mods[modApi.currentMod].resourcePath
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

        -- create animations for our mech with our imported files.
        -- note how the animations starts searching from /img/
        local a = ANIMS
        a.tatu_mech_starfish =			a.MechUnit:new{Image = "units/player/tatu_mech_starfish.png", PosX = -25, PosY = -2 }
        a.tatu_mech_starfisha =			a.MechUnit:new{Image = "units/player/tatu_mech_starfish_a.png", PosX = -25, PosY = -2, NumFrames = 4 }
        a.tatu_mech_starfishw =			a.MechUnit:new{Image = "units/player/tatu_mech_starfish_w.png", PosX = -23, PosY = 9 }
        a.tatu_mech_starfish_broken =	a.MechUnit:new{Image = "units/player/tatu_mech_starfish_broken.png", PosX = -25, PosY = -2 }
        a.tatu_mech_starfishw_broken =	a.MechUnit:new{Image = "units/player/tatu_mech_starfish_w_broken.png", PosX = -23, PosY = 9 }
        a.tatu_mech_starfish_ns =		a.MechIcon:new{Image = "units/player/tatu_mech_starfish_ns.png"}

    --------------------
    -- Gastropod Mech ---
    --------------------
        --new weapon icon
        modApi:appendAsset("img/weapons/tatu_gastropod_attack.png",path.."img/weapon/tatu_gastropod_attack.png")
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
    --custom Starfish attack sprites
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
        	-- art, icons, animations
            modApi:appendAsset("img/advanced/effects/Nico_starfish_D.png",mod.resourcePath.."img/advanced/effects/Nico_starfish_D.png")
            modApi:appendAsset("img/advanced/effects/Nico_starfish_L.png",mod.resourcePath.."img/advanced/effects/Nico_starfish_L.png")
            modApi:appendAsset("img/advanced/effects/Nico_starfish_R.png",mod.resourcePath.."img/advanced/effects/Nico_starfish_R.png")
            modApi:appendAsset("img/advanced/effects/Nico_starfish_U.png",mod.resourcePath.."img/advanced/effects/Nico_starfish_U.png")
            ANIMS.exploNicostarfish_0 = Animation:new{
                Image = "advanced/effects/Nico_starfish_R.png",
                NumFrames = 7,
                Time = 0.1,
                PosX = -35,
                PosY = -1,
            }
            ANIMS.exploNicostarfish_1 = ANIMS.exploNicostarfish_0:new{
                Image = "advanced/effects/Nico_starfish_D.png",
                PosX = -10,
                PosY = -3
            }
            ANIMS.exploNicostarfish_2 = ANIMS.exploNicostarfish_0:new{
                Image = "advanced/effects/Nico_starfish_L.png",
                PosX = 5,
                PosY = -1,
            }
            ANIMS.exploNicostarfish_3 = ANIMS.exploNicostarfish_0:new{
                Image = "advanced/effects/Nico_starfish_U.png",
                PosX = -6,
                PosY = 19
            }
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
                damage.sAnimation = "exploNicostarfish_"..tatu_pos(p1,p)
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
                damage.sAnimation = "exploNicostarfish_"..tatu_pos(p1,p)
                ret:AddDamage(damage)
            end
            
            return ret
        end

    --adds the weapons to the Weapon Deck
        modApi:addWeaponDrop("tatu_GastropodAttack")
        modApi:addWeaponDrop("tatu_PlasmodiaAttack")
        modApi:addWeaponDrop("tatu_StarfishAttack")
end

function mod:load(options, version)
   
end

return mod