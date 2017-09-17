<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 처방전" contents="${contentsCode }">
<div class="header">
    <s:if test="isManageList">
    <h1>운동처방</h1>
    </s:if>
    <s:else>
    <h1>${user.name }님의 처방 운동 리스트</h1>
    </s:else>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>     
<div class="section">
    <div class="article">
    	<s:set var="now" value='%{util.now}'/>
<form name="deleteForm" action="delete.action">
    	<table class="board-list">
            <thead>
                <tr>
                	<s:if test="(auth.isMediStaff) || (auth.isNurse)">
                	   <s:if test="auth.isMediStaff">
                	       <th>삭제</th>
                	   </s:if>
                	<th class="row-num">번호</th>
                	<th class="name">환자명</th>
                	<th>상태</th>
                	</s:if>
                	<s:else>
                	<th class="row-num">번호</th>
                	</s:else>                	
                    <th>진단명</th>
                    <th>중증도</th>
                    <th class="date">진단일</th>
                    <th class="date">만료일</th>
                    <%--<th>수행횟수</th> --%>
                    <th>작성자</th>
                    <th class="last">영상보기</th>
                </tr>
            </thead>
            <tbody>
            	<s:iterator value="listData">
                <tr>
                    <s:if test="(auth.isMediStaff) || (auth.isNurse)">
                       <s:if test="auth.isMediStaff">
                            <td><input type="checkbox" name="id" value="${id}"/></td>
                        </s:if>
                    <td>${row_number}</td>
                    <td class="tooltip"><a href="/prescript/show?id=${id}&menu=${param.menu}&depth=show&contents=${contentsCode }" class="medi-user-patient" title=" "><s:property value="user_name"/></a>
                    <input type="hidden" class="id_user" value="${id_user }"/>
	                <!--{id}<br/>{name}({gender_kor}) {date_birth} <br/>{phone_mobi} -->
	                <span class="tooltipView" style="display : none"></span>
                    </td>
                    <td>
                    <s:if test='%{status != 100}'><a href="/prescript/edit?id=${id }" class="status${status }"><s:property value="status_kor"/></a></s:if>
                    <s:else><s:property value="status_kor"/></s:else>
                    </td>
                    </s:if>
                    <s:else>
                    	<td>${row_number}</td>
                    </s:else>
                    <td><a href="/prescript/show?id=${id}&menu=${param.menu}&depth=show&contents=${contentsCode }"><s:property value="diagnosis"/></a></td>
                    <td><s:property value="vas"/></td>
                    <td><s:property value="date_upload_fmt"/></td>
                    <td><s:property value="date_end"/></td>
                    <td><s:property value="therap_name"/></td>
                    <%--<td><s:property value="exe_count"/></td> --%>
                    <td>
                    <s:if test='%{auth.isPatient && (date_end < #now)}'>만료</s:if>
                    <s:else><a href="/player/player?id=${id_comb}&menu=${param.menu}&depth=list&contents=${contentsCode }&to_list=/prescript/list" class="browserCheck">바로가기</a></s:else>
                    </td>
                </tr>
                </s:iterator>
                <s:if test="%{rowCount == 0}">
                <s:if test="(auth.isMediStaff) || (auth.isNurse)">
                	<tr><td colspan="20">자료가 없습니다.</td></tr>
                </s:if>
                <s:else>
                	<tr><td colspan="20">자료가 없습니다.</td></tr>
                </s:else>
    			</s:if>
            </tbody>
        </table>
        
        <div class="footer board">
            <div class="buttons">
		        <s:if test='%{ isManageList && (auth.isDoctor || auth.isAdmin || auth.isTherap) }'>
		        	<a class="artn-button board" href="write.action?contents=${contentsCode }">추가</a>
		        	<!-- 처방전 삭제 기능 추가 20130702 - thkim -->		        	
			        <input class="artn-button board" type="submit" id="delete" value="삭제"/>		        	
		        </s:if>
	        </div>
		    <a:pagenav page="${param.page }" params="${params}" rowCount="${rowCount }" rowLimit="10" navCount="10" id="pagecontroller" cssClass="page-controller" font="symbol" />
       	</div>
   </form>
       	<div>
			<s:include value="/WEB-INF/include/search/prescript.jsp">
			<s:param name="actionURI" value="actionURI"></s:param>
			<s:param name="is_admin">${auth.isPatient}</s:param>
			</s:include>
    	</div>
    </div>
</div>
</a:html>