<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - User Action Test : Menu">lude/header.jsp" flush="true" />      
            
            <div class="sub_contents pre_view">
                <div class="section">
                    <table summary="Healing up 365의 환자명, 의사명, 의료 기관명, 진단일, 만료일, 진단 형태, 위치, 방향, 중증도, 사후 조치, 수행 요일, 운동 횟수, 진단 지속, 코멘트, 영상 보기">
                        <caption>Healing up 365 나의 처방 운동 진단서</caption>
                        
                        <tbody>
                            <tr>
                                <th>환자명</th>
                                <td colspan="6"><span id="inv_name">정훈이</span></td>                                
                            </tr>
                            <tr>
                                <th>의사명</th>
                                <td colspan="1"><span id="doc_name">백광현</span></td>         
                                <th>의료 기관명</th>
                                <td colspan="3"><span id="medical_name">혜민서</span></td>                                
                            </tr>
                            <tr>
                                <th>진단일</th>
                                <td colspan="1"><span id="dia_date">2013.01.25</span></td>         
                                <th>만료일</th>
                                <td colspan="3"><span id="end_date">2013.01.30</span></td>                               
                            </tr>
                            <tr>
                                <th>진단 형태</th>
                                <td colspan="1"><span id="dia_shape">처방전</span></td>
                                <th>중증도</th>
                                <td colspan="3"><span id="pain">7.0</span></td>                                       
                            </tr>
                            <tr>
                                <th>위치</th>
                                <td colspan="1"><span id="loc">위쪽</span></td>
                                <th>방향</th>
                                <td colspan="3"><span id="direction">위쪽</span></td>  
                            </tr>
                            <tr>
                                <th>사후 조치</th>
                                <td colspan="1"><span id="after">일어났다 앉았다 5회 반복 실시</span></td>                                
                                <th>수행 요일</th>
                                <td colspan="3"><span id="action_date">토</span></td>   
                            </tr>
                            <tr>
                                <th>운동 횟수</th>
                                <td colspan="1"><span id="exe_count">3회</span></td>                                
                                <th>진단 지속 여부</th>
                                <td colspan="3"><span id="dia_last">예</span></td>      
                            </tr>
                            <tr>
                                <th>의사 처방</th>
                                <td colspan="6"><span id="comment">정훈이 환자님 적극적인 재활 운동 매우 대단히 필요합니다. 필히 물리치료 및 재활운동에 참여하시고 가정에서도 반드시 실행하실 것을 권합니다.</span></textarea></td>                                
                            </tr>
                            <tr>
                                <th>영상보기</th>
                                <td colspan="6"><a href="/player/player.jsp?id=20130315120553"><span class="screen"><em>영상</em>영상에 대한<br/> 정보</span></a></td>                                
                            </tr>
                        </tbody>                    
                    </table>
                </div>
                    
                    <div>
                    	<a href="/player/prescrit_list1.jsp" class="link list_link">목록</a>
                	</div>
            </div>
</a:html>
