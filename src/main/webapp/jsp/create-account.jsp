<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>HR Bank - 비대면 계좌개설</title>

<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<!-- Option 1: Bootstrap Bundle with Popper -->
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-beta1/js/bootstrap.bundle.min.js"></script>

</head>
<header>
	<%-- 상단고정 --%>
	<jsp:include page="/jsp/main-jsp/topper.jsp"></jsp:include>
</header>

<body>
	<div class="container mt-5 mb-5">
		<h3 align="center">계좌 개설</h3>



		<%--[상품설명]  계좌번호, 개설일자, 계좌비밀번호, 잔액, 별칭, 상품코드, 사용자아이디, 은행코드 --%>




		<div class="input-form-backgroud row">
			<div class="input-form mx-auto "
				style="min-width: 300px; max-width: 400px;" align="center">
					<div class="col-md-8 mb-5">
						<div class="card">
							<div class="card-header">
								<h4>HR하리사랑통장</h4>
							</div>
							<div class="card-body">
								<h5 class="card-title">입출금자유예금</h5>
								<p class="card-text">연이율 1.3% 수수료 무료</p>
							</div>
						</div>
						
						
					<div class="custom-control custom-checkbox mt-3">
						<input type="checkbox" class="custom-control-input" required>
						<label class="custom-control-label" for="agreement">(필수)계좌
							개설 및 약관 동의</label>
					</div>
						
					</div>
				<form method="post" action="createAccountProcess.do"
					name="createAccountForm" class="validation-form" novalidate>

					<div class="col-6 mb-3">
						<label for="account-pw">계좌비밀번호</label> <input type="password"
							class="form-control" id="account-pw" name="account-pw"
							placeholder="4자리 숫자" maxlength="4" value="" required>
						<div class="invalid-feedback">계좌 비밀번호를 입력해주세요</div>
					</div>
					<div class="col-6 mb-3">
						<label for="account-pw2">비밀번호 확인</label> <input type="password"
							class="form-control" id="account-pw2" name="account-pw2"
							placeholder="비밀번호 확인" maxlength="4" value="" onkeyup="checkPw()"
							required>
						<div class="invalid-feedback" id="account-pw2-feedback">비밀번호를 확인해주세요</div>
					</div>

					<div class="col-4 mb-4"></div>
					<button class="btn btn-success btn-lg" type="submit"
						id="signup-btn">계좌개설</button>



				</form>
			</div>
		</div>
	</div>
	<script>	
	
	<%-- 폼 유효성 검사 --%>	
	window.addEventListener('load', () => {
		  const forms = document.getElementsByClassName('validation-form');

		  Array.prototype.filter.call(forms, (form) => {
		    form.addEventListener('submit', function (event) {
		      if (form.checkValidity() === false) {
		        event.preventDefault();
		        event.stopPropagation();
		      }
		      
		      form.classList.add('was-validated');
		      const isPasswordValid = checkPw();
		      const pwFeedback = document.getElementById('account-pw2-feedback');
		      
		      if (!isPasswordValid) {
		        pwFeedback.innerText = '❌비밀번호가 일치하지 않아요';
		        pwFeedback.style.color = 'red';
		      } else {
		        pwFeedback.innerText = '✔비밀번호가 일치해요';
		        pwFeedback.style.color = 'green';
		      }

		    }, false);
		  });
		}, false);

		function checkPw() {
		  let pw = document.getElementById('account-pw');
		  let pw2 = document.getElementById('account-pw2');

		  if (pw.value !== pw2.value) {
		    pw2.classList.add('is-invalid');
		    return false;
		  } else {
		    pw2.classList.remove('is-invalid');
		    return true;
		  }
		}
	</script>

	<footer>
		<%-- 하단고정 --%>
		<jsp:include page="/jsp/main-jsp/footer.jsp"></jsp:include>
	</footer>
</body>
</html>
