<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>HR Bank - 나의 HR</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

</head>
<style>
table {
	table-layout: auto;
	width: 100%; /* 너비 설정은 선택 사항입니다. 필요에 따라 조정하세요 */
}
</style>

<body>
	<header>
		<%-- 상단고정 --%>
		<jsp:include page="/jsp/main-jsp/topper.jsp"></jsp:include>
	</header>
	<section>



		<div class="container mt-5" align="center">
			<div class="card col-6 pt-2 mb-4">
				<div class="card-header">
					<h2>MY HR</h2>
					<h6>최종접속시각 : ${latestLoginTime}</h6>
				</div>


				<div class="card-body">
					<h5>
						<b>${loginUser.korName}</b>님의 HR등급 <b>[${loginUser.roleName}]</b>
					</h5>
					* 등급혜택 : <b>타행이체시 수수료 면제</b>
				</div>
			</div>
			<form id="myinfo-form" action="update-info.do" method="POST">
				<table class="table table-striped col-8">
					<thead>
						<tr>
							<th>이름</th>
							<th>ID</th>
							<th></th>
							<th>연락처</th>
							<th>이메일</th>
							<th>가입구분</th>
							<th>가입일</th>
							<th></th>
						</tr>
					</thead>
					<%-- 테이블 내용 --%>
					<tbody>
						<tr>
							<td>${loginUser.korName}</td>
							<td>${loginUser.id}</td>
							<td></td>
							<td><input type="text" id="phone" name="phone" class="editable"
								value="${loginUser.phone}" style="width: 130px" disabled></td>
							<td><input type="email" id="email" name="email" class="editable"
								value="${loginUser.email}" disabled></td>
							<td>${loginUser.signupType}</td>
							<td>${loginUser.regDatetime}</td>
							<td>
								<div class="btn-group">
								<input type="hidden" name="id" value="${loginUser.id}">
									<button type="submit" class="btn btn-success" id="edit-btn"
										onclick="enableEdit(event)">수정</button>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>

		<div class="container mt-5" align="center">
			<div>
				<h2>최근 문의내역</h2>
			</div>
			<div class="btn-group mb-3">
				<button type="button" onclick="location.href='write-post.do'"
					class="btn btn-secondary">1:1 문의하기</button>
			</div>
			<div class="row justify-content-center">
				<div class="col-8">
					<table class="table table-hover">
						<thead>
							<tr>
								<th class="col-md-1 narrow-column">번호</th>
								<th class="col-md-4">제목</th>
								<th class="col-md-1 narrow-column">글쓴이</th>
								<th class="col-md-2 narrow-column">작성일</th>
								<th class="col-md-1 narrow-column">조회</th>
							</tr>
						</thead>
						<%-- 테이블 내용 --%>
						<tbody>
							<c:choose>
								<c:when test="${ empty qnaList }">
									<td colspan="5" align="center" style="padding: 50px 0;">
										문의하신 Q&A 내역이 없습니다.</td>
								</c:when>

								<c:otherwise>
									<c:forEach var="qna" items="${qnaList}">
										<tr>
											<td class="qna-no narrow-column">${qna.no}</td>
											<td class="qna-title"><a
												href="qna-details.do?no=${qna.no}">${qna.title}</a></td>
											<td class="qna-writer narrow-column">${qna.writer}</td>
											<td class="qna-regdate narrow-column">${qna.regDate}</td>
											<td class="qna-viewcnt narrow-column">${qna.viewCnt}</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</div>
		</div>









	</section>


	<script>
		
	<%-- 회원정보 수정모드 --%>
		function enableEdit(event) {
			event.preventDefault();

			var phoneInput = document.getElementById('phone');
			var emailInput = document.getElementById('email');
			var editButton = document.getElementById('edit-btn');
			var form = document.getElementById('myinfo-form');

			// 모든 input 요소를 활성화 또는 비활성화
			phoneInput.disabled = !phoneInput.disabled;
			emailInput.disabled = !emailInput.disabled;

			// 수정 버튼의 텍스트 변경
			editButton.innerText = phoneInput.disabled ? '수정' : '저장';
			editButton.onclick = phoneInput.disabled ? function(event) { enableEdit(event); } : function(event) { saveChanges(event); };
		}
		
	<%-- 정보수정 반영 --%>
	function saveChanges(event) {
		event.preventDefault();

		var form = document.getElementById('myinfo-form');
		form.submit();
	}
	</script>




	<footer>
		<%-- 하단고정 --%>
		<jsp:include page="/jsp/main-jsp/footer.jsp"></jsp:include>
	</footer>
</body>
</html>