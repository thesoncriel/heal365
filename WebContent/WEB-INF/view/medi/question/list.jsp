<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 문진표" contents="${contentsCode }">
<div class="header">
    <h1>문진표</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<s:if test="auth.isAdmin || auth.isMediStaff || auth.isNurse">
<div style="margin-bottom: 5px; color: red;">※회원 가입된 환자만 작성하실 수 있습니다.</div>
</s:if>
<div class="section">
<div class="article">
<fieldset>
<table class="board-list">
	<thead>	
		<tr>
			<th>번호</th>
			<th>환자명</th>
			<th>키</th>
			<th>몸무게</th>
			<th>작성일</th>
			<th>작성자</th>
		</tr>	
	</thead>
	<tbody>
		<s:iterator value="listData">
			<tr>
				<td>${row_number }</td>
				<td class="tooltip"><a href="show?id_medi_question=${id_medi_question}&contents=${params.contents }" class="medi-user-patient" title=" "> ${user_name }</a>
				<input type="hidden" class="id_user" value="${id_user }"/>
                <!--{id}<br/>{name}({gender_kor}) {date_birth} <br/>{phone_mobi} -->
                <span class="tooltipView" style="display : none"></span>
				</td>
				<td>${height}cm</td>
				<td>${weight}kg</td>				
				<td>${date_upload }</td>
				<td>${writer_name }</td>
			</tr>
		</s:iterator>
	</tbody>
</table>

</fieldset>


<div class="footer board">
	<div class="buttons">
		<s:if test="(auth.isGroupStaff == true) || (auth.isNurse == true)">
           <a href="write?contents=${params.contents }" class="artn-button board">작성하기</a>
       </s:if>
       <a:pagenav page="${param.page }" params="${params}" rowCount="${rowCount }" rowLimit="10" navCount="10" id="pagecontroller" cssClass="page-controller" font="symbol" />
	</div>
</div>
<div>
<s:include value="/WEB-INF/include/search/medicheck.jsp">
</s:include>
</div>
</div>
</div>

</a:html>