local mod = {
	id = "Nico_tankyTweaks",
    name = "Deployable Tanks",
    description="Makes the palette of the Deployable Tanks change with the palette of the deployer.",
	modApiVersion = "2.8.2",
	gameVersion = "1.2.83",
    version="1.",
	icon = "icon.png",
	dependencies = {},
	libs = {},
	enabled=false,
}

function mod:init()
	local options = mod_loader.currentModContent[mod.id].options
    local Nico_Light_Tanks_Palette = options["Nico_Light_Tanks_Palette"].value
    local Nico_ACID_Tanks_Palette = options["Nico_ACID_Tanks_Palette"].value
    local Nico_Pull_Tanks_Palette = options["Nico_Pull_Tanks_Palette"].value
    local Nico_Shield_Tanks_Palette = options["Nico_Shield_Tanks_Palette"].value
    --normal Tank
    if Nico_Light_Tanks_Palette==1 then
        modApi:appendAsset("img/units/player/Nico_tank.png", mod.resourcePath .."img/units/player/Nico_tank.png")
        modApi:appendAsset("img/units/player/Nico_tank_death.png", mod.resourcePath .."img/units/player/Nico_tank_death.png")
        modApi:appendAsset("img/units/player/Nico_tanka.png", mod.resourcePath .."img/units/player/Nico_tanka.png")
        modApi:appendAsset("img/units/player/Nico_tank_ns.png", mod.resourcePath .."img/units/player/Nico_tank_ns.png")
        local a=ANIMS
            a.Nico_Tank = 	a.MechUnit:new{ Image = "units/player/Nico_tank.png", PosX = -15, PosY = 12 }
            a.Nico_Tanka = a.MechUnit:new{ Image = "units/player/Nico_tanka.png", PosX = -15, PosY = 12, NumFrames = 2 }
            a.Nico_Tankd = a.Nico_Tank:new{ Image = "units/player/Nico_tank_death.png", PosX = -21, PosY = 3, NumFrames = 11, Time = 0.14, Loop = false }
            a.Nico_Tank_ns  = a.MechIcon:new{ Image = "units/player/Nico_tank_ns.png"}
            Deploy_Tank.Image = "Nico_Tank"
        function DeploySkill_Tank:GetSkillEffect(p1, p2)	
            local ret = SkillEffect()
            local damage = SpaceDamage(p2,0)
            damage.sPawn = self.Deployed
            ret:AddArtillery(damage,self.Projectile)
            ret:AddBounce(p2, 3)
            if Board:GetPawn(p1):GetImageOffset() ~= 0 then
                -- change tank color
                ret:AddScript(string.format("_G[%q].ImageOffset = Board:GetPawn(%s):GetImageOffset()",self.Deployed,p1:GetString()))
                ret:AddBounce(damage.loc,1)
            else
                Deploy_Tank.ImageOffset = 0
            end
            return ret
        end
    end
    --acid Tank
    if Nico_ACID_Tanks_Palette==1 then
        modApi:appendAsset("img/units/player/Nico_tankacid.png", mod.resourcePath .."img/units/player/Nico_tankacid.png")
        modApi:appendAsset("img/units/player/Nico_tankacid_death.png", mod.resourcePath .."img/units/player/Nico_tankacid_death.png")
        modApi:appendAsset("img/units/player/Nico_tankacida.png", mod.resourcePath .."img/units/player/Nico_tankacida.png")
        modApi:appendAsset("img/units/player/Nico_tankacid_ns.png", mod.resourcePath .."img/units/player/Nico_tankacid_ns.png")
        local a=ANIMS
            a.Nico_Tankacid =  a.MechUnit:new{ Image = "units/player/Nico_tankacid.png", PosX = -15, PosY = 4 }
            a.Nico_Tankacida = a.MechUnit:new{ Image = "units/player/Nico_tankacida.png", PosX = -15, PosY = 4, NumFrames = 2 }
            a.Nico_Tankacidd = a.Nico_Tankacid:new{ Image = "units/player/Nico_tankacid_death.png", PosX = -21, PosY = 3, NumFrames = 11, Time = 0.14, Loop = false }
            a.Nico_Tankacid_ns=a.MechIcon:new{ Image = "units/player/Nico_tankacid_ns.png"}
        Deploy_AcidTank.Image = "Nico_Tankacid"
        Deploy_AcidTank.ImageOffset = 0
        function DeploySkill_AcidTank:GetSkillEffect(p1, p2)	
            local ret = SkillEffect()
            local damage = SpaceDamage(p2,0)
            damage.sPawn = self.Deployed
            ret:AddArtillery(damage,self.Projectile)
            ret:AddBounce(p2, 3)
            -- change tank color
            ret:AddScript(string.format("_G[%q].ImageOffset = Board:GetPawn(%s):GetImageOffset()",self.Deployed,p1:GetString()))
            ret:AddAnimation(damage.loc,"ExploRepulse1", ANIM_NO_DELAY)
            return ret
        end
    end
    --pull Tank 1
    if Nico_Pull_Tanks_Palette==1 then
        modApi:appendAsset("img/units/player/Nico_tankpull1.png", mod.resourcePath .."img/units/player/Nico_tankpull1.png")
        modApi:appendAsset("img/units/player/Nico_tankpull1_death.png", mod.resourcePath .."img/units/player/Nico_tankpull1_death.png")
        modApi:appendAsset("img/units/player/Nico_tankpull1a.png", mod.resourcePath .."img/units/player/Nico_tankpull1a.png")
        modApi:appendAsset("img/units/player/Nico_tankpull1_ns.png", mod.resourcePath .."img/units/player/Nico_tankpull1_ns.png")
        local a=ANIMS
            a.Nico_tankpull1 = 	a.MechUnit:new{ Image = "units/player/Nico_tankpull1.png", PosX = -16, PosY = 3 }
            a.Nico_tankpull1a = a.MechUnit:new{ Image = "units/player/Nico_tankpull1a.png", PosX = -16, PosY = 2, NumFrames = 2 }
            a.Nico_tankpull1d = a.Nico_tankpull1:new{ Image = "units/player/Nico_tankpull1_death.png", PosX = -20, PosY = -3, NumFrames = 11, Time = 0.14, Loop = false }
            a.Nico_tankpull1_ns=a.MechIcon:new{ Image = "units/player/Nico_tankpull1_ns.png"}
            Deploy_PullTank.Image = "Nico_tankpull1"
            Deploy_PullTank.ImageOffset = 0
        function DeploySkill_PullTank:GetSkillEffect(p1, p2)	
            local ret = SkillEffect()
            local damage = SpaceDamage(p2,0)
            damage.sPawn = self.Deployed
            ret:AddArtillery(damage,self.Projectile)
            ret:AddBounce(p2, 3)
            -- change tank color
                ret:AddScript(string.format("_G[%q].ImageOffset = Board:GetPawn(%s):GetImageOffset()",self.Deployed,p1:GetString()))
                ret:AddBounce(damage.loc,1)
            return ret
        end
    --pull Tank 2
        modApi:appendAsset("img/units/player/Nico_tankpull2.png", mod.resourcePath .."img/units/player/Nico_tankpull2.png")
        modApi:appendAsset("img/units/player/Nico_tankpull2_death.png", mod.resourcePath .."img/units/player/Nico_tankpull2_death.png")
        modApi:appendAsset("img/units/player/Nico_tankpull2a.png", mod.resourcePath .."img/units/player/Nico_tankpull2a.png")
        modApi:appendAsset("img/units/player/Nico_tankpull2_ns.png", mod.resourcePath .."img/units/player/Nico_tankpull2_ns.png")
        local a=ANIMS
            a.Nico_tankpull2 = 	a.MechUnit:new{ Image = "units/player/Nico_tankpull2.png", PosX = -14, PosY = -3, }
            a.Nico_tankpull2a = a.MechUnit:new{ Image = "units/player/Nico_tankpull2a.png", PosX = -14, PosY = -3, NumFrames = 4 }
            a.Nico_tankpull2d = a.Nico_tankpull2:new{ Image = "units/player/Nico_tankpull2_death.png", PosX = -20, PosY = -3, NumFrames = 11, Time = 0.14, Loop = false }
            a.Nico_tankpull2_ns=a.MechIcon:new{ Image = "units/player/Nico_tankpull2_ns.png"}
            Deploy_PullTankB.Image = "Nico_tankpull2"
            Deploy_PullTankB.ImageOffset = 0
            Deploy_PullTankAB = Deploy_PullTankB:new{Health = 3}
            function DeploySkill_PullTank:GetSkillEffect(p1, p2)	
                local ret = SkillEffect()
                local damage = SpaceDamage(p2,0)
                damage.sPawn = self.Deployed
                ret:AddArtillery(damage,self.Projectile)
                ret:AddBounce(p2, 3)
                -- change tank color
                    ret:AddScript(string.format("_G[%q].ImageOffset = Board:GetPawn(%s):GetImageOffset()",self.Deployed,p1:GetString()))
                    ret:AddBounce(damage.loc,1)
                return ret
            end
    end
    --shield Tank
    if Nico_Shield_Tanks_Palette==1 then
        modApi:appendAsset("img/units/player/Nico_tankshield.png", mod.resourcePath .."img/units/player/Nico_tankshield.png")
        modApi:appendAsset("img/units/player/Nico_tankshield_death.png", mod.resourcePath .."img/units/player/Nico_tankshield_death.png")
        modApi:appendAsset("img/units/player/Nico_tankshielda.png", mod.resourcePath .."img/units/player/Nico_tankshielda.png")
        modApi:appendAsset("img/units/player/Nico_tankshield_ns.png", mod.resourcePath .."img/units/player/Nico_tankshield_ns.png")
        local a=ANIMS
            a.Nico_tankshield =  a.MechUnit:new{ Image = "units/player/Nico_tankshield.png", PosX = -15, PosY = 9}
            a.Nico_tankshielda = a.MechUnit:new{ Image = "units/player/Nico_tankshielda.png", PosX = -15, PosY = 8, NumFrames = 2}
            a.Nico_tankshieldd = a.Nico_tankshield:new{ Image = "units/player/Nico_tankshield_death.png", PosX = -21, PosY = 0, NumFrames = 11, Time = 0.14, Loop = false }
            a.Nico_tankshield_ns=a.MechIcon:new{ Image = "units/player/Nico_tankshield_ns.png"}
        Deploy_ShieldTank.Image = "Nico_tankshield"
        Deploy_ShieldTank.ImageOffset = 0
        function DeploySkill_ShieldTank:GetSkillEffect(p1, p2)	
            local ret = SkillEffect()
            local damage = SpaceDamage(p2,0)
            damage.sPawn = self.Deployed
            ret:AddArtillery(damage,self.Projectile)
            ret:AddBounce(p2, 3)
            -- change tank color
                ret:AddScript(string.format("_G[%q].ImageOffset = Board:GetPawn(%s):GetImageOffset()",self.Deployed,p1:GetString()))
                ret:AddBounce(damage.loc,1)
            return ret
        end
        function DeploySkill_PullTank_B:GetTargetArea(point)
            local ret = PointList()
            for i = DIR_START, DIR_END do
                for k = 2, 7 do
                    local curr = DIR_VECTORS[i]*k + point
                    if (not Board:IsPawnSpace(curr)) and (not Board:IsBlocked(curr, PATH_FLYER)) then ret:push_back(DIR_VECTORS[i]*k + point) end
                end
            end
            return ret
        end
    end
