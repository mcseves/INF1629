<%
  local cfg = dofile"config.lua"
  local limit = cfg.file_most_cited_limit
%>
<html>
<head>
   <title>WERpapers - Artigos Publicados no Workshop em Engenharia de
     Requisitos</title>
</head>
<% 
   cgilua.print('<body bgproperties="fixed" background="'
     ..cfg.image_folder..'/eng_req.jpg">')
%>
<br>
   <table border="0" cellpadding="0" cellspacing="0" style="border-collapse:
     collapse" bordercolor="#111111" width="100%" id="AutoNumber1">
      <tr>
      <td>
         <% 
            cgilua.print('<p align="center"><img border="0" src="'
              ..cfg.image_folder..'/logo_wer_papers.jpg" width="169"'
              ..'height="102"></p>')
         %>
         <p align="center">
            <font face="Times New Roman" size="5" color="#0000FF">Artigos
              publicados no WER</font>
            </br>
            <font face="Times New Roman" size="4" color="gray">
              Artículos publicados en WER</br>Papers published on WER
            </font>
         </p>
      <br>
      </td>
      </tr>
      <tr>
      <td>
         <p align="justify" style="margin-left: 10%; margin-right: 10%">
            <font face="Arial">WERpapers  disponibiliza os artigos publicados
              nos anais de cada <%cgilua.print('<a href="'..cfg.file_wer_home
              ..'" target="_blank">WER</a>')%>.  O acesso pode ser feito pelo
              sumário dos anais (para cada edição) ou por busca livre
              utilizando-se a máquina de busca Google (para todas as edições).
              A busca Google é livre e acessa os artigos em pdf.
            </font>
            </br></br>
            <font face="Arial" color="gray">WERpapers pone a su disposición
              los artículos publicados en los anales de todos los Workshops
              <%cgilua.print('<a href="'..cfg.file_wer_home..'" target='..
              '"_blank">WER</a>')%>. Es posible acceder a los mismos utilizando
              el resumen de los anales (para cada edición) o mediante el motor
              de búsqueda Google (para todas las ediciones). La búsqueda en
              Google permited acceder a los artículos en formato pdf.
              </br></br>
              WERpapers makes it possible to access <%cgilua.print('<a href="'
              ..cfg.file_wer_home..'" target="_blank">WER</a>')%> published
              papers. The access can be done for each edition or by using the              Google search engine. Google searches pdf files in all WER
              editions.
            </font>
         </p>
         <p style="margin-left: 10%; margin-right: 10%" align="center"><b>
            <font face="Verdana" size="2">
              <%
                -- list all wer conferences using dao to access the database
                dofile"dao.lua"
                conferences = dao.get_conferences()
                for v in conferences do
                  cgilua.print('<a href='..cfg.file_conference_home..
                  '?conference='..v.name_conference..'>'..v.name_conference
                  ..'</a>&nbsp;&nbsp;\n')
                end
              %>
              <br><a href="<%=cfg["file_paper_cited"]%>?limit=<%=limit%>">
                   Mais citados | Más Citados | Most Cited</a>
            </font></b>
         </p>
      </td>
      </tr>
   </table>
   	<table align="center" width="50%">
		<% dofile"google_search_box.lua" %>
	<table>
</body>

<footer>
  <hr width="80%" align=center>
  <table width="80%" align=center>
    <tr>
      <td width="34%" align=right>
        <a target="_blank" href="<%=cfg["file_wer_home"]%>">
	  <img border="0" src="<%= cfg.image_folder.."/logo_wer_new.jpg"%>"
               width="150" height="56">
	</a>
      </td>
		
      <td width="17%" align=center><!-- Start DBLP -->
        <a target="_blank" href="http://www.informatik.uni-trier.de/%7Eley/db/conf/wer/index.html">
	  <img src="<%= cfg.image_folder.."/dblp.gif"%>"
               width="109" border="0" height="40">
        </a>
      </td>
      <!-- End DBLP -->
		
      <td width="12%" align=left><!-- Start BDBCOMP -->
        <a href="http://www.lbd.dcc.ufmg.br/bdbcomp/servlet/PesquisaEvento?evento=wer" target="_blank">BDBComp</a>
      </td>
      <!-- End BDBCOMP -->
		
      <td align=right><!-- Start StatCounter -->
        <script type="text/javascript" language="javascript">
			  var sc_project=2436695; 
			  var sc_invisible=0; 
			  var sc_partition=23; 
			  var sc_security="d697c1f6"; 
			  var sc_text=3; 
			</script>
			<script type="text/javascript" language="javascript" src="http://www.statcounter.com/counter/counter.js"></script><br>
			<a href="http://my.statcounter.com/project/standard/stats.php?project_id=2436695&amp;guest=1">StatCounter</a>
		  </p>
      </td><!-- End of StatCounter Code -->
    </tr>
  </table>
</footer>
</html>
