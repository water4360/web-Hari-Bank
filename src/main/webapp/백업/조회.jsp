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
</head>

<body>
	<header>
		<%-- 상단고정 --%>
		<jsp:include page="/jsp/main-jsp/topper.jsp"></jsp:include>
	</header>
	<section>

		<div class="container mt-5" align="center">
			<div>
				<h2>전체계좌조회</h2>
			</div>
			<div class="row justify-content-center">
				<div class="col-md-11">
					<table class="table table-hover">
						<thead>
							<tr>
								<th class="col-md-1"></th>
								<th class="col-md-6"></th>
								<th class="col-md-1"></th>
								<th class="col-md-1"></th>
								<th class="col-md-1"></th>
							</tr>
						</thead>
						<%-- 테이블 내용 --%>
						<tbody>
							<c:choose>
								<c:when test="${ empty accountList }">
									<td colspan="5" align="center" style="padding: 50px 0;">보유중인
										계좌가 없습니다.
										<form action="create-account.do" method="post">
										<div class="btn-group mt-3">
											<button type="submit" class="btn btn-secondary">비대면
												계좌개설하기</button>
										</div>
									</form>
										</td>
								</c:when>
								<c:otherwise>
									<c:forEach var="account" items="${accountList}">
										<tr>
											<td class="account-bank-name">${account.bankCode}일단은행코드</td>
											<td class="account-product-code">${account.productCode}예금상품명</td>
											<td class="account-total-balance">잔액 ${account.totalBalance}</td>
											<td><a href="상세조회.do" class="btn btn-secondary">조회</a></td>
											<td><a href="이체.do" class="btn btn-secondary">이체</a></td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
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