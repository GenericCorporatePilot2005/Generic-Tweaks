local mod = {
	id = "Nico_bombyTweaks",
    name = "Walking Bomb Tweaks",
    description="makes the palette of the walking bombling change with the palette of the deployer.",
	modApiVersion = "2.8.2",
	gameVersion = "1.2.83",
    version="ery thankful to the Hotseat mod for making the original sprite (which I palette swapped) and to Tosx for making the pilot Simon Coil and their gimmick.",
	icon = "icon.png",
	dependencies = {},
	libs = {},
}

function mod:init()
    DeployUnit_Bomby.ImageOffset = 9

    function DeployUnit_SelfDamage:GetSkillEffect(p1, p2)
        local ret = SkillEffect()
        ret:AddDamage(SpaceDamage(p1, 1))
        for i = DIR_START, DIR_END do
            local damage = SpaceDamage(p1 + DIR_VECTORS[i], 1)
            damage.sAnimation = "exploout1_"..i
            ret:AddDamage(damage)
        end
        return ret
    end
    function Ranged_DeployBomb:GetSkillEffect(p1, p2)	
        local ret = SkillEffect()	
        local dir = GetDirection(p2-p1)
        -- change spider color
            local oldOffset = DeployUnit_Aracnoid.ImageOffset
            ret:AddScript(string.format("_G[%q].ImageOffset = Board:GetPawn(%s):GetImageOffset()",self.Deployed,p1:GetString()))
            
        local damage = SpaceDamage(p2,0)
        damage.sPawn = self.Deployed
        ret:AddBounce(p1, 2)
        ret:AddArtillery(damage,self.Projectile)
        ret:AddAnimation(damage.loc,"ExploRepulse1", FULL_DELAY)
        ret:AddBounce(p2, 3)
        
        if self.PushAdj then
            for i = DIR_START, DIR_END do
                damage = SpaceDamage(p1 + DIR_VECTORS[i], 0, i)
                damage.sAnimation = "airpush_"..i
                ret:AddDamage(damage)
            end
        end
        return ret
    end	
end

function mod:load(options, version)
end

return mod