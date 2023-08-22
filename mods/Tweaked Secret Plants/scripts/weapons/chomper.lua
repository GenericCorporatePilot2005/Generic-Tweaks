Nico_TW_chomper = lmn_ChomperAtk:new{
	Name = "Iron Jaws",
	Description = "Pulls in a target within 2 tiles to bite it.\n(Stable targets pull you in instead)\nFire extends the range.",
	Icon = "weapons/lmn_ChomperAtk1.png",
	Class = "TechnoVek",
	Range = 2,
	Damage = 2,
	Anim_Impact = "lmn_ChomperAtk_",
	SoundBase = "/enemy/scorpion_soldier_1",
	PowerCost = 1,
	Upgrades = 2,
	UpgradeCost = {1, 1},
	UpgradeList = { "Dazed, -1 Damage", "+2 Range" },
	TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,0),
		Target = Point(2,1),
		Second_Origin = Point(2,2),
		Second_Target = Point(2,3),
		Mountain = Point(2,4),
		CustomPawn = "lmn_Chomper"
	}
}

Nico_TW_chomper_A = Nico_TW_chomper:new{
	UpgradeDescription = "Change the target's attack square after biting it. Decrease attack damage by 1.",
	TwoClick = true,
	Damage = 1,
	CustomTipImage = "Nico_TW_chomper_Tip",
}

function Nico_TW_chomper:GetTargetArea(p)
	local ret = PointList()

	for i = DIR_START, DIR_END do
		local step = DIR_VECTORS[i]
		local target = p + step
		local cache = self.Range
		local k = 1
		while cache > 0 do
			local curr = p + step * k
			ret:push_back(curr)
			if not Board:IsValid(curr) then
				break
			end

			if Board:IsBlocked(curr, PATH_PROJECTILE) then
				target = curr
				break
			end
			
			k = k+1
			if not (Board:IsFire(curr) or Board:IsTerrain(curr,TERRAIN_LAVA)) then cache = cache - 1 end
		end
	end

	return ret
end

function Nico_TW_chomper:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	local adjacent = p1 + DIR_VECTORS[dir]
	local target = p1 + DIR_VECTORS[dir]
	local cache = self.Range
	local k = 1
	while cache > 0 do
		local curr = p1 + DIR_VECTORS[dir]*k

		if not Board:IsValid(curr) then
			break
		end

		if Board:IsBlocked(curr, PATH_PROJECTILE) then
			target = curr
			break
		end
		
		k = k+1
		if not (Board:IsFire(curr) or Board:IsTerrain(curr,TERRAIN_LAVA)) then cache = cache - 1 end
	end
	
	if not Board:IsValid(target) then
		return ret
	end
	
	local distance = p1:Manhattan(target)
	local pawn = Board:GetPawn(target)
	local d = SpaceDamage(adjacent)
	local pullPawn = pawn and not pawn:IsGuarding() and distance > 1

	d.sSound = self.SoundBase .."/attack"

	if not pullPawn then
		if Board:IsBlocked(target, PATH_PROJECTILE) then
			ret:AddCharge(Board:GetSimplePath(p1, target - DIR_VECTORS[dir]), FULL_DELAY)
			d.sSound = "/weapons/charge_impact"
			d.loc = target
		end
		d.iDamage = self.Damage
		d.sAnimation = self.Anim_Impact .. dir
	end

	ret:AddMelee(d.loc - DIR_VECTORS[dir], d, NO_DELAY)

	if pullPawn then
		if self.TwoClick then
			local damage = SpaceDamage(target,0)
			if self:IsConfuseable(target) or Board:IsTipImage() then
				damage.sImageMark = "combat/icons/icon_mind_glow.png"
			else
				damage.sImageMark = "combat/icons/icon_mind_off_glow.png"
			end
			ret:AddDamage(damage)
		end
		-- charge pawn towards chomper.
		ret:AddDelay(0.25)
		ret:AddCharge(Board:GetSimplePath(target, adjacent), FULL_DELAY)

		local d = SpaceDamage(adjacent, self.Damage)
		d.sSound = "/weapons/charge_impact"
		d.sAnimation = self.Anim_Impact .. dir
		ret:AddMelee(p1, d, NO_DELAY)
	end
	return ret
end

function Nico_TW_chomper_A:IsConfuseable(point)
	--Four Way Attackers "target" themselves with some exceptions
	if Board:IsPawnSpace(point) and Board:IsPawnTeam(point, TEAM_ENEMY) and Board:GetPawn(point):IsQueued() and (Board:GetPawn(point):GetQueuedTarget() == point or Board:GetPawn(point):GetType() == "lmn_Puffer2" or Board:GetPawn(point):GetType() == "DNT_AntlionBoss") then
		return false
	--Other Attackers do not
	elseif Board:IsPawnSpace(point) and Board:IsPawnTeam(point, TEAM_ENEMY) and Board:GetPawn(point):IsQueued() then
		if Board:IsValid(Board:GetPawn(point):GetQueuedTarget()) then
			return true
		end
	end
	
	return false	
