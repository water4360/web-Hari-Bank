<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
	alert('안전하게 로그아웃되었습니다.')
	<%-- location.href="/SoobLib" --%>
	location.href="${ pageContext.request.contextPath }"
</script>