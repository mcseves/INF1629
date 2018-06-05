
--returnt the path to modules in both operational systems
function returnDLPath()

--windows
	--return ";C:\\LuaRocks\\kepler\\htdocs\\dl_lua\\?.lua"

--linux	
	--return ";/home/b/wer/public_html/eduardo/?.lua" codigo eduardo
	return ";/home/b/wer/public_html/WERpapers/mvc/?.lua"
end

-- return the path to images in main page
function returnMainPagePaths()

	local main_page_paths = {
		["main_logo"] = "images/eventLogo.png",
		["papers_page_logo"] = "images/logo_cibse_papers.png",
		["dblp_logo"] = "images/dblp.gif"		
	}	

	return main_page_paths
end

-- return the path to images in papers page
function returnPaperPagePaths()

	local paper_page_paths = {
		["main_logo"] = "images/eventLogo.jpg",
		["papers_page_logo"] = "images/logo_cibse_papers_main.png",
		["dblp_logo"] = "images/dblp.gif"		
	}	

	return paper_page_paths
end