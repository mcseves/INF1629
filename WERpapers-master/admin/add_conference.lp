<%
conf_table = {
  name = cgilua.POST.name,
  url = cgilua.POST.url,
  editor = cgilua.POST.editor,
  isbn = cgilua.POST.isbn,
  month = cgilua.POST.month,
  days = cgilua.POST.days,
  year = cgilua.POST.year,
  country = cgilua.POST.country,
  city = cgilua.POST.city,
}

validation = {name = true, url = true, editor = true, isbn = true}

for k,v in pairs(conf_table) do
  if validation[k] and v == "" then
    cgilua.print("Você não preencheu o campo obrigatório <b>"..k.."</b>.<br>")
    --cgilua.urlpath = cgilua.urlpath:match("(.*/).*")
    local url = cgilua.mkurlpath("form_add_conference.lp", conf_table)
    url = url:match("/+.*/(.*)")
    cgilua.print("<a href='"..url.."'>voltar</a>")
    return
  end
end

package.path = "../?.lua;"..package.path
require("dao")

local ok = assert(dao.insert_conference(conf_table))
cgilua.put('query = "'..ok..'"<br>')
cgilua.print("Conferência inserida com sucesso.<br>")
%>
<a href="form_add_paper.lp">Inserir novo artigo</a>
