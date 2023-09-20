local mod = {
	id = "Nico_ZomSpi-weapon",
    name = "Reanimated Spiderling",
    description="Adds custom weapon icon for the Reanimated Spiderling and realigns the shadows on its sprites.",
	modApiVersion = "2.8.2",
	gameVersion = "1.2.83",
    version="ery thankful to the Hotseat mod for making the original sprite (which I palette swapped) and to Tosx for making the pilot Simon Coil and their gimmick.",
	icon = "img/icon.png",
	dependencies = {"CauldronPilots"},
	libs = {},
}

function mod:init()
    --zombie spider
        modApi:appendAsset("img/units/enemy/spiderlingZ.png", mod.resourcePath .."img/units/player/spiderlingZ.png")
        modApi:appendAsset("img/units/enemy/spiderlingZ_death.png", mod.resourcePath .."img/units/player/spiderlingZ_death.png")
        modApi:appendAsset("img/units/enemy/spiderlingZa.png", mod.resourcePath .."img/units/player/spiderlingZa.png")
        modApi:appendAsset("img/weapons/spiderlingZ_wep_portrait.png",mod.resourcePath.."img/weapons/spiderlingZ_wep_portrait.png")
        SpiderlingAtkZ.SelfDamage = 1
        function SpiderlingAtkZ:GetSkillEffect(p1, p2)
            local ret = SkillEffect()
            local dir = GetDirection(p2 - p1)

            local damage = SpaceDamage(p2, self.Damage, dir)
            damage.sAnimation = "explospear1_"..dir
            ret:AddMelee(p1, damage)
            
            ret:AddDamage(SpaceDamage(p1,1))
            
            return ret
        end
end

function mod:load(options, version)
end

return mod