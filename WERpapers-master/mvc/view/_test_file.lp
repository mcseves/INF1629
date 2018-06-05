<%
	dofile("../config/config.lua")	
	package.path = package.path..returnDLPath()		
	local module_controller = require("controller.controller_digitallibrary")
	
	print("Starting test <br/> <br/>")
	
	print(module_controller.returnName(2))
		
	print("<br/> <br/> Ending test")
	
%>
