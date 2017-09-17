<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:include value="/include/header.jsp"></s:include>
<article class="user-list">
	<table>
		<tr>
			<th>아이디:</th>
			<td><s:property value="showData.id"/></td>
		</tr>
		<tr>
			<th>이름:</th>
			<td><s:property value="showData.name"/></td>
		</tr>
		<tr>
			<th>비밀번호:</th>
			<td><s:property value="showData.pw"/></td>
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
			<th>주민등록번호</th>
			<td><s:property value="showData.jumin"/></td>
		</tr>
		<tr>
			<th>생년월일</th>
			<td><s:property value="showData.date_birth"/></td>
		</tr>
		<tr>
			<th>수정일자</th>
			<td><s:property value="showData.date_join"/></td>
		</tr>
		<tr>
			<th>관리자 권한</th>
			<td><s:property value="showData.auth_type"/></td>
		</tr>
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
		<s:a href="%{'edit.action?id=' + showData.id}">수정</s:a>
		<br/> 
		<s:a href="%{'list.action'}">리스트로</s:a>
		
		<br><br>
		<%--
		아이디 : <s:property value="id"/><br/>
		이름 : <s:property value="name"/><br/>
		<s:property value="count"/><br/>
		<s:property value="showResultStatus"/><br/>
		<s:a href="%{'edit.action?id=' + id}">수정</s:a>
		 --%>
		 
</article>
<s:include value="/include/player-footer.htmlpart"></s:include>
