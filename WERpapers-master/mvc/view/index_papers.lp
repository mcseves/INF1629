<%
--[[
@title: Show event papers page
@goal: Allow user interaction with the papers page.
@context:
	Localization: view layer.
	Precondition: SHOW EVENT PAGE or The user accesses the url of the papers page.
@actors: user, system.
@resources: module controler and config.lua file
]]--
	
	dofile("../config/config.lua")	
	package.path = package.path..returnDLPath()
	
--@episode: 	
	local module_controller = require("controller.controller_digitallibrary")
	
--@episode: Requests paper page paths to DIGITAL LIBRARY CONTROLLER
	local paper_page_paths = module_controller.digitalLibraryController("return_paperpage_paths")
	
--@episode: Requests paper page data to DIGITAL LIBRARY CONTROLLER
	local selected_paperspage = module_controller.digitalLibraryController("return_paperpage_data", 2)
	
--@episode: Requests editions with papers data to DIGITAL LIBRARY CONTROLLER
	local editions_with_papers = module_controller.digitalLibraryController("return_editions_with_papers", 2)
%>
<html>
<head>
   <title><%= selected_paperspage["title"]%></title>
</head>
<% 
   --cgilua.print('<body bgproperties="fixed" background="'
   --  ..cfg.image_folder..'/eng_req.jpg">')
%>
<br>
   <table border="0" cellpadding="0" cellspacing="0" style="border-collapse:
     collapse" bordercolor="#111111" width="100%" id="AutoNumber1">
      <tr>
      <td>
         <p align="center">
			<img border="0" src="<%= paper_page_paths["papers_page_logo"]%>" width="220" height="160">
		</p>
         
         <p align="center">
				<font face="Times New Roman" size="5" color="#0000FF">
				
<!--@episode: Print paperspage title -->
					<%= selected_paperspage["title"]%>
					<!-- End title -->	
				</font>
			  
			  </br>
				<font face="Times New Roman" size="4" color="gray">
				
<!--@episode: Print paperspage subtitle -->
					<%= selected_paperspage["subtitle"]%>		
					<!-- End subtitle -->				
				</font>
            </br>
         </p>
      <br>
      </td>
      </tr>
      <tr>
      <td>
         <p align="justify" style="margin-left: 10%; margin-right: 10%">
            <font face="Arial" size="2">
			
<!--@episode: Print paperspage description -->
				<%= selected_paperspage["description"]%>		
				<!-- End description -->	
            </font>
      
            <font face="Arial" color="gray"> 
            </font>
         </p>
         <p style="margin-left: 10%; margin-right: 10%" align="center"><b>
		 
<!--@episode: Print links to editions papers page. Only the edition that has papers appears. -->		 
            <font face="Verdana" size="2">
				<%
					for i, edition in pairs(editions_with_papers) do
				%>
					<a href="edition_papers.lp?id_edition=<%= edition["edition_id"]%>"><%= edition["acronym"]%></a>&nbsp;&nbsp;
				<%
					end
				%> 
			  
				<br />
				<br />
				<a>
                   Mais citados | Más Citados | Most Cited </a> 
				
            </font></b>
         </p>
      </td>
      </tr>

   </table>
    <table align="center" width="50%">
	
	</table>
</body>

<footer>
  
  <table width="80%" align="center"  border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td width="10%" align="left">
            <a target="_blank" href="index.lp">
	           <img border="0" src="<%= paper_page_paths["main_logo"]%>" width="170" height="90">
			</a>
     </td>
		      
<!--@episode: Display DBLP search box -->
      <td width="75%" align="center">
		  <a target="_blank" href="http://www.informatik.uni-trier.de/%7Eley/db/conf/cibse/index.html">
			<div align="center">
				<img src="<%= paper_page_paths["dblp_logo"]%>" width="109" border="0" height="40">    
			</div>
		  </a>
	  </td>
      <!-- End DBLP -->
	   		
<!--@episode: Insert statCounter code --> 	
	  <td align="right">	 
	  <!--
        <script type="text/javascript" language="javascript">
			  var sc_project=7250469; 
			  var sc_invisible=0; 
			  var sc_partition=23; 
			  var sc_security="1bc00ad7"; 
			  var sc_text=3; 
			</script>
			
			<script type="text/javascript" language="javascript" src="http://www.statcounter.com/counter/counter.js"></script><br>
			<a href="http://my.statcounter.com/project/standard/stats.php?project_id=7250469&amp;guest=1">StatCounter</a>
		-->		
		<!-- End of StatCounter Code -->	
		</td>	  
    </tr>
  </table>
</footer>
</html>
