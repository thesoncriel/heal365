<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 처방전" contents="${contentsCode }">
<div class="header">
    <h1>운동처방</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="section">
<div class="article prescript edit">
	<h2>운동처방 <s:if test='%{showIsNull}'>추가</s:if><s:else>변경</s:else><a href="#" class="totalslideToggle">전체 보기</a></h2>	
<form class="break-enter" action="modify.action" method="post">
    <fieldset>
    	<h3 class="artn-field-header">회원정보 (신체적 특성)</h3>
    	<div  class="section user-info">
    		<table>
    			<tbody>    			
    			<tr><th><label>등록번호(ID)</label></th> <td><span class="id_reg">${showData.id_medi_fmt} - ${showData.id_fmt }</span>
    					<input type="hidden" name="id_medi" value="${showData.id_medi}"/><input type="hidden" name="id" value="${showData.id}"/><input type="hidden" name="id_pres" value="${showData.id}"/></td>
    				<th><label>성명</label></th>			<td><input type="text" id="autocomplete_user_name" data-url="/groupuser/list?json=true&id_group=${idMedi }" data-format="{user_name} ({user_date_birth}) :: {id_user}" data-field="#user_name,@user_date_birth,@id_user,@user_gender_kor,@user_age,@user_phone_mobi,@user_phone_home,@user_zipcode_home,@user_address_home1,@user_address_home2" data-type="map" data-minlen="1" name="user_name" value="${showData.user_name }"/><input type="hidden" name="id_user" value="${showData.id_user}"/></td></tr>
    			<tr><th><label>성별</label></th>			<td><span class="user_gender_kor">${showData.user_gender_kor }</span></td>
    				<th><label>나이</label></th>			<td><span class="user_age">${showData.user_age }</span>세&nbsp;(<span class="user_date_birth">${showData.user_date_birth }</span>)</td></tr>
    			<tr><th><label>핸드폰</label></th>		<td><span class="user_phone_mobi">${showData.user_phone_mobi }</span></td>
    				<th><label>집전화</label></th>		<td><span class="user_phone_home">${showData.user_phone_home }</span></td></tr>
    			<tr><th><label>주소(집)</label></th><td colspan="3">	(<span class="user_zipcode_home">${showData.user_zipcode_home }</span>)&nbsp;&nbsp;<span class="user_address_home1">${showData.user_address_home1 }</span>&nbsp;<span class="user_address_home2">${showData.user_address_home2 }</span></td></tr>
    			
    			</tbody>
    		</table>
    	</div>
    	<h3 class="artn-field-header slideToggle">문진표<span>+</span></h3>
    	<div class="medi-qustion slideUp">
    	   <input type="hidden" class="id_medi_question" name="id_medi_question" value="${showData.id_medi_question }"/>
    	   <div class="section medi-question">
    	       <table class="medi-question-top">
                <tbody>
                    <tr>
                        <th>작성일</th>
                        <td colspan="5"><span class="date_upload_fmt">${subData.mediQuestion[0].date_upload_fmt }</span></td>
                    </tr>
                    <tr>
                        <th class="css-height"><label for="height">키</label></th>
                        <td><span class="height">${subData.mediQuestion[0].height }</span>cm</td>
                        <th class="css-weight"><label for="weight">몸무게</label></th>
                        <td><span class="weight">${subData.mediQuestion[0].weight }</span>kg</td>
                        <th class="css-feet_size"><label for="feet_size">발 사이즈(신발 사이즈)</label></th>
                        <td><span class="feet_size">${subData.mediQuestion[0].feet_size }</span>mm</td>
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
                        <td>1. 고혈압 진단을 받으신적이 있습니까?
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
                        <span class="text1">${subData.mediQuestion[0].text1 }</span></td>           
                    </tr>
                    <tr>
                        <td colspan="3">6. 현재 복용중인 약물이 있습니까?</td>
                    </tr>
                    <tr>
                        <td colspan="3">6-1. 복용중인 약물:
                        <span class="text2">${subData.mediQuestion[0].text2 }</span></td>           
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
    	<h3 class="artn-field-header slideToggle">건강검진 <span>+</span></h3>
    	<div class="medi-check slideUp">
    	<input type="hidden" class="id_medi_check" name="id_medi_check" value="${showData.id_medi_check }"/>
	    	<div  class="section medi-check">
	    	    <table class="medi-question-top">
                    <tbody>
                        <tr>
                            <th style="width: 20%;">작성일</th>
                            <td colspan="5" class="date_upload_fmt">${subData.mediCheck[0].date_upload_fmt }</td>
                        </tr>
                    </tbody>
                </table>
	    		<div style="width: 33%; display: inline-block;vertical-align: top;">
	                <table>
	                    <tbody>
	                    <s:iterator value="subData.mediCheck.{? (#this.position_group == 1) }" status="group1">
	                    	<tr>
							<th class="thkim"><label>${field_name }</label></th>
							<td class="group1_${group1.index+1 }">
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
	                        <s:iterator value="subData.mediCheck.{? (#this.position_group == 2) }" status="group2">
	                    	<tr>
							<th class="thkim"><label>${field_name }</label></th>
							<td class="group2_${group2.index+1 }">
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
	                        <s:iterator value="subData.mediCheck.{? (#this.position_group == 3) }" status="group3">
	                    	<tr>
							<th><label>${field_name }</label></th>
							<td class="group3_${group3.index+1 }">
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
	    	<div class="footer board">
                <div class="buttons">
                  <a href="/medicheck/complete/list?contents=sub100_10" class="artn-button board listSearch" target="_blank">목록</a>
                </div>
            </div>
    	</div>
    	<h3 class="artn-field-header slideToggle">물리치료 <span>+</span></h3>
        <div class="physics slideUp">
        <input type="hidden" class="id_physics" name="id_physics" value="${showData.id_physics }"/>
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
                                <s:if test="showIsNull">
                                    <span class="pain_site_check"></span>
                                </s:if>
                                <s:else>
                                    <a:valuelist list="목(좌),목(우),어깨(좌),어깨(우),허리,손목(좌),손목(우)
                                                           ,발목(좌),발목(우),손가락(좌),손가락(우),무릎(좌),무릎(우)
                                                           ,팔꿈치(좌),팔꿈치(우),허벅지(좌),허벅지(우),종아리(좌),종아리(우)" zero="-" value="${subData.physics[0].pain_site_check }"/>
                                </s:else>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <div style="width: 49%; display: inline-block;vertical-align: top;">
                    <table>
                        <tbody>
                        <s:iterator value="subData.physics.{? (#this.position_group == 1) }" status="group1">
                            <tr>
                            <th class="thkim"><label>${field_name }</label></th>
                            <td class="group1_${group1.index+1 }">
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
                            <s:iterator value="subData.physics.{? (#this.position_group == 2) }" status="group2">
                            <tr>
                            <th class="thkim"><label>${field_name }</label></th>
                            <td class="group2_${group2.index+1 }">
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
                <div class="approval">
                <table>
                    <tbody>
                        <s:subset source="subData.approval">
                        <tr>
                        <th><label>소견</label></th>
                        <td class="comment_approver">
                                ${comment_approver }
                        </td>
                        </tr>
                        <tr>
                        <th><label>검토자</label></th>
                        <td class="approver_name">
                                ${approver_name }
                        </td>
                        </tr>
                        <tr>
                        <th><label>승인일자</label></th>
                        <td class="date_approve">
                                ${date_approve }
                        </td>
                        </tr>
                    </s:subset>
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
    				<tr><th><label>진단명</label></th>	<td><input type="text" name="diagnosis" value="${showData.diagnosis }"/><input type="button" class="artn-button board" value="과거병력" id="button_DiagnosisSearch"/></td>
    					<th><label>가족력</label></th>	<td><input type="text" name="family_history" value="${showData.family_history }"/></td>
    				<tr><th><label>의사명</label></th>	<td><input type="text" id="autocomplete_doctor_name" data-url="/groupuser/list?json=true&id_group=${idMedi }" data-format="{user_name} :: {id_user}" data-field="#user_name,@id_user:id_doctor" data-type="map" data-minlen="1" name="doctor_name" data-name="user_name" value="${showData.doctor_name }"/><input type="hidden" name="id_doctor" value="${showData.id_doctor}"/>
    				<%-- <span class="doctor_name">${showData.doctor_name }</span><input type="hidden" name="id_doctor" value="${showData.id_doctor}"/>--%></td>
    					<th><label>의료기관명</label></th>	<td><span class="doctor_medi">${showData.medi_name }</span></td></tr>
    				<tr><th><label>신장</label></th> <td><input type="text" name="height" value="${showData.height }"/> cm</td>
    					<th colspan="2" class="curr-sick"><label>현재 앓고 있는 질환</label></th></tr>
    				<tr><th><label>체중</label></th> <td><input type="text" name="weight" value="${showData.weight }"/> kg</td>
    					<td colspan="2" rowspan="3"><s:include value="/include/prescript/curr_sick.jsp"><s:param name="val">${showData.curr_sick }</s:param></s:include></td></tr>
    				<tr><th><label>체질량지수</label></th>	<td><input type="text" name="bmi" value="${showData.bmi }"/> kg/m2</td></tr>
    				<%-- <tr><th><label>혈압</label></th>		<td><s:include value="/include/combobox-data/prescript.jsp">
    											<s:param name="cmb">bp</s:param>
    											<s:param name="val">${showData.bp }</s:param>
   											</s:include> mmHg</td></tr> --%>
   					<tr><th><label>진단소견</label></th> <td colspan="3"><textarea name="remark">${showData.remark }</textarea></td></tr>
    			</tbody>
    		</table>
    	</div>
    	
    	<div class="footer board">
	    	<div class="buttons">
   				<a href="#" data-rule="gotoback" class="artn-button board">취소</a>
				<s:if test='%{showIsNull == true}'><input type="submit" class="artn-button board" value="추가"/></s:if>
				<s:else><input type="submit" class="artn-button board" value="변경"/></s:else>    	
			</div>
		</div>
    	<h3 class="artn-field-header slideToggle">운동 기능 검사<span>+</span></h3>
    	<div class="section exercise slideUp">
    		<input type="hidden" name="cate_movie0" value="HL"/>
    		<input type="hidden" name="cate_movie2" value="0"/>
            <input type="hidden" name="cate_movie3" value="0"/>
            <table>
    			<tbody>
    				<tr><th><label>운동사</label></th>	<td><span class="therap_name">${showData.therap_name }</span><input type="hidden" name="id_therap" value="${showData.id_therap}"/></td>
    					<td rowspan="6" class="tight">
    					<s:if test="showData.user_gender_kor == '여자'"><img id="img_painSite" src="/img/prescript-body-female.png" alt="통증부위"/></s:if>
                        <s:else><img id="img_painSite" src="/img/prescript-body.png" alt="통증부위"/></s:else>
                        </td></tr>
    				<tr><th><label>대분류</label></th>	<td><s:include value="/include/combobox-data/cate_movie.jsp">
    											<s:param name="cmb">cate_movie1</s:param>
    											<s:param name="val">${showData.cate_movie1 }</s:param>
   											</s:include></td></tr>
					<tr><th><label>VAS</label></th>		<td><s:include value="/include/combobox-data/cate_movie.jsp">
    											<s:param name="cmb">vas</s:param>
    											<s:param name="val">${showData.vas }</s:param>
   											</s:include></td></tr>
					<tr><th><label>ODI</label></th>		<td><input type="text" name="odi" style="width:80px;" value="75" /><input type="button" class="artn-button board" value="ODI"/></td></tr>
					<tr><th><label>Strengthen</label></th>		<td><input type="text" name="str" style="width:80px;" value="120"/><input type="button" class="artn-button board" value="Strengthen"/></td></tr>
					<tr><th></th><td></td></tr>
					<tr><th><label>ROM</label></th><td colspan="2" class="tight"><div id="rom">
								    				<s:include value="/include/prescript/rom.jsp">
									        		<s:param name="rom">${showData.rom}</s:param>
									        		<s:param name="cate_movie1"><s:if test="showIsNull">1</s:if><s:else>${showData.cate_movie1}</s:else></s:param>
									        		</s:include>
									        		</div></td></tr>
					<tr><th colspan="3"><label>현재 불편한 부위와 증상에 ∨ 표시하여 주십시오.</label></th></tr>
					<tr>
						<th><label>1)부위</label></th>
						<td colspan="2">
							<div>
								<a:checkboxlist name="pain_site_check" subWrap="span" id="checkboxlist_painSiteCheck" list="목(좌),목(우),어깨(좌),어깨(우),허리,손목(좌),손목(우)
								                                                                                                ,발목(좌),발목(우),손가락(좌),손가락(우),무릎(좌),무릎(우)
                                                                                                                                    ,팔꿈치(좌),팔꿈치(우),허벅지(좌),허벅지(우),종아리(좌),종아리(우)" value="${showData.pain_site_check }"/>
								<%-- <input type="hidden" name="rom" value="0"/> --%>	
							</div>
						</td>
					</tr>
					<%-- <tr>
						<th><label>2)방향</label></th>
						<td colspan="2">
							<div>
								<a:checkboxlist name="pain_dir" list="왼쪽, 가운데, 오른쪽" value="${showData.pain_dir }" type="radio"/>	
							</div>
						</td>
					</tr> --%>
					<tr>
						<th><label>2)증상</label></th>
						<td colspan="2">
							<div>
								<a:checkboxlist name="pain_type" list="당긴다, 저리다, 쑤신다, 감각이 둔하다, 마비가 된다" value="${showData.pain_type }"/>	
							</div>
						</td>
					</tr>
					<tr>
						<th><label>3)발병시기(언제부터?)</label></th>
						<td colspan="2">
							<div>
								<input type="text" name="pain_since1" value="${showData.pain_since1 }"/>
								<s:select list="#{'일':'일', '주':'주', '월':'월', '년':'년' }" value="showData.pain_since2" theme="simple" name="pain_since2"></s:select>
								
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
	    			<tr><th><label>진단일</label></th>	<td><input type="text" name="date_upload" value="${showData.date_upload_fmt }" id="datepicker_Upload"/></td>
	    				<th><label>만료일</label></th>	<td><input type="text" name="date_end" value="${showData.date_end_fmt }" id="datepicker_End"/>
									            	<s:include value="/include/combobox-data/prescript.jsp">
									            	<s:param name="cmb">date_end_week</s:param>
									            	</s:include></td></tr>
		    		<tr><th><label>운동처방 영상 제목</label></th>	<td colspan="3"><input type="text" name="subject_comb" value="${showData.subject_comb }" class="tight"/></td></tr>
	    			<tr>
	    			<th>
	    				<label>운동처방 영상 목록</label><br/><input type="button" class="artn-button board" id="anchor_AddMovie" value="개별영상 추가"/><input type="button" class="artn-button board" id="anchor_AddComb" value="조합영상 추가"/>
	    				<br/><br/>
	    				<label>일괄 변경<br/>(반복 횟수)</label>
	    				<select id="batchSelect">
	    					<option value="1">1</option>
	    					<option value="2">2</option>
	    					<option value="3">3</option>
	    					<option value="4">4</option>
	    					<option value="5">5</option>
	    					<option value="6">6</option>
	    					<option value="7">7</option>
	    					<option value="8">8</option>
	    					<option value="9">9</option>
	    					<option value="10">10</option>
	    				</select>	    				
	    			</th>
	    				<td colspan="3" class="tight">
	    				<input type="hidden" name="id_comb" value="${showData.id_comb}"/>
	    				<ul id="sortable_MovieContent" class="sotable-list">
	    				<s:iterator value="subData.combList">
							<li><span class="seq">${seq }</span>
								<a:img cssClass="file_img" src="/media/img/${file_img }" alt="${subject_movie }" srcNone="/img/Heal365-logo-mini.png" altNone="썸네일" width="80" height="50"/>
								<span class="subject_movie">${subject_movie }</span>
								<a:selectbox cssClass="repeat_cnt" name="repeat_cnt" min="0" max="10" value="${repeat_cnt }"/>
								<a class="delete" href="#">삭제</a>
								<a class="artn-button board itemup" href="#">▲</a><a class="artn-button board itemdown" href="#">▼</a>
								<input type="hidden" name="seq" value="${seq }">
								<input type="hidden" name="id_movie" value="${id_movie }">
								</li>
						</s:iterator>
							<!-- 
							<li><span class="seq">0</span>
                				<img class="file_img" src="@{if defined('file_img') && (file_img != '')}/media/img/{file_img}@{else}../../img/Heal365-logo-mini.png@{/if}" alt="{subject_movie}" alt="썸네일" width="80" height="50"/>
				                <span class="subject_movie">{subject_movie}</span>
				                <a:selectbox cssClass="repeat_cnt" name="repeat_cnt" min="0" max="10"/>
				                <a class="delete" href="#">삭제</a>
				                <a class="artn-button board itemup" href="#">▲</a><a class="artn-button board itemdown" href="#">▼</a>
				                <input type="hidden" name="seq" value="0"/>
				                <input type="hidden" name="id_movie" value="{id_movie}"/>
				                </li>
							 -->
	    				</ul>
	    				</td></tr>
    			</tbody>
    		</table>
    		<%-- <table>
    			<tbody>
    			<tr><th><label>운동빈도</label></th><td>	<s:include value="/include/combobox-data/prescript.jsp">
								            	<s:param name="cmb">frequency</s:param>
								            	<s:param name="val">${showData.frequency }</s:param>
								            	</s:include></td>
            		<th><label>운동강도</label></th><td>	<s:include value="/include/combobox-data/prescript.jsp">
								            	<s:param name="cmb">intensity</s:param>
								            	<s:param name="val">${showData.intensity }</s:param>
								            	</s:include></td>
           			<th><label>운동지속시간</label></th><td>	<s:include value="/include/combobox-data/prescript.jsp">
								            	<s:param name="cmb">duration</s:param>
								            	<s:param name="val">${showData.duration }</s:param>
								            	</s:include></td>
					<th><label>운동형태</label></th><td>	<s:include value="/include/combobox-data/prescript.jsp">
								            	<s:param name="cmb">form</s:param>
								            	<s:param name="val">${showData.form }</s:param>
								            	</s:include></td></tr>
    			</tbody>
    		</table> --%>
    	</div>
    	
    	<h3 class="artn-field-header slideToggle">운동 관리<span>+</span></h3>
    	<div class="section management slideUp">
    		<table>
    			<tbody>
    				<tr><th><label>처방후 관리</label></th>	<td><input type="text" name="after_action" value="${showData.after_action }" class="tight" /></td>
    					<th><label>진단지속</label></th>		<td><s:include value="/include/combobox-data/prescript.jsp">
												<s:param name="cmb">continued</s:param>
												<s:param name="val">${showData.continued }</s:param>
												</s:include></td></tr>
    				<tr><th><label>수행요일</label></th>		<td colspan="3" class="tight"><s:include value="/include/prescript/weekly_chk.jsp">
    												<s:param name="val">${showData.weekly_chk }</s:param>
   												</s:include></td></tr>
            		<tr><th><label>코멘트</label></th>		<td colspan="3"><textarea name="comment">${showData.comment }</textarea></td></tr>
    			</tbody>
    		</table>
    	</div>
    	
    	<input type="hidden" name="_fromPrescript" value="1"/>
		<input type="hidden" name="_write" value="1"/>
		<input type="hidden" name="status" value="${showData.status }"/>

	</fieldset>
	<div class="footer board">
	    	<div class="buttons">
	    	    <a href="#" data-rule="gotoback" class="artn-button board">취소</a>
				<s:if test='%{showIsNull == true}'><input type="submit" class="artn-button board" value="추가"/></s:if>
				<s:else><input type="submit" class="artn-button board" value="변경"/></s:else>    	
			</div>
		</div>
	
