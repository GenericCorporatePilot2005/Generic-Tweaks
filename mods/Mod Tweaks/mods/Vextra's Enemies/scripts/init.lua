local mod = {
	id = "Nico_Vextra_enemy",
    name = "Vextra's Enemy Portraits",
    description="Changes almost all enemy portraits' backgrounds.",
	modApiVersion = "2.8.2",
	gameVersion = "1.2.83",
    version="1.",
	icon = "img/icon.png",
	dependencies = {"Djinn_NAH_Tatu_Vextra"},
	libs = {},
	enabled=false,
}
function mod:init()
    local path = mod_loader.mods[modApi.currentMod].resourcePath
    local files = {
        "DNT_Anthill2.png",
        "DNT_AnthillBoss.png",
        "DNT_Antlion2.png",
        "DNT_AntlionBoss.png",
        "DNT_Cockroach2.png",
        "DNT_CockroachBoss.png",
        "DNT_Dragonfly1.png",
        "DNT_Dragonfly2.png",
        "DNT_DragonflyBoss.png",
        "DNT_Fly2.png",
        "DNT_FlyBoss.png",
        "DNT_haste1.png",
        "DNT_IceCrawler2.png",
        "DNT_IceCrawlerBoss.png",
        "DNT_JunebugBoss.png",
        "DNT_Ladybug2.png",
        "DNT_LadybugBoss.png",
        "DNT_Mantis2.png",
        "DNT_MantisBoss.png",
        "DNT_Nurse1.png",
        "DNT_Pillbug2.png",
        "DNT_PillbugBoss.png",
        "DNT_Reactive1.png",
        "DNT_Silkworm2.png",
        "DNT_SilkwormBoss.png",
        "DNT_Stinkbug1.png",
        "DNT_Stinkbug2.png",
        "DNT_StinkbugBoss.png",
        "DNT_Termites2.png",
        "DNT_TermitesBoss.png",
        "DNT_Thunderbug2.png",
        "DNT_ThunderbugBoss.png",
        "DNT_Winter1.png",
    }
    local mechPath = "img/portraits/enemy/"
    for _, file in ipairs(files) do
        modApi:appendAsset(mechPath.. file, path .. mechPath .. file)
    end
end

function mod:load(options, version)
end

return mod