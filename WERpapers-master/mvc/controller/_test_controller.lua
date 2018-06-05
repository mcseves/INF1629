
dofile("../config/config.lua")
package.path = package.path..returnDLPath()

local model_event = require("model.model_event")
local model_edition = require("model.model_edition")

local editions = model_edition.returnEditionsWithPapers(2)

local edition = model_edition.returnEditionData(3)

print(#edition)

for i,v in pairs (edition) do

	print (v["acronym"])
end
