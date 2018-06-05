module(..., package.seeall)

local db_query = require("dba.db_query")	


--[[ ===================================================================================================================
@title: Return event data
@goal: Allows access to the data of an event.
@context: 
	- location: model layer.
	- precondition: DIGITAL LIBRARY CONTROLLER
@actors: system.
@resources: event id and dao_event module.
]]--
function returnEventData(event_id) 

--episode: Assembles query to select event data.
	local q_event_data = "SELECT * FROM event "..
							"WHERE event_id = "..event_id..
							" AND exclusion_flag = 1"

--episode: EXECUTES SELECT QUERY IN THE DATABASE.
	local q_result, selected_event = db_query.executeSelectQuery(q_event_data)
	
--episode: Return the selected event.	
	return selected_event[1]
end


--[[ ===================================================================================================================
@title: Return editions of an event
@goal: Allows access to editions of an event.
@context: 
	- location: model layer.
	- precondition: DIGITAL LIBRARY CONTROLLER
@actors: system.
@resources: event id and config.lua file
]]--
function returnEventEditions(event_id) 

--episode: Assembles query to select event editions.
	local q_event_editions = "SELECT * FROM edition "..
								"WHERE event_id = "..event_id..
								" AND exclusion_flag = 1"
								
--episode: EXECUTES SELECT QUERY IN THE DATABASE.								
	local q_result, event_editions = db_query.executeSelectQuery(q_event_editions)
	
--episode: Return event editions.
	return event_editions
end


--[[ ===================================================================================================================
@title: Return papers page data
@goal: Allows access to the data of a papers page.
@context: 
	- location: model layer.
	- precondition: DIGITAL LIBRARY CONTROLLER
@actors: system.
@resources: event id and dao_event module.
]]--
function returnPapersPageData(event_id)

--episode: Assembles query to select paperpage data.
	local q_paperpage_data = "SELECT * FROM paperspage "..
								"WHERE event_id = "..event_id..
								" AND exclusion_flag = 1"
 
--episode: 	EXECUTES SELECT QUERY IN THE DATABASE.
	local q_result, selected_paperspage = db_query.executeSelectQuery(q_paperpage_data)
	
--episode: Return the selected papers page.		
	return selected_paperspage[1]
end


--[[ ===================================================================================================================
@title: Return main page paths
@goal: Allows access to the main page paths.
@context: 
	- location: model layer.
	- precondition: DIGITAL LIBRARY CONTROLLER
@actors: system.
@resources: config.lua file
]]--
function returnPaths() 
	return returnMainPagePaths()
end