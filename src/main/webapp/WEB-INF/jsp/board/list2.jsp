<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <!-- Bootstrap CSS link -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
  <div class="container">
    <h2>전체 게시글 조회</h2>
    <a class="btn btn-primary mb-3" href="${pageContext.request.contextPath}/board/write">새글등록</a>
    <table class="table table-striped">
      <thead>
        <tr>
          <th>글번호</th>
          <th>제목</th>
          <th>글쓴이</th>
          <th>등록일</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach items="${boardList}" var="board">
          <tr>
            <td>${board.no}</td>
            <td><a href="${pageContext.request.contextPath}/board/${board.no}">${board.title}
            <c:if test="${board.replyCnt ne 0}">
            	[${board.replyCnt}]
            </c:if></a> </td>
            <td>${board.writer}</td>
            <td>${board.regDate}</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>

  <!-- Bootstrap JS and jQuery (required for some Bootstrap features) -->
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>