<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css" />
<link
	href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700"
	rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />
</head>
<body>
	<%-- 하단지도/고객센터 --%>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="card mb-4">
			<div class="card-header">지도</div>
			<div class="card-body">
				<div class="row">
					<div class="col-sm-6">
						<iframe style="border:0; width: 100%; height: 200px;" src="https://www.google.com/maps/place/%ED%95%9C%EA%B5%AD%ED%8F%B4%EB%A6%AC%ED%85%8D%EB%8C%80%ED%95%99+%EC%84%B1%EB%82%A8%EC%BA%A0%ED%8D%BC%EC%8A%A4/@37.4589226,127.1537563,20.75z/data=!4m6!3m5!1s0x357caf33963d4e07:0xf472ab67f14582d2!8m2!3d37.4590828!4d127.1537789!16s%2Fm%2F0cnv0m4?hl=ko-KR&entry=ttu" frameborder="0" allowfullscreen></iframe>
						<ul class="list-unstyled mb-0">
						</ul>
					</div>
					<div class="col-sm-6">
						<ul class="list-unstyled mb-0">
							<li>경기도 성남시 수정로398</a></li>
							<li>여기저기</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<div class="card mb-4">
			<div class="card-header">고객센터</div>
			<div class="card-body">
				<div class="row">
					<div class="col-sm-6">
						<ul class="list-unstyled mb-0">
							<li><a href="#!">여기는 전화번호 아이콘</a></li>
						</ul>
					</div>
					<div class="col-sm-6">
						<ul class="list-unstyled mb-0">
							<li><a href="#!">1566-0758</a></li>
							<li><a href="#!">평일 09~16시</a></li>
							<li><a href="#!">법정공휴일 휴무</a></li>
							<li><a href="#!">이메일 문의 : webcustomer@haribank.com</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</nav>
</body>
</html>