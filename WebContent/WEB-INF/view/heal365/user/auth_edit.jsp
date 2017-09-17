<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:include value="/include/header.jsp"></s:include>

<div class="contents">
    <s:include value="/include/leftmenu/10.htmlpart"></s:include>
    <section>
            <header>
                <h1>회원 권한 수정</h1>
                <span class="navigation-url">
                    <span class="artn-icon-16 home"></span>
                    <a href="#">HOME</a>
                    <span class="artn-icon-16 caret-thin-e">&gt;</span>
                    <a href="#">회원 리스트</a>                     
                    <span class="artn-icon-16 caret-thin-e">&gt;</span>
                    <a href="#">회원권한 수정</a>                     
                </span>
            </header>
        <article class="member-join step2">
            <form id="editProfileForm" action="/user/modify.action?id=${param.id}" class="break_enter" method="POST" enctype="multipart/form-data">
            <table>
                <tr>
                    <th><label for="file_img">사진</label></th>
                    <td>
                    <s:if test="%{showData.file_img != ''}">
                    <img src="/upload/user/img/${showData.file_img}" alt="이미지" width="100" height="100"/>
                    </s:if>
                    <s:else><img src="/media/thumb/none.png" alt="썸네일" width="100" height="100"/></s:else>
                    <s:textfield type="hidden" id="file_img" name="file_img" value="%{showData.file_img}" theme="simple"/>
                    <br/>
                    </td>
                </tr>
                <tr>
                    <th><label for="id">아이디</label></th>
                    <td>
                    <s:property value="showData.id"/>
                    <input type="hidden" name="id" value="%{showData.id}"/>
                    <input type="hidden" name="pw" value="${showData.pw}"/></td>
                </tr>
                <tr>
                    <th><label for="name">이름 </label></th>
                    <td>
                        <s:property value="showData.name"/>
                        <input type="hidden" name="name" value="${showData.name}"/>
                    </td>   
                </tr>
                <tr>
                    <th><label for="gender">성별</label></th>
                    <td>
                        <s:property value="showData.gender_kor"/>
                        <input type="hidden" name="gender" value="${showData.gender}"/>
                    </td>
                </tr>   
                <tr>
                    <th><label for="email">이메일</label></th>
                    <td><s:property value="showData.email"/>
                    <input type="hidden" name="email" value="${showData.email}"/></td>
                </tr>
                <tr>
                    <th><label for="phone_home">집전화</label></th>
                    <td><s:property value="showData.phone_home"/>
                    <input type="hidden" name="phone_home" value="${showData.phone_home}"/></td>
                </tr>
                <tr>
                    <th><label for="phone_corp">회사전화</label></th>
                    <td><s:property value="showData.phone_corp"/>
                    <input type="hidden" name="phone_corp" value="${showData.phone_corp}"/></td>
                </tr>
                <tr>        
                    <th><label for="phone_mobi">핸드폰</label></th>
                    <td><s:property value="showData.phone_mobi"/>
                    <input type="hidden" name="phone_mobi" value="${showData.phone_mobi}"/></td>
                </tr>               
                <tr>
                    <th><label for="date_birth">생년월일</label></th>
                    <td>
                    <s:property value="showData.date_birth"/>
                    <input type="hidden" name="date_birth" value="${showData.date_birth}"/>
                    <s:hidden name="date_join" theme="simple" value='%{showData.date_join}'/></td>
                </tr>
                <tr>
                    <th><label for="auth_type">관리자 권한</label></th>
                    <td><s:include value="/include/combobox-data/user.jsp">
                            <s:param name="cmb">auth_type</s:param>
                            <s:param name="val">${showData.auth_type}</s:param>
                        </s:include>
                         <%-- <s:select theme="simple" name="auth_type" list="#{'A':'관리자','a':'관계자','d':'의사','t':'운동치료사','p':'환자고객','c':'일반고객'}" value="1" /> --%>
                    </td>
                </tr>
                <tr>
                    <th>관리 병원</th>
                    <td><s:select theme="simple" name="id_medi" list="#{'0':'미지정','1':'더 본병원'}" value="%{showData.id_medi}" /></td>
                </tr>
                <!-- <tr>
                    <th>병원명</th> 프로토타입용 컨텐츠 나중에 빼야할 것 
                    <td><s:textfield name="name_medi" theme="simple" value="%{showData.medi}"/></td>
                </tr>
                <tr>
                    <th>회사 코드</th>
                    <td><s:textfield name="group_id" theme="simple" value="%{showData.group_id}"/></td>
                </tr>
                     -->
                
                <tr>
                    <th><label for="group_name">회사명</label></th>
                    <td>
	                    <s:property value="showData.group_name"/>
	                    <input type="hidden" name="group_name" value="${showData.group_name}"/>
	                    <s:hidden name="group_id" theme="simple" value="%{showData.group_id}"/>
                    </td>
                </tr>
                <tr>
                    <th><label for="group_dept">부서명</label></th>
                    <td>
                    <s:property value="showData.group_dept"/>
                    <input type="hidden" name="group_dept" value="${showData.group_dept}"/></td>
                </tr>
                <s:if test="%{auth.isMediStaff}">
                <tr>
                    <th><label for="comment">진료분야</label></th>
                    <td><textarea name="comment" readonly="true"></textarea></td>
                </tr>
                </s:if>
                <tr>
                    <th><label for="zipcode_corp">회사 주소</label></th>
                    <td>
                        <s:property value="showData.zipcode_corp"/><br>
                        <s:property value="showData.address_corp1"/><br>
                        <s:property value="showData.address_corp2"/>
                        <input type="hidden" name="zipcode_corp" value="${showData.zipcode_corp}"/>
                        <input type="hidden" name="address_corp1" value="${showData.address_corp1}"/>
                        <input type="hidden" name="address_corp2" value="${showData.address_corp2}"/>
                    </td>
                </tr>
                <tr>
                    <th><label for="zipcode_home">주소</label></th>
                    <td>
                        <s:property value="showData.zipcode_home"/><br>
                        <s:property value="showData.address_home1"/><br>
                        <s:property value="showData.address_home2"/>
                        <input type="hidden" name="zipcode_home" value="${showData.zipcode_home}"/>
                        <input type="hidden" name="address_home1" value="${showData.address_home1}"/>
                        <input type="hidden" name="address_home2" value="${showData.address_home2}"/>
                    </td>
                </tr>
                    <!--<s:textfield name="gender" theme="simple" value="%{showData.gender}"/>-->
                </table>
                    <footer>                 
                        <div class="buttons">
                            <s:hidden name="jumin" theme="simple" value=" "/>
                            <input type="submit" class="artn-button board" value="확인"/>
                            <a href="/index.jsp" class="artn-button board">취소</a>
                        </div>  
                    </footer>
            </form> 
        </article>
    </section>
</div>
<s:include value="/include/footer.htmlpart"></s:include>
