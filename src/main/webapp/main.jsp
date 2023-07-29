<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HB하리은행 - 인터넷뱅킹</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />

<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"></script>

</head>
<body>
	<header>
		<%-- 상단고정 --%>
		<jsp:include page="/jsp/include/topper.jsp"></jsp:include>
	</header>
	<section>
		<div class="container" id="dynamic-main-content">
			<!-- Page content-->
			<div class="main-container mt-5">
				<div class="row"
					style="display: flex; flex-direction: row; justify-content: center; align-items: center; align-items: flex-start;">
					<div class="col-lg-8">
						<!-- Post content-->
						<!-- <img class="img-fluid rounded" src="./assets/main-banner.png" -->
						<img class="main-banner" src="./assets/main-banner.gif"
							style="width: 110%;">
					</div>
					<!-- Side widgets-->
					<c:choose>
						<c:when test="${ empty loginUser }">
							<div class="col-lg-3">
								<%-- 로그인/가입메뉴 --%>
								<div class="card-body"
									style="display: flex; flex-direction: column; align-items: center;">
									<a class="btn btn-gradient" id="button-login" type="button"
										href='${ pageContext.request.contextPath }/login'> 로그인 <br>
										<i class="fa-solid fa-right-to-bracket fa-2xl"></i>
									</a> <a class="btn btn-gradient" id="button-create-account"
										type="button"
										href="${ pageContext.request.contextPath }/create-account">
										계좌개설 <br> <i class="fa-solid fa-money-check fa-2xl"></i>
									</a>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="col-lg-3"
								style="display: flex; flex-direction: column; align-items: center;">
								<%-- 개설/조회/이체메뉴 --%>
								<a class="btn btn-gradient" id="button-transfer" type="button"
									href='${ pageContext.request.contextPath }/transaction'>즉시이체
									<br> <i class="fa-solid fa-money-bill-transfer fa-2xl"></i>
								</a> <a class="btn btn-gradient" id="button-inquiry" type="button"
									href='${ pageContext.request.contextPath }/inquiry'> 빠른조회 <br>
									<i class="fa-brands fa-searchengin fa-2xl"></i>
								</a> <a class="btn btn-gradient" id="button-create-account"
									type="button"
									href='${ pageContext.request.contextPath }/create-account'>
									계좌추가개설 <br> <i class="fa-solid fa-money-check fa-2xl"></i>
								</a>

							</div>

						</c:otherwise>
					</c:choose>
					<!-- Categories widget-->
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