<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<% 
if(request.getSession().getAttribute("user") != null){ 
	response.sendRedirect("/user/menu");
} else {
%>

<jsp:include page="/include/header.jsp" flush="true" />
		<div class="contents">	
          <form action="/user/login" method="post" class="validator">
          	<img src="../img/common/MediFit.png" alt="개인 맞춤형 운동처방 시스템 MediFit" />
            <section class="contents-base">
               <article>
                 <ul>
                     <li>ID <input type="text" name="id" data-rule="id" maxlength="16" id="textbox_id" placeholder="아이디를 입력하세요." /></li>
                     <li>PW <input type="password" name="pw"  maxlength="16" id="textbox_password" placeholder="비밀번호를 입력하세요."/></li>
                 </ul>
                    <input type="submit" id="sub_login" value="로그인" />
                    <span><input type="checkbox" id="id_save"><label for="id_save">아이디 저장</label></span>
                    <span><a href="#">아이디</a>/<a href="#">비밀번호 찾기</a></span>
			   </article>
	                     
	                    <div class="new_mem">
	                       <!-- <p><span class="artn-icon-32 alert"></span>입력하신 아이디 혹은 비밀번호가 일치하지 않습니다.<br/>
	                        	비밀번호는 대/소문자 구분하여 입력하시기 바랍니다.</p>--> 
                        	<a id="" href="/contents.jsp?contents=sub6_1_1&menu=6" class="artn-button board">회원 가입하기</a>                      	
	                    </div>
	                     
            </section>		
          </form>				 
        </div>
<jsp:include page="/include/browser.htmlpart" flush="true" />
<jsp:include page="/include/footer.htmlpart" flush="true" />
<%} %>