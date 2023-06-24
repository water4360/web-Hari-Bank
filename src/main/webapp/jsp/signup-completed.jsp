<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>HR Bank - 회원가입 완료</title>

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
			<h3 align="center">회원가입 완료</h3>
			<div class="card mt-3">
				<div class="card-body center-align">
					<h5 class="card-title">${newUser.korName}님, 하리은행 가입을 환영합니다.</h5>
					<p class="card-text">가입일: ${newUser.regDatetime}</p>
				</div>
				<div class="col-12 mb-4 center-align">
					<div>
						<a href="create-account.do" class="btn btn-success btn-lg">
							이어서 계좌개설하기</a>
						<a href="login.do" class="btn btn-secondary btn-lg">로그인하기</a>
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
