<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 물리치료" contents="${contentsCode }">
	<script>
		$(document).ready(function(){
			$("#progressbar").progressbar({
				value: 0
			});
			
			$("#button_AddField").click(function(){
				Artn.List.inst["#list_mediCheckField"].add();
			});
			
			$("#button_submitMediCheckField").click(function(){
				var list = Artn.List.inst["#list_mediCheckField"];
				var maData = list.serialize();
				var iLen = maData.length;
				var jqForm = $("#form_mediCheckField");

				Artn.Method.mediCheckSubmit( jqForm, maData, iLen, 0 );

			});
		});
		
		Artn.Method.mediCheckSubmit = function(jqForm, maData, iLen, iCurr){
			
			if (iCurr === 0){
				$("#dialog_progress").dialog("open");
				Artn.Method.setProgress(0);
			}
			
			Artn.Util.deserialize( jqForm, maData[ iCurr ] );
			
			$.post(jqForm.attr("action"), jqForm.serialize(), function(data){
				if (data.indexOf("1") >= 0){
					Artn.Method.setProgress( Math.floor( (iCurr / iLen) * 100 ) );
					
					iCurr++;
					
					if (iLen === iCurr){
						$("#dialog_progress").dialog("close");
						$("#list_mediCheckField").find("button.delete").remove();
						alert("등록이 완료 되었습니다.");
						return;
					}
					
					Artn.Method.mediCheckSubmit(jqForm, maData, iLen, iCurr);
				}
				else{
					$("#dialog_progress").dialog("close");
					alert("등록 중 오류가 발생 되었습니다.");
					jqForm.after("<textarea>" + data + "</textarea>");
				}
			});
		};
		
		Artn.Method.setProgress = function(iProgress){
			$("#progressbar").progressbar("option", {
				value: iProgress
			});
		};
	</script>
<div class="header">
    <h1>물리치료 항목 설정</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="section">
<div class="article">

<table class="board-list medi-check-field">
	<thead>
		<tr>
			<th class="seq">순번</th>
			<th>항목명</th>
			<th>입력형태</th>
			<th>선택내용</th>
			<th class="unit">단위</th>
			<th class="relation">데이터 관계</th>
			<th>측정결과 설정</th>			
		</tr>
	</thead>
	<tbody id="list_mediCheckField" data-renumber="true">
		<s:if test="listIsNull">
		<tr>
			<td>1</td>
			<td><input type="text" name="field_name" value=""/><input type="hidden" name="id" value=""/></td>
			<td><s:select name="field_type" value="field_type" list="#{'0':'텍스트', '1':'셀렉트박스' }" theme="simple"/></td>
			<td><input type="text" name="field_label" value=""/></td>
			<td><input type="text" name="field_unit" value="" size="4"/></td>
			<td><input type="text" name="field_relation" value=""/></td>
			<td><s:select name="result_code" value="result_code" list="#{'':'선택안함', 'bp1':'혈압(저)', 'bp2':'혈압(고)', 'glu':'혈당', 'an':'빈혈', 'tc':'고지혈증', 'gh':'당화혈색소', 'ts':'T-Score', 'fat':'체지방량' }" theme="simple"/></td>		
		</tr>
		</s:if>
		<s:iterator value="listData" status="s">		
		<tr>
			<td class="seq">${s.index + 1 }</td>
			<td><input type="text" name="field_name" value="${field_name }"/><input type="hidden" name="id" value="${id }"/></td>
			<td><s:select name="field_type" value="field_type" list="#{'0':'텍스트', '1':'셀렉트박스' }" theme="simple"/></td>
			<td><input type="text" name="field_label" value="${field_label }"/></td>
			<td><input type="text" name="field_unit" value="${field_unit }" size="4"/></td>
			<td><input type="text" name="field_relation" value="${field_relation }"/></td>			
			<%-- <td>
				<button class="artn-button board edit" data-rule="dialogButton" data-dialog="#dialog_resultConf">설정</button>
				
				<input type="hidden" name="date_upload" value="${date_upload }"/>
				
				<input type="hidden" name="result0" value="${result0 }"/>
				<input type="hidden" name="result1min" value="${result1min }"/>
				<input type="hidden" name="result1max" value="${result1max }"/>
				<input type="hidden" name="result1" value="${result1 }"/>
				<input type="hidden" name="result2min" value="${result2min }"/>
				<input type="hidden" name="result2max" value="${result2max }"/>
				<input type="hidden" name="result2" value="${result2 }"/>
				<input type="hidden" name="result3min" value="${result3min }"/>
				<input type="hidden" name="result3max" value="${result3max }"/>
				<input type="hidden" name="result3" value="${result3 }"/>
				<input type="hidden" name="result4min" value="${result4min }"/>
				<input type="hidden" name="result4max" value="${result4max }"/>
				<input type="hidden" name="result4" value="${result4 }"/>
				<input type="hidden" name="result5min" value="${result5min }"/>
				<input type="hidden" name="result5max" value="${result5max }"/>
				<input type="hidden" name="result5" value="${result5 }"/>
			</td> --%>
			<td><s:select name="result_code" value="result_code" list="#{'':'선택안함', 'bp1':'혈압(저)', 'bp2':'혈압(고)', 'glu':'혈당', 'an':'빈혈', 'tc':'고지혈증', 'gh':'당화혈색소', 'ts':'T-Score', 'fat':'체지방량' }" theme="simple"/></td>
						
		</tr>
		</s:iterator>
		<!--	
		<tr>
			<td><input type="text" name="field_name" value=""/><input type="hidden" name="id" value=""/></td>
			<td><s:select name="field_type" value="field_type" list="#{'0':'텍스트', '1':'셀렉트박스' }" theme="simple"/></td>
			<td><input type="text" name="field_label" value=""/></td>
			<td><input type="text" name="field_unit" value="" size="4"/></td>
			<td><input type="text" name="field_relation" value=""/></td>		
			<td><s:select name="result_code" value="result_code" list="#{'':'선택안함', 'bp1':'혈압(저)', 'bp2':'혈압(고)', 'glu':'혈당', 'an':'빈혈', 'tc':'고지혈증', 'gh':'당화혈색소', 'ts':'T-Score', 'fat':'체지방량' }" theme="simple"/></td>
		</tr>		
		 -->
	</tbody>
