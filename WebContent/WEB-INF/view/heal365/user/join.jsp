<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:include value="/include/header.jsp"></s:include>

<div class="contents">

       <s:include value="/include/leftmenu/6.htmlpart"></s:include>
       <section>
            <header>
                <h1>회원가입</h1>
                <span class="navigation-url">
                    <span class="artn-icon-16 home"></span>
                    <a href="#">HOME</a>  
                    <span class="artn-icon-16 caret-thin-e">&gt;</span>
                    <a href="#">회원가입</a>                    
                </span>
            </header>
        <article class="member-join step2">
            <hgroup class="artn-bg-64 step3">
                 <h2>1. 약관동의/회원선택</h2>
                 <h2 class="selected">2. 회원정보 입력</h2>
                 <h2>3. 가입완료</h2>
            </hgroup> 
            <p>* 필수 입력 사항입니다.</p>
            <form id="joinForm" action="${actionURI}" class="break_enter" method="POST" enctype="multipart/form-data">
            <table>
                <tr>
               		<th><label for="id">* 아이디</label></th>
                    <td><s:textfield name="id" theme="simple" value="%{showData.id}"/>
                        <input type="button" value="중복 체크" id="id_check"/>
                        <strong id="idtext"></strong>
                        <input name="id_result" type="hidden" id="id_result" value=""/>
                    </td>
                </tr>
                <tr>
                    <th><label for="name">* 이름 </label></th>
                    <td>
                    <s:textfield name="name" theme="simple" value="%{showData.name}"/>
                        <strong id="nametext"></strong>
                    </td>   
                </tr>
                <tr>
                	<th><label for="pw">* 비밀번호</label></th>
                    <td>
                    	<s:textfield type="password" name="pw" theme="simple" value="%{showData.pw}"/>
                        <strong id="pwtext"></strong>
                	
                    </td>
                </tr>
                <tr>
                    <th><label for="re_pw">* 비밀번호 확인</label></th>
                    <td><s:textfield type="password" name="re_pw" theme="simple" value=""/>
                        <strong id="re_pwtext"></strong>
                    </td>
                </tr>
                <tr>
                    <th><label for="gender">* 성별</label></th>
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
                    <th><label for="phone_mobi">* 핸드폰</label></th>
                    <td><s:select name="phone_mobi" theme="simple" list="#{'010':'010', '011':'011', '016':'016', '017':'017', '018':'018', '019':'019'}" value="%{showData.phone_mobi1}"/>
                    -<s:textfield name="phone_mobi" theme="simple" value='%{showData.phone_mobi2}'/>-<s:textfield name="phone_mobi" theme="simple" value="%{showData.phone_mobi3}"/>
                    <strong class="phonetext"></strong></td>
                </tr>               
                <tr>
                    <th><label for="date_birth">* 생년월일</label></th>
                    <td><input type="text" name="date_birth" value="${showData.date_birth}" id="datepicker_old" data-year="1930"/>
                    
                    <s:hidden name="auth_type" value="262144"/>
                    </td>
                </tr>
                <tr>
                	<th><label for="id_medi">의료기관 선택</label></th>
                	<td>
                		<s:select list="%{showSubData}" id="id_medi" name="id_medi" value="showData.id_medi" listKey="id" listValue="name" theme="simple"/>
                	</td>
                </tr>
                
                
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
<div id = "dialog_Zipcode" title="우편번호 찾기"  style="display: none;">
    <section>
        <article>
            <form class="zipcode-search" action="" class="artn-search">
            <label for="dong">동 입력</label><input type="text" name="dong" value="" />
            <input type="button" name="dong-search" class="artn-button board" value="검색"/>
            <input type="hidden" name="class-name"/>
            
                <table class = "search-result">
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
