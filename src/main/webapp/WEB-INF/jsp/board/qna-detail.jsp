<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HB하리은행 - 문의게시판(Q&A)</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css">

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

<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js"></script>



<script>

//댓글리스트 조회
let getReplyList = function() {
	$.ajax({
		url : '${pageContext.request.contextPath}/reply/${post.no}',
		type : 'GET',
		success : function(result) {
// 			alert('댓글 불러오기 성공!')
			
			//자꾸자꾸 덧붙이지 않게.
			$('#replyList').empty()
			
			$(result).each(function() {
				console.log(this)
				
				let str = '<hr><div>'
				str += '<div><b>'+this.writer+'</b></div>'
				str += '<div style="font-size:10px">'+this.regDate+'</div>'
				str += this.content
				str += '<a type="button" class="btn">수정</a>'
				str += '<a type="button" class="btn">삭제</a>'
				str += '</div>'
				
				$('#replyList').append(str)
			})
			
		}, error : function() {
			alert('댓글 불러오기 실패')
		}
	})
}

$(document).ready(function() {
	getReplyList()
})

//모든 body 다 불러오면, 댓글 등록
$(document).ready(function() {
	$('#replyAddBtn').click(function() {
		let content = document.replyForm.content.value
		let writer = document.replyForm.writer.value
		
		$.ajax({
			url : '${pageContext.request.contextPath}/reply',
			type : 'POST',
			data : {
				writer : writer,
				content : content,
				boardNo : ${post.no}
			}, success : function() {
// 				alert('댓글등록 성공!')
				document.replyForm.content.value=''
				getReplyList()
			}, error : function() {
				alert('댓글등록 실패! 이유가 몰까나?')
				console.log(writer)
				console.log(content)
			}
		})
	})
})


</script>



</head>
<body>
	<header>
		<%-- 상단고정 --%>
		<jsp:include page="/jsp/include/topper.jsp"></jsp:include>
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
								<a href="deletePost.do?no=${post.no}"
									class="btn btn-secondary mb-2">삭제</a>
							</c:when>
						</c:choose>
						<a href="${pageContext.request.contextPath }/qna"
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
							<p class="card-text">${post.contents}</p>
						</div>
						<div class="card-footer text-muted" style="text-align: left;">
							<div class="reply-container">
								<b>댓글</b>
								<div id="replyList">
									<c:if test="${ empty reply }">
										등록된 댓글이 없습니다.
									</c:if>
								</div>
								<form name="replyForm">
									<div class="card">
										<div class="mt-2 mb-2">
											<b class="ml-2 reply_inbox_writer">${loginUser.id}</b>
											<input type="hidden" name="writer" value="${loginUser.id}"/>
										</div>
										<div class="ml-2 comment_inbox"
											style="display: flex; justify-content: space-between;">
											<div style="flex: 1;">
												<textarea name="content" rows="1" class="comment_inbox_text"
													style="border: none; outline: none; overflow: hidden; overflow-wrap: break-word; width: 100%; height: 100%; resize: none;"
													<c:if test="${empty loginUser}">
										              readonly="readonly" placeholder="로그인 후 이용할 수 있습니다."
										          </c:if>
													<c:if test="${not empty loginUser}">
										              placeholder="댓글을 등록해보세요"
										          </c:if>></textarea>

											</div>
											<div class="register_box" style="text-align: right;">
												<c:if test="${not empty loginUser}">
													<a href="#" type="button" class="btn btn-basic" id="replyAddBtn">등록</a>
												</c:if>
											</div>
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
		<jsp:include page="/jsp/include/footer.jsp"></jsp:include>
	</footer>
</body>
</html>
