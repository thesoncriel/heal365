<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 영상 등록 및 관리" contents="${contentsCode }">
<div class="header">
    <h1>영상 관리</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div> 
<div class="section">
    <div class="article">
    	<div>
	       	<s:include value="/WEB-INF/include/search/movie.jsp">
	    		<s:param name="actionURI" value="actionURI"></s:param>
	    	</s:include>
    	</div>
    	<table class="board-list img">
            <thead>
                <tr>
                	<th class="row-num">번호</th>
                    <th colspan="2">제목</th>                 
                    <th>대분류</th>
                    <th>중분류</th>
                    <th>소분류</th>
                    <th>중증도</th>
                    <th class="date last">등록일시</th>
                </tr>
            </thead>
            <tbody>
            	<s:iterator value="listData">
                <tr>
                	<td><s:property value="row_number"/></td>
                    <td class="img"><s:if test='%{file_img == "" || file_img == null}'><img src="/img/Heal365-logo-mini.png" alt="썸네일" height="35" /></s:if>
                    	<s:else><img src="/media/img/${file_img}" alt="썸네일" height="35" /></s:else></td>
                    <td class="subject"><a href="edit.action?id=${id}&contents=${contentsCode }"><s:property value="subject"/></a></td>
                    <td><s:property value="cate_movie1"/></td>
                    <td><s:property value="cate_movie2"/></td>
                    <td><s:property value="cate_movie3"/></td>
                    <td><s:property value="vas_high"/></td>
                    <td><s:property value="date_upload"/></td>
                </tr>
                </s:iterator>
                <s:if test="%{rowCount == 0}">
    				<tr><td colspan="7">자료가 없습니다.</td></tr>
    			</s:if>
            </tbody>
        </table>
        <div class="footer board">
            <div class="buttons">
		        <a href="write.action?contents=${contentsCode }" class="artn-button board">추가</a>
	        </div>
	    	<a:pagenav page="${param.page }" params="${params}" rowCount="${rowCount }" rowLimit="10" navCount="10" id="pagecontroller" cssClass="page-controller" font="symbol" />
       	</div>
    </div>
</div>
</a:html>