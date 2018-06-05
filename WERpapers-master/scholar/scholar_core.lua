-- load config file
local cfg = require"config"

local dao = require"dao"
--local dao = require"file_dao" -- no sql database avaiable

local utils = require"scholar_utils"
local socket = require"socket"

local assert, dofile, io, ipairs, math, pairs, print,
      table, string, tonumber, tostring =
      assert, dofile, io, ipairs, math, pairs, print,
      table, string, tonumber, tostring

module(...)

-- Generates a file containing each papers' citations count based on google 
-- scholar.
local function generate_cited()
  local result = {}

  print("Starting citation retrieval")
  
  -- get all papers
  local gpapers = dao.get_all_papers();

  local counter = 0
  while true do
    local batch_size = math.random(2,5)

    print("Starting " .. batch_size .. " requests")
    for i=1,batch_size do
      local p = gpapers()
      if p == nil then
        fim = true
        break
      end
      local citations, search_url = utils.getCitations(cfg.scholar_base_url,
                           cfg.scholar_base_referrer, p.paper_title, p.author)
      if citations then
        table.insert(result, {id = p.id, citations = citations, search_url = search_url})
        counter = counter + 1
--        if counter%10 == 0 then print(counter.." requisicoes feitas."); end
        if counter%2 == 0 then return end
      else
        local err = search_url
        print("erro " .. tostring(err))
        if err == 503 then  -- unavailable service (usually blocked)
          fim = true
          break
        end
      end
      inner_time = math.random(1000, 4000)
      socket.sleep(inner_time/1000)
    end
    if fim then
      break
    end
    local time = math.random(30, 600)
    print("Sleeping for ".. time .. "seconds.")
    socket.sleep(time)
  end

  print("\nRequests finished\nSorting...\n")
  -- sort table, most cited on top
  table.sort(result, function (a, b) return a.citations > b.citations end)
   
  -- write the citation_table in a file (persist it).
  -- use IF to protect empty writing
  if #result > 0 then
    print("Persisting result.\n")
    utils.persist_table("scholar/most_cited.lua", result)
    utils.persist_table_zero("scholar/zero.lua", result)
  end
end

local function verify_output()
  t = dofile("scholar/most_cited.lua")
  if not t then
    print("ERRO: Arquivo não foi gerado.")
  elseif #t < 20 then
    print("AVISO: Arquivo tem menos de 20 itens.")
  else
    print("OK: Arquivo gerado com sucesso.")
  end
end

return {
  generate_cited = generate_cited,
  verify_output = verify_output,
}

