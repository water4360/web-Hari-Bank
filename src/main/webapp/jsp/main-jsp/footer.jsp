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

<%-- 지도용 --%>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=01de9cbef4bce203f1cd367ba95b3559"></script>

<script>
	window.onload = function() {
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			// 지도의 중심좌표
			center : new kakao.maps.LatLng(37.45897008681379,
					127.15408793252612),
			// 지도의 확대 레벨
			level : 3
		};

		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		var map = new kakao.maps.Map(mapContainer, mapOption);

		//마커가 표시될 위치입니다 
		var markerPosition = new kakao.maps.LatLng(37.45897008681379,
				127.15408793252612);
		//마커를 생성합니다
		var marker = new kakao.maps.Marker({
			position : markerPosition
		});
		marker.setMap(map);
	};
</script>



</head>
<body>
	<%-- 하단지도/고객센터 --%>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<!-- 		<div id="map" style="width: 300px; height: 300px;"></div> -->
		<div class="card mb-4">
			<div class="card-header">경기도 성남시 수정로398 드림관 2층</div>
			<div class="card-body">
				<div id="map" style="width: 300px; height: 300px;"></div>
				<ul class="list-unstyled mb-0">
				</ul>
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