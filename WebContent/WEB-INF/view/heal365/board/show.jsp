<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:include value="/include/header.jsp"></s:include>
<div class="contents">
<s:if test='%{board_type == "A"}'>
	<jsp:include page="/include/leftmenu/5.htmlpart" flush="true"/>
</s:if>

<s:if test='%{board_type == "B"}'>
	<jsp:include page="/include/leftmenu/5.htmlpart" flush="true"/>
</s:if>

<s:if test='%{board_type == "C"}'>
    <jsp:include page="/include/leftmenu/5.htmlpart" flush="true"/>
</s:if>

<s:if test='%{board_type == "D"}'>
	<jsp:include page="/include/leftmenu/5.htmlpart" flush="true"/>
</s:if>

<s:if test='%{board_type == "F"}'>
	<jsp:include page="/include/leftmenu/3.htmlpart" flush="true"/>
</s:if>

<s:if test='%{board_type == "G"}'>
	<jsp:include page="/include/leftmenu/3.htmlpart" flush="true"/>
</s:if>

<s:if test='%{board_type == "H"}'>
	<jsp:include page="/include/leftmenu/3.htmlpart" flush="true"/>
</s:if>

<s:if test='%{board_type == "I"}'>
    <jsp:include page="/include/leftmenu/3.htmlpart" flush="true"/>
</s:if>

<s:if test='%{board_type == "J"}'>
    <jsp:include page="/include/leftmenu/5.htmlpart" flush="true"/>
</s:if>
    <section>
        <!-- A게시판 공지사항 제목 -->
        <s:if test='%{board_type == "A"}'>
            <header>
                <h1>공지사항</h1>
                <span class="navigation-url">
                	<span class="artn-icon-16 home"></span>
                	<a href="#">HOME</a>
                	<span class="artn-icon-16 caret-thin-e">&gt;</span>
                	<a href="#">고객센터</a>  
                	<span class="artn-icon-16 caret-thin-e">&gt;</span>
                	<a href="#">공지사항</a>                  	
               	</span>
            </header>
        </s:if>
        <!-- B게시판 자료실 제목 -->
        <s:if test='%{board_type == "B"}'>
            <header>
                <h1>자료실</h1>
                <span class="navigation-url">
                	<span class="artn-icon-16 home"></span>
                	<a href="#">HOME</a>
                	<span class="artn-icon-16 caret-thin-e">&gt;</span>
                	<a href="#">고객센터</a>  
                	<span class="artn-icon-16 caret-thin-e">&gt;</span>
                	<a href="#">자료실</a>                  	
               	</span>
            </header>
        </s:if>
        <!-- C게시판 묻고 답하기 제목 -->
        <s:if test='%{board_type == "C"}'>
            <header>
                <h1>묻고 답하기</h1>
                <span class="navigation-url">
                	<span class="artn-icon-16 home"></span>
                	<a href="#">HOME</a>
                	<span class="artn-icon-16 caret-thin-e">&gt;</span>
                	<a href="#">고객센터</a>  
                	<span class="artn-icon-16 caret-thin-e">&gt;</span>
                	<a href="#">묻고 답하기</a>                  	
               	</span>
            </header>
        </s:if>
        <!-- D게시판 자료실 제목 -->
        <s:if test='%{board_type == "D"}'>
            <header>
                <h1>FAQ</h1>
                <span class="navigation-url">
                	<span class="artn-icon-16 home"></span>
                	<a href="#">HOME</a>
                	<span class="artn-icon-16 caret-thin-e">&gt;</span>
                	<a href="#">고객센터</a>  
                	<span class="artn-icon-16 caret-thin-e">&gt;</span>
                	<a href="#">FAQ</a>                  	
               	</span>
            </header>
        </s:if>
        <!-- E게시판 자료실 제목 -->
        <s:if test='%{board_type == "E"}'>
            <h1>건강 정보</h1>
        </s:if>
        <s:if test='%{board_type == "F"}'>
            <header>
                <h1>바른자세</h1>
                <span class="navigation-url">
                	<span class="artn-icon-16 home"></span>
                	<a href="#">HOME</a>
                	<span class="artn-icon-16 caret-thin-e">&gt;</span>
                	<a href="#">건강정보</a>  
                	<span class="artn-icon-16 caret-thin-e">&gt;</span>
                	<a href="#">바른자세</a>                  	
               	</span>
            </header>
        </s:if>
        <s:if test='%{board_type == "G"}'>
            <header>
                <h1>근력강화운동</h1>
                <span class="navigation-url">
                	<span class="artn-icon-16 home"></span>
                	<a href="#">HOME</a>
                	<span class="artn-icon-16 caret-thin-e">&gt;</span>
                	<a href="#">건강정보</a>  
                	<span class="artn-icon-16 caret-thin-e">&gt;</span>
                	<a href="#">근력강화운동</a>                  	
               	</span>
            </header>
        </s:if>
        <s:if test='%{board_type == "H"}'>
            <header>
                <h1>허리운동</h1>
                <span class="navigation-url">
                	<span class="artn-icon-16 home"></span>
                	<a href="#">HOME</a>
                	<span class="artn-icon-16 caret-thin-e">&gt;</span>
                	<a href="#">건강정보</a>  
                	<span class="artn-icon-16 caret-thin-e">&gt;</span>
                	<a href="#">근력강화운동</a>                  	
               	</span>
            </header>
        </s:if>
        <s:if test='%{board_type == "I"}'>
            <header>
                <h1>진단후 관리</h1>
                <span class="navigation-url">
                    <span class="artn-icon-16 home"></span>
                    <a href="#">HOME</a>
                    <span class="artn-icon-16 caret-thin-e">&gt;</span>
                    <a href="#">건강정보</a>  
                    <span class="artn-icon-16 caret-thin-e">&gt;</span>
                    <a href="#">진단후 관리</a>                    
                </span>
            </header>
        </s:if>
        <s:if test='%{board_type == "J"}'>
            <header>
                <h1>치료체험후기</h1>
                <span class="navigation-url">
                    <span class="artn-icon-16 home"></span>
                    <a href="#">HOME</a>
                    <span class="artn-icon-16 caret-thin-e">&gt;</span>
                    <a href="#">고객센터</a>  
                    <span class="artn-icon-16 caret-thin-e">&gt;</span>
                    <a href="#">치료체험후기</a>                    
                </span>
            </header>
        </s:if>
