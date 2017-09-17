<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:include value="/include/header.jsp"></s:include>
<article class="user-list">
	<s:form action="%{actionURI}" method="POST">
	<table border="1">
		<tr>
		<s:if test="%{showData == null}">		
			<th>아이디 :</th>
			<td><s:textfield name="id" theme="simple" value="%{showData.id}"/></td>
		</s:if>
		<s:else>			
			<s:hidden name="id" theme="simple" value="%{id}"/>
		</s:else>
		</tr>
		<tr>
			<th>이름:	</th>
			<td><s:textfield name="name" theme="simple" value="%{showData.name}"/></td>	
		</tr>
		<tr>
			<th>비밀번호:</th>
			<td><s:textfield type="password" name="pw" theme="simple" value="%{showData.pw}"/></td>
		</tr>
		<tr>
			<th>이메일:</th>
			<td><s:textfield name="email" theme="simple" value="%{showData.email}"/></td>
		</tr>
		<tr>
			<th>집전화:</th>
			<td><s:textfield name="phone_home" theme="simple" value="%{showData.phone_home}"/></td>
		</tr>
		<tr>
			<th>회사전화:</th>
			<td><s:textfield name="phone_corp" theme="simple" value="%{showData.phone_corp}"/></td>
		</tr>
		<tr>		
			<th>핸드폰:</th>
			<td><s:textfield name="phone_mobi" theme="simple" value="%{showData.phone_mobi}"/></td>
		</tr>
		<tr>
			<th>주민등록번호:</th>
			<td><s:textfield name="jumin" theme="simple" value="%{showData.jumin}"/></td>
		</tr>
		<tr>
			<th>생년월일:</th>
			<td><s:textfield name="date_birth" theme="simple" value="%{showData.date_birth}"/>
			<s:hidden name="date_join" theme="simple" value="%{showData.date_join}"/></td>
		</tr>
		<tr>
			<th>관리자 권한:</th>
			<td>
			     <s:select label="관리자 권한" theme="simple" name="auth_type" list="#{'A':'관리자','a':'관계자','d':'의사','t':'운동치료사','p':'환자고객','c':'일반고객'}" value="1" />
			</td>
			<!-- <td><s:textfield name="auth_type" theme="simple" value="%{showData.auth_type}"/></td> -->
		</tr>
		<tr>
		    <th>병원명</th> <!-- 프로토타입용 컨텐츠 나중에 빼야할 것 --> 
		    <td><s:textfield name="name_medi" theme="simple" value="%{showData.medi}"/></td>
		</tr>
		<!-- <tr>
			<th>병원코드:</th>
			<td><s:textfield name="id_medi" theme="simple" value="%{showData.id_medi}"/></td>
		</tr>
		<tr>
            <th>회사 코드</th>
            <td><s:textfield name="group_id" theme="simple" value="%{showData.group_id}"/></td>
        </tr>
		<tr>
			<th>회사명</th>
			<td><s:textfield name="group_name" theme="simple" value="%{showData.group_name}"/></td>
		</tr>
		<tr>
			<th>부서명</th>
			<td><s:textfield name="group_dev" theme="simple" value="%{showData.group_dev}"/></td>
		</tr>	 -->	
		<tr>
			<th>주소</th>
			<td><s:textfield name="location" theme="simple" value="%{showData.location}"/></td>
		</tr>
		<tr>
			<th>우편번호</th>
			<td><s:textfield name="zip_code" theme="simple" value="%{showData.zip_code}"/></td>
		</tr>
		<tr>
			<th>성별</th>
			<td><s:radio name="gender" list="#{'m':'남자','w':'여자'}" value="%{showData.gender}" theme="simple" /></td>
			
		</tr>	
			<!--<s:textfield name="gender" theme="simple" value="%{showData.gender}"/>-->
		
		</table>
		
		<input type="submit" value="작성 완료"/>
		<a href="/index.jsp">취소</a>
	</s:form>	
</article>
<s:include value="/include/player-footer.htmlpart"></s:include>
