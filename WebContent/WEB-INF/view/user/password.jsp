<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - User Action Test : List">

<div class="contents">
	<form action="edit" method="post" class="validator user-password">
		<input type="hidden" name="contents" value="${param.contents }"/>
			<h1>사용자 비밀번호 확인</h1>
		<div class="section contents-base">
			<div class="article">					
				<fieldset>
					<span>회원아이디</span> <span>${user.id }</span><br/>
					<label for="userpassword">패스워드</label> <input type="password" id="userpassword" name="pw"/><br/>
					<s:actionerror/>
					<input type="hidden" name="id" value="${param.id }" />
					<input type="hidden" name="pw_checked" value="true" />				
				</fieldset>
				<button type="submit" class="artn-button board">확인</button>
			
				<h3>회원정보 수정</h3>
				<p>외부로부터 회원님의 정보를 안전하게 보호하기 위해
				패스워드를 한번 더 확인합니다.</p>
			</div>
		</div>
	</form>
</div>

</a:html>