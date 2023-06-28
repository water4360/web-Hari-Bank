<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>HR Bank - 당행/타행계좌이체</title>
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
		<div class="container mt-5">
			<div class="card mx-auto text-center" style="width: 30rem;">
				<div class="card-header" align="center">
					<h4 class="card-title">즉시이체결과</h4>
				</div>
				<div class="card-body">
					<div class="mb-3">${result}</div>
					<form action="inquiryDetail.do" method="post">
						<input type="hidden" name="accountNo" value="${account.accountNo}">
						<button type="submit" class="btn btn-secondary">거래내역보기</button>
					</form>
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