
var statisticalGraphModule = function(){
	return{
		
		/*
		@title: Draw pie chart.
		@goal: Draws a pie chart with the data informed using the google chart API.
		@context:
			localization: view layer.
			precondition: SHOW STATISTICAL DATA PAGE.
		@actors: system.
		@resources: chart title, chart dava and the div where the chart will be presented.
		*/
		drawPieChart: function(chart_title, chart_data, chart_div){
		
        	var data = google.visualization.arrayToDataTable(chart_data);

        //@episode 1: Sets the chart options
        	var options = {
          	title: chart_title
        	};
        
        //@episode 2: Uses the google chart API to create the chart and presents it in the informed div.
        	var chart = new google.visualization.PieChart(document.getElementById(chart_div));

        //@episode 3: Draw the chart with the options informed.
       	 	chart.draw(data, options);
      
		}

	}
}();



var statisticalInterfaceManagerModule = function(){
	return{
	
		/*
		@title: Update the interface to select menu item.
		@goal: Updates the interface hilighting the selected menu item and showing the corresponding div.
		@context:
			localization: view layer.
			precondition: SHOW STATISTICAL DATA PAGE.
		@actors: system.
		@resources: id of the menu item.
		*/


		selectMenuItem: function(menu_item_id){

		//@episode 1: Keeps only the selected menu item active.
			$("#statistical_menu_ul li").removeClass("active");
			$("#"+menu_item_id+"_li").addClass("active");
			
		//@episode 2: Shows only the corresponding div.
			$("#middle_content_div > div").addClass("table_chart_div");
			$("#"+menu_item_id+"_div").removeClass("table_chart_div");

		//@episode 3: Shows only the corresponding chart div.	
			//$("#"+menu_item_id+"Chart_div").removeAttr("hidden");			
		}
	}
}();		

