
local mod = {
	id = "Nico_Mercurial",
	name = "Mercurials",
	version = "1.2.0",
	modApiVersion = "2.9.1",
	gameVersion = "1.2.88",
	icon = "icon.png",
	version = "1",
	description = "This mod makes the weapon of Alloy Mech, the Ablative Spines, into a two click weapon, allowing you to target two different targets, not just opposites. Also gives the Husks web and smoke immunity.\nIdea by Cat-As$-Trophy, from the ItB discord server",
	dependencies = {modApiExt = "1.17","tosx_Mercurials"},
	libs = {},
	enabled = false,
}

function mod:init()
	require(self.scriptPath .."libs/trait")
	tosx_Prime_Tendrils.Description = "Damage and push tiles on two different sides. Mechs are healed instead."
	tosx_Prime_Tendrils.TwoClick = true
	tosx_Prime_Tendrils.TipImage = {
		Unit = Point(2,2),
		Enemy = Point(2,1),
		Friendly_Damaged = Point(2,3),
		Target = Point(2,1),
		Second_Click = Point(2,3),
	}
	function tosx_Prime_Tendrils:GetSkillEffect(p1, p2)
		local ret = SkillEffect()
		local dir = GetDirection(p2 - p1)
		
		local damage0 = SpaceDamage(p1, 0)
		ret:AddDamage(damage0)
		
		local damage1 = SpaceDamage(p2, self.Damage, dir)
		if Board:IsPawnSpace(p2) and Board:GetPawn(p2):IsMech() then
			damage1.iDamage = -1 * self.Damage
		end
		damage1.sAnimation = "tosx_metal_spike_"..dir
		ret:AddDamage(damage1)
		return ret
	end
	function tosx_Prime_Tendrils:GetSecondTargetArea(p1,p2)
		local ret = PointList()
		local direction = GetDirection(p2 - p1)
		
		for i = DIR_START, DIR_END do
			local curr = p1 + DIR_VECTORS[i]
			if Board:IsValid(curr) then
				ret:push_back(curr)
			end
		end
		
		return ret
	end
	function tosx_Prime_Tendrils:GetFinalEffect(p1, p2, p3)
        local ret = self:GetSkillEffect(p1,p2)
        local dir = GetDirection(p3 - p1)
		local p3 = p1 + DIR_VECTORS[dir]
		
		local damage0 = SpaceDamage(p1, self.SelfDamage)
		ret:AddDamage(damage0)
	
		
		local damage2 = SpaceDamage(p3, self.Damage, dir)
		if Board:IsPawnSpace(p3) and Board:GetPawn(p3):IsMech() then
			damage2.iDamage = -1 * self.Damage
		end
		damage2.sAnimation = "tosx_metal_spike_"..dir
		ret:AddDamage(damage2)	
		
		if not Board:IsTipImage() then
			local enemycount = Board:GetEnemyCount()
			local m0, m1, m2 = 0, 0, 0
			if Board:GetPawn(0) and not Board:GetPawn(0):IsDead() then m0 = 1 end
			if Board:GetPawn(1) and not Board:GetPawn(1):IsDead() then m1 = 1 end
			if Board:GetPawn(2) and not Board:GetPawn(2):IsDead() then m2 = 1 end
			
			ret:AddScript([[
				local fx = SkillEffect();
				fx:AddScript("tosx_checkmutual(]]..enemycount..[[, ]]..m0..[[, ]]..m1..[[, ]]..m2..[[)")
				Board:AddEffect(fx);
			]])
		end
		
		return ret
	end
	tosx_Husk1.IgnoreSmoke = true
	tosx_Husk2.IgnoreSmoke = true
	local path = self.resourcePath
	modApi:appendAsset("img/combat/icons/icon_Nico_grapple.png",path.."img/combat/icons/icon_Nico_grapple.png")--image of the trait
	local trait = require(self.scriptPath .."libs/trait")--where does it get the code for the rest of this to work
    for i = 1,2 do
		trait:add{
			pawnType="tosx_Husk"..i,--who will get the trait
			icon = "img/combat/icons/icon_Nico_grapple.png",--the icon itself
			desc_title = "Web Immunity",--title
			desc_text = "This unit is unaffected by Webbing.",--description
		}
	end
end

function mod:load(options, version)
	--Remove Grapples (Webs) from Leaper Mech:
	local function HOOK_PawnGrappled(mission, pawn, isGrappled) --Here's the function that will run
		if isGrappled and (pawn:GetType() == "tosx_Husk1" or pawn:GetType() == "tosx_Husk2") then --If we're grappled and it's our leaper
			--If removing the web right away it looks really weird (try it if you want). So we'll wait about half a second with this
			modApi:scheduleHook(550,function()
				local space = pawn:GetSpace() --Store the space so we can move it back later
				Board:AddAlert(space,"WEB PREVENTED") --This will play an alert when it happens
				--It's entirely optional, remove it if you don't like it
				pawn:SetSpace(Point(-1,-1)) --Move the pawn to Point(-1,-1)
				modApi:runLater(function() --This runs a function one frame later so things get updated
					pawn:SetSpace(space) --Move the pawn back, after that one frame. The web will be gone
				end)
			end)
		end
	end
	
	local function EVENT_onModsLoaded() --This function will run when the mod is loaded
		--modapiext is requested in the init.lua
		modapiext:addPawnIsGrappledHook(HOOK_PawnGrappled)
		--This line tells us that we want to run the above function every time a pawn is grappled
	end
	modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)
end

return mod
