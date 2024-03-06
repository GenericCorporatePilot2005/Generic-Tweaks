
local mod = mod_loader.mods[modApi.currentMod]
local path = mod.resourcePath
local a = ANIMS
local worldConstants = require(mod.scriptPath .."libs/worldConstants")
local tips = mod.libs.tutorialTips
local astar = require(path .."scripts/libs/astar")
local utils = require(path .."scripts/libs/utils")
local writepath = "img/units/player/"
local readpath = path .. writepath
local imagepath = writepath:sub(5,-1)
local this = {}
local cycle = 0
--Lemon's Real Mission Checker
local function isRealMission()
	local mission = GetCurrentMission()
		
	return true
		and mission ~= nil
		and mission ~= Mission_Test
		and Board
		and Board:IsMissionBoard()
	end

-- returns true if the tile has creep.
local function isCreep(p)
	assert(GAME)
	assert(Board)
	return GAME.lmn_creep[p2idx(p)]
end

local function IsColony(pawn)
	return
		list_contains(_G[pawn:GetType()].SkillList, "lmn_ColonyAtk1") or
		list_contains(_G[pawn:GetType()].SkillList, "lmn_ColonyAtk2") or
		list_contains(_G[pawn:GetType()].SkillList, "lmn_ColonyAtkB") or
        list_contains(_G[pawn:GetType()].SkillList, "Nico_Colony_Atk")
end
-- returns true if creep can exist on this tile.
local function isCreepable(p)
	assert(Board)
	local terrain = Board:GetTerrain(p)

	return
		terrain ~= TERRAIN_FOREST	and -- I don't feel like dealing with the complications of forests.
		terrain ~= TERRAIN_MOUNTAIN	and
		terrain ~= TERRAIN_WATER	and -- counts as water/acidwater/lava
		terrain ~= TERRAIN_HOLE		and
		terrain ~= TERRAIN_ICE		and
		not Board:IsFire(p)
end
Nico_Floater_Atk = Skill:new{
	Name = "Spawn Colony",
    Class = "TechnoVek",
	Description = "Spawns a Colony at its tile and moves to an adjacent tile.",
	Spawn = "Nico_Techno_Colony",
    PathSize = 1,
	CustomTipImage = "Nico_Floater_Atk_Tip",
	TipImage = {
		CustomPawn = "Nico_Techno_Floater",
		Unit = Point(2,2),
		Target = Point(2,2),
		Escape = Point(1,2)
	}
}
Nico_Techno_Colony = Pawn:new{
	Name = "Techno-Colony",
	Health = 1,
	MoveSpeed = 0,
	Ranged = 1,
	Image = "lmn_colony",
	ImageOffset = 0,
	SkillList = { "Nico_Colony_Atk" },
	SoundLocation = "/enemy/blob_1/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_FLESH,
	Pushable = false,
	IsDeathEffect = true,
}
function Nico_Techno_Colony:GetDeathEffect(p1)
	local ret = SkillEffect()

	local creep = astar:getTraversable(p1, isCreep)
	local colonies = {}
	local remCreep = {}

	for _, n in pairs(creep) do
		local pawn = Board:GetPawn(n.loc)

		-- if we detect another colony on connected creep, exit.
		if pawn and IsColony(pawn) then
			local type = pawn:GetType()
			local weapon = _G[_G[type].SkillList[1]]
			table.insert(colonies, {loc = pawn:GetSpace(), range = weapon.Range})
		end
	end

	-- destroy all disconnected creep.
	for _, n in pairs(creep) do
		local destroy = true

		for _, colony in ipairs(colonies) do
			if n.loc:Manhattan(colony.loc) <= colony.range then
				destroy = false
				break
			end
		end

		if destroy then
			table.insert(remCreep, n.loc)
		end
	end

	if #remCreep > 0 then
		ret:AddScript(string.format([[
			local tips = mod_loader.mods.lmn_bots_and_bugs.libs.tutorialTips;
			tips:trigger("Creep_Death", %s);
		]], p1:GetString()))
	end

	for _, p in ipairs(remCreep) do
		ret:AddScript(string.format("lmn_ColonyAtk1:DestroyCreep(%s, %s)", p:GetString(), p:Manhattan(p1)))
	end

	return ret
end
function Nico_Floater_Atk:GetTargetArea(point)
    local speed = Pawn:GetMoveSpeed()
    if (speed)%2==0 then
        speed=speed/2
    else
        speed=(speed-1)/2
    end
	return Board:GetReachable(point, speed, Pawn:GetPathProf())
