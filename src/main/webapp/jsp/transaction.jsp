<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>HR Bank - 계좌이체</title>
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
		<div class="container mt-5">
			<div class="text-center mb-4">
				<h2>계좌이체</h2>
			</div>

			<div class="card mx-auto" style="width: 30rem;">
				<div class="card-header" align="center">
					<h5 class="card-title">출금 정보</h5>
				</div>
				<div class="card-body">
					<form>
						<div class="mb-3">
							<label for="accountNo" class="form-label">보유 계좌 목록</label>
							<c:if test="${empty myAccountList }">
								<option>보유중인 계좌가 없어요</option>
							</c:if>
							<select class="form-select" id="accountNo" name="accountNo">
								<c:choose>
									<c:when test="${empty myAccountList }">
										<option selected>보유중인 계좌가 없어요</option>
									</c:when>
									<c:otherwise>
										<option disabled selected>--출금계좌를 선택하세요--</option>
										<c:forEach var="myAccount" items="${myAccountList}">
											<option value="${myAccount.accountNo}">${myAccount.accountNo}
												(${myAccount.productName})</option>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</select>
						</div>
						<div class="mb-3">
							<label for="accountPassword" class="form-label">계좌 비밀번호</label> <input
								type="password" class="form-control" id="accountPassword"
								name="accountPassword" maxlength="4">
						</div>
					</form>
				</div>
			</div>

			<div class="card mx-auto mt-5 mb-5" style="width: 30rem;">
				<div class="card-header" align="center">
					<h5 class="card-title">입금 정보</h5>
				</div>
				<div class="card-body">
					<form>
						<div class="mb-3">
							<label for="depositBank" class="form-label">입금 은행 목록</label> <select
								class="form-select" id="depositBank" name="depositBank">
								<!-- Options here -->
									<c:forEach var="bank" items="${bankList}">
										<option value="${bank.bankCode}">${bank.bankName}
											(${bank.bankCode})</option>
									</c:forEach>
							</select>
						</div>
						<div class="mb-3">
							<label for="depositAccountNo" class="form-label">입금 계좌 번호</label>
							<input type="text" class="form-control" id="depositAccountNo"
								name="depositAccountNo">
						</div>
						<div class="mb-3">
							<label for="transferAmount" class="form-label">이체 금액</label> <input
								type="text" class="form-control" id="transferAmount"
								name="transferAmount">
						</div>
					</form>
					<div class="d-flex justify-content-center mt-5">
						<button class="btn btn-primary"
							onclick="location.href='transactionProcess.do'">다음</button>
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