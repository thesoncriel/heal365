<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags"%>
<a:html title=" - 설문지 관리" contents="${contentsCode }">
<div class="header">
	<h1>설문지 관리</h1>
	<div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>
<div class="section">
	<div class="article">
		<table class="board-list">
			<thead>
				<tr>
					<th class="row-num">번호</th>
					<th>제목</th>
					<th>업무형태</th>
					<th class="date">작성일시</th>
					<th>작성자</th>
					<th>설문기간</th>
					<th class="last">사용</th>
				</tr>
			</thead>
			<tbody>
				<s:if test="listIsNull">
					<tr>
						<td colspan="7">데이터가 없습니다</td>
					</tr>
				</s:if>
				<s:else>
					<s:iterator value="listData">
						<tr>
							<td>${row_number}</td>
							<td><a href="/admin/Survey/show?id=${id }">${subject}</a></td>
							<td>${work_type}</td>
							<td>${date_upload_fmt }</td>
							<td>${id_writer}/${writer_name }</td>
							<td>${date_start_fmt} ~ ${date_end_fmt }</td>
							<td>
								<s:if test="opt == 0">N</s:if>
								<s:if test="opt == 1">Y</s:if>
							</td>
						</tr>
					</s:iterator>
				</s:else>
			</tbody>
		</table>
		<div class="footer board">
			
				<div class="buttons">
					<a href="write?contents=${contentsCode }" class="artn-button board">등록</a>
				</div>
			
			<a:pagenav page="${param.page }" params="${params}"
				rowCount="${rowCount }" rowLimit="10" navCount="10"
				id="pagecontroller" cssClass="page-controller" font="symbol" />
		</div>
		<div>
			<s:include value="/WEB-INF/include/search/group.jsp"></s:include>
		</div>
		
		
	</div>
</div>
</a:html>