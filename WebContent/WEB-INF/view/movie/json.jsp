<%@ page language="java" contentType="text/plain; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<% response.addHeader("Access-Control-Allow-Origin", "*"); %>
<%-- TODO: ajax로 데이터만 보낼 시 스트림 방식으로 할 것 --%>

<s:property value="JSON" escapeHtml="false"/>