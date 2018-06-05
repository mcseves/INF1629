module(..., package.seeall)

local db_query = require("dba.db_query")


--[[ ===================================================================================================================
@title: Return data from an edition
@goal: Allows access to data from an edition
@context: 
	- location: model layer.
	- precondition: 
@actors: system.
@resources: edition id and config.lua file
]]--
function returnEditionData(edition_id)

--episode: Assembles query to select edition data.
	local q_edition_data = "SELECT * FROM edition "
								.."WHERE edition_id = "..edition_id..
								" AND exclusion_flag = 1"
	local q_result, event_data = db_query.executeSelectQuery(q_edition_data)
	
--episode: Return the edition data.
	return event_data[1]
end


--[[ ===================================================================================================================
@title: Return editions with papers
@goal: Allows access to data of editions that have papers.
@context: 
	- location: model layer.
	- precondition: 
@actors: system.
@resources: event id and config.lua file
]]--
function returnEditionsWithPapers(event_id)

--episode: Assembles query to select editions with papers.
	local q_editions_with_papers = "SELECT * FROM edition ".. 
										"WHERE event_id = "..event_id..
										" AND has_papers = 1 "..
										"AND exclusion_flag = 1"
										
--episode: EXECUTES SELECT QUERY IN THE DATABASE.										
	local q_result, editions_with_papers = db_query.executeSelectQuery(q_editions_with_papers)
	
--episode: Return the selected editions.
	return editions_with_papers
end


--[[ ===================================================================================================================
@title: Return edition proceedings editors
@goal: Allows access to the data of the editors of the edition proceedings.
@context: 
	- location: model layer.
	- precondition: 
@actors: system.
@resources: edition id and config.lua file
]]--
function returnEditionProceedingsEditors(edition_id)

--episode: Assembles query to select edition proceedings editors.
	local q_edition_proceedings_editors = "SELECT * FROM researcher "..
												"WHERE exclusion_flag = 1 "..
												"AND researcher_id IN "..
												"(SELECT researcher_id FROM edition_researcher_editor "..
													"WHERE exclusion_flag = 1 "..
													"AND edition_id = "..edition_id.." )"

--episode: EXECUTES SELECT QUERY IN THE DATABASE.													
	local q_result, edition_editors = db_query.executeSelectQuery(q_edition_proceedings_editors)
	
--episode: Return the selected editors.	
	return edition_editors
end


--[[ ===================================================================================================================
@title: Return edition sessions
@goal: Allows access to the data of the edition sessions.
@context: 
	- location: model layer.
	- precondition: 
@actors: system.
@resources: edition id and config.lua file
]]--
function returnEditionSessions(edition_id)

--episode: Assembles query to select edition sessions.
	local q_edition_sessions = "SELECT * FROM session "..
									"WHERE exclusion_flag = 1 "..
									"AND edition_id = "..edition_id

--episode: EXECUTES SELECT QUERY IN THE DATABASE.		
	local q_result, edition_sessions = db_query.executeSelectQuery(q_edition_sessions)
	
--episode: Return the selected sessions.
	return edition_sessions
end	


--[[ ===================================================================================================================
@title: Return edition papers
@goal: Allows access to the data of the edition papers.
@context: 
	- location: model layer.
	- precondition: 
@actors: system.
@resources: edition id and config.lua file
]]--
function returnEditionPapers(edition_id)

--episode: Assembles query to select edition papers.
	local q_edition_papers = "SELECT * FROM paper "..
								"WHERE session_id in "..
								"(SELECT session_id FROM session ".. 
									"WHERE edition_id ="..edition_id..")"
									
--episode: EXECUTES SELECT QUERY IN THE DATABASE.		
	local q_result, edition_papers = db_query.executeSelectQuery(q_edition_papers)									

--episode: Return the selected pappers.
	return edition_papers

end