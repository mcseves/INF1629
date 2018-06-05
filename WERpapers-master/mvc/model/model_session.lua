module(..., package.seeall)

local db_query = require("dba.db_query")

--[[ ===================================================================================================================
@title: Return session papers
@goal: Allows access to the data of the session papers.
@context: 
	- location: model layer.
	- precondition: 
@actors: system.
@resources: edition id and config.lua file
]]--
function returnSessionPapers(session_id)

--episode: Assembles query to select edition papers.
	local q_session_papers = "SELECT * FROM paper "..
								"WHERE session_id = "..session_id
									
--episode: EXECUTES SELECT QUERY IN THE DATABASE.		
	local q_result, session_papers = db_query.executeSelectQuery(q_session_papers)									

	
--episode: Return the selected pappers.
	return session_papers

end