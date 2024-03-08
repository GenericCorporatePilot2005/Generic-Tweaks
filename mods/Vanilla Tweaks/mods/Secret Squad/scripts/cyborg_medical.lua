Passive_Medical = PassiveSkill:new{
	PowerCost = 0, --AE Change
	Icon = "weapons/passives/passive_medical.png",
	Passive = "Passive_Medical",
	Upgrades = 0,
	TipImage = {
		Unit = Point(2,2),
	}
}

function Passive_Medical:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local damage = SpaceDamage(Point(2,2),5)
	damage.bHide = true
	ret:AddDelay(1)
	ret:AddDamage(damage)
	return ret
end

local function TechnoVekHeal(mission)
	if IsPassiveSkill("Passive_Medical") then
		for i = 0,2 do
			local dpawn = Game:GetPawn(i)
			local curr = dpawn:GetSpace()
			local name = dpawn:GetType()
			if Board:IsValid(curr) and dpawn:IsDead() and _G[name].Class == "TechnoVek" then
				if not Board:IsTerrain(curr,TERRAIN_HOLE) then
					dpawn:ModifyHealth(1,true,0)
					Board:AddAlert(curr,"MEDICAL SUPPLIES")
					local dam = SpaceDamage(0)
					dam.fDelay = 1
					Board:DamageSpace(dam)
				elseif Board:IsTerrain(curr,TERRAIN_HOLE) and _G[name].Flying then
					dpawn:SetHealth(1)
					Board:RemovePawn(dpawn)
					Board:AddPawn(dpawn, curr)
					Game:TriggerSound("/ui/map/repair_mech")
					Board:AddAlert(curr,"MEDICAL SUPPLIES")
				elseif Board:IsTerrain(curr,TERRAIN_HOLE) and not _G[name].Flying then
					dpawn:SetHealth(1)
					Board:RemovePawn(dpawn)
					Board:AddPawn(dpawn, curr)
					
					--
					
					local dest = Point(-1,-1)
					local z = 1
					while z<15 do
						local places = extract_table(Board:GetReachable(curr, z, PATH_FLYER))
						for i = 1, #places do
							local corr = places[i]
							if curr:Manhattan(corr) == z and not Board:IsTerrain(corr,TERRAIN_HOLE) then dest = corr break end
						end
						if dest ~= Point(-1,-1) then break end
						z = z+1
					end
					Game:TriggerSound("/ui/map/repair_mech")
					local ret = SkillEffect()
					ret:AddTeleport(curr,dest,0)
					ret:AddSound("/weapons/swap")
					--ret:AddLeap(Board:GetPath(curr, dest, PATH_FLYER),FULL_DELAY)
					Board:AddEffect(ret)
					modApi:runLater(function()
						Board:AddAlert(dest,"MEDICAL SUPPLIES")
					end)
				end
			end
		end
	end
end

local function EVENT_onModsLoaded()
	modApi:addMissionUpdateHook(TechnoVekHeal)
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)