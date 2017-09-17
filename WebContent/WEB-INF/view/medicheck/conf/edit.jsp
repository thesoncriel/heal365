<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 건강검진" contents="${contentsCode }">
	<script>
		$(document).ready(function(){
			$("#button_AddConf").click(function(){
				Artn.List.inst["#list_mediCheckConf"].add();
			});
			$("#button_addCompleteConf").click(function(){
				Artn.List.inst["#sortablelist_completeConf"].add();
			});
			Artn.List.inst["#sortablelist_completeConf"].inputchange(function(e){
				var sName = $(e.currentTarget).attr("name");
				
				if (sName === "field_id"){
					$.getJSON("/physics/field/show", {
						json: "true",
						id: e.item.field_id
					}, 
					function(data){
						Artn.Util.deserialize( e.currentItem, data );
					});
				}
			});
		});
	</script>
<div class="header">
    <h1>건강검진 병원별 설정</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="section">
<div class="article">
<h2>사용 항목 설정</h2>
<form action="modify" method="post" enctype="multipart/form-data" class="validator">
<input type="text" name="id_medi" value="${param.id_medi }"/>
<input type="text" name="medi_name" value="${param.medi_name }"/>
<fieldset>
<!-- <h3 class="artn-field-header">건강검진 </h3> -->
<div class="article">
<table class="board-list">
	<thead>
		<tr>
			<th>항목명</th>
			<th>그룹위치</th>
			<th>순서</th>
			<th>삭제</th>
		</tr>		
	</thead>
	<tbody id="list_mediCheckConf">
		<s:if test="listIsNull">
			<tr>
				<td><s:select list="subData.fieldList" name="id_medi_check_field" listKey="id" listValue="field_name" theme="simple" value=""></s:select></td>
				<td><a:selectbox name="position_group" min="0" max="3" value=""/></td>
				<td><a:selectbox name="position_seq" min="0" max="10" value=""/></td>
				<td><button type="button" class="delete artn-button board">삭제</button></td>
			</tr>
		</s:if>
		<s:iterator value="listData">
			<tr>
				<td><s:select list="subData.fieldList" name="id_medi_check_field" listKey="id" listValue="field_name" theme="simple" value="id_medi_check_field"></s:select></td>
				<td><a:selectbox name="position_group" min="0" max="3" value="${position_group }"/></td>
				<td><a:selectbox name="position_seq" min="0" max="10" value="${position_seq }"/></td>
				<td><button type="button" class="delete artn-button board">삭제</button></td>
			</tr>
		</s:iterator>
		<!-- 
			<tr>
				<td><s:select list="subData.fieldList" name="id_medi_check_field" listKey="id" listValue="field_name" theme="simple" value=""></s:select></td>
				<td><a:selectbox name="position_group" min="0" max="3" value=""/></td>
				<td><a:selectbox name="position_seq" min="0" max="10" value=""/></td>
				<td><button type="button" class="delete artn-button board">삭제</button></td>
			</tr>
		-->
	</tbody>
</table>
</div>
<%--숨김 필드 모음--%>
<s:if test="showIsNull == false">
<input type="hidden" name="id_medi_check" value="${showData.id_medi_check }"/>
</s:if>
<input type="hidden" name="contents" value="${contentsCode }"/>
</fieldset>


<div class="footer board">
	<div class="buttons">
		<button type="button" id="button_AddConf" class="artn-button board">추가</button>
		<button type="submit" class="artn-button board"><s:if test="showIsNull">작성</s:if><s:else>수정</s:else> 완료</button>
	</div>
</div>
</form>
</div>

