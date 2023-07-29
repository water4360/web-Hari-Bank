<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>HB하리은행 - 당행/타행계좌이체</title>
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
		<jsp:include page="/jsp/include/topper.jsp"></jsp:include>
	</header>


	<section>
		<div class="container mt-5">
			<div class="card mx-auto text-center" style="width: 60rem;">
				<div class="card-header" align="center">
					<h4 class="card-title">${result}</h4>
				</div>
				<div class="card-body">
					<table class="table col-6 mt-5 mb-5">
					<thead class="text-center">
						<tr>
							<th scope="col">No</th>
							<th scope="col">출금계좌</th>
							<th scope="col">입금은행</th>
							<th scope="col">입금계좌</th>
							<th scope="col">이체금액(원)</th>
							<th scope="col">내통장표기(실제 예금주명)</th>
						</tr>
					</thead>
					<%-- 테이블 내용 --%>
					<tbody class="text-center">
						<tr>
							<td>1</td>
							<td>${transaction.senderAccountNo}</td>
							<td>${transaction.receiverBank}</td>
							<td>${transaction.receiverAccountNo}</td>
							<td>${formattedAmount}</td>
							<td>
							<c:choose>
							<c:when test="${empty transaction.fromMemo }">
							${receiver}(${receiver})
							</c:when>
							<c:otherwise>
							${transaction.fromMemo}(${receiver})
							</c:otherwise>
							</c:choose>
							</td>
						</tr>

					</tbody>
				</table>
					
					
					<form action="inquiryDetail.do" method="post" style="display:inline-block;">
						<input type="hidden" name="accountNo" value="${account.accountNo}">
						<button type="submit" class="btn btn-secondary">거래내역보기</button>
					</form>
					<form action="transaction.do" method="post" style="display:inline-block;">
						<input type="hidden" name="accountNo" value="${account.accountNo}">
						<button type="submit" class="btn btn-secondary">추가이체</button>
					</form>
				</div>
			</div>
		</div>


	</section>

	<footer>
		<%-- 하단고정 --%>
		<jsp:include page="/jsp/include/footer.jsp"></jsp:include>
	</footer>


</body>
</html>