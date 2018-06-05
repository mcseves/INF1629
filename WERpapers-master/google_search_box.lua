cgilua.put(
[[<tr> <!-- Search Google -->
	 <table width="100%">
		<td  align="center">
		<div id="cse-search-form"  align="center" style="width: 40%;">Loading</div>
		<script src="http://www.google.com/jsapi" type="text/javascript"></script>
		<script type="text/javascript"> 
		  google.load('search', '1', {language : 'en'});
		  google.setOnLoadCallback(function() {
			var customSearchControl = new google.search.CustomSearchControl('009472974280876244117:xpn-pdgov3q');
			customSearchControl.setResultSetSize(google.search.Search.FILTERED_CSE_RESULTSET);
			var options = new google.search.DrawOptions();
			options.enableSearchboxOnly("http://www.google.com/cse?cx=009472974280876244117:xpn-pdgov3q");    
			customSearchControl.draw('cse-search-form', options);
		  }, true);
		</script>
		<link rel="stylesheet" href="http://www.google.com/cse/style/look/default.css" type="text/css" />
		</td>
	</table>
</tr>]])
