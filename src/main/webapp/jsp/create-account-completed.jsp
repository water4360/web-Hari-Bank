<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>HB하리은행 - 계좌개설 완료</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<style>
.center-align {
	display: flex;
	flex-direction: column;
	align-items: center;
	text-align: center;
}
</style>

</head>
<header>
	<%-- 상단고정 --%>
	<jsp:include page="/jsp/main-jsp/topper.jsp"></jsp:include>
</header>
<body>
	<section>
		<div class="container mt-5 mb-5">
			<h3 align="center">HB하리사랑통장 개설완료</h3>
			<div class="card mt-3">
				<div class="card-body center-align">
					<h5 class="card-title">계좌번호</h5>
					<p class="card-text">[${account.accountNo}]</p>
				</div>
				<div class="col-12 mb-4 center-align">
					<div>
						<a href="inquiry.do" class="btn btn-lg">
							계좌조회</a>
						<a href="main.do" class="btn btn-secondary btn-lg">메인으로</a>
					</div>
				</div>
			</div>
		</div>
		<footer>
			<%-- 하단고정 --%>
			<jsp:include page="/jsp/main-jsp/footer.jsp"></jsp:include>
		</footer>
	</section>
</body>
</html>
