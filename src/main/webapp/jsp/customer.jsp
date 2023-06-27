<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>HR Bank - 하리인터넷뱅킹</title>
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
		<h2>고객센터</h2>

		<div class="card col-4 mb-5">
			<div class="card-header">
				<a href="qna.do">회원전용문의(Q&A)</a>
			</div>
			<div class="card-body">

				<c:choose>
					<c:when test="${ empty qnas }">
						<td colspan="5" align="center" class="mt-3 mb-3">등록된 QnA가
							없습니다.</td>
					</c:when>
					<c:otherwise>
						<c:forEach var="qna" items="${qnas}" begin="0" end="2">
							<ul class="list-unstyled mb-0">
								<li class="qna-title"><a href="qna-details.do?no=${qna.no}">${qna.title}</a>
								</li>
							</ul>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</section>
	<footer>
		<%-- 하단고정 --%>
		<jsp:include page="/jsp/main-jsp/footer.jsp"></jsp:include>
	</footer>


</body>
</html>