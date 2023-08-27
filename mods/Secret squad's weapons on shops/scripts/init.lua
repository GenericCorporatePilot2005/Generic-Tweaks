
-- init.lua is the entry point of every mod

local mod = {
	id = "SSweaponsonShops",
	name = "Secret squad's weapons on shops",
	version = "0",
	requirements = {},
	dependencies = { --This requests modApiExt from the mod loader
		modApiExt = "1.17", --We can get this by using the variable `modapiext`
	},
	modApiVersion = "2.8.3",
	icon = "img/icon.png"
}

function mod:init()
	modApi:addWeaponDrop("Vek_Beetle")
	modApi:addWeaponDrop("Vek_Hornet")
	modApi:addWeaponDrop("Vek_Scarab")
end

function mod:load( options, version)
	-- after we have added our mechs, we can add a squad using them.
end

return mod