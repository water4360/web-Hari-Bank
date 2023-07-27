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
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v6.3.0/css/all.css">
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
	padding-right: 0;
	font-size: large !important;
}
</style>

</head>
<body>
	<%-- 네비게이션 메뉴바 --%>
	<nav class="navbar navbar-expand-md navbar-dark bg-dark pt-5"
		style="flex-direction: column;">
		<div class="container">
			<a class="navbar-brand" href="${pageContext.request.contextPath}/">
			<img alt="main-bank-logo" src="./assets/bank-logo.png" width="80%"></a>
			<div class="info-and-topmenu"
				style="display: flex; flex-direction: column; align-items: flex-end;">
				<div class="login-info"
					style="padding-right: 8px; font-size: large;">
					<c:if test="${ not empty loginUser }">
						<img alt="user" id="user" src="./assets/gr-user2.png"
							style="width: 30px;">
						<b>${ loginUser.korName }님 환영합니다</b>
						<a class="badge bg-secondary text-decoration-none link-light"
							href="#!">로그인연장</a>
						<a class="badge bg-secondary text-decoration-none link-light"
							href="#" data-bs-toggle="modal" data-bs-target="#logoutModal">로그아웃</a>
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
							<li class="nav-item"><a class="nav-link" href="${ pageContext.request.contextPath }/inquiry">조회</a></li>
							<li class="nav-item"><a class="nav-link" href="${ pageContext.request.contextPath }/inquiryOpenbank">오픈뱅킹</a></li>
							<li class="nav-item"><a class="nav-link" href="${ pageContext.request.contextPath }/transaction">이체</a></li>
							<li class="nav-item"><a class="nav-link" href="${ pageContext.request.contextPath }/products">금융상품</a></li>
							<li class="nav-item"><a class="nav-link" href="${ pageContext.request.contextPath }/qna">문의게시판</a></li>
							<li class="nav-item"><a class="nav-link" href="${ pageContext.request.contextPath }/mypage">마이페이지</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</nav>



	<!-- 로그아웃 모달 -->
	<div class="modal fade" id="logoutModal" tabindex="-1"
		aria-labelledby="logoutModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="logoutModalLabel">로그아웃 확인</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">하리은행 인터넷뱅킹을 로그아웃하고 안전하게 떠날까요?</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<a href="logout" type="button" class="btn btn-basic">로그아웃</a>
				</div>
			</div>
		</div>
	</div>














</body>
</html>