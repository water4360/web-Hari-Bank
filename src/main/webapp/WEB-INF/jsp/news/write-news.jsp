<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HB하리은행 - 금융뉴스 수정</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"
	crossorigin="anonymous"></script>

<style>
/* table { */
/*     table-layout: auto; */
/*     width: 80%; */
/* } */
</style>

</head>
<body>
	<header>
		<%-- 상단고정 --%>
		<jsp:include page="/jsp/include/topper.jsp"></jsp:include>
	</header>
	<section>
		<div class="container mt-5">
			<div class="row justify-content-center">
				<div class="col-md-6">
					<h3 class="mb-3">기사 등록</h3>
					<form action="add-news" method="post">
						<div class="mb-3">
							<label for="writer" class="form-label">작성자</label>
							<input type="text" class="form-control" id="writer" name="p_writer">
						</div>
						<div class="mb-3">
							<label for="title" class="form-label">제목</label>
							<input type="text" class="form-control" id="title" name="p_title" value="${news.p_title}">
						</div>
						<div class="mb-3">
							<label for="content" class="form-label">내용</label>
							<textarea class="form-control" id="content" name="p_contents" rows="5">${news.p_contents}</textarea>
						</div>
						<button type="submit" class="btn btn-primary">등록 완료</button>
						<a href="${pageContext.request.contextPath }/news"
							class="btn btn-secondary mb-2">목록으로</a>
					</form>
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
