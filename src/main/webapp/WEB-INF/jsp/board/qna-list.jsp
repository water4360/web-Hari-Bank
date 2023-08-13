<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

</head>
<body>
	<header>
		<%-- 상단고정 --%>
		<jsp:include page="/jsp/main-jsp/topper.jsp"></jsp:include>
	</header>
	<section>
		<div class="container mt-5" align="center">
			<div>
				<h2>문의게시판(Q&A)</h2>
			</div>
			<c:if test="${not empty loginUser}">
				<a class="btn btn-primary mb-3"
					href="${pageContext.request.contextPath}/board/write">문의하기</a>
			</c:if>
			<div class="row justify-content-center">
				<div class="col-md-11">
					<table class="table table-hover">
						<thead>
							<tr>
								<th class="col-md-1 narrow-column">번호</th>
								<th class="col-md-5">제목</th>
								<th class="col-md-1 narrow-column">글쓴이</th>
								<th class="col-md-2 narrow-column">작성일</th>
								<th class="col-md-1 narrow-column">조회</th>
							</tr>
						</thead>
						<%-- 테이블 내용 --%>
						<tbody>
							<c:choose>
								<c:when test="${ empty qnas }">
									<td colspan="5" align="center" style="padding: 50px 0;">등록된
										Q&A가 없습니다.</td>
								</c:when>

								<c:otherwise>
									<c:forEach var="qna" items="${qnas}">
										<tr>
											<td class="qna-no narrow-column">${qna.no}</td>
											<td class="qna-title"><a
												href="${pageContext.request.contextPath}/board/${qna.no}">${qna.title} [${ qna.commentCnt }]</a></td>
											<td class="qna-writer narrow-column">${qna.writer}</td>
											<td class="qna-regdate narrow-column">${qna.regDate}</td>
											<td class="qna-viewcnt narrow-column">${qna.viewCnt}</td>
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
		<jsp:include page="/jsp/main-jsp/footer.jsp"></jsp:include>
	</footer>
</body>
</html>