<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:bean name="artn.common.ComboboxDataMaker" var="cmbMaker"></s:bean>
<s:set var="val">${param.val }</s:set>
<s:set var="show">${param.show }</s:set>
<s:set var="isDaily" value='%{#cmbMaker.isDaily(#val) }'/>
<s:set var="valDaily" value='%{(#isDaily) ? #cmbMaker.extractWeeklyData(0, #val) : 0}'/>
<div class="weekly_chk-list">
<table>
	<thead>
		<tr><th>매일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th><th>일</th></tr>
	</thead>
	<tbody>
		<tr>
		<s:if test='%{#show == "yes"}'>
			<s:if test='%{#isDaily}'>
			<td>${valDaily }회</td><td>-</td><td>-</td><td>-</td><td>-</td><td>-</td><td>-</td><td>-</td>
			</s:if>
			<s:else>
			<td>-</td>
<s:iterator begin="0" end="6" status="status">
			<td>
			<s:set var="weeklyVal" value='%{#cmbMaker.extractWeeklyData(#status.index, #val)}'/>
			<s:if test='%{#weeklyVal == 0 }'>-</s:if>
			<s:else><s:property value='%{#weeklyVal}'/>회</s:else>
			</td>
</s:iterator>
			</s:else>
		</s:if>
		<s:else>
			<td><s:select list='%{#cmbMaker.getWeeklyCombData(0, 10, "직접선택", "회")}' listKey="key" listValue="value" theme="simple" id="combobox_weekly_chk_daily" name="weekly_chk_daily" value='%{#valDaily}'/></td>
<s:iterator begin="0" end="6" status="status">
			<td>
			<s:select list='%{#cmbMaker.getWeeklyCombData(#status.index, 10, "없음", "회")}' listKey="key" listValue="value" theme="simple" id='%{"combobox_weekly_chk" + #status.index }' name="weekly_chk" value='%{#cmbMaker.extractWeeklyData(#status.index, #val)}' disabled='%{ #isDaily}'/>
			</td>
</s:iterator>
		</s:else>
		</tr>
	</tbody>
</table>
</div>