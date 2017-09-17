<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 간호사" contents="${contentsCode }">
<div class="header">
    <h1>건강점검 리스트 보기</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="section">
<div class="article">
<fieldset>
<table class="board-edit">	
	<thead>
		<tr>
			<th colspan="2">[기본항목]</th>
		</tr>
		<tr>
			<td colspan="2"><label>키</label>
			${showData.height }cm</td>
		</tr>
		<tr>
			<td colspan="2"><label>몸무게</label>
			${showData.weight }kg</td>
		</tr>
		<tr>
			<td colspan="2"><label>발 사이즈(신발 사이즈)</label>
			${showData.feet_size }mm</td>
		</tr>
		<tr>
			<th colspan="2">[혈압관리]</th>
		</tr>
		<tr>
			<td colspan="2"><span>1. 고혈압 진단을 받으신적이 있습니까?</span>			
			<a:surveyvalue value="${showData.check }" offset="0" wrap="span" />			
			
		</tr>
		<tr>
			<td colspan="2">1-1. 진단을 받은적이 있다면 현재 복용하는 약이 있습니까?
			<a:surveyvalue value="${showData.check }" offset="1" wrap="span" />
		</tr>
		<tr>
			<td colspan="2">2. 가족중에 고혈압을 앓고 계신분은 있습니까?
			<a:surveyvalue value="${showData.check }" offset="2" wrap="span" />
		</tr>
		<tr>
			<th colspan="2">[당뇨관리]</th>
		</tr>
		<tr>
			<td colspan="2">3. 당뇨병 진단을 받은적이 있습니까?
			<a:surveyvalue value="${showData.check }" offset="3" wrap="span" />
		</tr>
		<tr>
			<td colspan="2">3-1. 진단을 받은적이 있다면 현재 복용하는 약이 있습니까?
			<a:surveyvalue value="${showData.check }" offset="4" wrap="span" />
		</tr>
		<tr>
			<td colspan="2">4. 가족중에 당뇨병을 알고 계신분은 있습니까?
			<a:surveyvalue value="${showData.check }" offset="5" wrap="span" />
		</tr>
		<tr>
			<th colspan="2">[기타]</th>
		</tr>
		<tr>
			<td colspan="2">5. 현재진단받은 질환이 있습니까?</td>						
		</tr>
		<tr>
			<td colspan="2">5-1. 현재 진단 받은 질환:
			${showData.text1 }</td>			
		</tr>
		<tr>
			<td colspan="2">6. 현재 복용중인 약물이 있습니까?</td>						
		</tr>
		<tr>
			<td colspan="2">6-1. 복용중인 약물:
			${showData.text2 }"</td>			
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
			<a href="list" class="artn-button board">목록</a>
	</div>
</div>
</div>
</div>

</a:html>