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
<!-- <h3 class="artn-field-header">건강검진 </h3> -->
<div class="article prescript edit">
		<table>
			<tbody>
				<tr>
					<th><label>사용자</label></th>
					<td><input type="text" id="autocomplete_user_name" data-url="/groupuser/list?json=true&id_group=${idMedi }" data-format="{user_name} ({user_date_birth}) :: {id_user}" data-field="#user_name,@id_user" data-type="map" data-minlen="1" name="user_name" value="${showData.user_name }" required="required" title="환자명을 입력하세요."/><input name="id_user" type="hidden" value="${showData.id_user }"/></td>
					<th>작성자</th>
					<td>${user.name }</td>
					<th>작성일</th>
					<td>${util.today }</td>
				</tr>
			</tbody>
		</table>
		<%-- <table style="width: 100%;">
			<tbody>			
				<tr>
				<s:iterator value="listData.{? (#this.position_group == 0) }">
					<th><label>${field_name }</label></th>
					<td>
					<s:if test="field_type == 0"><input type="text" name="field_value" value="${field_value }" data-rule="dec"/>${field_unit }</s:if>
					<s:elseif test="field_type == 1"><a:selectbox name="field_value" value="${field_value }" type="text" list="${field_label }" unit="${field_unit }" zero="선택안함"/></s:elseif>
					<input type="hidden" name="field_name" value="${field_name }"/>
					<input type="hidden" name="field_type" value="${field_type }"/>
					<input type="hidden" name="field_unit" value="${field_unit }"/>
					<input type="hidden" name="position_group" value="${position_group }"/>
					<input type="hidden" name="position_seq" value="${position_seq }"/>
					<input type="hidden" name="id" value="${id_medi_check_data }"/>
					<input type="hidden" name="id_medi_check_field" value="${id_medi_check_field }"/>
					<input type="hidden" name="result_code" value="${result_code }"/>
					<input type="hidden" name="field_label" value="${field_label }"/>
					<input type="hidden" name="id_medi_check_conf" value="${id }"/>
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
						<s:if test="field_type == 0"><input type="text" name="field_value" value="${field_value }" data-rule="dec"/>${field_unit }</s:if>
						<s:elseif test="field_type == 1"><a:selectbox name="field_value" value="${field_value }" type="text" list="${field_label }" unit="${field_unit }" zero="선택안함"/>
						<input type="hidden" name="field_label_${id_medi_check_field }" value="${field_label }"/></s:elseif>
						<input type="hidden" name="field_name" value="${field_name }"/>
						<input type="hidden" name="field_type" value="${field_type }"/>
						<input type="hidden" name="field_unit" value="${field_unit }"/>
						<input type="hidden" name="position_group" value="${position_group }"/>
						<input type="hidden" name="position_seq" value="${position_seq }"/>
						<input type="hidden" name="id" value="${id_medi_check_data }"/>
						<input type="hidden" name="id_medi_check_field" value="${id_medi_check_field }"/>
						<input type="hidden" name="result_code" value="${result_code }"/>
						<input type="hidden" name="field_label" value="${field_label }"/>
						<input type="hidden" name="id_medi_check_conf" value="${id }"/>
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
						<s:if test="field_type == 0"><input type="text" name="field_value" value="${field_value }" data-rule="dec"/>${field_unit }</s:if>
						<s:elseif test="field_type == 1"><a:selectbox name="field_value" value="${field_value }" type="text" list="${field_label }" unit="${field_unit }" zero="선택안함"/>
						<input type="hidden" name="field_label_${id_medi_check_field }" value="${field_label }"/></s:elseif>
						<input type="hidden" name="field_name" value="${field_name }"/>
						<input type="hidden" name="field_type" value="${field_type }"/>
						<input type="hidden" name="field_unit" value="${field_unit }"/>
						<input type="hidden" name="position_group" value="${position_group }"/>
						<input type="hidden" name="position_seq" value="${position_seq }"/>
						<input type="hidden" name="id" value="${id_medi_check_data }"/>
						<input type="hidden" name="id_medi_check_field" value="${id_medi_check_field }"/>
						<input type="hidden" name="result_code" value="${result_code }"/>
						<input type="hidden" name="field_label" value="${field_label }"/>
						<input type="hidden" name="id_medi_check_conf" value="${id }"/>
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
						<s:if test="field_type == 0"><input type="text" name="field_value" value="${field_value }" data-rule="dec"/>${field_unit }</s:if>
						<s:elseif test="field_type == 1"><a:selectbox name="field_value" value="${field_value }" type="text" list="${field_label }" unit="${field_unit }" zero="선택안함"/>
						<input type="hidden" name="field_label_${id_medi_check_field }" value="${field_label }"/></s:elseif>
						<input type="hidden" name="field_name" value="${field_name }"/>
						<input type="hidden" name="field_type" value="${field_type }"/>
						<input type="hidden" name="field_unit" value="${field_unit }"/>
						<input type="hidden" name="position_group" value="${position_group }"/>
						<input type="hidden" name="position_seq" value="${position_seq }"/>
						<input type="hidden" name="id" value="${id_medi_check_data }"/>
						<input type="hidden" name="id_medi_check_field" value="${id_medi_check_field }"/>
						<input type="hidden" name="result_code" value="${result_code }"/>
						<input type="hidden" name="field_label" value="${field_label }"/>
						<input type="hidden" name="id_medi_check_conf" value="${id }"/>
						</td>
						</tr>
					</s:iterator>               
                    </tbody>
                </table>
            </div>
    	</div>
</div>
<%--숨김 필드 모음--%>
<s:if test="showIsNull == false">
<input type="hidden" name="id_medi_check" value="${showData.id_medi_check }"/>
<input type="hidden" name="date_upload" value="${showData.date_upload }"/>
<input type="hidden" name="date_update" value="${showData.date_update }"/>
</s:if>
<s:if test="isCompleted == true">
<input type="hidden" name="id_complete" value="${showData.id_medi_check }"/>
<input type="hidden" name="date_complete" value="${showData.date_complete }"/>
</s:if>
<s:if test="isLinkedPres">
<input type="hidden" name="id_pres" value="${showData.id_medi_check }"/>
</s:if>
<input type="hidden" name="id_medi" value="${showData.id_medi }"/>
<input type="hidden" name="id_writer" value="${showData.id_writer }"/>
<input type="hidden" name="id_writer_last" value="${showData.id_writer_last }"/>
<input type="hidden" name="medi_name" value="${showData.medi_name }"/>
<input type="hidden" name="writer_name" value="${showData.writer_name }"/>
<input type="hidden" name="writer_last_name" value="${showData.writer_last_name }"/>
<input type="hidden" name="contents" value="${contentsCode }"/>
</fieldset>


<div class="footer board">
	<div class="buttons">
		<%-- 수정 시 보여지는 데이터는 모두 현재 로그인된 사용자의 내용으로 덮어씌워지게 됩니다. 계속 하시겠습니까? 예/아니오 <-- 추가 --%>
		<button type="submit" class="artn-button board"><s:if test="showIsNull">작성</s:if><s:else>수정</s:else> 완료</button>
	</div>
</div>
</form>
</div>
</div>

</a:html>