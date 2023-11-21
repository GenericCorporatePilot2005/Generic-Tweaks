local mod = {
	id = "Better_Lava_Flows",
	name = "Better Lava Flows",
	version = "1.0",
	requirements = {},
	dependencies = { --This requests modApiExt from the mod loader
		modApiExt = "1.18", --We can get this by using the variable `modapiext`
	},
	modApiVersion = "2.9.2",
	icon = "icon.png",
	enabled=false,
}

function mod:init()
	require(self.scriptPath.."env_volcano")
end
function mod:load(options, version)
end
return mod