</table>

<form id="form_mediCheckField" action="modify" method="post" enctype="multipart/form-data" class="validator">
<fieldset>
<%--숨김 필드 모음--%>
<s:if test="showIsNull == false">

</s:if>
<input type="hidden" name="contents" value="${contentsCode }"/>
<input type="hidden" name="ajax" value="true"/>

<input type="hidden" name="id"/>
<input type="hidden" name="field_name"/>
<input type="hidden" name="field_type"/>
<input type="hidden" name="field_label"/>
<input type="hidden" name="field_unit"/>
<input type="hidden" name="field_relation"/>
<input type="hidden" name="result_code"/>
</fieldset>

<div class="footer board">
	<div class="buttons">
		<button id="button_AddField" class="artn-button board" type="button">추가</button>
		<button id="button_submitMediCheckField" type="button" class="artn-button board">설정 완료</button>
	</div>
</div>
</form>
</div>
</div>



<div id="dialog_resultConf">
	<form>
	<div>0또는 입력없음 <input type="text" name="result0"/></div>
	<div>
		<input type="text" name="result1min"/> 이상이고 <input type="text" name="result1max"> 이하이면, <input type="text" name="result1">
	</div>
	<div>
		<input type="text" name="result2min"/> 이상이고 <input type="text" name="result2max"> 이하이면, <input type="text" name="result2">
	</div>
	<div>
		<input type="text" name="result3min"/> 이상이고 <input type="text" name="result3max"> 이하이면, <input type="text" name="result3">
	</div>
	<div>
		<input type="text" name="result4min"/> 이상이고 <input type="text" name="result4max"> 이하이면, <input type="text" name="result4">
	</div>
	<div>
		<input type="text" name="result5min"/> 이상이고 <input type="text" name="result5max"> 이하이면, <input type="text" name="result5">
	</div>
	<button id="button_EditOK" type="button" class="artn-button board">확인</button>
	</form>
</div>

<div id="dialog_progress">
	<div id="progressbar"></div>
</div>

</a:html>