-- load connection file
require("contador")

-- enable contador and assert use
local assert, contador, string = assert, contador, string
local error, type, tostring = error, type, tostring

--debug
local _G = _G

module("dao")

-- Executes a query in the database specified by
-- the contador.lua file.
-- @param sql statement to be executed
-- @return iterator function containing tuples
local function query(stmt)
  local con = contador.db_connect()
  local res, err = con:execute(stmt)
  con:close()

  assert(res, "\n\nQuery:\n"..stmt.."\n\nErro:\n"..(err or "").."\n")

  -- insert query
  if type(res) == "number" then
    return res
  end

  -- return iterator function
  return function()
     -- "a" uses the database index in the lua table
     return res:fetch({},"a")
  end
end

-- Query function for retrieving all conferences ordered
-- by id.
-- @return iterator function containing tuples or nil
function get_conferences()
  local stmt = "select * from conferences order by id;"
  return query(stmt)
end

-- Query function for retrieving one specific conference.
-- @param conference: conference name
-- @return table containing conference information
function get_conference(conference)
  local stmt = "select * from conferences where name_conference ='"
    ..conference.."';"
  return query(stmt)()
end

-- Query function for retrieving all papers from a
-- specific conference.
-- @param conference: conference name
-- @return iterator function containing tuples or nil
function list_papers_by_conference(conference)
  local stmt = "select * from papers where name_conference = '"..conference
    .."' order by paper_session;"
  return query(stmt)
end

-- Query function for retrieving one paper by id.
-- @param paper_id: paper id
-- @return iterator function containing tuples or nil
function get_paper_by_id(paper_id)
  local stmt = "select * from papers where id="..paper_id..";"
  return query(stmt)
end

-- Query function for retrieving all papers.
-- @return iterator function containing tuples or nil
function get_all_papers()
  local stmt = "select id, paper_title, author from papers;"
  return query(stmt)
end

function insert_conference(c)
  local stmt = string.format("insert into conferences (name_conference, url,"
  .."editor, ISBN, month, days, year, country, city) VALUES ('%s','%s','%s',"
  .."'%s','%s','%s','%s','%s','%s')", c.name, c.url, c.editor, c.isbn,
  c.month, c.days, c.year, c.country, c.city)

--  return stmt
  return query(stmt)
end

function insert_paper(p)
  local stmt = string.format("insert into papers (paper_title, file_name,"
  .."key_words, language,author, add_author, abstract, paper_session, page,"
  .."name_conference) VALUES ('%s','%s','%s','%s','%s','%s','%s','%s','%s','%s')",
  p.paper_title, p.file_name, p.key_words, p.language, p.author, p.add_author,
  p.abstract, p.paper_session, p.page, p.conference)

--  return stmt
  return query(stmt)
end
--]]

function add_download(file_name)
	local stmt = string.format("UPDATE papers SET num_downloads = num_downloads + 1 WHERE file_name = '%s'", file_name)
	return query(stmt)
end