end

function Nico_TW_chomper_A:IsTwoClickException(p1,p2)
	return (self:GetSecondTargetArea(p1,p2):size() == 0)
end

Nico_TW_chomper_Tip = Skill:new{
	Class = "TechnoVek",
	TipImage = {
		Unit = Point(2,2),
		Enemy1 = Point(2,0),
		Queued1 = Point(1,0),
		Building1 = Point(1,0),
		Building2 = Point(1,1),
		Target = Point(2,1),
		Second_Click = Point(3,1),
		CustomPawn = "lmn_Chomper"
	}
}

function Nico_TW_chomper_Tip:GetSkillEffect(p1,p2)
	local ret = Nico_TW_chomper_A:GetSkillEffect(p1, p2)
	ret.piOrigin = Point(2,2)
	local damage = SpaceDamage(0)
	damage.bHide = true
	damage.fDelay = 0.2
	ret:AddDamage(damage)
	ret:AddScript("Board:GetPawn("..Point(2,1):GetString().."):SetQueuedTarget("..Point(2,0):GetString()..")")
	ret:AddScript("Board:AddAlert("..Point(2,1):GetString()..",\"ATTACK CHANGED\")")
	return ret
end

function Nico_TW_chomper_A:GetSecondTargetArea(p1,p2)
	local ret = PointList()
	local dir = GetDirection(p2 - p1)
	local adjacent = p1 + DIR_VECTORS[dir]
	local target = p1 + DIR_VECTORS[dir]
	local cache = self.Range
	local k = 1
	while cache > 0 do
		local curr = p1 + DIR_VECTORS[dir]*k

		if not Board:IsValid(curr) then
			break
		end

		if Board:IsBlocked(curr, PATH_PROJECTILE) then
			target = curr
			break
		end
		
		k = k+1
		if not (Board:IsFire(curr) or Board:IsTerrain(curr,TERRAIN_LAVA)) then cache = cache - 1 end
	end
	local distance = p1:Manhattan(target)
	local pawn = Board:GetPawn(target)
	local pullPawn = pawn and not pawn:IsGuarding()
	
	if not pullPawn then return ret end
	
	if not self:IsConfuseable(target) then return ret end
	
	if Board:IsSmoke(adjacent) then return ret end
	
	local threat = Board:GetPawn(target):GetQueuedTarget()
	
	displace = p1 + DIR_VECTORS[dir] - target
	
	ret:push_back(adjacent)
	
	if target:Manhattan(threat)==1 then
		for i = DIR_START,DIR_END do
			local curr = target + DIR_VECTORS[i]
			if Board:IsValid(curr) then-- and curr ~= threat then
				ret:push_back(curr+displace)
			end
		end
		return ret
	else
		for i = DIR_START,DIR_END do
			for j = 2,7 do
				local curr = target + DIR_VECTORS[i]*j
				if Board:IsValid(curr) then-- and curr ~= threat then
					ret:push_back(curr+displace)
				end
			end
		end
		return ret
	end
	return ret
end

function Nico_TW_chomper_A:GetFinalEffect(p1,p2,p3)
	local ret = self:GetSkillEffect(p1, p2)
	local dir = GetDirection(p2 - p1)
	local adjacent = p1 + DIR_VECTORS[dir]
	if p3 == adjacent then return ret end
	local target = p1 + DIR_VECTORS[dir]
	local cache = self.Range
	local k = 1
	while cache > 0 do
		local curr = p1 + DIR_VECTORS[dir]*k

		if not Board:IsValid(curr) then
			break
		end

		if Board:IsBlocked(curr, PATH_PROJECTILE) then
			target = curr
			break
		end
		
		k = k+1
		if not (Board:IsFire(curr) or Board:IsTerrain(curr,TERRAIN_LAVA)) then cache = cache - 1 end
	end
	
	ret:AddDelay(0.2)
	
	ret:AddScript("Board:GetPawn("..adjacent:GetString().."):SetQueuedTarget("..p3:GetString()..")")
	
	ret:AddScript("Board:AddAlert("..adjacent:GetString()..",\"ATTACK CHANGED\")")
	
	local web_id = Board:GetPawn(target):GetId()--Store pawn id
	if Board:GetPawn(target):GetType() ~= "tosx_IceHornet" then ret:AddScript("Board:GetPawn("..web_id.."):SetSpace(Point(-1,-1))") end--Move the pawn to Point(-1,-1) to delete webbing
	local damage = SpaceDamage(p1,0)
	damage.bHide = true
	damage.fDelay = 0.00017--force a one frame delay on the board
	ret:AddDamage(damage)
	ret:AddScript("Board:GetPawn("..web_id.."):SetSpace("..adjacent:GetString()..")")--Move the pawn back
	return ret
end

Nico_TW_chomper_B = Nico_TW_chomper:new{
	UpgradeDescription = "Increase range by 2.",
	Range = 4,
}
Nico_TW_chomper_AB = Nico_TW_chomper_A:new{
	Range = 4,
}
