<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - 메인 페이지">
              <div class="section top-contents">
              	<div id="scroller_medifit_slide" class="medifit_slide" data-type="slide" data-auto="on" data-time="8000" data-imgWidth="" data-speed="normal">		                        
			            <ul class="medifit_slide_nav scroll_nav">
			                <li><a href="/user/menu"><span class="user-name">박시복 교수의</span>힐링 스트레칭 교실 365PLUS</a></li>
			                <li><a href="/user/menu"><span class="user-name">윤재형 원장의</span>만성통증 예방 Stretching Up</a></li>
			                <li><a href="/user/menu"><span class="user-name">조지훈 교수의</span>테마가 있는 힐링업 Core Training</a></li>
			                <li><a href="/user/menu"><span class="user-name">문훈기 센터장의</span>MediFit Training 아프니까 스트레칭</a></li>
			                <li><a href="/user/menu"><span class="user-name">개인별 맞춤형 처방 솔루션</span>MediFit Solution(전문가용)</a></li>
			            </ul>
			            <ul class="medifit_slide_img scroll_view">
			                <li><a href="#"><span>개인별 맞춤형 처방 솔루션<strong>MediFit Solution(전문가용)1</strong></span><img src="img/main/main-img-01.png" alt="" /></a></li>
			                <li><a href="#"><span>개인별 맞춤형 처방 솔루션<strong>MediFit Solution(전문가용)2</strong></span><img src="img/main/main-img-02.png" alt="" /></a></li>
			                <li><a href="#"><span>개인별 맞춤형 처방 솔루션<strong>MediFit Solution(전문가용)3</strong></span><img src="img/main/main-img-03.png" alt="" /></a></li>
			                <li><a href="#"><span>개인별 맞춤형 처방 솔루션<strong>MediFit Solution(전문가용)4</strong></span><img src="img/main/main-img-04.png" alt="" /></a></li>
			                <li><a href="#"><span>개인별 맞춤형 처방 솔루션<strong>MediFit Solution(전문가용)5</strong></span><img src="img/main/main-img-05.png" alt="" /></a></li>
			            </ul>
			            
              		<!-- <img src="/img/main/doc-park.png" alt=""/> -->
              		<a class="player-img" href="/menu"><img src="img/main/main-img-06.png" alt=""/></a>
              		<div class="service-interview">
              			<a href="/email/send?contents=sub5_6"><span>서비스 구매상담하기</span>자주문의하는 내용</a>
              		</div>
              	</div>
              </div>
              
              <div class="section bottom-contents">
              	<div class="section">
              		<div class="mini-board" data-rule="tabContents">
                  <ul class="tab">
                    <li><a href="#tab1" class="selected">공지사항</a></li>
                    <li><a href="#tab2">자료실</a></li>
                  </ul>
                  <s:property value="miniBoard('1,2,4', 4)"/>
					<div class="content" id="tab1">
					    <ul>
					    <s:iterator value="subData.mini1">
					    <li><a href="/board/show?id=${id}&amp;board_no=1&amp;view=notice&amp;contents=sub5_2" class="mini-sub" style="text-overflow:ellipsis;">${subject}</a><s:if test="util.today == date_upload_fmt"><span class="artn-icon-16 new">new</span></s:if><span class='date'>${date_upload_fmt}</span></li>
					    </s:iterator>
					    </ul>
					    <a href="board/list?board_no=1&amp;view=notice&amp;contents=sub5_2" class="artn-icon-32 more">more</a>
					</div> 
					<div class="content" id="tab2">
					    <ul>
					      <s:iterator value="subData.mini2">
					      <li><a href="/board/show?id=${id}&amp;board_no=2&amp;view=file&amp;contents=sub5_5" class="mini-sub" style="text-overflow:ellipsis;">${subject}</a><s:if test="util.today == date_upload_fmt"><span class="artn-icon-16 new">new</span></s:if><span class='date'>${date_upload_fmt}</span></li>
					      </s:iterator>
					    </ul>
					      <a href="board/list?board_no=2&amp;view=file&amp;contents=sub5_5" class="artn-icon-32 more">more</a>
					</div>
                        </div>
               <%--    <s:action name="mini"  namespace="/board" executeResult="true"/> 
                 <s:action name="mini" flush="true" executeResult="true" namespace="/board"/>--%>  
                
                <div class="customer-center">
	                <h2>고객만족센터</h2>
	                      <div class="address"><span>문의 전화 : 031.905.1659</span><!-- 02.2275.9340 --></div>
	              	</div>
              	</div>
              	
              	
              	<div class="section">
                <div class="aside product-slider">
                       <h2>BEST PRODUCT</h2>
                       
                       <div id="scroller_number_slideshow" class="number_slideshow scroller" data-type="slide" data-auto="on" data-imgWidth="" data-time="5000" data-speed="normal">
                        <ul class="scroll_view">
			                <li><a href="/contents?contents=sub4_3_5"><img src="/img/main/best-product_2_V1.png" alt="slideshow_large" /></a>
			                <a href="/contents?contents=sub4_3_5" class="artn-icon-32 more">more</a></li>
			                <li><a href="/contents?contents=sub4_3_1"><img src="/img/main/best-product_V1.png" alt="slideshow_large" /></a>
			                <a href="/contents?contents=sub4_3_1" class="artn-icon-32 more">more</a></li>
			                <li><a href="/contents?contents=sub4_3_5"><img src="/img/main/best-product_2_V1.png" alt="slideshow_large" /></a>
			                <a href="/contents?contents=sub4_3_5" class="artn-icon-32 more">more</a></li>
			                <li><a href="/contents?contents=sub4_3_1"><img src="/img/main/best-product_V1.png" alt="slideshow_large" /></a>
			                <a href="/contents?contents=sub4_3_1" class="artn-icon-32 more">more</a></li>
			            </ul>
			            <ul class="number_slideshow_nav scroll_nav">
			                <li><a href="#">1</a></li>
			                <li><a href="#">2</a></li>
			                <li><a href="#">3</a></li>
			                <li><a href="#">4</a></li>
			            </ul>
		            </div>
                   </div>           
            </div>
  	            
  	            <div class="section">    
                      <h2>바로가기</h2>
                      <div>                        
                          <a href="/menu" class="medifit"></a>
                          <a href="/contents?contents=sub1_4" class="stretching"></a>
                          <a href="/contents?contents=sub1_2" class="plus365"></a>                            
                          <a href="/contents?contents=sub1_5" class="myheal"></a>
                      </div>
                      <div class="aside">
                      	<h2>PARTNERS</h2>
                      	<div id="scroller_amazon_scroller2" class="amazon_scroller" data-type="banner" data-auto="on" data-imgWidth="234" data-time="3000" data-speed="normal">
			            <div class="amazon_scroller_mask">          
			                <ul class="scroll_view">
			                    <li><a href="/group/show?id=2&contents=sub2_1" title="title1"><img src="img/main/main-baner1.png" alt="title"/></a></li>
			                    <li><a href="/group/show?id=3&contents=sub2_1" title="title2"><img src="img/main/main-baner2.png" alt="title"/></a></li>
			                    <li><a href="/group/show?id=2&contents=sub2_1" title="title3"><img src="img/main/wellness-logo-v1.1.png" alt="title"/></a></li>
			                </ul>               
			             </div>
			             <ul class="amazon_scroller_nav scroll_nav">
			                 <li><a href="#" class="artn-icon-16 triangle-w prev">prev</a></li>
			                 <li><a href="#" class="artn-icon-16 triangle-e next">next</a></li>
			             </ul>
		         	</div>            
                      </div>
                  </div>
             	</div>                
</a:html>