</form>

<div id="dialog_RepeatCnt" title="반복 횟수 설정">
	<form class="break-enter">
	<fieldset>
		<input id="spinner_RepeatCnt" type="text" name="spinner_repeat_cnt"/><br/>
		<input id="button_RepeatCntOK" type="button" value="확인"/>
	</fieldset>
	</form>
</div>

<div id="dialog_MovieSelector" title="개별 영상 선택기" data-width="700" data-modal="true" data-openBy="#anchor_AddMovie">
<s:include value="/WEB-INF/include/search/movie.jsp">
	<s:param name="actionURI">/movie/list?json=true</s:param>
	<s:param name="id"></s:param>
	<s:param name="asyncsearch">asyncsearch</s:param>
</s:include>

<ul id="list_StorePlaceMovie">
	<!-- 
	<li><img src="@{if defined('file_img') && (file_img != '')}/media/img/{file_img}@{else}../../img/Heal365-logo-mini.png@{/if}" title="{subject_movie}" width="56" height="36"/><span class="artn-icon-16 delete"><a href="#" class="delete">x</a></span>
		<input type="hidden" name="seq" value="0"/>
		<input type="hidden" name="id_movie" value="{id_movie}"/>
		<input type="hidden" name="file_img" value="{file_img}"/>
		<input type="hidden" name="subject_movie" value="{subject_movie}"/>
		<input type="hidden" name="repeat_cnt" value="1"/>
		<input type="hidden" name="nth" value="{nth}"/>
		<input type="hidden" name="left_right" value="{left_right}"/>
		<input type="hidden" name="popup" value="{popup}"/>
		<input type="hidden" name="popup_msg" value="{popup_msg}"/>
		<input type="hidden" name="popup_action" value="{popup_action}"/></li>
	 -->
