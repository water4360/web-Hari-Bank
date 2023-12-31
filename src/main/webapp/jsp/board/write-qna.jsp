<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HB하리은행 - 문의게시판(Q&A)</title>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>

<style>
table {
    table-layout: auto;
    width: 80%;
}
</style>

</head>
<body>
    <header>
        <%-- 상단고정 --%>
        <jsp:include page="/jsp/main-jsp/topper.jsp"></jsp:include>
    </header>
    <section>
        <div class="container col-5 mt-5">
            <div class="text-center">
                <h2>문의글 작성</h2>
            </div>
            <form action="insert-new-post.do" method="post">
            <input type="hidden" name="writer" value="${loginUser.id}">
            <input type="hidden" name="category" value="QNA">
                <div class="mb-3">
                    <input type="text" class="form-control" name="title" placeholder="제목을 입력해 주세요.">
                </div>
                <div class="mb-3">
                    <textarea class="form-control" name="contents" rows="10" placeholder="내용을 입력하세요."></textarea>
                </div>
                <div class="mb-3 justify-content-center">
                    <button type="submit" class="btn mr-2 btn-basic">글등록</button>
                    <a href="${pageContext.request.contextPath }/qna.do" class="btn btn-secondary">목록으로</a>
                    <a href="${pageContext.request.contextPath }/mypage.do" class="btn btn-secondary">이전으로</a>
                </div>
            </form>
        </div>
    </section>
    <footer>
        <%-- 하단고정 --%>
        <jsp:include page="/jsp/main-jsp/footer.jsp"></jsp:include>
    </footer>
</body>
</html>
