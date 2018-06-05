<html>
<head>
<title>Lista Completa de Papers</title>
</head>
<body>
<%
package.path = "../?.lua;"..package.path
require("dao")

local gpapers = dao.get_all_papers();

for p in gpapers do
  cgilua.put(string.format('"%s";"%s";"%s"\n<br>\n',
                           p.id, p.paper_title, p.author))
end
%>
</body>

</html>
