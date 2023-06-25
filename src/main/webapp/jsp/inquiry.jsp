<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>HR Bank - 계좌조회</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />

<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"></script>

<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
</head>

<body>
	<header>
		<%-- 상단고정 --%>
		<jsp:include page="/jsp/main-jsp/topper.jsp"></jsp:include>
	</header>
	<section>
		
		<div class="container mt-5" align="center">
			<div>
				<h2>전체계좌조회</h2>
			</div>
			<div class="btn-group">
				<button type="button" class="btn btn-secondary" data-toggle="modal"
					data-target="#문의하기" aria-expanded="false">1:1 문의하기</button>
			</div>
			<table class="table">
				<thead>
					<tr>
						<th scope="col">카테고리</th>
						<th scope="col">번호</th>
						<th scope="col">제목</th>
						<th scope="col">등록일</th>
					</tr>
				</thead>
				<%-- 테이블 내용 --%>
				<tbody>
					<c:choose>
						<c:when test="${ empty accountList }">
							<td colspan="5" align="center" style="padding: 50px 0;">
								계좌가 존재하지 않습니다</td>
						</c:when>
						<c:otherwise>
							<c:forEach var="qna" items="${qnaList}">
								<tr>
									<td class="category">${qna.category}</td>
									<td class="no">${qna.no}</td>
									<td class="title">${qna.title}</td>
									<td class="regDate">${qna.regDate}</td>
									<td></td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
		
		
		
		
		
		
		
		
	</section>
	<footer>
		<%-- 하단고정 --%>
		<jsp:include page="/jsp/main-jsp/footer.jsp"></jsp:include>
	</footer>


</body>
</html>