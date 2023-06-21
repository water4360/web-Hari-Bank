<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	
<html>
<head>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />

<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>

<!-- Core theme CSS (includes Bootstrap)-->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<!-- 내 스타일시트 -->
<link href="/css/styles.css" rel="stylesheet" />
</head>
<body>

	<!-- Responsive navbar-->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container">
			<a class="navbar-brand"
				href="${pageContext.request.contextPath}/main.do">하리은행</a>
			<div class="login-info">
			<c:if test="${ not empty loginUser }">
			<img alt="user" id="user" src="${pageContext.request.contextPath}/assets/user.png"> <b>${ loginUser.id }(${ loginUser.korName })</b>
			<a class="badge bg-secondary text-decoration-none link-light"
				href="#!">로그인연장</a> <a
				class="badge bg-secondary text-decoration-none link-light" href="logout.do">로그아웃</a>
			</c:if>
			</div>
		</div>
	</nav>
	<%-- 네비게이션 메뉴바 --%>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container" align="center">
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent" align="center">
				<ul class="navbar-nav ms-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link" href="inquiry.do">조회</a></li>
					<li class="nav-item"><a class="nav-link" href="transaction.do">이체</a></li>
					<li class="nav-item"><a class="nav-link" href="products.do">금융상품</a></li>
					<li class="nav-item"><a class="nav-link" href="customer.do">고객센터</a></li>
					<li class="nav-item"><a class="nav-link" href="mypage.do">마이페이지</a></li>
					<!--<li class="nav-item"><a class="nav-link active" aria-current="page" href="#">Blog</a></li> -->
				</ul>
			</div>
		</div>
	</nav>

</body>
</html>