
local mod = mod_loader.mods[modApi.currentMod]
local path = mod.resourcePath

local function isCreep(p)
	assert(GAME)
	assert(Board)
	return GAME.lmn_creep[p2idx(p)]
end
local function isCreepable(p)
	assert(Board)
	local terrain = Board:GetTerrain(p)

	return
		terrain ~= TERRAIN_FOREST	and
		terrain ~= TERRAIN_MOUNTAIN	and
		terrain ~= TERRAIN_WATER	and
		terrain ~= TERRAIN_HOLE		and
		terrain ~= TERRAIN_ICE		and
		not Board:IsFire(p)
end

modApi:copyAsset("img/combat/icons/icon_shield_glow.png", "img/combat/icons/Nico_icon_shield_glow.png")
modApi:appendAsset("img/effects/colonyattack_front.png", path.. "img/effects/colonyattack_front.png")
modApi:appendAsset("img/effects/colonyattack_back.png", path.. "img/effects/colonyattack_back.png")
modApi:appendAsset("img/weapons/Nico_Floater_Atk.png", path .."img/weapons/Nico_Floater_Atk.png")
modApi:appendAsset("img/weapons/Nico_Colony_Impaler.png", path .."img/weapons/Nico_Colony_Impaler.png")
modApi:appendAsset("img/weapons/Nico_Colony_Piercer.png", path .."img/weapons/Nico_Colony_Piercer.png")
local a = ANIMS
	a.ColonyAttack_Back = a.PsionAttack_Back:new{
		Image = "effects/colonyattack_back.png",
		NumFrames = 9,
		Loop = false,
		Lengths = {0.04,0.04,0.04,0.04,0.2,.12,.12,0.09,0.08,0.07},
		PosX = -32,
		PosY = -8,
		Layer = LAYER_BACK
	}

	a.ColonyAttack_Front = a.PsionAttack_Front:new{
		Image = "effects/colonyattack_front.png",
		Layer = LAYER_FRONT,
		PosX = -23,
		PosY = -8,
	}

Nico_Floater_Atk = Skill:new{
	Name = "Spawn Colony",
    Class = "TechnoVek",
	Description = "Spawns a Techno-Colony and Creep at its tile and moves to a tile in a radius, radius increases with movement speed.\nIf both Upgrades are Powered, Techno-Colonies gain 1 movement speed.\nTechno-Colonies can't make Creep, but can use enemy Creep to expand their target areas.",
	Spawn = "Nico_Techno_Colony",
	Icon = "weapons/Nico_Floater_Atk.png",
	Upgrades = 2,
	UpgradeList = {"Resistance","Shield On Lethal"},
	UpgradeCost = {2,2},
	PowerCost = 2,
    PathSize = 1,
	TipImage = {
		CustomPawn = "Nico_Techno_Floater",
		Unit = Point(2,2),
		Target = Point(1,2),
		Enemy = Point(2,0),
	}
}

Nico_Floater_Atk_A = Nico_Floater_Atk:new{
	UpgradeDescription = "+1 Max Health for Techno-Colonies.\nPiercer deals Self Damage equal to Health.",
	Spawn = "Nico_Techno_Colony_A",
}
Nico_Floater_Atk_B = Nico_Floater_Atk:new{
	UpgradeDescription = "On Kill, with either Weapon of the Techno-Colony, Shields all adjacent Allies.",
	Spawn = "Nico_Techno_Colony_B",
}
Nico_Floater_Atk_AB = Nico_Floater_Atk_A:new{
	Spawn = "Nico_Techno_Colony_AB",
}
function Nico_Floater_Atk:GetTargetArea(point)
    local ret = PointList()
    local speed = math.ceil(Pawn:GetMoveSpeed()/2)
	if not Pawn:IsGrappled() then
		ret = Board:GetReachable(point, speed, Pawn:GetPathProf())
	else
		for i = DIR_START, DIR_END do
        	local curr = point + DIR_VECTORS[i]
            if Board:IsValid(curr) and not Board:IsBlocked(curr, Pawn:GetPathProf()) then
            	ret:push_back(curr)
            end
        end
	end
	return ret
