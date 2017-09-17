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
               	<a href="/index.jsp">HOME</a>
               	<span class="artn-icon-16 caret-thin-e">&gt;</span>
               	<a href="/contents.jsp?contents=sub1_1&menu=1">회사소개</a>
            	<span class="artn-icon-16 caret-thin-e">&gt;</span>
            	<a href="#">파트너</a>  
            	<span class="artn-icon-16 caret-thin-e">&gt;</span>
            	<a href="#">병원</a>                  	
           	</span>
        </header>
                <article class="group show">
					<h2><em>${showData.name}</em></h2>
					<table>
						<tbody>
							<tr>
								<th>설립일</th>
								<td>${showData.date_estab_kor} 설립</td>
							</tr>
							<tr>
                                <th>우편번호</th>
                                <td>${showData.zipcode}</td>
                            </tr>
							<tr>
								<th>주소</th>
								<td>${showData.address1}<br/>
								    ${showData.address2}</td>
							</tr>
							<tr>
								<th>TEL</th>
								<td>${showData.phone}</td>
							</tr>
							<tr>
								<th>FAX</th>
								<td>${showData.fax}</td>
							</tr>
							<tr>
								<th>업종</th>
								<td>${showData.div_group_kor}</td>
							</tr>
							<tr>
								<th>URL</th>
								<td>${showData.url}</td>
							</tr>
						</tbody> 
					</table>
			
				<img src="/upload/group/img/${showData.file_img}" class="effect frame"/>
				<iframe class="effect frame" src="${showData.url_map}" width="660" height="435" scrolling="no" frameborder="0"></iframe>
				
					<footer class="board"> 
	                	<div class="buttons">
	                	<s:if test='%{auth.isMediStaff}'>
							<a href="edit.action?id=${showData.id}" class="artn-button board">수정</a>
						</s:if>		   
							<a href="list.action" class="artn-button board">목록</a>
						</div>
					</footer>
		</article>
	</section>
</div>     
<s:include value="/include/footer.htmlpart"></s:include>
