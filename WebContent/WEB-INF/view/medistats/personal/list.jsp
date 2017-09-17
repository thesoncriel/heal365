<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 통합 이력관리" contents="${contentsCode }">

<div class="header">
    <h1>통합 이력관리</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="section">
<div class="article">
    <table class="board-list">
	    <thead>
	        <tr>
	            <th class="row-num">번호</th>
	            <th class="name">환자명</th>
	            <th>문진 횟수</th>
	            <th>건강검진 횟수</th>
	            <th>물리치료 횟수</th>
	            <th>운동처방 횟수</th>
	            <th>가입일</th>
	        </tr>
	    </thead>
	    <tbody>
	        <s:if test="listIsNull">
	                <tr><td colspan="7">그룹사용자가 없습니다</td></tr>
	        </s:if>
	        <s:else>
	        <s:iterator value="listData">
	            <tr>
	                <td><s:property value="row_number"/></td>
	                <td class="tooltip"><a href="/medistats/personal/stats?id_user=${id_user }&id_medi=${id_group}&contents=${contentsCode }" class="medi-user-patient" title=" "><s:property value="user_name"/></a>
	                <input type="hidden" class="id_user" value="${id_user }"/>
	                <!--{id}<br/>{name}({gender_kor}) {date_birth} <br/>{phone_mobi} -->
	                <span class="tooltipView" style="display : none"></span>
                    </td>
	                <td><s:property value="question_count"/></td>
	                <td><s:property value="check_count"/></td>
	                <td><s:property value="physics_count"/></td>
	                <td><s:property value="prescript_count"/></td>
	                <td><s:property value="date_join_fmt"/></td>
	            </tr>
	        </s:iterator>
	        </s:else>
	    </tbody>
	</table>
</div>
<a:pagenav page="${param.page }" params="${params}" rowCount="${rowCount }" rowLimit="10" navCount="10" id="pagecontroller" cssClass="page-controller" font="symbol" />
<div>
<s:include value="/WEB-INF/include/search/mediStats.jsp">
</s:include>
</div>
</div>

</a:html>