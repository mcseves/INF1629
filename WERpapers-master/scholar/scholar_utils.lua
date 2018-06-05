local http = require("socket.http")
local ltn12 = require("ltn12")
local scleaner = require"scholar_string_cleaner"
local count_citations = require"scholar_count_citations"

-- enable dofile, io and pairs use
local assert, dofile, io, ipairs, math, pairs, print, table, string, tonumber =
      assert, dofile, io, ipairs, math, pairs, print,  table, string, tonumber

local _G = _G

module(...)

-- 
-- @param url: url for request
-- @param referrer: refferer for request
-- @return requested page or nil see luasocket http.request
local function request (url, referer)
	local result = {}
	local ok, status, headers = http.request({
		url = url,
		headers = {
			["User-Agent"] =      "Mozilla/5.0 (Windows; U; Windows NT 5.1; pt-BR; rv:1.9.0.6) Gecko/2009011913 Firefox/3.0.6 (.NET CLR 3.5.30729)",
			["Accept"] =          "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
			["Accept-Language"] = "pt-br,pt;q=0.9,en-us,en;q=0.5",
			["Accept-Encoding"] = "identity",
			["Accept-Charset"] =  "ISO-8859-1;q=0.9", -- ,*;q=0.7
			["Connection"] =      "keep-alive",
			["Keep-Alive"] =      "300",
			["Referer"] = referer,
		},
		sink = ltn12.sink.table(result),
	})
	return (status == 200 and table.concat(result) or nil), status, headers
end

-- Counts the number of citations that a paper has(based on scholar)
-- @params title: paper title for counting citations
-- @return results: number of citations and search url
function getCitations(url, referrer, title, author)

  -- gera a URL relativa a busca na pagina do google do título.
  local url = scleaner.montaUrl(url, title, author)
_G.print(url)
if true then return 0,url end
  -- Requisição obtem codigo fonte da url e o status da requisiçao.
  local pagina, status, headers = request(url, referrer)

_G.print(pagina)
  -- Caso a url seja invalida, nao sera retornado o codigo fonte da pagina. 
  if not pagina or status ~= 200 then
    return nil, status
  end
  
  local citations = count_citations(pagina, title)
  print(title, citations)
  return citations, url
end

-- Persist a table in the counter_file.
-- Do not use optimized table creation.
-- Table format {i = {id = p.id, citations = citations}}
-- @params file_name: file path for persisting data
-- @params tab: table to persist
function persist_table (file_name, tab)
  h = assert(io.open(file_name,"w"))
  h:write("return {\n")
  for i,v in ipairs(tab) do
    if v.citations == 0 then break end -- register only citations > 0
    h:write("  { id = "..v.id..", citations = "..v.citations
            ..", search_url ='"..v.search_url.."'},\n")
  end
  h:write("}\n")
  h:close()
end

function persist_table_zero (file_name, tab)
  h = io.open(file_name,"w")
  h:write("return {\n")
  for i,v in ipairs(tab) do
    if v.citations == 0 then -- register only citations == 0
      h:write("  { id = "..v.id..", url ='"..v.search_url.."'},\n")
    end
  end
  h:write("}\n")
  h:close()
end
