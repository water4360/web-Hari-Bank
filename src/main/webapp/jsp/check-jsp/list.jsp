<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.dao.BoardDAO"%>
<%@ page import="board.vo.BoardVO"  %>
<%@ page import="java.util.List"  %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<%
	BoardDAO bDao = new BoardDAO();
	// 해당 페이지의 게시글 목록
	List<BoardVO> list = bDao.selectBoard();
	pageContext.setAttribute("list", list);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>                                                    	
<head>
	<title>페이징 처리</title>
	<link rel="stylesheet" href="../css/table.css" />
</head>                          
<body>
	<div align="center">
		<br />
		<hr width="70%" />                                      	
		<h2>게시판 목록</h2>	                                        
		<hr width="70%" />                                      	
		<table width="70%">                                                	
		<tr>                                                    	
			<th width="12%">번호</th>
			<th>제목</th>
			<th width="12%">글쓴이</th>
			<th width="12%">등록일</th>    
		</tr>                                                       
		<c:forEach var="item" items="${list}">
			<tr>                                            
				<td><c:out value="${item.no}" /></td>
			    <td style="text-align:left;padding-left:10px;">
			    	<c:out value="${item.title}" />
			    </td>
			    <td><c:out value="${item.writer }" /></td>
			    <td><c:out value="${item.regDate}" /></td>
			</tr>
		</c:forEach>
		</table>   
	</div>
</body>
</html>









 