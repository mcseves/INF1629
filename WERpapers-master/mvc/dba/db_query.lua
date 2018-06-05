module(..., package.seeall)

dofile("../dba/db_config.lua")


--[[ ===================================================================================================================
@title: Executes select query in the database 
@goal: Allows execution of selection queries in the database. Returns the query result.
@context: 
	- location: database access layer.
	- precondition: 
@actors: system.
@resources: event id and db_config.lua file
]]--
function executeSelectQuery(query)

--@episode 1: CONNECT TO THE DATABASE.
	local conn = connectDB()
	
	local select_result = ""

--@episode 2: Executes the select query.
	local cursor, query_error = conn:execute (query)

--@episode 3: If an error occurs, assembles a message explaining where the error occurred and the QUERY that caused the error.
	if not cursor then
		error (query_error.." Error executing select. QUERY = [=["..query.."]=]")
		conn:close()
		return false
	end
	
--@episode 4: Stores query result
	local select_result_line = cursor:fetch ({}, "a")
	local select_result_table = {}
	while select_result_line do
		table.insert(select_result_table, select_result_line)
		select_result_line = cursor:fetch ({}, "a")
	end

--@episode 5: Close the connection with database.
	conn:close()
	
--@episode 6: Returns query result.
	return true, select_result_table

end


--[[ ===================================================================================================================
@title: Executes insert query in the database 
@goal: Allows execution of insert queries in the database. Returns the inserted id.
@context: 
	- location: database access layer.
	- precondition: 
@actors: system.
@resources: event id and db_config.lua file
]]--
function executeInsertQuery(query)

--@episode 1: CONNECT TO THE DATABASE.
	local conn = connectDB()

--@episode 3: Executes the select query.
	local cursor, query_error = conn:execute (query)

--@episode 4: If an error occurs, assembles a message explaining where the error occurred and the QUERY that caused the error.
	if not cursor then
		error (query_error.." Error selecting "..table_name..". QUERY = [=["..query.."]=]")
		conn:close()
		return false
	end
	
--@episode 5: Stores query result
	local select_result_line = cursor:fetch ({}, "a")
	local select_result_table = {}
	while select_result_line do
		table.insert(select_result_table, select_result_line)
		select_result_line = cursor:fetch ({}, "a")
	end

--@Episódio 6: Executes the query to select last inserted id.
	local last_id_cursor, last_id_query_error = conn:execute("SELECT LAST_INSERT_ID()")

--@Episódio 7: If an error occurs, assembles a message explaining where the error occurred and the QUERY that caused the error.
	if not last_id_cursor then
	    error (last_id_query_error.." Error selecting LAST INSERTED ID.")
		conn:close()
		return false
	end	
	
--@episode 5: Close the connection with database.
	conn:close()
	
--@Episódio 8: Stores "select last id" query result
	local last_id_result_line = last_id_cursor:fetch ({}, "a")
	local last_id_result_table = {}
	while last_id_result_line do
		table.insert(last_id_result_table, last_id_result_line)
		last_id_result_line = last_id_cursor:fetch ({}, "a")
	end

--@Episódio 9: Recovers the last inserted id
	local last_id
	for i, v in pairs(last_id_result_table) do
		last_id = v["LAST_INSERT_ID()"]
	end

--@episode 6: Returns query result and .
	return true, select_result_table

end