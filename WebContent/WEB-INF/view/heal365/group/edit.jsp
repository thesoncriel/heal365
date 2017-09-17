<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<s:include value="/include/header.jsp"></s:include>
<div class="contents">
    <jsp:include page="/include/leftmenu/1.htmlpart" flush="true"/>
    <section>
		<header>
		        <h1>병원</h1>
		        <span class="navigation-url">
		        	<span class="artn-icon-16 home"></span>
		        	<a href="#">HOME</a>
		        	<span class="artn-icon-16 caret-thin-e">&gt;</span>
		        	<a href="#">회사소개</a>
		        	<span class="artn-icon-16 caret-thin-e">&gt;</span>
		        	<a href="#">병원</a>                    	
		       	</span>
		    </header>


<article class="group-edit">	
	<form action="${actionURI}" method="post" class="break_enter" enctype="multipart/form-data">
	<input type="hidden" name="width" value="660"/>
	<input type="hidden" name="height" value="400"/>
	<s:if test='%{id != null}'><input type="hidden" name="id" value="${id}"/></s:if>
	<table>
		<tr>
			<th><label>업체명</label></th>
			<td><input type="text" name="name" value="${showData.name}"/></td>
		</tr>
		<tr>
			<th><label>설립일</label></th>
			<td><input id="datepicker_old_date_estab" type="text" name="date_estab" value="${showData.date_estab}" readonly="readonly"/></td>	
		</tr>
		<tr>
			<th><label>업종</label></th>
			<td>			
				<select name="div_group">
					<option value="m">의료</option>
					<option value="c">일반기업</option>					
				</select>			
			</td>
		</tr>
		<tr>
			<th><label>부서</label></th>
			<td><input type="text" name="work_type" value="${showData.work_type}"/></td>
		</tr>
		<tr>
            <th><label for="phone">전화번호</label></th>
            <td><s:select name="phone" theme="simple" list="#{' ':'없음','02':'02', '031':'031', '032':'032', '033':'033', '041':'041', '042':'042', '043':'043', '044':'044', '051':'051', '052':'052', '053':'053', '054':'054', '055':'055', '061':'061', '062':'062', '063':'063', '064':'064'}" value="%{showData.phone1}"/>
            -<s:textfield name="phone" theme="simple" value="%{showData.phone2}"/>-<s:textfield name="phone" theme="simple" value="%{showData.phone3}"/></td>
        </tr>
		<tr>
            <th><label for="fax">팩스</label></th>
            <td><s:select name="fax" theme="simple" list="#{' ':'없음','02':'02', '031':'031', '032':'032', '033':'033', '041':'041', '042':'042', '043':'043', '044':'044', '051':'051', '052':'052', '053':'053', '054':'054', '055':'055', '061':'061', '062':'062', '063':'063', '064':'064'}" value="%{showData.fax1}"/>
            -<s:textfield name="fax" theme="simple" value='%{showData.fax2}'/>-<s:textfield name="fax" theme="simple" value="%{showData.fax3}"/></td>
        </tr>
		<tr>
            <th><label for="zipcode">병원 주소</label></th>
            <td>
                <input type="text" name="zipcode" theme="simple" readonly="readonly" value="${showData.zipcode}"/><input type="button" class="" value="우편번호 검색" name="search" /><br/>
                <input type="text" name="address1" theme="simple" readonly="readonly" value="${showData.address1}"/><br/>
                <input type="text" name="address2" theme="simple" value="${showData.address2}"/>
            </td>
        </tr>
		<tr>
			<th><label>대표자</label></th>
			<td>
			<s:if test='%{showData == null}'>
			<input type="text" name="name_user" value="${session.user.name}"/>
			<input type="hidden" name="id_user" value="${session.user.id}"/>
			</s:if>
			<s:else>
			<input type="text" name="name_user" value="${showData.name_user}"/>
            <input type="hidden" name="id_user" value="${showData.id_user}"/>
            </s:else>
			</td>
		</tr>
			
		<tr>
			<th><label>홈페이지</label></th>
			<td>
			<s:if test='%{showData == null}'>
            <input type="text" name="url" value="Http://"/>
			</s:if>
            <s:else>
            <input type="text" name="url" value="${showData.url}"/>
            </s:else>
			</td>
		</tr>
		<tr>
			<th><label>지도좌표</label></th>
			<td><input type="text" name="coordinate" value="${showData.coordinate}"/>
			    <input type="hidden" name="url_map" value="${showData.url_map}"/>
			    <input type="button" name="map_button" value="좌표찾기"/>
			</td>
		</tr>		
		<tr>
		    <th><label>회사소개</label></th>
			<td><textarea name="intro">${showData.intro}</textarea></td>
		</tr>
		<tr>
		    <th><label>이미지 파일</label></th>
            <td>
            	<s:if test="%{showData.file_img != ''}">
            		<span class="filename">현재 첨부<br/></span>
            		<a href="/upload/group/img/${showData.file_img}">
            			<img src="/upload/group/img/${showData.file_img}" alt="이미지" width="85" />
            		</a>
            		
            	</s:if>
                <s:else><img src="/media/thumb/none.png" alt="썸네일" width="85" /></s:else>
               	<s:file id="file_img" name="file_img" value="%{showData.file_img}" theme="simple"/>
               	
            </td>
		</tr>
		<tr>
		    <th><label>배너 파일</label></th>
            <td>
            	<s:if test="%{showData.file_banner != ''}">
            		<span class="filename">현재 첨부<br/></span>
            		<a href="/upload/group/img/${showData.file_banner}">
            			<img src="/upload/group/banner/${showData.file_banner}" alt="이미지" width="85" />
            		</a>
            		
            	</s:if>
                <s:else><img src="/media/thumb/none.png" alt="썸네일" width="85" /></s:else>
               	<s:file id="file_banner" name="file_banner" value="%{showData.file_banner}" theme="simple"/>
               	
            </td>
		</tr>
	</table>
	
	<footer class=""> 
	   	<div class="buttons">   
			<input type="hidden" name="file_banner" value="${showData.file_banner}"/>
			<input type="hidden" name="file_img" value="${showData.file_img}"/>
				<input type="submit" class="artn-button board" value="작성 완료"/>
				<a href="list.action" class="artn-button board">취소</a>
		</div>
	</footer>      
		
		
		</form>
		</article>
	</section>
</div>
<div id = "dialog_Zipcode" title="우편번호 찾기"  style="display: none;">
    <section>
        <article>
            <form class="zipcode-search" action="" class="artn-search">
            <label for="dong">동 입력</label><input type="text" name="dong" value="" />
            <input type="button" class="artn-button board" name="dong-search" value="검색"/>
            <input type="hidden" name="class-name"/>
            
                <table class = "search-result">
                    <thead>
                    <tr>
                        <th>우편번호</th>
                        <th colspan="2">주소</th>
                    </tr>
                    </thead>
                    <tbody class="result-select">
                    </tbody>
                </table>
            </form>
        </article>
    </section>
</div>
<s:include value="/include/footer.htmlpart"></s:include>
