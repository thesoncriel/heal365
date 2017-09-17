<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>

<a:html title=" - Product Action Test : List">
<div class="article">
<form action="delete">
<h1>상품 목록</h1>
	<table>
		<tr>
			<th>상품 번호</th>
			<th>카테고리</th>
			<th>상품명</th>
			<th>가격</th>
			<th>판매 개수</th>
			<th>상품 개수</th>
			<th>상품 개재 일자</th>	
			<th>구매 평가 평균</th>
			<th>상세 정보</th>		
		</tr>
		<tr>
		<s:if test="listIsNull">
		<tr><td colspan="8">상품이 존재하지 않습니다.</td></tr>
		</s:if>
		<s:else><s:iterator value="listData">
		<tr>
			<td><s:property value="id"/></td>			
			<td><s:property value="category"/></td>
			<td><s:property value="name"/></td>
			<td><s:property value="price"/></td>
			<td><s:property value="sold_count"/></td>
			<td><s:property value="product_count"/></td>
			<td><s:property value="date_upload_kor"/></td>
			<td><s:property value="rating_avg"/></td>
			<td><a href="show?id=${id }">상세 보기</a></td>		
		</tr>
		</s:iterator></s:else>
	</table>
	<a href="write" class="artn-button board">상품 등록</a>
	<a:pagenav page="${param.page }" rowCount="${rowCount }" rowLimit="10" navCount="10" id="pagecontroller" />
	</form>
</div>

</a:html>