<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - User Action Test : Menu" contents="${param.contents }">             
<div class="layout-contents 365plus">
            <%-- <div  class="nav left-menu">
            	<h3>365plus</h3>
                <ul>
                    <li><a href="/user/menu">메인메뉴</a></li>
                    <li><a href="/player/selector1.jsp?menu=${param.menu}">통증선택 1단계</a></li>
                </ul>
            </div> --%>
                         
                      <!-- <hgroup class="artn-bg-64 step3">
	                    <h2 class="selected">통증선택 1단계</h2>
	                    <h2>통증선택 2단계</h2>	                    
	                  </hgroup> -->
	                <img src="/img/common/heal_sub_Service.png"/>  
                    <%-- <section class="sub_contents selector">
                            <h2>Healing up 365</h2>
                            <article class="pain-selector-365plus step1">
                                <img src="/img/365plus/body/0.png" usemap="#body_selector" alt="" />
                                <map name="body_selector">
                                    <area shape="poly" coords="49,6,36,13,30,33,30,57,22,73,37,64,48,84,50,6" href="/player/selector2.jsp?cate_movie1=2" alt="1.L" />
                                    <area shape="poly" coords="52,7,53,81,65,65,77,73,82,61,79,49,76,37,68,16,52,7" href="#" alt="1.R" />
                                    <area shape="poly" coords="23,74,24,89,21,131,3,132,9,85,12,79,21,72" href="#" alt="2.L" />
                                    <area shape="poly" coords="75,73,80,132,99,132,97,92,91,80,75,71" href="#" alt="2.R" />
                                    <area shape="poly" coords="1,133,21,133,17,161,18,193,28,218,25,227,24,235,11,227,2,208,0,133" href="#" alt="3.L" />
                                    <area shape="poly" coords="82,132,86,198,79,222,82,234,95,228,102,209,102,132,82,130" href="#" alt="3.R" />
                                    <area shape="poly" coords="38,63,25,70,18,170,53,178,51,101,37,63" href="#" alt="4.L" />
                                    <area shape="poly" coords="51,101,51,177,63,176,79,172,84,168,76,71,66,63,64,84,51,100" href="#" alt="4.R" />
                                    <area shape="poly" coords="17,170,18,197,24,211,49,215,51,176,16,170" href="#" alt="5.L" />
                                    <area shape="poly" coords="51,177,52,177,52,215,81,209,87,201,85,168,51,177" href="#" alt="5.R" />
                                    <area shape="poly" coords="26,213,52,216,49,279,24,279,23,249,20,234,28,210" href="#" alt="6.L" />
                                    <area shape="poly" coords="53,215,56,280,81,280,86,233,83,210,52,215" href="#" alt="6.R" />
                                    <area shape="poly" coords="24,280,45,280,53,324,49,347,51,364,51,380,38,390,30,379,23,279" href="#" alt="7.L" />
                                    <area shape="poly" coords="58,279,79,279,78,334,76,372,75,388,61,384,54,367,50,350,58,277" href="#" alt="7.R" />
                                </map>
                                
                                <div id="position">
                                	<form name="position" action="/player/selector2.jsp" method="get">
	                                	<input type="hidden" name="cate_movie1" value=""/>
	                                	<input type="hidden" name="direction" value=""/>
	                                	<input type="hidden" name="left_right" value=""/>
	                                	<h3>방향을 선택하세요</h3>
		                                <nav>
		                                	<ul>     
					                            <li><a href="#" class="">앞</a></li>
					                            <li><a href="#" class="">뒤</a></li>
					                            <li><a href="#" class="">옆</a></li>
				                            </ul>
		                        		</nav>
		                        		<input type="hidden" name="menu" value="${param.menu}"/>
	                        		</form>
                        		</div>
                            </article>                
                        </section>         --%>               
                </div>
</a:html> 
