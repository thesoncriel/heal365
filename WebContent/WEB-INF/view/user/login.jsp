<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 로그인" contents="sub900_1">
<div class="header">
	<h1>로그인</h1>
    <div id="breadcrumbs" data-sub="sub900_1"></div>
</div>
<div class="contents">  
	<form action="/user/login" method="post" class="artn-login">
	    <h2 class="logo">MediFit - 개인 맞춤형 운동처방 시스템</h2>
		<div class="body">
			<div class="inner">
				<ul>
				    <li><input type="text" name="id" data-rule="id" maxlength="16" id="textbox_id" placeholder="아이디를 입력하세요" value="${loginId }" /></li>
				    <li><input type="password" name="pw" maxlength="16" id="textbox_pw" placeholder="비밀번호를 입력하세요"/></li>
				</ul>
		     	<button type="submit" class="artn-button login">로그인</button>
			</div>
			
			<div class="footer">
				
				<div class="inner">
					
					<div class="options">
						<span><input type="checkbox" id="id_save"><label for="id_save">아이디 저장</label></span>&nbsp;&nbsp;&nbsp;  
					    <span><a href="/user/find" target="_blank">아이디</a>/<a href="/user/find" target="_blank">비밀번호 찾기</a></span>
				    </div>
					<hr/>
					<s:if test="hasLoginError"><div class="error"><span class="artn-icon-32 alert"></span>${error.login }</div></s:if>
					<%--<table>
					<tr>
						<td><span class="artn-icon-32 alert"></span></td>
						<td>아싸라삐용 ^^)/</td>
					</tr>
					</table> --%>
					<a id="" href="/join" class="artn-button board">회원 가입하기</a>
				</div>                         
			</div>
		</div>
	</form>
</div>

</a:html>