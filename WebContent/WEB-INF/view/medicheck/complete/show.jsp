<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 건강검진" contents="${contentsCode }">
<div class="header">
    <h1>건강검진</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="section">
<div class="article">
<fieldset>
<input name="id_user" type="hidden" value="${showData.id_user }"/>
<!-- <h3 class="artn-field-header">건강검진 </h3> -->
<div class="article prescript edit">
        <s:subset source="listData">
		<table>
			<tbody>
				<tr>
				    <s:set name="check" value="0" var="chk"/>
				    <s:iterator>
				        <s:if test="(user_name != null) && (#chk == 0)">
				        <s:set name="check" value="1" var="chk"/>
				        <th><label>사용자</label></th>
	                    <td>${user_name }</td>
	                    <th>작성자</th>
	                    <td>${writer_name }</td>
	                    <th>작성일</th>
	                    <td>${date_upload }</td>
	                    </s:if>
				    </s:iterator>
				</tr>
			</tbody>
		</table>
		</s:subset>
		<%-- <table style="width: 100%;">
			<tbody>
				<tr>
				<s:iterator value="listData.{? (#this.position_group == 0) }">										
					<th><label>${field_name }</label></th>
					<td>
					<s:if test="field_type == 0">${field_value } ${field_unit }</s:if>
					<s:elseif test="field_type == 1">${field_result }${field_unit }</s:elseif>					
					</td>
				</s:iterator>
                </tr>
			</tbody>
		</table> --%>
    	<div  class="section health-screening">
    		<div style="width: 33%; display: inline-block;vertical-align: top;">
                <table>
                    <tbody>
                    <s:iterator value="listData.{? (#this.position_group == 1) }">
                    	<tr>
						<th><label>${field_name }</label></th>
						<td>
						<s:if test="field_type == 0">
                          <s:if test="(field_value != 0.0) && ((field_value == null) || (field_value == ''))">미측정</s:if>
                          <s:else>${field_value } ${field_unit }</s:else>
                          
                        </s:if>
                        <s:elseif test="field_type == 1">
                          <s:if test="(field_result != 0.0) && ((field_result == null) || (field_result == ''))">미측정</s:if>
                          <s:else>${field_result } ${field_unit }</s:else>
                        </s:elseif>						
						</td>
						</tr>
					</s:iterator>
                    </tbody>
                </table>
            </div>
            <div style="width: 33%; display: inline-block;vertical-align: top;">
                <table>
                    <tbody>
                        <s:iterator value="listData.{? (#this.position_group == 2) }">
                    	<tr>
						<th><label>${field_name }</label></th>
						<td>
						<s:if test="field_type == 0">
                          <s:if test="(field_value != 0.0) && ((field_value == null) || (field_value == ''))">미측정</s:if>
                          <s:else>${field_value } ${field_unit }</s:else>
                          
                        </s:if>
                        <s:elseif test="field_type == 1">
                          <s:if test="(field_result != 0.0) && ((field_result == null) || (field_result == ''))">미측정</s:if>
                          <s:else>${field_result } ${field_unit }</s:else>
                        </s:elseif> 						
						</td>
						</tr>
					</s:iterator>
                    </tbody>
                </table>
            </div>
            <div style="width: 33%; display: inline-block;vertical-align: top;">
                <table>
                    <tbody>                 
                        <s:iterator value="listData.{? (#this.position_group == 3) }">
                    	<tr>
						<th><label>${field_name }</label></th>
						<td>
						<s:if test="field_type == 0">
                          <s:if test="(field_value != 0.0) && ((field_value == null) || (field_value == ''))">미측정</s:if>
                          <s:else>${field_value } ${field_unit }</s:else>
                          
                        </s:if>
                        <s:elseif test="field_type == 1">
                          <s:if test="(field_result != 0.0) && ((field_result == null) || (field_result == ''))">미측정</s:if>
                          <s:else>${field_result } ${field_unit }</s:else>
                        </s:elseif>						
						</td>
						</tr>
					</s:iterator>               
                    </tbody>
                </table>
            </div>
    	</div>
</div>
</fieldset>
<div class="footer board">
	<div class="buttons">		
		<a href="list?contents=${params.contents }" class="artn-button board">목록</a>
	</div>
</div>
</div>
</div>

</a:html>