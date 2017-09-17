<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 간호사" contents="${contentsCode }">
<div class="header">
    <h1>건강점검 리스트 보기</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="section">
<div class="article">
<fieldset>
<table class="board-edit">
	<thead>	
		<tr>
			<th>번호</th>
			<th>이름</th>
		</tr>	
	</thead>
	<tbody>
		<s:iterator value="listData">
			<tr>
				<td>${row_number }</td>
				<td><a href="show?id=${id}">${id_user }</a></td>
			</tr>
		</s:iterator>
	</tbody>
</table>
<%--숨김 필드 모음--%>
<s:if test="showIsNull == false">
<input type="hidden" name="id" value="${showData.id }"/>
<input type="hidden" name="date_create" value="${showData.date_create }"/>
</s:if>

</fieldset>


<div class="footer board">
	<div class="buttons">
			<a href="write" class="artn-button board">작성하기</a>
			<a href="list" class="artn-button board">목록</a>
	</div>
</div>
</div>
</div>

</a:html>