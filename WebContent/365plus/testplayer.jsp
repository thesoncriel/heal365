<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - User Action Test : Menu">
	<jsp:param name="isplayer" value="1"/>
</jsp:include>
<div class="layout-contents">
<div class="nav left-menu">
			
	            <h3>healing up 365</h3>	            
                <ul>                
                	<li><a href="/user/menu">메인메뉴</a></li>
                	<s:if test='%{#parameters.menu[0] == "365plus"}'>                		
                    	<li><a href="/player/selector1.jsp?menu=${param.menu}">통증선택 1단계</a></li>
                    	<li><a href="/player/selector2.jsp?cate_movie1=${param.cate_movie1}&direction=${param.direction}&left_right=${param.left_right}&menu=${param.menu}">통증선택 2단계</a></li>
                	</s:if>        
                	<s:if test='%{#parameters.menu[0] == "comb" && #parameters.depth[0] == "edit"}'>                		
		                <li><a href="/comb/list.action?menu=${param.menu}">조합 영상 목록</a></li>
		                <li class="comb-edit"><a href="/comb/edit.action?id=${param.id}&menu=${param.menu}">조합 영상 변경</a></li>		                                    
                	</s:if>
                	<s:if test='%{#parameters.menu[0] == "comb" && #parameters.depth[0] == "list"}'>                			                    
		                    <li><a href="/comb/list.action?menu=${param.menu}">조합 영상 목록</a></li>		                                        
                	</s:if>
                	<s:if test='%{#parameters.menu[0] == "prescript" && #parameters.depth[0] == "show"}'>                		
		                <li><a href="/prescript/list.action?menu=${param.menu}">나의 처방 운동 목록</a></li>
                    	<li class="prescript-add"><a href="/prescript/show?id=${param.prescriptId}&menu=prescript&depth=show">처방전 보기</a></li>		                                    
                	</s:if>
                	<s:if test='%{#parameters.menu[0] == "prescript" && #parameters.depth[0] == "list"}'>                			                    
		                <li><a href="/prescript/list.action?menu=${param.menu}">나의 처방 운동 목록</a></li>		                                        
                	</s:if>
                	<s:if test='%{#parameters.menu[0] == "365pluscomb" && #parameters.depth[0] == "edit"}'>                		
		                <li><a href="/365plus/list.action?menu=${param.menu}">365plus 조합 영상 목록</a></li>
                    	<li class="comb-edit"><a href="/365plus/show.action?id=${param.id}&menu=${param.menu}&depth=${param.depth}">365plus 조합 영상 변경</a></li>		                                    
                	</s:if>
                	<s:if test='%{#parameters.menu[0] == "365pluscomb" && #parameters.depth[0] == "list"}'>                			                    
		                <li><a href="/365plus/list.action?menu=${param.menu}">365plus 조합 영상 목록</a></li>		                                        
                	</s:if>
                	<li><a href="#">영상재생</a></li>                
                </ul>                
            </div>
		<div class="player_display">
		
            <div class="article">
                <div class="header">
                    <h1>player</h1>
                    <input type="hidden" id="player-track-info" value="/player/test.json"/>
                    <input type="hidden" name="left_right" value="left"/>
                    <input type="hidden" name="menu" value="0"/>
                    <s:hidden name="nth" value='%{#session.nth}'/>
                    <%-- <input type="hidden" name="nth" value="${param.nth }"/> --%>
                </div>
            <div class="ui-player-container">
                <!-- <h3 id="title">컨텐츠 조합 영상 제목</h3>
                <p id="desc">컨텐츠에 대한 부가 설명 란. 길어질 수도 있습니다</p> -->
                
                <div class="pp">
                    
                    <h2>영상제목</h2>
                    <div id="wrapper_Player">
            <!--             <img id="__poster" src="" />
                        <audio id="__audio">
                            <source id="srcOgg" src="" type="video/ogg"></source>
                            <source id="srcMp3" src="" type="video/mp3"></source>
                        </audio>
                        <video id="__video">
                            <source id="srcWebm" src="" type="video/webm"></source>
                            <source id="srcMp4" src="" type="video/mp4"></source>
                            HTML5가 지원되지 않습니다. 사파리일 경우 QuickTime Player를 다운 받으시길 바랍니다. (<a href="http://www.apple.com/quicktime/download/">바로가기: </a>)
                        </video> -->
                    </div>
                    <!-- //자막 처리 기능 보류
                        <div id="subtitles">여기서 자막이 나옵니다.</div>
                    -->
                    <div id="imageList_Thumbnail" class="ui-player-thumbnail">
                        <a class="ui-list-prev ui-icon ui-icon-carat-1-w" href="#">&lt;</a>
                        <ol>
                        <!-- // 리스트 샘플
                            <li><a href="#"><img src="img/part1.jpg" alt="몸통 부위" /><span class="thumb-title">몸통 부위</span></a></li>
                         -->
                        </ol>
                        <a class="ui-list-next ui-icon ui-icon-carat-1-e" href="#">&gt;</a>
                    </div>
            
                    <div class="ui-player-controller ui-layout-table">
                        <div class="ui-layout-tr">
                            <div class="ui-layout-td">
                                <button type="button" id="button_Play" class="ui-state-default ui-corner-all"><span class="ui-icon ui-icon-play">Play</span></button>
                                <!-- <span id="button_Play" class="ui-state-default ui-corner-all ui-icon ui-icon-play">Play</span> -->
                                <button type="button" id="button_Prev" class="ui-state-default ui-corner-all"><span class="ui-icon ui-icon-seek-prev">Prev</span></button>                        
                                <button type="button" id="button_Next" class="ui-state-default ui-corner-all"><span class="ui-icon ui-icon-seek-next">Next</span></button>
                            </div>
                            <div class="ui-layout-td">
                                <div id="slider_CurrentTime"></div>
                            </div>
                            <div class="ui-layout-td">
                                <div id="label_PlayTime">10:00</div>
                                    
                                <button type="button" id="button_Speed" class="ui-state-default ui-corner-all"><span class="ui-icon ui-icon-speed">Speed</span></button>
                                <div id="wrapper_Speed">
                                    <button type="button" id="button_SpeedUp">증가</button>
                                    <button type="button" id="button_SpeedDown">감소</button>
                                    <button type="button" id="button_SpeedDefault">기본</button>
                                </div>
                                    
                                <button type="button" id="button_FullScreen" class="ui-state-default ui-corner-all"><span class="ui-icon ui-icon-arrow-4-diag">Full Screen</span></button>
                                <button type="button" id="button_Mute" class="ui-state-default ui-corner-all"><span class="ui-icon ui-icon-volume-on">Mute</span></button>
                                
                                <div id="wrapper_Volume"><div id="slider_Volume"></div></div>
                            </div>
                        </div>
                    </div>
                </div>
                </div>
            <br/><br/><br/><br/>
            <div id="dialog_Popup_365Plus" title="365 플러스 안내창">
			  <p></p>
			</div>
			<div id="dialog_PlayerConfirm" title="영상 종료 확인">
			  <p>영상이 종료 되었습니다.<br/>다시 수행 하시겠습니까?</p>
			</div>
        </div></div>
        </div>
</a:html>