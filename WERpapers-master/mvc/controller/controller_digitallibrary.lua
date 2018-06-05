--[[
@title: Digital library controller
@goal: Intermediate the communication between the vision and model layer of the digital library system.
@context:
	Localization: controller layer
	Precondition: SHOW EVENT PAGE, SHOW EVENT PAPERS PAGE, SHOW EDITIONS PAPERS PAGE.
@actors: digital library system.
@resources: command to be executed and first parameter
]]--

module(..., package.seeall)

--@Episode 1: 
local model_event = require("model.model_event")
local model_edition = require("model.model_edition")
local model_session = require("model.model_session")
local model_paper = require("model.model_paper")

function digitalLibraryController(command, first_parameter)

	if (command == "return_event_data") then

--episode: RETURN EVENT DATA
		local event_data = model_event.returnEventData(first_parameter)
		event_data["subtitle"] = string.gsub(event_data["subtitle"], "\n", "<br />")
		event_data["description"] = string.gsub(event_data["description"], "\n", "<br />")
		return event_data

	elseif (command == "return_paperpage_data") then

--episode: RETURN PAPERS PAGE DATA
		local paperspage_data = model_event.returnPapersPageData(first_parameter)
		paperspage_data["subtitle"] = string.gsub(paperspage_data["subtitle"], "\n", "<br />")
		paperspage_data["description"] = string.gsub(paperspage_data["description"], "\n", "<br />")
		return paperspage_data

	elseif (command == "return_event_editions") then 

--episode: RETURN EDITIONS OF AN EVENT
		return model_event.returnEventEditions(first_parameter)

	elseif (command == "return_mainpage_paths") then 

--episode: RETURN MAIN PAGE PATHS
		return model_event.returnPaths()
	
	elseif (command == "return_paperpage_paths") then 
	
--episode: RETURN MAIN PAGE PATHS	
		return model_event.returnPaths()	
	
	elseif (command == "return_editions_with_papers") then 
	
--episode: RETURN EDITIONS WITH PAPERS
		return model_edition.returnEditionsWithPapers(first_parameter)
	
	elseif (command == "return_edition_data") then

--episode: RETURN DATA FROM AN EDITION
		return model_edition.returnEditionData(first_parameter)
	
	elseif (command == "return_edition_proceedings_editors") then 

--episode: RETURN EDITION PROCEEDINFS EDITORS
		return model_edition.returnEditionProceedingsEditors(first_parameter)
		
	elseif (command == "return_edition_sessions") then 

--episode: RETURN EDITION SESSIONS
		return model_edition.returnEditionSessions(first_parameter)
	
	elseif (command == "return_session_papers") then

--episode: RETURN SESSION PAPERS
		return model_session.returnSessionPapers(first_parameter)

	elseif (command == "return_paper_authors") then 

--episode: RETURN PAPER AUTHORS
		return model_paper.returnPaperAuthors(first_parameter)
		
	elseif (command == "return_paper_scholar_url") then 	
		
--episode: RETURN PAPER'S SCHOLAR URL
		return model_paper.returnPapersScholarURL(first_parameter)
			
	else

--episode:	
		return "Error: command not found"
		
	end --if
end
