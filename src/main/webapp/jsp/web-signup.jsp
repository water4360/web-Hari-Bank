<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>HR Bank - 웹 회원가입</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
          integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N"
          crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct"
            crossorigin="anonymous"></script>
    <style>
        /* 화살표 메뉴 숨기기 */
        input[type="number"]::-webkit-inner-spin-button,
        input[type="number"]::-webkit-outer-spin-button {
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
    <h3 class="text-center">회원가입</h3>

    <div class="row mt-3">
        <div class="col-lg-6 mx-auto">
            <form method="post" action="signupProcess.do" name="joinForm" class="needs-validation" novalidate>
                <div class="form-group">
                    <label for="id">아이디</label>
                    <input type="text" class="form-control" id="id" name="id" autocorrect="off"
                           autocapitalize="none" placeholder="4~20자 영문, 숫자 입력" value=""
                           pattern="[a-zA-Z0-9]{4,20}" required>
                    <div class="invalid-feedback">아이디를 입력해주세요.</div>
                    <div class="valid-feedback">사용 가능한 아이디입니다.</div>
                </div>

                <div class="form-group">
                    <label for="pw">비밀번호</label>
                    <input type="password" class="form-control" id="pw" name="pw"
                           placeholder="4~12자 영문+숫자+특수문자" value="" required>
                    <div class="invalid-feedback">비밀번호를 입력해주세요.</div>
                </div>

                <div class="form-group">
                    <label for="pw2">비밀번호 확인</label>
                    <input type="password" class="form-control" id="pw2" name="pw2" placeholder="비밀번호 재입력"
                           value="" onkeyup="checkPw()" required>
                    <div class="invalid-feedback">비밀번호가 일치하지 않아요.</div>
                </div>

                <div class="form-group">
                    <label for="name">한글이름</label>
                    <input type="text" class="form-control" id="name" name="name" placeholder="한글이름 입력"
                           value="" pattern="[가-힣]{2,20}" required>
                    <div class="invalid-feedback">이름을 입력해주세요.</div>
                </div>

                <div class="form-group">
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
                    <div class="invalid-feedback">생년월일을 입력해주세요.</div>
                </div>

                <div class="form-group">
                    <label for="phone">연락처</label>
                    <div class="row">
                        <div class="col-3 pr-0">
                            <select id="telecom" name="telecom" class="form-control">
                                <option selected disabled>통신사 선택</option>
                                <option value="SKT">SK</option>
                                <option value="KT">KT</option>
                                <option value="LGU">LGU+</option>
                                <option value="알뜰폰">알뜰폰</option>
                            </select>
                        </div>
                        <div class="col-9 pl-0">
                            <input type="number" class="form-control" name="phone"
                                   placeholder="예) 01023456789" value="" maxlength="11"
                                   pattern="[0-9]{10,11}" required>
                        </div>
                    </div>
                    <div class="invalid-feedback">연락처 형식이 올바르지 않아요.</div>
                </div>

                <div class="form-group">
                    <label for="email">이메일</label>
                    <input type="email" class="form-control" id="email" name="email"
                           placeholder="예) soob@library.com" required>
                    <div class="invalid-feedback">이메일 주소가 올바르지 않아요.</div>
                </div>

                <div class="form-group">
                    <button class="btn btn-success btn-lg" type="submit" id="signup-btn">회원가입 후 계좌개설</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
	//아이디 중복체크
	$(function() {
        // 아이디 중복 체크
        $("#id").on("keyup", function() {
            checkIdAvailability();
        });

        function checkIdAvailability() {
            let id = $("#id").val();
            let errorElement = $("#invalid-feedback");
            let successElement = $("#valid-feedback");

            if (id === "") {
                errorElement.html("");
                successElement.html("");
                return;
            }

            $.ajax({
                type: "POST",
                url: "./jsp/check-jsp/checkId.jsp",
                data: {
                    "id": id
                },
                dataType: "html",
                async: true,
                success: function(data) {
                    if (data.trim() === "true") {
                        errorElement.html("❌이미 존재하는 아이디예요");
                        successElement.html("");
                    } else {
                        if (id.length < 4) {
                            errorElement.html("❌아이디가 너무 짧아요");
                            successElement.html("");
                        } else {
                            errorElement.html("");
                            successElement.html("✔사용 가능한 아이디예요");
                        }
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Ajax 요청 실패!");
                    console.error("HTTP 상태 코드: " + xhr.status);
                    console.error("에러 메시지: " + error);
                }
            });
        }
    });

    // 폼 유효성 검사
    window.addEventListener('load', () => {
        const forms = document.getElementsByClassName('needs-validation');

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
    
    $(function() {
        $("#pw2").on("keyup", function() {
            checkPw();
        });
    });

    
    
    
</script>

<footer>
    <%-- 하단고정 --%>
    <jsp:include page="/jsp/main-jsp/footer.jsp"></jsp:include>
</footer>
</body>
</html>
