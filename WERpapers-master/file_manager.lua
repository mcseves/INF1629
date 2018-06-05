dofile"util.lua"
local cfg = dofile"config.lua"


--debug local _G = _G

--module("manager")

--16-11-2015
function update_file_counter(file_name)
  -- loads counter table
	local counter_file_txt = cfg["counter_folder"].."download_counter.txt"
	local file_result = io.open(counter_file_txt, "r") -- r read mode and b binary mode
	if not file_result then 
		return {}
	else	
		local text_download = file_result:read "*a" -- *a or *all reads the whole file
		file_result:close()
		 -- add 1 to paper counter
		--update oe add new
		local num_download, text_download = update_downloads_paper(text_download, file_name)
		
		-- persist table
		--16-11-2015
        file_result = io.open(counter_file_txt, "w")
		file_result:write("")
		file_result:write(text_download)
		file_result:close()
	end	
end