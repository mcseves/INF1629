<%
paper_table = {
  paper_title = cgilua.POST.paper_title,
  author = cgilua.POST.author,
  add_author = cgilua.POST.add_author,
  conference = cgilua.POST.name_conference,
  file_name = cgilua.POST.file_name,
  key_words = cgilua.POST.key_words,
  language = cgilua.POST.language,
  paper_session = cgilua.POST.paper_session,
  page = cgilua.POST.page,
  abstract = cgilua.POST.abstract,
}

validation = {paper_title = true, paper_session = true, file_name = true,
              add_author = true, page = true, conference = true, author = true}

for k,v in pairs(paper_table) do
  if validation[k] and v == "" then
    cgilua.print("Você não preencheu o campo obrigatório <b>"..k.."</b>.<br>")
    local url = cgilua.mkurlpath("form_add_paper.lp", paper_table)
    url = url:match("/+.*/(.*)")
    cgilua.print("<a href='"..url.."'>voltar</a>")
    return
  end
end

package.path = "../?.lua;"..package.path
require("dao")

local ok = assert(dao.insert_paper(paper_table))
cgilua.put('query = "'..ok..'"<br>')
cgilua.print("Artigo inserido com sucesso.<br>")
%>
<a href="form_add_paper.lp">Inserir novo artigo</a>
