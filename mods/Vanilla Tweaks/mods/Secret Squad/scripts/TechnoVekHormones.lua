local function TechnoVekHormones(mission, pawn, weaponId, p1, p2, skillEffect)
	if pawn and _G[pawn:GetType()].Class == "TechnoVek" then
		for i = 1, skillEffect.effect:size() do
			local spaceDamage = skillEffect.effect:index(i)
			if spaceDamage.iDamage > 0 and spaceDamage.iDamage ~= DAMAGE_ZERO and spaceDamage.iDamage ~= DAMAGE_DEATH then
				if IsPassiveSkill("Passive_FriendlyFire") and Board:IsPawnSpace(spaceDamage.loc) and Board:GetPawn(spaceDamage.loc):GetTeam() == TEAM_ENEMY then
					spaceDamage.iDamage = spaceDamage.iDamage + 1	
					if IsPassiveSkill("Passive_FriendlyFire_AB") then
						spaceDamage.iDamage = spaceDamage.iDamage + 2
					elseif IsPassiveSkill("Passive_FriendlyFire_A") or IsPassiveSkill("Passive_FriendlyFire_B") then
						spaceDamage.iDamage = spaceDamage.iDamage + 1
					end
				end
			end
		end
	end
end

local function TechnoVekHormones2(mission, pawn, weaponId, p1, p2, p3, skillEffect)
	TechnoVekHormones(mission, pawn, weaponId, p1, p2, skillEffect)
end
local function onBoardClassInitialized(BoardClass, board)    
    local IsDeadlyVanilla = board.IsDeadly
    BoardClass.IsDeadly = function(self, spaceDamage, pawn)
        Assert.Equals("userdata", type(self), "Argument #0")
        Assert.Equals("userdata", type(spaceDamage), "Argument #1")
        Assert.Equals("userdata", type(pawn), "Argument #2")

        local mechs = extract_table(Board:GetPawns(TEAM_PLAYER))
        for i,id in pairs(mechs) do
            if _G[Board:GetPawn(id):GetType()].Class == "TechnoVek" then
                if spaceDamage and spaceDamage.loc and Board:IsValid(spaceDamage.loc) and
                spaceDamage.iDamage then
                    local Etile = true
                    if Board:GetCustomTile(spaceDamage.loc) == "tosx_rocks_0.png" or Board:GetCustomTile(spaceDamage.loc) == "tosx_whirlpool_0.png" then
                        Etile = false
                    end
                    if Etile then
                        local spaceDamageCopy = SpaceDamage(spaceDamage.loc, spaceDamage.iDamage, spaceDamage.iPush)
                        if IsPassiveSkill("Passive_FriendlyFire") and Board:IsPawnSpace(spaceDamage.loc) and Board:GetPawn(spaceDamage.loc):GetTeam() == TEAM_ENEMY then
                            spaceDamageCopy.iDamage = spaceDamageCopy.iDamage + 1    
                            if IsPassiveSkill("Passive_FriendlyFire_AB") then
                                spaceDamageCopy.iDamage = spaceDamageCopy.iDamage + 2
                            elseif IsPassiveSkill("Passive_FriendlyFire_A") or IsPassiveSkill("Passive_FriendlyFire_B") then
                                spaceDamageCopy.iDamage = spaceDamageCopy.iDamage + 1
                            end
                            return IsDeadlyVanilla(self, spaceDamageCopy, pawn)
                        end
                    end
                end
            end
        end
        return IsDeadlyVanilla(self, spaceDamage, pawn)
    end
end
local function EVENT_onModsLoaded()
	modapiext:addSkillBuildHook(TechnoVekHormones)
	modapiext:addFinalEffectBuildHook(TechnoVekHormones2)
end

modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)
modApi.events.onBoardClassInitialized:subscribe(onBoardClassInitialized)