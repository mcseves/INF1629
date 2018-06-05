module(..., package.seeall)

local db_query = require("dba.db_query")	


--[[ ===================================================================================================================
@title: Return keywords used by authors
@goal: Return to the control layer the number of times each keyword was used by an author.
@context: 
	- location: model layer.
	- precondition: CONTROL REQUEST STATISTICAL QUERY.
@actors: system.
@resources: sql code of the query
]]--
function returnKeywordsUsedByAuthors() 

--episode: Assembles query to count the number of times each keyword was used by the authors.
	local q_keywords_authors = [[SELECT `author`, k, count(contador) AS contador FROM (
								(SELECT `author`, 
								       SUBSTRING_INDEX(`key_words` ,',', 1) as k , 
								       count(SUBSTRING_INDEX(`key_words` ,',', 1)) as contador
								FROM `papers` as a where `key_words` is not null and `key_words` <> ''
								group by `author`, SUBSTRING_INDEX(`key_words` ,',', 1))
								UNION ALL
								(SELECT `author`, 
								       SUBSTRING_INDEX(SUBSTRING_INDEX(`key_words` ,',', 2) ,',',-1) as k , 
								    count(SUBSTRING_INDEX(SUBSTRING_INDEX(`key_words` ,',', 2) ,',',-1)) as contador
								    FROM `papers` as b where `key_words` is not null and `key_words` <> ''
								    group by `author`, SUBSTRING_INDEX(SUBSTRING_INDEX(`key_words` ,',', 2) ,',',-1))
								UNION ALL
								(SELECT `author`, 
								       SUBSTRING_INDEX( SUBSTRING_INDEX(`key_words` ,',',-2) ,',', 1) as k , 
								    count(SUBSTRING_INDEX( SUBSTRING_INDEX(`key_words` ,',',-2) ,',', 1)) as contador
								    FROM `papers` as c where `key_words` is not null and `key_words` <> ''
								    group by `author`, SUBSTRING_INDEX( SUBSTRING_INDEX(`key_words` ,',',-2) ,',', 1))
								UNION ALL
								(SELECT `author`, 
								       SUBSTRING_INDEX(`key_words` ,',',-1) as k, 
								    count(SUBSTRING_INDEX(`key_words` ,',',-1)) as contador 
								    FROM `papers` as d where `key_words` is not null and `key_words` <> ''
								    group by `author`, SUBSTRING_INDEX(`key_words` ,',',-1))
								) as u
								group by `author`, k]]

--episode: 	EXECUTES SELECT QUERY IN THE DATABASE.
	local q_result, keywords_authors = db_query.executeSelectQuery(q_keywords_authors)
	
--episode: Return the number of times each keyword was used by the authors.
	return keywords_authors
	
end



--[[ ===================================================================================================================
@title: Return total number of papers
@goal: Return to the control layer the total number of papers of the event
@context: 
	- location: model layer.
	- precondition: CONTROL REQUEST STATISTICAL QUERY.
@actors: system.
@resources: sql code of the query
]]--
function returnTotalNumberOfPapers()

--episode: Assembles query to count the total number of papers of an event.	
	local q_total_number = "SELECT count(`name_conference`) as contador FROM papers"

--episode: 	EXECUTES SELECT QUERY IN THE DATABASE.
	local q_result, total_papers = db_query.executeSelectQuery(q_total_number)
	
--episode: Return the total number of papers.
	return total_papers	

end


--[[ ===================================================================================================================
@title: Return the amount of papers by language
@goal: Return to the control layer the amount of papers in each language.
@context: 
	- location: model layer.
	- precondition: CONTROL REQUEST STATISTICAL QUERY.
@actors: system.
@resources: sql code of the query
]]--
function returnPapersByLanguage()

--episode: Assembles query to count the amount of papers in each language.
	local q_papers_by_language = "SELECT language AS lingua, count('name_conference') "
									.."AS contador "
									.."FROM papers "
									.."GROUP BY lingua "
									.."ORDER BY contador DESC"

--episode: 	EXECUTES SELECT QUERY IN THE DATABASE.
	local q_result, papers_by_language = db_query.executeSelectQuery(q_papers_by_language)
	
--episode: Return the amount of papers by language.
	return papers_by_language

