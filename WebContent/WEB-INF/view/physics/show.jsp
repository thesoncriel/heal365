<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 물리치료" contents="${contentsCode }">
<div class="header">
    <h1>물리치료 보기</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="section">
<div class="article">
<fieldset>
<div class="article prescript show">
    <div  class="section health-screening">
        <table class="medi-question-top">
            <tbody>
                <tr>
                    <th><label>환자명</label></th>
                    <td>${showData.user_name }</td>
                    <th><label>작성자</label></th>
                    <td>${showData.writer_name }</td>
                    <th><label>작성날짜</label></th>
                    <td>${showData.date_upload_fmt }</td>
                </tr>
            </tbody>
        </table>
        <table style="width: 100%;">
			<tbody>
				<tr>
                    <th><label>키</label></th>                  
                    <td>${showData.body_height }cm</td>
                    <th><label>체중</label></th>                  
                    <td>${showData.body_weight }Kg</td>
                </tr>
			</tbody>
		</table>
        <div style="width: 33%; display: inline-block; vertical-align: top;">
                <table>
                    <tbody>
                        <tr>
                            <th><label>혈압측정(상)</label></th>                    
                            <td>${showData.bp_high }mmHg</td> 
                        </tr>
                        <tr>
                            <th><label>혈압측정(하)</label></th>                    
                            <td>${showData.bp_low }mmHg</td> 
                        </tr>
                        <tr>
                            <th><label>혈당측정</label></th>                   
                            <td>${showData.glucose }mg/dℓ</td> 
                        </tr>
                        <tr>
                            <th><label>Hb 검사(빈혈 검진)</label></th>                   
                            <td>${showData.hb }g/dℓ</td> 
                        </tr>
                        <tr>
                            <th><label>당화혈색소</label></th>                  
                            <td>${showData.hba1c }%</td> 
                        </tr>
                        <tr>
                            <th><label>니코틴</label></th>                 
                            <td><a:valuelist list="양성, 무효, 음성" zero="-" value="${showData.nicotine }"/> </td> 
                        </tr>
                        <tr>
                            <th><label>요성분</label></th>                 
                            <td><a:valuelist list="양성, 음성" zero="-" value="${showData.pee }"/>  </td> 
                        </tr>
                        <tr>
                            <th><label>T-Score</label></th>                 
                            <td>${showData.tscore }</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div style="width: 33%; display: inline-block;vertical-align: top;">
                <table>
                    <tbody>                 
                        <tr>
                            <th><label>체중</label></th>                  
                            <td>${showData.body_weight }Kg</td> 
                        </tr>
                        <tr>
                            <th><label>골격근량</label></th>                    
                            <td>${showData.body_skel_muscle }Kg</td> 
                        </tr>
                        <tr>
                            <th><label>체지방량</label></th>                    
                            <td>${showData.body_fat }Kg</td> 
                        </tr>
                        <tr>
                            <th><label>복부지방률</label></th>                   
                            <td>${showData.body_wh_fat_ratio }</td> 
                        </tr>
                        <tr>
                            <th><label>내장지방</label></th>                    
                            <td>
                                ${showData.body_vis_fat } 레벨
                            </td> 
                        </tr>                   
                        <tr>
                            <th><label>상체강도</label></th>                    
                            <td><a:valuelist list="표준, 발달, 허약" zero="-" value="${showData.body_upper_str }"/> </td> 
                        </tr>
                        <tr>
                            <th><label>하체강도</label></th>                    
                            <td><a:valuelist list="표준, 발달, 허약" zero="-" value="${showData.body_lower_str }"/></td> 
                        </tr>
                        <tr>
                            <th><label>근육강도</label></th>                    
                            <td><a:valuelist list="표준, 발달, 허약" zero="-" value="${showData.body_muscle_str }"/> </td> 
                        </tr>                       
                    </tbody>
                </table>
            </div>
            <div style="width: 33%; display: inline-block;vertical-align: top;">
                <table>
                    <tbody>                     
                        <tr>
                            <th><label>TC (총 콜레스테롤)</label></th>                    
                            <td>${showData.chol_tc }mg/dℓ</td> 
                        </tr>
                        <tr>
                            <th><label>HDL-C (좋은 콜레스테롤)</label></th>                    
                            <td>${showData.chol_tc }mg/dℓ</td> 
                        </tr> 
                        <tr>
                            <th><label>TRG (중성지방)</label></th>                  
                            <td>${showData.chol_trg }mg/dℓ</td> 
                        </tr>
                        <tr>
                            <th><label>LDL-C (나쁜 콜레스테롤)</label></th>                    
                            <td>${showData.chol_ldl_c }mg/dℓ</td> 
                        </tr>
                        <tr>
                            <th><label>non-HDL <span  class="non-HDL">(대사성증후군 지표)</span></label></th>                 
                            <td>${showData.chol_non_hdl }mg/dℓ</td> 
                        </tr>
                        <tr>
                            <th><label>TC/HDL (동맥경화지수)</label></th>                 
                            <td>${showData.chol_tc_hdl }mg/dℓ</td> 
                        </tr>
                        <tr>
                            <th><label>GLU (혈당)</label></th>                    
                            <td>${showData.chol_glucose }mg/dℓ</td> 
                        </tr>
                    </tbody>
                </table>
            </div>
       </div>
</div>
</fieldset>


<div class="footer board">
	<div class="buttons">
	   <s:if test="(auth.isGroupStaff == true) || (auth.isNurse == true)">
	        <a href="edit?id_medi_check=${showData.id_medi_check }&contents=${params.contents }" class="artn-button board">수정</a>
	   </s:if>
			<a href="list?contents=${params.contents }" class="artn-button board">목록</a>
	</div>
</div>
</div>
</div>

</a:html>