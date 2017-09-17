<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:include value="/include/header.jsp"></s:include>
<div class="contents">
    <jsp:include page="/include/leftmenu/7.htmlpart" flush="true" />
    <section>
        <header>
            <h1>회원정보</h1>
            <span class="navigation-url">
                <span class="artn-icon-16 home"></span>
                <a href="#">HOME</a>  
                <span class="artn-icon-16 caret-thin-e">&gt;</span>
                <a href="#">회원정보</a>                    
            </span>
        </header>
        <article class="user-list">
            <table>
                <s:if test="auth.isMediStaff">
                <tr>
                    <th for="file_img">사진</th>
                        <td>
                        <s:if test="%{showData.file_img != ''}">
                        <img src="/upload/user/img/${showData.file_img}" alt="이미지" width="100" height="100"/>
                        </s:if>
                        <s:else><img src="/media/thumb/none.png" alt="썸네일" width="100" height="100"/></s:else>
                        </td>
                </tr>
                </s:if>
                <tr>
                    <th>아이디</th>
                    <td><s:property value="showData.id"/></td>
                </tr>
                <tr>
                    <th>이름</th>
                    <td><s:property value="showData.name"/></td>
                </tr>
                <tr>
                    <th>이메일</th>
                    <td><s:property value="showData.email"/></td>
                </tr>
                <tr>
                    <th>집전화</th>
                    <td><s:property value="showData.phone_home"/></td>
                </tr>
                <tr>
                    <th>회사전화</th>
                    <td><s:property value="showData.phone_corp"/></td>
                </tr>
                <tr>
                    <th>핸드폰</th>
                    <td><s:property value="showData.phone_mobi"/></td>
                </tr>
                <tr>
                    <th>생년월일</th>
                    <td><s:property value="showData.date_birth"/></td>
                </tr>
                <tr>
                    <th>수정일자</th>
                    <td><s:property value="showData.date_join"/></td>
                </tr>
                <s:if test="%{auth.isMediStaff}">
                <tr>
                    <th>관리자 권한</th>
                    <td><s:property value="showData.auth_type_kor"/></td>
                </tr>
                </s:if>
                <!-- <tr>
                    <th>병원 코드</th>
                    <td><s:property value="showData.id_medi"/></td>
                </tr>
                <tr>
                    <th>회사명</th>
                    <td><s:property value="showData.group_name"/></td>
                </tr>
                <tr>
                    <th>부서명</th>
                    <td><s:property value="showData.group_dev"/></td>
                </tr>
                <tr>
                    <th>회사 코드</th>
                    <td><s:property value="showData.group_id"/></td>
                </tr> -->
                <tr>
                    <th>우편번호</th>
                    <td><s:property value="showData.zipcode_home"/></td>
                </tr>
                <tr>
                    <th rowspan="2">주소</th>
                    <td><s:property value="showData.address_home1"/></td>
                </tr>
                <tr>
                    <td><s:property value="showData.address_home2"/></td>
                </tr>
                <tr>
                    <th>성별</th>
                    <td><s:property value="showData.gender_kor"/></td>
                </tr>
            </table>

                <footer class="board">
                    <div class="buttons">
                        <s:a href="%{'edit.action?id=' + showData.id}" class="artn-button board">수정</s:a>              
                        <s:if test='%{(#parameters.from == null) && (auth.isAdmin) }'>
                        <s:a href="%{'list.action'}" class="artn-button board">목록</s:a>
                        </s:if>
                        <s:else>
                        <a href="/${param.from }/list" class="artn-button board">목록</a>
                        </s:else>
                    </div>
                </footer>
                
                <br><br>
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
<s:include value="/include/player-footer.htmlpart"></s:include>
