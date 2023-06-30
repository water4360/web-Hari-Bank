<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HR Bank - 문의게시판(Q&A)</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"></script>

<style>
table {
	table-layout: auto;
	width: 60%;
}

.card-body {
	min-height : 200px;
}
</style>

</head>
<body>
	<header>
		<%-- 상단고정 --%>
		<jsp:include page="/jsp/main-jsp/topper.jsp"></jsp:include>
	</header>
	<section>
		<div class="container mt-5">
			<div class="row justify-content-center">
				<div class="col-md-6">
					<div class="card mb-3">
						<div
							class="card-header d-flex align-items-center justify-content-between">
							<h4>${post.title}</h4>
						</div>
						<div class="card-body">
							<p class="card-text">${post.contents}</p>
						</div>
						<div class="card-footer text-muted text-end">작성자 :
							${post.writer} | 등록일 : ${post.regDate}</div>
					</div>
					<div class="btn-group" role="group">
						<%-- 작성자일때, 관리자일때, 방문자일때 --%>
					<c:choose>
						<c:when test="${post.writer == loginUser.id}">
							<a href="modifyPost.do?no=${post.no}" class="btn btn-secondary mb-2">수정</a>
							<a href="deletePost.do?no=${post.no}" class="btn btn-secondary mb-2">삭제</a>
						</c:when>
						<c:when test="${loginUser.role == 'A758'}">
							<a href="deletePost.do?no=${post.no}" class="btn btn-secondary mb-2">삭제</a>
						</c:when>
					</c:choose>
							<a href="${pageContext.request.contextPath }/qna.do"
								class="btn btn-secondary mb-2">목록으로</a>
					</div>
				</div>
			</div>
		</div>
	</section>
	<footer>
		<%-- 하단고정 --%>
		<jsp:include page="/jsp/main-jsp/footer.jsp"></jsp:include>
	</footer>
</body>
</html>
