<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>HB하리은행 - 통합로그인</title>
<%-- 카카오 로그인용 스크립트 파일 --%>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"></script>
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/styles.css">
<!-- <script src="https://code.jquery.com/jquery-3.5.1.js"></script> -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
	//이 함수의 결과가 true이면 아래에 onsubmit이 넘어감.
	function checkForm() {
		let f = document.loginForm
		let id = f.id
		let pw = f.pw
// 		let idError = document.getElementById("idError")
// 		let pwError = document.getElementById("pwError")

		if (id.value.trim() === '') {
			loginError.innerText = '아이디를 입력하세요';
			id.focus();
			return false;
		} else if (pw.value.trim() === '') {
			loginError.innerText = '비밀번호를 입력하세요';
			pw.focus();
			return false;
		} else {
			// 	비밀번호와 아이디가 모두 입력되었을 때에만 로그인 요청
			// 	alert('로그인 프로세스로 진입!')
			return true;
		}
	}
</script>
<style>
.web-login-box, .kakao-login-box {
	display: flex;
	flex-direction: row;
	align-items: center;
	justify-content: space-evenly;
}

.input-login-info {
	display: flex;
	flex-direction: column;
	align-items: stretch;
	justify-content: space-evenly;
}

section {
	display: flex;
	flex-direction: row;
	align-items: center;
	justify-content: space-evenly;
}
</style>
</head>
<body>
	<header>
		<%-- 상단고정 --%>
		<jsp:include page="/jsp/main-jsp/topper.jsp"></jsp:include>
	</header>
	<section>
		<div class="login-outer-container" align="center">
			<!-- 	액션이 갈지 말지 선택하는걸 이 onsubmit 에서 ... -->
			<div class="login-container" style="width: 50rem" align="center">
				<!-- 	submit 눌렀을때 어디로 보낼지 여기서 결정!-->
				<form class="web-login-box" method="post" action="loginProcess.do"
					name="loginForm" style="height: 300px"
					onsubmit="return checkForm()">
					<div class="form-group" align="center">
						<h3>로그인</h3>
						<div class="input-login-info">
							<label for="id">
							<input type="text" class="form-control"
								placeholder="아이디" name="id">
							</label>
							<label for="pw">
							<input type="password"
								class="form-control" placeholder="비밀번호" name="pw">
							</label>
							<div class="checkbox mb-1">
								<label for="saveId">
<!-- 								<input type="checkbox" name="saveId" value="save"> 아이디기억 -->
							</label>
								<div id="loginError" style="color: red;">
							<c:if test="${loginFeedback ne ''}">
							${loginFeedback}
						</c:if>
								</div>
							</div>
							<button type="submit" class="btn btn-basic mb-3">로그인</button>
						</div>
						<div id="divide"></div>
						<div>
							<a href="findId.do">아이디 찾기</a> | <a href="findPw.do">비밀번호 찾기</a><br>
							하리은행을 처음 방문하셨나요? <a href="" onclick="loadPage('signup-choice'); return false;"><b>회원가입</b></a>
						</div>
					</div>
				</form>
				<div class="divide-line"></div>
				<div class="kakao-login-box">
					<a href="#" onclick="kakaoLogin()"><img alt="카카오 로그인"
						src="assets/kakao_login_medium_narrow.png"></a>
				</div>
			</div>
		</div>
	</section>
	<footer>
		<%-- 하단고정 --%>
		<jsp:include page="/jsp/main-jsp/footer.jsp"></jsp:include>
	</footer>

	<script>
	
	
    function loadPage(pageName) {
        if (pageName === 'signup-choice') {
            $.ajax({
                url: "${pageContext.request.contextPath}/jsp/signup-choice.jsp",
                type: "GET",
                success: function(response) {
                    $(".login-container").html(response);
                }
            });
        } else if(pageName === 'find-id') {
            // 다른 페이지 로드 로직
        } else if(pageName === 'find-pw') {
            // 다른 페이지 로드 로직
        }
    }
	
	
	
	
	
	
	
	
	
	
		function kakaoLogin() {
			Kakao.init('01de9cbef4bce203f1cd367ba95b3559');
			Kakao.Auth.loginForm({
				success : function(authObj) {
					console.log("로그인 성공");
					// 로그인 성공 시 처리 로직 작성
					var accessToken = authObj.access_token;
					getUserInfo(accessToken);
					// 예시: 로그인 성공 후 메인 페이지로 리디렉션
// 					window.location.href = 'main.do';
				},
				fail : function(err) {
					// 로그인 실패 시 처리 로직 작성
					console.log(err); // 실패 정보 확인 예시
				}
			});
		}

		function getUserInfo(accessToken) {
			Kakao.API.request({
				url : '/v2/user/me',
				success : function(res) {
					// 사용자 정보 요청 성공 시 처리 로직 작성
					console.log("res : "+res);
					console.log("res.id : "+res.id);
					console.log("res.kakao_account : "+res.kakao_account);
					console.log("res.nickname : " + JSON.stringify(res.properties.nickname));
					console.log("email : " + JSON.stringify(res.kakao_account.email));
					console.log("gender : " + JSON.stringify(res.kakao_account.gender));
					console.log("birthday : " + JSON.stringify(res.kakao_account.birthday));

					var userInfo = res; // 사용자 정보 저장
					sendUserInfoToServlet(userInfo); // 서블릿으로 사용자 정보 전달
					
					$.ajax({
	                    url:"kakaoLogin.do",
	                    data:{"id":res.id, "name":JSON.stringify(res.properties.nickname)},
	                    Type:"post",
	                    success:function(data){
	                        //성공적으로 하고나면 이동할 url
	                    location.href="<%=request.getContextPath()%>";
						}

					});

				},
				fail : function(error) {
					// 사용자 정보 요청 실패 시 처리 로직 작성
					console.log(error); // 실패 정보 확인 예시
				}
			});
		}

		function sendUserInfoToServlet(userInfo) {
			$.ajax({
				type : 'POST',
				url : 'kakaoLogin.do',
				data : userInfo,
				success : function(response) {
					// 서블릿으로 전달 후 처리 로직 작성
					console.log('User info sent to servlet');
				},
				error : function(xhr, status, error) {
					// 전송 실패 시 처리 로직 작성
					console.log(error); // 실패 정보 확인 예시
				}
			});
		}
	</script>



</body>
</html>