<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:include value="/include/header.jsp"></s:include>
<div class="contents">
	<jsp:include page="/include/leftmenu/4.htmlpart" flush="true" />
	<section>
	    <header>
             <h1>주치의 찾기</h1>
             <span class="navigation-url">
             	<span class="artn-icon-16 home"></span>
             	<a href="#">HOME</a>
             	<span class="artn-icon-16 caret-thin-e">&gt;</span>
             	<a href="#">서비스안내</a>  
             	<span class="artn-icon-16 caret-thin-e">&gt;</span>
             	<a href="#">주치의 찾기</a>                  	
            	</span>
         </header>
		<article class="static-contents board-search">

			<form class="search top" action="">
                <s:include value="/include/search/userDoctor.jsp"></s:include>
            </form>
			<table class="artn-board list">
				<thead class="delimiters">
					<tr>
						<th>사진</th>
						<th>프로필</th>
						<th>병원명</th>
					</tr>
				</thead>
				<tbody class="div-hr">
					<s:iterator value="ListData">
					       	<tr>
								<td><a href="#"><img class="effect frame" src="/upload/user/img/${file_img}" alt="" /></a></td>
								<td>
									<dl>
										<dt>의사명:</dt>
										<dd>
											<s:property value="name" />
										</dd>
										<dt>진료과:</dt>
										<dd>
											<s:property value="group_dept" />
										</dd>
										<dt class="long">전문진료분야</dt>
										<dd>
											<s:property value="comment" />
										</dd>
									</dl>
								</td>
								<td><s:property value="group_name" /></td>
							</tr>
					</s:iterator>
					<s:if test="%{rowCount == 0}">
						<tr>
							<td colspan="3">자료가 없습니다.</td>
						</tr>
					</s:if>
				</tbody>
			</table>
			<div class="page-controller">
				<s:property value="pageController" escapeHtml="false" />
			</div>
		</article>
	</section>
</div>
<s:include value="/include/footer.htmlpart"></s:include>
