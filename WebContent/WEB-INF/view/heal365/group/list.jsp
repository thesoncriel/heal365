<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:include value="/include/header.jsp"></s:include>
<div class="contents">
    <jsp:include page="/include/leftmenu/1.htmlpart" flush="true"/>
    
    
    <section>
		    <header>
		        <h1>병원</h1>
		        <span class="navigation-url">
		        	<span class="artn-icon-16 home"></span>
		        	<a href="#">HOME</a>
		        	<span class="artn-icon-16 caret-thin-e">&gt;</span>
		        	<a href="#">회사소개</a>
		        	<span class="artn-icon-16 caret-thin-e">&gt;</span>
		        	<a href="#">병원</a>                    	
		       	</span>
		    </header>
        <article class="group-list">            
			<table class="artn-board list">
				<thead>
				    <tr>
				    	<th>병원명</th>
				        <th>설립일</th>                 
				        <th>주소</th>
				        <th>TEL</th>
				        <th>FAX</th>
				        <th>업종</th>
				    </tr>
				</thead>
				<tbody>
				    <s:iterator value="ListData">
				        <tr>
				            <td><a href="show.action?id=${id}">${name}</a></td>
				            <td>${date_estab}</td>                    
				            <td>${address1}</td>
				            <td>${phone}</td>
				            <td>${fax}</td>
				            <td>${work_type}</td>
				        </tr>
				    </s:iterator>
				    <s:if test='%{rowCount == 0}'>
				        <tr><td colspan="19">자료가 없습니다.</td></tr>                    
				    </s:if>
				    </tbody>
				</table>
                <footer class="board"> 
                	<div class="buttons">   
		                <s:if test="auth.menu10"><a href="edit.action" class="artn-button board">추가</a><br/></s:if>
	                </div>
	                
	                <!-- 페이지 컨트롤러 시작 -->
	                <div class="page-controller">
	                    <s:property value="pageController" escapeHtml="false"/> 
	                </div>
	                <!-- 페이지 컨트롤러 끝 -->
	                
	                <s:include value="/include/search/group.jsp"></s:include>
                 </footer>      
        </article>
    </section>
</div>

<s:include value="/include/footer.htmlpart"></s:include>
