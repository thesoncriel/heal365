<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:set var="cmb">${param.cmb }</s:set>
<s:set var="val">${param.val }</s:set>

<s:if test='%{#cmb == "weekly_chk"}'>
	<s:select name="weekly_chk" list='%{#{
		"0": "매일",
		"1": "월",
		"2": "화",
		"3": "수",
		"4": "목",
		"5": "금",
		"6": "토",
		"7": "일"
	}}' value="val" theme="simple"/>
</s:if>

<s:elseif test='%{#cmb == "bp"}'>
	<s:select name="bp" list='%{#{
		"90-120":"90~120", 
		"120-150":"120~150", 
		"150-200":"150~200"
	}}' value="val" theme="simple"/>
</s:elseif>

<s:elseif test='%{#cmb == "date_end_week"}'>
	<s:select name="date_end_week" list='%{#{
		"4": "4주",
		"5": "5주",
		"6": "6주",
		"7": "7주",
		"8": "8주",
		"9": "9주",
		"10": "10주"
	}}' value="val" theme="simple"/>
</s:elseif>

<s:elseif test='%{#cmb == "continued"}'>
	<s:if test='%{#val.toString() not in {"1", "0"}}'><s:set var="val">0</s:set></s:if>
	<s:radio name='%{#cmb}' list='%{#{
		"1": "예",
		"0": "아니오"
	}}' value="val" theme="simple"/>
</s:elseif>

<s:elseif test='%{#cmb == "frequency"}'>
<s:select name='%{#cmb }' id='%{"combobox_" + #cmb}' list='%{#{
	"1": "1",
	"2": "2",
	"3": "3",
	"4": "4",
	"5": "5"
}}' value="val" theme="simple"/>
</s:elseif>

<s:elseif test='%{#cmb == "intensity"}'>
<s:select name='%{#cmb }' id='%{"combobox_" + #cmb}' list='%{#{
	"1": "1",
	"2": "2",
	"3": "3",
	"4": "4",
	"5": "5"
}}' value="val" theme="simple"/>
</s:elseif>

<s:elseif test='%{#cmb == "duration"}'>
<s:select name='%{#cmb }' id='%{"combobox_" + #cmb}' list='%{#{
	"1": "1",
	"2": "2",
	"3": "3",
	"4": "4",
	"5": "5"
}}' value="val" theme="simple"/>
</s:elseif>

<s:elseif test='%{#cmb == "form"}'>
<s:select name='%{#cmb }' id='%{"combobox_" + #cmb}' list='%{#{
	"1": "1",
	"2": "2",
	"3": "3",
	"4": "4",
	"5": "5"
}}' value="val" theme="simple"/>
</s:elseif>


<s:elseif test='%{#cmb == "move_direction"}'>
<s:if test='%{#sub == "1"}'>
<s:select name="move_direction" id="combobox_move_direction" list='%{#{
	"1": "flexion",
	"2": "extension",
	"3": "abduction",
	"4": "adduction",
	"5": "external rotation",
	"6": "internal rotation",
	"7": "horizontal adduction",
	"8": "horizontal abduction"
}}' value="val" theme="simple"/>
</s:if>
</s:elseif>

<s:elseif test='%{#cmb == "rom"}'>
<s:if test='%{#max == "170"}'>
<s:select name="rom_range" id="combobox_rom_range" list='%{#{
	"0": "0",
	"170": "170"
}}' value="val" theme="simple"/>
</s:if>

</s:elseif>