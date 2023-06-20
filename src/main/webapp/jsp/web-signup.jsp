<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>HR Bank - 웹 회원가입</title>

<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />

<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>

<!-- Core theme CSS (includes Bootstrap)-->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
	integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct"
	crossorigin="anonymous"></script>

<!-- 내 스타일시트 -->
<link href="/css/styles.css" rel="stylesheet" />

</head>
	<header>
		<%-- 상단고정 --%>
		<jsp:include page="/jsp/main-jsp/topper.jsp"></jsp:include>
	</header>
	
<body style="background-color: white">
	<div class="container">
		<h3 align="center">회원가입</h3>
		
		
		
		<div class="input-form-backgroud row">
			<div class="input-form mx-auto"
				style="min-width: 400px; max-width: 800px;">
				<form method="post" action="signupProcess.do" name="joinForm"
					class="validation-form" novalidate>
					
					<div class="col-12 mb-3">
						<label for="id">아이디</label> <input type="text"
							class="form-control" id="id" name="id" autocorrect="off"
							autocapitalize="none" placeholder="4~20자 영문, 숫자 입력" value=""
							pattern="[a-zA-Z0-9]{4,20}" required>
						<div id="invalid-feedback" style="color: red;"></div>
						<div id="valid-feedback" style="color: green;"></div>
					</div>

					<div class="col-12 mb-3">
						<label for="pw">비밀번호</label> <input type="password"
							class="form-control" id="pw" name="pw"
							placeholder="4~12자 영문+숫자+특수문자" value="" required>
						<div class="invalid-feedback">비밀번호를 입력해주세요</div>
					</div>
					<div class="col-12 mb-3">
						<label for="pw2">비밀번호 확인</label> <input type="password"
							class="form-control" id="pw2" name="pw2" placeholder="비밀번호 재입력"
							value="" required>
						<div id="pw2-feedback" style="color: red;"></div>
					</div>

					<div class="col-12 mb-3">
						<label for="name">한글이름</label> <input type="text"
							class="form-control" id="name" name="name" placeholder="이름 입력"
							value="" pattern="[가-힣]{1,20}" required>
						<div class="invalid-feedback">이름을 입력해주세요</div>
					</div>
					
					<div class="col-5 mb-3">
						<label for="birthdate">주민등록번호</label>
						<input type="text"
							class="form-control" id="birthdate" name="birthdate" placeholder="901208"
							value="" pattern="[0-9]{6}" required>
						<div class="invalid-feedback">생년월일을 입력해주세요</div>
						-
						<input type="text"
							class="form-control" id="gender" name="gender" placeholder=""
							value="" pattern="[0-9]{1}" required>●●●●●●
						<div class="invalid-feedback">생년월일을 입력해주세요</div>
					</div>
					
					<div class="col-6 mb-3">
						<label for="phone">연락처</label>
						<select>
							<option>SK</option>
							<option>KT</option>
							<option>LGU+</option>
							<option>알뜰폰</option>
						</select>
						<input type="number"
							class="form-control" id="phone" name="phone"
							placeholder="예)01023456789" value="" pattern="[0-9]{10,11}"
							required>
						<div class="invalid-feedback">연락처 형식이 올바르지 않아요</div>
					</div>
					<div class="col-12 mb-3">
						<label for="email">이메일</label> <input type="email"
							class="form-control" id="email" name="email"
							placeholder="예)soob@library.com" required>
						<div class="invalid-feedback">이메일 주소가 올바르지 않아요</div>
					</div>
					
					<div class="custom-control custom-checkbox">
						<input type="checkbox" class="custom-control-input" id="agreement"
							required> <label class="custom-control-label"
							for="agreement">(필수)개인정보 수집 및 이용에 동의할게요</label>
					</div>
					<div class="mb-4"></div>
					<button class="btn btn-success btn-lg btn-block" type="submit"
						id="signup-btn">회원가입</button>
				</form>
			</div>
		</div>
	</div>

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
					url : "./jsp/checkId.jsp",
					data : {
						"id" : $checkID
					},
					dataType : "html",
					async : true,
					success : function(data) {
						console.log("jsp data : " + data);

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
					}
				});
			});
		});

		function checkPw() {
			let pw = document.getElementById("pw");
			let pw2 = document.getElementById("pw2");
			let pwFeedback = document.getElementById("pw2-feedback");

			if (pw.value !== pw2.value) {
				pw2.classList.add("is-invalid");
				pwFeedback.innerText = "❌비밀번호가 일치하지 않아요";
				pwFeedback.style.color = "red";
				return false;
			} else {
				pw2.classList.remove("is-invalid");
				pwFeedback.innerText = "✔비밀번호가 일치해요";
				pwFeedback.style.color = "green";
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
