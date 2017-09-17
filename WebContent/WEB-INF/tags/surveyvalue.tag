<%@tag import="artn.common.tag.SurveyValueMaker"%>
<%@ tag body-content="empty" pageEncoding="UTF-8" description="각종 셀렉트박스 자동 생성 태그" trimDirectiveWhitespaces="true" %>
<%--
	
--%>
<%@ attribute name="id" %>
<%@ attribute name="name" %>
<%@ attribute name="value" type="java.lang.Integer"  %>
<%@ attribute name="cssClass" %>
<%@ attribute name="style" %>
<%@ attribute name="offset" type="java.lang.Integer" %>
<%@ attribute name="wrap" %>
<%

SurveyValueMaker radio = new SurveyValueMaker(id, cssClass, style, name, value);
radio.setOffset(offset).setWrap(wrap);

out.print(radio.make().toString());
%>