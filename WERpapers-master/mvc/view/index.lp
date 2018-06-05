<%
--[[
@title: Show event page
@goal: Allow user interaction with the system's main page
@context:
	Localization: view layer.
	Precondition: User accesses the url of the system.
@actors: user, system.
@resources: module controler and config.lua file
]]--
	
--@episode: 
	dofile("../config/config.lua")	
	package.path = package.path..returnDLPath()		
	
--@episode: Initialize controller module.
	local module_controller = require("controller.controller_digitallibrary")
	
--@episode: Requests event data to DIGITAL LIBRARY CONTROLLER
	local selected_event = module_controller.digitalLibraryController("return_event_data", 2)
	
--@episode: Requests main page paths to DIGITAL LIBRARY CONTROLLER
	local main_page_paths = module_controller.digitalLibraryController("return_mainpage_paths")
	
--@episode: Requests event editions to DIGITAL LIBRARY CONTROLLER
	local event_editions = module_controller.digitalLibraryController("return_event_editions", 2)
	
%>
<html>

<!-- @episode: Print event name -->
<head>
	<title>
		<%
			cgilua.print(string.format("%s - %s", selected_event["acronym"], selected_event["name"]))
		%>
	</title>
</head>

<body>
<div align="center">
  <table width="70%" bgcolor="white">
    <tr>
    <td>
	  <br>
      <p align="center">
	  
<!-- @episode: Print main logo path --> 
   <img border="0" src="<%= main_page_paths["main_logo"]%>" width="449" height="344">
      </p>

      <p align="center">
        <font face="Times New Roman" size="5" color="#0000FF">
		
<!-- @episode: Print event name --> 
			<%
				cgilua.print(string.format("%s - %s", selected_event["acronym"], selected_event["name"]))
			%>	

        </font>
        <br>
        <font face="Times New Roman" size="4" color="gray">

<!-- @episode: Print event subtitle --> 
			<%= selected_event["subtitle"]%>				
		  
        </font>

      </p>
    <br>
    </td>
    </tr>
    <tr>
    <td>
      <p align="justify" style="margin-left: 10%; margin-right: 10%">
        <font face="Arial">

<!-- @episode: Print event description --> 		
			<%= selected_event["description"]%>		
	
        </font>
		
        </br></br>
		
        <font face="Arial" color="gray">

         
        </font>
      </p>
      <p style="margin-left: 10%; margin-right: 10%" align="center"><b>
 
 <!-- @episode: Print event editions --> 
		<font face="Verdana" size="2">
		<%
			for i, edition in pairs(event_editions) do
		%>
				<a href="<%= edition["url"]%>"><%= edition["acronym"]%></a>&nbsp;&nbsp;
		<%
			end
		%> 
		   
        </font></b>
      </p>
    </td>
	  </tr>
   </table>
   </br>	

<!-- @episode: Display google search service --> 
	<table width="70%">
		<tr>
			<td  align="center" >
		
				<div id="cse-search-form"  align="center" style="width: 40%;">Loading</div>
				<script src="http://www.google.com/jsapi" type="text/javascript"></script>
				<script type="text/javascript"> 
				  google.load('search', '1', {language : 'en'});
				  google.setOnLoadCallback(function() {
					var customSearchControl = new google.search.CustomSearchControl('009472974280876244117:yevluvmfgti');
					customSearchControl.setResultSetSize(google.search.Search.FILTERED_CSE_RESULTSET);
					var options = new google.search.DrawOptions();
					options.enableSearchboxOnly("http://www.google.com/cse?cx=009472974280876244117:yevluvmfgti");    
					customSearchControl.draw('cse-search-form', options);
				  }, true);
				</script>
				<link rel="stylesheet" href="http://www.google.com/cse/style/look/default.css" type="text/css" />
				
			</td>
		</tr>	
	</table>
	<!-- End Google Search -->

	<table>
</div>
</body>

<footer>
  <hr width="60%" align=center>
<table width="70%" align=center>
  <tr>
    <td width="34%">
      <div align="center"><a target="_blank" href="index_papers.lp">
        <img border="0" src="<%= main_page_paths["papers_page_logo"]%>" width="173"
          height="133"></a> </div></td>
    
    <td width="35%">
	
<!-- @episode: Display DBLP search box --> 

      <a target="_blank" href="http://www.informatik.uni-trier.de/%7Eley/db/conf/cibse/index.html">
      <div align="center"><img src="<%= main_page_paths["dblp_logo"]%>" width="109" border="0" height="40">    </div></td>
    
	<!-- End DBLP search box -->
    
      
    <td>
	
<!-- @episode: Insert statCounter code --> 	
	<!-- Start statCounter -->
    
	<!--
      <p align="right">
        <script type="text/javascript" language="javascript">
          var sc_project=7250469; 
          var sc_invisible=0; 
          var sc_partition=23; 
          var sc_security="1bc00ad7"; 
          var sc_text=3; 
        </script>
        <script type="text/javascript" language="javascript" src="http://www.statcounter.com/counter/counter.js"></script>
		<br>
        <a href="http://my.statcounter.com/project/standard/stats.php?project_id=7250469&amp;guest=1">StatCounter</a>
      </p>
	-->
	
	<!-- End statCounter code -->	
	</td>
	
  </tr>

</table>

</footer>
</html>

