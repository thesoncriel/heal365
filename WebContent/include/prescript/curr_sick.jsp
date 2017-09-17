<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:set var="val">${param.val }</s:set>
<s:set var="show">${param.show }</s:set>
<s:set var="name">curr_sick</s:set>
<s:set var="chkList" value='%{{
#{"val":"1", "label":"혈압"},
#{"val":"2", "label":"당뇨"},
#{"val":"4", "label":"고지혈증"}
}}'/>
<div class="checkbox-list">
<s:if test='%{#show == "yes"}'>
<s:iterator value="chkList" var="item" status="status">
	<s:if test='%{ ((#val >> #status.index) & 1) == 1 }'><s:property value='%{#item.label}'/> / </s:if>
</s:iterator>
</s:if>
<s:else>
<s:iterator value="chkList" var="item" status="status">
	<input type="checkbox" name="${name}" value="${item.val}" id="checkbox_${name }${status.index}" <s:if test='%{ ((#val >> #status.index) & 1) == 1 }'>checked="checked"</s:if>/>
	<label for="checkbox_${name }${status.index}">${item.label}</label>
</s:iterator>
</s:else>

</div>