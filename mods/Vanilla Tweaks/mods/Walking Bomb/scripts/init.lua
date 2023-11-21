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
            ret:AddAnimation(damage.loc,"ExploRepulse1", ANIM_NO_DELAY)
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
    local Nico_Bomb_Sprites = options["Nico_Bomb_Sprites"].value
    if Nico_Bomb_Sprites==2 then
        -- iterate our files and add the assets so the game can find them.
        modApi:appendAsset("img/advanced/units/player/bombling.png", mod.resourcePath .."img/bombling1.png")
        modApi:appendAsset("img/advanced/units/player/bombling_a.png", mod.resourcePath .."img/bombling1_a.png")
        modApi:appendAsset("img/advanced/units/player/bombling_death.png", mod.resourcePath .."img/bombling1_death.png")
    elseif Nico_Bomb_Sprites==3 then
        -- make a list of our files.
        modApi:appendAsset("img/advanced/units/player/bombling.png", mod.resourcePath .."img/bombling2.png")
        modApi:appendAsset("img/advanced/units/player/bombling_a.png", mod.resourcePath .."img/bombling2_a.png")
        modApi:appendAsset("img/advanced/units/player/bombling_death.png", mod.resourcePath .."img/bombling2_death.png")
    elseif Nico_Bomb_Sprites==4 then
        -- make a list of our files.
        modApi:appendAsset("img/advanced/units/player/bombling.png", mod.resourcePath .."img/bombling3.png")
        modApi:appendAsset("img/advanced/units/player/bombling_a.png", mod.resourcePath .."img/bombling3_a.png")
        modApi:appendAsset("img/advanced/units/player/bombling_death.png", mod.resourcePath .."img/bombling3_death.png")
    end
end
function mod:metadata()--Don't make any changes to resources in metadata. metadata runs regardless of if your mod is enabled or not.

	modApi:addGenerationOption(
		"Nico_Bomb_Sprites", "Walking Bomb's Sprites",
		"What the Sprites of the Walking Bomb will be. REQUIRES RESTART TO TAKE EFFECT!",
		{
			strings = { "Metal Legs.", "Plate Legs.", "Frontal Plate legs,Metal Back Legs.", "Metal Legs, Plate Body"},
			values = { 1, 2, 3, 4},
			value = 1
		}
	)
end
function mod:load(options, version)
end

return mod