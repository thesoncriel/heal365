<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 설문지관리" contents="${contentsCode }">
<style>
.survey_show label{

/* 	vertical-align: top; */
}

</style>
<div class="header">
    <h1>설문지 관리</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="section">
<div class="article">
<form id="form_mediCheckField" action="edit" method="post" enctype="multipart/form-data" class="validator">

<input type="hidden" name="id" value="${listData[0].id }" />
<table class="board-show style2">
	<tbody class="row-scope">
		<tr>
			<th>아이디/작성자</th>
			<td>
			${listData[0].id_writer } / ${listData[0].writer_name }
			</td>
		</tr>
		<tr>
			<th>설문시작 일시</th>
			<td>
				${listData[0].date_start_fmt }
			</td>	
		</tr>
		<tr>
			<th>설문종료 일시</th>
			<td>
				${listData[0].date_end_fmt }
			</td>	
		</tr>
		<tr>
			<th>업무형태</th>
			<td>
				${listData[0].work_type }
			</td>
		</tr>
		<tr>
			<th>사용여부</th>
			<td>
				<s:if test="listData[0].opt == 1">
				사용
				</s:if>
				<s:if test="listData[0].opt == 0">
				사용안함
				</s:if>
				
			</td>	
		</tr>
	</tbody>
</tbody>
</table>
<h1 style="text-align: center;">${listData[0].subject }</h1>
<div class="item">
	<table class="board-show style2">
		<tbody class="row-scope">
			<s:iterator value="listData" status="s">
			<tr>
				<th style="width: 140px;">문항.${seq }</th>
				<td>
					<div style="width: 620px;line-height: 20px;">	
					${question_cont }
					</div>
				</td>
			</tr>
			<tr>
				<th>답변체크</th>
				<td style="line-height: 20px">
					<s:if test="question_type == 0">
						<a:checkboxlist name="answer_int${seq }" list="${question_item }" type="radio" cssClass="survey_show" />
					</s:if>
					<s:if test="question_type == 1">
					</s:if>
					<s:if test="question_type == 2">
						<a:selectbox list="${question_item }" name="answer_int${seq }" />
					</s:if>
					<s:if test="question_type == 3">
						<input type="text" readonly="readonly" name="answer_text${seq }" />
					</s:if>
					<s:if test="question_type == 4">
					</s:if>
					<%-- <s:if test="${question_type == '0'}">
						<s:select disabled="true" value="question_type" name="question_type" list="#{'0':'라디오버튼','1':'체크박스(다중선택)','2':'셀렉트박스','3':'텍스트박스(주관식)','4':'미정'}">
						</s:select>
		 			</s:if> --%>
				</td>
			</tr>
			</s:iterator>
		</tbody>
	</table>	
</div>

<div class="footer board">
	<div class="buttons">
		<button id="button_surveyField" class="artn-button board" type="submit">수정</button>
	</div>
</div>
</form>
</div>
</div>

</a:html>