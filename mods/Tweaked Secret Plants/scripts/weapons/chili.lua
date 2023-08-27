
Nico_TW_chili = Prime_Flamethrower:new{
	Name = "Chili Breath",
	Icon = "weapons/lmn_ChiliAtk1.png",
	Description = "Breathe fire on two tiles, damage the first target.\nCan self-detonate, blasting all adjacent tiles for double damage, and damaging self.",
	Class = "TechnoVek",
	Explosion = "",
	Range = 2,
	PathSize = 2,
	Damage = 1,
	Push = 1,
    kaboom=false,
	PowerCost = 0,
	Upgrades = 2,
	UpgradeList = { "Jalapeños",  "+1 Damage & Range"  },
	UpgradeCost = { 1 , 3 },
	LaunchSound = "/weapons/flamethrower",
	TipImage = {
		Unit = Point(2,3),
        Second_Origin=Point(2,3),
		Enemy1 = Point(2,2),
		Enemy2 = Point(1,3),
		Enemy3 = Point(3,3),
        Enemy4 = Point(2,1),
		Target = Point(2,1),
        Second_Target=Point(2,3),
		CustomPawn = "lmn_Chili",
	}
}

function Nico_TW_chili:GetTargetArea(p)
	local ret = PointList()

	for i = DIR_START, DIR_END do
		for k = 1, self.PathSize do
			local curr = DIR_VECTORS[i]*k + p
            ret:push_back(p)
			ret:push_back(curr)
			if not Board:IsValid(curr) then
				break
			end
		end
	end
	return ret
end

function Nico_TW_chili:GetSkillEffect(p1, p2)
    local ret = SkillEffect()

	local direction = GetDirection(p2 - p1)
	local distance = p1:Manhattan(p2)
    if p1==p2 then
        local crack=SpaceDamage(p1,self.Damage)
        crack.iCrack=EFFECT_CREATE
        crack.iFire = 1
        ret:AddBounce(p1,1)
        ret:AddDamage(crack)
        for i = DIR_START, DIR_END do
            local curr = p1 + DIR_VECTORS[i]

            local d = SpaceDamage(curr, self.Damage*2,i)
            d.sSound = "/impact/generic/explosion"
            d.sAnimation = "exploout2_".. i
            d.iFire = 1
            ret:AddBounce(d.loc,2)
            ret:AddDamage(d)
        end
    end
	local damage_flag = true--only damage the first target
	for i = 1, distance do
		local curr = p1 + DIR_VECTORS[direction]*i
		local push = (i == distance) and direction*self.Push or DIR_NONE
        local push2 = DIR_NONE--(i == distance) and ((direction + 1)% 4)*self.Push or DIR_NONE
        local push3 = DIR_NONE--(i == distance) and ((direction - 1)% 4)*self.Push or DIR_NONE
		local damage = SpaceDamage(p1 + DIR_VECTORS[direction]*i,0, push)
        local damage2=SpaceDamage(damage.loc+ DIR_VECTORS[(direction + 1)% 4], 0, push2)
        local damage3=SpaceDamage(damage.loc+ DIR_VECTORS[(direction - 1)% 4], 0, push3)
		if Board:IsPawnSpace(damage.loc) and damage_flag then
			damage_flag = false
			damage.iDamage = damage.iDamage + self.Damage
			damage.sAnimation = "ExploAir1"
        end
		damage.iFire = EFFECT_CREATE
		if i == distance then 	
			damage.sAnimation = "flamethrower"..distance.."_"..direction 
		end
		ret:AddDamage(damage)
        if Board:IsSmoke(damage.loc) and self.kaboom then
            for j = 1, i do
                damage2.iFire = EFFECT_CREATE
                if j == i then 	
                    damage2.sAnimation = "flamethrower"..distance.."_"..((direction+1)%4)
					damage2.iPush = ((direction + 1)% 4)
                end
                damage3.iFire = EFFECT_CREATE
                if j == i then 	
                    damage3.sAnimation = "flamethrower"..distance.."_"..((direction-1)%4) 
					damage3.iPush = ((direction - 1)% 4)
                end
                ret:AddBounce(damage2.loc,2)
                ret:AddBounce(damage3.loc,2)
                ret:AddDamage(damage2)
                ret:AddDamage(damage3)
                damage2.loc=damage2.loc+DIR_VECTORS[(direction + 1)% 4]
                damage3.loc=damage3.loc+DIR_VECTORS[(direction - 1)% 4]
                ret:AddDelay(0.1)
            end
        end
	end
	return ret
end
Nico_TW_chili_A=Nico_TW_chili:new{
    kaboom=true,
    UpgradeDescription="If the flames pass through smoke, lines of fire will emerge from the sides of it.",
    TipImage = {
		Unit = Point(2,3),
		Enemy1 = Point(3,1),
		Target = Point(2,1),
        Smoke1=Point(2,2),
		Smoke2=Point(2,1),
		CustomPawn = "lmn_Chili",
	}
}
Nico_TW_chili_B=Nico_TW_chili:new{
    UpgradeDescription="Extends range by 1 tile and increases damage dealt to first target by 1.",
    Range=3,
    PathSize=3,
    Damage=2,
    TipImage = {
		Unit = Point(2,3),
        Second_Origin=Point(2,3),
		Enemy1 = Point(2,2),
		Enemy2 = Point(1,3),
		Enemy3 = Point(3,3),
        Enemy4 = Point(2,1),
		Target = Point(2,0),
        Second_Target=Point(2,3),
		CustomPawn = "lmn_Chili",
	}
}
Nico_TW_chili_AB=Nico_TW_chili_A:new{
    Range=3,
    PathSize=3,
	Damage=2,
	TipImage = {
		Unit = Point(2,3),
		Enemy1 = Point(3,1),
		Target = Point(2,0),
        Smoke1=Point(2,2),
		Smoke2=Point(2,1),
		Smoke3=Point(2,0),
		CustomPawn = "lmn_Chili",
	}
}