<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 부트스트랩 -->
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<style>
	
	
</style>

<%-- 스크립트는 항상 스타일, CSS 아래에! --%>	
<script src="http://code.jquery.com/jquery-3.7.0.min.js"></script>
<script>

	//댓글리스트 조회(게시판번호)
	let getReplyList = function() {
		$.ajax({
			url: '${pageContext.request.contextPath}/reply/${board.no}',
			type: 'GET',
			success: function(result) {
// 				alert('댓글 불러오기 성공!')
// 				let list = JSON.parse(result)
				$('#replyList').empty()
				
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
					
					$('#replyList').append(str)

				})
				
			}, error: function() {
				alert('댓글 불러오기 실패..')
			}
		})
	}

		
		
		$(document).ready(function() {
			getReplyList()
		})
		
		
	<%--
		1번방법. 바디가 다 로드되고 나면. 
	 	window.onload = function() {
	 	}
 	--%>
	<%-- 2번방법. 바디가 다 로드되고 나면. --%>
	$(document).ready(function() {
		$('#replyAddBtn').click(function() {
			let content = document.rform.content.value
			let writer = document.rform.writer.value
			
// 			console.log(writer, content)
			$.ajax({
				url: '${pageContext.request.contextPath}/reply',
				type: 'POST',
				data: {
					content : content,
					writer : writer,
					boardNo : ${board.no}
				}, success : function() {
// 					alert('댓글등록 성공!')
					document.rform.content.value=''
					document.rform.writer.value=''
					getReplyList()
					
				}, error : function() {
					alert('댓글등록 실패! 다시 시도하세요.')
				}
			})
		})
	})
	


	
</script>
</head>
<body>
<div class="container mt-5">
    <h2>게시글 상세</h2>
    <div class="row" style="background-color: #f0f0f0;">
        <div class="col-md-3 py-2  font-weight-bold">작성자명</div>
        <div class="col-md-9 py-2">${board.writer}</div>
    </div>
    <div class="row" style="background-color: #f9f9f9;">
        <div class="col-md-3 py-2  font-weight-bold">조회수</div>
        <div class="col-md-9 py-2">${board.viewCnt}</div>
    </div>
    <div class="row" style="background-color: #f0f0f0;">
        <div class="col-md-3 py-2  font-weight-bold">등록일</div>
        <div class="col-md-9 py-2">${board.regDate}</div>
    </div>
    <div class="row" style="background-color: #f9f9f9;">
        <div class="col-md-3 py-2  font-weight-bold">내용</div>
        <div class="col-md-9 py-2">${board.content}</div>
    </div>
    <hr>
    <button onclick="location.href='${pageContext.request.contextPath}/board'">목록</button>
    <button onclick="">수정</button>
    <button onclick="">삭제</button>
    <hr>
    <%-- 댓글관련 --%>
    <form name="rform">
    	<input type="text" name="writer" placeholder="작성자명" size="10"/>
    	<input type="text" name="content" placeholder="댓글을 입력해주세요" size="50"/>
    	<button type="button" id="replyAddBtn">등록</button>
		<div id="replyList">
			<c:if test="${ empty reply }">
				등록된 댓글이 없습니다.
			</c:if>
		</div>
		</form>
	</div> 
</body>
</html>