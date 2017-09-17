<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 간호사" contents="${contentsCode }">
<div class="header">
    <h1>문진표 보기</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="section">
<div class="article">
<fieldset>
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
<table class="medi-question-top">
    <tbody>
        <tr>
            <th class="css-height"><label for="height">키</label></th>
            <td>${showData.height }cm</td>
            <th class="css-weight"><label for="weight">몸무게</label></th>
            <td>${showData.weight }kg</td>
            <th class="css-feet_size"><label for="feet_size">발 사이즈(신발 사이즈)</label></th>
            <td>${showData.feet_size }mm</td>
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
            <a:surveyradio name="check" value="${showData.check }" offset="0" subWrap="td" wrap="none" unchecked="${showIsNull}" labelShow="false" disabled="disabled"/>         
        </tr>
        <tr>
            <td>1-1. 진단을 받은적이 있다면 현재 복용하는 약이 있습니까?
            <a:surveyradio name="check" value="${showData.check }" offset="1" subWrap="td" wrap="none" unchecked="${showIsNull}" labelShow="false" disabled="disabled"/>
        </tr>
        <tr>
            <td>2. 가족중에 고혈압을 앓고 계신분은 있습니까?
            <a:surveyradio name="check" value="${showData.check }" offset="2" subWrap="td" wrap="none" unchecked="${showIsNull}" labelShow="false" disabled="disabled"/>
        </tr>
        <tr>
            <th><label>[당뇨관리]</label></th>
            <th class="check-radio">예</th>
            <th class="check-radio">아니오</th>
        </tr>
        <tr>
            <td>3. 당뇨병 진단을 받은적이 있습니까?
            <a:surveyradio name="check" value="${showData.check }" offset="3" subWrap="td" wrap="none" unchecked="${showIsNull}" labelShow="false" disabled="disabled"/>
        </tr>
        <tr>
            <td>3-1. 진단을 받은적이 있다면 현재 복용하는 약이 있습니까?
            <a:surveyradio name="check" value="${showData.check }" offset="4" subWrap="td" wrap="none" unchecked="${showIsNull}" labelShow="false" disabled="disabled"/>
        </tr>
        <tr>
            <td>4. 가족중에 당뇨병을 알고 계신분은 있습니까?
            <a:surveyradio name="check" value="${showData.check }" offset="5" subWrap="td" wrap="none" unchecked="${showIsNull}" labelShow="false" disabled="disabled"/>
        </tr>
        <tr>
            <th colspan="3"><label>[기타]</label></th>
        </tr>
        <tr>
            <td colspan="3">5. 현재진단받은 질환이 있습니까?</td>
        </tr>
        <tr>
            <td colspan="3">5-1. 진단받은 질환:
            ${showData.text1 }</td>           
        </tr>
        <tr>
            <td colspan="3">6. 현재 복용중인 약물이 있습니까?</td>
        </tr>
        <tr>
            <td colspan="3">6-1. 복용중인 약물:
            ${showData.text2 }</td>           
        </tr>
    </tbody>
</table>
</fieldset>


<div class="footer board">
	<div class="buttons">
	   <a href="list?contents=${params.contents }" class="artn-button board">목록</a>
	</div>
</div>
</div>
</div>

</a:html>