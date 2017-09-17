<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 통합 이력관리" contents="${contentsCode }">

<div class="header">
    <h1>통합 이력관리</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="section">
<div class="article">
    <form action="stats" method="post">
    <input type="text" id="datepicker_date_stats_start" name="date_stats_start" required="required" value="${dateStatsStart }" data-year="2013" data-max-year="10" />-<input type="text" id="datepicker_date_stats_end" name="date_stats_end" required="required" value="${dateStatsEnd }" data-year="2013" data-max-year="10"/>
    <input type="hidden" name="contents" value="${params.contents }"/>
    <input type="hidden" name="id_user" value="${params.id_user }"/>
    <input type="hidden" name="id_medi" value="${params.id_medi }"/>
    <input type="submit" class="artn-button board" value="검색"/>
    </form>
    <h2 class="medi_stats_sub_header">환자정보</h2>
    <table class="board-show style2">
        <tbody class="row-scope">
            <tr>
                <th>성명</th>
                <td>${showData.user_name }</td>
                <th>ID</th>
                <td>${showData.id_user }</td>
                <th>회원 등록일</th>
                <td>${showData.date_join_fmt }</td>
            </tr>
            <tr>
                <th>핸드폰</th>
                <td>${showData.user_phone_mobi }</td>
                <th>집전화</th>
                <td>${showData.user_phone_home }</td>
                <th>이메일</th>
                <td>${showData.user_email }</td>
            </tr>
            <tr>
                <th>주소(집)</th>
                <td colspan="5">${showData.user_address_home_new }</td>
            </tr>
        </tbody>
    </table>
    <h2 class="medi_stats_sub_header">문진표</h2>
    <table class="board-list style2">
	    <thead> 
	        <tr>
	            <th>번호</th>
	            <th>작성일</th>
	            <th>키</th>
	            <th>몸무게</th>
	            <th>작성자</th>
	        </tr>   
	    </thead>
	    <tbody>
	       <s:if test="subIsNull.questionList">
	       <tr><td colspan="5">자료가 없습니다.</td></tr>
	       </s:if>
	       <s:else>
	        <s:iterator value="subData.questionList" var="data" status="status">
                <tr>
                    <td>${status.index + 1 }</td>
                    <td><a href="/medi/question/show?id_medi_question=${data.id_medi_question }&contents=sub100_9">${data.date_upload_fmt }</a></td>
                    <td>${data.height}cm</td>
                    <td>${data.weight}kg</td>                
                    <td>${data.writer_name }</td>
                </tr>
            </s:iterator>
	       </s:else>
	    </tbody>
	</table>
    <h2 class="medi_stats_sub_header">건강검진</h2>
	<table class="board-list style2">
	    <thead> 
	        <tr>
	            <th>번호</th>
	            <th>작성일</th>
	            <s:iterator value="subData.checkFieldInfo">
	            <th>${field_name }</th>
	            </s:iterator>
	            <th>작성자</th>
	        </tr>   
	    </thead>
	    <tbody>
	        <s:if test="subIsNull.checkList">
	        <tr><td colspan="<s:property value="subData.checkFieldInfo.size() + 4"/>">자료가 없습니다.</td></tr>
	        </s:if>
	        <s:else>
	        <s:iterator value="subData.checkList" var="data">
	            <tr>
	                <td>${data.row_number }</td>
	                <td><a href="/medicheck/complete/show?id_complete=${data.id_complete }&id_medi=${data.id_medi }&contents=sub100_10">${data.date_complete_fmt }</a></td>
	                <s:iterator value="subData.checkFieldInfo" var="field">
	                <td>
	                    <s:if test="(#data[#field.field_column] == null) || (#data[#field.field_column] == '')">
	                    미측정
	                    </s:if>
	                    <s:else>
	                        <s:property value="#data[#field.field_column]"/>
	                    </s:else>
	                </td>
	                </s:iterator>
	                <td>${data.writer_name }</td>
	            </tr>
	        </s:iterator>
	        </s:else>
	    </tbody>
	</table>
    <h2 class="medi_stats_sub_header">물리치료</h2>
    <table class="board-list style2">
	    <thead> 
	        <tr>
	            <th>번호</th>
	            <th>작성일</th>
	            <s:iterator value="subData.physicsFieldInfo">
	            <th>${field_name }</th>
	            </s:iterator>
	            <th>작성자</th>
	            <th>최종승인자</th>
	        </tr>   
	    </thead>
	    <tbody>
	        <s:if test="subIsNull.physicsList">
	        <tr><td colspan="<s:property value="subData.physicsFieldInfo.size() + 4"/>">자료가 없습니다.</td></tr>
	        </s:if>
	        <s:else>
	        <s:iterator value="subData.physicsList" var="data">
	            <tr>
	                <td>${data.row_number }</td>
	                <td><a href="/physics/complete/show?id_complete=${data.id_complete }&id_medi=${data.id_medi }&contents=sub100_11">${data.date_complete_fmt }</a></td>
	                <s:iterator value="subData.physicsFieldInfo" var="field">
	                <td><s:if test="(#data[#field.field_column] == '') || (#data[#field.field_column] == null)">
	                        아니오
	                    </s:if>
	                    <s:else>
	                        <s:property value="#data[#field.field_column]"/>
	                    </s:else>
	                </td>
	                </s:iterator>
	                <td>${data.writer_name }</td>
	                <td>${data.approver_name }</td>
	            </tr>
	        </s:iterator>
	        </s:else>
	    </tbody>
	</table>
    <h2 class="medi_stats_sub_header">운동처방</h2>
    <table class="board-list style2">
        <thead> 
            <tr>
                <th rowspan="3">번호</th>
                <th rowspan="3">작성일</th>
                <th>목</th>
                <th>등</th>
                <th>어깨</th>
                <th>허리</th>
                <th>엉덩이</th>
                <th>팔</th>
                <th rowspan="3">검사 항목 총계</th>
                <th rowspan="3">작성자</th>
            </tr>
            <tr>
                <th>팔꿈치</th>
                <th>손등</th>
                <th>손바닥</th>
                <th>손목</th>
                <th>허벅지</th>
                <th>무릎</th>
            </tr>
            <tr class="under-line">
                <th>종아리</th>
                <th>정강이</th>
                <th>발등</th>
                <th>발가락</th>
                <th>발바닥</th>
                <th>발목</th>
            </tr>
        </thead>
        <tbody>
            <s:if test="subIsNull.prescriptList">
            <tr><td colspan="22">자료가 없습니다.</td></tr>
            </s:if>
            <s:else>
            <s:iterator value="subData.prescriptList" var="data" status="stat">
                <tr>
                    <td rowspan="3">${stat.index + 1 }</td>
                    <td rowspan="3"><a href="/prescript/show?id=${data.id }&contents=sub100_5">${data.date_upload_fmt }</a></td>
                    <s:iterator begin="1" end="6" var="stats">
                    <td><s:property value="#data['col'+#stats]"/></td>
                    </s:iterator>
                    <td rowspan="3">
                        <s:set name="tot" var="totcnt" value="0"/>
                        <s:iterator begin="1" end="18" var="stats">
                            <s:set name="tot" value="#totcnt+#data['col'+#stats]" var="totcnt"/>
                        </s:iterator>
                        <s:property value="#totcnt"/>
                    </td>
                    <td rowspan="3">${data.therap_name }</td>
                </tr>
                <tr>
                    <s:iterator begin="7" end="12" var="stats">
                    <td><s:property value="#data['col'+#stats]"/></td>
                    </s:iterator>
                </tr>
                <tr class="under-line">
                    <s:iterator begin="13" end="18" var="stats">
                    <td><s:property value="#data['col'+#stats]"/></td>
                    </s:iterator>
                </tr>
            </s:iterator>
            </s:else>
        </tbody>
    </table>
</div>
<div class="footer board">
	<div class="buttons">
	   <s:if test="auth.isAdmin || auth.isMediStaff || auth.isNurse">
            <a href="list" class="artn-button board">목록</a>	   
	   </s:if>
	</div>
</div>
</div>

</a:html>