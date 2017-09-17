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
				<li>
					<a href="/physics/complete/stats?contents=${params.contents }">물리치료</a>
				</li>
				<li>
					<a href="/prescript/statsPainSite?contents=${params.contents }">운동처방</a>
				</li>
				<li style="background-color: #eee">
                    <a href="/medistats/totalstats?contents=${params.contents }">통합집계</a>
                </li>
			</ul>
		
		</div>
	</div>

    <form action="totalstats" method="post">
    <input type="text" id="datepicker_date_stats_start" name="date_stats_start" required="required" value="${dateStatsStart }" data-year="2013" data-max-year="10" />-<input type="text" id="datepicker_date_stats_end" name="date_stats_end" required="required" value="${dateStatsEnd }" data-year="2013" data-max-year="10"/>
    <input type="hidden" name="contents" value="${params.contents }"/>
    <input type="submit" class="artn-button board" value="검색"/>
    </form>
    <h2 class="medi_stats_sub_header">건강검진</h2>
	<table class="board-list style2">
        <thead> 
           <s:subset source="subData.checkFieldInfo" count="5">
            <tr>
                <th rowspan="2">구분</th>
                <th rowspan="2">인원</th>
                <s:iterator>
                <th>${field_name }</th>
                </s:iterator>
                <th rowspan="2">검진일</th>
                <th rowspan="2">검사 항목 총계</th>
            </tr>
            </s:subset>
            <s:subset source="subData.checkFieldInfo" start="5" count="10">
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
                <s:if test="(subIsNull.checkFieldInfo == false) && (#subField == 0)">
                    <s:iterator begin="1" end="5">
                    <th></th>
                    </s:iterator>
                </s:if>
            </tr>
            </s:subset>
        </thead>
        <tbody>
            <s:if test="subIsNull.checkGroupCnt">
            <tr><td colspan="<s:property value="subData.checkFieldInfo.size() + 4"/>">자료가 없습니다.</td></tr>
            </s:if>
            <s:else>
            <s:iterator value="subData.checkGroupCnt" var="totalCnt">
                <s:subset source="subData.checkFieldInfo" count="5">
                <tr>
                    <td rowspan="2">집계</td>
                    <td rowspan="2">${totalCnt.user_cnt}</td>
                    <s:iterator var="field">
                    <td><s:property value="#totalCnt[#field.field_column+'_count']"/></td>
                    </s:iterator>
                    <td rowspan="2">${dateStatsStart}<br/>~<br/>${dateStatsEnd}</td>
                    <td rowspan="2">
                        <s:set name="tot" var="totcnt" value="0"/>
                        <s:iterator value="subData.checkFieldInfo" var="cnt">
                            <s:set name="tot" value="#totcnt+#totalCnt[#cnt.field_column+'_count']" var="totcnt"/>
                        </s:iterator>
                        <s:property value="#totcnt"/>
                    </td>
                </tr>
                </s:subset>
                <s:subset source="subData.checkFieldInfo" start="5" count="10">
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
                    <s:if test="(subIsNull.checkFieldInfo == false) && (#subField == 0)">
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
    <h2 class="medi_stats_sub_header">물리치료</h2>
    <table class="board-list style2">
        <thead> 
           <s:subset source="subData.physicsFieldInfo" count="5">
            <tr>
                <th rowspan="2">구분</th>
                <th rowspan="2">인원</th>
                <s:iterator>
                <th>${field_name }</th>
                </s:iterator>
                <th rowspan="2">검진일</th>
                <th rowspan="2">검사 항목 총계</th>
            </tr>
            </s:subset>
            <s:subset source="subData.physicsFieldInfo" start="5" count="10">
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
                <s:if test="(subIsNull.physicsFieldInfo == false) && (#subField == 0)">
                    <s:iterator begin="1" end="5">
                    <th></th>
                    </s:iterator>
                </s:if>
            </tr>
            </s:subset>
        </thead>
        <tbody>
            <s:if test="subIsNull.physicsGroupCnt">
            <tr><td colspan="<s:property value="subData.physicsFieldInfo.size() + 4"/>">자료가 없습니다.</td></tr>
            </s:if>
            <s:else>
            <s:iterator value="subData.physicsGroupCnt" var="totalCnt">
                <s:subset source="subData.physicsFieldInfo" count="5">
                <tr>
                    <td rowspan="2">집계</td>
                    <td rowspan="2">${totalCnt.user_cnt}</td>
                    <s:iterator var="field">
                    <td><s:property value="#totalCnt[#field.field_column+'_count']"/></td>
                    </s:iterator>
                    <td rowspan="2">${dateStatsStart}<br/>~<br/>${dateStatsEnd}</td>
                    <td rowspan="2">
                        <s:set name="tot" var="totcnt" value="0"/>
                        <s:iterator value="subData.physicsFieldInfo" var="cnt">
                            <s:set name="tot" value="#totcnt+#totalCnt[#cnt.field_column+'_count']" var="totcnt"/>
                        </s:iterator>
                        <s:property value="#totcnt"/>
                    </td>
                </tr>
                </s:subset>
                <s:subset source="subData.physicsFieldInfo" start="5" count="10">
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
                    <s:if test="(subIsNull.physicsFieldInfo == false) && (#subField == 0)">
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
    <h2 class="medi_stats_sub_header">운동처방</h2>
    <table class="board-list style2">
        <thead> 
            <tr>
                <th rowspan="3">구분</th>
                <th rowspan="3">인원</th>
                <th>목(좌)</th>
                <th>목(우)</th>
                <th>어깨(좌)</th>
                <th>어깨(우)</th>
                <th>허리</th>
                <th>손목(좌)</th>
                <th>손목(우)</th>
                <th rowspan="3">검진일</th>
                <th rowspan="3">검사 항목 총계</th>
            </tr>
            <tr>
                <th>발목(좌)</th>
                <th>발목(우)</th>
                <th>손가락(좌)</th>
                <th>손가락(우)</th>
                <th>무릎(좌)</th>
                <th>무릎(우)</th>
                <th>팔꿈치(좌)</th>
            </tr>
            <tr class="under-line">
                <th>팔꿈치(우)</th>
                <th>허벅지(좌)</th>
                <th>허벅지(우)</th>
                <th>종아리(좌)</th>
                <th>종아리(우)</th>
                <th></th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <s:if test="subIsNull.prescriptGroupCnt">
            <tr><td colspan="22">자료가 없습니다.</td></tr>
            </s:if>
            <s:else>
            <s:iterator value="subData.prescriptGroupCnt" var="totalCnt">
                <tr>
                    <td rowspan="3">집계</td>
                    <td rowspan="3">${totalCnt.user_cnt}</td>
                    <s:iterator begin="1" end="7" var="stats">
                    <td><s:property value="#totalCnt['col'+#stats]"/></td>
                    </s:iterator>
                    <td rowspan="3">${dateStatsStart}<br/>~<br/>${dateStatsEnd}</td>
                    <td rowspan="3">
                        <s:set name="tot" var="totcnt" value="0"/>
                        <s:if test="(subIsNull.prescriptGroupCnt == false)">
	                        <s:iterator begin="1" end="18" var="stats">
                               <s:set name="tot" value="#totcnt+#totalCnt['col'+#stats]" var="totcnt"/>
	                           <s:if test="#totcnt == null">
	                           <s:set name="tot" value="0" var="totcnt"/>
	                           </s:if>
	                        </s:iterator>
                        </s:if>
                        <s:property value="#totcnt"/>
                    </td>
                </tr>
                <tr>
                    <s:iterator begin="8" end="14" var="stats">
                    <td><s:property value="#totalCnt['col'+#stats]"/></td>
                    </s:iterator>
                </tr>
                <tr class="under-line">
                    <s:iterator begin="15" end="21" var="stats">
                    <td><s:property value="#totalCnt['col'+#stats]"/></td>
                    </s:iterator>
                </tr>
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