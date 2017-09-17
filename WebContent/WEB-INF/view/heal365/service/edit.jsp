<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<s:include value="/include/header.jsp"></s:include>
<div class = "contents">
<s:include value="/include/leftmenu/4.htmlpart"></s:include>
<section><img src="/img/common/Under-Construction.png"/>
    <%-- <s:if test = '%{service_type == "A"}'>
	   <header>
            <h1>제품주문하기</h1>
            <span class="navigation-url">
                <span class="artn-icon-16 home"></span>
                <a href="#">HOME</a>
                <span class="artn-icon-16 caret-thin-e">&gt;</span>
                <a href="#">서비스안내</a>  
                <span class="artn-icon-16 caret-thin-e">&gt;</span>
                <a href="#">제품주문하기</a>                      
            </span>
        </header>
	</s:if>
	<s:elseif test = '%{service_type == "B"}'>
	<header>
        <h1>1:1 상담하기</h1>
        <span class="navigation-url">
            <span class="artn-icon-16 home"></span>
            <a href="#">HOME</a>
            <span class="artn-icon-16 caret-thin-e">&gt;</span>
            <a href="#">서비스안내</a>  
            <span class="artn-icon-16 caret-thin-e">&gt;</span>
            <a href="#">1:1 상담하기</a>                    
        </span>
    </header>
	</s:elseif>
	<article class="service-board">
	   <p>* 필수 입력 사항입니다.</p>
	   <form id="service_form" action="${actionURI}" method="post" class="break_enter">
		<table>
			<tr>
				<th><label>* 회사명</label></th>
				<td><s:textfield name="group_name" theme="simple" value="%{showData.group_name}"/></td>
			</tr>
			<tr>
				<th><label>* 고객명</label></th>
				<td><s:textfield name="name" theme="simple" value="%{showData.name}"/></td>
			</tr>
			<tr>
				<th><label>* 연락처</label></th>
				<td><s:select name="phone" theme="simple" list="#{'010':'010', '011':'011', '016':'016', '017':'017', '018':'018', '019':'019', '02':'02', '031':'031', '032':'032', '033':'033', '041':'041', '042':'042', '043':'043', '044':'044', '051':'051', '052':'052', '053':'053', '054':'054', '055':'055', '061':'061', '062':'062', '063':'063', '064':'064', '070':'070'}" value="%{showData.phone}"/>-<s:textfield name="phone" theme="simple" value="%{showData.phone}"/>-<s:textfield name="phone" theme="simple" value="%{showData.phone}"/></td>
			</tr>

			<tr>
				<th><label>* 이메일 주소</label></th>
				<td><s:textfield name="email" theme="simple" value="%{showData.email}"/>@<s:if test='%{showIsNull == true}'>
                    <s:textfield name="email" id="emailSub" theme="simple" value="naver.com" readonly="true" />
                    </s:if>
                    <s:else>
                    <s:textfield name="email" id="emailSub" theme="simple" value='%{showData.email2}' readonly="true" />
                    </s:else>
                    <s:select name="emailSub" theme="simple" list="#{'naver.com':'naver.com', 'hanmail.net':'hanmail.net', 'google.com':'google.com', 'nate.com':'nate.com', 'empas.com':'empas.com', 'lycos.co.kr':'lycos.co.kr', 'netsgo.com':'netsgo.com', 'empal.com':'empal.com', 'yahoo.co.kr':'yahoo.co.kr', 'hotmail.com':'hotmail.com', 'paran.com':'paran.com', 'dreamwiz.com':'dreamwiz.com', ' ':'직접입력'}" value='%{showData.email2}'/>
                </td>
			</tr>

			<tr>
				<th><label>홈페이지</label></th>
				<td><s:textfield name="url" theme="simple" value="%{showData.url}"/></td>
			</tr>
			<s:if test = "%{showData == null}">
            <input type="hidden" name = "service_type" value="${param.service_type}"/>
            </s:if>
            <s:else>
            <s:hidden name = "service_type" value="%{showData.service_type}"/>
            </s:else>
			<tr>
				<th><label>* 문의 제목</label></th>
				<td><s:textfield name="subject" theme="simple" value="%{showData.subject}"/></td>
			</tr>

			<tr>
				<th><label>* 문의 내용</label></th>
				<td colspan="2"><textarea name="content">${showData.content}</textarea></td>
			</tr>
		</table>
		
        <div class="buttons">
	        <s:hidden type="hidden" name="date_upload" value="%{showData.date_upload}"/>
			<span class="artn-button board"><input type="submit" value="작성 완료" /></span>
		   </div>
        </form>
	</article> --%>
</section>
</div>
<s:include value="/include/footer.htmlpart"></s:include>