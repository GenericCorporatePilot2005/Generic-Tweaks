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
    IgnoreSmoke = true,
    MoveSpeed = 4,
}
--Chomper--
lmn_Chomper = lmn_Chomper:new{
	SkillList = { "Nico_TW_chomper" },
    MoveSpeed = 4,
}

local oldMove = Move.GetTargetArea
function Move:GetTargetArea(p, ...)
	local mover = Board:GetPawn(p)
	if mover and (mover:GetType() == "lmn_Puffer") then
		local pathType = PATH_FLYER
		local old = extract_table(Board:GetReachable(p, mover:GetMoveSpeed(), pathType))
		local ret = PointList()

		for _, v in ipairs(old) do
			local terrain = Board:GetTerrain(v)

			if terrain ~= TERRAIN_HOLE then
				ret:push_back(v)
			end
		end

		return ret
	end

	return oldMove(self, p, ...)
end

--Stolen that from Metalocif!
local oldMove = Move.GetSkillEffect
function Move:GetSkillEffect(p1, p2, ...)
	local mover = Board:GetPawn(p1)
	if mover and (mover:GetType() == "lmn_Puffer") then
		local ret = SkillEffect()
		local pawnId = mover:GetId()

		-- just preview move.
		-- ret:AddScript(string.format("Board:GetPawn(%s):SetSpace(Point(-1, -1))", pawnId))
		--it's annoying to go through the whole burrowing animation for one tile so we force a normal Move
		--could probably check whether it's possible to move to p2 without burrowing but this helps a little
            if Board:IsTerrain(p1,TERRAIN_WATER) then
                local wateranim = SpaceDamage(p1,0)
                wateranim.sAnimation = "Splash"
                ret:AddDamage(wateranim)
            end
			ret:AddBurrow(Board:GetPath(p1, p2, PATH_FLYER), NO_DELAY)
			ret:AddSound("/enemy/shared/crawl_out")
			ret:AddDelay(0.7)	--burrowing anim duration
            if Board:IsTerrain(p2,TERRAIN_WATER) then
                local wateranim = SpaceDamage(p2,0)
                wateranim.sAnimation = "Splash"
                ret:AddDamage(wateranim)
            end
			local path = extract_table(Board:GetPath(p1, p2, PATH_FLYER))
			local dist = #path - 1
			for i = 1, #path do
				local p = path[i]
				ret:AddBounce(p, -2)
				ret:AddDelay(.32 / dist)
			end
		return ret
	end

	return oldMove(self, p1, p2, ...)
end