var statisticalModule = function(){
	return{
		/*
		@title: Request keywords used by the authors.
		@goal: Request to the control layer the data from the number of times that the keywords were used by the authors.
		@context:
			localization: view layer.
			precondition: SHOW STATISTICAL DATA PAGE.
		@actors: system.
		@resources: type of query to be performed.
		*/

		keywordsUsedByAuthor: function() {

		//@episode 1: Requests CONTROL REQUEST STATISTICAL QUERY the keywords used by author. .
			$.getJSON("../controller/statistical_data.lp", {statistical_query: "keywordsUsedByAuthor"}, function (data){
		        
		//@episode 2: Removes the previous data from the result table.
				$("#keywords_used_table tr:not(:first)").remove();
		        $.each(data, function (key,val) {
		//@episode 3: For each result row, adds an row to the table to shows the data.
					$("#keywords_used_table").find("tbody:last").append("<tr><td>"+val.author+"</td><td>"+val.k+"</td><td>"+val.contador+"</td></tr>");
					
				});	

		        
		    });
		},


		/*
		@title: Request total number of papers.
		@goal: Request to the control layer the total number of papers of the event.
		@context:
			localization: view layer.
			precondition: SHOW STATISTICAL DATA PAGE.
		@actors: system.
		@resources: type of query to be performed.
		*/

		totalNumberOfPapers: function() {

			

		//@episode 1: Requests CONTROL REQUEST STATISTICAL QUERY the total number of papers.
			$.getJSON("../controller/statistical_data.lp", {statistical_query: "totalNumberOfPapers"}, function (data){
		
		//@episode 2: Removes the previous data from the result table.
			$("#total_num_papers_table tr:not(:first)").remove();	
		        $.each(data, function (key,val) {

		//@episode 3: For each result row, adds an row to the table to shows the data.
					$("#total_num_papers_table").find("tbody:last").append("<tr><td>"+val.total+"</td></tr>");
					
				});	

		        
		    });
		},

		/*
		@title: Request amount of papers by language
		@goal: Request to control layer the total number of papers at the digital library.
		@context:
			localization: view layer.
			precondition: SHOW STATISTICAL DATA PAGE.
		@actors: system.
		@resources: type of query to be performed.
		*/

		papersByLanguage: function() {

		//@episode 1: Creates a variable to store the data that will be presented at the chart.
			var chart_data = new Array();
			chart_data.push(["Idioma", "Artigos"]);
			
		//@episode 2: Requests CONTROL REQUEST STATISTICAL QUERY the number of papers by language.
			$.getJSON("../controller/statistical_data.lp", {statistical_query: "papersByLanguage"}, function (data){
		
		//@episode 3: Removes the previous data from the result table.
				$("#papers_by_language_table tr:not(:first)").remove();	
		        $.each(data, function (key,val) {

		//@episode 4: For each result row, adds an row to the table to shows the data.
					$("#papers_by_language_table").find("tbody:last").append("<tr><td>"+val.l+"</td><td>"+val.total+"</td></tr>");
					chart_data.push([val.l, parseInt(val.total)]);
				});	
		//@episode 5: DRAW PIE CHART
		       	statisticalGraphModule.drawPieChart("Artigos x Idioma", chart_data, "amountOfPapersByLanguageChart_div");
		    });
									    
		},

		/* 
		@title: Request amount of papers by conference
		@goal: Request to control layer the amount of papers written in each language.
		@context:
			localization: view layer.
			precondition: SHOW STATISTICAL DATA PAGE.
		@actors: system.
		@resources: type of query to be performed.
		*/

		papersByConference: function() {

		//@episode 1: Creates a variable to store the data that will be presented at the chart.
			var chart_data = new Array();
			chart_data.push(["Conferencia", "Artigos"]);	

		//@episode 2: Requests CONTROL REQUEST STATISTICAL QUERY the number of papers by conference.
			$.getJSON("../controller/statistical_data.lp", {statistical_query: "papersByConference"}, function (data){
		
		//@episode 3: Removes the previous data from the result table.
			$("#papers_by_conference_table tr:not(:first)").remove();	
		        $.each(data, function (key,val) {

		//@episode 4: For each result row, adds an row to the table to shows the data.
					$("#papers_by_conference_table").find("tbody:last").append("<tr><td>"+val.conference+"</td><td>"+val.total+"</td></tr>");
					chart_data.push([val.conference, parseInt(val.total)]);
				});	
		//@episode 5: DRAW PIE CHART
		  		statisticalGraphModule.drawPieChart("Conferencia x Artigos", chart_data, "amountOfPapersByConferenceChart_div");
		        
		    });
		},

		/*
		@title: Request amount of confences by country
		@goal: Request to control layer the amount of conferences held in each country.
		@context:
			localization: view layer.
			precondition: SHOW STATISTICAL DATA PAGE.
		@actors: system.
		@resources: type of query to be performed.
		*/

		conferencesByCountry: function() {

		//@episode 1: Creates a variable to store the data that will be presented at the chart.
			var chart_data = new Array();
			chart_data.push(["País", "Conferências"]);

		//@episode 2: Requests CONTROL REQUEST STATISTICAL QUERY the number of conferences by country.
			$.getJSON("../controller/statistical_data.lp", {statistical_query: "conferencesByCountry"}, function (data){

		//@episode 3: Removes the previous data from the result table.
				$("#conferences_by_country_table tr:not(:first)").remove();			        	
		        $.each(data, function (key,val) {

		//@episode 4: For each result row, adds an row to the table to shows the data.
					$("#conferences_by_country_table").find("tbody:last").append("<tr><td>"+val.country+"</td><td>"+val.total+"</td></tr>");
					chart_data.push([val.country, parseInt(val.total)]);
				});	
		//@episode 5: DRAW PIE CHART
		  		statisticalGraphModule.drawPieChart("Pais x Conferencias", chart_data, "amountOfConferencesByCountryChart_div");
		        
		    });
		},


		/*
		@title: Request amount of citations by keyword
		@goal: Request to control layer the amount of citations each keyword has.
		@context:
			localization: view layer.
			precondition: SHOW STATISTICAL DATA PAGE.
		@actors: system.
		@resources: type of query to be performed.
		*/
		citationsByKeyword: function() {

		//@episode 1: Creates a variable to store the data that will be presented at the chart.
			var chart_data = new Array();
			chart_data.push(["Keyword", "Citacoes"]);
			

		//@episode 2: Requests CONTROL REQUEST STATISTICAL QUERY the number of citations by keyword.
			$.getJSON("../controller/statistical_data.lp", {statistical_query: "citationsByKeyword"}, function (data){

		//@episode 3: Removes the previous data from the result table.
				$("#citations_by_keyword_table tr:not(:first)").remove();			        	
		        $.each(data, function (key,val) {
		        	
		//@episode 4: For each result row, adds an row to the table to shows the data.
					$("#citations_by_keyword_table").find("tbody:last").append("<tr><td>"+val.keyword+"</td><td>"+val.total+"</td></tr>");
					chart_data.push([val.keyword, parseInt(val.total)]);
				});	
		
		//@episode 5: DRAW PIE CHART
		  		statisticalGraphModule.drawPieChart("Citacoes x Keywords", chart_data, "amountOfCitationsByKeywordChart_div");
		        
		    });
		}
	}
}();	