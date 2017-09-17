<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
session.setAttribute("medifit_ta", "true");
response.setHeader("P3P","CP='CAO PSA CONi OTR OUR DEM ONL'");
%>
<%response.sendRedirect("/user/menu"); %>