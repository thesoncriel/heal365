<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title="365PLUS 관리"contents="${contentsCode }">
<div class="header">
    <h1>365PLUS 관리</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
            
<div class="section">
<div class="article">	
<form action="modify.action" method="post">
	
		<s:if test='%{showIsNull == false}'><input type="hidden" name="id" value="${showData.id}"/></s:if>
		<table class="board-edit comb-365plus">
			<thead>
				<tr><th>미리보기</th> 
					<td><a href="/365plus/player.jsp?id=${showData.id}&menu=${param.menu}&depth=edit">미리보기</a></td></tr>
				
				<tr><th><label>제목</label></th> 
					<td><input type="text" value="${showData.subject}" name="subject"/></td></tr>
				
				<tr><th><label>업무구분</label></th>
					<td>365PLUS<input type="hidden" name="cate_movie0" value="SF"/></td></tr>
			
				<tr><th><label>대분류</label></th>
					<td><s:include value="/include/combobox-data/cate_movie.jsp">
						<s:param name="cmb">cate_movie1</s:param>
						<s:param name="val">${showData.cate_movie1 }</s:param>
						<s:param name="sub">SF</s:param>
					</s:include></td></tr>
				
				<tr><th><label>중분류</label></th>
					<td><s:include value="/include/combobox-data/cate_movie.jsp">
						<s:param name="cmb">cate_movie2</s:param>
						<s:param name="val">${showData.cate_movie2 }</s:param>
					</s:include></td></tr>
		
				<tr><th><label>소분류</label></th>
					<td><s:include value="/include/combobox-data/cate_movie.jsp">
						<s:param name="cmb">cate_movie3</s:param>
						<s:param name="val">${showData.cate_movie3 }</s:param>
						<s:param name="sub">${showData.cate_movie1 }.${showData.cate_movie2 }</s:param>
					</s:include></td></tr>
		
				<tr><th><label>VAS</label></th>
					<td><s:include value="/include/combobox-data/cate_movie.jsp">
						<s:param name="cmb">vas_high</s:param>
						<s:param name="val">${showData.vas_high }</s:param>
					</s:include></td></tr>
				
				<tr><th><label>영상 조합</label><br/>
					<a class="artn-button board" href="#" id="anchor_AddMovie">영상 추가하기</a></th><!--  <a href="#" id="anchor_AddFromComb">기존 조합을 추가</a> -->
				
					<td><ul id="list_MovieContent365plus" class="sotable-list">
					<s:iterator value="subData.movieList">
						<li><span class="seq">0</span>
			                <span class="subject_movie">${subject_movie}</span>
			                <a class="nth" href="#">${nth}</a>
			                <a class="left_right" href="#">${left_right}</a>
			                <a class="popup" href="#">${popup}</a>
			                <a class="delete" href="#">삭제</a>
			                <input type="hidden" name="seq" value="0"/>
			                <input type="hidden" name="id_movie" value="${id_movie}"/>
			                <input type="hidden" name="repeat_cnt" value="1"/>
			                <input type="hidden" name="nth" value="${nth}"/>
			                <input type="hidden" name="left_right" value="${left_right}"/>
			                <input type="hidden" name="popup" value="${popup}"/>
			                <input type="hidden" name="popup_msg" value="${popup_msg}"/>
			                <input type="hidden" name="popup_action" value="${popup_action}"/></li>
					</s:iterator>
					</ul></td></tr>
		<!--			<li>-</li>
		
			"<li class=\"ui-state-default\"><span class=\"seq\">0</span>" +
		                "<img class=\"file_img\" src=\"media://thumb/{file_img}\" alt=\"{subject_movie}\" width=\"85\" height=\"55\" />" +
		                "<span class=\"subject_movie\">{subject_movie}</span>" +
		                "<a class=\"repeat_cnt\" href=\"#\">{repeat_cnt}</a>" +
		                "<a class=\"delete\" href=\"#\">삭제</a>" +
		                "<input type=\"hidden\" name=\"seq\" value=\"0\"/>" +
		                "<input type=\"hidden\" name=\"id_movie\" value=\"{id_movie}\"/>" +
		                "<input type=\"hidden\" name=\"repeat_cnt\" value=\"{repeat_cnt}\"/></li>",
		-->
					</ul></td></tr>
			</thead>
		</table>
		
		
		<!-- TODO: 추후에는 edit 시에는 js 에 의존하지 않도록 코딩 할 것 -->
		<div class="list-values" style="display: none">
			<input type="hidden" name="id_movie" value="${showData.id_movie}"/>
			<input type="hidden" name="file_img" value="${showData.file_img}"/>
			<input type="hidden" name="subject_movie" value="${showData.subject_movie}"/>
			<input type="hidden" name="nth" value="${showData.nth}"/>
			<input type="hidden" name="left_right" value="${showData.left_right}"/>
			<input type="hidden" name="popup" value="${showData.popup}"/>
			<input type="hidden" name="popup_msg" value="${showData.popup_msg}"/>
			<input type="hidden" name="popup_action" value="${showData.popup_action}"/>
		</div>
		<!-- 
		<div class="combobox-values" style="display: none;">
			<%--TODO: 실서버 적용 시 경로 바꿔야 함 --%>
			<span class="xml-path">/comb/category.xml</span>
			<input type="hidden" name="cate_movie0" value="${showData.cate_movie0}"/>
			<input type="hidden" name="cate_movie1" value="${showData.cate_movie1}"/>
			<input type="hidden" name="cate_movie2" value="${showData.cate_movie2}"/>
			<input type="hidden" name="cate_movie3" value="${showData.cate_movie3}" class="cate_movie1 cate_movie2"/>
			<input type="hidden" name="cate_sub1" value="${showData.cate_sub1}"/>
			<input type="hidden" name="vas_high" value="${showData.vas_high}"/>
		</div>
 -->
		<!--<label>테마별 운동 적용</label> 
		<select name="cate_sub1"><option value="0">-</option></select><br/>-->
		<!-- <label>VAS 최소</label> 
		<select name="vas_low"><option value="0">-</option></select><br/> -->
		
		
	<div class="footer board">
            <div class="buttons">
		        <a class="artn-button board" href="list.action">취소</a>
		        <s:if test="showIsNull"><input class="artn-button board" type="submit" value="추가"/></s:if>
				<s:else><input class="artn-button board" type="submit" value="변경"/></s:else>
	        </div>
       	</div>
