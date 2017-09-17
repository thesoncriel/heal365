<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 물리치료" contents="${contentsCode }">
<div class="header">
    <h1>물리치료</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="section">
<div class="article">
<fieldset>
<table class="board-list style2">
	<thead>	
		<tr>
			<th>번호</th>
			<th>환자명</th>
			<s:iterator value="subData.fieldInfo">
			<th>${field_name }</th>
			</s:iterator>
			<th>작성일</th>
			<th>작성자</th>
			<th>최종승인자</th>
		</tr>	
	</thead>
	<tbody>
		<s:if test="listIsNull">
		<tr><td colspan="<s:property value="subData.fieldInfo.size() + 5"/>">자료가 없습니다.</td></tr>
		</s:if>
		<s:else>
		<s:iterator value="listData" var="data">
			<tr>
				<td>${data.row_number }</td>
				<td class="tooltip"><a href="show?id_complete=${id_complete }&amp;id_medi=${id_medi }&amp;contents=${contentsCode }" class="medi-user-patient" title=" ">${data.user_name }</a>
				<input type="hidden" class="id_user" value="${id_user }"/>
                <!--{id}<br/>{name}({gender_kor}) {date_birth} <br/>{phone_mobi} -->
                <span class="tooltipView" style="display : none"></span>
                </td>
				<s:iterator value="subData.fieldInfo" var="field">
				<td><s:if test="(#data[#field.field_column] == '') || (#data[#field.field_column] == null)">
                        아니오
                    </s:if>
				    <s:else>
				        <s:property value="#data[#field.field_column]"/>
				    </s:else>
				</td>
				</s:iterator>
				<td>${data.date_complete_fmt }</td>
				<td>${data.writer_name }</td>
				<td>${data.approver_name }</td>
			</tr>
		</s:iterator>
		</s:else>
	</tbody>
</table>
</fieldset>


<div class="footer board">
	<div class="buttons">
	   <s:if test="(auth.isGroupStaff == true) || (auth.isNurse == true)">
	       <a href="#" class="openExcelDown artn-button board">엑셀 다운</a>
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
    <div id="dialog_excel" title="확인" data-width="200" data-height="196" data-modal="true">
        <p>출력할 년도/월 을 선택하세요.</p>
        <a:selectbox id="excelYear" min="${todayYear - 10 }" max="${todayYear }" />년도 &nbsp;
        <a:selectbox id="excelMonth" min="1" max="12"/>월
        <a href="#" data-url="/attdResult/excel?action=physics&id_medi=${listData[0].id_medi }" class="excelDown artn-button">출력</a><a href="#" class="excelCancel artn-button">취소</a>
    </div>
</div>

</div>
</div>

</a:html>