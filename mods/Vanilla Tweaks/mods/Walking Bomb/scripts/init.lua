local mod = {
	id = "Nico_bombyTweaks",
    name = "Walking Bomb",
    description="makes the palette of the walking bombling change with the palette of the deployer.",
	modApiVersion = "2.8.2",
	gameVersion = "1.2.83",
    version="1.2",
	icon = "icon.png",
	dependencies = {},
	libs = {},
	enabled=false,
}

function mod:init()
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
            
        local damage = SpaceDamage(p2,0)
        damage.sPawn = self.Deployed
        ret:AddBounce(p1, 2)
        ret:AddArtillery(damage,self.Projectile)
        if Board:GetPawn(p1):GetImageOffset() ~= 9 then
            -- change spider color
                ret:AddScript(string.format("_G[%q].ImageOffset = Board:GetPawn(%s):GetImageOffset()",self.Deployed,p1:GetString()))
                ret:AddBounce(damage.loc,1)
        else
            DeployUnit_Bomby.ImageOffset = 9
        end
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
	local options = mod_loader.currentModContent[mod.id].options
    if options["Nico_Bomb_Sprites"].value ~=0 then
        local Nico_Bomb_Sprites = options["Nico_Bomb_Sprites"].value
        -- iterate our files and add the assets so the game can find them.
            modApi:appendAsset("img/advanced/units/player/bombling.png", mod.resourcePath .."img/bombling"..Nico_Bomb_Sprites..".png")
            modApi:appendAsset("img/advanced/units/player/bombling_a.png", mod.resourcePath .."img/bombling"..Nico_Bomb_Sprites.."_a.png")
            modApi:appendAsset("img/advanced/units/player/bombling_death.png", mod.resourcePath .."img/bombling"..Nico_Bomb_Sprites.."_death.png")
    end
end
function mod:metadata()--Don't make any changes to resources in metadata. metadata runs regardless of if your mod is enabled or not.

	modApi:addGenerationOption(
		"Nico_Bomb_Sprites", "Walking Bomb's Sprites",
		"What the Sprites of the Walking Bomb will be. REQUIRES RESTART TO TAKE EFFECT!",
		{
			strings = { "Metal Legs.", "Plate Legs.", "Frontal Plate legs,Metal Back Legs.", "Metal Legs, Plate Body"},
			values = { 0, 1, 2, 3},
			value = 0
		}
	)
end
function mod:load(options, version)
end

return mod