</ul>
<ul id="infinitelist_MovieSearch" class="infinite-list" data-from="#asyncsearchform_MovieSearch" data-to="#list_StorePlaceMovie">
	<!-- 
	<li>
	<img class="file_img" src="@{if defined('file_img') && (file_img != '')}/media/img/{file_img}@{else}../../img/Heal365-logo-mini.png@{/if}" alt="{subject}" width="56" height="36" />
	<span class="subject_movie">{subject}</span>
	<button class="artn-button board select">선택</button>
	<input type="hidden" name="id_movie" value="{id_movie}"/>
	<input type="hidden" name="file_img" value="{file_img}"/>
	<input type="hidden" name="subject_movie" value="{subject_movie}"/>
	<input type="hidden" name="repeat_cnt" value="{repeat_cnt}"/>
	<input type="hidden" name="nth" value="{nth}"/>
	<input type="hidden" name="left_right" value="{left_right}"/>
	<input type="hidden" name="popup" value="{popup}"/>
	<input type="hidden" name="popup_msg" value="{popup_msg}"/>
	<input type="hidden" name="popup_action" value="{popup_action}"/></li>
	 -->
</ul>
	<%-- FIXME: 영상 검색 필드 수정 해야 함. - 2013.09.07 by jhson 
	
	 --%>

	<div class="footer board">
		<div class="buttons">
			<button id="button_SelectionComplete" class="artn-button board" type="button" data-close="close" data-rule="transfer" data-from="#list_StorePlaceMovie" data-to="#sortable_MovieContent" data-clear="from">선택 완료</button>
		</div>
    </div>  	

