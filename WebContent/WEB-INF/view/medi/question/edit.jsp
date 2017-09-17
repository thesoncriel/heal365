<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 문진표" contents="${contentsCode }">
<div class="header">
    <h1>문진표 <s:if test="showIsNull">작성</s:if><s:else>수정</s:else></h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="section">
<div class="article">
<form action="modify" method="post" enctype="multipart/form-data" class="validator">
<fieldset>
환자명:<input type="text" id="autocomplete_user_name" data-url="/groupuser/list?json=true&id_group=${idMedi }" data-format="{user_name} ({user_date_birth}) :: {id_user}" data-field="#user_name,@id_user" data-type="map" data-minlen="1" name="user_name" value="${showData.user_name }" required="required"/>
<span style="color: red;">※자동 완성 기능을 이용하여 선택해 주세요.</span>
<input name="id_user" type="hidden" value="${showData.id_user }"/>
<input type="hidden" name="id_writer" value="${user.id }">
<input type="hidden" name="writer_name" value="${user.name }">
<table class="medi-question-top">
    <tbody>
		<tr>
			<th class="css-height"><label for="height">키</label></th>
			<td><input type="text" name="height" value="${showData.height }" data-rule="dec" title="숫자만 입력 가능합니다."/>cm</td>
			<th class="css-weight"><label for="weight">몸무게</label></th>
			<td><input type="text" name="weight" value="${showData.weight }" data-rule="dec" title="숫자만 입력 가능합니다."/>kg</td>
			<th class="css-feet_size"><label for="feet_size">발 사이즈(신발 사이즈)</label></th>
			<td><input type="text" name="feet_size" value="${showData.feet_size }" data-rule="dec" title="숫자만 입력 가능합니다."/>mm</td>
		</tr>
	</tbody>
</table>
<table class="medi-question-bottom">
    <tbody>
		<tr>
			<th><label>[혈압관리]</label></th>
			<th class="check-radio">예</th>
			<th class="check-radio">아니오</th>
		</tr>
		<tr>
			<td><span>1. 고혈압 진단을 받으신적이 있습니까?</span>
			<a:surveyradio name="check" value="${showData.check }" offset="0" subWrap="td" wrap="none" unchecked="${showIsNull}" labelShow="false"/>			
		</tr>
		<tr>
			<td>1-1. 진단을 받은적이 있다면 현재 복용하는 약이 있습니까?
			<a:surveyradio name="check" value="${showData.check }" offset="1" subWrap="td" wrap="none" unchecked="${showIsNull}" labelShow="false"/>
		</tr>
		<tr>
			<td>2. 가족중에 고혈압을 앓고 계신분은 있습니까?
			<a:surveyradio name="check" value="${showData.check }" offset="2" subWrap="td" wrap="none" unchecked="${showIsNull}" labelShow="false"/>
		</tr>
		<tr>
			<th><label>[당뇨관리]</label></th>
			<th class="check-radio">예</th>
            <th class="check-radio">아니오</th>
		</tr>
		<tr>
			<td>3. 당뇨병 진단을 받은적이 있습니까?
			<a:surveyradio name="check" value="${showData.check }" offset="3" subWrap="td" wrap="none" unchecked="${showIsNull}" labelShow="false"/>
		</tr>
		<tr>
			<td>3-1. 진단을 받은적이 있다면 현재 복용하는 약이 있습니까?
			<a:surveyradio name="check" value="${showData.check }" offset="4" subWrap="td" wrap="none" unchecked="${showIsNull}" labelShow="false"/>
		</tr>
		<tr>
			<td>4. 가족중에 당뇨병을 알고 계신분은 있습니까?
			<a:surveyradio name="check" value="${showData.check }" offset="5" subWrap="td" wrap="none" unchecked="${showIsNull}" labelShow="false"/>
		</tr>
		<tr>
			<th colspan="3"><label>[기타]</label></th>
		</tr>
		<tr>
			<td colspan="3">5. 현재진단받은 질환이 있습니까?</td>
		</tr>
		<tr>
			<td colspan="3">5-1. 진단받은 질환:
			<input type="text" name="text1" value="${showData.text1 }"/></td>			
		</tr>
		<tr>
			<td colspan="3">6. 현재 복용중인 약물이 있습니까?</td>
		</tr>
		<tr>
			<td colspan="3">6-1. 복용중인 약물:
			<input type="text" name="text2" value="${showData.text2 }"/></td>			
		</tr>
	</tbody>
</table>
<%--숨김 필드 모음--%>
<s:if test="showIsNull == false">
<input type="hidden" name="id_medi_question" value="${showData.id_medi_question }"/>
</s:if>
<input type="hidden" name="contents" value="${contentsCode }"/>
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