<article class="board-show">
	<table class="artn-board list"> 
		<thead>
			<tr>
				<th>제목</th>
				<th>${showData.subject}</th>
				<th>글쓴이</th>
				<th>${showData.uploader}</th>
				<th>등록일</th>
				<th>${showData.date_upload_fmt}</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<s:if test='%{board_type == "B"}'>
					<td colspan="6">첨부파일:<a href=/upload/files/${showData.file_upload}>${showData.file_upload}</a></td>
				</s:if>		
			</tr>
			<tr>
				<td colspan="6">
				<s:if test="%{showData.file_image != ''}">
				<img src="/upload/image/${showData.file_image}" alt="이미지"/>
				</s:if>
				${showData.content}</td>
			</tr>					
		</tbody>
	</table>
		<div class="buttons">
		    <s:if test="auth.isAdmin">
			<a href="edit.action?id=${showData.id}&board_type=${showData.board_type}" class="artn-button board">수정</a>
			</s:if>
			<a href="list.action?board_type=${showData.board_type}" class="artn-button board">목록</a>
		</div>
		<%--
		아이디 : <s:property value="id"/><br/>
		이름 : <s:property value="name"/><br/>
		<s:property value="count"/><br/>
		<s:property value="showResultStatus"/><br/>
		<s:a href="%{'edit.action?id=' + id}">수정</s:a>
		 --%>
                </article>

                    </section>

            </div>     
<s:include value="/include/footer.htmlpart"></s:include>
