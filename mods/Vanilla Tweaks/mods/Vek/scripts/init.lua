
-- init.lua is the entry point of every mod

local mod = {
	id = "Nico_VVEK_Tweaks",
	name = "Vanilla Vek",
    description="Tweaks Vanilla Vek, mostly nerfs and improving visual elements, for example, reduces the both movement of Tumblebugs and the hp of moths by 1.",
	version = "1",
	requirements = {},
	dependencies = { --This requests modApiExt from the mod loader
		modApiExt = "1.17", --We can get this by using the variable `modapiext`
	},
	modApiVersion = "2.8.3",
	icon = "img/icon.png",
	enabled=false,
}

function mod:init()
    --minus 1 movement for Tumblebugs
    Dung1.MoveSpeed = 2
    Dung2.MoveSpeed = 2
    DungBoss.MoveSpeed = 2
    --minus 1 hp for moths
    Moth1.Health = 2
    Moth2.Health = 4
	--visual tweaks to Leader FireFly and Centipede
	FireflyAtkB.Projectile = "effects/shot_fireflyB"
	FireflyAtkB.Explosion = "ExploFireflyB"
	CentipedeAtkB.Explosion = "ExploFireflyB"
	CentipedeAtkB.Projectile = "effects/shot_fireflyB"
end

function mod:load( options, version)
end

return mod