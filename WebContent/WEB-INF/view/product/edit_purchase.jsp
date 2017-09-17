<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - Group Action Test : Edit">

<div class="article">
<h1>상품 구매</h1>
<form action="/purchase/modify" method="post" enctype="multipart/form-data" class="validator">
<fieldset>
<table>
<tbody>

<tr>
<th>사진</th>
<td><a:img src="/upload/product/img/${showData.file_img }" alt="상품 사진" srcNone="/img/none.png" altNone="상품 사진 없음" width="320" height="240" /></td></tr>

<tr>
<th>상품명</th>
<td>${showData.name }</td></tr>

<tr>
<th><label for="opt_detail">상품 옵션</label></th>
<td><input type="text" name="opt_detail" value="${showData.id_opt_group }" title="상품 옵션을 입력하세요."/></td></tr>

<tr>
<th>구매 가격</th>
<td><input type="text" name= "amount" value="${showData.price_event }" readonly="readonly" style="border: none;"/> 원</td></tr>

<tr>
<th><label for="purchase_count">주문 개수</label></th>
<td><input type="text" name="purchase_count" value="1"/> 개</td></tr>

<tr>
<th>총 구매 가격</th>
<td><input type="text" name="amount_adjust" value="${showData.price }" readonly="readonly" style="border: none;"/> 원</td></tr>

<tr>
<th><label for="pay_point">적립 예정 포인트</label></th>
<td><input type="text" name="pay_point" value="${showData.pay_point }" readonly="readonly" style="border: none;"/> 점</td></tr>

<tr>
<th>상품 설명 요약</th>
<td>${showData.contents_summary }</td></tr>

</tbody>
</table>
<%--숨김 필드 모음--%>
<input type="hidden" name="id" value="${showData.id }"/>
</fieldset>
<button type="submit" class="artn-button board">구매</button>
</form>

</div>
</a:html>