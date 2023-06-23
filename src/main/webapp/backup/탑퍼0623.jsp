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

<link
	href="https://cdn.jsdelivr.net/gh/sunn-us/SUITE/fonts/static/woff2/SUITE.css"
	rel="stylesheet">

<style>
* {
	font-family: 'SUITE', sans-serif;
}

.navbar-brand {
	font-size: xx-large !important;
}



</style>

</head>
<body>

	<!-- Responsive navbar-->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <div class="row">
            <div class="col-lg-6">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/main.do">하리은행</a>
            </div>
            <div class="col-lg-6 text-lg-end">
                <div class="login-info">
                    <c:if test="${ not empty loginUser }">
                        <img alt="user" id="user" src="${pageContext.request.contextPath}/assets/user.png">
                        <b>${ loginUser.korName }님 환영합니다</b>
                        <a class="badge bg-secondary text-decoration-none link-light" href="#!">로그인연장</a>
                        <a class="badge bg-secondary text-decoration-none link-light" href="logout.do">로그아웃</a>
                    </c:if>
                </div>
            </div>
        </div>
        <div class="row mt-3">
            <div class="col-lg-12">
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                        <li class="nav-item"><a class="nav-link" href="inquiry.do">조회</a></li>
                        <li class="nav-item"><a class="nav-link" href="transaction.do">이체</a></li>
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