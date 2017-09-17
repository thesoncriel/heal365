<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 병원 회원 관리" contents="${contentsCode }">
<script type="text/javascript">
$(document).load(function(){
	Artn.ComboBoxChain.create();	
});
</script>
<div class="header">
    <h1>병원 회원<s:if test="showIsNull"> 등록</s:if><s:else>수정</s:else></h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="section">
<div class="article">

<form action="modify" method="post" enctype="multipart/form-data" class="validator">
<fieldset>
<table class="board-edit">
<thead>
<s:if test="params.edit == 'edit'"><tr>
	<th><label for="autocomplete_user">성명</label></th>
	<td><input type="text" name="name" value="${showData.user_name }" readonly="readonly" required="required" />
	<input type="hidden" name="id_user" value="${showData.id_user}"/></td></tr>
</s:if>
<s:elseif test='%{auth.isGroupAdmin && params.id_group != null}'><tr>
	<th><label for="autocomplete_user">성명</label></th>
	<td><input type="text" id="autocomplete_user" data-url="/user/list?json=true" data-format="{name} ({date_birth}) :: {id}" data-field="#name,date_birth,@id:id_user" data-type="map" data-minlen="1" name="name" value="${#session.newUserName }" required="required" />
	<input type="hidden" name="id_user" value="${#session.newUserId }"/></td></tr>
</s:elseif>
<s:elseif test='%{auth.isHighGroupUser}'><tr>
	<th><label for="autocomplete_user">성명</label></th>
	<td><input type="text" id="autocomplete_user" data-url="/user/list?json=true" data-format="{name} ({date_birth}) :: {id}" data-field="#name,date_birth,@id:id_user" data-type="map" data-minlen="1" name="name" value="${showData.user_name }" required="required" />
	<input type="hidden" name="id_user" value="${showData.id_user}"/></td></tr>
</s:elseif>
<s:else><tr>
	<th><label for="textbox_user">성명</label></th>
	<td><input type="text" id="textbox_user" name="name" value="${user.name }" readonly="readonly" required="required"/>
	<input type="hidden" name="id_user" value="${user.id}"/></td></tr></s:else>
<s:if test='%{auth.isGroupAdmin(id_group) || auth.isSiteStaff}'>
<tr>
<th><label for="selectbox_id_group">병원 선택</label></th>
<td><span data-rule="comboChain" data-url="/admin/auth/list?json=true" data-to="#selectbox_auth_group_id" data-keys="id,auth_user_kor">
	<s:if test="auth.isAdmin">
        <s:select id="selectbox_id_group" name="id_group" value="showData.id_group" list="subData.groupList" listKey="id" listValue="name" headerKey="-1" headerValue="선택해주세요" emptyOption="false" theme="simple" />
	</s:if>
	<s:else>
	    <s:select id="selectbox_id_group" name="id_group" value="showData.id_group" list="subData.groupUserList" listKey="id_group" listValue="group_name" theme="simple"/>
	</s:else>
	</span></td></tr>
	<tr>
	<th><label for="selectbox_auth_group_id">병원 권한</label></th>
    <td>
    	<s:if test="showIsNull == false">
    	<s:select id="selectbox_auth_group_id" name="auth_group_id" value="showData.auth_group_id" list="subData.groupAuthList" listKey="id" listValue="auth_user_kor" theme="simple" />
    	</s:if>
    	<s:elseif test="auth.isGroupAdmin(id_group)">
    	<s:select id="selectbox_auth_group_id" name="auth_group_id" value="showData.auth_group_id" list="subData.groupAuthList" listKey="id" listValue="auth_user_kor" emptyOption="true" theme="simple" />
    	</s:elseif>
    	<s:elseif test="auth.isSiteStaff">
        <s:select id="selectbox_auth_group_id" name="auth_group_id" value="showData.auth_group_id" list="subData.groupAuthList.{? (#this.auth_user_kor == '환자') }" listKey="id" listValue="auth_user_kor" emptyOption="true" theme="simple" />
        </s:elseif>
    	<s:else>
    	<s:select id="selectbox_auth_group_id" name="auth_group_id" value="showData.auth_group_id" list="#{ }" listKey="id" listValue="auth_user_kor" emptyOption="true" theme="simple" />
    	</s:else>
    </td></tr>
</s:if>
<s:else>
<tr>
<th><label for="selectbox_id_group">병원 선택</label></th>
<td><s:if test="showIsNull">${param.group_name }</s:if>
	<s:else>${showData.group_name }</s:else>
	<input type="hidden" name="id_group" value="${id_group }"/>
	<input type="hidden" name="auth_group_id" value="${groupUserAuthId }" /></td></tr>
</s:else>
<tr>
<th><label for="textbox_comment">가입 소견</label></th>
<td><textarea id="textbox_comment" name="comment">${showData.comment }</textarea></td></tr>

</thead>
</table>
<%--숨김 필드 모음--%>
<s:if test="showIsNull == false">
<input type="hidden" name="id" value="${showData.id }"/>
<input type="hidden" name="date_join" value="${showData.date_join }"/>
<input type="hidden" name="listType" value="${listType }"/>
</s:if>
<input type="hidden" name="contents" value="${contentsCode }"/>
</fieldset>
<div class="footer board">
	<div class="buttons">
		<s:if test="params.groupUserList == 'groupUserList'">
			<%-- <a href="/groupuser/list?contents=${contents}" class="artn-button board">목록</a>--%>
			<a href="#" class="artn-button board" data-rule="gotoback">목록</a>
		</s:if>
		<s:else>
			<%-- <a href="/group/list?contents=${contents}" class="artn-button board">목록</a> --%>
			<a href="#" class="artn-button board" data-rule="gotoback">목록</a>
		</s:else>	
		<button type="submit" class="artn-button board"><s:if test="showIsNull">작성</s:if><s:else>수정</s:else> 완료</button>
	</div>
</div>
</form>
</div>
</div>
</a:html>