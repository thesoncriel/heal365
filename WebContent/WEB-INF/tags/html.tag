<%@tag import="artn.database.DBManager"%>
<%@tag import="artn.common.model.Environment"%>
<%@tag import="artn.common.model.Visitor"%>
<%@tag import="artn.common.manager.LoginManager"%>
<%@ tag body-content="scriptless" pageEncoding="UTF-8" description="공통으로 쓰이는 html 바탕 구조" trimDirectiveWhitespaces="true" %>
<%@ attribute name="title" %>
<%@ attribute name="contents" %>
<%@ attribute name="innerClear" type="java.lang.Boolean" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%!
	public int getMenuNumber(String subValue){
	    try{
	    	String sValue = subValue.split("_")[0];
	        return Integer.parseInt( sValue.substring(3, sValue.length()) );
	    }
	    catch(Exception ex){
	        return 0;
	    }
	}
%>
<%
if ((contents != null) && (contents.equals("") == true)){
	//response.sendRedirect("/main");
	request.setAttribute("menu", 0);
}
else{
	request.setAttribute("menu", getMenuNumber(contents));
}

//사용자 접속정보 객체 등록부 [시작]
if(session.getAttribute("loginManager") == null){	
	request.getSession().setAttribute("loginManager", LoginManager.getInstance());
}
if(session.getAttribute("environment") == null){	
	Visitor visitor = new Visitor( request.getHeader("referer"), request.getRemoteAddr() );
	Environment environment = new Environment(request.getHeader("User-Agent"));
	DBManager dbm = null;
	
	visitor.readEnvironment(environment);
	
	if(session.getAttribute("id_user") == null){
		visitor.setIdUser("guest");
	}
	
	if(session.getAttribute("dbm") == null){
		dbm = new DBManager();
	}
	else{
		dbm = (DBManager)session.getAttribute("dbm");
	}
	
	session.setAttribute("visitor", visitor);
	session.setAttribute("environment", environment);
	session.setAttribute("dbm", dbm);
	visitor.doInsert( dbm );
}
//사용자 접속정보 객체 등록부 [종료]

response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, pre-check=0, post-check=0, max-age=0");
response.setHeader("Pragma", "no-cache, no-store");   
response.setDateHeader("Expires", 0);

if (request.getProtocol().equals("HTTP/1.1")){
	//response.setHeader("Cache-Control", "no-cache");
}

if ("true".equals(session.getAttribute("medifit_ta"))){
	/* response.setHeader("P3P","CP='CAO PSA CONi OTR OUR DEM ONL'");	 */
}
%>
<%--<s:bean name="artn.common.model.User" var="user"><s:property value="#session.user"/></s:bean> --%>
<s:set name="artn.common.model.User" var="user" value="#session.user"></s:set>
<!DOCTYPE html>
<html>
    <head> 
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta http-equiv="Expires" content="-1"> 
		<meta http-equiv="Pragma" content="no-cache"> 
		<meta http-equiv="Cache-Control" content="no-cache"> 
        <%--<meta name="viewport" content="initial-scale=1.0, user-scalable=no">--%>
        <jsp:include page="/WEB-INF/include/title_css_script.htmlpart"/>
	</head>
    <body>
<%if((innerClear == null) || (innerClear == false)){ %>
        <input type="hidden" name="contents" value="${param.contents}"/>
        <input type="hidden" name="join" value="${param.join}"/>
        <input type="hidden" class="menu_selector" data-sub="${param.contents}"/>
        <div class="container">
            <%-- <div class="header" <%if( "true".equals(session.getAttribute("medifit_ta"))){ %>style="display: none;"<%}%>> --%>
            <%if( "true".equals(session.getAttribute("medifit_ta"))){ %>
            <div class="header medifit_ta">
                <div class="nav top-menu">
                    <span>
                        <s:if test="auth.isAdmin">
                                <s:select name="changeGroup" id="change" list="session.userGroup" listKey="id" listValue="name" headerKey="" headerValue="--병원 선택--" theme="simple" value="session.idGroup"/>
                        </s:if>
                        <s:elseif test="auth.isSiteUser">
                                <s:select name="changeGroup" id="change" list="session.userGroup" listKey="id_group" listValue="group_name" headerKey="" headerValue="--병원 선택--" theme="simple" value="session.idGroup"/>
                        </s:elseif>                    
                    </span>
                        <s:if test ="#user.isAdmin == true">
                        <a href="/admin">admin</a>
                        </s:if>
                        <s:if test='%{#user != null}'>
                            <s:property value="#user.name"/>님 환영합니다.
                            <a href="/logout">로그아웃</a>
                        </s:if>
                        <s:else>
                            <a href="/login">로그인</a>
                        </s:else>
                </div>
            </div>
            <%}else{%>
            <div class="header">
                <div class="nav top-menu">
                    <span>
                        <s:if test="auth.isAdmin">
                                <s:select name="changeGroup" id="change" list="session.userGroup" listKey="id" listValue="name" headerKey="" headerValue="--병원 선택--" theme="simple" value="session.idGroup"/>
                        </s:if>
                        <s:elseif test="auth.isSiteUser">
                                <s:select name="changeGroup" id="change" list="session.userGroup" listKey="id_group" listValue="group_name" headerKey="" headerValue="--병원 선택--" theme="simple" value="session.idGroup"/>
                        </s:elseif>                    
                    </span>
                        <s:if test ="#user.isAdmin == true">
                        <a href="/admin">admin</a>
                        </s:if>
                        <s:if test='%{#user != null}'>
                            <s:property value="#user.name"/>님 환영합니다.
                            <a href="/logout">로그아웃</a>
                        </s:if>
                        <s:else>
                            <a href="/login">로그인</a>
                            <a href="/join">회원가입</a>
                        </s:else>
                        <a href="/index.jsp">Home</a>
                        <a href="/contents?contents=sub5_7">Sitemap</a>
                        <!-- <a href="/contents.jsp?contents=sub4_6&menu=4">Contact Us</a> -->
                        <s:if test="#user != null">                    
                        <a href="/user/show.action?id=${user.id }">My Page</a>
                        </s:if>
                </div>
                
                <div class="top-gnb">
                    <jsp:include page="/WEB-INF/include/menu/gnb.jsp"/>
                </div>                          
            </div>
            <%} %>
<div id="body">
<div class="contents-wrap">
<s:set var="menu">${menu }</s:set>
<s:if test="#menu > 0">
	<div class="nav left-menu side-nav">
	<jsp:include page="/WEB-INF/include/menu/${menu }.jsp"/>
	</div>
	<div class="section contents">
		<jsp:doBody/>
	</div>	
</s:if>
<s:else>
	<div class="contents">
		<jsp:doBody/>
	</div>
</s:else>
</div>
</div>
<div id="footer" <%if( "true".equals(session.getAttribute("medifit_ta"))){ %>style="display: none;"<%}%>>
   <jsp:include page="/WEB-INF/include/footer.htmlpart"/>
</div>
<div id="aside"><%--
<s:include value="/WEB-INF/include/browserClick.htmlpart"/>
<jsp:include page="/WEB-INF/include/browser.htmlpart" flush="true" /> --%>
</div>
</div>
<%} else { %><jsp:doBody/><%} %>
<iframe id="inneriframe" style="display : none;">
</body>
</html>