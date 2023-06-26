<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>HR Bank - 계좌상세조회</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />

<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"></script>

<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<style>
.fixed-table {
	table-layout: fixed;
}

.fixed-table th, .fixed-table td {
	width: auto;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
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
			<div class="text-center mb-4">
				<h2>계좌상세조회</h2>
				<p>조회기준일시 : ${formattedNow}</p>
			</div>

			<div class="card mx-auto" style="width: 30rem;">
				<div class="card-body">
					<h5 class="card-title">계좌번호 : ${account.accountNo}</h5>
					<p class="card-text">상품명 : ${account.productName} (별칭:
						${account.nickName})</p>
					<p class="card-text">잔액 : ${account.totalBalance}</p>
					<p class="card-text">개설일자 : ${account.createdDate}</p>
					<div class="d-flex justify-content-between">
						<button class="btn btn-secondary">이체</button>
						<button class="btn btn-secondary">계좌개설확인서</button>
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