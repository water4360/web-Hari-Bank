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
			<form action="transactionProcess.do" method="POST">
				<div class="card mx-auto" style="width: 30rem;">
					<div class="card-header" align="center">
						<h5 class="card-title">출금 정보</h5>
					</div>
					<div class="card-body">
						<div class="mb-3">
							<label for="senderAccountNo" class="form-label">보유 계좌 목록</label>
									<select class="form-select" id="senderAccountNo"
										name="senderAccountNo">
										<option disabled selected>--출금계좌를 선택하세요--</option>
										<c:forEach var="myAccount" items="${myAccountList}">
											<option value="${myAccount.accountNo}"
											<c:if test="${myAccount.accountNo eq selectedAccount}">
												selected
											</c:if>
											>${myAccount.accountNo}
												(${myAccount.productName})</option>
										</c:forEach>
									</select>
									<input type="hidden" name="senderBankCode" value="0758">

									<div id="senderAccountNo-feedback" style="display: none;"></div>
									<div style="display: inline-block;" class="mt-2">
										<input type="button" class="btn btn-secondary" value="잔액조회"
											onclick="showCurrentBalance()">
										<div id="currentBalance" style="display: inline-block;"></div>
									</div>
						</div>
						<div>
							<label for="accountPassword" class="form-label">계좌 비밀번호</label>
							<!-- 계좌 비밀번호 입력 필드 -->
							<input type="password" class="form-control mb-2"
								id="accountPassword" name="accountPassword" maxlength="4"
								style="width: 100px;">
							<div id="accountPassword-feedback" class="invalid-feedback"
								style="display: none;"></div>
							<!-- 클래스와 스타일 수정 -->
						</div>
					</div>
				</div>

				<div class="card mx-auto mt-1 mb-5" style="width: 30rem;">
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
									<option value="${bank.bankCode}">${bank.bankName}</option>
								</c:forEach>
							</select>
							<div id="receiverBankCode-feedback" style="display: none;"></div>
						</div>
						<div class="mb-3">
							<label for="receiverAccountNo" class="form-label">입금 계좌
								번호</label>
							<!-- 입금 계좌 번호 입력 필드 -->
							<input type="text" class="form-control" id="receiverAccountNo"
								name="receiverAccountNo">
							<div id="receiverAccountNo-feedback" class="invalid-feedback"
								style="display: none;"></div>
							<!-- 클래스와 스타일 수정 -->
						</div>
						<div class="mb-3">
							<label for="transferAmount" class="form-label">이체 금액</label>
							<!-- 이체 금액 입력 필드 -->
							<input type="text" class="form-control" id="transferAmount"
								name="transferAmount">
							<div id="transferAmount-feedback" class="invalid-feedback"
								style="display: none;"></div>
							<!-- 클래스와 스타일 수정 -->
						</div>
						<div class="mb-3">
							<label for="to-memo" class="form-label">받는통장 메모</label> <input
								type="text" class="form-control" id="toMemo" name="toMemo"
								placeholder="(선택)7자 이내 입력" maxlength="21">
							<div id="transferAmount-feedback" style="display: none;"></div>
						</div>
						<div class="mb-3">
							<label for="from-memo" class="form-label">내통장 메모</label> <input
								type="text" class="form-control" id="fromMemo" name="fromMemo"
								placeholder="(선택)7자 이내 입력" maxlength="21">
							<div id="transferAmount-feedback" style="display: none;"></div>
						</div>
						<div class="d-flex justify-content-center mt-5">
							<button type="submit" class="btn btn-success">이체실행</button>


						</div>
					</div>
				</div>
			</form>
		</div>


		<!-- Modal -->
		<div class="modal fade" id="confirmModal" tabindex="-1"
			aria-labelledby="confirmModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="confirmModalLabel">이체 정보 확인</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body" id="confirmModalBody">
						<!-- This will be filled by the script -->
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">취소</button>
						<button type="button" class="btn btn-primary" id="confirmTransfer">확인</button>
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
					$('#currentBalance').text(response).css('color', 'black');
				},
				error : function(jqXHR, textStatus, errorThrown) {
					// 에러가 발생했을 때 실행되는 코드입니다.
					console.log(textStatus, errorThrown);
					alert('잔액조회실패. 다시 시도하세요.');
				}
			});
		}

		// 계좌비밀번호 4자리 일치확인
		$('#accountPassword').on(
				'keyup',
				function() {
					let accountPassword = $(this).val(); // 입력된 비밀번호를 가져옵니다.
					let accountNo = $('#senderAccountNo').val(); // 선택된 계좌 번호를 가져옵니다.

					// 계좌 번호나 비밀번호가 없거나, 비밀번호의 길이가 4가 아닌 경우 함수를 종료합니다.
					if (!accountPassword || !accountNo
							|| accountPassword.length != 4) {
						$(this).removeClass('is-valid is-invalid'); // 클래스 초기화
						$('#accountPassword-feedback').text('').hide(); // 피드백 메시지를 숨깁니다.
						return;
					}

					$.ajax({
						url : '/Hari-bank/checkAccountPassword.do',
						method : 'POST',
						data : {
							accountNo : accountNo,
							accountPassword : accountPassword
						// 계좌 번호와 비밀번호를 서버로 전달합니다.
						},
						success : function(response) {
							// 서버로부터 응답을 성공적으로 받았을 때 실행되는 코드입니다.
							response = response.trim();
							if (response == "true") {
								$('#accountPassword').removeClass('is-invalid')
										.addClass('is-valid'); // 유효성 검사 통과 시 클래스 추가
								$('#accountPassword-feedback').text(
										'비밀번호가 일치합니다').addClass('d-block')
										.removeClass('d-none'); // 클래스 및 스타일 수정
							} else {
								$('#accountPassword').removeClass('is-valid')
										.addClass('is-invalid'); // 유효성 검사 실패 시 클래스 추가
								$('#accountPassword-feedback').text(
										'비밀번호가 일치하지 않습니다').addClass('d-block')
										.removeClass('d-none'); // 클래스 및 스타일 수정
							}
						},
						error : function(jqXHR, textStatus, errorThrown) {
							// 에러가 발생했을 때 실행되는 코드입니다.
							console.log(textStatus, errorThrown);
							alert('비밀번호 검증에 실패했습니다.');
						}
					});
				});

		// 상대계좌 유효성 체크
		$('#receiverAccountNo').on(
				'keyup',
				function() {
					let senderAccountNo = $('#senderAccountNo').val();
					let receiverBankCode = $('#receiverBankCode').val();
					let receiverAccountNo = $(this).val();

					if (senderAccountNo === receiverAccountNo) {
						$(this).removeClass('is-valid').addClass('is-invalid'); // 유효성 검사 실패 시 클래스 추가
						$('#receiverAccountNo-feedback').text(
								'출금 계좌와 동일한 계좌번호입니다').addClass('d-block')
								.removeClass('d-none'); // 클래스 및 스타일 수정
					} else {
						$(this).removeClass('is-invalid').addClass('is-valid'); // 유효성 검사 통과 시 클래스 추가
						$('#receiverAccountNo-feedback').text('').hide();
					}

					if (!receiverAccountNo || receiverAccountNo.length <= 6) {
						$(this).removeClass('is-valid is-invalid'); // 클래스 초기화
						$('#receiverAccountNo-feedback').text('').hide();
						return;
					}
					$.ajax({
						url : '/Hari-bank/checkReceiverAccount.do',
						method : 'POST',
						data : {
							sender : senderAccountNo,
							bankCode : receiverBankCode,
							accountNo : receiverAccountNo,
						},
						success : function(response) {
							response = response.trim();
							if (response === "correct") {
								$('#receiverAccountNo').removeClass(
										'is-invalid').addClass('is-valid'); // 유효성 검사 통과 시 클래스 추가
								$('#receiverAccountNo-feedback').text(
										'유효한 계좌번호입니다').css('color', 'green')
										.addClass('d-block').removeClass(
												'd-none'); // 클래스 및 스타일 수정
							} else if (response === "duplicated") {
								$('#receiverAccountNo').removeClass('is-valid')
										.addClass('is-invalid'); // 유효성 검사 실패 시 클래스 추가
								$('#receiverAccountNo-feedback').text(
										'출금계좌와 입금계좌는 동일할 수 없습니다').addClass(
										'd-block').removeClass('d-none'); // 클래스 및 스타일 수정
							} else {
								$('#receiverAccountNo').removeClass('is-valid')
										.addClass('is-invalid'); // 유효성 검사 실패 시 클래스 추가
								$('#receiverAccountNo-feedback').text(
										'유효하지 않은 계좌번호입니다').addClass('d-block')
										.removeClass('d-none'); // 클래스 및 스타일 수정
							}
						},
						error : function(jqXHR, textStatus, errorThrown) {
							// 에러가 발생했을 때 실행되는 코드입니다.
							console.log(textStatus, errorThrown);
							alert('받는 계좌 유효성 검증에 실패했습니다.');
						}
					});
				});

		// 필드 유효성 검사
		// 필드 값 변경 감지
		$(
				'#senderAccountNo, #accountPassword, #receiverBankCode, #receiverAccountNo, #transferAmount, #toMemo, #fromMemo')
				.on('change keyup', function() {
					let id = $(this).attr('id');
					let value = $(this).val();

					// 해당 필드가 비어있지 않으면 피드백 메시지 숨기기
					if (value) {
						$('#' + id + '-feedback').text('').hide();
					}
				});

		$('form')
				.on(
						'submit',
						function(e) {
							let senderAccountNo = $('#senderAccountNo').val();
							let accountPassword = $('#accountPassword').val();
							let receiverBankCode = $('#receiverBankCode').val();
							let receiverAccountNo = $('#receiverAccountNo')
									.val();
							let transferAmount = $('#transferAmount').val();
							let toMemo = $('#toMemo').val();
							let fromMemo = $('#fromMemo').val();

							// 모든 필드가 제대로 입력되었는지 확인합니다.
							if (!senderAccountNo || !accountPassword
									|| !receiverBankCode || !receiverAccountNo
									|| !transferAmount) {
								// 각 필드가 비어있는 경우에 대한 메시지를 설정합니다.
								if (!senderAccountNo) {
									$('#senderAccountNo-feedback').text(
											'출금 계좌를 선택해주세요')
											.css('color', 'red').show();
								}
								if (!accountPassword) {
									$('#accountPassword-feedback').text(
											'계좌 비밀번호를 입력해주세요').css('color',
											'red').show();
								}
								if (!receiverBankCode) {
									$('#receiverBankCode-feedback').text(
											'입금 은행을 선택해주세요')
											.css('color', 'red').show();
								}
								if (!receiverAccountNo) {
									$('#receiverAccountNo-feedback').text(
											'입금 계좌 번호를 입력해주세요').css('color',
											'red').show();
								}
								if (!transferAmount) {
									$('#transferAmount-feedback').text(
											'이체 금액을 입력해주세요')
											.css('color', 'red').show();
								}

								// 이벤트의 기본 동작을 중단합니다.
								e.preventDefault();
							} else {
								// 모든 필드가 제대로 입력되었으면, 모든 피드백 메시지를 숨깁니다.
								$('.feedback').text('').hide();

								// 사용자에게 확인을 요청합니다.
								let confirmation = confirm('입력하신 정보로 이체를 실행할까요?');
								if (!confirmation) {
									// 사용자가 취소를 누른 경우 이벤트의 기본 동작을 중단합니다.
									e.preventDefault();
								}
							}
						});
	</script>


	<footer>
		<%-- 하단고정 --%>
		<jsp:include page="/jsp/main-jsp/footer.jsp"></jsp:include>
	</footer>

</body>
</html>