<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HB하리은행 - 문의게시판(Q&A)</title>

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
	min-height: 200px;
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
					<div class="btn-group" role="group">
						<%-- 작성자일때, 관리자일때, 방문자일때 --%>
						<c:choose>
							<c:when test="${post.writer == loginUser.id}">
								<a href="modifyPost.do?no=${post.no}"
									class="btn btn-secondary mb-2">수정</a>
								<a href="deletePost.do?no=${post.no}"
									class="btn btn-secondary mb-2">삭제</a>
							</c:when>
							<c:when test="${loginUser.role == 'A758'}">
								<a href="deletePost.do?no=${post.no}"
									class="btn btn-secondary mb-2">삭제</a>
							</c:when>
						</c:choose>
						<a href="${pageContext.request.contextPath }/qna.do"
							class="btn btn-secondary mb-2">목록으로</a>
					</div>
					<div class="card mb-3">
						<div class="card-header align-items-start justify-content-between">
							<div class="d-flex flex-column">
								<h4>${post.title}</h4>
							</div>
						</div>
						<div class="card-body">
							<!-- text-end 클래스를 사용하여 내용을 우측으로 정렬합니다. -->
							<span class="text-start mb-2"
								style="text-align: right; font-size: 15px; color: grey;">작성자:
								${post.writer} | 등록일: ${post.regDate} | 조회수: ${post.viewCnt}</span>
							<p class="card-text">${post.contents}</p>
						</div>
						<div class="card-footer text-muted" style="text-align: left;">
							<div class="reply-container">
								<div class="replyList">
									<b>댓글</b>
								</div>
								<form name="replyForm">
									<div class="card">
										<div class="ml-2 comment_inbox">
											<div>
												<b class="reply_inbox_writer">${loginUser.id}</b>
											</div>
											<div>
												<textarea name="content" placeholder="댓글을 남겨보세요" rows="1"
													class="comment_inbox_text"
													style="border:none; outline:none; overflow: hidden; overflow-wrap: break-word; width: 550px; height: 80px;"></textarea>
											</div>
										</div>
										<div class="register_box" style="text-align: right;">
											<a href="#" type="button" id="replyAddBtn">등록</a>
										</div>
									</div>
								</form>
							</div>
						</div>
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
