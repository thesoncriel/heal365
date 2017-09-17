<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - Validation Check">

<div class="article error_auth">
<img src="/img/sub/heal_sub_error-img.jpg" alt="" usemap="#map" />

<map name="map">
	<area shape="rect" coords="307, 240, 421, 257" href="/main" alt="메인 페이지로" />    
    <area shape="rect" coords="291, 261, 441, 279" href="/logout" alt="다른 계정으로 로그인 하기" />
    <area shape="rect" coords="289, 285, 442, 300" href="#" data-rule="gotoback" alt="이전 화면으로 돌아가기" />
</map>

<%-- <h1>권한 오류 입니다.</h1>
<p>본 페이지에 접근 할 권한이 없습니다.<br/>올바른 권한을 가진 계정으로 다시 로그인 하시길 바랍니다.</p>
<s:if test="showIsNull || hasLogin">
<a href="/login">로그인 하기</a><br/>
</s:if>
<s:else>
<a href="/main">메인 페이지로</a><br/>
<a href="/logout">다른 계정으로 로그인 하기</a>
</s:else>
<br/>
<a href="#" data-rule="gotoback">이전 화면으로 돌아가기</a> --%>
</div>

</a:html>