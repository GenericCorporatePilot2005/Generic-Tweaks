local mod = modApi:getCurrentMod()
local options = mod_loader.currentModContent[mod.id].options
if options["Nico_Arachnoid_Web"].value == 0 then
	require(mod.scriptPath .."libs/trait")
	--Remove Grapples (Webs) from Arachnoids:
	local function HOOK_PawnGrappled(mission, pawn, isGrappled) --Here's the function that will run
		if isGrappled and (pawn:GetType() == "DeployUnit_Aracnoid" or pawn:GetType() == "DeployUnit_AracnoidB") then --If we're grappled and it's an arachnoid
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
	local path = mod.resourcePath
	modApi:appendAsset("img/combat/icons/icon_Nico_grapple.png",path.."img/icon_Nico_grapple.png")--image of the trait
	local trait = require(mod.scriptPath .."libs/trait")--where does it get the code for the rest of this to work
	for i = 1,2 do
		local pawntype = ""
		if i == 1 then
			pawntype = "DeployUnit_Aracnoid"
		else
			pawntype = "DeployUnit_AracnoidB"
		end
		trait:add{
			pawnType = pawntype,--who will get the trait
			icon = "img/combat/icons/icon_Nico_grapple.png",--the icon itself
			desc_title = "Web Immunity",--title
			desc_text = "This unit is unaffected by Webbing.",--description
		}
	end
end
if options["Nico_Psion_Receiver"].value == 0 then
	--Lemon's Real Mission Checker
	local function isRealMission()
		local mission = GetCurrentMission()

		return true
			and mission ~= nil
			and mission ~= Mission_Test
			and Board
			and Board:IsMissionBoard()
	end
	local function Spider(mission)
		if isRealMission() and IsPassiveSkill("Psion_Leech") and (Board:GetPawn(0):IsMutation(9) or Board:GetPawn(1):IsMutation(9) or Board:GetPawn(2):IsMutation(9)) then
			SpiderlingHatch1.SpiderType = ""
		else
			SpiderlingHatch1.SpiderType = "Spiderling1"
		end
	end

	local function SpiderLoad()
		if isRealMission() and IsPassiveSkill("Psion_Leech") and (Board:GetPawn(0):IsMutation(9) or Board:GetPawn(1):IsMutation(9) or Board:GetPawn(2):IsMutation(9)) then
			SpiderlingHatch1.SpiderType = ""
		else
			SpiderlingHatch1.SpiderType = "Spiderling1"
		end
	end

	local function Spiderer(mission)
		if isRealMission() and IsPassiveSkill("Psion_Leech") and (Board:GetPawn(0):IsMutation(9) or Board:GetPawn(1):IsMutation(9) or Board:GetPawn(2):IsMutation(9)) then
			SpiderlingHatch1.SpiderType = ""
		else
			SpiderlingHatch1.SpiderType = "Spiderling1"
		end
	end

	local function UnspiderA(mission, pawn)
		if pawn:GetType() == "Jelly_Spider1" then
			SpiderlingHatch1.SpiderType = "Spiderling1"
		end
	end

	local function UnspiderB(screen)
		SpiderlingHatch1.SpiderType = "Spiderling1"
	end

	local function Hatcher(mission, pawn, weaponId, p1, p2)
		if Board and mission and weaponId and p1 and p2 and weaponId == "SpiderlingHatch1" and IsPassiveSkill("Psion_Leech") and (Board:GetPawn(0):IsMutation(9) or Board:GetPawn(1):IsMutation(9) or Board:GetPawn(2):IsMutation(9)) then
			local ret = SkillEffect()
			ret:AddScript("Board:AddPawn(\"DeployUnit_Aracnoid\","..p1:GetString()..")")
			ret:AddScript("Board:GetPawn("..p1:GetString().."):SetActive(false)")
			Board:AddEffect(ret)
		end
	end

	local function EVENT_onModsLoaded() --This function will run when the mod is loaded
		--modapiext is requested in the init.lua
		modapiext:addPawnIsGrappledHook(HOOK_PawnGrappled)
		--This line tells us that we want to run the above function every time a pawn is grappled
		--modApi.events.onMissionChanged:subscribe(Spider) - runs every frame ew
		--modApi:addPostLoadGameHook(SpiderLoad)
		modApi.events.onHangarLeaving:subscribe(Spider)
		--This line tells us that we want to run the above function every time a save file is loaded
		modApi:addMissionStartHook(Spider)
		--This line tells us that we want to run the above function every time a mission is entered
		modApi:addSaveGameHook(Spiderer)
		--This line tells us that we want to run the above function every time the game is saved (so after all weapon effects and death effects have processed, Vek Spawns generating)
		modapiext:addPawnKilledHook(UnspiderA)
		--This line tells us that we want to run the above function every time a pawn dies
		modApi.events.onGameExited:subscribe(UnspiderB)
		--This line tells us that we want to run the above function every time the player exits to the menu
		modapiext:addSkillEndHook(Hatcher)
		--This line tells us that we want to run the above function every time a weapon is used (e.g. the Egg Hatching)
	end

	modApi.events.onModsLoaded:subscribe(EVENT_onModsLoaded)
end