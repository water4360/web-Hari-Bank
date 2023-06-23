<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>HR Bank - 비대면 계좌개설</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
	integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct"
	crossorigin="anonymous"></script>
<style>
/* 화살표 메뉴 숨기기 */
input[type="number"]::-webkit-inner-spin-button, input[type="number"]::-webkit-outer-spin-button
	{
	-webkit-appearance: none;
	margin: 0;
}
</style>


</head>
<header>
	<%-- 상단고정 --%>
	<jsp:include page="/jsp/main-jsp/topper.jsp"></jsp:include>
</header>

<body>
	<div class="container">
		<h3 align="center">계좌 개설</h3>

		<div class="input-form-backgroud row">
			<div class="input-form mx-auto"
				style="min-width: 400px; max-width: 500px;" align="left">
				<form method="post" action="signupProcess.do" name="joinForm"
					class="validation-form" novalidate>

					<div class="col-6 mb-3">
						<label for="firstname">영문이름</label> <input type="text"
							class="form-control" id="firstname" name="firstname" autocorrect="off"
							autocapitalize="none" placeholder="Firstname" value=""
							pattern="[a-zA-Z]{4,20}" required>
						<div id="invalid-feedback" style="color: red;"></div>
						<div id="valid-feedback" style="color: green;"></div>
						<div class="invalid-feedback" id="invalid-feedback-firstname">영문이름을 입력해주세요</div>
					</div>
					<div class="col-6 mb-3">
						<label for="lastname">영문성</label> <input type="text"
							class="form-control" id="lastname" name="lastname" autocorrect="off"
							autocapitalize="none" placeholder="Lastname" value=""
							pattern="[a-zA-Z]{4,20}" required>
						<div id="invalid-feedback" style="color: red;"></div>
						<div id="valid-feedback" style="color: green;"></div>
						<div class="invalid-feedback" id="invalid-feedback-lastname">영문성을 입력해주세요</div>
					</div>

					<div class="col-6 mb-3">
						<label for="account-pw">계좌비밀번호</label> <input type="password"
							class="form-control" id="account-pw" name="account-pw"
							placeholder="4" maxlength="4" value="" required>
						<div class="invalid-feedback">계좌 비밀번호를 입력해주세요</div>
					</div>
					<div class="col-6 mb-3">
						<label for="account-pw2">비밀번호 확인</label> <input type="password"
							class="form-control" id="account-pw2" name="account-pw2"
							placeholder="4" maxlength="4" value="" onkeyup="checkPw()" required>
						<div class="invalid-feedback">비밀번호를 입력해주세요</div>
					</div>

					<div class="col-6 mb-3">
						<label for="benefit-code">우대코드(선택)</label> <input type="text"
							class="form-control" id="benefit-code" name="benefit-code" placeholder="우대코드"
							value="" pattern="[a-zA-Z]{4,20}">
						<div class="invalid-feedback">올바른 코드가 아니예요</div>
					</div>


					<div class="custom-control custom-checkbox">
						<input type="checkbox" class="custom-control-input" required>
						<label class="custom-control-label" for="agreement">(필수)개인정보
							수집 및 이용에 동의할게요</label>
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
		      
		      
		      
<%-- 		   아이디 중복 체크 함수 호출 및 결과에 따라 피드백 요소를 업데이트    --%>
// 		      const isIdValid = checkId();
// 		      const idFeedback = document.getElementById('invalid-feedback-id');
		      
// 		      if (!isIdValid) {
// 		        idFeedback.innerText = '❌아이디를 입력해주세요';
// 		        idFeedback.style.color = 'red';
// 		      } else {
// 		        idFeedback.innerText = '';
// 		      }
		      
		      
// 		      function checkId() {
// 					$("#id").on("keyup", function() {
// 						var inputId = $(this).val();
// 						var $error = $("#invalid-feedback");
// 						var $msg = $("#valid-feedback");

// 						console.log("keyup: " + inputId);

// 						if (inputId === "") {
// 							$error.html("");
// 							$msg.html("");
// 							console.log("아이디 없음");
// 							return;
// 						}

// 						$.ajax({
// 							type : "POST",
// 							url : "./jsp/check-jsp/checkId.jsp",
// 							// 					url : "/checkId",
// 							data : {
// 								"id" : inputId
// 							},
// 							dataType : "html",
// 							async : true,
// 							success : function(data) {
// 								console.log("dao data : " + data);

// 								if (data.trim() == "true") {
// 									$error.html("❌이미 존재하는 아이디예요");
// 									$msg.html("");
// 								} else {
// 									if (inputId.length < 4) {
// 										$error.html("❌아이디가 너무 짧아요");
// 										$msg.html("");
// 										console.log("아이디 짧음");
// 									} else {
// 										$error.html("");
// 										$msg.html("✔사용가능한 아이디예요");
// 									}
// 								}
// 							},
// 							error : function(xhr, status, error) {
// 								console.error("Ajax 요청 실패!");
// 								console.error("HTTP 상태 코드: " + xhr.status);
// 								console.error("에러 메시지: " + error);
// 							}
// 						});
// 					});
// 				};
		    	  


		      
		      
		      
		      
		      
		      
		      
		      // 비밀번호 확인 함수 호출 및 결과에 따라 피드백 요소를 업데이트합니다.
		      const isPasswordValid = checkPw();
		      const pwFeedback = document.getElementById('pw2-feedback');
		      
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










	<%-- 주소찾기용 --%>
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		function execDaumPostcode() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

							// 각 주소의 노출 규칙에 따라 주소를 조합한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var addr = ''; // 주소 변수
							var extraAddr = ''; // 참고항목 변수

							//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
							if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
								addr = data.roadAddress;
							} else { // 사용자가 지번 주소를 선택했을 경우(J)
								addr = data.jibunAddress;
							}

							// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
							if (data.userSelectedType === 'R') {
								// 법정동명이 있을 경우 추가한다. (법정리는 제외)
								// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
								if (data.bname !== ''
										&& /[동|로|가]$/g.test(data.bname)) {
									extraAddr += data.bname;
								}
								// 건물명이 있고, 공동주택일 경우 추가한다.
								if (data.buildingName !== ''
										&& data.apartment === 'Y') {
									extraAddr += (extraAddr !== '' ? ', '
											+ data.buildingName
											: data.buildingName);
								}
								// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
								if (extraAddr !== '') {
									extraAddr = ' (' + extraAddr + ')';
								}
								// 조합된 참고항목을 해당 필드에 넣는다.
								document.getElementById("extraAddress").value = extraAddr;

							} else {
								document.getElementById("extraAddress").value = '';
							}

							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							document.getElementById('postcode').value = data.zonecode;
							document.getElementById("address").value = addr;
							// 커서를 상세주소 필드로 이동한다.
							document.getElementById("detailAddress").focus();
						}
					}).open();
		}
	</script>


	<script>
		
	</script>
	<footer>
		<%-- 하단고정 --%>
		<jsp:include page="/jsp/main-jsp/footer.jsp"></jsp:include>
	</footer>
</body>
</html>
