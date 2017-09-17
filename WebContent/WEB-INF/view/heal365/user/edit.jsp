<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:include value="/include/header.jsp"></s:include>

<div class="contents">
    <s:if test="auth.isMediStaff && (showIsNull ==  true)">
    <s:include value="/include/leftmenu/8.htmlpart"></s:include>
    <section>
            <header> 
                <h1>회원정보 추가 가입</h1>
                <span class="navigation-url">
                    <span class="artn-icon-16 home"></span>
                    <a href="#">HOME</a>
                    <span class="artn-icon-16 caret-thin-e">&gt;</span>
                    <a href="#">회원 추가 가입</a>                     
                </span>
            </header>
        <article class="member-join step2">
    </s:if>
    <s:else>
       <s:include value="/include/leftmenu/6.htmlpart"></s:include>
          <section>
            <header> 
                <h1>회원정보 수정</h1>
                <span class="navigation-url">
                    <span class="artn-icon-16 home"></span>
                    <a href="#">HOME</a>
                    <span class="artn-icon-16 caret-thin-e">&gt;</span>
                    <a href="#">회원정보</a>                     
                    <span class="artn-icon-16 caret-thin-e">&gt;</span>
                    <a href="#">회원정보 수정</a>                     
                </span>
            </header>
        <article class="member-join step2">
             
    </s:else>
            <p>* 필수 입력 사항입니다.</p>
            <form id="joinForm" action="${actionURI}" class="break_enter" method="POST" enctype="multipart/form-data">
            <table>
                <s:if test='%{auth.isMediStaff}'>
                    <tr>
                        <th><label for="file_img">사진</label></th>
                        <td>
                        <s:if test="%{showData.file_img != ''}">
                        <img src="/upload/user/img/${showData.file_img}" alt="이미지" width="100" height="100"/>
                        </s:if>
                        <s:else><img src="/media/thumb/none.png" alt="썸네일" width="100" height="100"/></s:else></br>
                        <s:file id="file_img" name="file_img" value="%{showData.file_img}" theme="simple"/>
                        </td>
                    </tr>
                </s:if>
                <tr>
                <s:if test="%{showData == null}">
                    <th><label for="id">* 아이디</label></th>
                    <td><s:textfield name="id" theme="simple" value="%{showData.id}"/>
                        <input type="button" value="중복 체크" id="id_check"/>
                        <strong id="idtext"></strong>
                        <input name="id_result" type="hidden" id="id_result" value=""/>
                    </td>
                </s:if>
                <s:else>            
                    <s:hidden name="id" theme="simple" value="%{showData.id}"/>
                </s:else>
                </tr>
                <tr>
                    <th><label for="name">* 이름 </label></th>
                    <td>
                    <s:if test="%{showData == null}"><s:textfield name="name" theme="simple" value="%{showData.name}"/>
                        <strong id="nametext"></strong>
                    </s:if>
                    <s:else>
                    <span name="name">${showData.name}</span>
                    <input type ="hidden" name="name" value="${showData.name}"/>
                    </s:else>
                    </td>   
                </tr>
                <s:if test="(auth.isMediStaff && (showIsNull == true)) || auth.isUser || auth.isPatient">
                <tr>
                    <th><label for="pw">* 비밀번호</label></th>
                    <td>
                        <s:textfield type="password" name="pw" theme="simple" value="%{showData.pw}"/>
                        <strong id="pwtext"></strong>
                    </td>
                </tr>
                <tr>
                    <th><label for="re_pw">* 비밀번호 재확인</label></th>
                    <td><s:textfield type="password" name="re_pw" theme="simple" value=""/>
                        <strong id="re_pwtext"></strong>
                    </td>
                </tr>
                </s:if>
                <s:else>
                <input type="hidden" name="pw" value="${showData.pw }"/>
                </s:else>
                <tr>
                    <th><label for="gender">성별</label></th>
                    <td>
                        <s:if test='%{showIsNull == true}'>
                            <s:radio name="gender" list="#{'m':'남자','w':'여자'}" value='%{"m"}' theme="simple" />
                        </s:if>
                        <s:else>
                            <%-- <s:radio name="gender" list="#{'m':'남자','w':'여자'}" value='%{showData.gender}' theme="simple" /> --%>
                            <span name="gender">${showData.gender_kor}</span>
                            <input type="hidden" name="gender" value="${showData.gender}"/>
                        </s:else>
                    </td>
                </tr>   
                <tr>
                <th><label for="email">이메일</label></th>
                    <td><s:textfield name="email" theme="simple" value='%{showData.email1}'/>@
                    <s:if test='%{showIsNull == true}'>
                    <s:textfield name="email" id="emailSub" theme="simple" value="naver.com" readonly="true" />
                    </s:if>
                    <s:else>
                    <s:textfield name="email" id="emailSub" theme="simple" value='%{showData.email2}' readonly="true" />
                    </s:else>
                    <s:select name="emailSub" theme="simple" list="#{'naver.com':'naver.com', 'hanmail.net':'hanmail.net', 'google.com':'google.com', 'nate.com':'nate.com', 'empas.com':'empas.com', 'lycos.co.kr':'lycos.co.kr', 'netsgo.com':'netsgo.com', 'empal.com':'empal.com', 'yahoo.co.kr':'yahoo.co.kr', 'hotmail.com':'hotmail.com', 'paran.com':'paran.com', 'dreamwiz.com':'dreamwiz.com', ' ':'직접입력'}" value='%{showData.email2}'/>
                    </br><strong id="emailtext"></strong></td>
                </tr>
                <tr>
                    <th><label for="phone_home">집전화</label></th>
                    <td><s:select name="phone_home" theme="simple" list="#{'02':'02', '031':'031', '032':'032', '033':'033', '041':'041', '042':'042', '043':'043', '044':'044', '051':'051', '052':'052', '053':'053', '054':'054', '055':'055', '061':'061', '062':'062', '063':'063', '064':'064', '070':'070', '010':'010', '011':'011', '016':'016', '017':'017', '018':'018', '019':'019'}" value="%{showData.phone_home1}"/>
                    -<s:textfield name="phone_home" theme="simple" value='%{showData.phone_home2}'/>-<s:textfield name="phone_home" theme="simple" value="%{showData.phone_home3}"/>
                    <strong class="phonetext"></strong><br/>
                    <span>※ 집 전화번호가 없을 시 휴대폰번호와 동일하게 입력해 주세요.</span></td>
                </tr>
                <tr>
                    <th><label for="phone_corp">회사전화</label></th>
                    <td><s:select name="phone_corp" theme="simple" list="#{' ':'없음','02':'02', '031':'031', '032':'032', '033':'033', '041':'041', '042':'042', '043':'043', '044':'044', '051':'051', '052':'052', '053':'053', '054':'054', '055':'055', '061':'061', '062':'062', '063':'063', '064':'064'}" value="%{showData.phone_corp1}"/>
                    -<s:textfield name="phone_corp" theme="simple" value='%{showData.phone_corp2}'/>-<s:textfield name="phone_corp" theme="simple" value="%{showData.phone_corp3}"/>
                    <strong class="phonetext"></strong></td>
                </tr>
                <tr>        
                    <th><label for="phone_mobi">* 핸드폰</label></th>
                    <td><s:select name="phone_mobi" theme="simple" list="#{'010':'010', '011':'011', '016':'016', '017':'017', '018':'018', '019':'019'}" value="%{showData.phone_mobi1}"/>
                    -<s:textfield name="phone_mobi" theme="simple" value='%{showData.phone_mobi2}'/>-<s:textfield name="phone_mobi" theme="simple" value="%{showData.phone_mobi3}"/>
                    <strong class="phonetext"></strong></td>
                </tr>               
                <tr>
                    <th><label for="date_birth">* 생년월일</label></th>
                    <td>
                    <s:if test="%{showData == null}">
                    <input type="text" name="date_birth" value="${showData.date_birth}" id="datepicker_old" data-year="1930" />
                    </s:if>
                    <s:else>
                    <span>${showData.date_birth }</span>
                    <input type="hidden" name="date_birth" value="${showData.date_birth}" />
                    </s:else>
                    <s:hidden name="date_join" theme="simple" value='%{showData.date_join}'/></td>
                </tr>
                <s:if test='%{auth.isAdmin}'>
                <tr>
                    <th><label for="auth_type">회원 권한</label></th>
                    <td><s:include value="/include/combobox-data/user.jsp">
                            <s:param name="cmb">auth_type</s:param>
                            <s:param name="val">${showData.auth_type}</s:param>
                        </s:include>
                         <%-- <s:select theme="simple" name="auth_type" list="#{'A':'관리자','a':'관계자','d':'의사','t':'운동치료사','p':'환자고객','c':'일반고객'}" value="1" /> --%>
                    </td>
                </tr>
                </s:if>
                <s:elseif test="%{auth.isMediStaff && showData.auth_type > '262144'}">
                        <s:hidden name="auth_type" value="262144"/>
                </s:elseif>
                <s:elseif test="%{auth.isMediStaff}">
                <tr>
                    <th><label for="auth_type">회원 권한</label></th>
                    <td><s:include value="/include/combobox-data/user.jsp">
                            <s:param name="cmb">auth_type_medistaff</s:param>
                            <s:param name="val">${showData.auth_type}</s:param>
                        </s:include>
                         <%-- <s:select theme="simple" name="auth_type" list="#{'A':'관리자','a':'관계자','d':'의사','t':'운동치료사','p':'환자고객','c':'일반고객'}" value="1" /> --%>
                    </td>
                </tr>
                </s:elseif>
                <s:else>
                        <s:hidden name="auth_type" value="131072"/>
                </s:else>
                <%-- <s:if test="auth.isAdmin || (auth.isMediStaff && (showData.auth_type <= '262144') ) || auth.isUser || auth.isPatient"> --%>
                <tr>
                	<th><label for="id_medi">의료기관(환자)</label></th>
                	<td>
                		<s:select list="%{showSubData}" id="id_medi" name="id_medi" value="showData.id_medi" listKey="id" listValue="name" theme="simple"/>
                	</td>
                </tr>
                <%-- </s:if>
                <s:elseif test="%{auth.isMediStaff}">
                        <s:hidden name="id_medi" value="%{showData.id_medi}"/>
                </s:elseif>
                <s:else>
                        <s:hidden name="id_medi" value="0"/>
                </s:else> --%>
                <!-- <tr>
                    <th>병원명</th> 프로토타입용 컨텐츠 나중에 빼야할 것 
                    <td><s:textfield name="name_medi" theme="simple" value="%{showData.medi}"/></td>
                </tr>
                <tr>
                    <th>병원코드:</th>
                    <td><s:textfield name="id_medi" theme="simple" value="%{showData.id_medi}"/></td>
                </tr>
                <tr>
                    <th>회사 코드</th>
                    <td><s:textfield name="group_id" theme="simple" value="%{showData.group_id}"/></td>
                </tr>
                     -->
                <s:if test="auth.isAdmin || (auth.isMediStaff && (showData.auth_type > '262144') )">
                <tr>
                    <th><label for="group_name">근무 회사, 병원</label></th>
                    <td>
                        <s:action name="companyList" namespace="/group" executeResult="true">
                            <s:param name="val">${showData.group_id}</s:param>
                        </s:action>
                        <s:if test='%{showIsNull == true}'>
                            <input type="text" name="group_name"/>
                        </s:if>
                        <s:else>
                            <input type="text" name="group_name" value="${showData.group_name}" readonly="readonly"/>
                        </s:else>
                    </td>
                </tr>
                </s:if>
                <s:if test="%{auth.isMediStaff}">
                <%--
                <tr>
                    <th><label for="group_name">회사명</label></th>
                    <td><input type="text" name="group_name" value="${showData.group_name }"/></td>
                </tr>
                 --%>
                <tr>
                    <th><label for="group_dept">부서명</label></th>
                    <td><s:textfield name="group_dept" theme="simple" value='%{showData.group_dept}'/></td>
                </tr>
                <s:if test="%{auth.isAdmin || (showData.auth_type > 262144) }">
                <tr>
                    <th><label for="comment">진료분야</label></th>
                    <td><textarea name="comment">${showData.comment}</textarea></td>
                </tr>
                </s:if>
                <tr>
                    <th><label for="zipcode_corp">회사 주소</label></th>
                    <td>
                        <input type="text" name="zipcode_corp" theme="simple" readonly="readonly" value="${showData.zipcode_corp}"/><input type="button" class="_corp" value="우편번호 검색" name="search" /><br/>
                        <input type="text" name="address_corp1" theme="simple" readonly="readonly" value="${showData.address_corp1}"/><br/>
                        <input type="text" name="address_corp2" theme="simple" value="${showData.address_corp2}"/>
                    </td>
                </tr>
                </s:if>
                <tr>
                    <th><label for="zipcode_home">주소</label></th>
                    <td>
                        <input type="text" name="zipcode_home" theme="simple" readonly="readonly" value="${showData.zipcode_home}"/><input type="button" class="_home" value="우편번호 검색" name="search" /><br/>
                        <input type="text" name="address_home1" theme="simple" readonly="readonly" value="${showData.address_home1}"/><br/>
                        <input type="text" name="address_home2" theme="simple" value="${showData.address_home2}"/>
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
<div id="dialog_Zipcode" title="우편번호 찾기"  style="display: none;">
    <section>
        <article>
            <form class="zipcode-search" action="" class="artn-search">
            <label for="dong">동 입력</label><input type="text" name="dong" value="" />
            <input type="button" name="dong-search" class="artn-button board" value="검색"/>
            <input type="hidden" name="class-name"/>
            
                <table class="search-result">
                    <thead>
                    <tr>
                        <th>우편번호</th>
                        <th colspan="2">주소</th>
                    </tr>
                    </thead>
                    <tbody class="result-select">
                    </tbody>
                </table>
            </form>
        </article>
    </section>
</div>
<s:include value="/include/footer.htmlpart"></s:include>
