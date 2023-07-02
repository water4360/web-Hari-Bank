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
<style>
#map {
	width: 100px;
	height: 100px;
}

.bottomMenu-bar {
	color: #fff;
	padding: 10px;
}

.bottomMenu-item1, .bottomMenu-item2, .bottomMenu-item3 {
	color: #fff;
}
</style>
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
	<div class="bottomMenu center pl-4 pr-4" style="display: flex; flex-direction: row; justify-content: space-between; align-items: center;">
		<div class="bottomMenu-bar center">
			<div class="bottomMenu-item1">개인정보처리방침 · 경영공시 · 고객정보취급방침 ·
				보호금융상품등록부 · 전자민원접수 · 위치기반서비스 이용약관</div>
			<br>
			<div class="bottomMenu-item2">이메일 문의 : webcustomer@haribank.com</div>
			<div class="bottomMenu-item2">고객상담 1588-0758 | 해외
				82-2-1588-0758</div>

			<div class="bottomMenu-item3">평일 09:00~16:00 (법정공휴일 및 은행휴무일 제외)</div>
			<div class="bottomMenu-item4">HariBank All rights reserved.</div>
		</div>
		<div class="bottomMenu-map center">
			<div id="map" style="width: 400px; height: 150px;"></div>
		</div>
	</div>
</body>
</html>