</form>

<div id="dialog_Nth" title="차수 설정" style="display: none;">
	<form>
	<fieldset>
		<input id="spinner_Nth" type="text" name="spinner_nth"/><br/>
		<input id="button_NthOK" type="button" value="확인"/>
		
	</fieldset>
	</form>
</div>
<div id="dialog_LeftRight" title="좌우 설정" style="display: none;">
	<form>
	<fieldset>
		<div class="radioset">
			<input id="radio_LeftRight1" type="radio" name="left_right" value=""/><label for="radio_LeftRight1">구분 없음</label>
			<input id="radio_LeftRight2" type="radio" name="left_right" value="L"/><label for="radio_LeftRight2">왼쪽</label>
			<input id="radio_LeftRight3" type="radio" name="left_right" value="R"/><label for="radio_LeftRight3">오른쪽</label>
		</div>
		<input id="button_LeftRightOK" type="button" value="확인"/>
	</fieldset>
	</form>
</div>
<div id="dialog_PopupOption" title="팝업 설정" style="display: none;">
	<form>
	<fieldset>
		<input id="checkbox_Popup" type="checkbox" name="popup" value="P"/><label for="checkbox_Popup">팝업 사용 유무</label>
		<table>
			<tbody>
			<tr>
				<th><label for="textbox_PopupMsg">팝업 내용</label></th>
				<td><textarea id="textbox_PopupMsg" name="popup_msg"></textarea></td>
			</tr>
			<tr>
				<th><label for="textbox_PopupActionName1">버튼1 이름</label></th>
				<td><input id="textbox_PopupActionName1" type="text" name="popup_action_name1"/></td>
			</tr>
			<tr>
				<th><label for="textbox_PopupActionTarget1">버튼1 수행</label></th>
				<td><select id="textbox_PopupActionTarget1" name="popup_action_target1">
					<option value="">-</option>
				</select></td>
			</tr>
			<tr>
				<th><label for="textbox_PopupActionName2">버튼2 이름</label></th>
				<td><input id="textbox_PopupActionName2" type="text" name="popup_action_name2"/></td>
			</tr>
			<tr>
				<th><label for="textbox_PopupActionTarget2">버튼2 수행</label></th>
				<td><select id="textbox_PopupActionTarget2" name="popup_action_target2">
					<option value="">-</option>
				</select></td>
			</tr>
			</tbody>
		</table>
		<input id="button_PopupOptionOK" type="button" value="확인"/>
	</fieldset>
	</form>
</div>

<div id="dialog_MovieSelector" title="영상 선택기" style="display: none;">
<s:include value="/WEB-INF/include/search/movie.jsp">
	<s:param name="actionURI">/movie/jsondata.action?json=true</s:param>
</s:include>
<ul id="list_StorePlace">
	<!-- 
	<li><img src="/media/img/{file_img}" title="{subject}" width="56" height="36"/><span class="artn-icon-16 delete"><a href="#" class="delete">x</a></span>
		<input type="hidden" name="seq" value="0"/>
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
<ul id="infinitelist_MovieSearch" class="infinite-list" data-from="#dialog_MovieSelector #form_MovieSearch">
	<!-- 
	<li>
	<img class="file_img" src="/media/img/{file_img}" alt="{subject}" width="56" height="36" />
	<span class="subject_movie">{subject}</span>
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

<div class="footer board">
	<div class="buttons">
		<button id="button_SelectionComplete" class="artn-button board" type="button">선택 완료</button>
	</div>
</div>

</div>

</div>
</div>

</a:html>