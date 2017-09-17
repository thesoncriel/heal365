<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="a" tagdir="/WEB-INF/tags" %>
<a:html title=" - User Action Test : List" contents="${contentsCode }">
<div class="header">
    <h1>Contact Us</h1>
    <div id="breadcrumbs" data-sub="${contentsCode }"></div>
</div>
<div class="section">
                        <div class="article sub5_6">
                        <form action="write" method="post" enctype="multipart/form-data" class="validator">
                        	<%--<input type="hidden" name="email_to" value="theson@paran.com"/> --%>
                            <table class="board-edit">
	                            <thead>
	                                <tr>
	                                    <th><label>회사명</label></th>
	                                    <td><input type="text" name="company" required="required"/></td>  
	                                </tr>
	                                <tr>
	                                    <th><label>담당자명</label></th>
	                                    <td><input type="text" name="name" required="required"/></td>  
	                                </tr>
	                                <tr>
	                                    <th><label>연락처</label></th>
	                                    <td><a:phone name="phone" required="required"/></td>
	                                </tr>
	                                
	                                <tr>
	                                    <th><label>이메일 주소</label></th>
	                                    <td><a:email required="required" name="email"/></td>  
	                                </tr>
	                                
	                                <tr>
	                                    <th><label>사이트 주소</label></th>
	                                    <td><input type="text" name="site" data-minlen="3"/></td>
	                                </tr>
	                                
	                                <tr>
	                                    <th><label>문의 분류</label></th>
	                                    <td>
	                                        <select name="category">
	                                            <option value="치료 예약하기" selected="selected">치료 예약하기</option>
	                                            <option value="제품 주문하기">제품 주문하기</option>
	                                            <option value="1:1 상담하기">1:1 상담하기</option>
	                                        </select>
	                                    </td>
	                                </tr>
	                                
	                                <tr>
	                                    <th><label>문의 제목</label></th>
	                                    <td><input type="text" name="contentName" required="required"/></td>  
	                                </tr>
	                                
	                                <tr>
	                                    <th><label>문의 내용</label></th>
	                                    <td colspan="2"><textarea name="content"> </textarea></td>
	                                </tr>
	                                <tr>
	                                    <th><label>파일 첨부</label></th>
	                                    <td colspan="2"><input type="file" name="file_email"/></td>
	                                </tr>
	                            </thead>                   
                            </table>
                                
                                <div class="footer board">
                                	<div class="buttons">
                                		<input type="submit" class="artn-button board" value="작성 완료"/>
                            		</div>
                                </div>
						</form>
                        </div>
                        
                        
</div>
</a:html>