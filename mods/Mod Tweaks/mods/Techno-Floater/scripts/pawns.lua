
local mod = mod_loader.mods[modApi.currentMod]
local path = mod.resourcePath
local writepath = "img/units/player/"
local readpath = path .. writepath
local imagepath = writepath:sub(5,-1)
modApi:appendAsset("img/portraits/pilots/Pilot_Nico_Techno_Floater.png", path.."img/portraits/pilots/Pilot_Nico_Techno_Floater.png")
modApi:appendAsset("img/portraits/npcs/Nico_colony.png", path.."img/portraits/npcs/Nico_colony.png")
CreatePilot{
    Id = "Pilot_Nico_Techno_Floater",
    Personality = "Vek",
    Sex = SEX_VEK,
    Name = "Techno-Floater",
    Skill = "Survive_Death",
    Rarity = 0,
    Blacklist = {"Invulnerable","Popular"},
}

modApi:appendAssets(writepath,writepath)

local a = ANIMS
a.Nico_Floater = a.MechUnit:new{Image = imagepath .."Nico_Floater.png", PosX = -16, PosY = -21}
a.Nico_Floatera = a.Nico_Floater:new{Image = imagepath .."Nico_Floater_a.png", NumFrames = 12}
a.Nico_Floater_broken = a.Nico_Floater:new{Image = imagepath .."Nico_Floater_broken.png", PosX = -22, PosY = -18}
a.Nico_Floaterw_broken = a.Nico_Floater_broken:new{Image = imagepath .."Nico_Floater_w_broken.png", PosY = -16}
a.Nico_Floater_ns = 	a.MechIcon:new{ Image = imagepath .."Nico_Floater_ns.png" }
Nico_Techno_Floater = Pawn:new{
	Name = "Techno-Floater",
	Class = "TechnoVek",
	Health = 3,
	MoveSpeed = 2,
	Image = "Nico_Floater",
	ImageOffset = 8,
	SkillList = { "Nico_Floater_Atk" },
	SoundLocation = "/enemy/jelly/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_BLOB,
	Massive = true,
	Flying = true,
	LargeShield = true,
}

local function isCreep(p)
	assert(GAME)
	assert(Board)
	return GAME.lmn_creep[p2idx(p)]
end

Nico_Techno_Floater_Move = Move:new{}
local original_MoveGetTargetArea = Move.GetTargetArea

local original_MoveGetSkillEffect = Move.GetSkillEffect
function Move:GetTargetArea(p1, p2)
	local ret

	if Pawn:GetType() == "Nico_Techno_Floater" then
		ret = Nico_Techno_Floater_Move:GetTargetArea(p1, p2)
	else
		ret = original_MoveGetTargetArea(self, p1, p2)
	end

    return ret
end

function Nico_Techno_Floater_Move:GetTargetArea(point)
    local ret = PointList()
    local speed = Pawn:GetMoveSpeed()
	local pawnPath = Pawn:GetPathProf()
	ret = Board:GetReachable(point, speed, pawnPath)
	local board_size = Board:GetSize()
	for i = 0, board_size.x - 1 do
		for j = 0, board_size.y - 1  do
            local p = Point(i,j)
			if isCreep(p) and not list_contains(extract_table(ret), p)
			and Board:IsValid(p) and not Board:IsBlocked(p,pawnPath) then
				ret:push_back(p)
			end
		end
	end
    return ret
end

function Nico_Techno_Floater_Move:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	ret:AddMove(Board:GetPath(p1, p2, Pawn:GetPathProf()), FULL_DELAY)
	return ret
end

function Move:GetSkillEffect(p1, p2)
	local ret

	if Pawn:GetType() == "Nico_Techno_Floater" then
		ret = Nico_Techno_Floater_Move:GetSkillEffect(p1, p2)
	else
		ret = original_MoveGetSkillEffect(self, p1, p2)
	end

    return ret
end

a.Nico_Colony  = a.MechUnit:new{Image = imagepath .."Nico_Colony.png", PosX = -23, PosY = 5}
a.Nico_Colonya = a.Nico_Colony:new{ Image = imagepath.."Nico_Colony_a.png", PosY = 0, NumFrames = 10,
	Frames = {9,8,7,6,5,4,3,2,1,0},
	Lengths = {
		6,
		.10,
		.10,
		.20,
		.20,
		.20,
		.20,
		.20,
		.10,
		.10,
	}
}
a.Nico_Colonyd = a.Nico_Colony:new{ Image = imagepath.."Nico_Colony_d.png", PosX = -33, PosY = -15, NumFrames = 8, Time = 0.14, Loop = false }

Nico_Techno_Colony = Pawn:new{
	Name = "Techno-Colony",
	Health = 1,
	MoveSpeed = 0,
	Image = "Nico_Colony",
	ImageOffset = 8,
	SkillList = { "Nico_Colony_Impaler","Nico_Colony_Piercer"},
	SoundLocation = "/enemy/blob_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	Pushable = false,
	IgnoreSmoke = true,
	Portrait = "npcs/Nico_colony",
}
Nico_Techno_Colony_A = Nico_Techno_Colony:new{
	Health = 2,
	SkillList = { "Nico_Colony_Impaler","Nico_Colony_Piercer_A"},
}
Nico_Techno_Colony_B = Nico_Techno_Colony:new{
	SkillList = { "Nico_Colony_Impaler_B","Nico_Colony_Piercer_B"},
}
Nico_Techno_Colony_AB = Nico_Techno_Colony_A:new{
	MoveSpeed = 1,
	SkillList = { "Nico_Colony_Impaler_B","Nico_Colony_Piercer_AB"},
}

function Nico_Techno_Colony:GetDeathEffect(p1)
    local ret = SkillEffect()
    local bnb = mod_loader.mods["lmn_bots_and_bugs"]
    local astar = bnb.libs.astar
    
    local function currentCreepCheck(p)
        return GAME.lmn_creep[p2idx(p)]
    end

    local creep = astar:getTraversable(p1, currentCreepCheck)
    local activeColonies = {}

    for _, n in pairs(creep) do
        local pawn = Board:GetPawn(n.loc)
        if _G.IsAnyColony(pawn) then
            local type = pawn:GetType()
            local weapon = _G[_G[type].SkillList[1]]
            local range = (weapon and weapon.Range) or 3
            table.insert(activeColonies, {loc = pawn:GetSpace(), range = range})
        end
    end

    for _, n in pairs(creep) do
        local destroy = true
        for _, colony in ipairs(activeColonies) do
            if n.loc:Manhattan(colony.loc) <= colony.range then
                destroy = false
                break
            end
        end

        if destroy then
            ret:AddScript(string.format("lmn_ColonyAtk1:DestroyCreep(%s, %s)", n.loc:GetString(), n.loc:Manhattan(p1)))
        end
    end
    return ret
end