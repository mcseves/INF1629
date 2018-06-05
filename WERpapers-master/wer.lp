<%
  local cfg = dofile"config.lua"
%>
<html>
<head>
   <title>WER - Workshop em Engenharia de Requisitos</title>
</head>

<body>
  <br>
  <table width="100%">
    <tr>
      <%
        cgilua.print('<p align="center"><img border="0" src="'..
        cfg.image_folder..'/logo_wer_new.jpg" width="169" height="102"></p>')
      %>
      <p align="center">
        <font face="Times New Roman" size="5" color="#0000FF">
          Workshop em Engenharia de Requisitos
        </font>
        <br>
        <font face="Times New Roman" size="4" color="gray">
          Workshop en Ingeniería de Requerimientos<br>
          Workshop on Requirements Engineering
        </font>
      </p>
    </tr>
    <br>
    <tr>
      <p align="justify" style="margin-left: 10%; margin-right: 10%">
        <font face="Arial">Este Workshop vem sendo realizado desde de 1998 com
          o objetivo de consolidar a comunidade Ibero-americana de pesquisa em
          Engenharia de Requisitos
        </font>
        </br></br>
        <font face="Arial" color="gray">
          Este Workshop se viene realizando desde 1998 y tiene como principal
          objetivo la consolidación de una comunidad Iberoamericana de
          investigación en Ingeniería de Requisitos.
          </br></br>
          This workshop is part of an effort to consolidate an Ibero-american
          community of researchers on Requirements Engineering, which started
          in 1998.
        </font>
      </p>
      <p style="margin-left: 10%; margin-right: 10%" align="center"><b>
        <font face="Verdana" size="2">
          <%
            -- list all wer conferences homepages
            dofile"dao.lua" -- use dao to access the database
            conferences = dao.get_conferences()
            for v in conferences do
			   if v.url:match("http") then
			      cgilua.print('<a href="'..v.url..'">'..v.name_conference..
                  '</a>&nbsp;&nbsp;\n')
			   else
                  cgilua.print('<a href="http://'..v.url..'">'..v.name_conference..
                  '</a>&nbsp;&nbsp;\n')
			   end
            end
          %>       
          <i>!new!</i>&nbsp;&nbsp;
        </font></b>
      </p>
	  </tr>
   </table>
	<table align="center" width="50%">
		<% dofile"google_search_box.lua" %>
	<table>
</body>

<footer>
  <% dofile"footer.lua" %>
</footer>
</html>
