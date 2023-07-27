<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>HB하리은행 - 자주묻는질문(FAQ)</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>
	<header>
		<%-- 상단고정 --%>
		<jsp:include page="/jsp/main-jsp/topper.jsp"></jsp:include>
	</header>
	<section id="faq" class="faq">
		<div class="container" data-aos="fade-up">
			<div class="row gy-4">
				<div class="col-12 col-lg-4 mb-3">
					<div class="content px-xl-5">
						<br> <br> <br>
						<h3>메뉴</h3>
						<ul class="nav flex-column">
							<li class="nav-item"><a class="nav-link active" href="#">공지사항</a></li>
							<li class="nav-item"><a class="nav-link" href="#">FAQ</a></li>
							<li class="nav-item"><a class="nav-link" href="#">QNA</a></li>
						</ul>
					</div>
				</div>
				<div class="col-12 col-lg-8 mb-3">
					<div class="content px-xl-5">
						<br> <br> <br>
						<h3>
							자주하는 질문 <strong>FAQ</strong>
						</h3>
						<p>찾으시는 내용이 없다면 Q&A 게시판을 이용해주세요.</p>
						<!--없으면 질문하기 버튼 누르게하기-->
						<div id="hero2" class="hero2">
							<div
								class="d-flex justify-content-center justify-content-lg-start">
								<a href="#" class="btn-get-started"> 문의하기</a>
							</div>
						</div>
					</div>
					<div class="col-lg-8">
						<br> <br> <br>
						<div class="accordion accordion-flush" id="faqlist"
							data-aos="fade-up" data-aos-delay="100">

							<div class="accordion-item">
								<h3 class="accordion-header">

									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#faq-content-1">
										<span class="num">1.</span> 웹 회원가입과 카카오 회원가입은 어떻게 달라요?
									</button>
								</h3>
								<div id="faq-content-1" class="accordion-collapse collapse"
									data-bs-parent="#faqlist">
									<div class="accordion-body">웹 회원은 아이디와 비밀번호로, <strong>카카오 회원</strong>은 카카오 계정연동을 통해 클릭 한번으로 접속 가능합니다.</div>
								</div>
							</div>

							<!-- # Faq item-->
							<div class="accordion-item">
								<h3 class="accordion-header">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#faq-content-2">
										<span class="num">2.</span> 비밀번호 수정은 어디에서 하나요?
									</button>
								</h3>
								<div id="faq-content-2" class="accordion-collapse collapse"
									data-bs-parent="#faqlist">
									<div class="accordion-body">[마이페이지] - [회원정보수정] 에서 수정하실 수
										있습니다.</div>
								</div>
							</div>
							<!-- # Faq item-->
							<div class="accordion-item">
								<h3 class="accordion-header">
									<button class="accordion-button collapsed" type="button"
										data-bs-toggle="collapse" data-bs-target="#faq-content-3">
										<span class="num">3.</span> 질문
									</button>
								</h3>
								<div id="faq-content-3" class="accordion-collapse collapse"
									data-bs-parent="#faqlist">
									<div class="accordion-body">3번째 내용</div>
								</div>
							</div>
							<!-- # Faq item-->

						</div>
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