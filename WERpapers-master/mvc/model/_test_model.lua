dofile("../config/config.lua")
package.path = package.path..returnDLPath()

local model_utils = require("model.model_utils")
local model_paper = require("model.model_paper")


--~ local string_acentuada = "A informa��o n�o � confi�vel gggg"

--~ print (string.gsub(string_acentuada, "(.)", convertSpecialCharacterToUTF8))


print (model_paper.returnPapersScholarURL(9))
