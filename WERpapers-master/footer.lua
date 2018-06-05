local cfg = dofile("config.lua")
local img = cfg.image_folder

cgilua.print([[
<hr width="80%" align=center>
<table width="80%" align=center>
  <tr>
    <td width="34%">
      <div align="center"><a target="_blank" href="]]..cfg.file_paper_home..[[">
        <img border="0" src="]]..img..[[/logo_wer_papers3.jpg" width="247"
          height="56"></a> </div></td>
    
    <td width="17%"><!-- Start DBLP -->
      <a target="_blank" href="http://www.informatik.uni-trier.de/%7Eley/db/conf/wer/index.html">
      <div align="center"><img src="]]..img..[[/dblp.gif" width="109" border="0" height="40">    </div></td>
    <!-- End DBLP -->
    
    <td width="12%"><!-- Start BDBCOMP -->
      <div align="center"><a href="http://www.lbd.dcc.ufmg.br/bdbcomp/servlet/PesquisaEvento?evento=wer" target="_blank">BDBComp</a> </div></td>
    <!-- End BDBCOMP -->
    
    <td><!-- Start StatCounter -->
      <p align="right">
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
]])
