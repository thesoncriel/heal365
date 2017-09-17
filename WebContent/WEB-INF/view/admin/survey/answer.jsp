<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 설문지작성" contents="${contentsCode }">
<style>
.survey_answer label{
	 vertical-align: top;
}
.board-show.style2{
    font-size: 15px;
    border: 1px solid #d1d1d1;
}
</style>
<div class="header">
    <h1>설문지 작성</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="section">
<div class="article">
<form id="form_mediCheckField" action="/user/answer_complete" method="post" enctype="multipart/form-data" class="validator">
<input type="hidden" value="${user.id }" name="id_user"/>
<input type="hidden" value="${user.name }" name="user_name"/>
<input type="hidden" value="${listData[0].id_survey }" name="id_survey"/>
<input type="hidden" name="work_type" value="${listData[0].work_type }" />

<table class="board-show style2">
	<thead>
		<tr>
			<th>작성자</th>
			<td>
				${user.name }
			</td>
		</tr>
	</thead>
</table>
<br/>
<div style="color: red;text-align: center;">
	경고:자가진단에 응하지 않고 Medifit 이용시 책임지지 않습니다.
</div>
<br/>
<h1 style="text-align: center;">${listData[0].subject }</h1>
<br/>
		<table class="board-show style2">
			<tbody class="row-scope">
			<s:iterator value="listData" status="s">
			<input type="hidden" name="id_question" value="${id_question }" />
				<tr>
					<th style="width: 50px">문항.${s.index+1 }
					<input type="hidden" name="seq" value="${seq }"/>
					</th>
					<td>	
						<div style="width: 620px;line-height: 30px;">${question_cont }</div>
					</td>
				</tr>
				<tr>
					<th>답변체크</th>
					<td >
						<s:if test="question_type == 0">
							<a:checkboxlist name="answer_int${s.index+1 }" list="${question_item }" type="radio" cssClass="survey_answer" />
							<input type="hidden" name="answer_text" value=""/>
							<input type="hidden" name="question_type" value="${question_type }"/>
						</s:if>
						<s:if test="question_type == 1">
							
						</s:if>
						<s:if test="question_type == 2">
							<a:selectbox list="${question_item }" name="answer_int${s.index+1 }" />
							<input type="hidden" name="answer_text" value=""/>
							<input type="hidden" name="question_type" value="${question_type }"/>
						</s:if>
						<s:if test="question_type == 3">
							<input type="text" readonly="readonly" name="answer_text" />
							<input type="hidden" name="answer_int${s.index+1 }" value="0"/>
							<input type="hidden" name="question_type" value="${question_type }"/>
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
<div class="footer board">
	<div class="buttons">
		<button id="button_surveyField" class="artn-button board" type="submit">작성완료</button>
	</div>
</div>
</form>
</div>
</div>

</a:html>