end


--[[ ===================================================================================================================
@title: Return the amount of papers by conference
@goal: Return to the control layer the amount of papers of each conference.
@context: 
	- location: model layer.
	- precondition: CONTROL REQUEST STATISTICAL QUERY.
@actors: system.
@resources: sql code of the query
]]--
function returnPapersByConference()

--episode: Assembles query to count the amount of papers in each language.
	local q_papers_by_conference = "SELECT `name_conference` as conf, count(`name_conference`) as contador "
									.."FROM papers "
									.."group by conf "
									.."ORDER BY contador desc"



--episode: 	EXECUTES SELECT QUERY IN THE DATABASE.
	local q_result, papers_by_conference = db_query.executeSelectQuery(q_papers_by_conference)
	
--episode: Return the amount of papers by conference.
	return papers_by_conference

end


--[[ ===================================================================================================================
@title: Return the amount of conferences by country
@goal: Return to the control layer the amount of conferences that was held in each country.
@context: 
	- location: model layer.
	- precondition: CONTROL REQUEST STATISTICAL QUERY.
@actors: system.
@resources: sql code of the query
]]--
function returnConferencesByCountry()

--episode: Assembles query to count the amount of papers in each language.
	local q_conferences_by_country = "SELECT `country`, count(`name_conference`) AS contador "
										.."FROM conferences "
										.."GROUP BY `country` "
										.."ORDER BY contador DESC"

--episode: 	EXECUTES SELECT QUERY IN THE DATABASE.
	local q_result, conferences_by_country = db_query.executeSelectQuery(q_conferences_by_country)
	
--episode: Return the amount of papers by conference.
	return conferences_by_country

end


--[[ ===================================================================================================================
@title: Return the amount of citations by keyword
@goal: Return to the control layer the amount of citations that each keyword has.
@context: 
	- location: model layer.
	- precondition: CONTROL REQUEST STATISTICAL QUERY.
@actors: system.
@resources: sql code of the query
]]--
function returnCitationsByKeyword()

--episode: Assembles query to count the amount of papers in each language.
	local q_citations_by_keyword = [[SELECT k, count(contador) as c FROM (
									(SELECT  
									       SUBSTRING_INDEX(`key_words` ,',', 1) as k , 
									       count(SUBSTRING_INDEX(`key_words` ,',', 1)) as contador
									FROM `papers` as a where `key_words` is not null and `key_words` <> ''
									group by `author`, SUBSTRING_INDEX(`key_words` ,',', 1))
									 UNION ALL
									(SELECT 
									       SUBSTRING_INDEX(SUBSTRING_INDEX(`key_words` ,',', 2) ,',',-1) as k , 
									    count(SUBSTRING_INDEX(SUBSTRING_INDEX(`key_words` ,',', 2) ,',',-1)) as contador
									     FROM `papers` as b where `key_words` is not null and `key_words` <> ''
									    group by `author`, SUBSTRING_INDEX(SUBSTRING_INDEX(`key_words` ,',', 2) ,',',-1))
									UNION ALL
									(SELECT 
									       SUBSTRING_INDEX( SUBSTRING_INDEX(`key_words` ,',',-2) ,',', 1) as k , 
									    count(SUBSTRING_INDEX( SUBSTRING_INDEX(`key_words` ,',',-2) ,',', 1)) as contador
									    FROM `papers` as c where `key_words` is not null and `key_words` <> ''
									     group by `author`, SUBSTRING_INDEX( SUBSTRING_INDEX(`key_words` ,',',-2) ,',', 1))
									UNION ALL
									(SELECT 
									       SUBSTRING_INDEX(`key_words` ,',',-1) as k, 
									    count(SUBSTRING_INDEX(`key_words` ,',',-1)) as contador 
									    FROM `papers` as d where `key_words` is not null and `key_words` <> ''
									    group by `author`, SUBSTRING_INDEX(`key_words` ,',',-1))
									) as u
									group by k 
									order by c desc limit 20]]

--episode: 	EXECUTES SELECT QUERY IN THE DATABASE.
	local q_result, citations_by_keyword = db_query.executeSelectQuery(q_citations_by_keyword)
	
--episode: Return the amount of papers by conference.
	return citations_by_keyword

end