<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<s:bean name="artn.common.ComboboxDataMaker" var="cmbMaker"></s:bean>
<s:set var="romVal">${param.rom }</s:set>
<s:set var="show">${param.show }</s:set>
<s:set var="cate_movie1">${param.cate_movie1 }</s:set>

<s:if test='%{#cate_movie1 == "1"}'>
<s:set var="romName" value='%{"neck"}'/>
<s:set var="romList" value='%{{
#{"dir": "flexion", "max": 45, "step": 5}, 
#{"dir": "lateral flexion", "max": 55, "step": 5},
#{"dir": "rotation", "max": 70, "step": 10}
}}'/>
</s:if>

<s:elseif test='%{#cate_movie1 == "2"}'>
<s:set var="romName" value='%{"shoulder"}'/>
<s:set var="romList" value='%{{
#{"dir": "flexion", "max": 170, "step": 10}, 
#{"dir": "extension", "max": 60, "step": 10},
#{"dir": "abduction", "max": 170, "step": 10},
#{"dir": "adduction", "max": 0, "step": 10},
#{"dir": "external rotation", "max": 90, "step": 10},
#{"dir": "internal rotation", "max": 70, "step": 10},
#{"dir": "horizontal adduction", "max": 130, "step": 10},
#{"dir": "horizontal abduction", "max": 40, "step": 10}
}}'/>
</s:elseif>

<s:elseif test='%{#cate_movie1 == "3"}'>
<s:set var="romName" value='%{"elbow"}'/>
<s:set var="romList" value='%{{
#{"dir": "flexion", "max": 155, "step": 5}, 
#{"dir": "extension", "max": 5, "step": 1}
}}'/>
</s:elseif>

<s:elseif test='%{#cate_movie1 == "4"}'>
<s:set var="romName" value='%{"waist"}'/>
<s:set var="romList" value='%{{
#{"dir": "flexion", "max": 90, "step": 10}, 
#{"dir": "extension", "max": 30, "step": 10},
#{"dir": "lateral flexion", "max": 35, "step": 5},
#{"dir": "rotation", "max": 40, "step": 10}
}}'/>
</s:elseif>

<s:elseif test='%{#cate_movie1 == "5"}'>
<s:set var="romName" value='%{"hip"}'/>
<s:set var="romList" value='%{{
#{"dir": "flexion", "max": 120, "step": 10}, 
#{"dir": "extension", "max": 30, "step": 10},
#{"dir": "abduction", "max": 40, "step": 10},
#{"dir": "adduction", "max": 35, "step": 5},
#{"dir": "external rotation", "max": 45, "step": 5},
#{"dir": "internal rotation", "max": 45, "step": 5}
}}'/>
</s:elseif>

<s:elseif test='%{#cate_movie1 == "6"}'>
<s:set var="romName" value='%{"knee"}'/>
<s:set var="romList" value='%{{
#{"dir": "flexion", "max": 135, "step": 5}, 
#{"dir": "extension", "max": 0, "step": 1}
}}'/>
</s:elseif>

<s:elseif test='%{#cate_movie1 == "7"}'>
<s:set var="romName" value='%{"ankle"}'/>
<s:set var="romList" value='%{{
#{"dir": "dorsiflexion", "max": 15, "step": 5}, 
#{"dir": "plantarflexion", "max": 50, "step": 10}
}}'/>
</s:elseif>

<s:set var="listSize" value='%{#romList.size}'/>

<table class="rom">
	<thead>
	<tr>
		<th>관절(Joint)</th>
		<th>운동방향 (정상 운동범위)</th>
		<th>환자의 상태 범위</th>
	</tr>
	</thead>
	<tbody>
	<s:if test='%{#show == "yes"}'>
	<s:iterator value="#romList" var="rom" status="status">
	<tr>
		<s:if test='%{#status.first == true}'><td rowspan="${listSize}"><s:property value='%{#romName}'/></td></s:if>
		<td><s:property value='%{#rom.dir}'/> (0 ~ <s:property value='%{#rom.max}'/>)</td>
		<td><s:property value="#cmbMaker.subStrValue(#romVal, #status.index)"/></td>
	</tr>
	</s:iterator>
	</s:if>
	<s:else>
	<s:iterator value="#romList" var="rom" status="status">
	<tr>
		<s:if test='%{#status.first == true}'><td rowspan="${listSize}"><s:property value='%{#romName}'/></td></s:if>
		<td><s:property value='%{#rom.dir}'/> (0 ~ <s:property value='%{#rom.max}'/>)</td>
		<td><s:select name="rom" id='%{"combobox_rom" + #status.index}' list="#cmbMaker.getNumberList(#rom.max, #rom.step)" listKey="key" listValue="value" value="#cmbMaker.subStrValue(#romVal, #status.index)" theme="simple"/></td>
	</tr>
	</s:iterator>
	</s:else>
	</tbody>
</table>