<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>HR Bank - 문의게시판(Q&A)</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"></script>

</head>
<style>
table {
	width: 100%; /* 너비 설정은 선택 사항입니다. 필요에 따라 조정하세요 */
}

.qna-title {
	width: 50%;
}
</style>

<body>
	<header>
		<%-- 상단고정 --%>
		<jsp:include page="/jsp/main-jsp/topper.jsp"></jsp:include>
	</header>
	<section>

		<div class="container" align="center">
			<div>
				<h2>문의게시판(Q&A)</h2>
			</div>
			<div class="btn-group">

				<form action="write-post.do" method="post">
					<button type="submit" class="btn btn-secondary">문의하기</button>
				</form>
			</div>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>등록일</th>
						<th>조회수</th>
					</tr>
				</thead>
				<%-- 테이블 내용 --%>
				<tbody>
					<c:choose>
						<c:when test="${ empty qnas }">
							<td colspan="5" align="center" class="mt-3 mb-3">등록된 QnA가 없습니다.</td>
						</c:when>
						
						<c:otherwise>
							<c:forEach var="qna" items="${qnas}">
								<tr>
									<td class="qna-no">${qna.no}</td>
									<td class="qna-title"><a
										href="qna-details.do?no=${qna.no}">${qna.title}</a></td>
									<td class="qna-writer">${qna.writer}</td>
									<td class="qna-regdate">${qna.regDate}</td>
									<td class="qna-viewcnt">${qna.viewCnt}</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
	</section>


	<script>
<%-- 버튼 상태변경 --%>
function updateButtons() {
       var buttons = document.getElementsById('btn-rent');
       
       for (var i = 0; i < buttons.length; i++) {
           var status = buttons[i].getAttribute(${book.status});
           
           if (status === '0' ) {
               buttons[i].disabled = false; // 대출 가능일 때 버튼 활성화
           } else {
               buttons[i].disabled = true; // 대출 불가일 때 버튼 비활성화
           }
       }
   }
   // 페이지 로드 시 버튼 업데이트
   window.onload = function() {
       updateButtons();
   };
   
   
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