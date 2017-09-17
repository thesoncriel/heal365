<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:include value="/include/header.jsp"></s:include>
<div class="contents">
    <jsp:include page="/include/leftmenu/11.htmlpart" flush="true"/>
    
<section>
    <s:if test = '%{service_type == "A"}'>
	   <header>
            <h1>제품주문 리스트</h1>
            <span class="navigation-url">
                <span class="artn-icon-16 home"></span>
                <a href="#">HOME</a>
                <span class="artn-icon-16 caret-thin-e">&gt;</span>
                <a href="#">관리자 메뉴</a>  
                <span class="artn-icon-16 caret-thin-e">&gt;</span>
                <a href="#">제품주문하기</a>                      
            </span>
        </header>
	</s:if>
	<s:elseif test = '%{service_type == "B"}'>
	<header>
        <h1>상담 리스트</h1>
        <span class="navigation-url">
            <span class="artn-icon-16 home"></span>
            <a href="#">HOME</a>
            <span class="artn-icon-16 caret-thin-e">&gt;</span>
            <a href="#">관리자 메뉴</a>  
            <span class="artn-icon-16 caret-thin-e">&gt;</span>
            <a href="#">상담 리스트</a>                    
        </span>
    </header>
	</s:elseif>
        <article class="user-list">            
			<table class="artn-board list">
				<thead>
				    <tr>
				    	<th>번호</th>
				        <th>회사명</th>
				        <th>고객명</th>                 
				        <th>문의제목</th>
				        <th>연락처</th>
				        <th>작성일자</th>				        
				    </tr>
				</thead>
				<tbody>
				    <s:iterator value="ListData">
				        <tr>
				        	<td>${row_number}</td>
				        	<td>${group_name}</td>
				        	<td>${name}</td>
				            <td><a href="show.action?id=${id}&service_type=${service_type}">${subject}</a></td>
				            <td>${phone}</td>                    
				            <td>${date_upload}</td>				            
				        </tr>
				    </s:iterator>
				    <s:if test='%{rowCount == 0}'>
                        <tr><td colspan="19">자료가 없습니다.</td></tr>                    
                    </s:if>
				</tbody>
		    </table>
                <footer class="board">	                
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
