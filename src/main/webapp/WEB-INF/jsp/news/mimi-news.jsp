<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HB하리은행 - 빵미일보</title>
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body>
	<header>
		<%-- 상단고정 --%>
		<jsp:include page="/jsp/include/topper.jsp"></jsp:include>
	</header>
	<section>


		<div class="container mt-5" align="center">
			<div>
				<h2>지금 이시각 금융뉴스</h2>
			</div>
			<div class="btn-group">


				<form action="write-news" method="post">
					<button type="submit" class="btn btn-primary">작성하기</button>
				</form>
			</div>
			<div class="row justify-content-center">
				<div class="col-md-11">
					<table class="table table-hover">
						<thead>
							<tr>
								<th class="col-md-1">번호</th>
								<th class="col-md-6">제목</th>
								<th class="col-md-1">글쓴이</th>
								<th class="col-md-1">작성일</th>
								<th class="col-md-1">조회</th>
								<th class="col-md-1"></th>
							</tr>
						</thead>
						<%-- 테이블 내용 --%>
						<tbody>
							<c:choose>
								<c:when test="${ empty news }">
									<td colspan="5" align="center" style="padding: 50px 0;">등록된
										포스트가 없습니다.</td>
								</c:when>

								<c:otherwise>
									<c:forEach var="post" items="${news}">
										<tr>
											<td>${post.postNo}</td>
											<td>
											<a href="news-details?postNo=${post.postNo}">${post.postTitle}</a></td>
											<td>${post.userId}</td>
											<td>${post.postRegDate}</td>
											<td>${post.postHit}</td>
											<td>
											<a href="delete-news?postNo=${post.postNo}" class="btn btn-secondary mb-2">삭제</a>
											</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		
		
		


	</section>

	<footer>
		<%-- 하단고정 --%>
		<jsp:include page="/jsp/include/footer.jsp"></jsp:include>
	</footer>
</body>
</html>