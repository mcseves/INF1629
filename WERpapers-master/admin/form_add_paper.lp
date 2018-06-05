<html>
<head>
  <title>Cadastra artigos no BD do WER</title>
</head>

<body>
  <%
    local campo = dofile("campo.lua")
    local cfg = dofile("../config.lua")
  %>
  <p style="margin-left: 50; margin-right: 50">
  <img border="0" src="<%=cfg.image_folder.."/logo_wer_papers.jpg"%>"
   width="100" height="62"><font face="Arial" size="4">(Workshop em Engenharia
   de Requisitos)</font></p>

  <p style="margin-left: 50; margin-right: 50">
  <font face="Arial">Preencha o formulário para inserir os dados no BD de
  artigos do WER.<br>
  Os campos com (*) são obrigatórios.<br>
  Se não forem preenchidos adequadamente haverá problemas no BD.</font></p>
      
  <p style="margin-left: 50; margin-right: 50">
  <b><font face="Arial" size="5">Dados dos Artigos</font></b></p>
      
  <div style="border-style: solid; border-width: 1; padding-left: 4; padding-right: 4; padding-top: 1; padding-bottom: 1; width:735;">

  <form method="POST" action="add_paper.lp">
    <table border="0" cellpadding="0" cellspacing="0"
           style="border-collapse: collapse" bordercolor="#111111"
           width="639" id="AutoNumber1">

      <%= campo("Título do artigo*", "paper_title", cgilua.QUERY.paper_title) %>
      <%= campo("Primeiro autor*", "author", cgilua.QUERY.author) %>
      <%= campo("Co-Autores*", "add_author", cgilua.QUERY.add_author,
                "Use , (vírgula) para separar os autores.") %>
      <%= campo("Palavras-chave", "key_words", cgilua.QUERY.key_words) %>
      <%= campo("Idioma", "language", cgilua.QUERY.language) %>
      <tr>
        <td align="right" width="24%"><font face="Arial">Resumo</font></td>
        <td width="72%"><font face="Arial">&nbsp;<textarea rows="4"
                         name="abstract" cols="42"></textarea></font>
        </td>
      </tr>
      <%= campo("Nome do arquivo*", "file_name", cgilua.QUERY.file_name) %>
      <%= campo("Nome da conferência*", "name_conference",
                cgilua.QUERY.name_conference, "Ex: WER99") %>
      <%= campo("Seção*", "paper_session", cgilua.QUERY.paper_session) %>
      <%= campo("Páginas*", "page", cgilua.QUERY.page) %>
    </table>
    <p align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="Submit" name="B1"><input type="reset" value="Reset" name="B2"></p>
  </form>
  </div>
</body>
</html>
