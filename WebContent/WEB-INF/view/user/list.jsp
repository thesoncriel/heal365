<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 사용자 목록" contents="${contentsCode }">
	<div class="header">	
	    <h1>사용자 관리</h1>
	    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>		
	</div>
	<div class="section">
		<div class="article">
<table class="board-list">
<thead><tr>
<th class="row-num">번호</th>
<th>아이디</th>
<th class="name">성명</th>
<th>폰번호</th>
<th class="date">가입일</th>
<th class="last">상세정보</th>
</tr></thead>

<tbody>
<s:if test="listIsNull">
<tr><td colspan="5">회원이 없습니다 ^^;</td></tr>
</s:if>
<s:else><s:iterator value="listData">
<tr>
<td><s:property value="row_number"/></td>
<td><s:property value="id"/></td>
<td><s:property value="name"/></td>
<td><s:property value="phone_mobi"/></td>
<td><s:property value="date_join_fmt"/></td>
<td><a href="show?id=${id }&contents=${contentsCode }">정보 보기</a></td>
</tr>
</s:iterator></s:else>
</tbody>
</table>
<div class="footer board">
<div class="buttons">
	<a href="write?contents=${contentsCode }" class="artn-button board">회원 추가</a>
</div>
	<a:pagenav page="${param.page }" params="${params}" rowCount="${rowCount }" rowLimit="10" navCount="10" id="pagecontroller" cssClass="page-controller" font="symbol" />
</div>
	<div>
	<form action="list.action?contents=${param.contents }" method="post" class="board search">
		<span>이름</span>
        <input type="text" name="name" value="${param.name}" />
        <input class="artn-button board" type="submit" value="검색" />
	</form>
	</div>
</div>
</div>

</a:html>