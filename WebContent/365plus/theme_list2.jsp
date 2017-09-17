<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - User Action Test : Menu" contents="${param.contents }">     
            
            <div class="sub_contents theme_action_search">
                <div class="section">
                    <table summary="Healing up 365의 제목, 등록자, 날짜  등 테마별 운동 검색 양식 입니다.">
                        <caption>테마별 운동</caption>
                        
                        <tbody>
                            <tr>
                                <th><label for="video_title">제목</label></th>
                                <td colspan="1"><input type="text" id="video_title" placeholder="제목을 입력하세요" autofocus /></td>                                
                                <th><label for="reg_name">등록자</label></th>
                                <td colspan="1">
                                    <input type="text" id="reg_name" placeholder="등록자를 입력하세요" />
                                </td>                                       
                            </tr>
                            <tr>
                                <th><label for="reg_date">날짜</label></th>
                                <td colspan="4">
                                    <input type="text" id="reg_date" placeholder="날짜를 입력하세요" />
                                </td>                                
                            </tr>
                        </tbody>                    
                    </table>
                </div>
                    <div>
                        <a href="#" class="link search_link">검색</a>
                    </div>
            </div>
            
            <div class="theme_action_wrapper">
                <div class="sub_contents theme_action_info">
                    <div class="section">
                        <table summary="Healing up 365의 구분, 테마별 운동, 등록일, 등록자 등 테마별 운동의 등록 정보">
                            <caption>Healing up 365 테마별 운동 등록 정보</caption>
                            
                            <thead>
                                <tr>                      
                                    <th>테마별 운동</th>
                                    <th>등록일</th>
                                    <th>등록자</th>
                                    <th>조회수</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>                          
                                    <td><a href="#">복부 다이어트 운동<img src="/img/tema_cart.png" width="25" alt="" /></a></td>
                                    <td>2013.1.15</td>
                                    <td>관리자</td>
                                    <td>20</td>         
                                </tr>
                                <tr>                                
                                    <td><a href="/player/heal_user_3_1_3_theme_action.jsp">임산부에 좋은 운동</a></td>
                                    <td>2013.1.15</td>
                                    <td>관리자</td>
                                    <td>10</td>         
                                </tr>
                                <tr>                                
                                    <td><a href="#">골프에 좋은 운동<img src="/img/tema_cart.png" width="25" alt="" /></a></td>
                                    <td>2013.1.15</td>
                                    <td>관리자</td>
                                    <td>40</td>         
                                </tr>
                                <tr>                                
                                    <td><a href="/player/heal_user_3_1_3_theme_action.jsp">테니스에 좋은 운동</a></td>
                                    <td>2013.1.15</td>
                                    <td>관리자</td>
                                    <td>42</td>         
                                </tr>
                                <tr>                                
                                    <td><a href="/player/heal_user_3_1_3_theme_action.jsp">오십견에 좋은 운동</a></td>
                                    <td>2013.1.15</td>
                                    <td>관리자</td>         
                                    <td>41</td>
                                </tr>
                                <tr>                                
                                    <td><a href="#">오십견에 좋은 운동<img src="/img/tema_cart.png" width="25" alt="" /></a></td>
                                    <td>2013.1.15</td>
                                    <td>관리자</td>
                                    <td>41</td>         
                                </tr>
                                <tr>                          
                                    <td><a href="/player/heal_user_3_1_3_theme_action.jsp">복부 다이어트 운동</a></td>
                                    <td>2013.1.15</td>
                                    <td>관리자</td>
                                    <td>41</td>         
                                </tr>
                                <tr>                                
                                    <td><a href="#">임산부에 좋은 운동<img src="/img/tema_cart.png" width="25" alt="" /></a></td>
                                    <td>2013.1.15</td>
                                    <td>관리자</td>
                                    <td>41</td>         
                                </tr>
                                <tr>                                
                                    <td><a href="/player/heal_user_3_1_3_theme_action.jsp">골프에 좋은 운동</a></td>
                                    <td>2013.1.15</td>
                                    <td>관리자</td>
                                    <td>41</td>         
                                </tr>
                                <tr>                                
                                    <td><a href="/player/heal_user_3_1_3_theme_action.jsp">테니스에 좋은 운동</a></td>
                                    <td>2013.1.15</td>
                                    <td>관리자</td>
                                    <td>41</td>         
                                </tr>
                                <tr>                                
                                    <td><a href="/player/heal_user_3_1_3_theme_action.jsp">오십견에 좋은 운동</a></td>
                                    <td>2013.1.15</td>
                                    <td>관리자</td>
                                    <td>41</td>         
                                </tr>
                                <tr>                                                     
                                    <td><a href="/player/heal_user_3_1_3_theme_action.jsp">오십견에 좋은 운동</a></td>
                                    <td>2013.1.15</td>
                                    <td>관리자</td>
                                    <td>41</td>         
                                </tr>
                            </tbody>        
                        </table>
                    </div>
                </div>
                
                <div class="sub_contents theme_action_list">
                    <div class="section">
                        <table summary="Healing up 365의 영상, 테마별 운동 목록, 조회수 등 테마별 운동 목록">
                            <caption>Healing up 365 테마별 운동 목록</caption>
                            
                            <thead>
                                <tr>
                                    <th>영상</th>
                                    <th>테마별 운동 목록</th>
                                    <th>조회수</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><a href="/player/player.jsp?id=20130315120553"><img src="/img/cont1.jpg" alt="" /></a></td>
                                    <td><h3>어깨 들어 올리기</h3><span>어깨 돌리기+어깨 비틀기+팔 들어 올리기</span></td>
                                    <td>34</td>
                                </tr>
                                <tr>
                                    <td><a href="/player/player.jsp?id=20130315120553"><img src="/img/cont2.jpg" alt="" /></a></td>
                                    <td><h3>어깨 들어 올리기</h3><span>어깨 돌리기+어깨 비틀기+팔 들어 올리기</span></td>
                                    <td>53</td>
                                </tr>
                                <tr>
                                    <td><a href="/player/player.jsp?id=20130315120553"><img src="/img/cont3.jpg" alt="" /></a></td>
                                    <td><h3>어깨 들어 올리기</h3><span>어깨 돌리기+어깨 비틀기+팔 들어 올리기</span></td>
                                    <td>15</td>
                                </tr>
                                <tr>
                                    <td><a href="/player/player.jsp?id=20130315120553"><img src="/img/cont1.jpg" alt="" /></a></td>
                                    <td><h3>어깨 들어 올리기</h3><span>어깨 돌리기+어깨 비틀기+팔 들어 올리기</span></td>
                                    <td>24</td>
                                </tr>
                                <tr>
                                    <td><a href="/player/player.jsp?id=20130315120553"><img src="/img/cont2.jpg" alt="" /></a></td>
                                    <td><h3>어깨 들어 올리기</h3><span>어깨 돌리기+어깨 비틀기+팔 들어 올리기</span></td>
                                    <td>42</td>
                                </tr>
                                <tr>
                                    <td><a href="/player/player.jsp?id=20130315120553"><img src="/img/cont3.jpg" alt="" /></a></td>
                                    <td><h3>어깨 들어 올리기</h3><span>어깨 돌리기+어깨 비틀기+팔 들어 올리기</span></td>
                                    <td>52</td>
                                </tr>
                                <tr>
                                    <td><a href="/player/player.jsp?id=20130315120553"><img src="/img/cont1.jpg" alt="" /></a></td>
                                    <td><h3>어깨 들어 올리기</h3><span>어깨 돌리기+어깨 비틀기+팔 들어 올리기</span></td>
                                    <td>34</td>
                                </tr>
                                <tr>
                                    <td><a href="/player/player.jsp?id=20130315120553"><img src="/img/cont2.jpg" alt="" /></a></td>
                                    <td><h3>어깨 들어 올리기</h3><span>어깨 돌리기+어깨 비틀기+팔 들어 올리기</span></td>
                                    <td>53</td>
                                </tr>
                                <tr>
                                    <td><a href="/player/player.jsp?id=20130315120553"><img src="/img/cont3.jpg" alt="" /></a></td>
                                    <td><h3>어깨 들어 올리기</h3><span>어깨 돌리기+어깨 비틀기+팔 들어 올리기</span></td> 
                                    <td>15</td>
                                </tr>
                                <tr>
                                    <td><a href="/player/player.jsp?id=20130315120553"><img src="/img/cont1.jpg" alt="" /></a></td>
                                    <td><h3>어깨 들어 올리기</h3><span>어깨 돌리기+어깨 비틀기+팔 들어 올리기</span></td>
                                    <td>24</td>
                                </tr>
                                <tr>
                                    <td><a href="/player/player.jsp?id=20130315120553"><img src="/img/cont2.jpg" alt="" /></a></td>
                                    <td><h3>어깨 들어 올리기</h3><span>어깨 돌리기+어깨 비틀기+팔 들어 올리기</span></td>
                                    <td>42</td>
                                </tr>
                                <tr>
                                    <td><a href="/player/player.jsp?id=20130315120553"><img src="/img/cont3.jpg" alt="" /></a></td>
                                    <td><h3>어깨 들어 올리기</h3><span>어깨 돌리기+어깨 비틀기+팔 들어 올리기</span></td>
                                    <td>52</td>
                                </tr>
                            </tbody>                    
                        </table>
                    </div>
                </div>
            </div>
</a:html>  
