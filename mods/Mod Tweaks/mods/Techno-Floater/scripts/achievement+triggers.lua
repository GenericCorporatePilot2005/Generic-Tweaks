
local mod = mod_loader.mods[modApi.currentMod]
local path = mod.resourcePath
local bnb = mod_loader.mods["lmn_bots_and_bugs"]
local modApiExt = bnb.libs.modApiExt
local switch = bnb.libs.switch

local boss = "floater"

local chievo_writepath = "img/achievement/Nico_"
local toast_writepath = "img/achievement/toast/Nico_"
local chievo_readpath = path .. "img/achievement/"
local toast_readpath = path .. "img/achievement/toast/"

local Boss = boss:gsub("^.", string.upper) -- capitalize first letter

modApi:appendAsset(
	chievo_writepath .. boss ..".png",
	chievo_readpath .. boss ..".png"
)
modApi:appendAsset(
	toast_writepath .. boss ..".png",
	toast_readpath .. boss ..".png"
)

modApi.achievements:add{
	id = boss,
	name = Boss ..' Leader',
	tooltip = 'Destroy the '.. Boss ..' Leader\n\nReward: '.. Boss ..' Mech\nin Random Squad.\nAvailable in Custom Squad if Secret Squad is unlocked',
	image = 'img/achievement/Nico_'.. boss ..'.png',
}

local toasts = {}
local isCompleted = switch{ default = function() end }
local triggerChievo = switch{ default = function() end }

toasts[boss] = {
	title = Boss ..' Unlocked!',
    name = Boss ..' Mech',
	tooltip = Boss ..' Mech unlocked.',
    image = 'img/achievement/toast/Nico_'.. boss ..'.png'
}

isCompleted["lmn_FloaterBoss"] = function()
    return modApi.achievements:isComplete(mod.id, boss)
end

triggerChievo["lmn_FloaterBoss"] = function()
	modApi.achievements:trigger(mod.id, boss)
    modApi.toasts:add(toasts[boss])
end

local function onModsLoaded()
	modApiExt:addPawnKilledHook(function(mission, pawn)
		local pawnType = pawn:GetType()

		if isCompleted:case(pawnType) then
			return
		end

		triggerChievo:case(pawnType)
	end)
end

modApi.events.onModsLoaded:subscribe(onModsLoaded)