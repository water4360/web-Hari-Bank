<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>HB하리은행 - 문의게시판(Q&A)</title>

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
	<section>

		<div class="container mt-5" align="center">
			<div>
				<h2>문의게시판(Q&A)</h2>
			</div>
			<div class="btn-group">
			
			
				<c:if test="${not empty loginUser}">
				<form action="write-post.do" method="post">
					<button type="submit" class="btn btn-secondary">문의하기</button>
				</form>
				</c:if>
			</div>
			<div class="row justify-content-center">
				<div class="col-md-11">
					<table class="table table-hover">
						<thead>
							<tr>
								<th class="col-md-1 narrow-column">번호</th>
								<th class="col-md-6">제목</th>
								<th class="col-md-1 narrow-column">글쓴이</th>
								<th class="col-md-1 narrow-column">작성일</th>
								<th class="col-md-1 narrow-column">조회</th>
							</tr>
						</thead>
						<%-- 테이블 내용 --%>
						<tbody>
							<c:choose>
								<c:when test="${ empty qnas }">
									<td colspan="5" align="center" style="padding: 50px 0;">등록된 Q&A가
										없습니다.</td>
								</c:when>

								<c:otherwise>
									<c:forEach var="qna" items="${qnas}">
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
  }
  
</script>




	<footer>
		<%-- 하단고정 --%>
		<jsp:include page="/jsp/main-jsp/footer.jsp"></jsp:include>
	</footer>
</body>
</html>