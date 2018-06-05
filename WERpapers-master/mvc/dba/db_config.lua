require"luasql.mysql"

--[[
@title: Connect to the database
@goal: Allow connection with MySQL database.
@context: 
	location: database configuration file.
	precondition:
@actors: system.
@resourses: database name, login, password, address, port and luasql.mysql.
]]--

--@episode 1: Set connection atributes.
--local db_name = "digitallibrary"
--local db_login = "dlibrary"
local db_name = "wer"
local db_login = "wer"
local db_pass = "wer2103"
local db_address = "localhost"
local db_port = "3306"

function connectDB()

--@episode 2: Create environment.
	local env = luasql.mysql ()
	
--@episode 3: Open connection with the desired configuration.
	local connection = assert (env:connect (db_name, db_login, db_pass, db_address, db_port))
	
--@episode 4: Return connection.
	return connection

end



