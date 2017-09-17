<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:include value="/include/header.jsp"></s:include>
<div class="contents">
    <jsp:include page="/include/leftmenu/11.htmlpart" flush="true" />
    <section>
        <article class="user-list">
            <s:include value="/include/search/user.jsp">
                <s:param name="actionURI" value="actionURI"></s:param>
            </s:include>
            <h2>업체 회원 목록</h2>
            <table class="artn-board list">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>사용자ID</th>                        
                        <th>사용자명</th>
                        <th>그룹명</th>                        
                        <th>권한</th>
                        <th>가입일</th>
                        <th>사용자정보</th>                       
                    </tr>
                </thead>
                <tbody>
                    <s:iterator value="ListData">
                        <tr>
                            <td><s:property value="row_number"/></td>                            
                            <td><s:property value="name"/></td>                            
                            <td><s:property value="phone_mobi"/></td>                            
                            <td><s:property value="date_join"/></td>
                            <td><a href= "/user/show?id=${id}">정보보기</a></td>
                        </tr>
                    </s:iterator>
                    <s:if test="%{rowCount == 0}">
                        <tr>
                            <td colspan="19">자료가 없습니다.</td>
                        </tr>
                    </s:if>
                </tbody>
            </table>

            <footer class="board">
                <a:pagenav page="${param.page }" rowCount="${rowCount }" rowLimit="10" navCount="10" id="pagecontroller" params="${params }" />
                <s:if test='%{auth.isMediStaff}'>
                <div class="buttons">
                    <a href="write" class="artn-button board">회원 추가</a>
                </div>
                </s:if>
            </footer>



        </article>
    </section>
</div>
<s:include value="/include/footer.htmlpart"></s:include>
