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

<article class="board-edit">
	
	<form action="${actionURI}" method="post" class="break_enter" enctype="multipart/form-data">
	<s:if test='%{id != null}'><input type="hidden" name="id" value="${id}"/></s:if>
	<input type="hidden" name="board_type" value="${board_type }"/>
	
	<s:if test='%{board_type == "B"}'>
		<input type="hidden" name="category" value="후기"/><!-- 자료실 -->
	</s:if>
	
	<s:if test='%{board_type == "C"}'>
		<input type="hidden" name="category" value="문의"/><!-- 묻고 답하기 -->
	</s:if>
	
	<s:if test='%{board_type == "D"}'>
		<input type="hidden" name="category" value="FAQ"/><!-- FAQ -->
	</s:if>
	
	<s:if test='%{board_type == "J"}'>
        <input type="hidden" name="category" value="후기"/><!-- FAQ -->
    </s:if>
	<s:if test='%{view_cnt != null}'>
	<input type="hidden" name="view_cnt" value="${view_cnt }"/>
	</s:if>
	<s:else>
	<input type="hidden" name="view_cnt" value="0"/>
	</s:else>
<s:if test='%{board == true}'>
	<table>
		<s:if test='%{board_type == "A"}'><!-- 공지사항 -->
		<tr>		
			<th><label>구분</label></th>
			<td>			
				<select name="category">
					<option value="사업공고">사업공고</option>
					<option value="행사안내">행사안내</option>
					<option value="기타">기타</option>
				</select>			
			</td>			
		</tr>
		</s:if>	
		<tr>
			<th><label>작성자</label></th>
			<td>
			<s:if test='%{name == null}'>
			<input type="text" name="uploader" value="${showData.uploader}"/>
            </s:if>
			<s:else>
			<input type="text" name="uploader" value="${session.user.name}" readonly="readonly"/>
			</s:else>
			</td>
		</tr>
		<tr>
			<th><label>제목</label></th>
			<td><input type="text" name="subject" value="${showData.subject}"/></td>
		</tr>
		<tr>
		    <th><label>내용</label></th>
			<td colspan="2"><textarea name="content">${showData.content}</textarea></td>
		</tr>
		
		<!-- 파일 업로드 부분 -->
		<s:if test='%{params.board_type == "B"}'><!-- 자료실 -->
		<tr>
		    <th><label>파일</label></th>
            <td>
               	<s:file id="file_upload" name="file_upload" value="%{showData.file_upload}" theme="simple"/>
               	<s:if test="%{showData.file_upload != ''}">
           		<span class="filename">현재 첨부 </span> <a href="/upload/file/${showData.file_upload}" class="file-attach">&#160;<s:property value="showData.file_upload"/></a>
           		</s:if>
            </td>
		</tr>
		</s:if>		
			
	</table>
</s:if>
<s:else>
	<table>
		<tr>
			<th><label>작성자</label></th>
			<td colspan="2"><input type="text" name="uploader" value="${showData.uploader}"/></td>	
		</tr>
		<tr>
			<th><label>제목</label></th>
			<td colspan="2"><input type="text" name="subject" value="${showData.subject}"/></td>
		</tr>
		<tr>
		    <th><label>내용</label></th>
			<td colspan="2"><textarea name="content">${showData.content}</textarea></td>
		</tr>

		<tr>
		    <th><label>이미지 파일</label></th>
		    <td>
		        <s:if test="%{showData.file_image != ''}"><img src="/upload/image/${showData.file_image}" alt="이미지" width="85" /></s:if>
                <s:else><img src="/media/thumb/none.png" alt="썸네일" width="85" /></s:else>
            </td>
            <td>
               	<s:file id="file_image" name="file_image" value="%{showData.file_image}" theme="simple"/>
               	<s:if test="%{showData.file_image != ''}">
           		<span class="filename">현재 첨부 </span> <a href="/upload/image/${showData.file_image}" class="file-attach">&#160;<s:property value="showData.file_image"/></a>
           		</s:if>
            </td>
		</tr>
	</table>
</s:else>	
		 
		<div class="buttons">
			<s:hidden type="hidden" name="date_upload" value="%{showData.date_upload}"/>
			<input type="submit" class="artn-button board" value="작성 완료"/>
			<a href="list.action?board_type=${board_type}" class="artn-button board">취소</a>
		</div> 
		 
		</form>
		</article>
	</section>
</div>
<s:include value="/include/footer.htmlpart"></s:include>
