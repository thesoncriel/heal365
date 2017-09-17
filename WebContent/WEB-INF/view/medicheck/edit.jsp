<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 건강검진" contents="${contentsCode }">
<div class="header">
    <h1>건강검진 <s:if test="showIsNull">작성</s:if><s:else>수정</s:else></h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="section">
<div class="article">
<form action="modify" method="post" enctype="multipart/form-data" class="validator">
<fieldset>
이름:<input type="text" id="autocomplete_user_name" data-url="/groupuser/list?json=true&id_group=${idMedi }" data-format="{user_name} ({user_date_birth}) :: {id_user}" data-field="#user_name,@id_user" data-type="map" data-minlen="1" name="user_name" value="${showData.user_name }" required="required" title="환자명을 입력하세요."/>
<input name="id_user" type="hidden" value="${showData.id_user }"/>
<input type="hidden" name="id_writer" value="${user.id }">
<input type="hidden" name="writer_name" value="${user.name }">
<!-- <h3 class="artn-field-header">건강검진 </h3> -->
<div class="article prescript edit">
		<table style="width: 100%;">
			<tbody>
				<tr>
                    <th><label>키</label></th>                  
                    <td><input type="text" name="body_height" value="${showData.body_height }" data-rule="dec" title="숫자만 입력 가능합니다."/>cm</td>
                    <th><label>체중</label></th>                  
                    <td><input type="text" name="body_weight" value="${showData.body_weight }" data-rule="dec" title="숫자만 입력 가능합니다."/>Kg</td>
                </tr>
			</tbody>
		</table>
    	<div  class="section health-screening">
    		<div style="width: 33%; display: inline-block;vertical-align: top;">
                <table>
                    <tbody>
                        <tr>
                            <th><label>혈압측정(상)</label></th>                 
                            <td><input type="text" name="bp_high" value="${showData.bp_high }" data-rule="dec" title="숫자만 입력 가능합니다."/>mmHg</td> 
                        </tr>
                        <tr>
                            <th><label>혈압측정(하)</label></th>                 
                            <td><input type="text" name="bp_low" value="${showData.bp_low }" data-rule="dec" title="숫자만 입력 가능합니다."/>mmHg</td> 
                        </tr>
                        <tr>
                            <th><label>혈당측정</label></th>                    
                            <td><input type="text" name="glucose" value="${showData.glucose }" data-rule="dec" title="숫자만 입력 가능합니다."/>mg/dℓ</td> 
                        </tr>
                        <tr>
                            <th><label>Hb 검사(빈혈 검진)</label></th>                    
                            <td><input type="text" name="hb" value="${showData.hb }" data-rule="dec" title="숫자만 입력 가능합니다."/>g/dℓ</td> 
                        </tr>
                        <tr>
                            <th><label>당화혈색소</label></th>                   
                            <td><input type="text" name="hba1c" value="${showData.hba1c }" data-rule="dec" title="숫자만 입력 가능합니다."/>%</td> 
                        </tr>
                        <tr>
                            <th><label>니코틴</label></th>                 
                            <td>
                            <s:select id="selectbox_nicotine" name="nicotine" value="showData.nicotine" list="#{'1':'양성','2':'무효','3':'음성' }" headerKey="0" headerValue="선택안됨" emptyOption="false" theme="simple" />
                            <%-- <a:checkboxlist name="nicotine" list="양성, 무효, 음성" value="${showData.nicotine }" type="radio"/> --%> </td> 
                        </tr>
                        <tr>
                            <th><label>요성분</label></th>                 
                            <td>
                            <s:select id="selectbox_pee" name="pee" value="showData.pee" list="#{'1':'양성','2':'음성' }" headerKey="0" headerValue="선택안됨" emptyOption="false" theme="simple" />
                            <%-- <a:checkboxlist name="pee" list="양성, 음성" value="${showData.pee }" type="radio"/> --%> </td> 
                        </tr>
                        <tr>
                        <th><label>T-Score</label></th>                 
                        <td><input type="text" name="tscore" value="${showData.tscore }" data-rule="dec" title="숫자만 입력 가능합니다."/></td> 
                    </tr>
                    </tbody>
                </table>
            </div>
            <div style="width: 33%; display: inline-block;vertical-align: top;">
                <table>
                    <tbody>
                        <tr>
                            <th><label>골격근량</label></th>                    
                            <td><input type="text" name="body_skel_muscle" value="${showData.body_skel_muscle }" data-rule="dec" title="숫자만 입력 가능합니다."/>Kg</td> 
                        </tr>
                        <tr>
                            <th><label>체지방량</label></th>                    
                            <td><input type="text" name="body_fat" value="${showData.body_fat }" data-rule="dec" title="숫자만 입력 가능합니다."/>Kg</td> 
                        </tr>
                        <tr>
                            <th><label>복부지방률</label></th>                   
                            <td><input type="text" name="body_wh_fat_ratio" value="${showData.body_wh_fat_ratio }" data-rule="dec" title="숫자만 입력 가능합니다."/></td> 
                        </tr>
                        <tr>
                            <th><label>내장지방</label></th>                    
                            <td>
                                <s:select list="#{1:'1레벨', 2:'2레벨', 3:'3레벨', 4:'4레벨', 5:'5레벨', 6:'6레벨', 7:'7레벨', 8:'8레벨', 9:'9레벨', 10:'10레벨'}" value="showData.body_vis_fat" theme="simple" name="body_vis_fat"></s:select>
                                <%-- <select name="body_vis_fat">
                                    <option value="1">1레벨</option>
                                    <option value="2">2레벨</option>
                                    <option value="3">3레벨</option>
                                    <option value="4">4레벨</option>
                                    <option value="5">5레벨</option>
                                    <option value="6">6레벨</option>
                                    <option value="7">7레벨</option>
                                    <option value="8">8레벨</option>
                                    <option value="9">9레벨</option>
                                    <option value="10">10레벨</option>                                
                                </select> --%>
                            </td> 
                        </tr>
                        <tr>
                            <th><label>상체강도</label></th>                    
                            <td>
                            <s:select id="selectbox_body_upper_str" name="body_upper_str" value="showData.body_upper_str" list="#{'1':'표준','2':'발달','3':'허약' }" headerKey="0" headerValue="선택안됨" emptyOption="false" theme="simple" />
                            <%-- <a:checkboxlist name="body_upper_str" list="표준, 발달, 허약" value="${showData.body_upper_str }" type="radio"/> --%> </td> 
                        </tr>
                        <tr>
                            <th><label>하체강도</label></th>                    
                            <td>
                            <s:select id="selectbox_body_lower_str" name="body_lower_str" value="showData.body_lower_str" list="#{'1':'표준','2':'발달','3':'허약' }" headerKey="0" headerValue="선택안됨" emptyOption="false" theme="simple" />
                            <%-- <a:checkboxlist name="body_lower_str" list="표준, 발달, 허약" value="${showData.body_lower_str }" type="radio"/>  --%></td> 
                        </tr>
                        <tr>
                            <th><label>근육강도</label></th>                    
                            <td>
                            <s:select id="selectbox_body_muscle_str" name="body_muscle_str" value="showData.body_muscle_str" list="#{'1':'표준','2':'발달','3':'허약' }" headerKey="0" headerValue="선택안됨" emptyOption="false" theme="simple" />
                            <%-- <a:checkboxlist name="body_muscle_str" list="표준, 발달, 허약" value="${showData.body_muscle_str }" type="radio"/> --%> </td> 
                        </tr>
                    </tbody>
                </table>
            </div>
            <div style="width: 33%; display: inline-block;vertical-align: top;">
                <table>
                    <tbody>                 
                        <tr>
                            <th><label>TC (총 콜레스테롤)</label></th>                    
                            <td><input type="text" name="chol_tc" value="${showData.chol_tc }" data-rule="dec" title="숫자만 입력 가능합니다."/>mg/dℓ</td> 
                        </tr>
                        <tr>
                            <th><label>HDL-C (좋은 콜레스테롤)</label></th>                    
                            <td><input type="text" name="chol_hdl_c" value="${showData.chol_tc }" data-rule="dec" title="숫자만 입력 가능합니다."/>mg/dℓ</td> 
                        </tr> 
                        <tr>
                            <th><label>TRG (중성지방)</label></th>                  
                            <td><input type="text" name="chol_trg" value="${showData.chol_trg }" data-rule="dec" title="숫자만 입력 가능합니다."/>mg/dℓ</td> 
                        </tr> 
                        <tr>
                            <th><label>LDL-C (나쁜 콜레스테롤)</label></th>                    
                            <td><input type="text" name="chol_ldl_c" value="${showData.chol_ldl_c }" data-rule="dec" title="숫자만 입력 가능합니다."/>mg/dℓ</td> 
                        </tr> 
                        <tr>
                            <th><label>non-HDL <span class="non-HDL">(대사성증후군 지표)</span></label></th>                 
                            <td><input type="text" name="chol_non_hdl" value="${showData.chol_non_hdl }" data-rule="dec" title="숫자만 입력 가능합니다."/>mg/dℓ</td> 
                        </tr>
                        <tr>
                            <th><label>TC/HDL (동맥경화지수)</label></th>                 
                            <td><input type="text" name="chol_tc_hdl" value="${showData.chol_tc_hdl }" data-rule="dec" title="숫자만 입력 가능합니다."/>mg/dℓ</td> 
                        </tr>
                        <tr>
                            <th><label>GLU (혈당)</label></th>                    
                            <td><input type="text" name="chol_glucose" value="${showData.chol_glucose }" data-rule="dec" title="숫자만 입력 가능합니다."/>mg/dℓ</td> 
                        </tr>               
                    </tbody>
                </table>
            </div>
    	</div>
</div>
<%--숨김 필드 모음--%>
<s:if test="showIsNull == false">
<input type="hidden" name="id_medi_check" value="${showData.id_medi_check }"/>
</s:if>
<input type="hidden" name="contents" value="${contentsCode }"/>
</fieldset>


<div class="footer board">
	<div class="buttons">
			<button type="submit" class="artn-button board"><s:if test="showIsNull">작성</s:if><s:else>수정</s:else> 완료</button>
	</div>
</div>
</form>
</div>
</div>

</a:html>