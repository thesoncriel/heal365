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
            <h2>건강 정보</h2>
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
        <article class="board-list">
            <!-- 일반 게시판 시작 -->
            <s:if test='%{board_type == "D"}'>
                <table class="artn-board list"> 
                    <thead>
                        <tr>
                            <th class="rnum">번호</th>
                            <th>제목</th>
                            <th class="date">등록일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <s:iterator value="ListData">
                            <tr>
                                <td>${row_number}</td>                  
                                <td><a href="show.action?id=${id}&board_type=${board_type}">${subject}</td>
                                <td>${date_upload}</td>
                            </tr>
                        </s:iterator>
                        <s:if test='%{rowCount == 0}'>
                            <tr><td colspan="19">자료가 없습니다.</td></tr>                    
                        </s:if>
                    </tbody>
                </table>
            </s:if>
            <s:elseif test='%{board_type == "C" || board_type == "I" || board_type == "J"}'>
            <table class="artn-board list type1"> 
                    <thead>
                        <tr>
                            <s:if test='%{board_type != "C" && board_type != "J"}'>
                            <th>번호</th>
                            </s:if>
                            <s:if test='%{board_type != "I"}'>
                            <th>구분</th>
                            </s:if>
                            <th>제목</th>
                            <th>글쓴이</th>
                            <th>등록일</th>
                            <s:if test='%{board_type == "I" || board_type == "C" || board_type == "J" }'>
                            <th>조회수</th>
                            </s:if>
                        </tr>
                    </thead>
                    <tbody>
                        <s:iterator value="ListData">
                            <tr>
                                <s:if test='%{board_type != "C" && board_type != "J"}'>
                                <td>${row_number}</td>
                                </s:if>
                                <s:if test='%{board_type != "I"}'>
                                <td>${category}</td>
                                </s:if>
                                <td><a href="show.action?id=${id}&board_type=${board_type}&view_cnt=${view_cnt}">${subject}</td>
                                <td>${uploader}</td>
                                <td>${date_upload}</td>
                                <s:if test='%{board_type == "I" || board_type == "C" || board_type == "J" }'>
                                <td>${view_cnt}</td>
                                </s:if>
                            </tr>
                        </s:iterator>
                        <s:if test='%{rowCount == 0}'>
                            <tr><td colspan="19">자료가 없습니다.</td></tr>                    
                        </s:if>
                    </tbody>
                </table>
            </s:elseif>
            <s:elseif test='%{board == true}'>
                <table class="artn-board list"> 
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>구분</th>
                            <th>제목</th>
                            <th>글쓴이</th>
                            <th>등록일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <s:iterator value="ListData">
                            <tr>
	                            <td>${row_number}</td>
	                            <td>${category}</td>
	                            <td><a href="show.action?id=${id}&board_type=${board_type}&view_cnt=${view_cnt}">${subject}</td>
	                            <td>${uploader}</td>
	                            <td>${date_upload}</td>
                            </tr>
                        </s:iterator>
                        <s:if test='%{rowCount == 0}'>
                            <tr><td colspan="19">자료가 없습니다.</td></tr>                    
                        </s:if>
                    </tbody>
                </table>
                </s:elseif>
                <!-- 일반 게시판 끝 -->
                
                <!-- 이미지 게시판 시작 -->
                <s:else>        
                    <table class="artn-board list">
                        <thead>
                            <tr>
                                <th>사진</th>
                                <th>제목/내용</th>
                            </tr> 
                        </thead>
                        <tbody>
                        <s:iterator value="ListData">
                            <tr>
                                <td><img src="/upload/image/${file_image}" alt="이미지" width="85"/></td>
                                <td><a href="show.action?id=${id}&board_type=${board_type}"><span class="subject">${subject}</span><p>${content}</p></a></td>
                            </tr>
                        </s:iterator>
                        <s:if test='%{rowCount == 0}'>
                            <tr><td colspan="19">자료가 없습니다.</td></tr>                    
                        </s:if>
                        </tbody>                
                    </table>        
                </s:else>
                <!-- 이미지 게시판 끝 -->
                
                <footer class="board">
                	<s:if test="auth.isAdmin">
	                <div class="buttons">
	                	<a href="edit.action?board_type=${params.board_type}" class="artn-button board">추가</a>
	               	</div>
	               	</s:if>
	                <!-- 페이지 컨트롤러 시작 -->
	                <div class="page-controller">
	                    <s:property value="pageController" escapeHtml="false"/> 
	                </div>
	                <!-- 페이지 컨트롤러 끝 -->
	                <div>
					<s:include value="/include/search/board.jsp"></s:include>
					</div>
                </footer>
        </article>
    </section>
</div>

<s:include value="/include/footer.htmlpart"></s:include>