</div>


<div id="dialog_CombSelector" title="조합 영상 선택기" data-width="700" data-modal="true" data-openBy="#anchor_AddComb" style="display: none;">
<s:include value="/WEB-INF/include/search/comb.jsp">
	<s:param name="actionURI">/comb/list?json=true</s:param>
	<s:param name="id_group">${showData.id_medi }</s:param>
	<s:param name="asyncsearch">asyncsearch</s:param>
</s:include>

<ul id="list_StorePlaceComb">
	<!-- 
	<li><img src="@{if defined('file_img') && (file_img != '')}/media/img/{file_img}@{else}../../img/Heal365-logo-mini.png@{/if}" title="{subject_movie}" width="56" height="36"/><span class="artn-icon-16 delete"><a href="#" class="delete">x</a></span>
        <input type="hidden" name="seq" value="0"/>
        <input type="hidden" name="id_movie" value="{id_movie}"/>
        <input type="hidden" name="file_img" value="{file_img}"/>
        <input type="hidden" name="subject_movie" value="{subject_movie}"/>
        <input type="hidden" name="repeat_cnt" value="1"/>
        <input type="hidden" name="nth" value="{nth}"/>
        <input type="hidden" name="left_right" value="{left_right}"/>
        <input type="hidden" name="popup" value="{popup}"/>
        <input type="hidden" name="popup_msg" value="{popup_msg}"/>
        <input type="hidden" name="popup_action" value="{popup_action}"/></li>
	 -->
