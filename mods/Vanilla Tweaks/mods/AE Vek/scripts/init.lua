
-- init.lua is the entry point of every mod

local mod = {
	id = "Nico_AEVEK_Tweaks",
	name = "Advanced Edition Vek",
    description="Reduces the both movement of Tumblebugs and the hp of moths by 1.",
	version = "1",
	requirements = {},
	dependencies = { --This requests modApiExt from the mod loader
		modApiExt = "1.17", --We can get this by using the variable `modapiext`
	},
	modApiVersion = "2.8.3",
	icon = "img/icon.png"
}

function mod:init()
    --minus 1 movement for Tumblebugs
    Dung1.MoveSpeed = 2
    Dung2.MoveSpeed = 2
    DungBoss.MoveSpeed = 2
    --minus 1 hp for moths
    Moth1.Health = 2
    Moth2.Health = 4
end

function mod:load( options, version)
end

return mod