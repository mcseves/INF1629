<%
--[[
@title: Show edition papers page
@goal: Allow user interaction with the editions papers page.
@context:
	Localization: view layer.
	Precondition: SHOW EVENT PAPERS PAGE.
@actors: user, system.
@resources: module controler and config.lua file
]]--
	
	dofile("../config/config.lua")	
	package.path = package.path..returnDLPath()
	
	local selected_edition = cgilua.QUERY.id_edition
	
--@episode: 	
	local module_controller = require("controller.controller_digitallibrary")

--@episode: Requests edition data to DIGITAL LIBRARY CONTROLLER
	local edition_data = module_controller.digitalLibraryController("return_edition_data", selected_edition)	

--@episode: Requests event data to DIGITAL LIBRARY CONTROLLER	 
	local event_data = module_controller.digitalLibraryController("return_event_data", 2)
	
--@episode: Requests proceedings editors to DIGITAL LIBRARY CONTROLLER
	local proceedings_editors = module_controller.digitalLibraryController("return_edition_proceedings_editors", selected_edition)	
	
--@episode:	
	local proceedings_editors_txt = ""
	for i, v in pairs (proceedings_editors) do
		if (i == 1) then 
			proceedings_editors_txt = v["name"]
		else
			proceedings_editors_txt = proceedings_editors_txt..", "..v["name"]
		end
	end
	
--@episode: Requests edition sessions to DIGITAL LIBRARY CONTROLLER
	local edition_sessions = module_controller.digitalLibraryController("return_edition_sessions", selected_edition)
%>

<html>
<head>

<!--
@episode: Print page HTML title.	
-->
<title>
	<%=edition_data["acronym"] or "" %> <%=edition_data["year"] or "" %>: <%=edition_data["city"] or "" %>, <%=edition_data["country"] or "" %>
</title>
</head>
 
<body>

<!--
@episode: Print paper´s page title.
-->
  <h1>
	<a href=<%=edition_data["url"] or "" %>><%=edition_data["acronym"] or "" %></a> - <%=event_data["name"] or "" %> <%=edition_data["year"] or "" %>: <%=edition_data["city"] or "" %>, <%=edition_data["country"] or "" %>
  </h1>
  <hr>

<!--
@episode: Print proceedings editors and proceedings title
-->  
	<%=proceedings_editors_txt%> : <%=edition_data["proceedings_title"] or "" %>	<p align=right><a href='' align=right>voltar</a><p>

<!--
@episode: Print edition proceedings 
--> 
<pre>
@proceedings{<a href='<%=edition_data["url"] or "" %>'><%=event_data["acronym"] or "" %></a>: <%=edition_data["acronym"] or "" %>,
   editor = {<%=proceedings_editors_txt or "" %>},
   title = {<%=edition_data["proceedings_title"] or "" %>},
   publisher = {<%=edition_data["publisher"] or "" %>},
   ISBN = {<%=edition_data["isbn"] or "" %>},
   year = {<%=edition_data["year"] or "" %>}
}
</pre>

<%
	local num_paper = 1

	for i, session in pairs(edition_sessions) do

--@episode: For each session print the order attribute followed by its name.			
%>	
		<H2><%=session["order_attribute"] or "" %> - <%=session["name"] or "" %> </H2>
<%		

--@episode: Requests session papers to DIGITAL LIBRARY CONTROLLER
		local session_papers = module_controller.digitalLibraryController("return_session_papers", session["session_id"])
		for j, paper in pairs(session_papers) do
		
--@episode: For each paper print its title.
%>
			<p style='margin-left: 10'>   
			<font face='Arial'><%=num_paper or "" %> - <b><%=paper["title"] or "" %></b>. 
<%		
			
--@episode: Requests paper DIGITAL LIBRARY CONTROLLER
			local paper_authors = module_controller.digitalLibraryController("return_paper_authors", paper["paper_id"])
			
			local authors_text = ""

--@episode: Creates a string with the authors names.			
			for k, author in pairs(paper_authors) do 
				if (k == 1) then 
					authors_text = author["name"]
				else
					authors_text = authors_text..", "..author["name"]
				end	
			end --for authors
			
--@episode: Requests paper's scholar url to DIGITAL LIBRARY CONTROLLER
			local paper_scholar_url = module_controller.digitalLibraryController("return_paper_scholar_url", paper["paper_id"])			
			
--@episode: Prints the paper´s authors, the proceedings title and the paper´s abstract.			
%>
			<i><%=authors_text or "" %>.</i> <%=edition_data["proceedings_title"] or "" %>
				<b>
					<a href='' target='_blank'>[pdf]</a>
					<a href='<%=paper_scholar_url or "" %>' target='_blank'>[scholar]</a> Downloads: 0
				</b>
			</font>
			<p align='justify' style='margin-left: 30'><font face='Arial' size='2'><b>Abstract: </b><%=paper["abstract"] or "" %></font></p>
<%			
			num_paper = num_paper + 1
		end --for papers
	
	end	--for sessions
%>
  &nbsp;&nbsp;<a href="">voltar</a>
</body>
</html>