</ul>
<ul id="infinitelist_CombSearch" class="infinite-list" data-from="#asyncsearchform_CombSearch" data-to="list_StorePlaceComb">
	<!-- 
    <li>
    <img class="file_img" src="@{if defined('file_img') && (file_img != '')}/media/img/{file_img}@{else}../../img/Heal365-logo-mini.png@{/if}" alt="{subject}" width="56" height="36" />
    <span class="subject_movie">{subject}</span>
    <button class="artn-button board select">선택</button>
    <input type="hidden" name="cate_movie" value="{cate_movie}" />
    <input type="hidden" name="vas_low" value="@{if defined('vas_low') && (vas_low != '')}{vas_low}@{else}0@{/if}"/>
    <input type="hidden" name="vas_high" value="@{if defined('vas_high') && (vas_high != '')}{vas_high}@{else}0@{/if}"/>
    <input type="hidden" name="id" value="{id}"/></li>
     -->
</ul>

	<div class="footer board">
		<div class="buttons">
			<button id="button_SelectionComplete" class="artn-button board" type="button" data-close="close" data-rule="transfer" data-from="#list_StorePlaceComb" data-to="#sortable_MovieContent" data-clear="from">선택 완료</button>			
		</div>
    </div>  	

</div>

</div>
</div>
</a:html>