local mod = modApi:getCurrentMod()
local path = mod.scriptPath
require(path .."palettes")
--Chili--
lmn_Chili = lmn_Chili:new{
    SkillList = { "Nico_TW_chili" },
}
--Puffer--
lmn_Puffer = lmn_Puffer:new{
	SkillList = { "Nico_TW_puffer" },
    IgnoreSmoke=true,
    MoveSpeed = 4,
}
--Chomper--
lmn_Chomper = lmn_Chomper:new{
	SkillList = { "Nico_TW_chomper" },
    MoveSpeed = 4,
}