<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:include value="/include/header.jsp"></s:include>
<div class="contents">

<jsp:include page="/include/leftmenu/11.htmlpart" flush="true" />
<section>
<s:if test = '%{service_type == "A"}'>
       <header>
            <h1>제품주문 내용</h1>
            <span class="navigation-url">
                <span class="artn-icon-16 home"></span>
                <a href="#">HOME</a>
                <span class="artn-icon-16 caret-thin-e">&gt;</span>
                <a href="#">관리자 메뉴</a>  
                <span class="artn-icon-16 caret-thin-e">&gt;</span>
                <a href="#">제품주문 리스트</a>                      
                <span class="artn-icon-16 caret-thin-e">&gt;</span>
                <a href="#">제품주문 내용</a>
            </span>
        </header>
</s:if>
<s:elseif test = '%{service_type == "B"}'>
	<header>
        <h1>상담 내용</h1>
        <span class="navigation-url">
            <span class="artn-icon-16 home"></span>
                <a href="#">HOME</a>
                <span class="artn-icon-16 caret-thin-e">&gt;</span>
                <a href="#">관리자 메뉴</a>  
                <span class="artn-icon-16 caret-thin-e">&gt;</span>
                <a href="#">상담 리스트</a>                      
                <span class="artn-icon-16 caret-thin-e">&gt;</span>
                <a href="#">상담 내용</a>
        </span>
    </header>
	</s:elseif>

<article class="service-board">
	<table class="artn-service list"> 
		<tbody>
		    <tr>
                <th><label>회사명</label></th>
                <td><span>${showData.group_name}</span></td>
            </tr>
            <tr>
                <th><label>고객명</label></th>
                <td><span>${showData.name}</span></td>
            </tr>
            <tr>
                <th><label>연락처</label></th>
                <td><span>${showData.phone}</span></td>
            </tr>

            <tr>
                <th><label>이메일 주소</label></th>
                <td><span>${showData.email}</span></td>
            </tr>
            <tr>
                <th><label>홈페이지</label></th>
                <td><span>${showData.url}</span></td>
            </tr>
            <tr>
                <th><label>작성 일자</label></th>
                <td><span>${showData.date_upload}</span></td>
            </tr>
            <s:hidden name = "service_type" value="%{showData.service_type}"/>
            <tr>
                <th><label>문의 제목</label></th>
                <td><span>${showData.subject}</span></td>
            </tr>
            <tr>
                <th colspan="2"><label>문의 내용</label></th>
                
            </tr>
            <tr>
                <td colspan="2">${showData.content}</td>
            </tr>
		</tbody>
	</table>
		<div class="buttons">
		    <!--<s:if test="%{#session.user.name == showData.uploader}">
			<span class="artn-button board"><a href="edit.action?id=${showData.id}&board_type=${showData.board_type}">수정</a></span>
			</s:if>-->
			<a href="list.action?service_type=${showData.service_type}" class="artn-button board">목록</a>
		</div>
      </article>

    </section>

</div>     
<s:include value="/include/footer.htmlpart"></s:include>
