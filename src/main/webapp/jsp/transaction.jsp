<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>HR Bank - 당행/타행계좌이체</title>
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
				<h2>당행/타행계좌이체</h2>
			</div>

			<div class="card mx-auto" style="width: 30rem;">
				<div class="card-header" align="center">
					<h5 class="card-title">출금 정보</h5>
				</div>
				<div class="card-body">
					<div class="mb-3">
						<label for="senderAccountNo" class="form-label">보유 계좌 목록</label>
						<c:if test="${empty myAccountList }">
							<option>보유중인 계좌가 없어요</option>
						</c:if>
						<select class="form-select" id="senderAccountNo"
							name="senderAccountNo">
							<option disabled selected>--출금계좌를 선택하세요--</option>
							<c:forEach var="myAccount" items="${myAccountList}">
								<option value="${myAccount.accountNo}">${myAccount.accountNo}
									(${myAccount.productName})</option>
							</c:forEach>
						</select>
						<div style="display: inline-block;" class="mt-2">
							<input type="button" class="btn btn-secondary" value="잔액조회"
								onclick="showCurrentBalance()">
							<div id="currentBalance" style="display: inline-block;"></div>
						</div>
					</div>
					<div class="mb-3">
						<label for="accountPassword" class="form-label">계좌 비밀번호</label> <input
							type="password" class="form-control" id="accountPassword"
							name="accountPassword" maxlength="4">
					</div>
				</div>
			</div>

			<div class="card mx-auto mt-5 mb-5" style="width: 30rem;">
				<div class="card-header" align="center">
					<h5 class="card-title">입금 정보</h5>
				</div>
				<div class="card-body">
					<div class="mb-3">
						<label for="receiverBankCode" class="form-label">입금 은행 목록</label>
						<select class="form-select" id="receiverBankCode"
							name="receiverBankCode">
							<!-- Options here -->
							<c:forEach var="bank" items="${bankList}">
								<option value="${bank.bankCode}">${bank.bankName}
									(${bank.bankCode})</option>
							</c:forEach>
						</select>
					</div>
					<div class="mb-3">
						<label for="receiverAccountNo" class="form-label">입금 계좌 번호</label>
						<input type="text" class="form-control" id="receiverAccountNo"
							name="receiverAccountNo">
					</div>
					<div class="mb-3">
						<label for="transferAmount" class="form-label">이체 금액</label> <input
							type="text" class="form-control" id="transferAmount"
							name="transferAmount">
					</div>
					<div class="d-flex justify-content-center mt-5">
						<!-- 						<button class="btn btn-primary" -->
						<!-- 						onclick="location.href='transactionProcess.do'">다음</button> -->
						<button type="submit" class="btn btn-success" data-toggle="modal"
							data-target="#confirmTransactionInfo" aria-expanded="false"
							id="transfer">이체하기</button>
					</div>
				</div>
			</div>
		</div>



	</section>

	<script>
		// 다른 계좌를 선택하면 이전 잔액 보이지 않도록.
		$('#senderAccountNo').change(function() {
			$('#currentBalance').text('');
		});

		function showCurrentBalance() {

			let selectedAccount = $('#senderAccountNo').val(); // 선택된 계좌 번호를 가져옵니다.
			console.log(selectedAccount)

			// 선택된 계좌가 없을 경우 메시지 출력하고 함수 실행 중지
			if (selectedAccount == null) {
				$('#currentBalance').text('계좌를 먼저 선택해주세요').css('color', 'red');
				return;
			}

			$.ajax({
				url : '/Hari-bank/checkCurrentBalance.do',
				method : 'POST',
				data : {
					accountNo : selectedAccount
				// 선택된 계좌 번호를 서버로 전달합니다.
				},
				success : function(response) {
					// 서버로부터 응답을 성공적으로 받았을 때 실행되는 코드입니다.
					// 응답으로 받은 잔액을 #currentBalance 요소에 표시합니다.
					response = response.trim();
					console.log(response)
					$('#currentBalance').text(response).css('color', 'black');
				},
				error : function(jqXHR, textStatus, errorThrown) {
					// 에러가 발생했을 때 실행되는 코드입니다.
					console.log(textStatus, errorThrown);
					alert('조회실패');
				}
			});
		}

		function checkPw() {
			let insertPw = $('#accountPassword').val();

		}
	</script>









	<footer>
		<%-- 하단고정 --%>
		<jsp:include page="/jsp/main-jsp/footer.jsp"></jsp:include>
	</footer>


</body>
</html>