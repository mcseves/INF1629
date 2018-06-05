dofile"util.lua"
local cfg = dofile"config.lua"

	local counter_file = cfg["counter_folder"].."download_counter.txt"
	local file_result = io.open(counter_file, "r") -- r read mode and b binary mode
	if not file_result then 
		return {}
	else	
		local text_download = file_result:read "*a" -- *a or *all reads the whole file
		file_result:close()
		return downloads_string_to_table (text_download)		
	end	

