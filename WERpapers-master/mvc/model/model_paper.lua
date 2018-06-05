module(..., package.seeall)

local db_query = require("dba.db_query")
local model_utils = require("model.model_utils")

--[[ ===================================================================================================================
@title: Return paper authors 
@goal: Allows access to the data of the paper authors.
@context: 
	- location: model layer.
	- precondition: DIGITAL LIBRARY CONTROLLER, RETURN THE SCHOLAR URL OF THE PAPER.
@actors: system.
@resources: paper id and config.lua file
]]--
function returnPaperAuthors(paper_id)

--episode: Assembles query to select edition papers.
	local q_paper_authors = "SELECT r.*, pr.first_author FROM researcher r, paper_researcher pr "..
								"WHERE r.researcher_id = pr.researcher_id AND r.researcher_id IN "..
								"(SELECT researcher_id FROM paper_researcher "..
									"WHERE paper_id = "..paper_id.." )"
								
--@episode: EXECUTES SELECT QUERY IN THE DATABASE.		
	local q_result, paper_authors = db_query.executeSelectQuery(q_paper_authors)									

--@episode: Return the selected pappers.
	return paper_authors

end


--[[ ===================================================================================================================
@title: Return the scholar URL of the paper
@goal: Allows the search for the article on google scholar through a url.
@context: 
	- location: model layer.
	- precondition: DIGITAL LIBRARY CONTROLLER
@actors: system.
@resources: paper id and config.lua file
]]--
function returnPapersScholarURL(paper_id)

	local url_prefix = "http://scholar.google.com.br/scholar?hl=pt-BR&num=50&as_sdt=0,5&q=%22"
	local url_sufix = "%22+autor%3A%22"

--@episode: RETURN PAPER DATA
	local paper_data = returnPaperData(paper_id)
	
--@episode: RETURN PAPER AUTHORS
	local paper_authors = returnPaperAuthors(paper_id)	
	local fa_last_name = ""
	
--@episode: Selects the last name of first author of the paper.
	for i, author in pairs(paper_authors) do
		if (author["first_author"] == "1") then
			for last_string in author["name"]:gmatch("%s(%a+)") do 
				fa_last_name = last_string
			end
		end
	end
	
--@episode: ESCAPE SPECIAL CHARACTERS TO UTF8 	
	local scholar_url = string.gsub(paper_data[1]["title"], "(.)", convertSpecialCharacterToUTF8) 
	
--@episode: Replaces title whitespaces by "+".
	scholar_url = string.gsub(scholar_url, "(%s)", "+")
	
--@episode: Add prefix to URL. 	
	scholar_url = url_prefix..scholar_url..url_sufix..fa_last_name.."%22"
	
	return scholar_url

end


--[[ ===================================================================================================================
@title: Return paper data
@goal: Allows access to the paper's data.
@context: 
	- location: model layer.
	- precondition: RETURN THE SCHOLAR URL OF THE PAPER
@actors: system.
@resources: paper id and config.lua file
]]--
function returnPaperData(paper_id)

--@episode: Assembles query to select edition papers.
	local q_paper = "SELECT * FROM paper "..
						"WHERE paper_id = "..paper_id
									
--@episode: EXECUTES SELECT QUERY IN THE DATABASE.		
	local q_result, paper_data = db_query.executeSelectQuery(q_paper)									

--@episode: Return the selected pappers.
	return paper_data

end 