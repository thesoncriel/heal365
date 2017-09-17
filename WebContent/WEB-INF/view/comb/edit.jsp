<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 조합 관리" contents="${contentsCode }">
<div class="header">
    <h1>조합 관리</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>       
<div class="section">
<div class="article">
<form action="modify.action" method="post">
		<s:if test='%{showIsNull == false}'><input type="hidden" name="id" value="${showData.id}"/></s:if>
		<table class="board-edit comb">
			<thead>
				<tr><th><label>미리보기</label></th> 
					<td><a href="/player/player?id=${showData.id}&menu=${param.menu}&depth=edit">미리보기</a></td></tr>
				
				<tr><th><label>제목</label></th> 
					<td><input type="text" value="${showData.subject}" name="subject"/></td></tr>
				
				<tr><th><label>업무구분</label></th>
					<td><s:include value="/include/combobox-data/cate_movie.jsp">
						<s:param name="cmb">cate_movie0</s:param>
						<s:param name="val">${showData.cate_movie0 }</s:param>
					</s:include></td></tr>
			
				<tr><th><label>대분류</label></th>
					<td><s:include value="/include/combobox-data/cate_movie.jsp">
						<s:param name="cmb">cate_movie1</s:param>
						<s:param name="val">${showData.cate_movie1 }</s:param>
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
					
				<tr><th><label>사용그룹설정</label></th>
					<td><s:select list="groupList" name="id_group" listKey="id" listValue="name" theme="simple" value="showData.id_group"></s:select></td></tr>
				
				<tr><th><label>영상 조합</label><br/>
					<a class="artn-button board" href="#" id="anchor_AddMovie">영상 추가하기</a>
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
				
					<td>
					<ul id="sortable_MovieContent" class="sotable-list">
					<s:iterator value="subData.movieList">
						<li>
							<span class="seq">${seq }</span>
							<a:img cssClass="file_img" src="/media/img/${file_img }" alt="${subject_movie }" srcNone="/img/Heal365-logo-mini.png" altNone="썸네일" width="80" height="50"/>
							<span class="subject_movie">${subject_movie }</span>
							<a:selectbox cssClass="repeat_cnt" name="repeat_cnt" min="0" max="10" value="${repeat_cnt }"/>
							<a class="delete" href="#">삭제</a>
							<a class="artn-button board itemup" href="#">▲</a><a class="artn-button board itemdown" href="#">▼</a>
							<input type="hidden" name="seq" value="${seq }">
							<input type="hidden" name="id_movie" value="${id_movie }"></li>
					</s:iterator>
					<!--<li><span class="seq">0</span>
               				<img class="file_img" src="@{if defined('file_img') && (file_img != '')}/media/img/{file_img}@{else}../../img/Heal365-logo-mini.png@{/if}" alt="{subject_movie}" width="80" height="50"/>
							<span class="subject_movie">{subject_movie}</span>
							<a:selectbox cssClass="repeat_cnt" name="repeat_cnt" min="0" max="10"/>
			                <a class="delete" href="#">삭제</a>
			                <a class="artn-button board itemup" href="#">▲</a><a class="artn-button board itemdown" href="#">▼</a>
			                <input type="hidden" name="seq" value="0"/>
			                <input type="hidden" name="id_movie" value="{id_movie}"/></li>-->
					</ul></td></tr>
			</thead>
		</table>
		
		

		<!-- TODO: 추후에는 edit 시에는 js 에 의존하지 않도록 코딩 할 것 -->
<%--		<div class="list-values" style="display: none">
			<input type="hidden" name="id_movie" value="${showData.id_movie}"/>
			<input type="hidden" name="file_img" value="${showData.file_img}"/>
			<input type="hidden" name="subject_movie" value="${showData.subject_movie}"/>
			<input type="hidden" name="repeat_cnt" value="${showData.repeat_cnt}"/>
		</div> --%>
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
		        <s:if test='%{showIsNull == true}'><input class="artn-button board" type="submit" value="추가"/></s:if>
				<s:else><input class="artn-button board" type="submit" value="변경"/></s:else>
	        </div>
       	</div>
<input type="hidden" name="contents" value="${contents }"/>       	
</form>

<div id="dialog_RepeatCnt" title="반복 횟수 설정" style="display: none;">
	<form>
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

</div>
</div>

</a:html>