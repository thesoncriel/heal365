<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>

<a:html title=" - User Action Test : List" contents="${boardInfo.contentsCode }">
	<div class="header">
		<h1>${boardInfo.name }</h1>
		<div id="breadcrumbs" data-sub="${boardInfo.contentsCode }"></div>
	</div>
	<div class="section">
		<div class="article">
		<form action="delete">
			<table class="board-list">
				<thead>
				<tr>
					<s:if test="auth.isAdmin"><th> </th></s:if>
					<th class="row-num">번호</th>
					<th class="div">구분</th>
					<th>제목</th>
					<th class="name">작성자</th>
					<th class="date">등록일</th>
					<th class="view-cnt">조회수</th>			
				</tr>
				</thead>
				<tbody>
				<s:if test="listIsNull">
				<tr><td colspan="7">게시물이 존재하지 않습니다.</td></tr>
				</s:if>
				<s:else><s:iterator value="listData">
				<tr>
					<s:if test="auth.isAdmin"><td><input type="checkbox" name="id" value="${id}"/></td></s:if>
					<td><s:property value="row_number"/></td>
					<td><s:property value="category"/></td>
					<td class="subject"><a href="show?id=${id}&amp;board_no=${param.board_no}&amp;view=${param.view}&amp;contents=${param.contents}"><s:property value="subject"/></a><s:if test="util.today == date_upload_fmt"> &nbsp;<span class="artn-icon-16 new">new</span></s:if></td>
					<td><s:property value="user_name"/></td>
					<td><s:property value="date_upload_fmt"/></td>			
					<td><s:property value="view_count"/></td>			
				</tr>
				</s:iterator></s:else>
				</tbody>
			</table>
			<input type="hidden" name="view" value="${param.view}"/>
			<input type="hidden" name="board_no" value="${param.board_no}"/>
			<input type="hidden" name="contents" value="${param.contents}"/>	
			<div class="footer board">
				<div class="buttons">
					<s:if test="auth.isAdmin"><a href="write?board_no=${param.board_no}&view=${param.view}&amp;contents=${param.contents}" class="artn-button board">글쓰기</a></s:if>
					<s:if test="auth.isAdmin"><button type="submit" class="artn-button board">삭제</button></s:if>
				</div>
				<a:pagenav page="${param.page }" params="${params}" rowCount="${rowCount }" rowLimit="10" navCount="10" id="pagecontroller" cssClass="page-controller" font="symbol" />
			</div>
			</form>
	
			<div>
				<jsp:include page="/WEB-INF/include/search/board.jsp" flush="false" />
			</div>
		</div>
	</div>
</a:html>