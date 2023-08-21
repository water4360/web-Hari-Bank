<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>하리은행 - 스프링QNA 답글작성</title>
<style>
	.error {
		font-size:0.6em;
		color: red;
	}

</style>


</head>
<body>
	<h2>게시글 등록폼</h2>

	<%-- POST방식이고 보낼 action과 URL 똑같을때는 action 안 붙여도 같은 걸로 인식 됨.
	<form action="${pageContext.request.contextPath}/board/write" method="post">
	<form method="post"> 이렇게만 쓸 수도 있음 --%>

	<%-- 스프링의 form태그. 아까 등록한 model.addAttribute로 등록한 객체명을 적어줌. --%>
	<form:form method="post" modelAttribute="origin">
		<table>
			<tr>
				<th>제목</th>
				<td>
					<form:input path="title"/><form:errors path="title" class="error"/>
				</td>
			</tr>
			<tr>
				<th>글쓴이</th>
				<td>
					<input type="hidden" name="writer" value="${ loginUser.id }"/>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<form:textarea path="content" rows="5" cols="30"/>
				</td>
			</tr>
		</table>
		<button type="submit">등 록</button>
	</form:form>
</body>
</html>