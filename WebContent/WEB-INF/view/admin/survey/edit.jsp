<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 설문지관리" contents="${contentsCode }">
	<script>
		$(document).ready(function(){
			
			$("#button_surveyField").click(function(){
				Artn.List.inst["#sortable_survey"].add();
			});
			
		});
		
	</script>
<div class="header">
    <h1>설문지 관리</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="section">
<div class="article">
<form id="form_mediCheckField" action="modify" method="post" enctype="multipart/form-data" class="validator">
<input type="hidden" value="${user.id }" name="id_writer"/>
<input type="hidden" value="${user.name }" name="writer_name"/>
<s:if test="listIsNull == false">
  <input type="hidden" name="id" value="${listData[0].id }" /> 
</s:if>
<table>
	<thead>
		<tr>
			<td>설문제목</td>
			<td>
				<input type="text" name="subject" size="100" value="${listData[0].subject }" required="required" />
			</td>
		</tr>
		<tr>
			<td>설문일시</td>
			<td>
				<input type="text" readonly="readonly" name="date_start" value="${listData[0].date_start_fmt }" id="datepicker_date_start" required="required" /> ~ <input required="required" type="text" readonly="readonly" name="date_end" value="${listData[0].date_end_fmt }" id="datepicker_date_end" />
			</td>	
		</tr>
		
		<tr>
			<td>업무형태</td>
			<td>
				<input type="text"  name="work_type" required="required" maxlength="10" value="${listData[0].work_type }" />
			</td>
		</tr>
		<tr>
			<td>사용여부</td>
			<td>
				<input type="radio"  name="opt" checked="checked" value="1" />예
				<input type="radio"  name="opt" value="0" />아니오
			</td>	
		</tr>
	</thead>
</table>
<s:if test="listIsNull">
<div id="sortable_survey">
	<div class="item">
		<table>
			<tbody>
				<tr>
					<td>문항<input type="hidden" name="seq" required="required" /></td>
					<td>	
						<textarea rows="5" cols="90" name="question_cont" required="required" ></textarea>
					</td>
				</tr>
				<tr>
					<td>답변체크</td>
					<td>	
						<input type="text" name="question_item" size="100" required="required" />
					</td>
				</tr>
				<tr>
					<td>선택종류</td>
					<td>
						<s:select value="showData.question_type" name="question_type" list="#{'0':'라디오버튼','1':'체크박스(다중선택)','2':'셀렉트박스','3':'텍스트박스(주관식)','4':'미정'}" theme="simple">
						</s:select>
					</td>
				</tr>
				<tr>
					<td colspan="3">답변은 , 로 불리해서 입력하시면 됩니다.</td>
				</tr>
			</tbody>
		</table>
		<button class="artn-button board delete">삭제</button>                     
	</div>
	<!--
	<div class="item">
		<table>
			<tbody>
				
				<tr>
					<td>문항<input type="hidden" name="seq" value="${seq }"/></td>
					<td>	
						<textarea rows="5" cols="90" name="question_cont"></textarea>
					</td>
				</tr>
				<tr>
					<td>답변체크</td>
					<td>	
						<input type="text" name="question_item" size="100" />
					</td>
					<td>
						<s:select value="showData.question_type" name="question_type" list="#{'0':'라디오버튼','1':'체크박스(다중선택)','2':'셀렉트박스','3':'텍스트박스(주관식)','4':'미정'}">
						</s:select>
					</td>
				</tr>
			</tbody>
		</table>
		<button class="artn-button board delete">삭제</button>
	</div>
	-->
</div>
</s:if>
<s:else>

<div id="sortable_survey">
<s:iterator value="listData" status="s">
	<div class="item">
		<table>
			<tbody>
				
				<tr>
					<td>문항<input type="hidden" name="seq" value="${seq }" required="required" /></td>
					<td>	
						<textarea rows="5" cols="90" name="question_cont" required="required" >${question_cont }</textarea>
					</td>
				</tr>
				<tr>
					<td>답변체크</td>
					<td>	
						<input type="text" name="question_item" size="100" value="${question_item }" required="required" />
					</td>
					<td>
						<s:select value="showData.question_type" name="question_type" list="#{'0':'라디오버튼','1':'체크박스(다중선택)','2':'셀렉트박스','3':'텍스트박스(주관식)','4':'미정'}">
						</s:select>
					</td>
				</tr>
			</tbody>
		</table>
		<button class="artn-button board delete">삭제</button>
	</div>
	<!--
	<div class="item">
		<table>
			<tbody>
				
				<tr>
					<td>문항<input type="hidden" name="seq" value="${seq }"/></td>
					<td>	
						<textarea rows="5" cols="90" name="question_cont"></textarea>
					</td>
				</tr>
				<tr>
					<td>답변체크</td>
					<td>	
						<input type="text" name="question_item" size="100" />
					</td>
					<td>
						<s:select value="showData.question_type" name="question_type" list="#{'0':'라디오버튼','1':'체크박스(다중선택)','2':'셀렉트박스','3':'텍스트박스(주관식)','4':'미정'}">
						</s:select>
					</td>
				</tr>
			</tbody>
		</table>
		<button class="artn-button board delete">삭제</button>
	</div>
	-->
</s:iterator>
</div>

</s:else>

<div class="footer board">
	<div class="buttons">
		<button id="button_surveyField" class="artn-button board" type="button">추가</button>
		<button id="button_submitMediCheckField" type="submit" class="artn-button board">입력완료</button>
	</div>
</div>
</form>
</div>
</div>

</a:html>