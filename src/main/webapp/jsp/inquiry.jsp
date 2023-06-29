<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>HR Bank - 계좌조회</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />

<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.5.0/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.5.0/js/bootstrap.bundle.min.js"></script>


<style>
.fixed-table {
	table-layout: fixed;
}

.fixed-table th, .fixed-table td {
	width: auto;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
</style>

</head>

<body>
	<header>
		<%-- 상단고정 --%>
		<jsp:include page="/jsp/main-jsp/topper.jsp"></jsp:include>
	</header>
	<section>

		<div class="container mt-5">
			<div class="text-center mb-4">
				<h2>전체계좌조회</h2>
			</div>
			<div class="row justify-content-center">
				<div class="col-md-10">
					<!-- 					<table class="table table-striped"> -->
					<table class="table table-striped fixed-table">
						<thead class="thead-dark">
							<tr class="text-white bg-secondary table-lg">
								<th style="text-align: center;">입출금(총 ${accountCount} 계좌)</th>
								<th colspan="2">잔액 ${formattedTotalBalance}</th>
								<th colspan="3" style="text-align: right;">조회기준일시 :
									${formattedNow}</th>
							</tr>
							<tr>
								<th style="text-align: center;">은행코드</th>
								<th style="text-align: center;">예금상품명</th>
								<th colspan="2" style="text-align: center; width: 40%;">계좌번호</th>
								<th style="text-align: center; width: 20%;">잔액(원)</th>
								<th style="text-align: center;">업무</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${ empty accountList }">
									<tr>
										<td colspan="5" class="text-center">보유중인 계좌가 없습니다.</td>
									</tr>
									<tr>
										<td colspan="5" class="text-center">
											<form action="create-account.do" method="post">
												<button type="submit" class="btn btn-secondary mt-3">비대면
													계좌개설하기</button>
											</form>
										</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="account" items="${accountList}">
										<tr>
											<td style="text-align: center;">${account.bankName}</td>
											<td style="text-align: center;">${account.productName}</td>
											<td colspan="2" style="text-align: center;">${account.accountNo}
												<button onclick="copyToClipboard('${account.accountNo}')"
													class="btn link-dark btn-sm" data-bs-toggle="modal"
													data-bs-target="#copyModal">
													<i class="fas fa-copy"></i>
												</button>
											</td>
											<td style="text-align: center;">${account.totalBalance}</td>
											<td style="text-align: center;">
												<form action="inquiryDetail.do" method="post"
													style="display: inline-block;">
													<input type="hidden" name="accountNo"
														value="${account.accountNo}"> <input type="hidden"
														name="productCode" value="${account.productCode}">
													<input type="submit" class="btn btn-secondary" value="조회">
												</form>
												<form action="transaction.do" method="post"
													style="display: inline-block;">
													<input type="hidden" name="accountNo"
														value="${account.accountNo}"> <input type="hidden"
														name="productCode" value="${account.productCode}">
													<input type="submit" class="btn btn-secondary" value="이체">
												</form>
											</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</div>
		</div>


<script>
function copyToClipboard(text) {
    navigator.clipboard.writeText(text)
        .then(() => {
            // 모달 표시
            alert('계좌번호가 복사되었습니다. ctrl+v로 붙여넣기 할 수 있습니다.');
        })
        .catch((error) => {
            console.error("계좌번호 복사 실패:", error);
        });
    }
</script>



	</section>
	<footer>
		<%-- 하단고정 --%>
		<jsp:include page="/jsp/main-jsp/footer.jsp"></jsp:include>
	</footer>


</body>
</html>