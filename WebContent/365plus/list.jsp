<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html contents="sub100">
﻿<div class="header">
    <h1>365PLUS 조합 관리</h1>
    <div id="breadcrumbs" data-sub="*365PLUS,365PLUS 조합 관리"></div>
</div> 
<div class="section">
    <div class="article board-list">
    	<s:include value="/WEB-INF/include/search/comb.jsp">
    		<s:param name="actionURI" value="actionURI"></s:param>
    	</s:include>
    	<table class="artn-board list">
            <thead>
                <tr>
                    <th>영상</th>
                    <th>이름</th>
                    <th>업무구분</th>
                    <th>대분류</th>
                    <th>중분류</th>
                    <th>소분류</th>
                    <th>중증도</th>
                    <th>등록일시</th>
                </tr>
            </thead>
            <tbody>
            	<s:iterator value="listData">
                <tr>
                    <td><s:if test='%{file_img == "" || file_img == null}'><img src="/img/Heal365-logo-mini.png" alt="썸네일" height="35" /></s:if>
                    	<s:else><a href="/365plus/player.jsp?id=${id}&menu=${param.menu}&depth=list"><img src="/media/img/${file_img}" alt="썸네일" height="35" /></a></s:else></td>
                    <td><a href="edit.action?id=${id}&menu=${param.menu}"><s:property value="subject"/></a><!-- <br/><xsl:value-of select="subject_movie"/> --></td>
                    <td><s:property value="cate_movie0"/></td>
                    <td><s:property value="cate_movie1"/></td>
                    <td><s:property value="cate_movie2"/></td>
                    <td><s:property value="cate_movie3"/></td>
                    <td><s:property value="vas_high"/></td>
                    <td><s:property value="date_upload"/></td>
                </tr>
                </s:iterator>
                <s:if test="%{rowCount == 0}">
    				<tr><td colspan="8">자료가 없습니다.</td></tr>
    			</s:if>
            </tbody>
        </table>
        <div class="footer board">
            <div class="buttons">
		        <span class="artn-button board"><a href="edit.action">추가</a></span>
	        </div>
		        <div class="page-controller">
		    		<a:pagenav page="${param.page }" params="${params}" rowCount="${rowCount }" rowLimit="10" navCount="10" id="pagecontroller" />
		    	</div>
       	</div>
    </div>
</div>
</a:html>