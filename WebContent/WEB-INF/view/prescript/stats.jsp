<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title="처방전 통계" contents="${contentsCode }">
<div class="header">
    <h1>운동처방 통계</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="section">
<div class="article prescript-stats">
	<div class="stats">
		<div class="stats-item">
			<h2>연령별</h2>
			<div id="chart1" data-type="pie" data-from="#table_ageGroup" style="margin-top:20px; margin-left:20px; width:200px; height:200px;"></div>
			<table id="table_ageGroup" class="data">
				<thead>
				<tr>
					<th>연령</th>
					<th>처방 횟수</th>
				</tr>
				</thead>
				<tbody>
			<s:iterator value="subData.ageGroup">
				<tr>
					<td>${user_age_group }</td>
					<td>${count_user_age_group }</td>
				</tr>
			</s:iterator>
				</tbody>
			</table>
		</div>
		<div class="stats-item">
			<h2>통증 부위별</h2>
			<div id="chart2" data-type="pie" data-from="#table_painSite" style="margin-top:20px; margin-left:20px; width:200px; height:200px;"></div>
			<table id="table_painSite" class="data">
				<thead>
				<tr>
					<th>통증부위</th>
					<th>처방 횟수</th>
				</tr>
				</thead>
				<tbody>
			<s:iterator value="subData.painSite">
				<tr>
					<td>${pain_site_kor }</td>
					<td>${count_pain_site }</td>
				</tr>
			</s:iterator>
				</tbody>
			</table>
		</div>
	</div>
	
	<div class="stats">
		<h2>연령별 통증부위</h2>
		<div class="stats-item">
			<h3>20대</h3>
			<div id="chart3" data-type="pie" data-from="#table_painSiteByAge20" style="margin-top:20px; margin-left:20px; width:200px; height:200px;"></div>
			<table id="table_painSiteByAge20" class="data">
				<thead>
				<tr>
					<th>통증부위</th>
					<th>처방 횟수</th>
				</tr>
				</thead>
				<tbody>
			<s:iterator value="subData.painSiteByAge1">
				<tr>
					<td>${pain_site_kor }</td>
					<td>${count_pain_site }</td>
				</tr>
			</s:iterator>
				</tbody>
			</table>
		</div>
		<div class="stats-item">
			<h3>30대</h3>
			<div id="chart4" data-type="pie" data-from="#table_painSiteByAge30" style="margin-top:20px; margin-left:20px; width:200px; height:200px;"></div>
			<table id="table_painSiteByAge30" class="data">
				<thead>
				<tr>
					<th>통증부위</th>
					<th>처방 횟수</th>
				</tr>
				</thead>
				<tbody>
			<s:iterator value="subData.painSiteByAge2">
				<tr>
					<td>${pain_site_kor }</td>
					<td>${count_pain_site }</td>
				</tr>
			</s:iterator>
				</tbody>
			</table>
		</div>
		<div class="stats-item">
			<h3>40대</h3>
			<div id="chart5" data-type="pie" data-from="#table_painSiteByAge40" style="margin-top:20px; margin-left:20px; width:200px; height:200px;"></div>
			<table id="table_painSiteByAge40" class="data">
				<thead>
				<tr>
					<th>통증부위</th>
					<th>처방 횟수</th>
				</tr>
				</thead>
				<tbody>
			<s:iterator value="subData.painSiteByAge3">
				<tr>
					<td>${pain_site_kor }</td>
					<td>${count_pain_site }</td>
				</tr>
			</s:iterator>
				</tbody>
			</table>
		</div>
		<div class="stats-item">
			<h3>50대</h3>
			<div id="chart6" data-type="pie" data-from="#table_painSiteByAge50" style="margin-top:20px; margin-left:20px; width:200px; height:200px;"></div>
			<table id="table_painSiteByAge50" class="data">
				<thead>
				<tr>
					<th>통증부위</th>
					<th>처방 횟수</th>
				</tr>
				</thead>
				<tbody>
			<s:iterator value="subData.painSiteByAge4">
				<tr>
					<td>${pain_site_kor }</td>
					<td>${count_pain_site }</td>
				</tr>
			</s:iterator>
				</tbody>
			</table>
		</div>
		<div class="stats-item">
			<h3>60대</h3>
			<div id="chart7" data-type="pie" data-from="#table_painSiteByAge60" style="margin-top:20px; margin-left:20px; width:200px; height:200px;"></div>
			<table id="table_painSiteByAge60" class="data">
				<thead>
				<tr>
					<th>통증부위</th>
					<th>처방 횟수</th>
				</tr>
				</thead>
				<tbody>
			<s:iterator value="subData.painSiteByAge5">
				<tr>
					<td>${pain_site_kor }</td>
					<td>${count_pain_site }</td>
				</tr>
			</s:iterator>
				</tbody>
			</table>
		</div>
		<div class="stats-item">
			<h3>70대</h3>
			<div id="chart8" data-type="pie" data-from="#table_painSiteByAge70" style="margin-top:20px; margin-left:20px; width:200px; height:200px;"></div>
			<table id="table_painSiteByAge70" class="data">
				<thead>
				<tr>
					<th>통증부위</th>
					<th>처방 횟수</th>
				</tr>
				</thead>
				<tbody>
			<s:iterator value="subData.painSiteByAge6">
				<tr>
					<td>${pain_site_kor }</td>
					<td>${count_pain_site }</td>
				</tr>
			</s:iterator>
				</tbody>
			</table>
		</div>
	</div>
</div>
</div>

<script type="text/javascript">
	function parsePieChartData(strSelector){
		var jqTrList = $(strSelector).find("tbody tr");
		var iRowLen = jqTrList.length;
		var iCellLen = jqTrList.eq(0).find("td").length;
		var jqTdList = null;
		var aData = [iRowLen];
		var iCell = 0;
		
		
		for(var iRow = 0; iRow < iRowLen; iRow++){
			aData[ iRow ] = [iCellLen];
			jqTdList = jqTrList.eq( iRow ).find("td");
			
			iCell = 0;
			aData[ iRow ][ iCell ] = jqTdList.eq( iCell ).text();
			for(iCell = 1; iCell < iCellLen; iCell++ ){
				aData[ iRow ][ iCell ] = parseFloat( jqTdList.eq( iCell ).text() );
			}
		}

		return aData;
	}
	
	function createPieChart(jqElem){
		var data = null;
	    var pie = null;

	    data = parsePieChartData( jqElem.data("from") );
		
		pie = $.jqplot( jqElem.attr("id"), [data], {
	        gridPadding: {top:0, bottom:38, left:0, right:0},
	        seriesDefaults:{
	            renderer: $.jqplot.PieRenderer, 
	            trendline:{ show: false }, 
	            rendererOptions: { padding: 8, showDataLabels: true }
	        },
	        legend:{
	            show:true, 
	            placement: "outside", 
	            rendererOptions: {
	                numberRows: 2
	            }, 
	            location: "s",
	            marginTop: "10px"
	        }       
	    });
	}

	$(document).ready(function(){
		$("div[id^='chart']").each(function(index){
			var jqChart = $(this);
			
			if (jqChart.data("type") === "pie"){
				createPieChart( jqChart );
			}
		});
	});
	</script>

</a:html>