end

function Nico_Floater_Atk:GetSkillEffect(p1, p2)
	ret = SkillEffect()
	local direction = GetDirection(p2 - p1)

	local pawn = Board:GetPawn(p1)
	ret:AddBounce(p1, -2)
	ret:AddSound("enemy/shared/crawl_out")

	local pathing = pawn:GetPathProf()

	if not Board:IsBlocked(p2, pathing) then
		ret:AddMove(Board:GetPath(p1, p2, pathing), NO_DELAY)
	end

	local d = SpaceDamage(p1)
	d.sPawn = self.Spawn
	ret:AddBounce(p1, -3)
	ret:AddDamage(d)
	if Board:IsTipImage() then
		ret:AddDelay(-1)
		ret:AddDelay(2)
		ret:AddScript(string.format(
			"Board:GetPawn(%s):FireWeapon(%s, %s)",
			self.TipImage.Unit:GetString(),
			self.TipImage.Enemy:GetString(),
			math.random(1,2)
			))
	elseif not IsTestMechScenario() then
		if not isCreep(p1) and isCreepable(p1) then
			ret:AddScript(string.format("lmn_ColonyAtk1:AddCreep(%s, 0)", p1:GetString()))
		end
	end

	return ret
end

Nico_Colony_Impaler = Skill:new{
	Name = "Impaler",
	Description = "Impales an enemy in a range equal to the Techno-Colony's Health + 2, + 1 Damage when Shielded. Creep can expand target area.",
    Class = "TechnoVek",
	Icon = "weapons/Nico_Colony_Impaler.png",
	Damage = 1,
	Range = 3,
	Upgrades = 2,
	UpgradeList = {"Resistance","Shield On Lethal"},
	UpgradeCost = {2,2},
	Shield_on_Kill = false,
	TipImage = {
		CustomPawn = "Nico_Techno_Colony",
		Unit = Point(2,2),
		Enemy = Point(3,1),
		Building = Point(1,1),
		Mountain = Point(2,1),
		Target = Point(3,1)
	}
}

Nico_Colony_Impaler_B = Nico_Colony_Impaler:new{
	OnKill = "Shield Adjacent Allies",
	Shield_on_Kill = true,
}
function Nico_Colony_Impaler:GetTargetArea(point)
	local range = Pawn:GetMaxHealth() + self.Range-1
	local board_size = Board:GetSize()
	local ret = general_DiamondTarget(point, range)
	for i = 0, board_size.x - 1 do
		for j = 0, board_size.y - 1  do
            local p = Point(i,j)
			if isCreep(p) and not list_contains(extract_table(ret), p) then
				ret:push_back(p)
			end
		end
	end
	return ret
end

function Nico_Colony_Impaler:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local amount = Pawn:IsShield() and 1 or 0
	local Damage = SpaceDamage(p2,self.Damage + amount)
	Damage.sAnimation = "lmn_ExploColony"
	Damage.bKO_Effect = self.Shield_on_Kill and Board:IsDeadly(Damage,Pawn)
	if Damage.bKO_Effect then
		for dir = DIR_START, DIR_END do
			local spaceDamage = SpaceDamage(p2 + DIR_VECTORS[dir], 0)
			if Board:IsBuilding(p2 + DIR_VECTORS[dir]) or Board:GetPawnTeam(p2 + DIR_VECTORS[dir]) == TEAM_PLAYER then
				spaceDamage.iShield = 1
				ret:AddDamage(spaceDamage)
			end
		end
	end
	ret:AddSound("enemy/digger_1/move")
	ret:AddSound("enemy/shared/moved")
	ret:AddSound("enemy/spider_soldier_1/attack_egg_land")
	ret:AddDelay(.04 * 3)
	ret:AddSound("impact/generic/general")
	ret:AddBounce(Damage.loc,1)
	ret:AddDamage(Damage)
	return ret
end

