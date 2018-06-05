		function trim(text)
		  return (text:gsub("^%s*(.-)%s*$", "%1"))
		end
		
		--split
		function split(texto,delimitador)
			local resultado = nil
			local inicio  = 1
			if texto and texto ~= ""  then
				resultado = {}
		--@Episódio 1: Obtém índice inicial e final da primeira ocorrêncida do delimitador na string (se houver)
				local delim_ini, delim_fim = string.find(texto, delimitador, inicio)

		--@Episódio 2: Enquanto houver ocorrênica do delimitador na string insere a substring delimitada na tabela resutlado.
				while delim_ini do
					table.insert(resultado, trim(string.sub( texto, inicio , delim_ini-1)))
					inicio  = delim_fim + 1

		--@Episódio 3: Procura próxima ocorrência de delimitador na string.
					delim_ini, delim_fim = string.find(texto, delimitador, inicio)
				end
		--@Episódio 4: Insere última substring na tabela resultado.
		  	table.insert( resultado, trim(string.sub(texto, inicio)))
			end
		  return resultado
		end
		
		--table to string (Lua Official)
		function table_val_to_str ( v )
		  if "string" == type( v ) then
		    v = string.gsub( v, "\n", "\\n" )
		    if string.match( string.gsub(v,"[^'\"]",""), '^"+$' ) then
		      return "'" .. v .. "'"
		    end
		    return '"' .. string.gsub(v,'"', '\\"' ) .. '"'
		  else
		    return "table" == type( v ) and table_to_string( v ) or
		      tostring( v )
		  end
		end
		
		function table_key_to_str ( k )
		  if "string" == type( k ) and string.match( k, "^[_%a][_%a%d]*$" ) then
		    return k
		  else
		    return "[" .. table_val_to_str( k ) .. "]"
		  end
		end
		
		function table_to_string( tbl, separator )
		  local result, done = {}, {}
		  local separator = separator or ","
		  for k, v in ipairs( tbl ) do
		    table.insert( result, table_val_to_str( v ) )
		    done[ k ] = true
		  end
		  for k, v in pairs( tbl ) do
		    if not done[ k ] then
		      table.insert( result,
		        table_key_to_str( k ) .. "=" .. table_val_to_str( v ) )
		    end
		  end
		  --return "{" .. table.concat( result, "," ) .. "}"
		  return "{" .. table.concat( result, separator ) .. "}"
		end
		
		--[[
		METODOS ADAPTADOS PARA PROCESSAR NUMEROS DE DOWNLOADS E CITAÇÕES POR ARTIGO
		]]--
		
		--	local text_download = [[
--						WER01/santander.pdf &&  231
	--					WER09/ebling.pdf && 206
		--				WER09/ridao.pdf && 285
			--			WER08/ma.pdf && 199
				--	]]
		
		--String to Table Download (spacific for downloads)
		function downloads_string_to_table (text_download)
			local tab_download = {}
			local counter_download = {}
			
			local tab_download = split(text_download, '\n')
			for i=1,#tab_download do
				local paper_download = nil
				local paper_split = split(tab_download[i], "&&")
				--downloads = {WER00/paper.pdf && 10}
				if paper_split and #paper_split == 2 then
					--print("paper: " .. paper_split[1].. "-> num: "..paper_split[2])
					counter_download[paper_split[1]] = {downloads = paper_split[2]}
				end		
			end
			return 	counter_download
		end		 
		
		--Table to string Download - util
		function downloads_table_to_string (counter_download)
			local table_str = table_to_string(counter_download, "\n")
			--specific format for downloads counter
			table_str = string.gsub(table_str, "%[\"", "")
			table_str = string.gsub(table_str, "\"%]", "")
			table_str = string.gsub(table_str, "\"%}", "")
			table_str = string.gsub(table_str, "=%{downloads%=\"?", " && ")
			
			table_str = string.gsub(table_str, "%{", "")
			table_str = string.gsub(table_str, "%}", "")
			
			return table_str
			
		end
		
		--String to Table Citation (spacific for citations)
		function citations_string_to_table (text_download)
			local tab_citation = {}
			local counter_citation = {}
			
			local tab_citation = split(text_download, '\n')
			for i=1,#tab_citation do
				local paper_citation = nil
				local paper_split = split(tab_citation[i], "&&")
				--citations = {WER00/paper.pdf && 10 && 11-11-2015}
				if paper_split and #paper_split > 2 then
					--print("paper: " .. paper_split[1].. "-> num: "..paper_split[2])
					counter_citation[paper_split[1]] = {citations = paper_split[2], data_citation = paper_split[3]}
				end
			end
			return 	counter_citation
		end		
		
		--Table to string Citation - util
		function citations_table_to_string (counter_citation)
			local table_str = table_to_string(counter_citation, "\n")
			--specific format for downloads counter
			table_str = string.gsub(table_str, "%[\"", "")
			table_str = string.gsub(table_str, "\"%]", "")
			table_str = string.gsub(table_str, "\"%}", "")
			table_str = string.gsub(table_str, "=%{citations%=\"?", " && ")
			table_str = string.gsub(table_str, "=%{data_citation%=\"?", " && ")
			
			table_str = string.gsub(table_str, "\"?%,data_citation%=\"?", " && ")
			table_str = string.gsub(table_str, "\"%,citations%=\"?", " && ")
			
			table_str = string.gsub(table_str, "%{", "")
			table_str = string.gsub(table_str, "%}", "")
			
			return table_str
			
		end 
		
		--count and update downloads
		function update_downloads_paper(text_download, paper)
			local counter_download = downloads_string_to_table (text_download)
			--look for specifi paper
			if counter_download[paper] then
				if counter_download[paper]['downloads'] then
					counter_download[paper]['downloads'] = counter_download[paper]['downloads'] + 1
				else
				 	counter_download[paper] = {downloads = 1}
				end	
			else
				counter_download[paper] = {downloads = 1}
			end
			--transform table to string
			text_download = downloads_table_to_string (counter_download)
			return counter_download[paper]['downloads'], text_download
		end	
		
		
				
		
		--local text_citation = [[
			--			WER01/santander.pdf &&  231 && 11-11-2015
				--		WER09/ebling.pdf && 206 && 11-11-2015
					--	WER09/ridao.pdf && 285 && 11-11-2015
						--WER08/ma.pdf && 199 && 11-11-2015
					--]]
		
		function update_citations_paper(text_citation, paper, citations)			
			local counter_citation = citations_string_to_table (text_citation)
			--look for specifi paper
			local data_citation = os.date("%Y-%m-%d")
			if counter_citation[paper] then
				if counter_citation[paper]['citations'] then
					counter_citation[paper]['citations'] = citations
					counter_citation[paper]['data_citation'] = data_citation
				end	
			else
				counter_citation[paper] = {citations = citations, data_citation = data_citation}
			end
			--transform table to string
			text_citation = citations_table_to_string (counter_citation)
			
			return counter_citation[paper]['citations'], text_citation
		end	
		
		--print(update_downloads_paper(text_download, "WER01/santander.pdf"))
		
		--print(update_citations_paper(text_citation, "WER01/santander.pdf", 1))