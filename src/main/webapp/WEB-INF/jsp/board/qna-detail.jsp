<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HB하리은행 - 스프링QNA 상세(Q&A)</title>
<style>
table {
	table-layout: auto;
	width: 60%;
}

.card-body {
	min-height: 200px;
}
</style>

<%-- 스크립트는 항상 스타일, CSS 아래에! --%>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"></script>

<script>

	//댓글리스트 조회(게시판번호)
	let getCommentList = function() {
		$.ajax({
			url: '${pageContext.request.contextPath}/comment/${post.no}',
			type: 'GET',
			success: function(result) {
// 				alert('댓글 불러오기 성공!')
// 				let list = JSON.parse(result)
				$('#commentList').empty()
				
				$(result).each(function() {
 					console.log(this)
				
					let str = ''
					str += '<hr>'
					str += '<div>'
					str += '<strong>'+this.content+'</strong>'
					str += '('+this.writer+')    '
					str += this.regDate
					str += '<button type="button">삭제</button>'
					str += '</div>'
					
					$('#commentList').append(str)

				})
				
			}, error: function() {
				alert('댓글 불러오기 실패..')
			}
		})
	}

		
		
		$(document).ready(function() {
			getCommentList()
		})
		
		
	<%--
		1번방법. 바디가 다 로드되고 나면. 
	 	window.onload = function() {
	 	}
 	--%>
	<%-- 2번방법. 바디가 다 로드되고 나면. --%>
	$(document).ready(function() {
		$('#commentAddBtn').click(function() {
			let content = document.commentForm.content.value
			let writer = document.commentForm.writer.value
			
			console.log(writer, content)
			$.ajax({
				url: '${pageContext.request.contextPath}/comment',
				type: 'POST',
				data: {
					content : content,
					writer : writer,
					boardNo : ${post.no}
				}, success : function() {
// 					alert('댓글등록 성공!')
					document.commentForm.content.value=''
					document.commentForm.writer.value=''
					getCommentList()
					
				}, error : function() {
					alert('댓글등록 실패! 다시 시도하세요.')
				}
			})
		})
	})
	


	
</script>
</head>
<body>
	<header>
		<%-- 상단고정 --%>
		<jsp:include page="/jsp/main-jsp/topper.jsp"></jsp:include>
	</header>
	<section>
		<div class="container mt-5">
			<div class="row justify-content-center">
				<div class="col-md-6">
					<div class="btn-group" role="group">
						<%-- 작성자일때, 관리자일때, 방문자일때 --%>
						<c:choose>
							<c:when test="${post.writer == loginUser.id}">
								<a href="modifyPost.do?no=${post.no}"
									class="btn btn-secondary mb-2">수정</a>
								<a href="deletePost.do?no=${post.no}"
									class="btn btn-secondary mb-2">삭제</a>
							</c:when>
							<c:when test="${loginUser.role == 'A758'}">
								<a
									href="${pageContext.request.contextPath }/board/delete/${post.no}"
									class="btn btn-secondary mb-2">삭제</a>
							</c:when>
						</c:choose>
						<a href="${pageContext.request.contextPath }/board"
							class="btn btn-secondary mb-2">목록으로</a>


					</div>
					<div class="card mb-3">
						<div class="card-header align-items-start justify-content-between">
							<div class="d-flex flex-column">
								<h4>${post.title}</h4>
							</div>
						</div>
						<div class="card-body">
							<!-- text-end 클래스를 사용하여 내용을 우측으로 정렬합니다. -->
							<span class="text-start mb-2"
								style="text-align: right; font-size: 15px; color: grey;">작성자:
								${post.writer} | 등록일: ${post.regDate} | 조회수: ${post.viewCnt}</span>
							<p class="card-text">${post.content}</p>
						</div>
						<div class="card-footer text-muted" style="text-align: left;">
							<div class="comment-container">
								<div id="commentCnt">댓글(${post.commentCnt}개)</div>
								<div id="commentList">
									<c:if test="${ empty comment }">등록된 댓글이 없습니다.</c:if>
								</div>
								<form name="commentForm">
									<div class="card">
										<div class="ml-2 comment_inbox">
											<div>
												<b class="comment_inbox_writer">${loginUser.id}</b>
												<input type="hidden" name="writer" value="${loginUser.id}"/>
											</div>
											<div>
												<textarea name="content"
													<c:if test="${not empty loginUser.id}">
												placeholder="댓글을 남겨보세요"
												</c:if>
													<c:if test="${empty loginUser.id}">
												placeholder="로그인 후 이용해주세요"
												readonly = true
												</c:if>
													rows="1" class="comment_inbox_text"
													style="border: none; outline: none; overflow: hidden; overflow-wrap: break-word; width: 550px; height: 80px;"></textarea>
											</div>
										</div>
										<div class="register_box" style="text-align: right;">
											<c:if test="${not empty loginUser.id}">
												<a href="#" type="button" id="commentAddBtn">등록</a>
											</c:if>
										</div>
									</div>
								</form>
							</div>
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