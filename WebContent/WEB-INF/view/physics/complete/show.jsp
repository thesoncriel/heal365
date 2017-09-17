<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 물리치료" contents="${contentsCode }">
<div class="header">
    <h1>물리치료</h1>
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
                <s:set name="check" value="0" var="chk"/>
                    <s:iterator>
                        <s:if test="(user_name != null) && (#chk == 0)">
                        <s:set name="check" value="1" var="chk"/>
                <tr>
                        <th><label>사용자</label></th>
                        <td>${user_name }</td>
                        <th>작성자</th>
                        <td>${writer_name }</td>
                        <th>작성일</th>
                        <td>${date_upload }</td>
                        
                </tr>
                <tr>
                    <th><label>통증 부위</label></th>
                    <td colspan="5">
                        <div>
                            <a:valuelist list="목(좌),목(우),어깨(좌),어깨(우),허리,손목(좌),손목(우)
                                                   ,발목(좌),발목(우),손가락(좌),손가락(우),무릎(좌),무릎(우)
                                                   ,팔꿈치(좌),팔꿈치(우),허벅지(좌),허벅지(우),종아리(좌),종아리(우)" zero="-" value="${pain_site_check }"/>
                            <!-- <input type="hidden" name="rom" value="0"/> -->    
                        </div>
                    </td>
                </tr>
                </s:if>
                </s:iterator>
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
    		<div style="width: 49%; display: inline-block;vertical-align: top;">
                <table>
                    <tbody>
                    <s:iterator value="listData.{? (#this.position_group == 1) }">
                    	<tr>
						<th><label>${field_name }</label></th>
						<td>
						<s:if test="field_type == 0">
                          <s:if test="(field_value == null) || (field_value == '')">미측정</s:if>
                          <s:else>${field_value } ${field_unit }</s:else>
                          
                        </s:if>
                        <s:elseif test="field_type == 1">
                          <s:if test="(field_result == null) || (field_result == '')">아니오</s:if>
                          <s:else>${field_result } ${field_unit }</s:else>
                        </s:elseif>						
						</td>
						</tr>
					</s:iterator>
                    </tbody>
                </table>
            </div>
            <div style="width: 401px; display: inline-block;vertical-align: top;">
                <table>
                    <tbody>
                        <s:iterator value="listData.{? (#this.position_group == 2) }">
                    	<tr>
						<th><label>${field_name }</label></th>
						<td>
						<s:if test="field_type == 0">
                          <s:if test="(field_value == null) || (field_value == '')">미측정</s:if>
                          <s:else>${field_value } ${field_unit }</s:else>
                          
                        </s:if>
                        <s:elseif test="field_type == 1">
                          <s:if test="(field_result == null) || (field_result == '')">아니오</s:if>
                          <s:else>${field_result } ${field_unit }</s:else>
                        </s:elseif>						
						</td>
						</tr>
					</s:iterator>
                    </tbody>
                </table>
            </div>
            <%-- <div style="width: 33%; display: inline-block;vertical-align: top;">
                <table>
                    <tbody>                 
                        <s:iterator value="listData.{? (#this.position_group == 3) }">
                    	<tr>
						<th><label>${field_name }</label></th>
						<td>
						<s:if test="field_type == 0">${field_value } ${field_unit }</s:if>
						<s:elseif test="field_type == 1">${field_result } ${field_unit }</s:elseif>						
						</td>
						</tr>
					</s:iterator>               
                    </tbody>
                </table>
            </div> 
            --%>
               
       		 <div>
                <table>
                    <tbody>
                        <s:iterator value="subData.approval">
                    	<tr>
						<th><label>소견</label></th>
						<td>
								${comment_approver }
								
						</td>
						</tr>
						<tr>
						<th><label>검토자</label></th>
						<td>
								${approver_name }
								
						</td>
						</tr>
						<tr>
						<th><label>승인일자</label></th>
						<td>
								${date_approve }
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