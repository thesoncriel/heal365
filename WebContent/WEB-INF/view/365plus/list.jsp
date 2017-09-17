<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title="365PLUS 관리"contents="${contentsCode }">
<div class="header">
    <h1>365PLUS 관리</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div> 
<div class="section">
    <div class="article">    	
           	<s:include value="/WEB-INF/include/search/comb.jsp">
    		<s:param name="actionURI" value="actionURI"></s:param>
    	</s:include>
    	<table class="board-list img">
            <thead>
                <tr>
                	<th class="row-num">번호</th>                    
                    <th colspan="2">제목</th>
                    <th>업무구분</th>
                    <th>대분류</th>
                    <th>중분류</th>
                    <th>소분류</th>
                    <th>중증도</th>
                    <th class="date">등록일시</th>
                    <th class="view-cnt">조회수</th>
                </tr>
            </thead>
            <tbody>
            	<s:iterator value="listData">
                <tr>
                	<td><s:property value="row_number"/></td>
                    <td><s:if test='%{file_img == "" || file_img == null}'><img src="/img/Heal365-logo-mini.png" alt="썸네일" height="35" /></s:if>
                    	<s:else><a href="/365plus/player.jsp?id=${id}&menu=${param.menu}&depth=list"><img src="/media/img/${file_img}" alt="썸네일" height="35" /></a></s:else></td>
                    <td><a href="edit.action?id=${id}&menu=${param.menu}&contents=${contentsCode }"><s:property value="subject"/></a><!-- <br/><xsl:value-of select="subject_movie"/> --></td>
                    <td><s:property value="cate_movie0"/></td>
                    <td><s:property value="cate_movie1"/></td>
                    <td><s:property value="cate_movie2"/></td>
                    <td><s:property value="cate_movie3"/></td>
                    <td><s:property value="vas_high"/></td>
                    <td><s:property value="date_upload"/></td>
                    <td><s:property value="use_cnt"/></td>
                </tr>
                </s:iterator>
                <s:if test="%{rowCount == 0}">
    				<tr><td colspan="8">자료가 없습니다.</td></tr>
    			</s:if>
            </tbody>
        </table>
        <div class="footer board">
            <div class="buttons">
		        <a class="artn-button board" href="edit.action?contents=${contentsCode }">추가</a>
	        </div>
		    <a:pagenav page="${param.page }" params="${params}" rowCount="${rowCount }" rowLimit="10" navCount="10" id="pagecontroller" cssClass="page-controller" font="symbol" />		    	
       	</div>

    </div>
</div>
</a:html>