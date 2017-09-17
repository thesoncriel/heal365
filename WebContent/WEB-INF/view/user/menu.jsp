<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - Main Menu" contents="${contentsCode }">
    <div class="header">
        <h1>메인 메뉴</h1>
        <div id="breadcrumbs" data-sub="*메인메뉴"></div>
    </div>
<div class="section">
<div class="article">
<div class="nav">

<div class="prj-menu-wrap single">
	<div> 
		<h2 class="prj-bg-edge4-on"><span>365+</span></h2>
		<ul>
			<s:if test="auth.menu(1)"><li><a href="/contents?contents=${contentsCode }_1"><span class="prj-icon-64 loc2-1"></span><span class="prj-icon-name">통증치료 <br/>및 예방운동</span></a></li></s:if>
		</ul>
	</div><div>
		<h2 class="prj-bg-edge4-on"><span>스트레칭 365</span></h2>
		<ul>
			<s:if test="auth.menu(3)"><li><a href="/contents?contents=${contentsCode }_2"><span class="prj-icon-64 loc2-2"></span><span class="prj-icon-name">테마별 운동(Routine)</span></a></li></s:if>
		</ul>
	</div><div>
		<h2 class="prj-bg-edge4-on"><span>나의 맞춤 운동</span></h2>
		<ul>
			<s:if test="auth.menu(4)"><li><a href="/contents?contents=${contentsCode }_3"><span class="prj-icon-64 loc2-3"></span><span class="prj-icon-name">개인별 운동구성<br/>(Workout)</span></a></li></s:if>
		</ul>
	</div>
</div><%-- prj-menu-wrap 종료 --%>

<div class="prj-menu-wrap">
	<div>
		<h2 class="prj-bg-edge4-on"><span>MediFit</span></h2>
		<ul>
			<s:if test="auth.menu(2)"><li><a href="/prescript/listp.action?contents=sub100_4"><span class="prj-icon-64 loc2-8"></span><span class="prj-icon-name">처방 <br/>운동 리스트</span></a></li></s:if>
			<s:if test="auth.menu(7)"><li><a href="/movie/list.action?contents=sub100_6"><span class="prj-icon-64 loc2-5"></span><span class="prj-icon-name">영상 관리</span></a></li></s:if>
			<s:if test="auth.menu(8)"><li><a href="/comb/list.action?contents=sub100_7"><span class="prj-icon-64 loc2-6"></span><span class="prj-icon-name">조합 관리</span></a></li></s:if>
			<s:if test="auth.menu(9)"><li><a href="/365plus/list.action?contents=sub100_8"><span class="prj-icon-64 loc2-7"></span><span class="prj-icon-name">365PLUS 관리</span></a></li></s:if>							
			<li><s:if test="auth.menu(15)"><a href="/medistats/personal/list?contents=sub100_14" class="group_select"><span class="prj-icon-64 loc2-14"></span><span class="prj-icon-name">통합 이력관리</span></a></s:if>
				<s:else><a href="/medistats/personal/stats?id_user=${user.id }&contents=sub100_14" class="group_select"><span class="prj-icon-64 loc2-14"></span><span class="prj-icon-name">나의 이력관리</span></a></s:else></li>
			<s:if test="auth.menu(10)"><li><a href="/medi/question/list?contents=sub100_9" class="group_select"><span class="prj-icon-64 loc2-9"></span><span class="prj-icon-name">문진표</span></a></li></s:if>
			<s:if test="auth.menu(11)"><li><a href="/medicheck/complete/list?contents=sub100_10" class="group_select"><span class="prj-icon-64 loc2-10"></span><span class="prj-icon-name">건강검진</span></a></li></s:if>
			<s:if test="auth.menu(12)"><li><a href="/physics/complete/list?contents=sub100_11" class="group_select"><span class="prj-icon-64 loc2-11"></span><span class="prj-icon-name">물리치료</span></a></li></s:if>							
			<s:if test="auth.menu(6)"><li><a href="/prescript/list<s:if test="auth.isAdmin == false">m</s:if>.action?contents=sub100_5" class="group_select"><span class="prj-icon-64 loc2-4"></span><span class="prj-icon-name">운동처방</span></a></li></s:if>
			<s:if test="auth.menu(13)"><li><a href="/medicheck/complete/stats?contents=sub100_12" class="group_select"><span class="prj-icon-64 loc2-12"></span><span class="prj-icon-name">통합 집계표</span></a></li></s:if>
			<s:if test="auth.menu(14)"><li><a href="/healMediUser?contents=sub100_13" class="group_select"><span class="prj-icon-64 loc2-13"></span><span class="prj-icon-name">회원 관리</span></a></li></s:if>
		</ul>
	</div>
