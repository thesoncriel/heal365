<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:include value="/include/header.jsp"></s:include>
<div class="contents">
	<jsp:include page="/include/leftmenu/4.htmlpart" flush="true" />
	<section>
		<header>
			<h1>병원찾기</h1>
			<span class="navigation-url"> <span class="artn-icon-16 home"></span>
				<a href="#">HOME</a> <span class="artn-icon-16 caret-thin-e">&gt;</span>
				<a href="#">서비스안내</a> <span class="artn-icon-16 caret-thin-e">&gt;</span>
				<a href="#">병원찾기</a>
			</span>
		</header>

		<article class="static-contents board-search">
			<form class="search top" action="">
				<s:include value="/include/search/listHospital.jsp"></s:include>
			</form>

			<table class="artn-board list">
				<thead class="delimiters">
					<tr>
						<th>번호</th>
						<th>병원명</th>
						<th>위치</th>
					</tr>
				</thead>
				<tbody>
					<s:iterator value="ListData">
						<tr>
							<td><s:property value="row_number" /></td>
							<td><a href="/group/show?id=${id }"><s:property value="name" /></a></td>
							<td><s:property value="zipcode" /> <s:property value="address" /></td>
						</tr>
					</s:iterator>
					<s:if test="%{rowCount == 0}">
						<tr>
							<td colspan="19">자료가 없습니다.</td>
						</tr>
					</s:if>
				</tbody>
			</table>
			<footer class="board">
				<div class="page-controller">
					<s:property value="pageController" escapeHtml="false" />
				</div>
			</footer>
		</article>
	</section>
</div>

<s:include value="/include/footer.htmlpart"></s:include>
