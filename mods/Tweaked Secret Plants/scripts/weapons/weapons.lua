local mod = modApi:getCurrentMod()
local path = mod.scriptPath
local this = {}

require(path .."weapons/chili")
require(path .."weapons/chomper")
require(path .."weapons/puffer")
--[[pendientes:
chili, darle la opcion de cambiar empuje, quitar daño mortal a favor de empuje y daño
puffer, ataque a adjacentes y ataque estilo burrower
chomper, dar vuelta ataques, incluso de espejo
PRIORIDAD, CHOMPER]]