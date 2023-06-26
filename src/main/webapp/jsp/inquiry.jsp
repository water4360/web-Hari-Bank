<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>HR Bank - 계좌조회</title>
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
				<h2>전체계좌조회</h2>
				<p>조회기준일시 : ${formattedNow}</p>
			</div>
			<div class="row justify-content-center">
				<div class="col-md-10">
					<!-- 					<table class="table table-striped"> -->
					<table class="table table-striped fixed-table">
						<thead class="thead-dark">
							<tr class="text-white bg-secondary">
								<th>입출금(총 ${accountCount} 계좌)</th>
								<th colspan="2">잔액 ${formattedTotalBalance}</th>
								<th colspan="3"></th>
							</tr>
							<tr>
								<th>은행코드</th>
								<th>예금상품명</th>
								<th>계좌번호</th>
								<th colspan="2">잔액</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${ empty accountList }">
									<tr>
										<td colspan="5" class="text-center">보유중인 계좌가 없습니다.</td>
									</tr>
									<tr>
										<td colspan="5" class="text-center">
											<form action="create-account.do" method="post">
												<button type="submit" class="btn btn-secondary mt-3">비대면
													계좌개설하기</button>
											</form>
										</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="account" items="${accountList}">
										<tr>
											<td>${account.bankCode}</td>
											<td>${account.productCode}</td>
											<td id="account-no">${account.accountNo}</td>
											<td colspan="2">${account.totalBalance}</td>
											<td>
												<form action="inquiryDetail.do" method="post" style="display: inline-block;">
													<input type="hidden" name="accountNo" value="${account.accountNo}">
													<input type="submit" class="btn btn-secondary" value="조회">
												</form>
												<form action="transaction.do" method="post" style="display: inline-block;">
													<input type="hidden" name="accountNo" value="${account.accountNo}">
													<input type="submit" class="btn btn-secondary" value="이체">
												</form>
											</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
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