end
function Nico_Floater_Atk:GetSkillEffect(p1, p2)
	ret = SkillEffect()
	local direction = GetDirection(p2 - p1)

	--  attacks are weird. Make sure
	-- we have the correct pawn.
	local pawn = Board:GetPawn(p1)
	ret:AddBounce(p1, -2)
	ret:AddSound("enemy/shared/crawl_out")

	if not isCreep(p1) then
		ret:AddScript(string.format("Nico_Floater_Atk:AddCreep(%s, 0)", p1:GetString()))
	end

	local pathing = pawn:GetPathProf()
	ret:AddDelay(1)

	if not Board:IsBlocked(p2, pathing) then
		ret:AddMove(Board:GetPath(p1, p2, pathing), NO_DELAY)
	end

	local d = SpaceDamage(p1)
	d.sPawn = self.Spawn
	ret:AddBounce(p1, -3)
	ret:AddDamage(d)

	return ret
end
Nico_Floater_Atk_Tip = Nico_Floater_Atk:new{}

Nico_Colony_Atk = Skill:new{
	Name = "Impaler",
	Description = "Expands creep, and impales an enemy reachable by creep.",
	Class = "Enemy",
	Damage = 1,
    ArtillerySize = 2,
	Range = 3,
	CustomTipImage = "Nico_Colony_Atk_Tip";
	TipImage = {
		CustomPawn = "Nico_Techno_Colony",
		Unit = Point(2,2),
		Enemy = Point(3,1),
		Building = Point(1,1),
		Mountain = Point(2,1),
		Target = Point(2,2)
	}
}
Nico_Colony_Atk_Tip = Nico_Colony_Atk:new{}
function Nico_Colony_Atk:GetTargetArea(point)
	return general_DiamondTarget(point, self.ArtillerySize)
end
function Nico_Colony_Atk:DeclareCreep(p)
	assert(GAME)
	GAME.lmn_creep[p2idx(p)] = {
		draw = false,
		loc = p,
		age = Game:GetTurnCount(),
		sprout = 0,
		t0 = 0
	}
end

-- adds creep to a tile and draws the graphics.
function Nico_Colony_Atk:AddCreep(p, sproutDelay)
	assert(GAME)
	local creep = GAME.lmn_creep
	local pid = p2idx(p)
	local v = creep[pid] or {}

	creep[pid] = v
	v.draw = true
	v.loc = p
	v.age = Game:GetTurnCount()
	v.sprout = sproutDelay or 0
	v.t0 = math.random(60) % 60
end

-- requests a tile have its creep removed with animation.
function Nico_Colony_Atk:DestroyCreep(p, distance)
	assert(GAME)

	local creep = GAME.lmn_creep[p2idx(p)]

	if isCreep(p) and not creep.destroy then
		creep.requestDestroy = true
		creep.distance = distance
	end
end

-- pulls creep down for a duration.
-- if creep is requested to be destroyed, it will not remerge.
function Nico_Colony_Atk:RetractCreep(p, duration)
	assert(GAME)

	if isCreep(p) then
		GAME.lmn_creep[p2idx(p)].sprout = duration
	end
end

-- completely removes the creep from a tile instantly.
function Nico_Colony_Atk:RemCreep(p)
	assert(GAME)
	GAME.lmn_creep[p2idx(p)] = nil
end

function Nico_Floater_Atk_Tip:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local creep = {}
	local pawn = Board:GetPawn(p1)

	local function addCreepAnim(p)
		if isCreepable(p) then
			ret:AddBounce(p, -2)
			ret:AddDelay(0.08)
			ret:AddScript(string.format("Board:AddAnimation(%s, 'lmn_creep_front_tip', NO_DELAY)", p:GetString()))

			-- should technically be in a script, but this will do for the tipimage.
			table.insert(creep, p)
		end
	end

	addCreepAnim(p1)

	ret:AddMove(Board:GetPath(p1, self.TipImage.Escape, pawn:GetPathProf()), FULL_DELAY)

	local d = SpaceDamage(p1)
	d.sPawn = self.Spawn
	ret:AddBounce(p1, -3)
	ret:AddDamage(d)

	ret:AddDelay(1.2)

	return ret
end

