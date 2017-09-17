<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 간호사" contents="${contentsCode }">
<div class="header">
    <h1>간호사 <s:if test="showIsNull">등록</s:if><s:else>수정</s:else></h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="section">
<div class="article">
<form action="modify" method="post" enctype="multipart/form-data" class="validator">
<fieldset>
그룹:<input name="id_group" type="text" value="${param.id_group }"/><br/>
이름:<input type="text" id="autocomplete_user_name" data-url="/user/list?json=true" data-format="{name} ({date_birth}) :: {id}" data-field="#name,@id:id_user" data-type="map" data-minlen="1" name="user_name" value="${showData.user_name }"/><input name="id_user" type="hidden" value="${showData.id_user }"/>
<table class="board-edit">	
	<thead>
		<tr>
			<th colspan="2">[기본항목]</th>
		</tr>
		<tr>
			<td colspan="2"><label>키</label>
			<input type="text" name="height" value="${showData.height }">cm</td>
		</tr>
		<tr>
			<td colspan="2"><label>몸무게</label>
			<input type="text" name="weight" value="${showData.weight }">kg</td>
		</tr>
		<tr>
			<td colspan="2"><label>발 사이즈(신발 사이즈)</label>
			<input type="text" name="feet_size" value="${showData.feet_size }">mm</td>
		</tr>
		<tr>
			<th colspan="2">[혈압관리]</th>
		</tr>
		<tr>
			<td colspan="2"><span>1. 고혈압 진단을 받으신적이 있습니까?</span>
			<a:surveyradio name="check" value="${showData.check }" offset="0" subWrap="span" wrap="div" unchecked="${showIsNull}"/>			
			
		</tr>
		<tr>
			<td colspan="2">1-1. 진단을 받은적이 있다면 현재 복용하는 약이 있습니까?
			<a:surveyradio name="check" value="${showData.check }" offset="1" subWrap="span" wrap="div" unchecked="${showIsNull}"/>
		</tr>
		<tr>
			<td colspan="2">2. 가족중에 고혈압을 앓고 계신분은 있습니까?
			<a:surveyradio name="check" value="${showData.check }" offset="2" subWrap="span" wrap="div" unchecked="${showIsNull}"/>
		</tr>
		<tr>
			<th colspan="2">[당뇨관리]</th>
		</tr>
		<tr>
			<td colspan="2">3. 당뇨병 진단을 받은적이 있습니까?
			<a:surveyradio name="check" value="${showData.check }" offset="3" subWrap="span" wrap="div" unchecked="${showIsNull}"/>
		</tr>
		<tr>
			<td colspan="2">3-1. 진단을 받은적이 있다면 현재 복용하는 약이 있습니까?
			<a:surveyradio name="check" value="${showData.check }" offset="4" subWrap="span" wrap="div" unchecked="${showIsNull}"/>
		</tr>
		<tr>
			<td colspan="2">4. 가족중에 당뇨병을 알고 계신분은 있습니까?
			<a:surveyradio name="check" value="${showData.check }" offset="5" subWrap="span" wrap="div" unchecked="${showIsNull}"/>
		</tr>
		<tr>
			<th colspan="2">[기타]</th>
		</tr>
		<tr>
			<td colspan="2">5. 현재진단받은 질환이 있습니까?</td>						
		</tr>
		<tr>
			<td colspan="2">5-1. 현재 진단 받은 질환:
			<input type="text" name="text1" value="${showData.text1 }"/></td>			
		</tr>
		<tr>
			<td colspan="2">6. 현재 복용중인 약물이 있습니까?</td>						
		</tr>
		<tr>
			<td colspan="2">6-1. 복용중인 약물:
			<input type="text" name="text2" value="${showData.text2 }"/></td>			
		</tr>
	</thead>
</table>
<%--숨김 필드 모음--%>
<s:if test="showIsNull == false">
<input type="hidden" name="id" value="${showData.id }"/>
<input type="hidden" name="date_create" value="${showData.date_create }"/>
</s:if>

</fieldset>


<div class="footer board">
	<div class="buttons">
			<button type="submit" class="artn-button board"><s:if test="showIsNull">작성</s:if><s:else>수정</s:else> 완료</button>
	</div>
</div>
</form>
</div>
</div>

</a:html>