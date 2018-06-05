<%

--[[
@title: Control request statistical query .
@goal: Obtain from model layer and transmits to view layer the result of the statistical query requested.
@context:
	localization: control layer.
	precondition: REQUEST KEYWORDS USED BY THE AUTHORS.
@actors: system.
@resources: query to be performed, first parameter(optional)
]]--

--@episode 1: imports the configuration file and sets the correct path.
dofile("../config/config.lua")	
package.path = package.path..returnDLPath()

--@episode 2: imports model_statistical and iconv module to charset tranformation
local model_statistical = require("model.model_statistical")
--require ("iconv")
--local cd = iconv.new("ISO-8859-1", "ISO-8859-1")

--@episode 3: imports model_statistical and iconv module to charset tranformation
local statistical_query = cgilua.QUERY.statistical_query
local first_parameter = ""

if (statistical_query == "keywordsUsedByAuthor") then


--episode 4: if the statisticas query is keywordsUsedByAuthor then RETURN KEYWORDS USED BY AUTHOR.
	local keywords_authors = model_statistical.returnKeywordsUsedByAuthors()
	local table_size = table.getn(keywords_authors)
	local json_obj = ""

--episode 5: assembles the json object according to the data returned.
	for i, v in pairs(keywords_authors) do

		local keyword = (v["k"])
		keyword = string.gsub(keyword, "\n", " ")	
		keyword = string.gsub(keyword, "\r", " ")
		keyword = string.gsub(keyword, "\b", " ")    
		keyword = string.gsub(keyword, "\t", " ")
		--keyword = cd:iconv(keyword)
		--local author = cd:iconv(v["author"])
		local author = v["author"]	--remover	
		
		json_obj = json_obj .. [[
			{
				"author":"]]..author..[[",
				"k":"]]..keyword..[[",
				"contador":"]]..v["contador"]..[["
			}
		]]
	
			
--episode 6: puts a comma after each element in the json object, except the last one.
		if (i < table_size) then
			json_obj = json_obj..","
		end	
	end

	json_obj = "["..json_obj.."]"
	cgilua.contentheader("application" , "xml; charset=iso-8859-1")
	
--episode 7: returns the json object.
	cgilua.put(json_obj)

elseif (statistical_query == "totalNumberOfPapers") then

--episode 8: if the statisticas query is totalNumberOfPapers then RETURN TOTAL NUMBER OF PAPERS
	local t_total_num_papers = model_statistical.returnTotalNumberOfPapers()
	local json_obj = ""


--episode 9: assembles the json object according to the data returned.
	for i, v in pairs(t_total_num_papers) do
		
		for i, v in pairs(v) do

			json_obj = json_obj .. [[
			{
				"total":"]]..v..[["
			}
			]]
		end

	end

	json_obj = "["..json_obj.."]"
	cgilua.contentheader("application" , "xml; charset=iso-8859-1")
	
--episode 10: returns the json object.
	cgilua.put(json_obj)

elseif (statistical_query == "papersByLanguage") then

--episode 11: if the statisticas query is papersByLanguage then RETURN THE AMOUNT OF PAPERS BY LANGUAGE
	local t_papers_by_language = model_statistical.returnPapersByLanguage()
	local table_size = table.getn(t_papers_by_language)
	local json_obj = ""

--episode 12: assembles the json object according to the data returned.
	for i, v in pairs(t_papers_by_language) do

		local total_num_papers = v["contador"]
		json_obj = json_obj .. [[
			{
				"l":"]]..v["lingua"]..[[",
				"total":"]]..v["contador"]..[["
			}
		]]

		if (i < table_size) then
			json_obj = json_obj..","
		end	

	end

	json_obj = "["..json_obj.."]"
	cgilua.contentheader("application" , "xml; charset=iso-8859-1")
	
--episode 13: returns the json object.
	cgilua.put(json_obj)

elseif (statistical_query == "papersByConference") then

--episode 14: if the statisticas query is papersByConference then RETURN THE AMOUNT OF PAPERS BY CONFERENCE
	local t_papers_by_conference = model_statistical.returnPapersByConference()
	local table_size = table.getn(t_papers_by_conference)
	local json_obj = ""

--episode 15: assembles the json object according to the data returned.
	for i, v in pairs(t_papers_by_conference) do

		json_obj = json_obj .. [[
			{
				"conference":"]]..v["conf"]..[[",
				"total":"]]..v["contador"]..[["
			}
		]]

		if (i < table_size) then
			json_obj = json_obj..","
		end	

	end

	json_obj = "["..json_obj.."]"
	cgilua.contentheader("application" , "xml; charset=iso-8859-1")
	
--episode 16: returns the json object.
	cgilua.put(json_obj)


elseif (statistical_query == "conferencesByCountry") then

--episode 17: if the statisticas query is conferencesByCountry then RETURN THE AMOUNT OF CONFERENCES BY COUNTRY.
	local t_conferences_by_country = model_statistical.returnConferencesByCountry()
	local table_size = table.getn(t_conferences_by_country)
	local json_obj = ""

--episode 18: assembles the json object according to the data returned.
	for i, v in pairs(t_conferences_by_country) do

		json_obj = json_obj .. [[
			{
				"country":"]]..v["country"]..[[",
				"total":"]]..v["contador"]..[["
			}
		]]

		if (i < table_size) then
			json_obj = json_obj..","
		end	

	end

	json_obj = "["..json_obj.."]"
	cgilua.contentheader("application" , "xml; charset=iso-8859-1")
	
--episode 19: returns the json object.
	cgilua.put(json_obj)


elseif (statistical_query == "citationsByKeyword") then

--episode 20: if the statisticas query is conferencesByCountry then RETURN THE AMOUNT OF CITATIONS BY KEYWORD.
	local t_citations_by_keyword = model_statistical.returnCitationsByKeyword()
	local table_size = table.getn(t_citations_by_keyword)
	local json_obj = ""

--episode 21: assembles the json object according to the data returned.
	for i, v in pairs(t_citations_by_keyword) do

		local keyword = (v["k"])
		keyword = string.gsub(keyword, "\n", " ")	
		keyword = string.gsub(keyword, "\r", " ")
		keyword = string.gsub(keyword, "\b", " ")    
		keyword = string.gsub(keyword, "\t", " ")
		--keyword = cd:iconv(keyword)
		
		json_obj = json_obj .. [[
			{
				"keyword":"]]..keyword..[[",
				"total":"]]..v["c"]..[["
			}
		]]

		if (i < table_size) then
			json_obj = json_obj..","
		end	

	end

	json_obj = "["..json_obj.."]"
	cgilua.contentheader("application" , "xml; charset=iso-8859-1")
	
--episode 22: returns the json object.
	cgilua.put(json_obj)

else	

--episode : if the query informed was not found, then retuns and error.
	cgilua.contentheader("application" , "xml; charset=iso-8859-1")
	cgilua.put([[

		{
			"Error": "Control Layer - statistical query not found"
		}
	]])
end 
%>
