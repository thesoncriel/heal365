<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 건강검진" contents="${contentsCode }">
<div class="header">
    <h1>건강검진 병원별 설정</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="section">
<div class="article">
<fieldset>
<table class="board-list">
	<thead>	
		<tr>
			<th>번호</th>
			<th>그룹명</th>
			<th>설정여부</th>
			<th>설정</th>	
		</tr>	
	</thead>
	<tbody>
		<s:iterator value="listData">
			<tr>
				<td>${row_number }</td>
				<td>${name }</td>
				<td>
					<s:if test="field_count == 0">
						-
					</s:if>
					<s:else>
						설정됨
					</s:else>
				</td>
				<td><a href="edit?id_medi=${id }&medi_name=${name }">설정하러 가기</a></td>
			</tr>
		</s:iterator>
	</tbody>
</table>
</fieldset>


<div class="footer board">
	<div class="buttons">
	   <a:pagenav page="${param.page }" params="${params}" rowCount="${rowCount }" rowLimit="10" navCount="10" id="pagecontroller" cssClass="page-controller" font="symbol" />
	</div>
</div>
</div>
</div>

</a:html>