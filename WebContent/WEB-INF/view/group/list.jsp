<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 병원 목록" contents="${contentsCode }">
<div class="header">
    <h1>병원 찾기</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div> 
<div class="section">
<div class="article">
<table class="board-list">
<thead><tr>
<th class="row-num">번호</th>
<th class="name">병원명</th>
<th>주소</th>
<th class="phone">TEL</th>
<th class="phone">FAX</th>
<th class="date">생성일</th>
<th class="last etc">기타</th> 
</tr>
</thead>

<tbody>
<s:if test="listIsNull">
<tr><td colspan="5">그룹이 없습니다 ^^;</td></tr>
</s:if>
<s:else><s:iterator value="listData">
<tr>
<td><s:property value="row_number"/></td>
<td><s:property value="name"/></td>
<td class="address"><s:property value="address_group1"/></td>
<td><s:property value="phone_group"/></td>
<td><s:property value="phone_fax"/></td>
<td><s:property value="date_create_fmt"/></td>
<td>
    <s:if test='%{(hasLogin == true) && (auth.isGroupUser(id) == false)}'>
        <a href="/groupuser/write?id_group=${id }&group_name=${name }&contents=${contentsCode }">가입</a><br/>
    </s:if>
    &nbsp;&nbsp;&nbsp;<a href="show?id=${id }&contents=${contentsCode }">정보 보기</a>
    <s:if test='auth.isAdmin'>
        <%-- <a href="/medi/item/write?id_group=${id }&group_name=${name }">건강검진 작성</a> --%>
    </s:if>
</td>
</tr>
</s:iterator></s:else>
</tbody>
</table>
<div class="footer board">
	<s:if test='%{auth.isAdmin}'>
		<div class="buttons">
			<a href="write?contents=${contentsCode }" class="artn-button board">그룹 추가</a>
		</div>
	</s:if>
<a:pagenav page="${param.page }" params="${params}" rowCount="${rowCount }" rowLimit="10" navCount="10" id="pagecontroller" cssClass="page-controller" font="symbol" />
</div>
	<div>
		<s:include value="/WEB-INF/include/search/group.jsp"></s:include>
	</div>
</div>
</div>
</a:html>