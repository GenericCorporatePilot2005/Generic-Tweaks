
local mod = {
	id = "Nico-4/01",
	name = "Ballistic Bravo",
	description = "Don't ask, I don't know why either.\n(replaces Ballistic Mech's sprites for Johnny Bravo inspired ones, adds random quotes)",
	icon = "mod_icon.png",
	submodFolders = {"Mods/"},
	version = "ravo but with a B.",
	dependencies = {"tosx_MissileCommand"},
}
function mod:init()
	tosx_Missile1Mech.Name = "Ballistic Bravo",
	modApi:appendAssets("img/units/player/", "img/", "")
	modApi.events.onNextTurn:subscribe(function(mission)
		if Game:GetTeamTurn() ~= TEAM_PLAYER then return end

		for i = 0, 2 do
			local pawn = Board:GetPawn(i)
			if pawn and pawn:GetType() == "tosx_Missile1Mech" then
				local loc = pawn:GetSpace()
				local qoutes = {"Woah, Mama!","Man, I'm pretty!","I am Johnny Bravo, the one-man army!",
					"Wanna see me comb my hair, really fast?","Now remember, I do my best work when I'm being worshipped as a god.",
					"Enough about you, let's talk about me, "..pawn:GetMechName()..".", "Hello, 911 emergency? There's a handsome guy in my house."}
				local n = math.random(#qoutes)
				if n == 7 then
					Board:AddAlert(loc,qoutes[n])
					local effect = SkillEffect()
					modApi:runLater(function()
						modApi:runLater(function()
							local s = SpaceDamage(loc)
							s.sScript = "Board:AddAlert("..loc:GetString()..",\"Hey, wait a second. Cancel that, it's only me.\")"
							effect:AddDamage(s)
							Board:AddEffect(effect)
						end)
					end)
				else
					Board:AddAlert(loc,qoutes[n])
				end
			end
		end
	end)
end
function mod:load(options, version)
end
return mod