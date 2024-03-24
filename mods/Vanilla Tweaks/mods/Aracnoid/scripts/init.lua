local mod = {
	id = "Nico_aracTweaks",
    name = "Aracnoid",
    description = "Adds custom sprites for the aracnoids, makes the palette of the Aracnoid change dinamically to match the palette of the deployer,\nchanges the animation of the attack\nand reduces the self damage from DAMAGE_DEATH to 1.",
	modApiVersion = "2.8.2",
	gameVersion = "1.2.83",
    version = "ersion 1.1",
	icon = "img/icon.png",
	dependencies = {},
	libs = {},
	enabled = false,
}

function mod:init()
    local options = mod_loader.currentModContent[mod.id].options
	require(self.scriptPath .."extra")
    --aracnoid
    if options["Nico_Arachnoid_Web"].value == 0 then
        modApi:appendAsset("img/advanced/units/player/aracnoid.png", mod.resourcePath .."img/advanced/units/player/aracnoid.png")
        modApi:appendAsset("img/advanced/units/player/aracnoid_death.png", mod.resourcePath .."img/advanced/units/player/aracnoid_death.png")
        modApi:appendAsset("img/advanced/units/player/aracnoida.png", mod.resourcePath .."img/advanced/units/player/aracnoida.png")
        modApi:appendAsset("img/advanced/units/player/aracnoid_emerge.png", mod.resourcePath .."img/advanced/units/player/aracnoid_emerge.png")
        function Ranged_Arachnoid:GetSkillEffect(p1, p2)
            local ret = SkillEffect()
            local dir = GetDirection(p2 - p1)            
            ret:AddBounce(p1, 1)
            local damage = SpaceDamage(p2,self.Damage)
            damage.sAnimation = ""
            damage.bKO_Effect = Board:IsPawnSpace(damage.loc) and (Board:IsDeadly(damage, Pawn) and not Board:IsTerrain(damage.loc,TERRAIN_WATER) and not Board:IsTerrain(damage.loc,TERRAIN_LAVA) and not Board:IsTerrain(damage.loc,TERRAIN_HOLE) and not Board:IsCracked(damage.loc) and (not Board:IsTerrain(damage.loc,TERRAIN_ICE) and not Board:IsCracked(damage.loc)))
            ret:AddArtillery(damage,self.Projectile)
            if damage.bKO_Effect then
                ret:AddAnimation(damage.loc,"Arachnoide", ANIM_NO_DELAY)
            end
            ret:AddAnimation(damage.loc, "ExploArt1", ANIM_NO_DELAY)
            ret:AddBounce(p2, 2)
            
            if self.Push then
                for i = DIR_START, DIR_END do
                    ret:AddDamage(SpaceDamage(p2 + DIR_VECTORS[i], 0, i))
                end
            end
            
            if damage.bKO_Effect then
                ret:AddSound(self.KOSound)
                ret:AddDelay(1.1)
                if Board:GetPawn(p1):GetImageOffset() ~= 10 then       
                    -- change spider color
                    ret:AddScript(string.format("_G[%q].ImageOffset = Board:GetPawn(%s):GetImageOffset()",self.MyPawn,p1:GetString()))
                    ret:AddBounce(damage.loc,1)
                else
                    DeployUnit_Aracnoid.ImageOffset = 10
                    DeployUnit_AracnoidB.ImageOffset = 10
                end
                local damage = SpaceDamage(p2)
                damage.sPawn = self.MyPawn
                damage.bKO_Effect = true
                ret:AddDamage(damage)
            end
            
            return ret
        end
    end
    DeployUnit_AracnoidAtk.SelfDamage = 1
    function DeployUnit_AracnoidAtk:GetSkillEffect(p1, p2)
        local ret = SkillEffect()
        local dir = GetDirection(p2 - p1)
    
        local damage = SpaceDamage(p2, self.Damage, dir)
        damage.iAcid = self.Acid 
        ret:AddMelee(p1, damage)
        
        ret:AddDamage(SpaceDamage(p1,1))
        
        return ret
        
    end
end

function mod:metadata()
	modApi:addGenerationOption(
		"Nico_Arachnoid_Sprites", "Arachnoid Sprites.",
		"Changes the sprites of the Arachnoid to allow the palette changes.",
		{
			strings = { "On.", "Off."},
			values = {0, 1},
			value = 0
		}
	)
	modApi:addGenerationOption(
		"Nico_Arachnoid_Web", "Arachnoid's Web Immunity.",
		"Changes the sprites of the Arachnoid to allow the palette changes.",
		{
			strings = { "On.", "Off."},
			values = {0, 1},
			value = 0
		}
	)
	modApi:addGenerationOption(
		"Nico_Psion_Receiver", "Psionic Receiver Buff",
		"Having Psionic Receiver, with a Arachnid Psion present makes all spiderling eggs spawn Arachnoids.\nRecommended to turn off if the mod Unfair Tweaks is also on, since this feature is also on that mod by default.\nREQUIRES RESTART TO TAKE EFFECT!",
		{
			strings = { "On.", "Off."},
			values = {0, 1},
			value = 0
		}
	)
end

function mod:load(options, version)
end

return mod