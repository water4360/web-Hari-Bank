<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<h2>조회메뉴</h2>
	<div id="content"></div>
	<a href="transaction.do" onclick="loadPage('transaction.do'); return false;">이체하기</a>
	<script>
// 		function loadPage(pageURL) {
// 			var xhttp = new XMLHttpRequest();
// 			xhttp.onreadystatechange = function() {
// 				if (this.readyState == 4 && this.status == 200) {
// 					document.getElementById("content").innerHTML = this.responseText;
// 				}
// 			};
// 			xhttp.open("GET", pageURL, true);
// 			xhttp.send();
// 		}
	</script>


</body>
</html>