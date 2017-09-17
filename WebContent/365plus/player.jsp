<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 힐링업 플레이어" contents="${param.contents }">
<div class="header">
	<h1>Healing up Player</h1>
    <div id="breadcrumbs" data-sub=""></div>
</div>

<div class="section">
<div class="article">          
<%-- <h2>${showData.subject }</h2> --%>
<h2 class="subject">영상제목</h2>
<table class="board-show">
<thead>	
	<tr class="delimiter">
		<td class="category">처방영상</td>
		<td colspan="4"> </td>
		<%--
		<td class="name">글쓴이 : ${showData.user_name}(${showData.id_user})</td>
		<td class="view-cnt">조회수 : ${showData.view_count}</td>
		<td class="date">작성일 : ${showData.date_upload_fmt}</td>
		<td>&nbsp;</td>
		 --%>
	</tr>
</thead>
<tbody>
<tr>
	<td colspan="5" class="player-field">
		<input type="hidden" id="player-track-info" value="/comb/show?json=true&id=${param.id }"/>
        <input type="hidden" name="left_right" value="${param.left_right }"/>
        <input type="hidden" name="menu" value="${param.menu}"/>
        <s:hidden name="nth" value='%{#session.nth}'/>
		
		<div class="player">
			<video width="640" height="360" id="wrapper_Player" controls="controls">
	        	<source src="../media/mp3/A-9.mp3" type="audio/mp3">
	        </video>
	
	        <%-- //자막 처리 기능 보류
	            <div id="subtitles">여기서 자막이 나옵니다.</div>
	        --%>
	        <div id="currentRepeat"><span></span></div>
	        <div id="imageList_Thumbnail" class="ui-player-thumbnail">
	        	<a class="ui-list-prev ui-icon ui-icon-carat-1-w" href="#">&lt;</a>
	            <ol>
	            <%-- // 리스트 샘플
	                <li><a href="#"><img src="img/part1.jpg" alt="몸통 부위" /><span class="thumb-title">몸통 부위</span></a></li>
	             --%>
	            </ol>
	            <a class="ui-list-next ui-icon ui-icon-carat-1-e" href="#">&gt;</a>
	        </div>
        </div>
	</td>	
</tr>
</tbody>
</table>

<div class="footer board">
    <div class="buttons">
    	<span class="artn-button board"><a href="${param.to_list }">목록</a></span>
	</div>
</div>

            <div id="dialog_Popup_365Plus" title="365 플러스 안내창">
			  <p></p>
			</div>
			<div id="dialog_PlayerConfirm" title="영상 종료 확인">
			  <p>영상이 종료 되었습니다.<br/>다시 수행 하시겠습니까?</p>
			</div>
</div>
</div>
</a:html>