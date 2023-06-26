<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HR Bank - 하리인터넷뱅킹</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css" />
<link
	href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700"
	rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="/css/styles.css" rel="stylesheet" />
</head>
<body>
	<%-- 상단고정 --%>
	<jsp:include page="/jsp/main-jsp/topper.jsp"></jsp:include>


	<!-- Page content-->
	<div class="container mt-5">
		<div class="row">
			<div class="col-lg-8">
				<!-- Post content-->
				<article>
					<!-- Post header-->
					<header class="mb-4">
						<!-- Post title-->
						<h1 class="fw-bolder mb-1">Welcome to Blog Post!</h1>
						<!-- Post meta content-->
						<div class="text-muted fst-italic mb-2">Posted on January 1,
							2023 by Start Bootstrap</div>
						<!-- Post categories-->
						<a class="badge bg-secondary text-decoration-none link-light"
							href="#!">Web Design</a> <a
							class="badge bg-secondary text-decoration-none link-light"
							href="#!">Freebies</a>
					</header>
					<!-- Preview image figure-->
					<figure class="mb-4">
						<img class="img-fluid rounded"
							src="https://dummyimage.com/900x400/ced4da/6c757d.jpg" alt="..." />
					</figure>
					<!-- Post content-->
					<section class="mb-5">
						<p class="fs-5 mb-4">Science is an enterprise that should be
							cherished as an activity of the free human mind. Because it
							transforms who we are, how we live, and it gives us an
							understanding of our place in the universe.</p>
						<p class="fs-5 mb-4">The universe is large and old, and the
							ingredients for life as we know it are everywhere, so there's no
							reason to think that Earth would be unique in that regard.
							Whether of not the life became intelligent is a different
							question, and we'll see if we find that.</p>
						<p class="fs-5 mb-4">If you get asteroids about a kilometer in
							size, those are large enough and carry enough energy into our
							system to disrupt transportation, communication, the food chains,
							and that can be a really bad day on Earth.</p>
						<h2 class="fw-bolder mb-4 mt-5">I have odd cosmic thoughts
							every day</h2>
						<p class="fs-5 mb-4">For me, the most fascinating interface is
							Twitter. I have odd cosmic thoughts every day and I realized I
							could hold them to myself or share them with people who might be
							interested.</p>
						<p class="fs-5 mb-4">Venus has a runaway greenhouse effect. I
							kind of want to know what happened there because we're twirling
							knobs here on Earth without knowing the consequences of it. Mars
							once had running water. It's bone dry today. Something bad
							happened there as well.</p>
					</section>
				</article>
				
				
				<%-- 댓글창쪽 --%>
				<!-- Comments section-->
				<section class="mb-5">
					<div class="card bg-light">
						<div class="card-body">
							<!-- Comment form-->
							<form class="mb-4">
								<textarea class="form-control" rows="3"
									placeholder="Join the discussion and leave a comment!"></textarea>
							</form>
							<!-- Comment with nested comments-->
							<div class="d-flex mb-4">
								<!-- Parent comment-->
								<div class="flex-shrink-0">
									<img class="rounded-circle"
										src="https://dummyimage.com/50x50/ced4da/6c757d.jpg" alt="..." />
								</div>
								<div class="ms-3">
									<div class="fw-bold">Commenter Name</div>
									If you're going to lead a space frontier, it has to be
									government; it'll never be private enterprise. Because the
									space frontier is dangerous, and it's expensive, and it has
									unquantified risks.
									<!-- Child comment 1-->
									<div class="d-flex mt-4">
										<div class="flex-shrink-0">
											<img class="rounded-circle"
												src="https://dummyimage.com/50x50/ced4da/6c757d.jpg"
												alt="..." />
										</div>
										<div class="ms-3">
											<div class="fw-bold">Commenter Name</div>
											And under those conditions, you cannot establish a
											capital-market evaluation of that enterprise. You can't get
											investors.
										</div>
									</div>
									<!-- Child comment 2-->
									<div class="d-flex mt-4">
										<div class="flex-shrink-0">
											<img class="rounded-circle"
												src="https://dummyimage.com/50x50/ced4da/6c757d.jpg"
												alt="..." />
										</div>
										<div class="ms-3">
											<div class="fw-bold">Commenter Name</div>
											When you put money directly to a problem, it makes a good
											headline.
										</div>
									</div>
								</div>
							</div>
							<!-- Single comment-->
							<div class="d-flex">
								<div class="flex-shrink-0">
									<img class="rounded-circle"
										src="https://dummyimage.com/50x50/ced4da/6c757d.jpg" alt="..." />
								</div>
								<div class="ms-3">
									<div class="fw-bold">Commenter Name</div>
									When I look at the universe and all the ways the universe wants
									to kill us, I find it hard to reconcile that with statements of
									beneficence.
								</div>
							</div>
						</div>
					</div>
				</section>
			</div>
			<!-- Side widgets-->
			<div class="col-lg-4">
				<%-- 로그인/가입메뉴 --%>
				<div class="card mb-4">
					<div class="card-body">
						<button class="btn btn-primary" id="button-login" type="button">로그인</button>
						<button class="btn btn-primary" id="button-login" type="button">비대면<br>계좌개설</button>
					</div>
				</div>

				<!-- Categories widget-->
				<div class="card mb-4">
					<div class="card-header">공지사항</div>
					<div class="card-body">
						<div class="row">
							<div class="col-sm-6">
								<ul class="list-unstyled mb-0">
									<li><a href="#!">Web Design</a></li>
									<li><a href="#!">HTML</a></li>
									<li><a href="#!">Freebies</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<!-- Side widget-->
				<div class="card mb-4">
					<div class="card-header">자주묻는 질문</div>
					<div class="card-body">You can put anything you want inside
						of these side widgets. They are easy to use, and feature the
						Bootstrap 5 card component!</div>
				</div>
			</div>
		</div>
	</div>
	
	
	
	<%-- 하단고정 --%>
	<jsp:include page="/jsp/main-jsp/footer.jsp"></jsp:include>
	
	
	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>







</body>
</html>