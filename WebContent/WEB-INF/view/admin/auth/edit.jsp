<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - User Action Test : List" contents="${param.contents }">

<div class="article">
<h1>권한 수정</h1>
<form action="modify" method="post" enctype="multipart/form-data" class="validator">
<fieldset>
<table>
<tbody>
<tr>
<th>권한명칭</th>
<td><input type="text" name="auth_user_kor" value="${showData.auth_user_kor }"/>
	<input type="hidden" name="id" value="${showData.id }"/><input type="hidden" name="id_group" value="${showData.id_group }"/></td></tr>
<tr>
<th>권한코드 (비트 연산)</th>
<td><a:checkboxlist name="auth_user" list="01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28(사용자 정보 수정),29,30(관리자),31(최고관리자)" value="${showData.auth_user }"/></td></tr>
<tr>
<th>메뉴 권한</th>
<td><a:checkboxlist name="restrict_menu" list="01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,20,21" value="${showData.restrict_menu }"/></td></tr>
<tr>
<th>사용자 정보 수정 권한</th>
<td><a:checkboxlist name="restrict_user_edit" list="01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20" value="${showData.restrict_user_edit }"/></td></tr>
</tbody>
</table>
</fieldset>
<button class="artn-button board" type="submit">수정 완료</button>
<a class="artn-button board" href="list">목록</a>
</form>

</div>
</a:html>