end

function mod:metadata()--Don't make any changes to resources in metadata. metadata runs regardless of if your mod is enabled or not.
    modApi:addGenerationOption(
		"Nico_Light_Tanks_Palette", "Light Tank's Palette",
		"What the Light Tank's Palette will be.\nREQUIRES RESTART TO TAKE EFFECT!",
		{
			strings = { "Default.", "Dynamic Palette."},
			values = { 0, 1,},
			value = 1
		}
	)
    modApi:addGenerationOption(
		"Nico_ACID_Tanks_Palette", "A.C.I.D. Tank's Palette",
		"What the A.C.I.D. Tank's Palette will be.\nREQUIRES RESTART TO TAKE EFFECT!",
		{
			strings = { "Default.", "Dynamic Palette."},
			values = { 0, 1,},
			value = 1
		}
	)
    modApi:addGenerationOption(
		"Nico_Pull_Tanks_Palette", "Pull-Tank's Palette",
		"What the Pull-Tank's Palette will be.\nREQUIRES RESTART TO TAKE EFFECT!",
		{
			strings = { "Default.", "Dynamic Palette."},
			values = { 0, 1,},
			value = 1
		}
	)
    modApi:addGenerationOption(
		"Nico_Shield_Tanks_Palette", "Shield-Tank's Palette",
		"What the Shield-Tank's Palette will be.\nREQUIRES RESTART TO TAKE EFFECT!",
		{
			strings = { "Default.", "Dynamic Palette."},
			values = { 0, 1,},
			value = 1
		}
	)
end

function mod:load(options, version)
end

return mod