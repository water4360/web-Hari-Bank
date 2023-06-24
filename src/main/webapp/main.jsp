<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HR Bank - 하리인터넷뱅킹</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />

<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>

<!-- Core theme CSS (includes Bootstrap)-->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<!-- 내 스타일시트 -->
<link href="css/styles.css" rel="stylesheet" />

</head>
<body>
	<header>
		<%-- 상단고정 --%>
		<jsp:include page="/jsp/main-jsp/topper.jsp"></jsp:include>
	</header>
	<section>
		<div class="container" id="dynamic-main-content">
			<!-- Page content-->
			<div class="container mt-5">
				<div class="row">
					<div class="col-lg-8">
						<!-- Post content-->
						<article>
							<!-- Preview image figure-->
							<figure class="mb-4">
								<img class="img-fluid rounded"
									src="https://dummyimage.com/900x400/ced4da/6c757d.jpg"
									alt="..." />
							</figure>
						</article>
						<div id="dynamic-content">
							<%-- Ajax로 로드될 내용이 들어갈 공간 --%>
						</div>
						<%-- 원래라면 메인헤더 --%>
						<!-- Post header-->
						<header class="mb-4">
							<!-- Post title-->
							<h1 class="fw-bolder mb-1">HR하리은행 오픈뱅킹</h1>
							<!-- Post meta content-->
							<div class="text-muted fst-italic mb-2">
								다른은행 조회/이체가 한번에<br>이체수수료 무료 혜택까지~
							</div>
						</header>

					</div>
					<!-- Side widgets-->
					<c:choose>
						<c:when test="${ empty loginUser }">
							<div class="col-lg-4">
								<%-- 로그인/가입메뉴 --%>
								<div class="card-body">
									<a class="btn btn-success" id="button-login" type="button"
										href='login.do'> 로그인 <br> <i
										class="fa-solid fa-right-to-bracket fa-2xl"></i>
									</a> <a class="btn btn-success" id="button-create-account"
										type="button" href="create-account.do"> 계좌개설 <br> <i
										class="fa-solid fa-money-check fa-2xl"></i>
									</a>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="col-lg-4">
								<%-- 개설/조회/이체메뉴 --%>
								<div class="card-body">
									<a class="btn btn-success" id="button-create-account"
										type="button" href='create-account.do'> 계좌개설 <br> <i
										class="fa-solid fa-money-check fa-2xl"></i>
									</a> <a class="btn btn-success" id="button-inquiry" type="button"
										href='inquiry.do'> 빠른조회 <br>
									</a> <a class="btn btn-success" id="button-transfer" type="button"
										href='transaction.do'> 이체 <br>
									</a>
								</div>
							</div>

						</c:otherwise>
					</c:choose>
					<!-- Categories widget-->
					<div class="card col-lg-4 mb-5">
						<div class="card-header">공지사항</div>
						<div class="card-body">
							<div class="row">
								<div class="col-sm-6">
									<ul class="list-unstyled mb-0">
										<li><a href="#!">Web Design</a></li>
										<li><a href="#!">HTML</a></li>
										<li><a href="#!">Freebies</a></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<div class="card col-lg-4 mb-5">
						<div class="card-header">자주묻는질문(F&Q)</div>
						<div class="card-body">You can put anything you want inside
							of these side widgets. They are easy to use, and feature the
							Bootstrap 5 card component!</div>
					</div>
					<div class="card col-4 mb-5">
						<div class="card-header">
							<a href="qna.do">회원전용문의(Q&A) 최근3건</a>
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
											<li class="qna-title"><a
												href="qna-details.do?no=${qna.no}">${qna.title}</a>
												</li>
										</ul>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</div>
					</div>

				</div>
			</div>
		</div>
	</section>

	<script>
		function loadPage(pageName) {
			if (pageName === 'inquiry') {
				$.ajax({
					url : "${pageContext.request.contextPath}/inquiry.do",
					type : "GET",
					success : function(response) {
						$("#dynamic-main-content").html(response);
					}
				});
			} else if (pageName === 'transaction') {
				$.ajax({
					url : "${pageContext.request.contextPath}/transaction.do",
					type : "GET",
					success : function(response) {
						$("#dynamic-main-content").html(response);
					}
				});
			}
		}
	</script>



	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>




	<footer>
		<%-- 하단고정 --%>
		<jsp:include page="/jsp/main-jsp/footer.jsp"></jsp:include>
	</footer>
</body>
</html>