<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<jsp:include page="/include/header.jsp" flush="true" />          
            <s:if test='%{#session.user != null}'>
            <div class="layout-contents">
            <nav class="left-menu">
                 <h3>365plus</h3>
                 <ul>
                    <li><a href="/user/menu">메인메뉴</a></li>
                </ul>
            </nav>
	                <section class="contents-base">
	                    <article>
	                        <nav>
	                       		<h2>365 PLUS</h2>          
	                            <ul>
	                                <s:if test="auth.menu1"><li><span class="artn-button control"><a href="/player/selector1.jsp?menu=365plus" id="button_CureAndExcercise">통증치료 및 예방운동</a></span></li></s:if>
	                                <s:if test="auth.menu2"><li><span class="artn-button control"><a href="/prescript/list.action?menu=prescript" id="button_MyScription">나의 처방 운동</a></span></li></s:if>
	                                <s:if test="auth.menu3"><li><span class="artn-button control"><a href="/player/theme_search.jsp" id="button_Routine">테마별 운동(Routine)</a></span></li></s:if>
	                                <s:if test="auth.menu4"><li><span class="artn-button control"><a href="/player/work_out.jsp" id="button_Workout">Workout(개인별 운동구성)</a></span></li></s:if>
	                                
	                                <s:if test="auth.menu5"><li><span class="artn-button admin"><a href="/prescript/list.action?menu=prescript" id="button_Workout">처방전 관리</a></span></li></s:if>
	                                <s:if test="auth.menu6"><li><span class="artn-button admin"><a href="/movie/list.action">영상 등록 및 관리</a></span></li></s:if>
	                                <s:if test="auth.menu7"><li><span class="artn-button admin"><a href="/comb/list.action?menu=comb">조합 등록 및 관리</a></span></li></s:if>
									<s:if test="auth.menu8"><li><span class="artn-button admin"><a href="/365plus/list.action?menu=365pluscomb">365Plus 조합 관리</a></span><li></li></s:if>
									
									
									<s:if test="auth.menu9"><li><span class="artn-button admin"><a href="/group/show.action?id=${user.group_id}&contents=sub1_6_1&menu=1">소속 의료기관 정보</a></span></li></s:if>
									<s:if test="auth.menu10"><li><span class="artn-button admin"><a href="/group/list.action">의료기관 정보</a></span></li></s:if>
									<s:if test="auth.menu11"><li><span class="artn-button admin"><a href="/user/list">회원 관리</a></span></li></s:if>
									<%--
									<s:if test='%{auth.isAdmin}'>
                                		
                                	</s:if>
                                	<s:elseif test='%{auth.isMediStaff}'>
                                		<s:if test='%{#session.user.group_id != 0}'>
                                			<span class="artn-button admin"><a href="/group/show.action?id=${session.user.group_id}&contents=sub1_6_1&menu=1">소속 의료기관 정보</a></span>
                                		</s:if>
                                		<s:else>
                                			<span class="artn-button admin"><a href="/group/edit.action">의료기관 추가하기</a></span>
                                		</s:else>
                                	</s:elseif>
	                                </li>
	                                 --%>
	                            </ul>
	                            <ul class="menu_setting">
	                                <!-- <li><a href="#" id="button_Setting">setting(옵션설정)</a></li> -->
	                                <li><span class="artn-icon-16 caret-e"></span><a href="/contents.jsp?contents=sub2_1_1&menu=2" id="button_SwInfo">365 plus란?</a></li>
	                            </ul>
                        	</nav>
                        </article>
	                </section>
	         </div>
            </s:if>
<jsp:include page="/include/footer.htmlpart" flush="true" />  
