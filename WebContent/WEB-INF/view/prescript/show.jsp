<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 처방전" contents="${contentsCode }">
<s:bean name="artn.common.ComboboxDataMaker" var="cmbMaker"></s:bean>
<s:set var="now" value='%{util.now}'/>
<div class="header">
    <h1>처방전</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="section">
<s:if test='%{ (auth.isGroupStaff || auth.isAdmin || auth.isNurse) }'>
    <button id="button_printPrescript">처방전 인쇄</button>
</s:if>
<div class="article prescript show">
    <h2>처방전 <s:if test='%{showIsNull}'>추가</s:if><s:else>보기</s:else><a href="#" class="totalslideToggle">전체 보기</a></h2>
	<form action="modify.action" method="post">
        <h3 class="artn-field-header">회원정보 (신체적 특성)</h3>
        <div class="section user-info">
            <table>
                <tbody>
                <tr><th>등록번호(ID)</th> <td class="half">${showData.id_medi_fmt} - ${showData.id_fmt }</td>
                    <th>성명</th>         <td>${showData.user_name }<input type="hidden" name="id_user" value="${showData.id_user }"/></td></tr>
                <tr><th>성별</th>         <td>${showData.user_gender_kor }</td>
                    <th>나이</th>         <td>${showData.user_age }세&nbsp;(${showData.user_date_birth })</td></tr>
                <tr><th>핸드폰</th>        <td>${showData.user_phone_mobi }</td>
                    <th>집전화</th>        <td>${showData.user_phone_home }</td></tr>
                <tr><th>주소(집)</th><td colspan="3">  ${showData.user_zipcode_home }&nbsp;&nbsp;${showData.user_address_home1 }&nbsp;${showData.user_zipcode_corp2 }</td></tr>
                </tbody>
            </table>
        </div>
        <h3 class="artn-field-header slideToggle">문진표<span>+</span></h3>
        <div class="medi-question slideUp">
            <div class="section medi-question">
	           <table class="medi-question-top">
	                <tbody>
	                    <tr>
	                        <th>작성일</th>
	                        <td colspan="5">${subData.mediQuestion[0].date_upload_fmt }</td>
	                    </tr>
	                    <tr>
	                        <th class="css-height"><label for="height">키</label></th>
	                        <td>${subData.mediQuestion[0].height }cm</td>
	                        <th class="css-weight"><label for="weight">몸무게</label></th>
	                        <td>${subData.mediQuestion[0].weight }kg</td>
	                        <th class="css-feet_size"><label for="feet_size">발 사이즈(신발 사이즈)</label></th>
	                        <td>${subData.mediQuestion[0].feet_size }mm</td>
	                    </tr>
	                </tbody>
	            </table>            
	            <table class="medi-question-bottom">
	                <tbody>
	                    <tr>
	                        <th><label>[혈압관리]</label></th>
	                        <th class="check-radio">예</th>
	                        <th class="check-radio">아니오</th>
	                    </tr>
	                    <tr>
	                        <td><span>1. 고혈압 진단을 받으신적이 있습니까?</span>
	                        <a:surveyradio name="check" value="${subData.mediQuestion[0].check }" offset="0" subWrap="td" wrap="none" unchecked="${showIsNull}" labelShow="false" disabled="disabled"/>         
	                    </tr>
	                    <tr>
	                        <td>1-1. 진단을 받은적이 있다면 현재 복용하는 약이 있습니까?
	                        <a:surveyradio name="check" value="${subData.mediQuestion[0].check }" offset="1" subWrap="td" wrap="none" unchecked="${showIsNull}" labelShow="false" disabled="disabled"/>
	                    </tr>
	                    <tr>
	                        <td>2. 가족중에 고혈압을 앓고 계신분은 있습니까?
	                        <a:surveyradio name="check" value="${subData.mediQuestion[0].check }" offset="2" subWrap="td" wrap="none" unchecked="${showIsNull}" labelShow="false" disabled="disabled"/>
	                    </tr>
	                    <tr>
	                        <th><label>[당뇨관리]</label></th>
	                        <th class="check-radio">예</th>
	                        <th class="check-radio">아니오</th>
	                    </tr>
	                    <tr>
	                        <td>3. 당뇨병 진단을 받은적이 있습니까?
	                        <a:surveyradio name="check" value="${subData.mediQuestion[0].check }" offset="3" subWrap="td" wrap="none" unchecked="${showIsNull}" labelShow="false" disabled="disabled"/>
	                    </tr>
	                    <tr>
	                        <td>3-1. 진단을 받은적이 있다면 현재 복용하는 약이 있습니까?
	                        <a:surveyradio name="check" value="${subData.mediQuestion[0].check }" offset="4" subWrap="td" wrap="none" unchecked="${showIsNull}" labelShow="false" disabled="disabled"/>
	                    </tr>
	                    <tr>
	                        <td>4. 가족중에 당뇨병을 알고 계신분은 있습니까?
	                        <a:surveyradio name="check" value="${subData.mediQuestion[0].check }" offset="5" subWrap="td" wrap="none" unchecked="${showIsNull}" labelShow="false" disabled="disabled"/>
	                    </tr>
	                    <tr>
	                        <th colspan="3"><label>[기타]</label></th>
	                    </tr>
	                    <tr>
	                        <td colspan="3">5. 현재진단받은 질환이 있습니까?</td>
	                    </tr>
	                    <tr>
	                        <td colspan="3">5-1. 진단받은 질환:
	                        ${subData.mediQuestion[0].text1 }</td>           
	                    </tr>
	                    <tr>
	                        <td colspan="3">6. 현재 복용중인 약물이 있습니까?</td>
	                    </tr>
	                    <tr>
	                        <td colspan="3">6-1. 복용중인 약물:
	                        ${subData.mediQuestion[0].text2 }</td>           
	                    </tr>
	                </tbody>
	            </table>
	        </div>
	        <div class="footer board">
                <div class="buttons">
                    <a href="/medi/question/list.action?contents=sub100_9" class="artn-button board listSearch" target="_blank">목록</a>
                </div>
            </div>
        </div>
        <s:if test="subIsNull.mediCheck == false">
        <h3 class="artn-field-header slideToggle">건강검진<span>+</span></h3>
    	<div class="medi-check slideUp">
	    	<%-- <table style="width: 100%;">
				<tbody>
					<tr>
					<s:iterator value="subData.mediCheck.{? (#this.position_group == 0) }">										
						<th><label>${field_name }</label></th>
						<td>
						<s:if test="field_type == 0">${field_value } ${field_unit }</s:if>
						<s:elseif test="field_type == 1">${field_result }${field_unit }</s:elseif>					
						</td>
					</s:iterator>
	                </tr>
				</tbody>
			</table> --%>
	    	<div class="section medi-check">
	    	     <table class="medi-question-top">
	                <tbody>
	                    <tr>
	                        <th style="width: 20%;">작성일</th>
	                        <td colspan="5">${subData.mediCheck[0].date_upload_fmt }</td>
	                    </tr>
	                </tbody>
	            </table>
	    		<div style="width: 33%; display: inline-block;vertical-align: top;">
	                <table>
	                    <tbody>
	                    <s:iterator value="subData.mediCheck.{? (#this.position_group == 1) }">
	                    	<tr>
							<th><label>${field_name }</label></th>
							<td>
							<s:if test="field_type == 0">
	                          <s:if test="(field_value == null) || (field_value == '')">미측정</s:if>
	                          <s:else>${field_value } ${field_unit }</s:else>
	                          
	                        </s:if>
	                        <s:elseif test="field_type == 1">
	                          <s:if test="(field_result == null) || (field_result == '')">미측정</s:if>
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
	                        <s:iterator value="subData.mediCheck.{? (#this.position_group == 2) }">
	                    	<tr>
							<th><label>${field_name }</label></th>
							<td>
							<s:if test="field_type == 0">
                              <s:if test="(field_value == null) || (field_value == '')">미측정</s:if>
                              <s:else>${field_value } ${field_unit }</s:else>
                              
                            </s:if>
                            <s:elseif test="field_type == 1">
                              <s:if test="(field_result == null) || (field_result == '')">미측정</s:if>
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
	                        <s:iterator value="subData.mediCheck.{? (#this.position_group == 3) }">
	                    	<tr>
							<th><label>${field_name }</label></th>
							<td>
							<s:if test="field_type == 0">
                              <s:if test="(field_value == null) || (field_value == '')">미측정</s:if>
                              <s:else>${field_value } ${field_unit }</s:else>
                              
                            </s:if>
                            <s:elseif test="field_type == 1">
                              <s:if test="(field_result == null) || (field_result == '')">미측정</s:if>
                              <s:else>${field_result } ${field_unit }</s:else>
                            </s:elseif>						
							</td>
							</tr>
						</s:iterator>               
	                    </tbody>
	                </table>
	            </div>
	    	</div>
    	    <%-- <table>
                <tbody>
                    <tr>
                        <th>작성일</th>
                        <td colspan="5">${subData.mediCheck[0].date_upload_fmt }</td>
                    </tr>
                </tbody>
            </table>
            <table>
                <tbody>
                	<tr>
	    				<th><label>키</label></th>    				
	    				<td>${subData.mediCheck[0].body_height }cm</td>
	    				<th><label>체중</label></th>    				
	    				<td>${subData.mediCheck[0].body_weight }Kg</td> 
	    			</tr>
                </tbody>
            </table>
	    	<div style="width: 33%; display: inline-block; vertical-align: top;">
	    		<table>
	    			<tbody>
		    			<tr>
		    				<th><label>혈압측정(상):</label></th>    				
		    				<td>${subData.mediCheck[0].bp_high }mmHg</td> 
		    			</tr>
		    			<tr>
		    				<th><label>혈압측정(하):</label></th>    				
		    				<td>${subData.mediCheck[0].bp_low }mmHg</td> 
		    			</tr>
		    			<tr>
		    				<th><label>혈당측정:</label></th>    				
		    				<td>${subData.mediCheck[0].glucose }mg/dℓ</td> 
		    			</tr>
		    			<tr>
		    				<th><label>Hb 검사(빈혈 검진):</label></th>    				
		    				<td>${subData.mediCheck[0].hb }g/dℓ</td> 
		    			</tr>
		    			<tr>
		    				<th><label>당화혈색소:</label></th>    				
		    				<td>${subData.mediCheck[0].hba1c }%</td> 
		    			</tr>
		    			<tr>
		    				<th><label>니코틴</label></th>    				
		    				<td><a:valuelist list="양성, 무효, 음성" zero="-" value="${subData.mediCheck[0].nicotine }"/> </td> 
		    			</tr>
		    			<tr>
		    				<th><label>요성분</label></th>    				
		    				<td><a:valuelist list="양성, 음성" zero="-" value="${subData.mediCheck[0].pee }"/>  </td> 
		    			</tr>
		    			<tr>
		    				<th><label>T-Score</label></th>    				
		    				<td>${subData.mediCheck[0].tscore }</td>
	    				</tr>
		    		</tbody>
	    		</table>
	    	</div>
	    	<div style="width: 33%; display: inline-block;vertical-align: top;">
	    		<table>
	    			<tbody>	    			
		    			<tr>
		    				<th><label>골격근량</label></th>    				
		    				<td>${subData.mediCheck[0].body_skel_muscle }Kg</td> 
		    			</tr>
		    			<tr>
		    				<th><label>체지방량</label></th>    				
		    				<td>${subData.mediCheck[0].body_fat }Kg</td> 
		    			</tr>
		    			<tr>
		    				<th><label>복부지방률</label></th>    				
		    				<td>${subData.mediCheck[0].body_wh_fat_ratio }</td> 
		    			</tr>
		    			<tr>
		    				<th><label>내장지방</label></th>    				
		    				<td>
		    					${subData.mediCheck[0].body_vis_fat } 레벨
		    				</td> 
		    			</tr>	    			
		    			<tr>
		    				<th><label>상체강도</label></th>    				
		    				<td><a:valuelist list="표준, 발달, 허약" zero="-" value="${subData.mediCheck[0].body_upper_str }"/> </td> 
		    			</tr>
		    			<tr>
		    				<th><label>하체강도</label></th>    				
		    				<td><a:valuelist list="표준, 발달, 허약" zero="-" value="${subData.mediCheck[0].body_lower_str }"/></td> 
		    			</tr>
		    			<tr>
		    				<th><label>근육강도</label></th>    				
		    				<td><a:valuelist list="표준, 발달, 허약" zero="-" value="${subData.mediCheck[0].body_muscle_str }"/> </td> 
		    			</tr>		    			
	    			</tbody>
	    		</table>
    		</div>
	    	<div style="width: 33%; display: inline-block;vertical-align: top;">
	    		<table>
	    			<tbody>		    			
	    				<tr>
		    				<th><label>TC (총 콜레스테롤)</label></th>    				
		    				<td>${subData.mediCheck[0].chol_tc }mg/dℓ</td> 
	    				</tr>
	    				<tr>
		    				<th><label>HDL-C (좋은 콜레스테롤)</label></th>    				
		    				<td>${subData.mediCheck[0].chol_tc }mg/dℓ</td> 
	    				</tr> 
	    				<tr>
		    				<th><label>TRG (중성지방)</label></th>    				
		    				<td>${subData.mediCheck[0].chol_trg }mg/dℓ</td> 
	    				</tr>
						<tr>
		    				<th><label>LDL-C (나쁜 콜레스테롤)</label></th>    				
		    				<td>${subData.mediCheck[0].chol_ldl_c }mg/dℓ</td> 
	    				</tr>
	    				<tr>
		    				<th><label>non-HDL <span class="non-HDL">(대사성증후군 지표)</span></label></th>    				
		    				<td>${subData.mediCheck[0].chol_non_hdl }mg/dℓ</td> 
	    				</tr>
	    				<tr>
		    				<th><label>TC/HDL (동맥경화지수)</label></th>    				
		    				<td>${subData.mediCheck[0].chol_tc_hdl }mg/dℓ</td> 
	    				</tr>
	    				<tr>
		    				<th><label>GLU (혈당)</label></th>    				
		    				<td>${subData.mediCheck[0].chol_glucose }mg/dℓ</td> 
	    				</tr>
		    		</tbody>
	    		</table>
	    	</div>	  --%>
	    	<div class="footer board">
                <div class="buttons">
	    	      <a href="/medicheck/complete/list?contents=sub100_10" class="artn-button board listSearch" target="_blank">목록</a>
	    	    </div>
	    	</div>   	
    	</div>
        </s:if>
        <h3 class="artn-field-header slideToggle">물리치료 <span>+</span></h3>
        <div class="physics slideUp">
            <div  class="section physics">
                <table class="medi-question-top">
                    <tbody>
                        <tr>
                            <th style="width: 20%;">작성일</th>
                            <td colspan="5" class="date_upload_fmt">${subData.physics[0].date_upload_fmt }</td>
                        </tr>
                        <tr>
                        <th><label>부위</label></th>
                        <td colspan="5">
                            <div>
                                <a:valuelist list="목(좌),목(우),어깨(좌),어깨(우),허리,손목(좌),손목(우)
                                                       ,발목(좌),발목(우),손가락(좌),손가락(우),무릎(좌),무릎(우)
                                                       ,팔꿈치(좌),팔꿈치(우),허벅지(좌),허벅지(우),종아리(좌),종아리(우)" zero="-" value="${subData.physics[0].pain_site_check }"/>
                                                                                      
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <div style="width: 49%; display: inline-block;vertical-align: top;">
                    <table>
                        <tbody>
                        <s:iterator value="subData.physics.{? (#this.position_group == 1) }">
                            <tr>
                            <th class="thkim"><label>${field_name }</label></th>
                            <td>
                            <s:if test="field_type == 0">
                              <s:if test="(field_value == null) || (field_value == '')">미측정</s:if>
                              <s:else>${field_value } ${field_unit }</s:else>
                              
                            </s:if>
                            <s:elseif test="field_type == 1">
                              <s:if test="(field_result == null) || (field_result == '')">미측정</s:if>
                              <s:else>${field_result } ${field_unit }</s:else>
                            </s:elseif>                     
                            </td>
                            </tr>
                        </s:iterator>
                        </tbody>
                    </table>
                </div>
                <div style="width: 49%; display: inline-block;vertical-align: top;">
                    <table>
                        <tbody>
                            <s:iterator value="subData.physics.{? (#this.position_group == 2) }">
                            <tr>
                            <th class="thkim"><label>${field_name }</label></th>
                            <td>
                            <s:if test="field_type == 0">
                              <s:if test="(field_value == null) || (field_value == '')">미측정</s:if>
                              <s:else>${field_value } ${field_unit }</s:else>
                            </s:if>
                            <s:elseif test="field_type == 1">
                              <s:if test="(field_result == null) || (field_result == '')">미측정</s:if>
                              <s:else>${field_result } ${field_unit }</s:else>
                            </s:elseif>                     
                            </td>
                            </tr>
                        </s:iterator>
                        </tbody>
                    </table>
                </div>
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
            <div class="footer board">
                <div class="buttons">
                  <a href="/physics/complete/list?contents=sub100_11" class="artn-button board listSearch" target="_blank">목록</a>
                </div>
            </div>
        </div>
        <h3 class="artn-field-header slideToggle">진단 및 병력 (신체적 특성)<span>+</span></h3>
        <div class="section diagnosis slideUp">
            <table>
                <tbody>
                    <tr><th>진단명</th>    <td class="half">${showData.diagnosis }</td>
                        <th>가족력</th>    <td>${showData.family_history }</td></tr>
                    <tr><th>의사명</th>    <td>${showData.doctor_name }</td>
                        <th>의료기관명</th>  <td>${showData.medi_name }</td></tr>
                    <tr><th>신장</th> <td>${showData.height } cm</td>
                        <th colspan="2" class="curr-sick">현재 앓고 있는 질환</th></tr>
                    <tr><th>체중</th> <td>${showData.weight } kg</td>
                        <td colspan="2" rowspan="3"><s:include value="/include/prescript/curr_sick.jsp"><s:param name="show">yes</s:param><s:param name="val">${showData.curr_sick }</s:param></s:include></td></tr>
                    <tr><th>체질량지수</th>  <td>${showData.bmi } kg/m2</td></tr>
                    <tr><th>혈압</th>     <td>${showData.bp } mmHg</td></tr>
                    <tr><th>진단소견</th> <td colspan="3">${showData.remark }</td></tr>
                </tbody>
            </table>            
        </div>
        
        <h3 class="artn-field-header slideToggle">운동 기능 검사<span>+</span></h3>
        <div class="section exercise slideUp">
            <input type="hidden" name="cate_movie0" value="HL"/>
            <input type="hidden" name="cate_movie2" value="0"/>
            <input type="hidden" name="cate_movie3" value="0"/>            
            <table>
                <tbody>
                    <tr><th>운동사</th> <td>${showData.therap_name }</td>
                        <td rowspan="6" class="tight" width="460">
                        <s:if test="showData.user_gender_kor == '남자'"><img src="/img/prescript-body.png" alt="통증부위"/></s:if>
                        <s:else><img src="/img/prescript-body-female.png" alt="통증부위"/></s:else>
                        </td></tr>
                    <tr><th>대분류</th> <td><s:include value="/include/combobox-data/cate_movie.jsp">
    											<s:param name="cmb">cate_movie1</s:param>
    											<s:param name="val">${showData.cate_movie1 }</s:param>
    											<s:param name="sub">HL_kor</s:param>
   											</s:include></td></tr>
                    <tr><th>VAS</th>     <td>${showData.vas }</td></tr>
                    <tr><th>ODI</th>     <td>${showData.odi }</td></tr>
                    <tr><th>Strengthen</th>      <td>${showData.str }</td></tr>
                    <tr><th></th><td></td></tr>
                    <tr><th>ROM</th><td colspan="2" class="tight"><div id="rom">
                                                    <s:include value="/include/prescript/rom.jsp">
                                                    <s:param name="rom">${showData.rom}</s:param>
                                                    <s:param name="cate_movie1">${showData.cate_movie1}</s:param>
                                                    <s:param name="show">yes</s:param>
                                                    </s:include>
                                                    </div></td></tr>
                                                    
                    <tr><th colspan="3"><label>현재 불편한 부위와 증상에 ∨ 표시하여 주십시오.</label></th></tr>
					<tr>
						<th><label>1)부위</label></th>
						<td colspan="2">
							<div>
								<a:valuelist list="목(좌),목(우),어깨(좌),어깨(우),허리,손목(좌),손목(우)
                                                       ,발목(좌),발목(우),손가락(좌),손가락(우),무릎(좌),무릎(우)
                                                       ,팔꿈치(좌),팔꿈치(우),허벅지(좌),허벅지(우),종아리(좌),종아리(우)" zero="-" value="${showData.pain_site_check }"/>
								<!-- <input type="hidden" name="rom" value="0"/> -->	
							</div>
						</td>
					</tr>
					<%-- <tr>
						<th><label>2)방향</label></th>
						<td colspan="2">
							<div>
								<a:valuelist list="왼쪽, 가운데, 오른쪽" zero="-" value="${showData.pain_dir }"/>
							</div>
						</td>
					</tr> --%>
					<tr>
						<th><label>2)증상</label></th>
						<td colspan="2">
							<div>
								<a:valuelist list="당긴다, 저리다, 쑤신다, 감각이 둔하다, 마비가 된다" zero="-" value="${showData.pain_type }"/>
							</div>
						</td>
					</tr>
					<tr>
						<th><label>3)발병시기(언제부터?)</label></th>
						<td colspan="2">
							<div>
								${showData.pain_since }								
								<%-- <select name="pain_since">
									<option value="일">일</option>
									<option value="주">주</option>
									<option value="월">월</option>
									<option value="년">년</option>
								</select> --%>
							</div>
						</td>
					</tr>
                </tbody>
            </table>
        </div>
        
        <h3 class="artn-field-header slideToggle">운동 처방<span>+</span></h3>
        <div class="section comb slideUp">
            <table>
                <tbody>
                    <tr><th>진단일</th> <td>${showData.date_upload_fmt }</td>
                        <th>만료일</th> <td>${showData.date_end_fmt }</td></tr>
                    <tr><th>운동처방 영상 제목</th>  <td colspan="3">${showData.subject_comb }</td></tr>
                    
                    <tr><th>운동처방 영상 목록<br/>
                    		<s:if test='%{auth.isMediStaff || (showData.date_end >= #now)}'><a class="artn-button board" href="/player/player?id=${showData.id_comb}&menu=${param.menu}&depth=list&contents=${contentsCode }&to_list=/prescript/list" class="browserCheck">영상 미리보기</a></s:if></th>
                        <td colspan="3" class="tight">
                        	<table class="prescript-movie-list">
                        		<thead>
                        			<tr>
                        			<th class="_seq">순서</th><th class="_thumb">썸네일</th><th class="_subject">제목</th><th class="_repeat-cnt">반복 횟수</th>
                        			</tr>
                        		</thead>
                        		<tbody>
                        		<s:iterator value="subData.combList">
                        			<tr>
                        			<td>${seq }</td>
                        			<td class="_thumb"><a:img cssClass="file_img" src="/media/img/${file_img }" alt="${subject_movie }" srcNone="/img/Heal365-logo-mini.png" altNone="${subject_movie }" width="80" height="50" /></td>
                        			<td class="_subject">${subject_movie }</td>
                        			<td>${repeat_cnt }</td></tr>
		                        </s:iterator>
                        		</tbody>
                        	</table>
                        </td></tr>
                	
                </tbody>
            </table>
            <%-- <table>
                <tbody>
                <tr><th>운동빈도</th><td>    ${showData.frequency }</td>
                    <th>운동강도</th><td>    ${showData.intensity }</td>
                    <th>운동지속시간</th><td>  ${showData.duration }</td>
                    <th>운동형태</th><td>    ${showData.form }</td></tr>
                </tbody>
            </table> --%>
        </div>
        
        <h3 class="artn-field-header slideToggle">운동 관리<span>+</span></h3>
        <div class="section management slideUp">
            <table>
                <tbody>
                    <tr><th>처방후 관리</th>  <td>${showData.after_action }</td>
                        <th>진단지속</th>        <td>${showData.continued_kor }</td></tr>
                    <tr><th>수행요일</th>        <td colspan="3" class="tight"><s:include value="/include/prescript/weekly_chk.jsp">
                                                    <s:param name="val">${showData.weekly_chk }</s:param>
                                                    <s:param name="show">yes</s:param>
                                                </s:include></td></tr>
                    <tr><th>코멘트</th>     <td colspan="3">${showData.comment }</td></tr>
                </tbody>
            </table>
        </div>
        
        <input type="hidden" name="_fromPrescript" value="1"/>
        <input type="hidden" name="id_comb" value="${showData.id_comb}"/>
        <s:if test='%{showIsNull == false}'>
        <input type="hidden" name="id" value="${showData.id}"/>
        <input type="hidden" name="id_pres" value="${showData.id}"/></s:if>
        <s:else>
        <input type="hidden" name="_write" value="1"/>
        </s:else>
    <div class="footer board">
	    <div class="buttons">
                <a href="#" data-rule="gotoback" class="artn-button board">목록</a>
		   	<s:if test='%{auth.isMediStaff}'>
	   			<a href="edit.action?id=${showData.id }&contents=${contentsCode }" class="artn-button board">수정</a>
			</s:if>
		</div>
	</div>
</form>

</div>
</div>
</a:html>