Nico_Colony_Piercer = Skill:new{
	Name = "Piercer",
	Description = "Pierces an enemy in a Diamond-shaped Area, dealing Deadly Damage to target and self, pushes all adjacent targets. Creep can expand target area.",
    Class = "TechnoVek",
	Damage = 2,
	TipDamageCustom = "Max Health times 2",
	Icon = "weapons/Nico_Colony_Piercer.png",
	SelfDamage = DAMAGE_DEATH,
    ArtillerySize = 2,
	Range = 3,
	Upgrades = 2,
	UpgradeList = {"Resistance","Shield On Lethal"},
	UpgradeCost = {2,2},
	Shield_on_Kill = false,
	Resistance = false,
	TipImage = {
		CustomPawn = "Nico_Techno_Colony",
		Unit = Point(2,2),
		Enemy = Point(3,1),
		Building = Point(1,1),
		Mountain = Point(2,1),
		Target = Point(3,1)
	}
}

function Nico_Colony_Piercer:GetTargetArea(point)
	local board_size = Board:GetSize()
	local ret = general_DiamondTarget(point, self.Range)
	for i = 0, board_size.x - 1 do
		for j = 0, board_size.y - 1  do
            local p = Point(i,j)
			if isCreep(p) and not list_contains(extract_table(ret), p) then
				ret:push_back(p)
			end
		end
	end
	return ret
end

function Nico_Colony_Piercer:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local selfAmount = self.SelfDamage
	local Health = Board:GetPawn(p1):GetHealth() 
    if self.Resistance and self.SelfDamage ~= DAMAGE_DEATH then
        selfAmount = Health
    end
	local damAmount = self.Damage*Health
    local selfDam = SpaceDamage(p1, selfAmount)
	local Damage = SpaceDamage(p2,damAmount)
	Damage.sAnimation = "ColonyAttack_Front"--"lmn_ExploColony"
	Damage.bKO_Effect = self.Shield_on_Kill and Board:IsDeadly(Damage,Pawn)
	local scriptShield = ""
	local check = false
	for dir = DIR_START, DIR_END do
		local spaceDamage = SpaceDamage(p2 + DIR_VECTORS[dir], 0,dir)
		if Damage.bKO_Effect then
			if Board:IsBuilding(p2 + DIR_VECTORS[dir]) or Board:GetPawnTeam(p2 + DIR_VECTORS[dir]) == TEAM_PLAYER
			and spaceDamage.loc ~= p1 then
				spaceDamage.iShield = 1
			elseif spaceDamage.loc == p1 and selfDam.iDamage ~= DAMAGE_DEATH then
				scriptShield = scriptShield.. " Board:GetPawn("..spaceDamage.loc:GetString().."):SetShield(true)"
				spaceDamage.sImageMark = "combat/icons/Nico_icon_shield_glow.png"
			end
		end
		if spaceDamage.loc == selfDam.loc then
			selfDam.iPush = spaceDamage.iPush
			check = true
			ret:AddDamage(selfDam)
		elseif selfDam.loc == Damage.loc then
			Damage.iDamage = damAmount + selfAmount
			check = true
		else
			ret:AddDamage(spaceDamage)
		end
	end
	ret:AddSound("enemy/digger_1/move")
	ret:AddSound("enemy/shared/moved")
	ret:AddSound("enemy/spider_soldier_1/attack_egg_land")
	ret:AddDelay(.04 * 3)
	ret:AddSound("impact/generic/general")
	ret:AddBounce(Damage.loc,1)
	ret:AddDamage(Damage)
	ret:AddAnimation(Damage.loc,"ColonyAttack_Back")
	if not check then
		ret:AddDamage(selfDam)
	end
	if scriptShield ~= "" then
        ret:AddScript(scriptShield)
    end
	return ret
end

Nico_Colony_Piercer_A = Nico_Colony_Piercer:new{
	SelfDamage = 2,
	Resistance = true,
}

Nico_Colony_Piercer_B = Nico_Colony_Piercer:new{
	OnKill = "Shield Adjacent Allies",
	Shield_on_Kill = true,
}

Nico_Colony_Piercer_AB = Nico_Colony_Piercer_A:new{
	OnKill = "Shield Adjacent Allies",
	Shield_on_Kill = true,
}