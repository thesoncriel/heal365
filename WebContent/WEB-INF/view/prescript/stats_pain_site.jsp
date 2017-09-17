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
                <li style="background-color: #eee">
                    <a href="/prescript/statsPainSite?contents=${params.contents }">운동처방</a>
                </li>
                <li>
                    <a href="/medistats/totalstats?contents=${params.contents }">통합집계</a>
                </li>
            </ul>
		
		</div>
	</div>

    <form action="statsPainSite" method="post">
    <input type="text" id="datepicker_date_stats_start" name="date_stats_start" required="required" value="${dateStatsStart }" data-year="2013" data-max-year="10" />-<input type="text" id="datepicker_date_stats_end" name="date_stats_end" required="required" value="${dateStatsEnd }" data-year="2013" data-max-year="10"/>
    <input type="hidden" name="contents" value="${params.contents }"/>
    <input type="submit" class="artn-button board" value="검색"/>
    </form>
	<table class="board-list style2">
	    <thead> 
	        <tr>
	            <th rowspan="3">구분</th>
	            <th rowspan="3">성명</th>
	            <th>목(좌)</th>
	            <th>목(우)</th>
                <th>어깨(좌)</th>
                <th>어깨(우)</th>
                <th>허리</th>
                <th>손목(좌)</th>
                <th>손목(우)</th>
                <th rowspan="3">검진일자</th>
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
	        <s:if test="listIsNull">
	        <tr><td colspan="22">자료가 없습니다.</td></tr>
	        </s:if>
	        <s:else>
	        <s:iterator value="subData.GroupCnt" var="totalCnt">
                <tr>
                    <td rowspan="3">집계</td>
                    <td rowspan="3">${totalCnt.user_cnt}</td>
                    <s:iterator begin="1" end="7" var="stats">
                    <td><s:property value="#totalCnt['col'+#stats]"/></td>
                    </s:iterator>
                    <td rowspan="3">${dateStatsStart}<br/>~<br/>${dateStatsEnd}</td>
                    <td rowspan="3">
                        <s:set name="tot" var="totcnt" value="0"/>
                        <s:iterator begin="1" end="19" var="stats">
                            <s:set name="tot" value="#totcnt+#totalCnt['col'+#stats]" var="totcnt"/>
                        </s:iterator>
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
            
	        <s:iterator value="listData" var="data">
	            <tr>
                    <td rowspan="3">${data.rowcount }</td>
                    <td rowspan="3" class="tooltip"><span class="medi-user-patient" title=" ">${data.name }</span>
                    <input type="hidden" class="id_user" value="${data.id_user }"/>
	                <!--{id}<br/>{name}({gender_kor}) {date_birth} <br/>{phone_mobi} -->
	                <span class="tooltipView" style="display : none"></span>
	                </td>
                    <s:iterator begin="1" end="7" var="stats">
                    <td><s:property value="#data['cols'+#stats]"/></td>
                    </s:iterator>
                    <td rowspan="3">${dateStatsStart}<br/>~<br/>${dateStatsEnd}</td>
                    <td rowspan="3">
                        <s:set name="tot" var="totcnt" value="0"/>
                        <s:iterator begin="1" end="19" var="stats">
                            <s:set name="tot" value="#totcnt+#data['cols'+#stats]" var="totcnt"/>
                        </s:iterator>
                        <s:property value="#totcnt"/>
                    </td>
                </tr>
                <tr>
                    <s:iterator begin="8" end="14" var="stats">
                    <td><s:property value="#data['cols'+#stats]"/></td>
                    </s:iterator>
                </tr>
                <tr class="under-line">
                    <s:iterator begin="15" end="21" var="stats">
                    <td><s:property value="#data['cols'+#stats]"/></td>
                    </s:iterator>
                </tr>
            </s:iterator>
            
            <s:iterator value="subData.GroupCnt" var="totalCnt">
                <tr>
                    <td rowspan="3">집계</td>
                    <td rowspan="3">${totalCnt.user_cnt}</td>
                    <s:iterator begin="1" end="7" var="stats">
                    <td><s:property value="#totalCnt['col'+#stats]"/></td>
                    </s:iterator>
                    <td rowspan="3">${dateStatsStart}<br/>~<br/>${dateStatsEnd}</td>
                    <td rowspan="3">
                        <s:set name="tot" var="totcnt" value="0"/>
                        <s:iterator begin="1" end="19" var="stats">
                            <s:set name="tot" value="#totcnt+#totalCnt['col'+#stats]" var="totcnt"/>
                        </s:iterator>
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
<%-- <a:pagenav page="${param.page }" params="${params}" rowCount="${rowCount }" rowLimit="10" navCount="10" id="pagecontroller" cssClass="page-controller" font="symbol" /> --%>
<div class="footer board">
	<div class="buttons">		
		<a href="list" class="artn-button board">목록</a>
	</div>
</div>
</div>

</a:html>