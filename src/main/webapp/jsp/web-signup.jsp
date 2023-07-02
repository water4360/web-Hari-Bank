<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>HB하리은행 - 웹 회원가입</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
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
	<div class="container mt-5 mb-5">
		<h3 align="center">회원가입</h3>

		<div class="input-form-backgroud row mt-3">
			<div class="input-form mx-auto"
				style="min-width: 400px; max-width: 500px;" align="left">
				<form method="post" action="signupProcess.do" name="joinForm"
					class="validation-form" novalidate>

					<div class="col-6 mb-3">
						<label for="id">아이디</label> <input type="text"
							class="form-control" id="id" name="id" autocorrect="off"
							autocapitalize="none" placeholder="4~20자 영문, 숫자 입력" value=""
							pattern="[a-zA-Z0-9]{4,20}" required>
						<div id="invalid-feedback" style="color: red;"></div>
						<div id="valid-feedback" style="color: green;"></div>
						<div class="invalid-feedback" id="invalid-feedback-id">(class)아이디를
							입력해주세요</div>
					</div>

					<div class="col-6 mb-3">
						<label for="pw">비밀번호</label> <input type="password"
							class="form-control" id="pw" name="pw"
							placeholder="4~12자 영문+숫자+특수문자" value="" required>
						<div class="invalid-feedback">(class)비밀번호를 입력해주세요</div>
					</div>
					<div class="col-6 mb-3">
						<label for="pw2">비밀번호 확인</label> <input type="password"
							class="form-control" id="pw2" name="pw2" placeholder="비밀번호 재입력"
							value="" onkeyup="checkPw()" required>
						<!-- 						<div id="pw2-feedback" style="color: red;"></div> -->
						<div class="invalid-feedback" id="pw2-feedback">(class)비밀번호가
							일치하지 않아요</div>
					</div>

					<div class="col-6 mb-3">
						<label for="name">한글이름</label> <input type="text"
							class="form-control" id="name" name="name" placeholder="한글이름 입력"
							value="" pattern="[가-힣]{2,20}" required>
						<div class="invalid-feedback">(class)이름을 입력해주세요</div>
					</div>

					<div class="col-10 mb-3">
						<label for="birthdate">주민등록번호</label>
						<div class="row">
							<div class="col-4">
								<input type="text" class="form-control" id="birthdate"
									name="birthdate" placeholder="901208" value="" maxlength="6"
									pattern="[0-9]{6}" required>
							</div>
							<div class="col-1">-</div>
							<div class="col-2">
								<input type="text" class="form-control" id="gender"
									name="gender" maxlength="1" pattern="[0-9]{1}" required>
							</div>
							<div class="col-1">●●●●●●</div>
						</div>
					</div>
					<div class="invalid-feedback">(class)생년월일을 입력해주세요</div>

					<div class="col-10 mb-3">
						<label for="phone">연락처</label>
                        <div class="row">
                            <div class="col-4 pr-0">
                                <select id="telecom" name="telecom" class="form-control">
                                    <option selected disabled>통신사선택</option>
                                    <option value="SKT">SK</option>
                                    <option value="KT">KT</option>
                                    <option value="LGU">LGU+</option>
                                    <option value="알뜰폰">알뜰폰</option>
                                </select>
                            </div>
                            <div class="col-6 pl-0">
                                <input type="number" class="form-control" name="phone"
                                    placeholder="예) 01023456789" value="" maxlength="11" pattern="[0-9]{10,11}"
                                    required>
                            </div>
                        </div>
                        <div class="invalid-feedback">연락처 형식이 올바르지 않아요.</div>
					</div>

					<div class="col-6 mb-3">
						<label for="email">이메일</label> <input type="email"
							class="form-control" id="email" name="email"
							placeholder="예)soob@library.com" required>
						<div class="invalid-feedback">(class)이메일 주소가 올바르지 않아요</div>
					</div>

					<div class="col-10 mb-3">
						<input type="button" class="btn btn-secondary"
							onclick="execDaumPostcode()" value="우편번호 찾기"><br> <input
							type="text" class="form-control" id="postcode" name="postcode"
							placeholder="우편번호"> <input type="text"
							class="form-control" id="address" name="address" placeholder="주소">
						<input type="text" class="form-control" id="extraAddress"
							name="roadAddress" placeholder="상세주소"> <input type="text"
							class="form-control" id="detailAddress" name="detailAddress"
							placeholder="상세주소">
						<div class="invalid-feedback">주소를 입력해주세요</div>
						<div class="custom-control custom-checkbox mt-3">
							<input type="checkbox" id="agreement"
								class="custom-control-input" required> <label
								class="custom-control-label" for="agreement"> (필수)개인정보
								수집 및 이용에 동의할게요</label>
						</div>
					</div>

					<div class="col-4 mb-4">
						<button class="btn btn-lg" type="submit"
							id="signup-btn">회원가입</button>
					</div>
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
		  let pw = document.getElementById('pw');
		  let pw2 = document.getElementById('pw2');

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

	
	
	
	
	
		$(function() {
			$("#id").on("keyup", function() {
				var $checkID = $(this).val();
				var $error = $("#invalid-feedback");
				var $msg = $("#valid-feedback");

				console.log("keyup: " + $checkID);

				if ($checkID === "") {
					$error.html("");
					$msg.html("");
					console.log("아이디 없음");
					return;
				}

				$.ajax({
					type : "POST",
					url : "./jsp/check-jsp/checkId.jsp",
					data : {
						"id" : $checkID
					},
					dataType : "html",
					async : true,
					success : function(data) {
						console.log("dao data : " + data);

						if (data.trim() == "true") {
							$error.html("❌이미 존재하는 아이디예요");
							$msg.html("");
						} else {
							if ($checkID.length < 4) {
								$error.html("❌아이디가 너무 짧아요");
								$msg.html("");
								console.log("아이디 짧음");
							} else {
								$error.html("");
								$msg.html("✔사용가능한 아이디예요");
							}
						}
					},
					error : function(xhr, status, error) {
						console.error("Ajax 요청 실패!");
						console.error("HTTP 상태 코드: " + xhr.status);
						console.error("에러 메시지: " + error);
					}
				});
			});
		});

// 		function checkPw() {
// 			let pw = document.getElementById("pw");
// 			let pw2 = document.getElementById("pw2");
// 			let pwFeedback = document.getElementById("pw2-feedback");

// 			if (pw.value !== pw2.value) {
// 				pw2.classList.add("is-invalid");
// 				pwFeedback.innerText = "❌비밀번호가 일치하지 않아요";
// 				pwFeedback.style.color = "red";
// 				return false;
// 			} else {
// 				pw2.classList.remove("is-invalid");
// 				pwFeedback.innerText = "✔비밀번호가 일치해요";
// 				pwFeedback.style.color = "green";
// 				return true;
// 			}
// 		}
		
		
		
	</script>
	<footer>
		<%-- 하단고정 --%>
		<jsp:include page="/jsp/main-jsp/footer.jsp"></jsp:include>
	</footer>
</body>
</html>
