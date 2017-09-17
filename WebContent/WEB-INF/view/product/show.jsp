<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - Group Action Test : Edit">

<div class="article">
<h1>상품 정보</h1>
<table>
<tbody>

<tr>
<th>사진</th>
<td><a:img src="/upload/product/img/${showData.file_img }" alt="상품 사진" srcNone="/img/none.png" altNone="상품 사진 없음 - 상품 등록 후 적용 됩니다." width="320" height="240" /></td></tr>

<tr>
<th>상품명</th>
<td>${showData.name }</td></tr>

<tr>
<th>상품 옵션</th>
<td>${showData.id_opt_group }</td></tr>

<tr>
<th>가격</th>
<td>${showData.price } 원</td></tr>

<tr>
<th>할인 전 가격</th>
<td>${showData.price_before } 원</td></tr>

<tr>
<th>이벤트 가격</th>
<td>${showData.price_event } 원</td></tr>

<tr>
<th>적립 포인트</th>
<td>${showData.pay_point }</td></tr>

<tr>
<th>이용 약관</th>
<td>${showData.opt_terms_user }</td></tr>

<tr>
<th>상품 설명</th>
<td>${showData.contents }</td></tr>

<tr>
<th>상품 설명 요약</th>
<td>${showData.contents_summary }</td></tr>

</tbody>
</table>
<a href="/product/edit?id=${showData.id }&purchase=true" class="artn-button board">구매</a>
 <a href="edit?id=${showData.id }" class="artn-button board">수정</a>
</div>
</a:html>