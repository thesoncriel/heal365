<%@page import="artn.common.Const"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 영상 등록 및 관리" contents="${contentsCode }">
<div class="header">
    <h1>영상 관리</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }" data-target="left"></div>
</div>

<div class="section">
<div class="article">
	<%-- <h2>개별 영상 <s:if test="%{showData == null}">변경</s:if><s:else>추가</s:else></h2>--%>	
	
<form action="modify.action" method="post" enctype="multipart/form-data" class="validator">	
		<s:if test="showIsNull == false"><input type="hidden" name="id" value="${showData.id}"/></s:if>
		<table class="board-edit">
            <thead>
            	<tr>
                    <th><label>추가된 영상</label></th>
                    <td>
                    	<a:img id="img_Thumbnail" src="/media/img/${showData.file_img}" alt="썸네일" srcNone="/media/thumb/none.png" altNone="없음" width="85"/>
                   	</td>
                </tr>
                <tr>
                    <th><label>제목</label></th>
                    <td><input type="text" value="${showData.subject}" name="subject"/></td>                                
                </tr>
                <tr>
                    <th><label>영상코드</label></th>
                    <td><input type="text" value="${showData.movie_code}" name="movie_code" required="required"/></td>                                
                </tr>
                <tr>
                    <th><label>동영상 파일 (.webm)</label></th>
                    <td>
                   		<a:file name="file_webm" id="file_Webm" value="${showData.file_webm}" path="/media/webm/"/>
                   		<input type="hidden" name="file_webm" value="${showData.file_webm}"/>
                   		<input type="hidden" name="ori_webm" value="${showData.ori_webm}"/>
                    </td>
                </tr>
                <tr>                    
                    <th>
                    	<label>동영상 파일 (.mp4)</label> 
                    </th>
                    <td>
                   		<a:file name="file_mp4" id="file_Mp4" value="${showData.file_mp4}" path="/media/mp4/"/>
                   		<input type="hidden" name="file_mp4" value="${showData.file_mp4}"/>
                   		<input type="hidden" name="ori_mp4" value="${showData.ori_mp4}"/>
                    </td>
                </tr>
                <tr>
                    <th>
                    	<label>음성 파일 (.ogg)</label>
                	</th>
                    <td>
                   		<a:file name="file_ogg" id="file_Ogg" value="${showData.file_ogg}" path="/media/ogg/"/>
                   		<input type="hidden" name="file_ogg" value="${showData.file_ogg}"/>
                   		<input type="hidden" name="ori_ogg" value="${showData.ori_ogg}"/>
                    </td>
                </tr>
                <tr>   
                    <th>
                    	<label>음성 파일 (.mp3)</label>
                    </th>
                    <td>
                   		<a:file name="file_mp3" id="file_Mp3" value="${showData.file_mp3}" path="/media/mp3/"/>
                   		<input type="hidden" name="file_mp3" value="${showData.file_mp3}"/>
                   		<input type="hidden" name="ori_mp3" value="${showData.ori_mp3}"/>
                    </td>
                </tr>
                <tr>
                    <th>
                    	<label>설명 파일 (.jpg)</label> 
                	</th>
                    <td>
                   		<a:file name="file_img" id="file_Img" value="${showData.file_img}" path="/media/img/"/>
                   		<input type="hidden" name="file_img" value="${showData.file_img}"/>
                   		<input type="hidden" name="ori_img" value="${showData.ori_img}"/>
                    </td>
                </tr>
                <tr>
                    <th>
                    	<label>설명 영상 (.mp4)</label> 
                	</th>
                    <td>
                   		<a:file name="file_mp4narr" id="file_Mp4narr" value="${showData.file_mp4narr}" path="/media/mp4narr/"/>
                   		<input type="hidden" name="file_mp4narr" value="${showData.file_mp4narr}"/>
                   		<input type="hidden" name="ori_mp4narr" value="${showData.ori_mp4narr}"/>
                    </td>
                </tr>
                <tr>
                    <th>
                    	<label>자막 파일 (.smi)</label> 
                    </th>
                    <td>
                   		<a:file name="file_smi" id="file_Smi" value="${showData.file_smi}" path="/media/smi/"/>
                   		<input type="hidden" name="file_smi" value="${showData.file_smi}"/>
                   		<input type="hidden" name="ori_smi" value="${showData.ori_smi}"/>
                    </td>
                </tr>
                <tr><th><label>업무구분</label></th>
		        	<td><s:include value="/include/combobox-data/cate_movie.jsp">
						<s:param name="cmb">cate_movie0</s:param>
						<s:param name="val">${showData.cate_movie0 }</s:param>
					</s:include></td></tr>
		        
		        <tr><th><label>통증부위1</label></th>
		        	<td><s:include value="/include/combobox-data/cate_movie.jsp">
						<s:param name="cmb">cate_movie1</s:param>
						<s:param name="val">${showData.cate_movie1 }</s:param>
						<s:param name="sub">${showData.cate_movie0 }</s:param>
						<s:param name="chain">['cate_movie0']</s:param>
					</s:include></td></tr>
		        
		        <tr><th><label>통증부위2</label></th>
		        	<td><s:include value="/include/combobox-data/cate_movie.jsp">
						<s:param name="cmb">cate_movie2</s:param>
						<s:param name="val">${showData.cate_movie2 }</s:param>
					</s:include></td></tr>
		        
		        <tr><th><label>통증부위3</label></th>
		        	<td><s:include value="/include/combobox-data/cate_movie.jsp">
						<s:param name="cmb">cate_movie3</s:param>
						<s:param name="val">${showData.cate_movie3 }</s:param>
						<s:param name="sub">${showData.cate_movie1 }.${showData.cate_movie2 }</s:param>
						<s:param name="chain">['cate_movie1', 'cate_movie2']</s:param>
					</s:include>
					</td>
			    </tr>
			    <tr><th><label>VAS</label></th>
                    <%-- <td><s:include value="/include/combobox-data/cate_movie.jsp">
                        <s:param name="cmb">vas_high</s:param>
                        <s:param name="val">${showData.vas_high }</s:param>
                    </s:include></td> --%>
                    <td>최소 <s:select name="vas_low" list="#{'0.0':'0.0', '1.0':'1.0', '2.0':'2.0', '3.0':'3.0', '4.0':'4.0', 
                                            '5.0':'5.0', '6.0':'6.0', '7.0':'7.0', '8.0':'8.0', '9.0':'9.0', '10.0':'10.0'}" theme="simple" value="showData.vas_low"/><br/>
                        최대 <s:select name="vas_high" list="#{'0.0':'0.0', '1.0':'1.0', '2.0':'2.0', '3.0':'3.0', '4.0':'4.0', 
                                            '5.0':'5.0', '6.0':'6.0', '7.0':'7.0', '8.0':'8.0', '9.0':'9.0', '10.0':'10.0'}" theme="simple" value="showData.vas_high"/>
                    </td>
                </tr>
                <tr>
                    <th colspan="2">운동 카테고리</th>
                </tr>
                <tr>
                    <th><label>운동부위</label></th>
                    <td><a:checkboxlist name="cate_sub_loc" subWrap="span" id="checkboxlist_cate_sub_loc" list="앉기,바로눕기,측면눕기,서기,엎드리기,무릎꿇기" value="${showData.cate_sub_loc }"/></td>
                </tr>
                <tr>
                    <th><label>도구사용</label></th>
                    <td><a:checkboxlist name="cate_sub_tool" subWrap="span" id="checkboxlist_cate_sub_tool" list="밴드,공,아령,펌롤,수건,지팡이,벽,의자,배게,모래주머니,퍼티,발란스 보드,바디 블레이드" value="${showData.cate_sub_tool }"/></td>
                </tr>
                <tr>
                    <th><label>운동방법</label></th>
                    <td><a:checkboxlist name="cate_sub_mode" subWrap="span" id="checkboxlist_cate_sub_mode" list="등척성,등장성,등속성,PROM,AROM,AAROM,P Streaching,A Stretching,plyometric,Mobilization" value="${showData.cate_sub_mode }"/></td>
                </tr>
                <tr>
                    <th><label>운동적용부위</label></th>
                    <td><a:checkboxlist name="cate_sub_part" subWrap="span" id="checkboxlist_cate_sub_part" list="발,발목,종아리,무릎,대퇴,엉덩이,허리,가슴,복부,등,목,어깨,팔꿈치,팔목,손" value="${showData.cate_sub_part }"/></td>
                </tr>
                <tr>
                    <th><label>운동 메카니즘</label></th>
                    <td><a:checkboxlist name="cate_sub_mecha" subWrap="span" id="checkboxlist_cate_sub_mecha" list="OKC,CKC,Neutral,Adduction,Abduction,Flexion,Extension,Rotation,Inversion,Eversion,Pronation,Supinaton,IR,ER,D1,D2,Obliq,Side Bend,Protraction,Retraction,Horizontal,Elevation,Press,Pull" value="${showData.cate_sub_mecha }"/></td>
                </tr>
		        <%-- <tr><th><label>운동별 분류</label></th>
		            <td colspan="5"><s:select name="cate_sub" value="showData.cate_sub" list="#{
							        '0': '-',
							        '1': '관절가동범위운동',
							        '2': '스트레칭',
							        '4': '등척성 운동',
                                    '8': '등장성 운동(도구 없음)',
                                    '24': '등장성 운동(덤벨 운동)',
                                    '40': '등장성 운동(밴드 운동)',
                                    '72': '등장성 운동(짐볼 운동)',
                                    '136': '등장성 운동(기타 도구)'
				                    }" theme="simple"></s:select>
				    </td>
		        </tr> --%>
			    
            </thead>                    
        </table>
		<div class="footer board">
            <div class="buttons">
		        <a href="list.action" class="artn-button board">취소</a>
		        <s:if test="%{showIsNull == true}"><input type="submit" class="artn-button board" value="추가"/></s:if>
					<s:else><input type="submit" class="artn-button board" value="변경"/></s:else>
	        </div>
       	</div>
<input type="hidden" name="contents" value="${contents }"/>	
</form>
</div>
</div>
<div id="dialog_player" title=""> 
    <video width="320" height="240" controls>
        <source src="/media/webm/${showData.file_webm}" type="video/webm">    
    </video>    
</div>
</a:html>