</div><%-- prj-menu-wrap 종료 --%>
                                                                
<%--
<dt>365+</dt>
<dd></dd>
</dl>
<dl>
<dt>스트레칭 365</dt>
<s:if test="auth.menu(3)"><dd></dd></s:if>
</dl>
<dl>
<dt>나의 맞춤 운동</dt>
<s:if test="auth.menu(4)"><dd></dd></s:if>
</dl>
</div>

<div>
<dl>
<dt>MediFit</dt>
<s:if test="auth.menu(2)"><dd><a href="/prescript/listp.action?contents=sub100_4"><span class="prj-icon-64 loc2-4"></span>처방 <br/>운동 리스트</a></dd></s:if>
<s:if test="auth.menu(7)"><dd><a href="/movie/list.action?contents=sub100_6"><span class="prj-icon-64 loc2-5"></span>영상 관리</a></dd></s:if>
<s:if test="auth.menu(8)"><dd><a href="/comb/list.action?contents=sub100_7"><span class="prj-icon-64 loc2-6"></span>조합 관리</a></dd></s:if>
<s:if test="auth.menu(9)"><dd><a href="/365plus/list.action?contents=sub100_8"><span class="prj-icon-64 loc2-7"></span>365PLUS 관리</a></dd></s:if>							
<dd>
<s:if test="auth.menu(15)">
<s:if test="auth.isSiteStaff">
<a href="/medistats/personal/list?contents=sub100_14"><span class="prj-icon-64 loc2-1"></span>통합 이력관리</a>
</s:if>
<s:else>
<a href="/medistats/personal/stats?id_user=${user.id }&contents=sub100_14"><span class="prj-icon-64 loc2-8"></span>나의 이력관리</a>
</s:else>
</s:if>
	
</dd>												
<s:if test="auth.menu(10)"><dd><a href="/medi/question/list?contents=sub100_9"><span class="prj-icon-64 loc2-9"></span>문진표</a></dd></s:if>
<s:if test="auth.menu(11)"><dd><a href="/medicheck/complete/list?contents=sub100_10"><span class="prj-icon-64 loc2-10"></span>건강검진</a></dd></s:if>
<s:if test="auth.menu(12)"><dd><a href="/physics/complete/list?contents=sub100_11"><span class="prj-icon-64 loc2-11"></span>물리치료</a></dd></s:if>							
<s:if test="auth.menu(6)"><dd><a href="/prescript/list<s:if test="auth.isAdmin == false">m</s:if>.action?contents=sub100_5"><span class="prj-icon-64 loc2-1"></span>운동처방</a></dd></s:if>
<s:if test="auth.menu(13)"><dd><a href="/medicheck/complete/stats?contents=sub100_12"><span class="prj-icon-64 loc2-1"></span>통합 집계표</a></dd></s:if>
<s:if test="auth.menu(14)"><dd><a href="/healMediUser?contents=sub100_13"><span class="prj-icon-64 loc2-1"></span>회원 관리</a></dd></s:if>
</dl>
</div> --%>
</div><%-- nav 종료 --%>
</div><%-- article 종료 --%>
</div><%-- section 종료 --%>
</a:html>