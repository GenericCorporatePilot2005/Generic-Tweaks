
-- init.lua is the entry point of every mod

local mod = {
	id = "Nico_Blitzkrieg_Tweaks",
	name = "Blitzkrieg",
    description="Tweaks Blitzkrieg, mostly buffs Lightning Mech to be better, by adding water chaining(like Building Chain but with water) and Ally Immune().",
	version = "1",
	requirements = {},
	dependencies = { --This requests modApiExt from the mod loader
		modApiExt = "1.17", --We can get this by using the variable `modapiext`
	},
	modApiVersion = "2.8.3",
	icon = "img/icon.png",
	enabled=false,
}

function mod:init()
	Prime_Lightning.FriendlyDamage = false
	WallMech.MoveSpeed=4
	function Prime_Lightning:GetSkillEffect(p1, p2)
		local ret = SkillEffect()
		local damage = SpaceDamage(p2,self.Damage)
		local hash = function(point) return point.x + point.y*10 end
		local explored = {[hash(p1)] = true}
		local todo = {p2}
		local origin = { [hash(p2)] = p1 }
		
		if Board:IsPawnSpace(p2) or (self.Buildings and Board:IsBuilding(p2)) then
			ret:AddAnimation(p1,"Lightning_Hit")
		end
		
		while #todo ~= 0 do
			local current = pop_back(todo)
			
			if not explored[hash(current)] then
				explored[hash(current)] = true
				
				if Board:IsPawnSpace(current) or (self.Buildings and Board:IsBuilding(current)) or Board:GetTerrain(current) == TERRAIN_WATER or (IsPassiveSkill("Electric_Smoke") and Board:IsSmoke(current)) or Board:IsAcid(current) then
				
					local direction = GetDirection(current - origin[hash(current)])
					damage.sAnimation = "Lightning_Attack_"..direction
					damage.loc = current
					damage.iDamage = (Board:IsBuilding(current) or Board:IsPawnTeam(current, TEAM_PLAYER)) and DAMAGE_ZERO or self.Damage
					
					if not self.FriendlyDamage and Board:IsPawnTeam(current, TEAM_PLAYER) then
						damage.iDamage = DAMAGE_ZERO
					end
					
					ret:AddDamage(damage)
					
					if not Board:IsBuilding(current) then
						ret:AddAnimation(current,"Lightning_Hit")
					end
					
					for i = DIR_START, DIR_END do
						local neighbor = current + DIR_VECTORS[i]
						if not explored[hash(neighbor)] then
							todo[#todo + 1] = neighbor
							origin[hash(neighbor)] = current
						end
					end
				end		
			end
		end
	
		return ret
	end
end

function mod:load( options, version)
end

return mod