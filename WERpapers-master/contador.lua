-- load config table containing contator info
local cfg = require("cont-acc")

-- load mysql enviroment
local env = require"luasql.mysql".mysql()

-- enable assert use
local assert = assert

module("contador")

-- Connects to a data source specified and return a 
-- connection object containing specific attributes
-- and parameters of a single data source connection.
-- @return connection object.
function db_connect()
  local con = assert(env:connect(
     cfg.db_name, cfg.db_login,
     cfg.db_passwd, cfg.db_host, cfg.db_port));
  return con;
end
