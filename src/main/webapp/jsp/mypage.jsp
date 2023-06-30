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
				<div class="card-body">
					<h5><b>${loginUser.korName}</b>님의
						HR등급 <b>[${loginUser.roleName}]</b>
					</h5>
					* 등급혜택 : <b>타행이체시 수수료 면제</b>
				</div>
			</div>
			<form action="update-info.do">
				<table class="table table-striped col-8">
					<thead>
						<tr>
							<th scope="col">이름</th>
							<th scope="col">ID</th>
							<th scope="col">PW</th>
							<th scope="col">연락처</th>
							<th scope="col">이메일</th>
							<th scope="col">가입일</th>
							<th scope="col"></th>
						</tr>
					</thead>
					<%-- 테이블 내용 --%>
					<tbody>
						<tr>
							<td class="name">${loginUser.korName}</td>
							<td class="id">${loginUser.id}</td>
							<td class="pw"><input type="password" id="pw"
								class="editable" value="${loginUser.pw}" style="width: 60px"
								disabled></td>
							<td class="phone"><input type="text" id="phone"
								class="editable" value="${loginUser.phone}" style="width: 110px"
								disabled></td>
							<td class="email"><input type="email" id="email"
								class="editable" value="${loginUser.email}" disabled></td>
							<td class="regDatetime">${loginUser.regDatetime}</td>
							<td>
								<div class="btn-group">
									<button type="button" class="btn btn-success" id="edit-btn"
										onclick="enableEdit()">수정</button>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="col">생년월일</th>
							<th scope="col">가입구분</th>
							<th scope="col">자택주소</th>
							<th scope="col"></th>
							<th scope="col"></th>
							<th scope="col"></th>
							<th scope="col"></th>
						</tr>
						<tr>
							<td class="name">${loginUser.birthdate}</td>
							<td class="id">${loginUser.signupType}</td>
							<td class="pw"><input type="text" id="pw"
								class="editable" value="${userAddr.postcode}" style="width: 60px"
								disabled></td>
							<td class="phone" colspan="2"><input type="text" id="phone"
								class="editable" value="${userAddr.roadAddress}" style="width: 250px"
								disabled></td>
							<td class="email"><input type="email" id="email"
								class="editable" value="${userAddr.detailAddress}" disabled></td>
							<td>
								<div class="btn-group">
									<button type="button" class="btn btn-success" id="edit-btn"
										onclick="enableEdit()">수정</button>
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
 function enableEdit() {
     var inputs = document.getElementsByClassName('editable');
     var editButton = document.getElementById('edit-btn');

     // 모든 input 요소를 활성화 또는 비활성화
     for (var i = 0; i < inputs.length; i++) {
         inputs[i].disabled = !inputs[i].disabled;
     }

     // 수정 버튼의 텍스트 변경
     editButton.innerText = inputs[0].disabled ? '수정' : '저장';
     editButton.onclick = saveChanges;
 }
 
 <%-- 정보수정 반영 --%>
  function saveChanges() {
      var pwInput = document.getElementById('pw');
      var phoneInput = document.getElementById('phone');
      var emailInput = document.getElementById('email');
      var editButton = document.getElementById('edit-btn');
      
      // 수정된 정보를 서버로 전송하는 로직 추가
      
      
      // 저장 버튼을 수정 버튼으로 변경
      editButton.innerText = '수정';
      editButton.onclick = enableEdit;
      
// 입력 필드 비활성화
phoneInput.disabled = true;
emailInput.disabled = true;
  }
  
</script>




	<footer>
		<%-- 하단고정 --%>
		<jsp:include page="/jsp/main-jsp/footer.jsp"></jsp:include>
	</footer>
</body>
</html>