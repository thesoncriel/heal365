<%@tag import="java.util.Map"%>
<%@tag import="java.util.List"%>
<%@ tag body-content="empty" pageEncoding="UTF-8" description="이메일 그룹 자동 생성 태그" trimDirectiveWhitespaces="true" %>
<%@ attribute name="list" type="java.lang.Object" %>
<%
List<Map<String, Object>> mList = (List<Map<String, Object>>)list;
out.print(list.getClass() + "<br/>" );
out.print(mList.get(0).get("value") );
%>