<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 물리치료 작성 진행 목록" contents="${contentsCode }">
<script>
$(document).ready(function(){
	$(".medi-check-complete").submit(function(){
		return confirm(
			"본 데이터 내 환자를 기준으로 최근 작성된 물리치료을 완료합니다.\r\n" +
			"(같은 항목이 여럿 발견되면 가장 최근 것을 제외한 나머지는 완료하지 않습니다.)\r\n" +
			"완료된 물리치료은 완료 목록에 추가되며 완료 목록에서 별도로 확인 가능합니다.\r\n" +
			"계속 하시겠습니까?"
			);
	});
});
</script>
<div class="header">
    <h1>물리치료 작성진행 목록</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="section">
<div class="article">
<fieldset>
<table class="board-list">
	<thead>	
		<tr>
			<th>번호</th>
			<th>환자명</th>
			<th>항목명</th>
			<th>측정수치</th>
			<th>결과</th>
			<th>작성</th>
			<th>일자</th>
			<s:if test="(auth.isGroupStaff == true) || (auth.isNurse == true)">
			<th>완료</th></s:if>
		</tr>	
	</thead>
	<tbody id="list_mediCheckProgress">
		<s:if test="listIsNull">
		<tr><td colspan="7">자료가 존재하지 않습니다.</td></tr>
		</s:if>
		<s:iterator value="listData">
			<tr>
				<td>${row_number }</td>
				<td><a href="list?user_name=${user_name }">${user_name }</a></td>
                <td><a href="list?field_name=${field_name }">${field_name }</a></td>
                <td>
                <s:if test="field_type == 0">${field_value }</s:if>
                <s:elseif test="field_type == 1">${field_result }</s:elseif></td>
                <td>
                <s:if test="field_type == 0">${field_result }</s:if>
                <s:elseif test="field_type == 1">-</s:elseif></td>
                <td>
                <s:if test="id_complete != null">완료</s:if>
                <s:else>-</s:else>
				</td>
                <td>${date_update_fmt }</td>
                <s:if test="(auth.isGroupStaff == true) || (auth.isNurse == true)">
                <td>
                <s:if test="id_complete == null">
                <form action="complete" method="post" class="medi-check-complete">
	                <%-- <button class="artn-button board" data-rule="dialogButton" data-dialog="#dialog_valueEditor">변경</button>
	                <input type="hidden" name="id" value="${id }"/>
	                <input type="hidden" name="field_value" value="${field_value }"/> --%>
	                <input type="hidden" name="id_medi" value="${id_medi }"/>
	                <input type="hidden" name="id_user" value="${id_user }"/>
	                <input type="hidden" name="medi_name" value="${medi_name }"/>
	                <input type="hidden" name="user_name" value="${user_name }"/>
	                <button type="submit" class="artn-button board">완료</button>
                </form>
                </s:if>
                </td></s:if>
			</tr>
		</s:iterator>
	</tbody>
</table>
</fieldset>


<div class="footer board">
	<div class="buttons">
	   <s:if test="(auth.isGroupStaff == true) || (auth.isNurse == true)">
	       <a href="write?contents=${params.contents }" class="artn-button board">추가 작성 하기</a>
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

<%-- 병원관계자가 값 수정할 시 쓰임. --%>
<s:if test="(auth.isGroupStaff == true) || (auth.isNurse == true)">
<div id="dialog_valueEditor">
	<h3>측정수치 변경</h3>
	<form>
	<fieldset>
	
	</fieldset>
	<button id="button_EditOK" type="submit" class="artn-button board">확인</button>
	</form>
</div>
</s:if>
</a:html>