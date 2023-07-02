<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />

<!-- 여기는 topper 스타일시트 -->
<link href="/css/styles.css" rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css"
	crossorigin="anonymous">
	
<!-- 여기는 topper Jquery-3.6.0 -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"
	crossorigin="anonymous"></script>

<%-- 클립보드 아이콘용 스타일시트 및 icon 링크--%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v6.3.0/css/all.css">
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"></script>



<%-- 서체용 --%>
<link
	href="https://cdn.jsdelivr.net/gh/sunn-us/SUITE/fonts/static/woff2/SUITE.css"
	rel="stylesheet">

<style>
* {
	font-family: 'SUITE', sans-serif !important;
}
.nav-item {
	padding-right:0;
	font-size: large !important;
}


</style>

</head>
<body>
	<%-- 네비게이션 메뉴바 --%>
	<nav class="navbar navbar-expand-md navbar-dark bg-dark pt-5"
		style="flex-direction: column;">
	<div class="container">
			<a class="navbar-brand"
				href="${pageContext.request.contextPath}/main.do"> <img
				alt="main-bank-logo" src="./assets/bank-logo.png" width="80%"></a>
			<div class="info-and-topmenu" style="display:flex; flex-direction:column; align-items:flex-end;">
				<div class="login-info" style="padding-right:8px; font-size:large;">
					<c:if test="${ not empty loginUser }">
						<img alt="user" id="user" src="./assets/gr-user2.png" style="width:30px;">
						<b>${ loginUser.korName }님 환영합니다</b>
						<a class="badge bg-secondary text-decoration-none link-light"
							href="#!">로그인연장</a>
						<a class="badge bg-secondary text-decoration-none link-light"
							href="logout.do">로그아웃</a>
					</c:if>
				</div>
				<div class="topmenu-container" align="center">
					<button class="navbar-toggler" type="button"
						data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
						aria-controls="navbarSupportedContent" aria-expanded="false"
						aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
					</button>
					<div class="collapse navbar-collapse" id="navbarSupportedContent"
						align="center">
						<ul class="navbar-nav ms-auto mb-2 mb-lg-0">
							<li class="nav-item"><a class="nav-link" href="inquiry.do">조회</a></li>
							<li class="nav-item"><a class="nav-link"
								href="inquiry-op.do">오픈뱅킹</a></li>
							<li class="nav-item"><a class="nav-link"
								href="transaction.do">이체</a></li>
							<li class="nav-item"><a class="nav-link" href="products.do">금융상품</a></li>
							<li class="nav-item"><a class="nav-link" href="customer.do">고객센터</a></li>
							<li class="nav-item"><a class="nav-link" href="mypage.do">마이페이지</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</nav>

</body>
</html>