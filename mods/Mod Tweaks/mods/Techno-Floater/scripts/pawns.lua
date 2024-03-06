
CreatePilot{
    Id = "Pilot_Nico_Techno_Floater",
    Personality = "Vek",
    Sex = SEX_VEK,
    Name = "Techno-Floater",
    Skill = "Survive_Death",
    Rarity = 0,
    Blacklist = {"Invulnerable","Popular"},
}

Nico_Techno_Floater = Pawn:new{
	Name = "Techno-Floater",
	Class = "TechnoVek",
	Health = 3,
	MoveSpeed = 2,
	Image = "lmn_techno_wyrm",
	ImageOffset = 8,
	SkillList = { "Nico_Floater_Atk" },
	SoundLocation = "/enemy/jelly/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_BLOB,
	Massive = true,
	Flying = true,
}