function Nico_Colony_Atk_Tip:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local creep = {}

	local function isCreep(p)
		return list_contains(creep, p)
	end

	local function addCreep(p)
		if isCreepable(p) then
			if Board:IsBlocked(p, PATH_PROJECTILE) then
				Board:AddAnimation(p, "lmn_creep_front_init_tip", NO_DELAY)
			else
				Board:AddAnimation(p, "lmn_creep_back_init_tip", NO_DELAY)
			end

			table.insert(creep, p)
		end
	end

	local function addCreepAnim(p)
		if isCreepable(p) then
			ret:AddBounce(p, -2)
			ret:AddDelay(0.08)
			if Board:IsBlocked(p, PATH_PROJECTILE) then
				ret:AddAnimation(p, "lmn_creep_front_tip")
				if p ~= p1 then
					ret:AddScript(string.format("Board:Ping(%s, GL_Color(255,66,66))", p:GetString()))
				end
			else
				ret:AddAnimation(p, "lmn_creep_back_tip")
			end

			-- should technically be in a script, but this will do for the tipimage.
			table.insert(creep, p)
		end
	end

	addCreep(p1)

	for dir = DIR_START, DIR_END do
		local curr = p1 + DIR_VECTORS[dir]
		addCreep(curr)
	end

	local creep = astar:getTraversable(p1, isCreep)
	for _, n in pairs(creep) do
		for dir = DIR_START, DIR_END do
			local curr = n.loc + DIR_VECTORS[dir]
			if not isCreep(curr) then
				addCreepAnim(curr)
			end
		end
	end

	local target = p2
    if not isRealMission() then 
        target = self.TipImage.Enemy
    end
	local d = SpaceDamage(target, self.Damage)
	local path = astar:getPath(p1, target, isCreep)

	for i = 1, #path do
		local p = path[i]
		local dir

		if i == 1 then
			dir = GetDirection(path[i+1] - p)
		else
			dir = GetDirection(p - path[i-1])
		end

		ret:AddBounce(p, -2)
		ret:AddScript(string.format("Board:AddBurst(%s, 'Emitter_Burst_$tile', %s)", p:GetString(), tostring(dir)))
		ret:AddDelay(0.16)
	end

	ret:AddAnimation(target, "lmn_ExploColony")
	ret:AddDelay(.04 * 3)
	ret:AddDamage(d)

	return ret
end
sdlext.addFrameDrawnHook(function()
    local mission = GetCurrentMission()
    local g = GAME
    local removeCreep = false

    if not Game or not g then
        return
    end

    if not Board then
        g.lmn_creep = {}
        return
    end

    g.lmn_creep = g.lmn_creep or {}
    local rem = {}

    -- cycle counter every 60 frames (1 second)
    cycle = (cycle + 1) % 60

    if not mission and not isMissionEnd then
        isMissionEnd = true
        removeCreep = true
    end

    for i, v in pairs(g.lmn_creep) do
        local p = idx2p(i)

        if removeCreep then
            table.insert(rem, i)
        elseif Board:GetBusyState() == 0 then
            if v.requestDestroy then
                v.requestDestroy = false
                table.insert(rem, i)
            elseif not isCreepable(p) and not v.destroy then
                table.insert(rem, i)
            end
        end

        if v.draw then
            local t = (v.t0 + cycle) % 60
            local doDraw = true
            local anim = ""
            local suffix = math.floor(t / 15) -- divide (0-59) by 15 to get frame 0 through 3.

            if not v.destroy then
                if isWebbedCamila(p) then
                    -- pull creep back if Camila is webbed.
                    if v.sprout < 10 then
                        v.sprout = v.sprout + 1
                    else
                        doDraw = false
                    end
                elseif v.sprout > 0 then
                    -- animate growth if it is not being destroyed.
                    v.sprout = v.sprout - 1
                end
            end

            if Board:IsBlocked(p, PATH_PROJECTILE) then
                anim = "lmn_creep_front_"
            else
                anim = "lmn_creep_back_"

                if isCreepSprout(p) then
                    suffix = "start"
                end
            end

            if doDraw then
                Board:AddAnimation(p, anim .. suffix, NO_DELAY)
            end
        end
    end

    if #rem > 0 then
        -- shuffle remCreep and sort by distance from dead colony.
        utils.shuffle(rem)
        table.sort(rem, function(i,j)
            return (g.lmn_creep[i].distance or 0) > (g.lmn_creep[j].distance or 0)
        end)

        local fx = SkillEffect()

        for _, i in ipairs(rem) do
            local n = g.lmn_creep[i]
            local p = n.loc

            n.destroy = true

            fx:AddBounce(p, -2)
            fx:AddSound("enemy/goo_boss/move")
            fx:AddScript(string.format("Nico_Colony_Atk:RetractCreep(%s, 10)", p:GetString()))
            fx:AddDelay(0.04)
            fx:AddScript(string.format("Nico_Colony_Atk:RemCreep(%s)", p:GetString()))
        end

        Board:AddEffect(fx)
    end
end)

local function isCreepVisibleSprout(p)
    assert(Board)
    return Board:IsTerrain(p, TERRAIN_FOREST) or Board:IsAcid(p)
end

local function isCreepSprout(p)
    assert(GAME)
    return GAME.lmn_creep[p2idx(p)].sprout > 0 or isCreepVisibleSprout(p)
end

local isMissionEnd = false

local function onStartMission()
	isMissionEnd = false
	GAME.lmn_creep = {}
end

local function resetMissionEnd()
	isMissionEnd = false
end

sdlext.addGameExitedHook(resetMissionEnd)

function this:load()
	modApi:addMissionStartHook(onStartMission)
	modApi:addTestMechEnteredHook(onStartMission)
	modApi:addPostLoadGameHook(resetMissionEnd)
end

return this