<s:set var="fieldColumnList" value="#{
'field1_value':'field1_value',
'field1_result':'field1_result',
'field2_value':'field2_value',
'field2_result':'field2_result',
'field3_value':'field3_value',
'field3_result':'field3_result',
'field4_value':'field4_value',
'field4_result':'field4_result',
'field5_value':'field5_value',
'field5_result':'field5_result',
'field6_value':'field6_value',
'field6_result':'field6_result',
'field7_value':'field7_value',
'field7_result':'field7_result',
'field8_value':'field8_value',
'field8_result':'field8_result',
'field9_value':'field9_value',
'field9_result':'field9_result',
'field10_value':'field10_value',
'field10_result':'field10_result',
'field11_value':'field11_value',
'field11_result':'field11_result',
'field12_value':'field12_value',
'field12_result':'field12_result',
'field13_value':'field13_value',
'field13_result':'field13_result',
'field14_value':'field14_value',
'field14_result':'field14_result'
 }"></s:set>

<div class="article">
<h2>완료 목록 내 항목 설정</h2>
<form action="complete_modify" method="post" enctype="multipart/form-data" class="validator">
<input type="text" name="id_medi" value="${param.id_medi }"/>
<input type="text" name="medi_name" value="${param.medi_name }"/>
<fieldset>
<!-- <h3 class="artn-field-header">건강검진 </h3> -->
<div class="article">
<table class="board-list">
	<thead>
		<tr>
			<th>순서</th>
			<th>위치</th>
			<th>데이터항목</th>
			<th>항목명</th>
			<th>단위</th>
			<th>출력형태</th>
			<th>삭제</th>
		</tr>		
	</thead>
	<tbody id="sortablelist_completeConf">
		<s:if test="subIsNull.completeConfList">
			<tr>
				<td class="seq">1</td>
				<td><s:select list="#fieldColumnList" name="field_column" theme="simple" value=""/></td>
				<td><s:select list="subData.fieldList" name="field_id" listKey="id" listValue="field_name" theme="simple" cssClass="edit" value=""/></td>
				<td><input type="text" name="field_name" value=""/></td>
				<td><input type="text" name="field_unit" value=""/></td>
				<td><a:selectbox name="use_type" value="" list="result,value"/></td>
				<td><button type="button" class="delete artn-button board">삭제</button>
					<input type="hidden" name="seq" value="1"/>
				</td>
			</tr>
		</s:if>
		<s:iterator value="subData.completeConfList">
			<tr>
				<td class="seq">${seq }</td>
				<td><s:select list="#fieldColumnList" name="field_column" theme="simple" value="field_column"/></td>
				<td><s:select list="subData.fieldList" name="field_id" listKey="id" listValue="field_name" theme="simple" cssClass="edit" value="field_id"/></td>
				<td><input type="text" name="field_name" value="${field_name }"/></td>
				<td><input type="text" name="field_unit" value="${field_unit }"/></td>
				<td><a:selectbox name="use_type" value="${use_type }" list="result,value"/></td>
				<td><button type="button" class="delete artn-button board">삭제</button>
					<input type="hidden" name="seq" value="${seq }"/>
				</td>
			</tr>
		</s:iterator>
		<!-- 
			<tr>
				<td class="seq">1</td>
				<td><s:select list="#fieldColumnList" name="field_column" theme="simple" value=""/></td>
				<td><s:select list="subData.fieldList" name="field_id" listKey="id" listValue="field_name" theme="simple" cssClass="edit" value=""/></td>
				<td><input type="text" name="field_name" value=""/></td>
				<td><input type="text" name="field_unit" value=""/></td>
				<td><a:selectbox name="use_type" value="" list="result,value"/></td>
				<td><button type="button" class="delete artn-button board">삭제</button>
					<input type="hidden" name="seq" value="1"/>
				</td>
			</tr>
		-->
	</tbody>
</table>
</div>
<%--숨김 필드 모음--%>
<s:if test="showIsNull == false">
</s:if>
<input type="hidden" name="contents" value="${contentsCode }"/>
</fieldset>


<div class="footer board">
	<div class="buttons">
		<button type="button" id="button_addCompleteConf" class="artn-button board">추가</button>
		<button type="submit" class="artn-button board"><s:if test="showIsNull">작성</s:if><s:else>수정</s:else> 완료</button>
	</div>
</div>
</form>
</div>

</div>

</a:html>