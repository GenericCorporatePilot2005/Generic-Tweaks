local scriptPath = mod_loader.mods[modApi.currentMod].resourcePath

modApi:appendAsset("img/icon_acidsmoke.png", scriptPath.."img/icon_acidsmoke.png")
Location["icon_acidsmoke.png"] = Point(-22,9)

Nico_TW_puffer = lmn_PufferAtk:new{
	Name = "Spore Emitter",
	Description = "Create smoke on target tiles, and damage them.",
	Icon = "weapons/lmn_PufferAtk1.png",
	Class = "TechnoVek",
	Emitter = "lmn_Puffer_Cloud_Burst",
	Damage = 1,
	Smoke = true,
	Acid = 0,
    triple = false,
    fourtiles = false,
	TwoClick = true,
	Blade = false,
	PathSize = 1,
	LaunchSound = "",
	PowerCost = 1,
	Upgrades = 2,
	UpgradeCost = {2, 3},
	UpgradeList = { "Cleaving Burst", "A.C.I.D. + Damage" },
	CustomTipImage = "",
	TipImage = {
		Unit = Point(2,2),
		Enemy1 = Point(2,1),
		Enemy2 = Point(1,2),
		Target = Point(2,1),
		Second_Click = Point(1,2),
		CustomPawn = "lmn_Puffer"
	}
}
local cloudCount = 6
function Nico_TW_puffer:Lemon_Particles(p1,p2,dir,ret)
	for k = cloudCount, 0, -1 do
		ret:AddEmitter(p2, self.Emitter .. dir .. k)
		ret.effect:index(ret.effect:size()).bHide = true
		if Board:IsPawnSpace(p2) then
			ret:AddSound("enemy/shared/moved")
		end
	end
end
function Nico_TW_puffer:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		ret:push_back(point+DIR_VECTORS[i])
	end
	return ret
end
function Nico_TW_puffer:GetSecondTargetArea(p1,p2)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		if p1+DIR_VECTORS[i]~=p2 then ret:push_back(p1+DIR_VECTORS[i]) end
	end
	return ret
end
function Nico_TW_puffer:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local d = SpaceDamage(p2, self.Damage)
	d.iSmoke = 1
	d.iAcid = self.Acid
	if self.Acid == 1 then d.sImageMark = "icon_acidsmoke.png" end
	ret:AddDamage(d)
	if self.Blade then
		d.loc = p2 + DIR_VECTORS[(GetDirection(p2 - p1)+1)%4]
		ret:AddDamage(d)
		d.loc = p2 + DIR_VECTORS[(GetDirection(p2 - p1)-1)%4]
		ret:AddDamage(d)
	end
	return ret
end
function Nico_TW_puffer:GetFinalEffect(p1, p2, p3)
	local ret = SkillEffect()
	local dir = GetDirection(p2 - p1)
	ret:AddSound("enemy/goo_boss/attack")
	ret:AddDelay(0.1)
	self:Lemon_Particles(p1,p2,dir,ret)
	if self.Blade then
		self:Lemon_Particles(p1,p2 + DIR_VECTORS[(GetDirection(p2 - p1)+1)%4],dir,ret)
		self:Lemon_Particles(p1,p2 + DIR_VECTORS[(GetDirection(p2 - p1)-1)%4],dir,ret)
	end
	self:Lemon_Particles(p1,p3,GetDirection(p3 - p1),ret)
	ret:AddDelay(0.02)
	local d = SpaceDamage(p2, self.Damage)
	d.sSound = "props/acid_splash"
	d.iSmoke = 1
	d.iAcid = self.Acid
	if self.Acid == 1 then d.sImageMark = "icon_acidsmoke.png" end
	ret:AddDamage(d)
	if self.Blade then
		d.loc = p2 + DIR_VECTORS[(GetDirection(p2 - p1)+1)%4]
		ret:AddDamage(d)
		d.loc = p2 + DIR_VECTORS[(GetDirection(p2 - p1)-1)%4]
		ret:AddDamage(d)
	end
	d.loc = p3
	ret:AddDamage(d)
	return ret
end

Nico_TW_puffer_A = Nico_TW_puffer:new{
	Blade = true,
	UpgradeDescription = "Hit nearby tiles in the direction of the first target.",
	TipImage = {
		Unit = Point(2,2),
		Enemy1 = Point(2,1),
		Enemy2 = Point(2,3),
		Enemy3 = Point(1,1),
		Enemy4 = Point(3,1),
		Target = Point(2,1),
		Second_Click = Point(2,3),
		--Fire = Point(2,1),
		CustomPawn = "lmn_Puffer"
	}
}

Nico_TW_puffer_B = Nico_TW_puffer:new{
	UpgradeDescription = "Increases damage by 1 and applies A.C.I.D.",
	Damage = 2,
	Acid = 1,
}

Nico_TW_puffer_AB = Nico_TW_puffer_A:new{
	Damage = 2,
	Acid = 1,
}