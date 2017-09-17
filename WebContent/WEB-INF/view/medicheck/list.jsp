<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 건강검진" contents="${contentsCode }">
<div class="header">
    <h1>건강검진</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="section">
<div class="article">
<fieldset>
<table class="board-edit">
	<thead>	
		<tr>
			<th>번호</th>
			<th>환자명</th>
			<th>혈압</th>
			<th>혈당</th>
			<th>고지혈증</th>
			<th>빈혈</th>
			<th>BMI</th>
			<th>체지방률</th>
			<th>골밀도</th>
			<th>작성날짜</th>
		</tr>	
	</thead>
	<tbody>
		<s:iterator value="listData">
			<tr>
				<td>${row_number }</td>
				<td class="tooltip"><a href="show?id_medi_check=${id_medi_check}&contents=${params.contents }" title=""> ${user_name }</a>
                <span style="display : none">${id_user } <br/>${user_name}(${user_gender }) ${date_birth } <br/>${phone_mobi }</span>
                </td>
                <td>정상</td>
                <td>당뇨병</td>
                <td>정상</td>
                <td>비정상</td>
                <td>표준이상</td>
                <td>표준이상</td>
                <td>골감소증</td>			
				<td>${date_upload }</td>
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
</div>
</div>

</a:html>