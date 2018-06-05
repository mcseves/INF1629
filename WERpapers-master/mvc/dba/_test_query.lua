
dofile("../config/config.lua")
package.path = package.path..returnDLPath()
local db_query = require("dba.db_query")


local resultado, dados = db_query.executeSelectQuery("select * from edition", "edition")

if (resultado) then
	print("ok")
	for i, v  in pairs (dados) do
		print(v["name"])
	end
end


--~ function multiple (k, l, v)

--~ 	print ("hello")

--~ 	if (k) then
--~ 		print("hello again")
--~ 	end

--~ end


--~ multiple(true)
