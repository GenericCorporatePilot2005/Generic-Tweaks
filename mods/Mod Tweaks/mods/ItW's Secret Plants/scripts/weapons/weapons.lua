local mod = modApi:getCurrentMod()
local path = mod.scriptPath
local this = {}

require(path .."weapons/chili")
require(path .."weapons/chomper")
require(path .."weapons/puffer")


    local function Smoke_Fire_Enemies()
        if not Board then return end
        
        local mechs = extract_table(Board:GetPawns(TEAM_PLAYER))
        local hasChili = false
        local hasChomper = false

        -- Identify if any mech has a version of the required weapons powered
        for _, id in pairs(mechs) do
            local pawn = Board:GetPawn(id)
            if pawn then
                local weapons = pawn:GetPoweredWeapons()
                for i = 1, 3 do
                    local w_id = weapons[i]
                    if w_id then
                        -- Detects Nico_TW_chili_A and Nico_TW_chili_AB
                        if string.find(w_id, "Nico_TW_chili_A") then 
                            hasChili = true 
                        end
                        -- Detects Nico_TW_chomper, _A, _B, and _AB
                        if string.find(w_id, "Nico_TW_chomper") then 
                            hasChomper = true 
                        end
                    end
                end
            end
        end

        -- If neither weapon is found, stop here
        if not (hasChili or hasChomper) then return end

        local foes = extract_table(Board:GetPawns(TEAM_ENEMY))
        local affected_count = 0

        for _, id in pairs(foes) do
            local pawn = Board:GetPawn(id)
            local space = pawn:GetSpace()
            -- Only target enemies that aren't already on fire or in smoke
            if pawn and not Board:IsSmoke(space) and not pawn:IsFire() then
                if hasChili then 
                    -- Added true for animation_bool
                    Board:SetSmoke(space, true, false) 
                end
                if hasChomper then 
                    -- SetFire also typically takes (Point, fire_bool, animation_bool)
                    Board:SetFire(space, true, false)  
                end

                affected_count = affected_count + 1
                if affected_count >= 3 then break end
            end
        end
    end

	local function Plant_Enter_Test(mission)
		modApi:scheduleHook(100, function()
			Smoke_Fire_Enemies()
		end)
	end
	local function EVENT_onModsLoaded()
		modApi:addTestMechEnteredHook(Plant_Enter_Test)
	end
	modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)