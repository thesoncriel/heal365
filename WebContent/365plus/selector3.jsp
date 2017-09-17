<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - User Action Test : Menu" contents="${param.contents }">        
            <div class="layout-contents 365plus">
            <div class="nav left-menu">
            	<h3>365plus</h3>
                <ul>
                    <li><a href="/user/menu">메인메뉴</a></li>
                    <li><a href="/player/selector1.jsp">통증선택 1단계</a></li>
                    <li><a href="/player/selector2.jsp?cate_movie1=${param.cate_movie1}&cate_movie2=${param.cate_movie2}&cate_movie3=${param.cate_movie3}&vas_high=${param.vas_high}&direction=${param.direction}&left_right=${param.left_right}">통증선택 2단계</a></li>
                    <li><a href="/player/selector3.jsp?cate_movie1=${param.cate_movie1}&cate_movie2=${param.cate_movie2}&cate_movie3=${param.cate_movie3}&vas_high=${param.vas_high}">설문조사</a></li>
                </ul>
            </div>

            		<div class="hgroup artn-bg-64 step3">
	                    <h2>통증선택 1단계</h2>
	                    <h2>통증선택 2단계</h2>
	                    <h2 class="selected">설문조사</h2>
                    </div>

            <div class="section">
        	<form action="/365plus/searchContent.action" method="post">

            <input type="hidden" name="cate_movie1" value="${param.cate_movie1}"/>
            <input type="hidden" name="cate_movie2" value="${param.cate_movie2}"/>
            <input type="hidden" name="cate_movie3" value="${param.cate_movie3}"/>
            <input type="hidden" name="vas_high" value="${param.vas_high}"/>
            <input type="hidden" name="left_right" value="${param.left_right}"/>
            		
                    <div class="section sub_contents survey_list">
                            <h2>Healing up 365</h2>
                            <div class="article pain-selector-365plus step3">
                                                <h3><!-- <img src="/img/arrow2.png" alt="" /> -->설문조사</h3>
                                                <ol>
                                                    <li>
                                                           <h4>1 통증이 언제부터 생겼습니까?</h4>
                                                        <ul>
                                                            <li>
                                                                <p><input type="radio" id="day" value="일전" name="sick" checked="checked" /><!-- <label for="day">일전</label> -->
                                                                    <select id="day_sick">
                                                                        <option value="sel">선택</option>
                                                                        <option value="1">1</option>
                                                                        <option value="2">2</option>
                                                                        <option value="3">3</option>
                                                                        <option value="4">4</option>
                                                                        <option value="5">5</option>
                                                                        <option value="6">6</option>
                                                                        <option value="7">7</option>
                                                                    </select>
                                                                        <label for="day_sick">일전</label></p>
                                                            </li>
                                                             
                                                             <li>   
                                                                <p><input type="radio" id="week" value="주전" name="sick" /><!-- <label for="week">주전</label> -->
                                                                    <select id="week_sick">
                                                                        <option value="sel">선택</option>
                                                                        <option value="1">1</option>
                                                                        <option value="2">2</option>
                                                                        <option value="3">3</option>
                                                                        <option value="4">4</option>
                                                                        <option value="5">5</option>
                                                                   </select>
                                                                        <label for="week_sick">주전</label></p>
                                                            </li>
                                                            
                                                            <li>
                                                                <p><input type="radio" id="moon" name="sick" />
                                                                    <select id="moon_sick">
                                                                        <option value="sel">선택</option>
                                                                        <option value="1">1</option>
                                                                        <option value="2">2</option>
                                                                        <option value="3">3</option>
                                                                        <option value="4">4</option>
                                                                        <option value="5">5</option>
                                                                        <option value="6">6</option>
                                                                        <option value="7">7</option>
                                                                        <option value="8">8</option>
                                                                        <option value="9">9</option>
                                                                        <option value="10">10</option>
                                                                        <option value="11">11</option>
                                                                        <option value="12">12</option>
                                                                    </select>
                                                                        <label for="moon">월전</label></p>
                                                            </li>
                                                            
                                                            <li>    
                                                                <p><input type="radio" id="year" name="sick" />
                                                                    <select id="year_sick">
                                                                        <option value="sel">선택</option>
                                                                        <option value="1">1</option>
                                                                        <option value="2">2</option>
                                                                        <option value="3">3</option>
                                                                        <option value="4">4</option>
                                                                        <option value="5">5</option>
                                                                        <option value="6">6</option>
                                                                        <option value="7">7</option>
                                                                        <option value="8">8</option>
                                                                        <option value="9">9</option>
                                                                        <option value="10">10</option>
                                                                        <option value="11">11</option>
                                                                        <option value="12">12</option>
                                                                    </select>
                                                                        <label for="year">년전</label></p>
                                                            </li>
                                                        </ul>
                                                    </li>
                                                    
                                                    <li>
                                                            <h4>2 병명은 무엇인가요?</h4>
                                                            <input type="text" id="sick_name"/>
                                                    </li>
                                                    
                                                    <li>
                                                            <h4>3 이 통증 때문에 현재 병의원에서 치료중인가요?</h4>
                                                            <input type="radio" id="yes" name="ynn" value="yes" /><label for="yes">예</label>
                                                            <input type="radio" id="no" name="ynn" value="no" /><label for="no">아니오</label>
                                                    </li>
                                                </ol>
                                                                    
                                        <div class="controls">
                                        	<input type="submit" value="선택"/>
                                            <!-- <a href="/player/player.jsp?id=20130315120553" id="button_QuestionOK">선택</a>  -->
                                            <a href="/player/selector2.jsp?cate_movie1=${param.cate_movie1}&cate_movie2=${param.cate_movie2}&cate_movie3=${param.cate_movie3}&vas_high=${param.vas_high}&direction=${param.direction}&left_right=${param.left_right}" id="button_QuestionCancle">취소</a>
                                        </div>    
                            </div>
                        </div>
                    
                </form>
            </div>
          </div>
</a:html>
