<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>HR Bank - 비대면 계좌개설</title>

<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<!-- Option 1: Bootstrap Bundle with Popper -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/5.0.0-beta1/js/bootstrap.bundle.min.js"></script>

</head>
<header>
	<%-- 상단고정 --%>
	<jsp:include page="/jsp/main-jsp/topper.jsp"></jsp:include>
</header>

<body>
	<div class="container mt-5 mb-5">
		<h3 align="center">계좌 개설</h3>
		
		
		<div class="container py-5">
      <h3>HR하리사랑통장</h3>
	  <h4>약관 및 상품설명서</h4>
      <div class="accordion mt-4" id="termsAndConditions">
        <div class="accordion-item">
          <h2 class="accordion-header" id="headingOne">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne">
              제1조 (목적)
            </button>
          </h2>
          <div id="collapseOne" class="accordion-collapse collapse" data-bs-parent="#termsAndConditions">
            <div class="accordion-body">
              이 약관은 본 은행과 고객 간의 예금 상품 가입 및 관련 업무에 대한 일반적인 사항을 정함을 목적으로 합니다.
            </div>
          </div>
        </div>
        <div class="accordion-item">
          <h2 class="accordion-header" id="headingTwo">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo">
              제2조 (정의)
            </button>
          </h2>
          <div id="collapseTwo" class="accordion-collapse collapse" data-bs-parent="#termsAndConditions">
            <div class="accordion-body">
              본 약관에서 사용하는 용어의 정의는 다음과 같습니다.
            </div>
          </div>
        </div>
        <!-- 기타 약관 항목들을 추가하실 수 있습니다 -->
      </div>
    </div>


		<%--[상품설명]  계좌번호, 개설일자, 계좌비밀번호, 잔액, 별칭, 상품코드, 사용자아이디, 은행코드 --%>




		<div class="input-form-backgroud row">
			<div class="input-form mx-auto"
				style="min-width: 400px; max-width: 500px;" align="left">
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
						<div class="invalid-feedback">비밀번호를 입력해주세요</div>
					</div>

					<div class="custom-control custom-checkbox">
						<input type="checkbox" class="custom-control-input" required>
						<label class="custom-control-label" for="agreement">(필수)계좌
							개설 및 약관 동의</label>
					</div>
					<div class="col-4 mb-4"></div>
					<button class="btn btn-success btn-lg" type="submit"
						id="signup-btn">계좌개설</button>
						
						
			
				</form>
			</div>
		</div>
	</div>
	<script>	
	
	$(document).ready(function(){
	    $('.nav-tabs a').click(function(){
	        $(this).tab('show');
	    });
	});
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
		      
	</script>
	
	<footer>
		<%-- 하단고정 --%>
		<jsp:include page="/jsp/main-jsp/footer.jsp"></jsp:include>
	</footer>
</body>
</html>
