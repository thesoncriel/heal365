<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>

<a:html title=" - 통합 집계표" contents="${contentsCode }">
<div class="header">
    <h1>통합 집계표</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="section">
<div class="article">

	<div>
		<div>
			<ul class="distribute div4 tabul">
                <li>
                    <a href="/medicheck/complete/stats?contents=${params.contents }">건강검진</a>
                </li>
                <li style="background-color: #eee">
                    <a href="/physics/complete/stats?contents=${params.contents }">물리치료</a>
                </li>
                <li>
                    <a href="/prescript/statsPainSite?contents=${params.contents }">운동처방</a>
                </li>
                <li>
                    <a href="/medistats/totalstats?contents=${params.contents }">통합집계</a>
                </li>
            </ul>
		
		</div>
	</div>
    <form action="stats" method="post">
    <input type="text" id="datepicker_date_stats_start" name="date_stats_start" required="required" value="${dateStatsStart }" data-year="2013" data-max-year="10" />-<input type="text" id="datepicker_date_stats_end" name="date_stats_end" required="required" value="${dateStatsEnd }" data-year="2013" data-max-year="10"/>
    <input type="hidden" name="contents" value="${params.contents }"/>
    <input type="submit" class="artn-button board" value="검색"/>
    </form>
	<table class="board-list style2">
        <thead> 
           <s:subset source="subData.fieldInfo" count="5">
            <tr>
                <th rowspan="2">구분</th>
                <th rowspan="2">성명</th>
                <s:iterator>
                <th>${field_name }</th>
                </s:iterator>
                <th rowspan="2">검진일</th>
                <th rowspan="2">검사 항목 총계</th>
            </tr>
            </s:subset>
            <s:subset source="subData.fieldInfo" start="5" count="10">
            <tr class="under-line">
                <s:set name="subField" var="subField" value="0"/>
                <s:iterator status="status">
                <th>${field_name }</th>
                <s:if test="#status.last">
                    <s:set name="subField" var="subField" value="1"/>
                    <s:iterator begin="#status.count" end="4">
                        <th></th>
                    </s:iterator>
                </s:if>
                </s:iterator>
                <s:if test="(subIsNull.fieldInfo == false) && (#subField == 0)">
                    <s:iterator begin="1" end="5">
                    <th></th>
                    </s:iterator>
                </s:if>
            </tr>
            </s:subset>
        </thead>
        <tbody>
            <s:if test="listIsNull">
            <tr><td colspan="<s:property value="subData.fieldInfo.size() + 4"/>">자료가 없습니다.</td></tr>
            </s:if>
            <s:else>
            <s:iterator value="subData.GroupCnt" var="totalCnt">
                <s:subset source="subData.fieldInfo" count="5">
                <tr>
                    <td rowspan="2">집계</td>
                    <td rowspan="2">${totalCnt.user_cnt}</td>
                    <s:iterator var="field">
                    <td><s:property value="#totalCnt[#field.field_column+'_count']"/></td>
                    </s:iterator>
                    <td rowspan="2">${dateStatsStart}<br/>~<br/>${dateStatsEnd}</td>
                    <td rowspan="2">
                        <s:set name="tot" var="totcnt" value="0"/>
                        <s:iterator value="subData.fieldInfo" var="cnt">
                            <s:set name="tot" value="#totcnt+#totalCnt[#cnt.field_column+'_count']" var="totcnt"/>
                        </s:iterator>
                        <s:property value="#totcnt"/>
                    </td>
                </tr>
                </s:subset>
                <s:subset source="subData.fieldInfo" start="5" count="10">
                <tr class="under-line">
                   <s:iterator status="status" var="field">
                    <s:set name="subField" var="subField" value="0"/>
                    <td class="tdtotalization"><s:property value="#totalCnt[#field.field_column+'_count']"/></td>
                        <s:if test="#status.last">
                        <s:set name="subField" var="subField" value="1"/>
                        <s:iterator begin="#status.count" end="4">
                            <td></td>
                        </s:iterator>
                        </s:if>
                    </s:iterator>
                    <s:if test="(subIsNull.fieldInfo == false) && (#subField == 0)">
                        <s:iterator begin="1" end="5">
                        <td></td>
                        </s:iterator>
                    </s:if>
                </tr>
                </s:subset>
            </s:iterator>
            
            <s:iterator value="listData" var="data">
                <s:subset source="subData.fieldInfo" count="5">
                <tr>
                        <td rowspan="2">${data.rowcount }</td>
                        <td rowspan="2" class="tooltip"><span class="medi-user-patient" title=" ">${data.user_name }</span>
                        <input type="hidden" class="id_user" value="${data.id_user }"/>
		                <!--{id}<br/>{name}({gender_kor}) {date_birth} <br/>{phone_mobi} -->
		                <span class="tooltipView" style="display : none"></span>
		                </td>
                        <s:iterator var="field">
                        <td><s:property value="#data[#field.field_column+'_count']"/></td>
                        </s:iterator>
                        <td rowspan="2">${dateStatsStart}<br/>~<br/>${dateStatsEnd}</td>
                        <td rowspan="2">
                            <s:set name="tot" var="totcnt" value="0"/>
                            <s:iterator value="subData.fieldInfo" var="cnt">
                                <s:set name="tot" value="#totcnt+#data[#cnt.field_column+'_count']" var="totcnt"/>
                            </s:iterator>
                            <s:property value="#totcnt"/>
                        </td>
                    </tr>
                </s:subset>
                <s:subset source="subData.fieldInfo" start="5" count="10">
                <tr class="under-line">
                   <s:iterator status="status" var="field">
                       <s:set name="subField" var="subField" value="0"/>
                       <td><s:property value="#data[#field.field_column+'_count']"/></td>
                        <s:if test="#status.last">
                        <s:set name="subField" var="subField" value="1"/>
                        <s:iterator begin="#status.count" end="4">
                            <td></td>
                        </s:iterator>
                        </s:if>
                    </s:iterator>
                    <s:if test="(subIsNull.fieldInfo == false) && (#subField == 0)">
                        <s:iterator begin="1" end="5">
                        <td></td>
                        </s:iterator>
                    </s:if>
                </tr>
                </s:subset>
            </s:iterator>
            
            <s:iterator value="subData.GroupCnt" var="totalCnt">
                <s:subset source="subData.fieldInfo" count="5">
                <tr>
                    <td rowspan="2">집계</td>
                    <td rowspan="2">${totalCnt.user_cnt}</td>
                    <s:iterator var="field">
                    <td><s:property value="#totalCnt[#field.field_column+'_count']"/></td>
                    </s:iterator>
                    <td rowspan="2">${dateStatsStart}<br/>~<br/>${dateStatsEnd}</td>
                    <td rowspan="2">
                        <s:set name="tot" var="totcnt" value="0"/>
                        <s:iterator value="subData.fieldInfo" var="cnt">
                            <s:set name="tot" value="#totcnt+#totalCnt[#cnt.field_column+'_count']" var="totcnt"/>
                        </s:iterator>
                        <s:property value="#totcnt"/>
                    </td>
                </tr>
                </s:subset>
                <s:subset source="subData.fieldInfo" start="5" count="10">
                <tr class="under-line">
                   <s:iterator status="status" var="field">
                    <s:set name="subField" var="subField" value="0"/>
                    <td class="tdtotalization"><s:property value="#totalCnt[#field.field_column+'_count']"/></td>
                        <s:if test="#status.last">
                        <s:set name="subField" var="subField" value="1"/>
                        <s:iterator begin="#status.count" end="4">
                            <td></td>
                        </s:iterator>
                        </s:if>
                    </s:iterator>
                    <s:if test="(subIsNull.fieldInfo == false) && (#subField == 0)">
                        <s:iterator begin="1" end="5">
                        <td></td>
                        </s:iterator>
                    </s:if>
                </tr>
                </s:subset>
            </s:iterator>
            </s:else>
        </tbody>
    </table>
</div>

<div class="footer board">
	<div class="buttons">		
		<a href="list" class="artn-button board">목록</a>
	</div>
</div>
</div>

</a:html>