local mod = {
	id = "Nico_aracTweaks",
    name = "Aracnoid tweaks",
    description="Adds custom sprites for the aracnoids, makes the palette of the Aracnoid change dinamically to match the palette of the deployer, changes the animation of the attack and reduces the self damage from DAMAGE_DEATH to 1.",
	modApiVersion = "2.8.2",
	gameVersion = "1.2.83",
    version="ersion 1.1",
	icon = "img/icon.png",
	dependencies = {},
	libs = {},
}

function mod:init()
    --aracnoid
        modApi:appendAsset("img/advanced/units/player/aracnoid.png", mod.resourcePath .."img/advanced/units/player/aracnoid.png")
        modApi:appendAsset("img/advanced/units/player/aracnoid_death.png", mod.resourcePath .."img/advanced/units/player/aracnoid_death.png")
        modApi:appendAsset("img/advanced/units/player/aracnoida.png", mod.resourcePath .."img/advanced/units/player/aracnoida.png")
        modApi:appendAsset("img/advanced/units/player/aracnoid_emerge.png", mod.resourcePath .."img/advanced/units/player/aracnoid_emerge.png")
        DeployUnit_AracnoidAtk.SelfDamage = 1

        function Ranged_Arachnoid:GetSkillEffect(p1, p2)
            local ret = SkillEffect()
            local dir = GetDirection(p2 - p1)
            
            ret:AddBounce(p1, 1)
            
            local damage = SpaceDamage(p2,self.Damage)
            damage.sAnimation = ""
            damage.bKO_Effect = Board:IsDeadly(damage, Pawn)
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
            
            if Board:IsDeadly(damage, Pawn) then
                ret:AddSound(self.KOSound)
                ret:AddDelay(1.1)
                if Board:GetPawn(p1):GetImageOffset() ~= 10 then       
                    -- change spider color
                    ret:AddScript(string.format("_G[%q].ImageOffset = Board:GetPawn(%s):GetImageOffset()",self.MyPawn,p1:GetString()))
                    ret:AddAnimation(damage.loc,"ExploRepulse1", ANIM_NO_DELAY)
                else
                    DeployUnit_Aracnoid.ImageOffset = 10
                end
                local damage = SpaceDamage(p2)
                damage.sPawn = self.MyPawn
                damage.bKO_Effect = true
                ret:AddDamage(damage)
            end
            
            return ret
        end
        function DeployUnit_AracnoidAtk:GetSkillEffect(p1, p2)
            local ret = SkillEffect()
            local dir = GetDirection(p2 - p1)
        
            local damage = SpaceDamage(p2, self.Damage, dir)
            damage.sAnimation = "explospear1_"..dir
            damage.iAcid = self.Acid 
            ret:AddMelee(p1, damage)
            
            ret:AddDamage(SpaceDamage(p1,1))
            
            return ret
            
        end
end

function mod:load(options, version)
end

return mod