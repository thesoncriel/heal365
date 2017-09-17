<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 주치의 목록" contents="${contentsCode }">
<div class="header">            
    <h1>주치의 찾기</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>    
    <div class="section">
        <div class="article">
            <table class="board-list">
                <thead>
                    <tr>
                        <th class="row-num">번호</th>
                        <th class="name">성명</th>
                        <th>소속병원</th>
                        <th>병원 전화번호</th>
                        <th>직급</th>
                        <th class="last">상세정보</th>
                    </tr>
                </thead>
                <tbody>
                    <s:if test="listIsNull">
                            <tr><td colspan="7">그룹사용자가 없습니다</td></tr>
                    </s:if>
                    <s:else>
                    <s:iterator value="listData">
                        <tr>
                            <td>${row_number }</td>
                            <td>${user_name }</td>
                            <td><a href="/mediuser/list?id_group=${id_group}&contents=${contentsCode }">${group_name }</a></td>
                            <td>${phone_group } </td>
                            <td>${auth_group_kor }</td>
                            <td><a href="show?id=${id }&contents=${contentsCode }">정보 보기</a></td>
                        </tr>
                    </s:iterator>
                    </s:else>
                </tbody>
            </table>

            <div class="footer board">
                <a:pagenav page="${param.page }" params="${params}" rowCount="${rowCount }" rowLimit="10" navCount="10" id="pagecontroller" cssClass="page-controller" font="symbol" />
            </div>
            <div>
            <s:include value="/WEB-INF/include/search/mediUser.jsp"></s:include>
            </div>
        </div>
    </div>
</a:html>
