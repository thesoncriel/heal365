<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - User Action Test : Menu">       
            <div class="layout-contents 365plus">
            <div class="nav left-menu">
            	<h3>365plus</h3>
                <ul>
                    <li><a href="/user/menu">메인메뉴</a></li>
                    <li><a href="/player/selector1.jsp?menu=${param.menu}">통증선택 1단계</a></li>
                    <li><a href="/player/selector2.jsp?cate_movie1=${param.cate_movie1}&direction=${param.direction}&left_right=${param.left_right}&menu=${param.menu}">통증선택 2단계</a></li>
                </ul>
            </div>
            
            <div  class="hgroup artn-bg-64 step3">
              <h2>통증선택 1단계</h2>
              <h2 class="selected">통증선택 2단계</h2>              
            </div>
            
            <div class="section">            
            <form class="365plus-selector2" action="/365plus/searchContent.action" method="get"> 
           	<input type="hidden" name="cate_movie1" value="${param.cate_movie1}"/>
            <input type="hidden" name="cate_movie2" value=""/>
            <input type="hidden" name="cate_movie3" value=""/>
            <input type="hidden" id="vas_high" name="vas_high" value="${vas_high}"/>
            <input type="hidden" name="direction" value="${param.direction}"/>
	        <input type="hidden" name="left_right" value="${param.left_right}"/>    
            <input type="hidden" name="menu" value="${param.menu}"/>
                    <div class="section sub_contents pain_selector">                        
                            <h2>Healing up 365</h2>
                            <div class="article pain-selector-365plus step2">
                                    <div class="left">
										<jsp:include page="/include/365plus/${param.cate_movie1}${param.direction}${param.left_right}.htmlpart" flush="true"/>
                                    </div>
                                    
                                    <div id="view_VasSlider">            
                                       <div id="slider_Vas"> 
                                       		<div class="main">
                                            
                                        	</div>
                                        </div>
                                    </div>
                                    <span id="result">통증강도:5.0</span>
                                </div>
                                
                                   <!-- <a href="/player/selector3.jsp" id="button_selectOK">선택완료</a>  -->
                                   <input type="submit" value="선택완료"/>
             						</div>
             					
			                </form>
			            </div>
			          </div>
</a:html>  
